local data = nil
local isHideNew = false

function Awake()
    SetSelect(false)
    InitAnim()
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb =_cb
end

function SetSelect(b)
    CSAPI.SetGOActive(selObj,b)
end

function Refresh(_data,_isHideNew)
    data = _data
    isHideNew = _isHideNew
    CSAPI.SetGOActive(icon,_data~=nil)
    CSAPI.SetGOActive(empty,_data==nil)
    if data then
        SetLock()
        SetIcon()
        SetNew()
    end
end

function SetIcon()
    local iconName = data:GetIcon()
    if iconName ~= nil and iconName~="" then
        ResUtil.Badge:Load(icon,iconName)
    end
end

function SetScale(scale1,scale2)
    scale1 = scale1 or 1
    scale2 = scale2 or 1
    CSAPI.SetScale(iconParent,scale1,scale1,scale1)
    CSAPI.SetScale(selObj,scale2,scale2,scale2)
end

function SetLock()
    CSAPI.SetGOAlpha(gameObject,data:IsGet() and 1 or 0.5)
end

function SetNew()
    if isHideNew then
        UIUtil:SetNewPoint(newParent, false)
        return
    end
    local newInfos = FileUtil.LoadByPath("Badge_new_info.txt") or {} -- 记录new
    if data and newInfos[data:GetID()] and newInfos[data:GetID()]==1 then
        CSAPI.SetGOActive(newParent,false)
        CSAPI.SetGOActive(newParent,true)
        UIUtil:SetNewPoint(newParent, true)
    else
        UIUtil:SetNewPoint(newParent, false)
    end
end

function GetData()
    return data
end

function OnClick()
    if not isHideNew then
        local newInfos = FileUtil.LoadByPath("Badge_new_info.txt") or {} -- 记录new
        if data and newInfos[data:GetID()] and newInfos[data:GetID()]==1 then
            UIUtil:SetNewPoint(newParent, false)
            newInfos[data:GetID()]= 0
            FileUtil.SaveToFile("Badge_new_info.txt",newInfos)
        end
    end
    if cb then
        cb(this)
    end
end

--------------------------------anim--------------------------------

function InitAnim()
    CSAPI.SetGOActive(changeAction1,false)
    CSAPI.SetGOActive(changeAction2,false)
end

function ShowEffect(go)
    CSAPI.SetGOActive(go,false)
    CSAPI.SetGOActive(go,true)
end

function PlayChangeAnim1()
    ShowEffect(changeAction1)
end

function PlayChangeAnim2()
    ShowEffect(changeAction2)
end