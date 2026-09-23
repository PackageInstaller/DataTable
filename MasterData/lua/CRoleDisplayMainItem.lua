local needToCheckMove = false
local timer = 0

function Awake()
    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(txtName1)
end
function Update()
    if (needToCheckMove and Time.time > timer) then
        luaTextMove:CheckMove(txtName1)
        needToCheckMove = false
    end
end

function SetIndex(_index)
    index = _index
end
function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_id, _data)
    id = _id
    data = _data

    -- lock
    isOpen, lockStr = data:CheckOpen()
    -- 
    CSAPI.SetGOActive(entity, id ~= 0)
    if (isOpen and (id == nil or id == 0)) then
        CSAPI.SetGOActive(empty, true)
    else
        CSAPI.SetGOActive(empty, false)
    end
    CSAPI.SetGOActive(lock, not isOpen)
    -- 
    if (isOpen) then
        if (id ~= 0) then
            SetEntity()
        end
    else
        CSAPI.SetText(txtLock, lockStr)
    end
    --
    SetLimitSkin()

end

function SetEntity()
    local cfg1 = Cfgs.CfgArchiveMultiPicture:GetByID(id)
    if (cfg1) then
        -- icon
        ResUtil.MultBoardSmall:Load(icon, cfg1.set_icon)
        local typeName = CRoleDisplayMgr:GetTypeSName(cfg1.nType, cfg1.theme_type)
        SetName(cfg1.sName, typeName)
    else
        local cfg2 = Cfgs.character:GetByID(id)
        -- icon
        ResUtil.CardIcon:Load(icon, cfg2.Card_head)
        SetName(cfg2.key, cfg2.desc)
    end
    --  
    CSAPI.SetGOActive(btnRemove, CRoleDisplayMgr:GetCopyUsing() ~= data:GetIndex())
end

function SetName(str1, str2)
    needToCheckMove = false
    CSAPI.SetText(txtName1, str1)
    timer = Time.time + 0.1
    needToCheckMove = true
    CSAPI.SetText(txtName2, str2)
end

function OnClick()
    if (isOpen) then
        cb(index, 1)
    end
end

function OnClickRemove()
    cb(index, 2)
end

function SetLimitSkin()
    local isLimitSkin = data:CheckLimitSkin(index)
    UIUtil:SetRedPoint2("Common/Red4", clickNode, isLimitSkin, -82.4, 161, 0)
end
