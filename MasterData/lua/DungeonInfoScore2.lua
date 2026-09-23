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
        CSAPI.SetText(txtScore2,cfg.point .. "")
    end
end

function SetScore(num1,num2)
    CSAPI.SetText(txtScore,num1 .. "")
    -- CSAPI.SetText(txtScore2,num2 .. "")
end
