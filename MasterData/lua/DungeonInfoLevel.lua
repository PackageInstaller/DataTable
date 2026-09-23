local cfg = nil
local data = nil
local sectionData = nil

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        local str = cfg.lvTips ~= nil and cfg.lvTips or "— —"
        str = cfg.type == eDuplicateType.Teaching and "— —" or str -- 教程不显示lv  
        CSAPI.SetText(txtLevel, str);
    end
end

function SetText(str)
    CSAPI.SetGOActive(txtLevel,false)
    CSAPI.SetGOActive(txtLevel2,true)
    CSAPI.SetText(txtLevel2, str);
end

function SetText2(str)
    CSAPI.SetText(txtLevel, str);
end

function SetTitle(str)
    CSAPI.SetText(txt_topTips,str)
end