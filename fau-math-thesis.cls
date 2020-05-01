% ########################################################################################
% Class specification
% ----------------------------------------------------------------------------------------
\newcommand{\classname}{fau-math-thesis}
\newcommand{\fileversion}{0.1}
\newcommand{\filedate}{02/05/2020}
\newcommand{\cfileauthor}{Tim Roith}
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
% ----------------------------------------------------------------------------------------
\newif\ifTH@customBib\TH@customBibfalse
\DeclareOptionX{customBib}{\TH@customBibtrue}
% ----------------------------------------------------------------------------------------
% Options for the page layout within KOMA
\newif\ifFAU@setBCOR\FAU@setBCORfalse
\newif\ifFAU@setDIV\FAU@setDIVfalse
\newif\ifFAU@setSided\FAU@setSidedfalse
% Binding offset
\DeclareOptionX{BCOR}{
	\FAU@setBCORtrue
	\PassOptionsToClass{\CurrentOption}{\baseclass}
}%
% DIV calculation
\DeclareOptionX{DIV}{
	\FAU@setDIVtrue
	\PassOptionsToClass{\CurrentOption}{\baseclass}
}%
% two or onesided definition
\DeclareOptionX{oneside}{
	\FAU@setSidedtrue
	\PassOptionsToClass{\CurrentOption}{\baseclass}
}%
\DeclareOptionX{twoside}{
	\FAU@setSidedtrue
	\PassOptionsToClass{\CurrentOption}{\baseclass}
}%
% ----------------------------------------------------------------------------------------
% If the page layout is not set by options and the PDF or print option is set we now specify
% the page layout by means of the KOMA script.
% ----------------------------------------------------------------------------------------
\newif\ifTH@PDF\TH@PDFfalse % PDF Option, a document for PDF viewers
\newif\ifFAU@print\FAU@printfalse % print Option, a document for pinting
% ----------------------------------------------------------------------------------------
\DeclareOptionX{PDF}{\TH@PDFtrue}
\DeclareOptionX{setPDF}{
	\TH@PDFtrue
	% DIV SETTING
	\ifFAU@setDIV % it has already been set
		\ClassWarningNoLine{\classname}{The Option DIV has already been set. The 
		PDF option will not reset this value. If you want to use the default settings
		of PDF do not specify a DIV value.}
	\else
		\PassOptionsToClass{DIV=classic}{\baseclass}
	\fi
	% BINDING
	\ifFAU@setBCOR % it has already been set
		\ClassWarningNoLine{\classname}{The Option BCOR has already been set. The 
		PDF option will not reset this value. If you want to use the default settings
		of PDF do not specify a BCOR value.}
	\else
		\PassOptionsToClass{BCOR=0mm}{\baseclass}
	\fi
	% TWO-ONESIDED
	\ifFAU@setSided % it has already been set, probably output something
		\ClassWarningNoLine{\classname}{The Option side has already been set. The 
		PDF option will not reset this value. If you want to use the default settings
		of PDF do not specify a side value.}	
	\else
		\PassOptionsToClass{oneside}{\baseclass}
	\fi
}
% ----------------------------------------------------------------------------------------
\DeclareOptionX{print}{\FAU@printtrue}
\DeclareOptionX{setprint}{
	\FAU@printtrue
	% DIV SETTING
	\ifFAU@setDIV % it has already been set
	\ClassWarningNoLine{\classname}{The Option DIV has already been set. The 
	print option will not reset this value. If you want to use the default settings
	of PDF do not specify a DIV value.}
	\else
		\PassOptionsToClass{DIV=classic}{\baseclass}
	\fi
	% BINDING
	\ifFAU@setBCOR % it has already been set
	\else
		\ClassWarningNoLine{\classname}{The Option BCOR has not been set yet! The 
		print option will set it to BCOR=5mm. You should actually set this value yourself!}
		\PassOptionsToClass{BCOR=15mm}{\baseclass}
	\fi
	% TWO-ONESIDED
	\ifFAU@setSided % it has already been set, probably output something
	\ClassWarningNoLine{\classname}{The Option side has already been set. The 
	print option will not reset this value. If you want to use the default settings
	of PDF do not specify a side value.}	
	\else
		\PassOptionsToClass{twoside}{\baseclass}
	\fi		
}
% ----------------------------------------------------------------------------------------
\DeclareOptionX{showframe}{\PassOptionsToPackage{showframe}{geometry}}
% ----------------------------------------------------------------------------------------
% We might need these values for internal use, so let's consider them

% ----------------------------------------------------------------------------------------
% This passes all the options not considered so far to \baseclass
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{\baseclass}}
\ProcessOptionsX
% ----------------------------------------------------------------------------------------
% We can now load our baseclass
\LoadClass{\baseclass}
% ########################################################################################
%
%
%
%
%
% ########################################################################################
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
\define@key{color}{colmain}{\def\colmain{#1}}
\define@key{color}{colmainlight}{\def\colmainlight{#1}}
\define@key{color}{colmainllight}{\def\colmainllight{#1}}
\define@key{color}{colmainlllight}{\def\colmainlllight{#1}}
\setkeys{color}{colmain = black, colmainlight = white, colmainllight = white,%
				colmainlllight = white}{}
%
%
\def\colors#1{
\setkeys{color}{#1}
\hypersetup{
		urlcolor=\colmain,
		citecolor=\colmain,
		linkcolor=\colmain}
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
\usepackage[german, american]{babel}
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
% Don't break enumeration (etc.) across pages in an ugly manner
\clubpenalty=10000
\widowpenalty=10000
% ########################################################################################
%
%
%
%
%
% ########################################################################################
% Defines the page layout. We now use the KOMA options instead of the geometry package.
% ----------------------------------------------------------------------------------------
\usepackage[pass]{geometry} % This is just loaded for showframe