function showPackageDetails(name)
{
 //   alert("package name " + name + " " + pkgDescriptions[name].Author);

    var desc = pkgDescriptions[name];
    
    var el = document.getElementById('pkgName');
    el.innerHTML = name;
    
    var its = ['Author', 'Description', 'Imports', 'Depends'];
    for(var i = 0; i < its.length; i++) {
	el = document.getElementById('pkg' + its[i]);	
	el.innerHTML = desc ? desc[its[i]] : "";
    }
}