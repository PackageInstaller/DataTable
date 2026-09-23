
function SetPos(y)
    CSAPI.SetAnchor(gameObject,0,y)
end

function SetSelect(b)
    CSAPI.SetGOActive(nol,not b)
    CSAPI.SetGOActive(sel,b)
end