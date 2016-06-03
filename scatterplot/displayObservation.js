function displayObservation(obs)
{

    var el = document.getElementById('observation');
    
    var tbl =  '<table>' +
       '<tr><th>Type</th><td>' + obs.type + '</td></tr>' +
       '<tr><th>MPG</th><td>' + obs.mpg + '</td></tr>' +
       '<tr><th>Weight</th><td>' + obs.wt + '</td></tr>' +
	'</table>';

     el.innerHTML = tbl;
}