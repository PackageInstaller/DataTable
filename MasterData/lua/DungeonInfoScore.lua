local cfg = nil
local data = nil
local sectionData = nil

function Awake()
    CSAPI.SetGOActive(tipsObj, false)
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        
    end
end

function SetText(str1,str2)
    CSAPI.SetText(txtScore,str1 or "0")
    CSAPI.SetText(txtMaxScore,str2 or "0")
end

function OnClickQuestion()
    CSAPI.SetGOActive(tipsObj,true)
end


function OnClickBack()
    CSAPI.SetGOActive(tipsObj,false)
end