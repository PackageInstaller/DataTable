local needToCheckMove = false
function Awake()
    luaTextMove12 = LuaTextMove.New()
    luaTextMove12:Init(txtName12)
    luaTextMove22 = LuaTextMove.New()
    luaTextMove22:Init(txtName22)
end
function Update()
    if (needToCheckMove) then
        luaTextMove12:CheckMove(txtName12)
        luaTextMove22:CheckMove(txtName22)
        needToCheckMove = false
    end
end

function SetIndex(_index)
    index = _index
end

function Refresh(_data)
    data = _data
    --
    ids = index == 1 and {0, 0} or data:GetIDs()
    needToCheckMove = false
    SetSlot(ids[1], empty1, entity1, icon1, txtName11, txtName12)
    SetSlot(ids[2], empty2, entity2, icon2, txtName21, txtName22)
    needToCheckMove = true
    if (index ~= 1) then
        CSAPI.SetGOActive(btnRemove1, data:GetIdx() ~= CRoleDisplayMgr:GetPanelRet().using)
        CSAPI.SetGOActive(btnRemove2, data:GetIdx() ~= CRoleDisplayMgr:GetPanelRet().using)
    end
    --
    SetLimitSkin()
end

function SetSlot(_id, _empty, _entity, _icon, _txtName1, _txtName2)
    CSAPI.SetGOActive(_empty, _id == 0)
    CSAPI.SetGOActive(_entity, _id ~= 0)
    if (_id ~= 0) then
        local cfg1 = Cfgs.CfgArchiveMultiPicture:GetByID(_id)
        if (cfg1) then
            -- icon
            ResUtil.MultBoardSmall:Load(_icon, cfg1.set_icon)
            local typeName = CRoleDisplayMgr:GetTypeSName(cfg1.nType, cfg1.theme_type)
            CSAPI.SetText(_txtName2, cfg1.sName)
            CSAPI.SetText(_txtName1, typeName)
        else
            local cfg2 = Cfgs.character:GetByID(_id)
            -- icon
            ResUtil.CardIcon:Load(_icon, cfg2.Card_head)
            CSAPI.SetText(_txtName2, cfg2.key)
            CSAPI.SetText(_txtName1, cfg2.desc)
        end
    end
end

function OnClick1()
    if (index == 1) then
        local arr = CRoleDisplayMgr:GetRandomPanels(eRandomPanelType.DOUBLE)
        if (#arr >= g_RandomKanbanQuantity) then
            LanguageMgr:ShowTips(27008)
            return
        end
        local _data = CRoleDisplayMgr:CreateRandomData(CRoleDisplayMgr:GetRandomIdx(), 3)
        CSAPI.OpenView("CRoleDisplay", _data, 1)
    else
        PlayerProto:GetRandomPanelDetail(data:GetIdx(), function(proto)
            local _data = CRoleDisplayMgr:GerRamdomData(proto.idx)
            CSAPI.OpenView("CRoleDisplay", _data, 1)
        end)
    end
end
function OnClick2()
    if (index == 1) then
        local arr = CRoleDisplayMgr:GetRandomPanels(eRandomPanelType.DOUBLE)
        if (#arr >= g_RandomKanbanQuantity) then
            LanguageMgr:ShowTips(27008)
            return
        end
        local _data = CRoleDisplayMgr:CreateRandomData(CRoleDisplayMgr:GetRandomIdx(), 3)
        CSAPI.OpenView("CRoleDisplay", _data, 2)
    else
        PlayerProto:GetRandomPanelDetail(data:GetIdx(), function(proto)
            local _data = CRoleDisplayMgr:GerRamdomData(proto.idx)
            CSAPI.OpenView("CRoleDisplay", _data, 2)
        end)
    end
end

function OnClickRemove1()
    local str = LanguageMgr:GetTips(27010)
    UIUtil:OpenDialog(str, function()
        if (ids[2] ~= 0) then
            local panel = table.copy(data:GetRet())
            panel.ids = {0, ids[2]}
            PlayerProto:SetRandomPanel(panel)
        else
            PlayerProto:RemoveRandomPanel(data:GetIdx())
        end
    end)
end
function OnClickRemove2()
    local str = LanguageMgr:GetTips(27010)
    UIUtil:OpenDialog(str, function()
        if (ids[1] ~= 0) then
            local panel = table.copy(data:GetRet())
            panel.ids = {ids[1], 0}
            PlayerProto:SetRandomPanel(panel)
        else
            PlayerProto:RemoveRandomPanel(data:GetIdx())
        end
    end)
end

function SetLimitSkin()
    local isLimitSkin1 = data:CheckLimitSkin(1)
    UIUtil:SetRedPoint2("Common/Red4", node1, isLimitSkin1, -77.6, 158, 0)

    local isLimitSkin2 = data:CheckLimitSkin(2)
    UIUtil:SetRedPoint2("Common/Red4", node2, isLimitSkin2, -77.6, 158, 0)
end
