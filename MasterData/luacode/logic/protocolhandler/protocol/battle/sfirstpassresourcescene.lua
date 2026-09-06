local function p1(protocol)
  local t = {}
  
  LuaNotificationCenter.AddObserver(t, function()
    DialogManager.CreateSingletonDialog("dungeon.resourcedungeonaccountdialog"):SetData(protocol.passid, protocol.firstItems)
    LuaNotificationCenter.RemoveObserver(t)
  end, Common.n_BattleRewardEnd)
end

local function p2(protocol, client)
end

return {p1, p2}
