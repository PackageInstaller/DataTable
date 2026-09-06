local Collection = LuaNetManager.CreateBean("protocol.activity.collection")

local function p1(protocol)
  local commonStr = ""
  for i, v in ipairs(protocol.commonCollection) do
    if commonStr ~= "" then
      commonStr = commonStr .. ", "
    end
    commonStr = commonStr .. "{index=" .. i .. ", level=" .. v.level .. ", state=" .. v.state .. ", itemId=" .. v.itemId .. ", itemNum=" .. v.itemNum .. "}"
  end
  local highStr = ""
  for i, v in ipairs(protocol.highCollection) do
    if highStr ~= "" then
      highStr = highStr .. ", "
    end
    highStr = highStr .. "{index=" .. i .. ", level=" .. v.level .. ", state=" .. v.state .. ", itemId=" .. v.itemId .. ", itemNum=" .. v.itemNum .. "}"
  end
  LogInfoFormat("sreturnpass", "--- actId = %s, deadline = %s, highUnlocked = %s, chargeMoneyType = %s, chargePrice = %s, levelPrice = %s, level = %s, chipNum = %s, needChipNum = %s, canReceiveMaxAward = %s, leftTime = %s, commonCollection = %s, highCollection = %s ---", protocol.actId, protocol.deadline, protocol.highUnlocked, protocol.chargeMoneyType, protocol.chargePrice, protocol.levelPrice, protocol.level, protocol.chipNum, protocol.needChipNum, protocol.canReceiveMaxAward, protocol.leftTime, commonStr, highStr)
  NekoData.DataManager.DM_ReturnWelfare:OnSReturnPass(protocol)
  if protocol.highUnlocked == 1 then
    DialogManager.DestroySingletonDialog("welfare.returnwelfare.returnbattlepassunlockdialog")
  end
  local dialog = DialogManager.GetDialog("welfare.returnwelfare.roleopstiondialog")
  if dialog then
    local tag
    for i, v in ipairs(protocol.commonCollection) do
      if v.level == dialog._data.level and dialog._data.CollectionType == 1 and v.state == Collection.RECEIVE then
        tag = true
      end
    end
    for i, v in ipairs(protocol.highCollection) do
      if v.level == dialog._data.level and dialog._data.CollectionType == 2 and v.state == Collection.RECEIVE then
        tag = true
      end
    end
    if tag then
      dialog:Destroy()
    end
  end
  LuaNotificationCenter.PostNotification(Common.n_RefreshReturnBattlePass, nil, protocol.actId)
end

local function p2(protocol, client)
end

return {p1, p2}
