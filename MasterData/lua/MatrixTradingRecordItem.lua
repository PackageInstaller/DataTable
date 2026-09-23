function Refresh(_data)
    data = _data

    -- child
    -- SetChild()
    -- SetIcon(data.icon)
    -- name
    CSAPI.SetText(txtName, data.name)
    -- lv
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
    CSAPI.SetText(txtLv, lvStr .. data.lv)
    -- desc
    if (data.type == 1) then
        -- 点赞
        LanguageMgr:SetText(txtDesc, 10118, data.name)
    else
        -- 交易
        LanguageMgr:SetText(txtDesc, 10117, data.name, 1)
    end
    -- head
    UIUtil:AddHeadByID(hfParent, 0.6, data.icon_frame, data.icon,data.sel_card_ix)
end

-- function SetChild()
--     if (not cRoleLittleItem2) then
--         ResUtil:CreateUIGOAsync("CRoleItem/CRoleSmallItem2", childParent, function(go)
--             cRoleLittleItem2 = ComUtil.GetLuaTable(go)
--             cRoleLittleItem2.Refresh(data.lv, data.icon)

--         end)
--     else
--         cRoleLittleItem2.Refresh(data.lv, data.icon)
--     end
-- end

-- function SetIcon(icon_id)
-- 	local cfgModel = Cfgs.character:GetByID(icon_id)
-- 	local iconName = cfgModel.icon or nil
-- 	if(iconName) then
-- 		ResUtil.RoleCard:Load(icon, iconName)
-- 	end
-- end

function OnClickTalk()
    local data = FriendMgr:GetData(data.fid)
    if (data == nil) then
        LanguageMgr:ShowTips(6009)
    else
        LanguageMgr:ShowTips(1035)
    end
end
