-- 皮肤 data : CRoleInfo
local needToCheckMove = false
function Awake()
    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(txtName)
end
function Update()
    if (needToCheckMove) then
        luaTextMove:CheckMove(txtName)
        needToCheckMove = false
    end
end

function SetIndex(_index)
    index = _index
end
function SetClickCB(_cb)
    cb = _cb
end

-- _elseData 根据key来划分数据
function Refresh(_data, _curID, _isdx)
    isdx = _isdx
    data = _data
    elseData = _elseData or {}

    -- isUse = elseData.useID and elseData.useID == data:GetID() or false
    isSelect = _curID == data:GetID() or false

    -- icon
    -- SetIcon(data:GetIcon())
    SetIcon2()
    -- name 
    needToCheckMove = false
    CSAPI.SetText(txtName, data:GetAlias())
    needToCheckMove = true
    -- use 
    -- CSAPI.SetGOActive(use, isUse)
    SetUse()
    -- select
    CSAPI.SetGOActive(select, isSelect)
    --
    UIUtil:SetRedPoint2("Common/Red4", node, data:IsHadLimitSkin(), -86, 58, 0)
end

function SetUse()
    isUse = false
    if (isdx) then
        isUse, useID = CRoleDisplayMgr:CheckRoleIsUse(data)
        CSAPI.SetGOActive(use, isUse)
    end
    CSAPI.SetGOActive(btnUse, isUse)
end

-- function SetIcon(_iconName)
--     if (_iconName) then
--         ResUtil.Card:Load(icon, _iconName)
--     end
-- end

-- 设置角色详情选择的皮肤头像（如果是看板，则用看板的）
function SetIcon2()
    local modelId = nil
    -- if (PlayerClient:KBIsRole()) then
    --     local cfg = Cfgs.character:GetByID(PlayerClient:GetIconId())
    --     if (cfg and cfg.role_id and cfg.role_id == data:GetID()) then
    --         modelId = PlayerClient:GetIconId()
    --     end
    -- end
    if (modelId == nil) then
        modelId = RoleMgr:GetSkinIDByRoleID(data:GetID())
    end
    local cfgModel = modelId and Cfgs.character:GetByID(modelId) or nil
    local iconName = cfgModel and cfgModel.List_head or nil
    if (iconName) then
        ResUtil.Card:Load(icon, iconName)
    end
end

-- function SetNew()
--     local isAdd = data:CheckHadNewSkin()
--     UIUtil:SetNewPoint(node, isAdd, 85.7, 79, 0)
-- end

function OnClick()
    if (cb) then
        cb(data)
    end
end

function OnClickUse()
    if (not isdx) then
        return
    end
    -- CRoleDisplayMgr:UseOrRemove(isUse,useID)
    -- 只有一个并且是队长
    if (CRoleDisplayMgr:CheckOnlyLeader()) then
        local str = LanguageMgr:GetByID(7082)
        Tips.ShowTips(str)
        return
    end
    -- 
    local str = LanguageMgr:GetTips(27015)
    UIUtil:OpenDialog(str, function()
        CRoleDisplayMgr:RemoveForRole(data)
    end)
end

