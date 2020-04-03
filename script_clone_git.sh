#!/bin/bash

#id do usuario
USUARIO="rbmarquez"

# Pegar o numero de Pagina
#NumPag = `curl -H "Authorization: token  e5c2d674cac7d3334f3734adad213105b08793c4" -s https://api.github.com/users/${USUARIo} | jq . '.public_repos' `
#for pag in {1..${NumPag}}; do 
for pag in {1..40}; do 
	# pega json que contem todos os repositorios e extrai as URLs
	LISTA_URL_CLONES=`curl --silent https://api.github.com/users/${USUARIO}/repos?page=${pag} -q | grep "\"clone_url\"" | awk -F': "' '{print $2}' | sed -e 's/",//g'`

	#para cada url faz um 'git clone'
	for URL in $LISTA_URL_CLONES; do
		echo "====>> clonando: " ${URL}
		git clone ${URL}
	done
	echo "counter: $pag"
done;
