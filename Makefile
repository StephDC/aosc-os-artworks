# Basic list of files to be generated/converted.
SUBDIRS	= 32 43 169 219
SVG = Day.svg \
      Day-Plain.svg \
      Night.svg \
      Night-Plain.svg
SVGGEN = Day-gen.svg \
         Day-Plain-gen.svg \
         Night-gen.svg \
         Night-Plain-gen.svg

# Command definitions.
CD = cd
FIND = find
SED = sed
RM = rm -fv

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

all: gen32 gen43 gen169 gen219 png32 png43 png169 png219

gen32:
	$(CD) 32/ && \
	for svg in $(SVG) ; do \
		sed -e "s|>REL<|>$(REL)<|g" \
		    -e "s|ARCHIT|$(ARCH)|g" \
		    -e "s|RV|$(REL)|g" \
		    -e "s|REL_DATE|$(DATE)|g" \
		    -e "s|COREV|$(CORE)|g" \
		    "$$svg" > "$${svg/.svg/-gen.svg}" ; \
	done

gen43:
	$(CD) 43/ && \
	for svg in $(SVG) ; do \
		sed -e "s|>REL<|>$(REL)<|g" \
		    -e "s|ARCHIT|$(ARCH)|g" \
		    -e "s|RV|$(REL)|g" \
		    -e "s|REL_DATE|$(DATE)|g" \
		    -e "s|COREV|$(CORE)|g" \
		    "$$svg" > "$${svg/.svg/-gen.svg}" ; \
	done

gen169:
	$(CD) 169/ && \
	for svg in $(SVG) ; do \
		sed -e "s|>REL<|>$(REL)<|g" \
		    -e "s|ARCHIT|$(ARCH)|g" \
		    -e "s|RV|$(REL)|g" \
		    -e "s|REL_DATE|$(DATE)|g" \
		    -e "s|COREV|$(CORE)|g" \
		    "$$svg" > "$${svg/.svg/-gen.svg}" ; \
	done

gen219:
	$(CD) 219/ && \
	for svg in $(SVG) ; do \
		sed -e "s|>REL<|>$(REL)<|g" \
		    -e "s|ARCHIT|$(ARCH)|g" \
		    -e "s|RV|$(REL)|g" \
		    -e "s|REL_DATE|$(DATE)|g" \
		    -e "s|COREV|$(CORE)|g" \
		    "$$svg" > "$${svg/.svg/-gen.svg}" ; \
	done

png32: gen32
	$(CD) 32/ && \
	for svg in $(SVGGEN) ; do \
		inkscape -h $(H32) -w $(W32) \
		         -e $${svg/-gen.svg/-$(W32)x$(H32).png} "$$svg" ; \
	done

png43: gen43
	$(CD) 43/ && \
	for svg in $(SVGGEN) ; do \
		inkscape -h $(H43) -w $(W43) \
		         -e $${svg/-gen.svg/-$(W43)x$(H43).png} "$$svg" ; \
	done

png169: gen169
	$(CD) 169/ && \
	for svg in $(SVGGEN) ; do \
		inkscape -h $(H169) -w $(W169) \
		         -e $${svg/-gen.svg/-$(W169)x$(H169).png} "$$svg" ; \
	done

png219: gen219
	$(CD) 219/ && \
	for svg in $(SVGGEN) ; do \
		inkscape -h $(H219) -w $(W219) \
		         -e $${svg/-gen.svg/-$(W219)x$(H219).png} "$$svg" ; \
	done

clean:
	$(FIND) . -name '*gen*.svg' -exec $(RM) {} \;
	$(FIND) . -name '*.png' -exec $(RM) {} \;

.PHONY: all
