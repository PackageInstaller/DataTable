function Awake()
    SetSelect(false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    local scale = b and 1 or 0.58
    CSAPI.SetScale(img1,scale,scale,scale)
    CSAPI.SetScale(img2,scale,scale,scale)
end

function Refresh(_data)
    data = _data
    if data then
        isOpen = data:IsOpen()
        SetIcon()
        SetLock(isOpen)
    end
end

function SetIcon()
    CSAPI.LoadImg(img2,"UIs/DungeonActivity2/btn_03_0" .. index .. ".png",true,nil,true)
end

function SetLock(b)
    CSAPI.SetGOActive(lockImg,not b)
end

function GetCfgs()
    if data and cfgDungeons == nil then
        cfgDungeons = data:GetDungeonCfgs()
    end
    return cfgDungeons
end

function GetCfg(_index)
    _index = _index or 1
    if data and cfgDungeons == nil then
        cfgDungeons = data:GetDungeonCfgs()
    end
    return cfgDungeons and cfgDungeons[_index]
end

function OnClick()
    if cb then
        cb(this)
    end
end

function ShowSelAnim(b)
    AnimScaleTo(img1,b)
    AnimScaleTo(img2,b)
end

-- 缩放动画
function AnimScaleTo(go, isSel, cb)
    local scale = isSel and 1 or 0.58
    CSAPI.SetUIScaleTo(go, nil, scale, scale, scale, cb, 0.2)
end