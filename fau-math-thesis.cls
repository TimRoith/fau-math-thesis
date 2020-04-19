% ########################################################################################
% Class specification
% ----------------------------------------------------------------------------------------
\newcommand{\classname}{fau-math-theis}
\newcommand{\fileversion}{0.1}
\newcommand{\filedate}{18/03/2020}
%\newcommand{\fileauthor}{Tim Roith}
\def\baseclass{scrbook}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fau-math-thesis}[\filedate A class file for a FAU math thesis, provided by]
% ########################################################################################
% Options and bools
% ----------------------------------------------------------------------------------------
% Here we declare the options passed to the classed and define bools which are mostly 
% used further below
% ----------------------------------------------------------------------------------------
\usepackage{xkeyval} % Should be loaded here in case we want to define xkey Options
% ------------------------------------------------
% Bibliography, the options are currently very limited, user can either specify the 
% the bib stuff himself by using ths option or use the spec from the bib section 
% down below.
% ------------------------------------------------
\newif\ifTH@customBib\TH@customBibfalse
\DeclareOption{customBib}{\TH@customBibtrue}
% ------------------------------------------------
%
\newif\ifTH@PDF\TH@PDFfalse % PDF Option, if false it is a document for actual printing
\DeclareOption{PDF}{\TH@PDFtrue}
%
%
\DeclareOption{showframe}{\PassOptionsToPackage{showframe}{geometry}}
%
%
\newif\if@oneside\@onesidefalse
\DeclareOption{oneside}{\PassOptionsToClass{\CurrentOption}{\baseclass}\@onesidetrue}%
\DeclareOption{twoside}{\PassOptionsToClass{\CurrentOption}{\baseclass}}%
%
%
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{\baseclass}
}

\ProcessOptions\relax
\ProcessOptionsX

\LoadClass{\baseclass}
% ########################################################################################
%
%
%
%
%
\usepackage{graphicx}
% ########################################################################################
%
%
%
%
%
% ########################################################################################
% Colors
% ----------------------------------------------------------------------------------------
% Here we define the basic structure for using consistent colors in our document. The idea 
% is to define key values with respective commands, i.e. \titlecolor that can be used 
% througout the document. The command \colors will set the colors, it is used in the file
% fau-colors.sty where additional colors are defined.
% ----------------------------------------------------------------------------------------
\usepackage{xcolor}
%
\define@key{color}{titlecolor}{\def\titlecolor{#1}}
\define@key{color}{titlebackground}{\def\titlebackground{#1}}
\define@key{color}{background}{\def\background{#1}}
\define@key{color}{titleboxcolor}{\def\titleboxcolor{#1}}
\define@key{color}{boxcolor}{\def\boxcolor{#1}}
\setkeys{color}{titlecolor = black, titlebackground = white, background = white,%
				titleboxcolor = black, boxcolor = black}{}
%
%
\def\colors#1{
\setkeys{color}{#1}	
\hypersetup{
		urlcolor=\titlecolor,
		citecolor=\titleboxcolor,
		linkcolor=\titlecolor}
}
% ########################################################################################
%
%
%
%
%
% ########################################################################################
% Datetime commands
% ----------------------------------------------------------------------------------------
\usepackage[american, german]{babel}
\usepackage[ngerman]{datetime}
\newdateformat{gerformat}{\THEDAY{.}\hspace{3pt}\monthname[\THEMONTH] \THEYEAR}
% ########################################################################################
%
%
%
%
%
% ########################################################################################
% Some usful stuff we'll need all the time
% ----------------------------------------------------------------------------------------
\newenvironment{singlepage}{%
	\@restonecolfalse
	\if@twocolumn
		\@restonecoltrue\onecolumn
	\else
		\if@openright
			\cleardoublepage
		\else
			\clearpage
		\fi
	\fi}%
{\if@restonecol
	\twocolumn
\else\newpage\thispagestyle{empty}
\fi}
% ########################################################################################
%
%
%
%
%
% ########################################################################################
% Titelpage
% ----------------------------------------------------------------------------------------
% Some macros
\def\subdate#1{\gdef\@subdate{#1}}
\subdate{\gerformat\today} % The default value for the date is today in german style
\def\degree#1{\gdef\@degree{#1}} % for the degree you want to obtain
\def\thesistype#1{\gdef\@thesistype{#1}} % for the degree you want to obtain
\def\keywords#1{\gdef\@keywords{#1}}
% ----------------------------------------------------------------------------------------
% Referees
\define@cmdkey{ref}{first}[]{}
\define@cmdkey{ref}{second}[]{}
\define@cmdkey{ref}{third}[]{}
% ========= KEY DEFAULTS =========
%\setkeys{ref}{}% Defaults
\newcommand{\Referee}[1]{\setkeys{ref}{#1}}
\gdef\@Referee{%
	Betreuer:& \cmdKV@ref@first
	\key@ifundefined[cmdKV]{ref}{second}{}{\\ Betreuer:& \cmdKV@ref@second}
	\key@ifundefined[cmdKV]{ref}{third}{}{\\ Betreuer:& \cmdKV@ref@third \\}
}
% ----------------------------------------------------------------------------------------
\renewcommand{\maketitle}{
\begin{singlepage}
\thispagestyle{empty}
\textsf{
\begin{center}
\vspace*{1cm}
\huge \textbf{\@title} \\
\vspace{2cm}
\LARGE\textbf{\@thesistype}\\[5mm]
\Large zur Erlangung des Grades\\[5mm]
\textbf{\@degree \\[5mm]
im Studiengang
Mathematik\\[5mm]
%% Technomathematik\\[5mm]
%% Wirtschaftsmathematik\\[5mm]
}
am Department Mathematik der\\ Friedrich-Alexander-Universit\"at
Erlangen-N\"urnberg\\[1cm]
vorgelegt am \textbf{\@subdate} \\[3mm]
von \textbf{\@author}
%  \vspace{2.5cm}
%  \vspace{3cm}
\vfill
\normalsize
\begin{tabular}{r l}
\@Referee
\end{tabular}
\end{center}
%
\begin{minipage}{0.36\textwidth}
\vspace*{10mm}
\includegraphics[width=\textwidth]{atelier/logo/FAU_nat}
\end{minipage}
\hfill
\begin{minipage}{0.3\textwidth}
\includegraphics[width=\textwidth]{atelier/logo/DepMathLogo} \\[3mm]
\end{minipage}
}
\end{singlepage}
}
% ########################################################################################
%
%
%
%
%
% ########################################################################################
% Probably minitocs are cool, we'll see
% ----------------------------------------------------------------------------------------
%\usepackage[nohints,tight]{minitoc} 
%\setcounter{minitocdepth}{2} 
%% The level that gets a number:
%\setcounter{secnumdepth}{2}
%% The level that shows up in the ToC:
%\setcounter{tocdepth}{2}


%\renewcommand{\chapterheadstartvskip}{\vspace*{40pt}}
%\renewcommand{\chapterheadendvskip}{\vspace{30pt}}
% ########################################################################################
%
%
%
%
%
% ########################################################################################
% Bibliography
% ----------------------------------------------------------------------------------------
\ifTH@customBib %
\else
\usepackage{csquotes}
\usepackage[style=numeric-comp,%
			defernumbers=true,
			useprefix=true,%
			giveninits=true,%
			hyperref=true,%
			autocite=inline,
			maxcitenames=2,%
			maxbibnames=20,%
			uniquename=init,%
			sorting = none,
			sortcites=false,% sort citations when multiple entries are passed to one cite command
			doi=true,%
			isbn=false,%
			url=false,%
			eprint=false,%
			backend=biber %
]{biblatex}
\fi
% ########################################################################################
%
%
%
%
%
% ########################################################################################
% Main, front, back matter, this is copied from 
% https://github.com/kks32/phd-thesis-template/
% ########################################################################################
\renewcommand{\frontmatter}{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{roman}
}
\renewcommand{\mainmatter}{%
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}
}
\renewcommand{\backmatter}{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse
}
% ########################################################################################
%
%
%
%
%
% ########################################################################################
% Thorems, definitions, etc.
% ----------------------------------------------------------------------------------------
\usepackage{amsmath, amssymb, amsthm}
% ########################################################################################
%
%
%
%
%
% ########################################################################################
% Hyperref stuff
% ----------------------------------------------------------------------------------------
\usepackage{hyperref}
\hypersetup{
	colorlinks = true,
    final=true,
    plainpages=false,
    pdfstartview=FitV,
    pdftoolbar=true,
    pdfmenubar=true,
    bookmarksopen=true,
    bookmarksnumbered=true,
    breaklinks=true,
    linktocpage
}
\def\setpdfinfo{\hypersetup{pdfinfo={
			Title={\@title},
			Author={\@author},
			Subject={\@thesistype},
			Keywords={\@keywords}}}}
% ########################################################################################
% Misc
% ----------------------------------------------------------------------------------------
\usepackage{todonotes}
% Don't break enumeration (etc.) across pages in an ugly manner
\clubpenalty=10000
\widowpenalty=10000
% ########################################################################################
% Defines the page layout
% ----------------------------------------------------------------------------------------
\ifTH@PDF
\usepackage[includehead,hmargin={3.1cm, 3.1cm}, vmargin={2.5cm,2.7cm}, 
headsep=.8cm,footskip=1.2cm, marginparsep=0.4cm, marginparwidth=2.7cm]{geometry}
\else
\usepackage[includehead,hmargin={3.6cm, 2.6cm}, vmargin={2.5cm,2.7cm}, 
headsep=.8cm,footskip=1.2cm]{geometry}
\fi