DFLAGS_UNITTEST := -unittest
DFLAGS_DEBUG := -debug
DFLAGS_RELEASE := -O -release

ifeq ($(DEBUG),1)
	DFLAGS := $(DFLAGS_DEBUG)
else

ifeq ($(RELEASE), 1)
	DFLAGS := $(DFLAGS_RELEASE)
else
	DFLAGS := $(DFLAGS_UNITTEST)
endif
endif

BUILDDIR := build

$(BUILDDIR)/umi: app.d
	@dmd $(DFLAGS) $^ -of$@

clean:
	-@$(RM) $(wildcard $(BUILDDIR)/*)

.PHONY: clean
