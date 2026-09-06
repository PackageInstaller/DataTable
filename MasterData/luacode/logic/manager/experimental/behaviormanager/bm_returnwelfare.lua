local BM_ReturnWelfare = class("BM_ReturnWelfare")
local CReturnDisplay = BeanManager.GetTableByName("welfare.creturndisplay")
local cReturnDisplayRecord = CReturnDisplay:GetRecorder(1)
local Collection = LuaNetManager.GetBeanDef("protocol.activity.collection")
BM_ReturnWelfare.DisplayType = {
  returnWelfareSignAwardActivityId = cReturnDisplayRecord.sign,
  returnTask = cReturnDisplayRecord.mission,
  enterInvitedCode = cReturnDisplayRecord.reward,
  returnWelfarePack = cReturnDisplayRecord.gift,
  invitePlayerReturn = cReturnDisplayRecord.invitation,
  returnBattlePass = cReturnDisplayRecord.battlepass
}

function BM_ReturnWelfare:Ctor()
  self._data = NekoData.Data.returnWelfare
end

function BM_ReturnWelfare:ShowReturnWelfareEntrance()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Welfare) then
    return false
  end
  if NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):ShowReturnWelfareEntrance_Sign() then
    return true
  end
  local returnsignactivity = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetReturnSignActivities()
  if table.nums(returnsignactivity) > 0 then
    return true
  end
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnTask) then
    return true
  end
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.enterInvitedCode) then
    return true
  end
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnWelfarePack) then
    return true
  end
  if self:GetReturnBattlePass() then
    return true
  end
end

function BM_ReturnWelfare:GetOpenBackInviteProtocolData()
  return self._data.backInviteProtocol
end

function BM_ReturnWelfare:GetBackTaskRewardProtocolData()
  return self._data.backTaskRewardProtocol
end

function BM_ReturnWelfare:GetOpenBackPackProtocolData()
  return self._data.openBackPackProtocol
end

function BM_ReturnWelfare:GetOpenBackGiftProtocolData()
  return self._data.openBackGiftProtocol
end

function BM_ReturnWelfare:ShowReturnBattlePassRedDot()
  if self._data.returnBattlePass then
    local common = self._data.returnBattlePass.commonCollection
    for i, v in ipairs(common) do
      if v.state == Collection.UN_RECEIVE then
        return true
      end
    end
    local high = self._data.returnBattlePass.highCollection
    for i, v in ipairs(high) do
      if v.state == Collection.UN_RECEIVE then
        return true
      end
    end
  end
end

function BM_ReturnWelfare:GetReturnBattlePass()
  return self._data.returnBattlePass
end

return BM_ReturnWelfare
