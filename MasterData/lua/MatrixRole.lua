-- 驻员item
function Awake()
    CSAPI.SetGOActive(plObj, false)
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, isRoledata)
    if (isRoledata) then
        Refresh1(_data)
    else
        Refresh2(_data)
    end
end

-- 
function Refresh1(curData)
    SetIcon(curData:GetBaseIcon())
end

-- {data = ,curLv = ,openLv=}  
function Refresh2(_data)
    cRoleID = _data.data
    curLv = _data.curLv
    openLv = _data.openLv
    curData = nil

    CSAPI.SetGOActive(icon, cRoleID ~= nil)
    CSAPI.SetGOActive(nilObj, cRoleID == nil)

    if (cRoleID) then
        curData = CRoleMgr:GetData(cRoleID)
        SetIcon(curData:GetBaseIcon())
        InitPl()
    else
        local type = MatrixMgr:GetPLType(curLv, openLv)
        RefreshNil(type)
    end

    InitPl()
    CSAPI.SetGOActive(plObj, curData ~= nil)

    -- 红点
    SetRed()
end

function SetRed()
    local isRed = false
    if (curData ~= nil and curData:IsInBuilding()) then
        isRed = curData:CheckIsRed()
    end
    UIUtil:SetRedPoint(clickNode, isRed, 73, 73, 0)
end

-- 无数据时 type nil:隐藏 1：待添加  2：锁  3：不开放 
function RefreshNil(type)
    if (type) then
        local iconName = ""
        if (type == 1) then
            iconName = "copy3"
        elseif (type == 2) then
            iconName = "copy4"
        else
            iconName = "copy5"
        end
        ResUtil.CRoleItem_BG:Load(nilObj, iconName)
    end
end

function SetIcon(iconName)
    CSAPI.SetGOActive(icon, iconName ~= nil)
    if (iconName) then
        ResUtil.RoleCard:Load(icon, iconName)
    end
end

function OnClick()
    if (curLv and curLv >= openLv and cb) then
        cb()
    end
end

function SetIcon_pet(iconName)
    CSAPI.SetGOActive(icon, iconName ~= nil)
    if (iconName) then
        ResUtil.PetHead:Load(icon, iconName)
    end
end

-- =====================================pl=========================================================
function InitPl()
    if (matrixPL == nil) then
        matrixPL = MatrixPL.New()
    end
    matrixPL:Init(curData, face, txtPL)
end

function Update()
    if (matrixPL) then
        matrixPL:Update()
    end
end

function HideTxt(b)
    CSAPI.SetGOActive(txtPL, b)
end
