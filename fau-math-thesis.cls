\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fau-math-thesis}[2020/02/11 FAU math]
% ########################################################################################
% Why do we use report here? Are there bette oprions?
% ----------------------------------------------------------------------------------------
\LoadClass[openright,12pt]{report}
\usepackage{xkeyval}


\newif\ifmc@nobind
\mc@nobindfalse
\newif\ifmc@showframe
\mc@showframefalse

\DeclareOption{nobind}{\mc@nobindtrue}
\define@boolkey{fau-math-thesis.cls}[cls]{showframe}{}
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
% Colors
% ----------------------------------------------------------------------------------------
\usepackage{xcolor}
%
\def\colortheme#1{
\def\@input{#1}
\def\@thA{themeA}
%
\ifx \@input\@thA
	\definecolor{cA}{RGB}{40,100,40}
	\definecolor{cB}{RGB}{0,40,140}
	\definecolor{cC}{RGB}{100,40,40}
\else % default values
	\definecolor{cA}{RGB}{40,100,40}
	\definecolor{cB}{RGB}{0,40,140}
	\definecolor{cC}{RGB}{100,40,40}
\fi
}

% ########################################################################################
%
%
%
%
%
% ########################################################################################
% Hyperef stuff
% ----------------------------------------------------------------------------------------
\usepackage[colorlinks = true, linkcolor = cA, citecolor = cB, urlcolor = cA]{hyperref}
\def\setpdfinfo{\hypersetup{pdfinfo={
		Title={\@title},
		Author={\@author},
		Subject={\@thesistype},
		Keywords={\@keywords}}}}
% ########################################################################################



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
% ########################################################################################
