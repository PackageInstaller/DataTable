local info = nil
local isLock= false
local goNames = {"bg2","eff1","eff2","eff3","eff4"}

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    info = _data
    if info then
        SetFrame()
        SetIcon()
        SetEffect()
        SetLock()
    end
end

function SetFrame()
    if info.frame then
        CSAPI.SetGOActive(frame,true)
        local code = nil
        for i = 1, 5 do
            code = info.frame[i]
            if code and goNames[i] then
                CSAPI.SetImgColorByCode(this[goNames[i]].gameObject,code)
            end
        end
    else
        CSAPI.SetGOActive(frame,false)
    end
end

function SetIcon()
    if info.icon then
        ResUtil.Bite:Load(icon,info.icon)
    end
end

function SetEffect()
    if effectParent and effectParent.transform.childCount > 0 then
        for i = 0, effectParent.transform.childCount - 1 do
            CSAPI.SetGOActive(effectParent.transform:GetChild(i).gameObject, false)
        end
    end
    if info.effect and this[info.effect] then
        CSAPI.SetGOActive(this[info.effect].gameObject, true)
    end
end

function SetLock()
    isLock= false
    if info.item_id then
        isLock = BagMgr:GetCount(info.item_id) <= 0
    end
    CSAPI.SetGOAlpha(node,isLock and 0.7 or 1)
    CSAPI.SetGOActive(lockObj,isLock)
end

function OnClick()
    if isLock then
        return
    end
    if cb then
        cb(this)
    end
end