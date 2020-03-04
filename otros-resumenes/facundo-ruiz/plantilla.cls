\LoadClass[10pt]{article}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{plantilla}[2020/02/26 Plantilla para resumen bases]

% ===========================================================

% Diseño de página
\RequirePackage[paper=a4paper, left=1.5cm, right=1.5cm, bottom=2cm, top=1.5cm]{geometry}

% Lenguaje español
\RequirePackage[utf8]{inputenc}
\RequirePackage[spanish,activeacute]{babel}
\spanishplainpercent

% Encacbezado y pie de página
% \RequirePackage{fancyhdr} --> default
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\renewcommand{\sectionmark}[1]{\markboth{#1}{}}
\fancyhf{} % clear the headers
\fancyhead[L]{%
   % Letra itálica
   \itshape
}
\fancyfoot[C]{\thepage}
%\usepackage{lastpage}
\setlength{\headheight}{20pt}
\setlength{\headsep}{10pt}
\setlength{\intextsep}{0.3cm}
%\lhead{Algoritmos y Estructuras de Datos III}
%\chead{\chaptername}
\rhead{\textit{Bases de Datos - Resumen final}}

% Paquetes de colores y títulos
\RequirePackage[usenames,dvipsnames,svgnames,table]{xcolor}
\RequirePackage{titlesec}
\RequirePackage{parskip}

% Hipervínculos
\RequirePackage[bookmarks=true]{hyperref}

% Ítems
\RequirePackage{enumitem}

% Math
\RequirePackage{amsmath,amssymb,amsthm,mathabx,mathtools}
\RequirePackage[italic]{mathastext}

% Columnas
\RequirePackage{multicol}

% Paquete para el psuedo-código
\RequirePackage[ruled, linesnumbered, lined, boxed, commentsnumbered]{algorithm2e}

% Paquete de imágenes
\RequirePackage{graphicx}

% Títulos
\RequirePackage{titlesec}
\titleformat{\chapter}[display]{\scshape\huge\color{Brown}}{}{}{}
\titleformat{\section}[display]{\scshape\Large\color{BrickRed}}{}{}{}
\titleformat{\subsection}[display]{\scshape\large\color{RoyalPurple}}{}{}{}
\titleformat{\subsubsection}[display]{\scshape\normalsize\color{RoyalBlue}}{}{}{}
\titleformat{\paragraph}[display]{\rmfamily\normalsize}{}{}{}

% Espaciado del formato
\titlespacing{\chapter}{0pt}{3pt}{6pt plus 2pt minus 3pt}
\titlespacing{\section}{3pt}{2pt}{4pt plus 2pt minus 2pt}
\titlespacing{\subsection}{6pt}{1pt}{3pt plus 1pt minus 2pt}
\titlespacing{\subsubsection}{8pt}{1pt}{3pt plus 1pt minus 2pt}
\titlespacing{\paragraph}{0pt}{1pt}{2pt plus 1pt minus 1pt}

% Comando para las comillas dobles
\newcommand{\quotes}[1]{``#1"}

% Epígrafes en la experimentación
\RequirePackage[font=small,labelfont=bf]{caption}
\RequirePackage{changepage}

% Comandos de código (Orga1)
\newcommand{\codigo}[1]{\texttt{#1}}
\RequirePackage{multido}
\newcommand{\repetir}[2]{\multido{\i=0+1}{#2}{#1}}
\newcommand{\tabs}[1]{\repetir{\quad}{#1}}
\newcommand{\lineacod}[2]{\codigo{\null \tabs{#2} #1 \\}}

% ===========================================================

\let\oldtitle\title
\let\oldauthor\author
\let\olddate\date

\renewcommand\title[1]{\newcommand{\thetitle}{#1}}
\newcommand\subtitle[1]{\newcommand{\thesubtitle}{#1}}
\renewcommand\author[1]{\newcommand{\theauthor}{#1}}
\renewcommand\date[1]{\newcommand{\thedate}{#1}}

\oldtitle{\thetitle\ifdef{\thesubtitle}{ \\ {\normalsize \thesubtitle}}{}}
\oldauthor{\theauthor}
\olddate{\thedate}

\newcommand\updatemetadata{
    \hypersetup{
        pdfauthor={\theauthor},
        pdftitle={\thetitle{ - }\thesubtitle},
        pdfsubject={\thetitle{ - }\thesubtitle},
    }
}

% Enunciado
\newenvironment{enunciado}[1][]
    {\begin{rmfamily}}
    {\end{rmfamily}}
