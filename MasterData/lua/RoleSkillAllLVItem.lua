function Awake()
    cg_go = ComUtil.GetCom(gameObject, "CanvasGroup")
end
function SetIndex(_index)
    index = _index
end
function Refresh(_cfg, _elseData)
    cfg = _cfg
    id = _elseData[1]
    isTalent = _elseData[2]
    isEnd = _elseData[3] == index
    curLv = _elseData[4]
    isCurLv = id == cfg.id and true or false

    local cfgDesc = nil
    if (isTalent) then
        cfgDesc = cfg
    else
        cfgDesc = Cfgs.CfgSkillDesc:GetByID(cfg.id)
    end
    -- lv 
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
    local lvStr = lvStr .. cfg.lv
    -- if(isCurLv) then
    -- 	local s = LanguageMgr:GetByID(4039) .. " LV." .. cfg.lv
    -- 	lvStr = StringUtil:SetByColor(s, "ffc146")
    -- else
    -- 	lvStr = "LV." .. cfg.lv
    -- end
    -- desc
    local desc1 = cfgDesc.desc
    if (desc1 and desc1 ~= "") then
        desc1 = StringUtil:SkillDescFormat(desc1)
    end
    CSAPI.SetText(txt_desc1, lvStr .. ": " .. desc1)
    -- desc2 
    local desc2 = ""
    if (not isTalent) then
        desc2 = cfgDesc.desc1
    end
    local _desc2, _cfgs2 = "", {}
    if (desc2 and desc2 ~= "") then
        _desc2, _cfgs2 = StringUtil:SkillDescFormat(desc2)
    end
    CSAPI.SetGOActive(overload, _desc2 ~= "")
    CSAPI.SetGOActive(txt_desc2, _desc2 ~= "")
    CSAPI.SetText(txt_desc2, _desc2)
    -- line
    -- CSAPI.SetGOActive(line, not isEnd)
    -- 
    CSAPI.SetGOActive(topLine, index ~= 1)
    --
    cg_go.alpha = index <= curLv and 1 or 0.4
end

