local cfg = nil
local data = nil
local sectionData = nil

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetName()
    end
end

function SetName()
    if cfg.name then
        CSAPI.SetText(txtTitle,cfg.name)
    end
end