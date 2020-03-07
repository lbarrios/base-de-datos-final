#!/usr/bin/bash

markdown_py -q -o "html5" -x markdown.extensions.toc \
-x markdown.extensions.tables -x markdown.extensions.fenced_code \
-x markdown.extensions.codehilite -x pymdownx.mark \
todas_las_preguntas.md > todas_las_preguntas.pre.html

echo "
<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
    <meta charset=\"utf-8\">
    <link rel=\"stylesheet\" type=\"text/css\" href=\"../resumen/codehilite.css\">
    <!--<link rel=\"stylesheet\" type=\"text/css\" href=\"../resumen/github-markdown.css\">-->
    <link href=\"https://fonts.googleapis.com/css?family=Roboto&display=swap\" rel=\"stylesheet\">
    <style>
        .markdown-body {
        	font-family: 'Roboto';
            box-sizing: border-box;
            min-width: 200px;
            max-width: 980px;
            margin: 0 auto;
            padding: 45px;
        }

        @media (max-width: 767px) {
            .markdown-body {
                padding: 15px;
            }
        }
    </style>
</head>

<body>
    <article class="markdown-body">" > todas_las_preguntas.html

cat todas_las_preguntas.pre.html >> todas_las_preguntas.html

echo "</article>
</body></html>" >> todas_las_preguntas.html

rm -f todas_las_preguntas.pre.html