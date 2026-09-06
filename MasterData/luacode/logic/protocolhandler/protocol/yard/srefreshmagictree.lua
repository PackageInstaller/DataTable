local TaskStateEnum = LuaNetManager.GetBeanDef("protocol.yard.task")

local function p1(protocol)
  local level = NekoData.BehaviorManager.BM_MagicTree:GetLevel()
  NekoData.DataManager.DM_MagicTree:OnSRefreshMagicTree(protocol)
  if level < protocol.magicTree.level then
    local dialog = DialogManager.GetDialog("magictree.magictreedialog")
    if dialog then
      dialog._magicTreeLvUpClick = false
    end
    DialogManager.CreateSingletonDialog("magictree.magictreelvupsuccessdialog"):Init(level, protocol.magicTree.level)
    LuaNotificationCenter.PostNotification(Common.n_BuildingLevelUp, nil, {
      buildingId = DataCommon.MagicTree
    })
  end
  LuaNotificationCenter.PostNotification(Common.n_RefreshMagicTree, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
