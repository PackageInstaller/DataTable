function Awake()
    CloseRank(true)
end

function SetRank(num)
    CSAPI.SetText(txtRank,num.."")
end

function CloseRank(b)
    -- CSAPI.SetGOActive(txt_rank2,not b)
    CSAPI.SetGOActive(txtRank,not b)
    CSAPI.SetGOActive(txt_rank3,b)
end

function OnClickRank()
    
end