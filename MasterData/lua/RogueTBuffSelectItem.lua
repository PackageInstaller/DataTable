function SetIndex(_index)
    index = _index
end
function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_id, _curIndex)
    id = _id
    local cfg = Cfgs.CfgRogueTBuff:GetByID(id)
    -- bg 
    local bgName = "b_" .. cfg.quality
    ResUtil.RogueBuff:Load(iconBg, bgName)
    -- icon 
    ResUtil.RogueBuff:Load(icon, cfg.icon)
    -- name 
    CSAPI.SetText(txtName, cfg.name)
    -- desc 
    CSAPI.SetText(txtDesc, cfg.desc)
    -- 
    CSAPI.SetGOActive(colorful, cfg.quality >= 6)
    -- star
    local star = cfg.star or 0
    for k = 1, 3 do
        CSAPI.SetGOActive(this["star" .. k], star >= k)
    end
    -- select 
    CSAPI.SetGOActive(select, _curIndex == index)
end

function Select(b) 
    CSAPI.SetGOActive(select, b)
end

function OnClick()
    if (cb) then
        cb(index)
    end
end
