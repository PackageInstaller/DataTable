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
    local str = cfg.name:gsub("-","\u{3000}")
    CSAPI.SetText(txtTitle,str)
    CSAPI.SetText(txtStage,cfg.chapterID and cfg.chapterID .. "" or "")
end