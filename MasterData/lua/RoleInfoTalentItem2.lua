isSelect = false

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh2(cfg)
    ResUtil.RoleTalent:Load(icon, cfg.icon)
    CSAPI.SetGOActive(objLock, false)
    CSAPI.SetGOActive(select2, false)
    CSAPI.SetGOActive(lv, false)
    SetSelect(false)
    CSAPI.SetGOActive(select2Bg, false)
end

-- {index = , id = , had = , use = }  --had是否已解锁  use是否已装载
function Refresh(_data, _curIndex)
    data = _data
    -- icon
    CSAPI.SetGOActive(icon, data.had)
    -- lock
    CSAPI.SetGOActive(objLock, not data.had)
    -- select2
    CSAPI.SetGOActive(select2Bg, data.had)
    -- tick
    CSAPI.SetGOActive(select2, data.use)
    -- txt 
    if (data.had) then
        -- icon
        local cfg = Cfgs.CfgSubTalentSkill:GetByID(data.id)
        ResUtil.RoleTalent:Load(icon, cfg.icon, true)
        -- lv
        -- local maxLv = 1
        -- if (cfg.group) then
        --     local _cfgs = Cfgs.CfgSubTalentSkill:GetGroup(cfg.group)
        --     maxLv = _cfgs[#_cfgs].lv
        -- end
        -- CSAPI.SetText(txtLv, string.format("<color=#929296>LV.</color>%s/%s", cfg.lv, maxLv))

		-- lv 
		CSAPI.SetText(txtLv2, cfg.lv .. "")
    else
        LanguageMgr:SetText(txtLock, 5008, data.index)
    end
    -- select
    SetSelect(index == _curIndex)
end

function SetSelect(b)
    isSelect = b
    CSAPI.SetGOActive(select, isSelect)
end

-- 安装或者卸载
function OnClickSelect2()
    if(not data.had) then 
        return 
    end 
    if (cb) then
        cb(index, true)
    end
end

function OnClick()
    if (cb) then
        cb(index)
    end
end
