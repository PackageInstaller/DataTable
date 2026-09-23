local data = nil
local typeDatas = nil
local layout = nil
local selIndex = 1
local lastType = 0

function Awake()
    InitAnim()
end

function SetSaveClickCB(_cb)
    saveCb = _cb
end

function SetBtnClickCB(_cb)
    btnCb = _cb
end

function SetClickCB(_cb)
    cb = _cb
end

function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/Badge/BadgeGridItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = typeDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.SetScale(0.7, 0.9)
        lua.Refresh(_data)
        lua.SetSelect(index == selIndex)
    end
end

function OnItemClickCB(item)
    if item.index == selIndex then
        return
    end
    local lua = layout:GetItemLua(selIndex)
    if lua then
        lua.SetSelect(false)
    end
    item.SetSelect(true)
    selIndex = item.index
    data = item.GetData()
    SetText()
    SetIcon()
    -- SetBtnState(data)
    if cb then
        cb(data)
    end
end

function Refresh(_data)
    data = _data
    CSAPI.SetGOActive(selObj, data ~= nil)
    CSAPI.SetGOActive(emptyObj, data == nil)
    if data then
        SetText()
        SetIcon()
        SetCurrIndex()
        SetType()       
    else
        lastType = nil
        ShowEffect(emptyAction)
    end
    -- SetBtnState()
end

function SetText()
    CSAPI.SetText(txtName, data:GetName())
    CSAPI.SetText(txtTag, data:GetTag())
    CSAPI.SetText(txtDesc, data:GetDesc())
    local str = data:IsGet() and LanguageMgr:GetByID(48004, data:GetTimeStr()) or ""
    CSAPI.SetText(txtTime, str)
end

function SetIcon()
    local iconName = data:GetIcon()
    if iconName ~= nil and iconName ~= "" then
        ResUtil.Badge:Load(icon, iconName, true)
        CSAPI.SetScale(icon, 0.7, 0.7, 1)
    end
end

function SetType()
    CSAPI.SetGOActive(typeObj, data:GetType() ~= nil)
    if data:GetType() then
        CSAPI.SetRTSize(descObj, 555, 296)
        if lastType ~= data:GetType() then
            layout:IEShowList(#typeDatas, nil, selIndex)
            lastType = data:GetType()
        else
            layout:UpdateList()
        end
    else
        lastType = nil
        CSAPI.SetRTSize(descObj, 555, 508)
    end
end

function SetCurrIndex()
    typeDatas = BadgeMgr:GetArrByType(data:GetType())
    if typeDatas and #typeDatas > 0  then
        for i, v in ipairs(typeDatas) do
            if data:GetID() == v:GetID() then
                selIndex = i
                data = v
                break
            end
        end
    end
end

function SetBtnState(_data,_data1,_data2)
    if _data then
        CSAPI.SetGOAlpha(btnDel, not _data:IsGet() and 0.5 or 1)
    else
        CSAPI.SetGOAlpha(btnDel, 0.5)
    end
    local str = LanguageMgr:GetByID(4020)
    local str2 = LanguageMgr:GetByType(4020, 4)
    if not _data or (BadgeMgr:IsEquip(_data:GetID()) and (_data2 and _data2:GetID() == _data:GetID())) then
        str = LanguageMgr:GetByID(48002)
        str2 = LanguageMgr:GetByType(48002, 4)
    end
    CSAPI.SetText(txtDel1, str)
    CSAPI.SetText(txtDel2, str2)

    CSAPI.SetGOAlpha(btnSave,BadgeMgr:IsChange() and 1 or 0.5)
end

function OnClickDel()
    if btnCb then
        btnCb(data)
    end
end

function OnClickSave()
    if saveCb then
        saveCb(this)
    end
end

--------------------------------anim--------------------------------

function InitAnim()
    CSAPI.SetGOActive(emptyAction,false)
    CSAPI.SetGOActive(selObjAction,false)
end

function ShowEffect(go)
    CSAPI.SetGOActive(go,false)
    CSAPI.SetGOActive(go,true)
end

function ShowSelAnim()
    ShowEffect(selObjAction)
end

