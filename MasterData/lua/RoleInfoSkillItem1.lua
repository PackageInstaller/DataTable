local clickImg = nil;
function Awake()
    clickImg = ComUtil.GetCom(clickNode, "Image")
end

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function ActiveClick(canClick)
    clickImg.raycastTarget = canClick == true;
end

function Refresh(_cfgID)
    cfgID = _cfgID
    local cfg = Cfgs.skill:GetByID(cfgID)
    local cfgDesc = Cfgs.CfgSkillDesc:GetByID(cfgID)
    if (cfgDesc == nil) then
        LogError("技能描述表无id：" .. cfgID)
        return
    end
    local iconName = string.format("icon_1_0%s", cfgDesc.icon_bg_type)
    -- bg
    ResUtil.SkillBg:Load(clickNode, iconName)
    -- icon
    ResUtil.IconSkill:Load(icon, cfgDesc.icon)
    if (cfg.main_type == SkillMainType.CardTalent) then
        CSAPI.SetGOActive(txtPassive, true)
        CSAPI.SetText(txtCost1, "")
        CSAPI.SetText(txtCost2, "")
    else
        CSAPI.SetGOActive(txtPassive, false)
        -- np
        local str, num = RoleTool.GetNPStr(cfg)
        CSAPI.SetText(txtCost1, str)
        CSAPI.SetText(txtCost2, num .. "")
    end
    -- select
    SetSelect(false)
    -- lv 
    CSAPI.SetText(txtLv2, cfg.lv .. "")
end

function SetSelect(b)
    CSAPI.SetGOActive(select, b)
end

function OnClick()
    if (cb) then
        cb(index)
    end
end
