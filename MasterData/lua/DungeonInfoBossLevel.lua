local cfg = nil
local data = nil
local sectionData = nil

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetLv()
    end
end

function SetLv()
    CSAPI.SetText(txtLv,cfg.lvTips and cfg.lvTips .. "" or "")
end