include ../makeenv
LABEL?=~dev
FAKEROOT=$(DATAROOT)/$(PACKAGE)-$(VERSION)
DOCDIR=$(FAKEROOT)/usr/share/doc/$(PACKAGE)
SHAREDIR=$(FAKEROOT)/usr/share/$(PACKAGE)
BINDIR=$(FAKEROOT)$(DSTSDIR)
SPECFILE=dnsclient-dotnet.spec

RPM=RPMS/x86_64/$(PACKAGE)-$(VERSION)-$(LABEL).x86_64.rpm

TARBALL=$(PACKAGE)-$(VERSION).tgz

RPM: $(TARBALL)
	rpmbuild -v -bb --clean --define "_topdir $(realpath .)" SPECS/$(SPECFILE)

$(TARBALL): rpm_prepare install-deps $(DOCDIR)/ChangeLog
	find $(FAKEROOT) -type d | xargs chmod 0755
	find $(FAKEROOT) -type d | xargs chmod ug-s
	cd $(DATAROOT) && tar -czf ../SOURCES/$@ *

$(DOCDIR):
	mkdir -p $@

$(DOCDIR)/ChangeLog: ../changelog $(DOCDIR)
	cp $< $@

rpm_prepare:
	mkdir -p SOURCES SPECS BUILD BUILDROOT RPMS SRPMS
	cp $(SPECFILE) SPECS
	sed -i '/^Name:/c Name: $(PACKAGE)' SPECS/$(SPECFILE)
	sed -i '/^Version:/c Version: $(VERSION)' SPECS/$(SPECFILE)
	sed -i '/^Release:/c Release: $(LABEL)' SPECS/$(SPECFILE)
	sed -i -e '/^POST-INSTALL/{r ../postinst' -e 'd}' SPECS/$(SPECFILE)

.PHONY: clean install-clean install-deps

clean: install-clean
	-rm -rf SOURCES SPECS BUILD BUILDROOT RPMS SRPMS

install-clean:
	-rm -rf $(DATAROOT)

install-deps: install-clean
	mkdir -p $(BINDIR)
	install -m 644 $(SRCDIR)/DnsClient.dll $(BINDIR)

