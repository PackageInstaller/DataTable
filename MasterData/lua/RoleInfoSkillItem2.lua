isSelect = false
id = nil 

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh2(cfg)
    id = cfg.id 
    local cfgDesc = Cfgs.CfgSkillDesc:GetByID(cfg.id)
    local isPassive = cfg.main_type == SkillMainType.CardTalent and true or false
    local iconName = isPassive and string.format("icon_3_0%s", cfgDesc.icon_bg_type) or
                         string.format("icon_2_0%s", cfgDesc.icon_bg_type)
    ResUtil.SkillBg:Load(clickNode, iconName)
    ResUtil.IconSkill:Load(icon, cfgDesc.icon)
    CSAPI.SetGOActive(lv, false)
    SetSelect()
end

function Refresh(_data, _curIndex)
    id = _data.id
    local cfg = Cfgs.skill:GetByID(_data.id)
    local cfgDesc = Cfgs.CfgSkillDesc:GetByID(_data.id)
    local isPassive = cfg.main_type == SkillMainType.CardTalent and true or false
    local iconName = isPassive and string.format("icon_3_0%s", cfgDesc.icon_bg_type) or
                         string.format("icon_2_0%s", cfgDesc.icon_bg_type)
    -- bg
    ResUtil.SkillBg:Load(clickNode, iconName)
    -- icon
    ResUtil.IconSkill:Load(icon, cfgDesc.icon)
    -- lv
    local maxLv = 1
    if (cfg.group) then
        local _cfgs = Cfgs.skill:GetGroup(cfg.group)
        maxLv = _cfgs[#_cfgs].lv
    end
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
    CSAPI.SetText(txtLv, string.format("<color=#929296>%s</color>%s/%s", lvStr,cfg.lv, maxLv))
    -- select
    SetSelect(index == _curIndex)
    --
    CSAPI.SetText(txtLv2, cfg.lv .. "")
end

function SetSelect(b)
    isSelect = b
    CSAPI.SetGOActive(select, isSelect)
end

function OnClick()
    if (cb) then
        cb(index)
    end
end
