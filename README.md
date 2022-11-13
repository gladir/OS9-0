# OS9-0
Clone des comamndes de OS-9 écrit en Pascal

![image](https://user-images.githubusercontent.com/11842176/160869302-3bc16cf6-ef68-4752-83a9-822abcf0ba89.png)

<h2>Liste des fichiers</h2>

Voici la liste des différents fichiers proposés dans Corail :

<table>
		<tr>
			<th>Nom</th>
			<th>Description</th>	
		</tr>
      <tr>
			<td><b>BUILD.PAS</b></td>
			<td>Cette commande permet de construire un fichier texte. Cette commande est inspiré de la commande <a href="https://www.gladir.com/OS/OS9/build.htm">BUILD</a> de <a href="https://www.gladir.com/OS/OS9/intro.htm">OS-9</a>.</td>
		</tr>		
	   <tr>
			<td><b>CHD.PAS</b></td>
			<td>Cette commande permet de fixer ou demander le répertoire courant.</td>
		</tr>	
	   <tr>
			<td><b>DELDIR.PAS</b></td>
			<td>Cette commande permet de supprimer un répertoire vide.</td>
		</tr>
     <tr>
			<td><b>DISPLAY.PAS</b></td>
			<td>Cette commande permet d'afficher un message encodée en hexadécimal.</td>
		</tr>
	    <tr>
			<td><b>ERROR.PAS</b></td>
			<td>Cette commande permet d'afficher la description de l'erreur.</td>
		</tr>
	   <tr>
			<td><b>MAKDIR.PAS</b></td>
			<td>Cette commande permet de créer un répertoire. Cette commande est inspiré du <a href="https://www.gladir.com/OS/OS9/intro.htm">OS-9</a>.</td>
		</tr>	
    <tr>
			<td><b>OS9.PAS</b></td>
			<td>Cette commande permet de lancer l'interpréteur de commande <a href="https://www.gladir.com/OS/OS9/intro.htm">OS-9</a> des Color Computer de Tandy Radio Shack.</td>
		</tr>
	   <tr>
			<td><b>PXD.PAS</b></td>
			<td>Cette commande permet d'afficher le répertoire d'exécution.</td>
		</tr>
    <tr>
			<td><b>SETIME.PAS</b></td>
			<td>Cette commande permet de fixer l'horloge du système d'exploitation.</td>
		</tr>	
	</table>
	

<h2>Compilation</h2>
	
Les fichiers Pascal n'ont aucune dépendances, il suffit de télécharger le fichier désiré et de le compiler avec Free Pascal avec la syntaxe de commande  :

<pre><b>fpc</b> <i>LEFICHIER.PAS</i></pre>
	
Sinon, vous pouvez également le compiler avec le Turbo Pascal à l'aide de la syntaxe de commande suivante :	

<pre><b>tpc</b> <i>LEFICHIER.PAS</i></pre>
	
Par exemple, si vous voulez compiler OS9.PAS, vous devrez tapez la commande suivante :

<pre><b>fpc</b> OS9.PAS</pre>
	
<h2>Licence</h2>
<ul>
 <li>Le code source est publié sous la licence <a href="https://github.com/gladir/OS9-0/blob/master/LICENSE">MIT</a>.</li>
 <li>Le paquet original est publié sous la licence <a href="https://github.com/gladir/OS9-0/blob/master/LICENSE">MIT</a>.</li>
</ul>
