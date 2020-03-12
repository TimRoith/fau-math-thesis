\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fau-math-thesis}[2020/02/11 FAU math]
% ########################################################################################
% Why do we use report here? Are there bette oprions?
% ----------------------------------------------------------------------------------------
\LoadClass[twoside, openright, 12pt]{report}
\usepackage{xkeyval}

 

\newif\ifmc@nobind
\mc@nobindfalse
\newif\ifmc@showframe
\mc@showframefalse

\DeclareOption{nobind}{\mc@nobindtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\define@boolkey{fau-math-thesis.cls}[cls]{showframe}{}

\newif\ifPHD@pageStyleI\PHD@pageStyleIfalse % Set Page StyleI
\DeclareOption{PageStyleI}{\PHD@pageStyleItrue}

\newif\ifPHD@pageStyleII\PHD@pageStyleIIfalse % Set Page StyleII
\DeclareOption{PageStyleII}{\PHD@pageStyleIItrue}


\ProcessOptions\relax
\ProcessOptionsX




% ########################################################################################
% Defines the page layout
% ----------------------------------------------------------------------------------------
\ifmc@nobind
\usepackage[includehead,hmargin={3.1cm, 3.1cm}, vmargin={2.5cm,2.7cm}, 
headsep=.8cm,footskip=1.2cm, showframe]{geometry}
\else
\usepackage[includehead,hmargin={3.6cm, 2.6cm}, vmargin={2.5cm,2.7cm}, 
headsep=.8cm,footskip=1.2cm, showframe]{geometry}
\fi
% ########################################################################################
%
%
%
%
%
% ########################################################################################
% Fancy Header
% ----------------------------------------------------------------------------------------


\RequirePackage{fancyhdr} % Define custom header

% Style 1: Sets Page Number at the Top and Chapter/Section Name on LE/RO
\fancypagestyle{PageStyleI}{
	\renewcommand{\chaptermark}[1]{\markboth{##1}{}}
	\renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1\ }}
	\fancyhf{}
	\fancyhead[RO]{\nouppercase \rightmark\hspace{0.25em} | 
		\hspace{0.25em} \bfseries{\thepage}}
	\fancyhead[LE]{ {\bfseries\thepage} \hspace{0.25em} | 
		\hspace{0.25em} \nouppercase \leftmark}
}

% Style 2: Sets Page Number at the Bottom with Chapter/Section Name on LO/RE
\fancypagestyle{PageStyleII}{
	\renewcommand{\chaptermark}[1]{\markboth{##1}{}}
	\renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1}}
	\fancyhf{}
	\fancyhead[RO]{\bfseries\nouppercase \rightmark}
	\fancyhead[LE]{\bfseries \nouppercase \leftmark}
	\fancyfoot[C]{\thepage}
}


% Set Fancy Header Command is defined to Load FancyHdr after Geometry is defined
\newcommand{\setFancyHdr}{
	
	\pagestyle{fancy}
	
	\ifPHD@pageStyleI
	% Style 1: Sets Page Number at the Top and Chapter/Section Name on LE/RO
	\pagestyle{PageStyleI}
	
	\else
	\ifPHD@pageStyleII
	
	% Style 2: Sets Page Number at the Bottom with Chapter/Section Name on LO/RE
	\pagestyle{PageStyleII}
	
	\else
	% Default Style: Sets Page Number at the Top (LE/RO) with Chapter/Section Name
	% on LO/RE and an empty footer
	\renewcommand{\chaptermark}[1]{\markboth {##1}{}}
	\renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1}}
	\fancyhf{}
	\fancyhead[LO]{\nouppercase \rightmark}
	\fancyhead[LE,RO]{\bfseries\thepage}
	\fancyhead[RE]{\nouppercase \leftmark}
	\fi
	\fi
}

\setlength{\headheight}{14.5pt}
%\renewcommand{\headrulewidth}{0.5pt}
%\renewcommand{\footrulewidth}{0pt}
\fancypagestyle{plain}{
	\fancyhead{}
	\renewcommand{\headrulewidth}{0pt}
}



% ########################################################################################
% Colors
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
\def\colors#1{
\setkeys{color}{#1}	
\hypersetup{colorlinks = true,
		urlcolor=\titlecolor,
		citecolor=\titleboxcolor
		linkcolor=\titlebackground}
}
\def\colorthemefaumath{
	\definecolor{cA}{RGB}{0,155,119}
	\definecolor{cB}{RGB}{170,207,189}
	\definecolor{cC}{RGB}{229,239,234}
	\colors{titlecolor=cA, titlebackground = cB, background = cC}
}



%\def\colortheme#1{
%\def\@input{#1}
%\def\@thA{themeA}
%%
%\ifx \@input\@thA
%	\definecolor{cA}{RGB}{40,100,40}
%	\definecolor{cB}{RGB}{0,40,140}
%	\definecolor{cC}{RGB}{100,40,40}
%\else % default values
%	\definecolor{cA}{RGB}{40,100,40}
%	\definecolor{cB}{RGB}{0,40,140}
%	\definecolor{cC}{RGB}{100,40,40}
%\fi
%}

% ########################################################################################
% Chapter opening
% ------------------
% The following code is inspired by the qoutechap package.
% ----------------------------------------------------------------------------------------
\providecommand*{\chapterheadstartvskip}{\vspace*{2.3\baselineskip}}
\providecommand*{\chapterheadendvskip}{\vspace{1.7\baselineskip}}
\@ifundefined{@mainmattertrue}{\newif\if@mainmatter\@mainmattertrue}{}
%
\renewcommand\chapter{%
	\if@openright\cleardoublepage\else\clearpage\fi
	\thispagestyle{plain}%
	\global\@topnum\z@
	\@afterindentfalse
	\secdef\@chapter\@schapter}
%
\newcommand*{\chapnumfont}{%
	\usefont{T1}{ptm}{b}{n}\fontsize{100}{130}\selectfont%
	\color{\titlecolor}
}
\let\size@chapter\huge

\renewcommand{\@makechapterhead}[1]{\chapterheadstartvskip%
	{\size@chapter
		{\relax\raggedleft
			{\chapnumfont
				\ifnum \c@secnumdepth >\m@ne%
				\if@mainmatter\thechapter%
				\fi\fi
				\par\nobreak
			}%
			{\raggedleft\advance\leftmargin10em\interlinepenalty\@M #1\par}
		}
		\nobreak\chapterheadendvskip
	}
}

\renewcommand{\@makeschapterhead}[1]{%
	{\let\c@secnumdepth\m@ne\@makechapterhead{#1}}}
% ########################################################################################

% ########################################################################################
%
%
%
%
%
\usepackage{tabularx}
\usepackage{graphicx}


\usepackage[american, german]{babel}
\usepackage[ngerman]{datetime}
\newdateformat{gerformat}{\THEDAY{.}\hspace{3pt}\monthname[\THEMONTH] \THEYEAR}

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



\usepackage[nohints,tight]{minitoc} 
\setcounter{minitocdepth}{2} 
% The level that gets a number:
\setcounter{secnumdepth}{2}
% The level that shows up in the ToC:
\setcounter{tocdepth}{2}


%\renewcommand{\chapterheadstartvskip}{\vspace*{40pt}}
%\renewcommand{\chapterheadendvskip}{\vspace{30pt}}






% ########################################################################################
% Bibliography
% ----------------------------------------------------------------------------------------
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
backend=bibtex%
]{biblatex}
% ########################################################################################\\
%
%
%
%
%
% ########################################################################################
% Thorems, definitions, etc.
% ----------------------------------------------------------------------------------------
\usepackage{amsthm}
\usepackage{thmtools}
\usepackage[framemethod=TikZ]{mdframed}
% some styles
\declaretheoremstyle[
headfont=\bfseries, 
notebraces={[}{]},
bodyfont=\normalfont\itshape,
headpunct={},
postheadspace=\newline,
postheadhook={\textcolor{\titlecolor}{\rule[.6ex]{\linewidth}{0.4pt}}\\},
spacebelow=\parsep,
spaceabove=\parsep,
mdframed={
	backgroundcolor=\background, 
	linecolor=\titlebackground, 
	innertopmargin=6pt,
	roundcorner=10pt, 
	innerbottommargin=6pt, 
	skipabove=\parsep, 
	skipbelow=\parsep } 
]{styleA}
%
%
%
%
%
% ########################################################################################
% Hyperref stuff
% ----------------------------------------------------------------------------------------
\usepackage{hyperref}
\def\setpdfinfo{\hypersetup{pdfinfo={
			Title={\@title},
			Author={\@author},
			Subject={\@thesistype},
			Keywords={\@keywords}}}}
% ########################################################################################
