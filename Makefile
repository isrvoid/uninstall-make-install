DFLAGS_UNITTEST := -unittest
DFLAGS_RELEASE := -O -release

ifeq ($(RELEASE), 1)
	DFLAGS := $(DFLAGS_RELEASE)
else
	DFLAGS := $(DFLAGS_UNITTEST)
endif

BUILDDIR := build

$(BUILDDIR)/umi: app.d
	@dmd $(DFLAGS) $^ -of$@

clean:
	-@$(RM) $(wildcard $(BUILDDIR)/*)

.PHONY: clean
