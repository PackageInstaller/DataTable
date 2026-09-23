local cfg = nil
local data = nil
local sectionData = nil

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetDesc()
    end
end

function SetDesc()
    if cfg.introduction then
        CSAPI.SetText(txtDesc,cfg.introduction)
    end
end