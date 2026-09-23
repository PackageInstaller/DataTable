-- {data = , curlv= , openlv = }  data=> 服务器
local isCalTime = false
local len = 0
local timer = 0

-- function Awake()
-- 	p_slider = ComUtil.GetCom(Slider, "Slider")
-- end
function Refresh(_data, _matrixData)
    cRoleID = _data.data
    curLv = _data.curLv
    openLv = _data.openLv
    oldTime = _matrixData:GetOldTime()
    roomID = _matrixData:GetId()
    cRoleData = cRoleID and CRoleMgr:GetData(cRoleID) or nil

    local isEmpty = cRoleData == nil and true or false
    CSAPI.SetGOActive(empty, isEmpty)
    CSAPI.SetGOActive(entity, not isEmpty)

    local lockStr = ""
    local abilityName = ""
    local lv = 0
    local iconName = nil
    local isLock = false
    if (not isEmpty) then
        cfg = cRoleData:GetAbilityCurCfg()
        abilityName = cfg.remarks
        lv = cRoleData:GetLv() -- cfg.index
        iconName = cRoleData:GetIcon()
        -- iconName = StringUtil:StrReplace(_iconName, "_shead", "_fhead")
    else
        if (openLv == -1) then
            lockStr = LanguageMgr:GetByID(10062)
        elseif (curLv >= openLv) then
            -- 闲置中
            lockStr = LanguageMgr:GetByID(10063)
        else
            -- 锁住
            lockStr = LanguageMgr:GetByID(10040, openLv)
            isLock = true
        end
    end
    CSAPI.SetGOActive(imgLock, isLock)
    SetLockStr(lockStr)
    SetIcon(iconName)
    SetAbility(abilityName)
    SetLv(lv)

    InitPl() -- pl face

    -- CanvasGroup
    if (bgCanvasGroup == nil) then
        bgCanvasGroup = ComUtil.GetCom(bg, "CanvasGroup")
    end
    bgCanvasGroup.alpha = isLock and 0.3 or 1

    -- 红点
    SetRed()
end

function SetRed()
    local isRed = false
    if (cRoleData ~= nil) then
        isRed = cRoleData:CheckIsRed()
    end
    UIUtil:SetRedPoint(node, isRed, 176, 48, 0)
end

function SetIcon(iconName)
    CSAPI.SetGOActive(icon, iconName ~= nil)
    if (iconName ~= nil) then
        ResUtil.Card:Load(icon, iconName)
    end
    -- CSAPI.SetAnchor(icon, - 37, - 25)
end

function SetAbility(str)
    CSAPI.SetText(txtAbility, str)
end

function SetLv(lv)
    CSAPI.SetGOActive(imgLove, lv ~= 0)
    if (lv ~= 0) then
        CSAPI.SetText(txtLove, lv .. "")
    end
end

function SetLockStr(str)
    CSAPI.SetText(txtLock, str)
end

-- 点击空置
function ClickItemCB()
    -- CSAPI.OpenView("MatrixRoleSet", _matrixData)
    CSAPI.OpenView("DormSetRoleList", {roomID})
end

-- =====================================pl=========================================================
function InitPl()
    if (matrixPL == nil) then
        matrixPL = MatrixPL.New()
    end
    matrixPL:Init(cRoleData, face, txtPL)
end

function Update()
    if (matrixPL) then
        matrixPL:Update()
    end
end

-- function InitPl()
-- 	if(cRoleData) then
-- 		InitPLFace(true, cRoleData, oldTime)
-- 		isCalTime = true
-- 	else
-- 		isCalTime = false
-- 	end
-- end
-- function InitPLFace(b, cRoleData, oldTime)
-- 	CSAPI.SetGOActive(plObj, b)
-- 	if(matrixPL == nil) then
-- 		matrixPL = MatrixPL.New()
-- 	end
-- 	if(b) then
-- 		matrixPL:InitTime(b, cRoleData:GetTF(), cRoleData:GetTriedValue(), oldTime, face, txtPL)
-- 	end
-- end
-- function Update()
-- 	if(isCalTime and matrixPL) then
-- 		matrixPL:Update()
-- 	end
-- end
