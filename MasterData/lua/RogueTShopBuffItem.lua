function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_id, _selectID)
    id = _id
    local cfg = Cfgs.CfgRogueTBuff:GetByID(id)
    -- bg 
    local bgName = "b_" .. cfg.quality
    ResUtil.RogueBuff:Load(iconBg, bgName)
    -- icon 
    ResUtil.RogueBuff:Load(icon, cfg.icon)
    -- name 
    CSAPI.SetText(txtName, cfg.name)
    -- 
    CSAPI.SetGOActive(colorful, cfg.quality >= 6)
    -- star
    star = cfg.star or 0
    for k = 1, 3 do
        CSAPI.SetGOActive(this["star" .. k], star >= k)
    end
    -- select 
    CSAPI.SetGOActive(select, _selectID == id)
    --
    CSAPI.SetGOActive(colorful_shop, cfg.quality >= 6)
    --
    if (starEffect) then
        CSAPI.RemoveGO(starEffect.gameObject)
        starEffect = nil
    end
end

function SetUPAnim()
    local obj = this["star" .. star]
    if (obj and obj.activeSelf) then
        CSAPI.CreateGOAsync("UIs/RogueT/RogueTShopBuff_Star", 0, 0, 0, obj, function(obj)
            starEffect = obj
        end)
    end
end

function OnClick()
    if (cb) then
        cb(id)
    end
end
