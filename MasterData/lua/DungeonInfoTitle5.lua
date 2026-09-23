local cfg = nil
local data = nil
local sectionData = nil

function Refresh(tab)
    cfg = tab.cfg
    if cfg then
        CSAPI.SetText(txtName, cfg.name)
    end
end

function SetName(str)
    CSAPI.SetText(txtName,str)
end