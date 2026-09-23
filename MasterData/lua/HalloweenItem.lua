local size = nil
local cfg = nil
local isStop = true
local posX,posY = 0,0

function Refresh(_data)
    isStop = true
    data = _data
    if data then
        cfg = Cfgs.CfgHalloweenItem:GetByID(data.id)
        if cfg then
            SetIcon()
            SetEffect()
        end
        isStop = false
    end
end

function SetIcon()
    if cfg.icon and cfg.icon~="" then
        ResUtil.Halloween:Load(icon,cfg.icon)
    end
end

function SetEffect()
    CSAPI.SetGOActive(iconParent,cfg.type == HalloweenItemType.Score)
    CSAPI.SetGOActive(effectObj,cfg.type ~= HalloweenItemType.Score)
    CSAPI.SetGOActive(reward,cfg.type == HalloweenItemType.Time)
    CSAPI.SetGOActive(bomb,cfg.type == HalloweenItemType.Trap)
end

function UpdateMove()
    posX,posY = CSAPI.GetAnchor(gameObject)
    CSAPI.SetAnchor(gameObject,posX,posY - GetSpeed())
end

function GetSpeed()
    return data.speed * Time.deltaTime
end

function GetHeight()
    if size == nil then
        size = CSAPI.GetRTSize(gameObject)
    end
    return size[1]
end

function GetWidth()
    if size == nil then
        size = CSAPI.GetRTSize(gameObject)
    end
    return size[0]
end

function GetPosX()
    return posX
end

function GetPosY()
    return posY
end

function GetType()
    return cfg.type
end

function GetID()
    return cfg.id
end

function GetEffectNum()
    return cfg.effect
end