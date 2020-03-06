#!/usr/bin/env bash

rm -f 999-todo_junto.md
echo -e "[TOC]\n" > 999-todo_junto.md
cat 01-introduccion.md <(echo) <(echo) >> 999-todo_junto.md
cat 02-procesos-y-api.md <(echo) <(echo) >> 999-todo_junto.md
cat 03-scheduling.md <(echo) <(echo) >> 999-todo_junto.md
cat 04-sincronizacion-entre-procesos.md <(echo) <(echo) >> 999-todo_junto.md
cat 05-sincronizacion-ezequiel.md <(echo) <(echo) >> 999-todo_junto.md
cat 07-memoria.md <(echo) <(echo) >> 999-todo_junto.md
cat 08-administracion-de-entrada-salida.md <(echo) <(echo) >> 999-todo_junto.md
cat 09-sistemas-de-archivos.md <(echo) <(echo) >> 999-todo_junto.md
cat 10-sistemas-distribuidos.md <(echo) <(echo) >> 999-todo_junto.md
cat 11-proteccion-y-seguridad.md <(echo) <(echo) >> 999-todo_junto.md
cat 12-sistemas-distribuidos.md <(echo) <(echo) >> 999-todo_junto.md
cat 13-microkernels-y-virtualizacion.md <(echo) <(echo) >> 999-todo_junto.md

markdown_py -q -o "html5" -x markdown.extensions.toc \
-x markdown.extensions.tables -x markdown.extensions.fenced_code \
-x markdown.extensions.codehilite -x pymdownx.mark \
999-todo_junto.md > 999-todo_junto.pre.html
#pygmentize -S default -f html > codehilite.css

echo "
<!DOCTYPE html>
<html lang="en">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="./codehilite.css">
	<link rel="stylesheet" type="text/css" href="./github-markdown.css">
	<style>
		.markdown-body {
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
	<article class="markdown-body">" > 999-todo_junto.html

cat 999-todo_junto.pre.html >> 999-todo_junto.html

echo "</article>
</body></html>" >> 999-todo_junto.html

rm -f 999-todo_junto.md 999-todo_junto.pre.html