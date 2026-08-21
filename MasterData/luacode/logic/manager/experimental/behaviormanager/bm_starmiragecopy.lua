-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_starmiragecopy.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TypeEnum = (DataCommon.StarMirage1)[(DataCommon.Activities).StarMirageCopy]
local BM_CopyBase = require("logic.manager.experimental.behaviormanager.bm_copybase")
local BM_StarMirageCopy = class("BM_StarMirageCopy", BM_CopyBase)
BM_StarMirageCopy.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, BM_StarMirageCopy
  self._data = (NekoData.Data).starMirageCopy
  ;
  ((BM_StarMirageCopy.super).Ctor)(self, (self._data).baseData)
end

BM_StarMirageCopy.SetLevelStatus = function(self, type, levelId, status)
  -- function num : 0_1 , upvalues : _ENV, BM_StarMirageCopy
  ((NekoData.DataManager).DM_StarMirageCopy):SetLevelStatus(type, levelId, status)
  ;
  ((BM_StarMirageCopy.super).SetLevelStatus)(self, type, levelId, status)
end

BM_StarMirageCopy.GetDailySupplyData = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return ((NekoData.BehaviorManager).BM_Activity):GetDailySupplyDataByActivityId((DataCommon.Activities).StarMirageCopy)
end

BM_StarMirageCopy.ShowDailySupplyRedDot = function(self)
  -- function num : 0_3 , upvalues : TypeEnum, _ENV
  if self:IsUnlockFunctionById((TypeEnum.Function).DailySupply) then
    return ((NekoData.BehaviorManager).BM_Activity):ShowDailySupplyRedDotByActivityId((DataCommon.Activities).StarMirageCopy)
  end
end

BM_StarMirageCopy.GetAccumulateRewardList = function(self)
  -- function num : 0_4
  return (self._data).accumulateRewardList
end

BM_StarMirageCopy.ShowAccumulateRewardRedDot = function(self)
  -- function num : 0_5 , upvalues : TypeEnum, _ENV
  if self:IsUnlockFunctionById((TypeEnum.Function).AccumulateRewards) then
    return ((NekoData.BehaviorManager).BM_Activity):ShowAccumulateRedDot((DataCommon.Activities).StarMirageCopy)
  end
end

BM_StarMirageCopy.IsPackageOpen = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local leftTime = ((NekoData.BehaviorManager).BM_Activity):GetOtherActivityLeftTimeWithActivityId((DataCommon.Activities).StarMirageCopy)
  do return leftTime > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_StarMirageCopy.ShowActivityRedDot = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).StarMirageCopy) then
    return true
  end
  if self:ShowDailySupplyRedDot() then
    return true
  end
  if self:ShowAccumulateRewardRedDot() then
    return true
  end
end

BM_StarMirageCopy.ShowRedDot = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).StarMirageCopy) then
    return true
  end
  if self:ShowDailySupplyRedDot() then
    return true
  end
  if self:ShowAccumulateRewardRedDot() then
    return true
  end
  if self:HasFreeGood() then
    return true
  end
end

BM_StarMirageCopy.HasFreeGood = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if not self:IsPackageOpen() then
    return false
  end
  if not ((NekoData.BehaviorManager).BM_Shop):GetShopGoodInfoByID((((DataCommon.StarMirage1)[(DataCommon.Activities).StarMirageCopy]).Other).ShopId) then
    local shopData = {}
  end
  local allFreeSoldOut = true
  for _,good in ipairs(shopData) do
    if good.discountPrice == 0 then
      allFreeSoldOut = true
      if good.goodRemain ~= 0 then
        allFreeSoldOut = false
        break
      end
    end
  end
  do
    return not allFreeSoldOut
  end
end

BM_StarMirageCopy.HasScoreAward = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if not self:IsPackageOpen() then
    return false
  end
  for _,v in ipairs(((self._data).package).award) do
    if v == 1 then
      return true
    end
  end
end

return BM_StarMirageCopy

