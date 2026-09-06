local function p1(protocol)
  NekoData.DataManager.DM_Welfare:SFirstChargeOpenPanel(protocol)
  
  if CS.UnityEngine.PlayerPrefs.HasKey("FirstReChargeRedPoint") then
    CS.UnityEngine.PlayerPrefs.DeleteKey("FirstReChargeRedPoint")
  end
  local SixOneGetStatue = 0
  local SixTwoGetStatue = 0
  local Is68HasGetAward = false
  for k, v in pairs(protocol.awards) do
    if v.id == 1 then
      SixOneGetStatue = v.statue
    elseif v.id == 2 then
      SixTwoGetStatue = v.statue
    elseif v.id >= 3 and v.statue == 1 then
      Is68HasGetAward = true
    end
  end
  if SixOneGetStatue ~= 1 and SixTwoGetStatue ~= 1 and not Is68HasGetAward then
    NekoData.DataManager.DM_Welfare:SFitstRechargeGiftRedPoint(false)
  end
  if SixOneGetStatue == 2 and SixTwoGetStatue == 2 then
    local dialog = DialogManager.CreateSingletonDialog("welfare.fitstrecharge2dialog")
    if dialog then
      dialog:Init()
    end
  elseif SixOneGetStatue == 0 or SixOneGetStatue == 1 then
    local dialog = DialogManager.CreateSingletonDialog("welfare.fitstrechargedialog")
    if dialog then
      dialog:Init()
    end
  elseif SixTwoGetStatue == 1 then
    local dialog = DialogManager.CreateSingletonDialog("welfare.fitstrechargedialog")
    if dialog then
      dialog:Init()
    end
  elseif Is68HasGetAward then
    local dialog = DialogManager.CreateSingletonDialog("welfare.fitstrecharge2dialog")
    if dialog then
      dialog:Init()
    end
  else
    local dialog = DialogManager.CreateSingletonDialog("welfare.fitstrechargedialog")
    if dialog then
      dialog:Init()
    end
  end
  LuaNotificationCenter.PostNotification(Common.n_FirstRechargeGiftState, nil, nil)
  LuaNotificationCenter.PostNotification(Common.n_FitstRechargeGiftRedPoint, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
