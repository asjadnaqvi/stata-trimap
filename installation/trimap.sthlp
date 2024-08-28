{smcl}
{* 28Aug2024}{...}
{hi:help trimap}{...}
{right:{browse "https://github.com/asjadnaqvi/stata-trimap":trimap v1.0 beta (GitHub)}}

{hline}

{title:ternary}: A Stata package for plotting three variables on a map. 

{p 4 4 2}
The command is still {it:beta} and lacks full set of features and checks. The command is a wrapper for {stata help geoplot:geoplot} and {stata help ternary:ternary}.

{marker syntax}{title:Syntax}
{p 8 15 2}

{cmd:trimap} {it:varL varR varB} {ifin}, 
                {cmd:[} {cmd:frame}({it:frame name}) {cmd:cuts}({it:num}) {cmd:geo}({it:str}) {cmd:geopost}({it:str})  
                  {cmd:zoom} {cmd:fill} {cmd:points} {cmd:lines} {cmd:labels} {cmd:colorL}({it:str}) {cmd:colorR}({it:str}) {cmd:colorB}({it:str})
                  {cmd:lwidth}({it:str}) {cmd:msize}({it:str}) {cmd:malpha}({it:num}) {cmd:mcolor}({it:str}) {cmd:mlcolor}({it:str}) {cmd:mlwidth}({it:str}) 
                  {cmd:xscale}({it:num}) {cmd:yscale}({it:num})
				  *                                  
                {cmd:]}

{p 4 4 2}
The options are described as follows:

{p2coldent : {opt trimap varL varR varB}}The order of the variables is {it:Left}, {it:Right} and {it:Bottom}.{p_end}

{p2coldent : {opt frame(str)}}Define the frame in which the primary data exists. If no option is specified, then the current active frame is used.{p_end}

{p2coldent : {opt geo(str)}}Define additional spatial layers that are passed onto the {stata help geoplot:geoplot} command.{p_end}

{p2coldent : {opt geopost(str)}}Define post comma options in the {stata help geoplot:geoplot} command which includes additional layers, compass, scalebar, etc.{p_end}

{p2coldent : {opt cuts(num)}}Total number of evenly-spaced segments in the triangle. Default is {opt cuts(5)}.{p_end}

{p2coldent : {opt zoom(num)}}Zoom into the data based on the data extent of the bottom layer. This option will be enhanced further in later releases. Use this option if 
the data points are bunched in very few triangles. Rather than increasing the cuts to show more variation, {opt zoom} rescales the axes while keeping the cuts the same.{p_end}

{p2coldent : {opt lcolor(str)}}Outline colors of filled areas.{p_end}

{it:Colors}

{p2coldent : {opt fill}}Add graduated colors to the legend triangles. See color options below.{p_end}

{p2coldent : {opt points}}Add graduated colors to the points defined by the triangle they are in. Note that while both {opt fill} and {opt points} can be simultanously used,
but it will create a hollow marker illusion where only marker outlines are visible. So avoid this. Broadly, just using {opt points} renders faster since not all triangles contain points.
Point markers and outcomes can also be customized. See below.{p_end}

{p2coldent : {opt lines}}Add line colors in the triangle.{p_end}

{p2coldent : {opt labels}}Add colors to axes labels and ticks.{p_end}

{p2coldent : {opt colorL(str)}, {opt colorR(str)}, {opt colorB(str)}}User either a named color recognized by {stata help colorpalette:colorpalette} or use a {it:hex} code.
Defaults are {opt colorL(#00E0DF)}, {opt colorR(#FF6CFF)}, and {opt colorB(#DCB600)}. These colors represent the points where value is 1 or 100 for each layer.
The convex combinations of all the in-between colors are auto generated. Please note that the number of triangles = {it:cuts^2}, hence the program slows down exponentially.
as {it:O(n)=n^2}. So avoid going over 10 cuts which in any case renders the information meaningless as colors become indistinguishable. Here lower numbers are better.{p_end}


{p 4 4 2}
{it:Legend markers and lines}

{p2coldent : {opt lwidth(str)}}Lines width. Default is {opt lwidth(0.25)}.{p_end}

{p2coldent : {opt msize(str)}}Marker size. Default is {opt msize(1.5)}.{p_end}

{p2coldent : {opt malpha(str)}}Marker fill intensity. Default is {opt malpha(90)} or 90% fill.{p_end}

{p2coldent : {opt mcolor(str)}}Marker color if the option {opt points} is not specified. Default is {opt mcolor(black)}.{p_end}

{p2coldent : {opt mlcolor(str)}}Marker outline color. Default is {opt mlcolor(white)}.{p_end}

{p2coldent : {opt mlwidth(str)}}Marker outline width. Default is {opt mlwidth(0.1)}.{p_end}

{p2coldent : {opt xscale(num)}}Scale of the legend width relative to the full image. Default is {opt xscale(50)}.{p_end}

{p2coldent : {opt yscale(num)}}Scale of the legend height relative to the full image. Default is {opt yscale(100)}. Ideally don't touch this option and modify {opt xscale()} instead.{p_end}

{p2coldent : {opt *}}All other twoway options not elsewhere specified.{p_end}

{title:Dependencies}

The following packages are required for {cmd:trimap}:


{stata ssc install ternary, replace}
{stata ssc install geoplot, replace}
{stata ssc install moremata, replace}
{stata ssc install palettes, replace}
{stata ssc install colrspace, replace}

Even if you have these installed, it is highly recommended to check for updates: {stata ado update, update}

{title:Examples}

See {browse "https://github.com/asjadnaqvi/stata-trimap":GitHub}.

{hline}


{title:Package details}

Version      : {bf:trimap} v1.0 beta
This release : 28 Aug 2024
First release: 28 Aug 2024
Repository   : {browse "https://github.com/asjadnaqvi/stata-trimap":GitHub}
Keywords     : Stata, graph, ternary, triplot, trimap, tri-variate map
License      : {browse "https://opensource.org/licenses/MIT":MIT}

Authors      : {browse "https://github.com/asjadnaqvi":Asjad Naqvi}
E-mail       : asjadnaqvi@gmail.com
Twitter/X    : {browse "https://x.com/AsjadNaqvi":@AsjadNaqvi}


{title:Feedback}

Please submit bugs, errors, feature requests on {browse "https://github.com/asjadnaqvi/stata-trimap/issues":GitHub} by opening a new issue.


{title:Citation guidelines}

Suggested citation guidlines for this package:

Naqvi, A. (2024). Stata package "ternary" version 1.0. Release date 28 August 2024. https://github.com/asjadnaqvi/stata-trimap.

@software{trimap,
   author = {Naqvi, Asjad},
   title = {Stata package ``trimap''},
   url = {https://github.com/asjadnaqvi/stata-trimap},
   version = {1.0},
   date = {2024-08-28}
}


{title:References}

{p 4 8 2}Jann, B. (2024). GEOPLOT

{p 4 8 2}Jann, B. (2018). {browse "https://www.stata-journal.com/article.html?article=gr0075":Color palettes for Stata graphics}. The Stata Journal 18(4): 765-785.

{p 4 8 2}Jann, B. (2022). {browse "https://ideas.repec.org/p/bss/wpaper/43.html":Color palettes for Stata graphics: An update}. University of Bern Social Sciences Working Papers No. 43. 


{title:Other visualization packages}

{psee}
    {helpb arcplot}, {helpb alluvial}, {helpb bimap}, {helpb bumparea}, {helpb bumpline}, {helpb circlebar}, {helpb circlepack}, {helpb clipgeo}, {helpb delaunay}, {helpb joyplot}, {helpb marimekko}, {helpb polarspike}, 
	{helpb sankey}, {helpb schemepack}, {helpb spider}, {helpb splineplot}, {helpb streamplot}, {helpb sunburst}, {helpb ternary}, {helpb treecluster}, {helpb treemap}, {helpb trimap}, {helpb waffle}
