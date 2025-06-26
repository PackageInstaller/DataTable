-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_returnwelfare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_ReturnWelfare = class("BM_ReturnWelfare")
local CReturnDisplay = (BeanManager.GetTableByName)("welfare.creturndisplay")
local cReturnDisplayRecord = CReturnDisplay:GetRecorder(1)
local Collection = (LuaNetManager.GetBeanDef)("protocol.activity.collection")
BM_ReturnWelfare.DisplayType = {returnWelfareSignAwardActivityId = cReturnDisplayRecord.sign, returnTask = cReturnDisplayRecord.mission, enterInvitedCode = cReturnDisplayRecord.reward, returnWelfarePack = cReturnDisplayRecord.gift, invitePlayerReturn = cReturnDisplayRecord.invitation, returnBattlePass = cReturnDisplayRecord.battlepass}
BM_ReturnWelfare.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).returnWelfare
end

BM_ReturnWelfare.ShowReturnWelfareEntrance = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Welfare) then
    return false
  end
  if (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SignManagerID)):ShowReturnWelfareEntrance_Sign() then
    return true
  end
  local returnsignactivity = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SignManagerID)):GetReturnSignActivities()
  if (table.nums)(returnsignactivity) > 0 then
    return true
  end
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnTask) then
    return true
  end
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).enterInvitedCode) then
    return true
  end
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnWelfarePack) then
    return true
  end
  if self:GetReturnBattlePass() then
    return true
  end
end

BM_ReturnWelfare.GetOpenBackInviteProtocolData = function(self)
  -- function num : 0_2
  return (self._data).backInviteProtocol
end

BM_ReturnWelfare.GetBackTaskRewardProtocolData = function(self)
  -- function num : 0_3
  return (self._data).backTaskRewardProtocol
end

BM_ReturnWelfare.GetOpenBackPackProtocolData = function(self)
  -- function num : 0_4
  return (self._data).openBackPackProtocol
end

BM_ReturnWelfare.GetOpenBackGiftProtocolData = function(self)
  -- function num : 0_5
  return (self._data).openBackGiftProtocol
end

BM_ReturnWelfare.ShowReturnBattlePassRedDot = function(self)
  -- function num : 0_6 , upvalues : _ENV, Collection
  if (self._data).returnBattlePass then
    local common = ((self._data).returnBattlePass).commonCollection
    for i,v in ipairs(common) do
      if v.state == Collection.UN_RECEIVE then
        return true
      end
    end
    local high = ((self._data).returnBattlePass).highCollection
    for i,v in ipairs(high) do
      if v.state == Collection.UN_RECEIVE then
        return true
      end
    end
  end
end

BM_ReturnWelfare.GetReturnBattlePass = function(self)
  -- function num : 0_7
  return (self._data).returnBattlePass
end

return BM_ReturnWelfare

