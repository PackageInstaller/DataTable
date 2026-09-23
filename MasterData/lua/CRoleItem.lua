local needToCheckMove = false
function OnRecycle()
    if goRect == nil then
        goRect = ComUtil.GetCom(gameObject, "RectTransform")
    end
    goRect.pivot = UnityEngine.Vector2(0.5, 0.5)
    CSAPI.SetGOActive(gameObject, true)
    CSAPI.SetGOAlpha(gameObject, 1)
end

function Awake()
    cg_skill = ComUtil.GetCom(skill, "CanvasGroup")
    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(txtName)
end

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

-- CRoleInfo
function Refresh(_data, _select, _isRepe, _isUnUse)
    curData = _data
    isSelect = _select
    isRePe = _isRepe
    isUnUse = _isUnUse

    RefreshBase()
    -- in
    local roomName = curData:GetRoomNama() or ""
    CSAPI.SetGOActive(imgIn, roomName ~= "")
    if (roomName ~= "") then
        local inBuilding = curData:IsInBuilding()
        roomName = not inBuilding and (LanguageMgr:GetByID(32002) .. roomName) or roomName
    end
    CSAPI.SetText(txtIn, roomName)
    -- select
    CSAPI.SetGOActive(select, isSelect)
    -- cal 
    plTimer = nil
    plPerTimer = curData:GetPerTimer()
    if (plPerTimer and plPerTimer > 0) then
        plTimer = Time.time + plPerTimer
    end
    -- unuse
    CSAPI.SetGOActive(unUse1, not isSelect and isRePe)
    cg_skill.alpha = isUnUse and 0.3 or 1
end

function RefreshBase()
    -- icon 
    SetIcon(curData:Card_head())
    -- lv
    CSAPI.SetText(txtLv, curData:GetLv() .. "")
    -- name 代号
    needToCheckMove = false
    CSAPI.SetText(txtName, curData:GetAlias())
    needToCheckMove = true
    -- skill
    local curSkillCfg = curData:GetAbilityCurCfg()
    CSAPI.SetText(txtSkill, curSkillCfg.index .. "")
    local cfg = curData:GetAbilityCfg()
    ResUtil.CRoleSkill:Load(imgSkill, cfg.icon)
    -- pl
    SetPL()
end

function SetIcon(iconName)
    if (iconName) then
        ResUtil.CardIcon:Load(icon, iconName)
    end
end

function Update()
    if (plTimer and Time.time > plTimer) then
        plTimer = Time.time + plPerTimer
        SetPL()
    end
    if (needToCheckMove) then
        luaTextMove:CheckMove(txtName)
        needToCheckMove = false
    end
end
function SetPL()
    local curTv = curData:GetCurRealTv()
    CSAPI.SetText(txtPL, curTv .. "")
    local faceName = MatrixMgr:GetFaceName(curTv)
    ResUtil.Face:Load(face, faceName)

    CSAPI.SetGOActive(red, curTv <= 0)
end

function OnClick()
    if (cb) then
        cb(this)
    end
end

-- 仅显示基本信息
function Refresh2(_data)
    curData = _data

    CSAPI.SetGOActive(select, false)
    CSAPI.SetGOActive(unUse, false)
    CSAPI.SetGOActive(imgIn, false)

    RefreshBase()
end
