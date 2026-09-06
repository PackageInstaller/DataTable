local function p1(protocol)
  local BattleType = LuaNetManager.CreateBean("protocol.activity.challengerecord")
  
  if protocol.battleType == BattleType.SEASON then
    local dialog = DialogManager.CreateSingletonDialog("mainline.undecidedroad.undecidedroadrecorddialog")
    if dialog then
      dialog:SetData(protocol)
    end
  else
    local dialog = DialogManager.CreateSingletonDialog("mainline.undecidedroad.undecidedroadbossrecorddialog")
    if dialog then
      dialog:SetData(protocol)
    end
  end
end

local function p2(protocol, client)
end

return {p1, p2}
