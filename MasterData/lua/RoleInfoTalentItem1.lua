-- 副天赋，当前使用
function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh2(cfg)
    ResUtil.RoleTalent:Load(icon, cfg.icon)
    CSAPI.SetGOActive(lv, false)
    CSAPI.SetGOActive(objLock, false)
    CSAPI.SetGOActive(objAdd, false)
    SetSelect(false)
end

function Refresh(_data)
    data = _data
    if (data.isOpen and data.id) then
        local cfg = Cfgs.CfgSubTalentSkill:GetByID(data.id)
        ResUtil.RoleTalent:Load(icon, cfg.icon)

		CSAPI.SetText(txtLv2, cfg.lv .. "")
    end
    CSAPI.SetGOActive(icon, data.isOpen and data.id ~= nil)
    CSAPI.SetGOActive(objAdd, data.isOpen and data.id == nil)
    CSAPI.SetGOActive(objLock, not data.isOpen)
    -- select
    SetSelect(false)
end

function SetSelect(b)
    CSAPI.SetGOActive(select, b)
end

function OnClick()
    if (cb) then
        cb(index)
    end
end
