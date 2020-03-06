#!/usr/bin/env bash

rm -f 999-todo_junto.md
echo -e "[TOC]\n" > 999-todo_junto.md
cat 01-modeloRelacional.md <(echo) <(echo) >> 999-todo_junto.md
cat 02-algebraRelacional.md <(echo) <(echo) >> 999-todo_junto.md
cat 03-calculoRelacional.md <(echo) <(echo) >> 999-todo_junto.md
cat 04-expresividad.md <(echo) <(echo) >> 999-todo_junto.md
cat 05-normalizacion.md <(echo) <(echo) >> 999-todo_junto.md
cat 06-xml.md <(echo) <(echo) >> 999-todo_junto.md
cat 07-openData.md <(echo) <(echo) >> 999-todo_junto.md
cat 09-noSQL.md <(echo) <(echo) >> 999-todo_junto.md
cat 10-dataWarehousing.md <(echo) <(echo) >> 999-todo_junto.md
cat 14-schedules.md <(echo) <(echo) >> 999-todo_junto.md
cat 15-controlDeConcurrencia.md <(echo) <(echo) >> 999-todo_junto.md
cat 16-logging.md <(echo) <(echo) >> 999-todo_junto.md
cat 17-longDurationTransaction.md <(echo) <(echo) >> 999-todo_junto.md
cat 18-inMemoryDatabases.md <(echo) <(echo) >> 999-todo_junto.md
cat 19-distributedDB.md <(echo) <(echo) >> 999-todo_junto.md
cat 20-integracionDeDatos.md <(echo) <(echo) >> 999-todo_junto.md
cat 21-OBDA.md <(echo) <(echo) >> 999-todo_junto.md
cat 22-gobiernoYCalidadDeDatos.md <(echo) <(echo) >> 999-todo_junto.md
cat 23-claseAvanzadaDeDisenio.md <(echo) <(echo) >> 999-todo_junto.md
cat 24-dataMining.md <(echo) <(echo) >> 999-todo_junto.md

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