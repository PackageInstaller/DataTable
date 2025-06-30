-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sreturnpass.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Collection = (LuaNetManager.CreateBean)("protocol.activity.collection")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, Collection
  local commonStr = ""
  for i,v in ipairs(protocol.commonCollection) do
    if commonStr ~= "" then
      commonStr = commonStr .. ", "
    end
    commonStr = commonStr .. "{index=" .. i .. ", level=" .. v.level .. ", state=" .. v.state .. ", itemId=" .. v.itemId .. ", itemNum=" .. v.itemNum .. "}"
  end
  local highStr = ""
  for i,v in ipairs(protocol.highCollection) do
    if highStr ~= "" then
      highStr = highStr .. ", "
    end
    highStr = highStr .. "{index=" .. i .. ", level=" .. v.level .. ", state=" .. v.state .. ", itemId=" .. v.itemId .. ", itemNum=" .. v.itemNum .. "}"
  end
  LogInfoFormat("sreturnpass", "--- actId = %s, deadline = %s, highUnlocked = %s, chargeMoneyType = %s, chargePrice = %s, levelPrice = %s, level = %s, chipNum = %s, needChipNum = %s, canReceiveMaxAward = %s, leftTime = %s, commonCollection = %s, highCollection = %s ---", protocol.actId, protocol.deadline, protocol.highUnlocked, protocol.chargeMoneyType, protocol.chargePrice, protocol.levelPrice, protocol.level, protocol.chipNum, protocol.needChipNum, protocol.canReceiveMaxAward, protocol.leftTime, commonStr, highStr)
  ;
  ((NekoData.DataManager).DM_ReturnWelfare):OnSReturnPass(protocol)
  if protocol.highUnlocked == 1 then
    (DialogManager.DestroySingletonDialog)("welfare.returnwelfare.returnbattlepassunlockdialog")
  end
  local dialog = (DialogManager.GetDialog)("welfare.returnwelfare.roleopstiondialog")
  do
    if dialog then
      local tag = nil
      for i,v in ipairs(protocol.commonCollection) do
        if v.level == (dialog._data).level and (dialog._data).CollectionType == 1 and v.state == Collection.RECEIVE then
          tag = true
        end
      end
      for i,v in ipairs(protocol.highCollection) do
        if v.level == (dialog._data).level and (dialog._data).CollectionType == 2 and v.state == Collection.RECEIVE then
          tag = true
        end
      end
      if tag then
        dialog:Destroy()
      end
    end
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshReturnBattlePass, nil, protocol.actId)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

