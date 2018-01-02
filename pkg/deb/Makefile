include ../makeenv
LABEL?=~dev
PKGVER=$(VERSION)-$(LABEL)
DOCDIR=$(DATAROOT)/usr/share/doc/$(PACKAGE)/
LINTIANOVERRIDES=$(DATAROOT)/usr/share/lintian/overrides/$(PACKAGE)
DEB=$(PACKAGE)_$(PKGVER)_amd64.deb
BINDIR=$(DATAROOT)$(DSTSDIR)

package: $(DEB)

signed-package: _gpgorigin $(DEB)
	ar r $(DEB) $<

_gpgorigin: $(DEB)
	-rm -f $@
	ar p $(DEB) debian-binary control.tar.gz data.tar.gz | gpg -abs -o _gpgorigin

$(DEB): tarballs debian-binary
	-rm -f $@
	ar rc $@ debian-binary control.tar.gz data.tar.gz
	lintian $@

$(DOCDIR):
	mkdir -p $@

$(DOCDIR)/changelog.Debian.gz: ../changelog $(DOCDIR)
	cat $< | sed 's/PACKAGENAME/$(PACKAGE)/g' | sed 's/VERSION/$(PKGVER)/g' | gzip -9n > $@

$(DOCDIR)/copyright: ../copyright $(DOCDIR)
	cp $< $@

$(LINTIANOVERRIDES): lintian-overrides
	mkdir -p $(@D)
	cat $< | sed "s/PACKAGE/$(PACKAGE)/g" >$@
	
debian-binary:
	echo 2.0 > debian-binary

tarballs: data.tar.gz control.tar.gz

control.tar.gz: md5sums control
	-rm -rf control-root
	-mkdir -p control-root	
	cp control md5sums control-root
	chmod 644 control-root/*
	sed -i '/^Version:/c Version: $(PKGVER)' control-root/control
	sed -i '/^Package:/c Package: $(PACKAGE)' control-root/control
	cd control-root && tar -czf ../$@ --owner=root --group=root .

md5sums: install-deps
	(cd $(DATAROOT) && md5sum `find -type f`) > $@
	chmod 0644 $@

data.tar.gz: install-deps \
             $(DOCDIR)/changelog.Debian.gz \
             $(DOCDIR)/copyright \
			 $(LINTIANOVERRIDES)
	find $(DATAROOT) -type d | xargs chmod 0755
	find $(DATAROOT) -type d | xargs chmod ug-s
	find $(DATAROOT)/usr/share/doc -type f | xargs chmod 0644
	cd $(DATAROOT) && tar -czf ../$@ --owner=root --group=root --mode=go-w *

.PHONY: clean install-clean install-deps

clean: install-clean
	-rm -rf control-root
	-rm -f debian-binary *.tar.gz _gpgorigin md5sums
	-rm -f *.deb

install-clean:
	-rm -rf $(DATAROOT)

install-deps: install-clean	
	mkdir -p $(BINDIR)
	install -m 644 $(SRCDIR)/DnsClient.dll $(BINDIR)
