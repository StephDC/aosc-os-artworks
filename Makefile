# Basic list of files to be generated/converted.
RATIOS = 32 43 169 219
IMAGES_32 = 32/Day 32/Day-Plain 32/Night 32/Night-Plain
IMAGES_43 = 43/Day 43/Day-Plain 43/Night 43/Night-Plain
IMAGES_169 = 169/Day 169/Day-Plain 169/Night 169/Night-Plain
IMAGES_219 = 219/Day 219/Day-Plain 219/Night 219/Night-Plain 
IMAGES = ${IMAGES_32} ${IMAGES_43} ${IMAGES_169} ${IMAGES_219}
XMLS = data/core4-plain-timed \
       data/core4-timed \
       data/core4 \
       data/core4-plain \
       data/core4-wallpapers

# Command definitions.
CD = cd
FIND = find
SED = sed
RM = rm -fv
CP = cp -v
MKDIR = mkdir -pv
LN = ln -sv
DESTDIR =
DATAROOTDIR = /usr/share

# Version definitions.
CORE = 4.0.0
REL = 4.0
ARCH = x86_64
DATE = 20160916

# Dimension definitions.
H32 = 3000
W32 = 4500
H43 = 3000
W43 = 4000
H169 = 2880
W169 = 5120
H219 = 2880
W219 = 6880

all : png xmlgen screenshot

$(IMAGES:=-gen.svg) : ${IMAGES:=.svg}
	sed	-e "s|>REL<|>$(REL)<|g" \
		-e "s|ARCHIT|$(ARCH)|g" \
		-e "s|RV|$(REL)|g" \
		-e "s|REL_DATE|$(DATE)|g" \
		-e "s|COREV|$(CORE)|g" \
		"$(subst -gen.svg,.svg,$@)" > "$@"

$(IMAGES_32:=-$(W32)x$(H32).png) : $(IMAGES_32:=-gen.svg)
	inkscape -h $(H32) -w $(W32) -e $@ $(subst -$(W32)x$(H32).png,-gen.svg,$@)

$(IMAGES_43:=-$(W43)x$(H43).png) : $(IMAGES_43:=-gen.svg)
	inkscape -h $(H43) -w $(W43) -e $@ $(subst -$(W43)x$(H43).png,-gen.svg,$@)

$(IMAGES_169:=-$(W169)x$(H169).png) : $(IMAGES_169:=-gen.svg)
	inkscape -h $(H169) -w $(W169) -e $@ $(subst -$(W169)x$(H169).png,-gen.svg,$@)

$(IMAGES_219:=-$(W219)x$(H219).png) : $(IMAGES_219:=-gen.svg)
	inkscape -h $(H219) -w $(W219) -e $@ $(subst -$(W219)x$(H219).png,-gen.svg,$@)

png : $(IMAGES_32:=-$(W32)x$(H32).png) \
      $(IMAGES_43:=-$(W43)x$(H43).png) \
      $(IMAGES_169:=-$(W169)x$(H169).png) \
      $(IMAGES_219:=-$(W219)x$(H219).png)

$(XMLS:=.xml) : ${XMLS:=.xml.in}
	sed	-e "s|@datadir@|$(DATAROOTDIR)|g" \
		-e "s|@COREVER@|$(REL)|g" \
		"$(subst .xml,.xml.in,$@)" > "$@"

xmlgen : $(XMLS:=.xml)

$(IMAGES_169:=-screenshot.png) : $(IMAGES:=-gen.svg)
	inkscape -h 250 -w 400 -e $@ $(subst -screenshot.png,-gen.svg,$@)

screenshot : $(IMAGES_169:=-screenshot.png)

clean :
	$(FIND) . -name '*gen*.svg' -exec $(RM) {} \;
	$(FIND) . -name '*.png' -exec $(RM) {} \;
	$(FIND) . -name '*.xml' -exec $(RM) {} \;

install-images : png
	$(MKDIR) ${DESTDIR}/$(DATAROOTDIR)/backgrounds/core4
	$(CP) $(IMAGES_32:=-$(W32)x$(H32).png) ${DESTDIR}/$(DATAROOTDIR)/backgrounds/core4/
	$(CP) $(IMAGES_43:=-$(W43)x$(H43).png) ${DESTDIR}/$(DATAROOTDIR)/backgrounds/core4/
	$(CP) $(IMAGES_169:=-$(W169)x$(H169).png) ${DESTDIR}/$(DATAROOTDIR)/backgrounds/core4/
	$(CP) $(IMAGES_219:=-$(W219)x$(H219).png) ${DESTDIR}/$(DATAROOTDIR)/backgrounds/core4/

install-gnome : install-images

install-kde : install-images

install-mint : install-images

.PHONY: all
