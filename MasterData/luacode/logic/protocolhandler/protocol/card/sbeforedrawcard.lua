local function p1(protocol)
  DialogManager.GetGroup("Guide"):SetObjectActive(false)
  
  NekoData.DataManager.DM_Gacha:SBeforeDrawCard(protocol.drawTimes)
  DialogManager.DestroySingletonDialog("gacha.gachamoviedialog")
  local dialog = DialogManager.CreateSingletonDialog("gacha.gachamoviedialog")
  dialog:SetTenDrawGuide()
  local map = {}
  local roleList = {}
  for i, v in ipairs(protocol.roleList) do
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(v)
    local isNew = 0
    if not role and not map[v] then
      isNew = 1
      map[v] = true
    end
    table.insert(roleList, {cardId = v, isNew = isNew})
  end
  dialog:SetData(roleList)
  NekoData.DataManager.DM_Gacha:OnSBeforeDrawCard(protocol.baodiNum, protocol.share)
  LuaNotificationCenter.PostNotification(Common.n_DrawCard, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
