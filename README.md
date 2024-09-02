


![StataMin](https://img.shields.io/badge/stata-2015-blue) ![issues](https://img.shields.io/github/issues/asjadnaqvi/stata-trimap) ![license](https://img.shields.io/github/license/asjadnaqvi/stata-trimap) ![Stars](https://img.shields.io/github/stars/asjadnaqvi/stata-trimap) ![version](https://img.shields.io/github/v/release/asjadnaqvi/stata-trimap) ![release](https://img.shields.io/github/release-date/asjadnaqvi/stata-trimap)


---

[Installation](#Installation) | [Syntax](#Syntax) | [Examples](#Examples) | [Feedback](#Feedback) | [Change log](#Change-log)

---

# trimap v1.0
(28 Aug 2024)

This package provides the ability to draw trimaps Stata.


## Installation

The package can be installed via SSC or GitHub. The GitHub version, *might* be more recent due to bug fixes, feature updates etc, and *may* contain syntax improvements and changes in *default* values. See version numbers below. Eventually the GitHub version is published on SSC.

The SSC version (**coming soon**):

```stata

```

Or it can be installed from GitHub (**v1.0**):

```stata
net install trimap, from("https://raw.githubusercontent.com/asjadnaqvi/stata-trimap/main/installation/") replace
```

The following packages are required to run this command:

```stata
ssc install ternary, replace
ssc install palettes, replace
ssc install colrspace, replace
ssc install moremata, replace
```

Even if you have the package installed, make sure that it is updated `ado update, update`.

If you want to make a clean figure, then it is advisable to load a clean scheme. These are several available and I personally use the following:

```stata
ssc install schemepack, replace
set scheme white_tableau  
```

You can also push the scheme directly into the graph using the `scheme(schemename)` option. See the help file for details or the example below.

I also prefer narrow fonts in figures with long labels. You can change this as follows:

```stata
graph set window fontface "Arial Narrow"
```


## Syntax

The syntax for the latest version is as follows:

```stata
 trimap varL varR varB [if] [in], [ frame(frame name) cuts(num) geo(str) geopost(str) zoom fill points lines labels colorL(str) colorR(str) colorB(str) lwidth(str) msize(str) malpha(num) mcolor(str) mlcolor(str) mlwidth(str) leglwidth(str)
               leglcolor(str) xscale(num) yscale(num) * ]
```


See the help file `help trimap` for details.

The most basic use is as follows:

```
trimap varL varR varB, frame(framename)
```

representing left, right and bottom variables respectively. The framename is the frame in which the data is stored.

## Citation guidelines
Software packages take countless hours of programming, testing, and bug fixing. If you use this package, then a citation would be highly appreciated. Suggested citations:


*in BibTeX*

```
@software{trimap,
   author = {Naqvi, Asjad},
   title = {Stata package ``trimap''},
   url = {https://github.com/asjadnaqvi/stata-trimap},
   version = {1.0},
   date = {2024-08-28}
}
```

*or simple text*

```
Naqvi, A. (2024). Stata package "trimap" version 1.0. Release date 28 August 2024. https://github.com/asjadnaqvi/stata-trimap.
```


*or see [SSC citation](XXXX) (updated once a new version is submitted)*




## Examples


### Data setup

Get the shapefiles

```stata
foreach x in NUTS0 NUTS0_shp NUTS1 NUTS1_shp NUTS2 NUTS_shp NUTS3 NUTS3_shp {
	copy "https://github.com/asjadnaqvi/stata-trimap/raw/main/data/`x'.dta" "`x'.dta", replace
}
```


Get the data files

```stata
foreach x in NUTS3_pop NUTS3_gva NUTS2_edu NUTS2_tourstay {
	copy "https://github.com/asjadnaqvi/stata-trimap/raw/main/data/`x'.dta" "`x'.dta", replace
}
```


Set up the data:

```stata
geoframe create nuts0, replace
geoframe create nuts1, replace
geoframe create nuts2, replace
geoframe create nuts3, replace
```

```
frames change nuts3


merge 1:1 NUTS_ID using NUTS3_pop
drop if _m==2
drop _m


format *prop %5.0f
```

Test if `geoplot` is working correctly:

```stata
geoplot ///
	(area nuts3 y15prop, cuts(0(10)100) )  ///
	(line nuts0, lc(white) lw(0.2))  ///
	, tight title("Population share 15-64")
	
	
geoplot ///
	(area nuts3 y64prop, cuts(0(10)100) )  ///
	(line nuts0, lc(white) lw(0.2))  ///
	, tight	title("Population share 0-14")
	
	
geoplot ///
	(area nuts3 y99prop, cuts(0(10)100) )  ///
	(line nuts0, lc(white) lw(0.2))  ///
	, tight	title("Population share 65+")	
```

which gives us:

<img src="/figures/geoplottest1.png" width="48%"><img src="/figures/geoplottest2.png" width="48%">
<img src="/figures/geoplottest3.png" width="48%">


```stata
ternary y99prop y15prop y64prop, points
```

<img src="/figures/ternary_test.png" width="100%">



### Test the command

```stata
trimap y99prop y15prop y64prop, frame(nuts3)
```

<img src="/figures/trimap1.png" width="100%">


```stata
trimap y99prop y15prop y64prop, frame(nuts3) zoom
```

<img src="/figures/trimap2.png" width="100%">

```stata
trimap y99prop y15prop y64prop, frame(nuts3) zoom cuts(4)
```

<img src="/figures/trimap3.png" width="100%">

```stata
trimap y99prop y15prop y64prop, frame(nuts3) zoom cuts(4) geo( (line nuts1, lc(white) lw(0.05)) )
```

<img src="/figures/trimap4.png" width="100%">


```stata
trimap y99prop y15prop y64prop, frame(nuts3) zoom cuts(4) ///
geo( (line nuts1, lc(white) lw(0.05)) (line nuts0, lc(white) lw(0.2)) )
```

<img src="/figures/trimap5.png" width="100%">

```stata
trimap y99prop y15prop y64prop, frame(nuts3) zoom cuts(4) ///
	geo( (line nuts1, lc(white) lw(0.05)) (line nuts0, lc(white) lw(0.2)) )	///
	fill msym(point) 
```

<img src="/figures/trimap6.png" width="100%">

```stata
trimap y99prop y15prop y64prop, frame(nuts3) zoom cuts(4) ///
	geo( (line nuts1, lc(white) lw(0.05)) (line nuts0, lc(white) lw(0.2)) )	///
	fill msize(0.5) mcolor(white%50) leglc(black)
```

<img src="/figures/trimap7.png" width="100%">

```stata
trimap y99prop y15prop y64prop, frame(nuts3) zoom cuts(2) ///
	geo( (line nuts1, lc(white) lw(0.05)) (line nuts0, lc(white) lw(0.2)) )	///
	fill msize(0.5) mcolor(white%60) leglc(black)
```

<img src="/figures/trimap8.png" width="100%">

```stata
trimap y99prop y15prop y64prop, frame(nuts3) zoom cuts(4) ///
	geo( (line nuts1, lc(white) lw(0.05)) (line nuts0, lc(white) lw(0.2)) )	///
	fill msize(0.5) mcolor(white%60) leglc(black) colorB(#FFFF00) colorL(#F11D8C) colorR(#01A0C6)
```

<img src="/figures/trimap9.png" width="100%">

### Try another layer

```stata
merge 1:1 NUTS_ID using NUTS3_gva
drop if _m==2
drop _m
```


```stata
trimap  gva_tertiary gva_primary gva_secondary, frame(nuts3) cuts(4) ///
	geo( (line nuts1, lc(white) lw(0.05)) (line nuts0, lc(white) lw(0.2)) )	///
	fill colorB(#FFFF00) colorL(#F11D8C) colorR(#01A0C6) msize(0.3) mcolor(black%60) mlc(none) 
```

<img src="/figures/trimap10.png" width="100%">

```stata
trimap  gva_secondary gva_tertiary gva_primary , frame(nuts3)   ///
	geo( (line nuts1, lc(white) lw(0.05)) (line nuts0, lc(white) lw(0.2)) )	///
	fill colorB(#FFFF00) colorL(#F11D8C) colorR(#01A0C6) msize(0.3) mcolor(black%60) mlc(none) 
```

<img src="/figures/trimap11.png" width="100%">

```stata
trimap  gva_secondary gva_tertiary gva_primary , frame(nuts3)  cuts(8) ///
	geo( (line nuts1, lc(white) lw(0.05)) (line nuts0, lc(white) lw(0.2)) )	///
	fill colorB(#FFFF00) colorL(#F11D8C) colorR(#01A0C6) msize(0.3) mcolor(black%60) mlc(none) 
```

<img src="/figures/trimap12.png" width="100%">

### And other layers at the NUTS2 level

```stata
frame change nuts2			


merge 1:1 NUTS_ID using NUTS2_edu
drop if _m==2
drop _m

trimap edu_primary  edu_secondary edu_tertiary, frame(nuts2)  cuts(2)  ///
	geo( (line nuts1, lc(white) lw(0.05)) (line nuts0, lc(white) lw(0.2)) )	///
	fill msize(0.4) mcolor(black%60) mlc(none) 
```

<img src="/figures/trimap13.png" width="100%">


```stata
merge 1:1 NUTS_ID using NUTS2_tourstay.dta
drop if _m==2
drop _m	

trimap  tour_hotels tour_other tour_camping , frame(nuts2)  cuts(5)  ///
	geo( (line nuts1, lc(white) lw(0.05)) (line nuts0, lc(white) lw(0.2)) )	///
	fill msize(0.4) mcolor(black%60) mlc(none) 
```

<img src="/figures/trimap14.png" width="100%">



## Feedback

Please open an [issue](https://github.com/asjadnaqvi/stata-trimap/issues) to report errors, feature enhancements, and/or other requests. 


## Change log

**v1.0 (28 Aug 2024)**
- First release.





