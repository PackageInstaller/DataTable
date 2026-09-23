function Refresh(cfg,_elseData)
    this.data=cfg;
    this.elseData=_elseData;
    --初始化icon
    -- ResUtil.IconGoods:Load(slotGrid,"slotC");
    ResUtil.EquipSkillIcon:Load(icon,cfg.icon);
    --初始化描述
    local skillCfgs=Cfgs.CfgEquipSkill:GetGroup(cfg.id)
    CSAPI.SetText(txt_effect,skillCfgs.skillName);
    CSAPI.SetText(txt_name,cfg.name);
    CSAPI.SetText(txt_effect,skillCfgs[1].sSkillType);
    CSAPI.SetText(txt_desc,cfg.dec);
    if _elseData then
        CSAPI.SetImgColorByCode(imgDetails,_elseData.sSKId==cfg.id and "ffc146" or "ffffff");
    end
end

function SetIndex(i)
    this.index=i;
    if i==1 then
        CSAPI.SetGOActive(line,false);
    end
end

function SetClickCB(_cb)
    this.cb=_cb;
end

function OnClickDetail()
    if this.cb then
        this.cb(this);
    end
end