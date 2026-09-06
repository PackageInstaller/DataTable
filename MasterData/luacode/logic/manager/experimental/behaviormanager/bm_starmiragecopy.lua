local TypeEnum = DataCommon.StarMirage1[DataCommon.Activities.StarMirageCopy]
local BM_CopyBase = require("logic.manager.experimental.behaviormanager.bm_copybase")
local BM_StarMirageCopy = class("BM_StarMirageCopy", BM_CopyBase)

function BM_StarMirageCopy:Ctor()
  self._data = NekoData.Data.starMirageCopy
  BM_StarMirageCopy.super.Ctor(self, self._data.baseData)
end

function BM_StarMirageCopy:SetLevelStatus(type, levelId, status)
  NekoData.DataManager.DM_StarMirageCopy:SetLevelStatus(type, levelId, status)
  BM_StarMirageCopy.super.SetLevelStatus(self, type, levelId, status)
end

function BM_StarMirageCopy:GetDailySupplyData()
  return NekoData.BehaviorManager.BM_Activity:GetDailySupplyDataByActivityId(DataCommon.Activities.StarMirageCopy)
end

function BM_StarMirageCopy:ShowDailySupplyRedDot()
  if self:IsUnlockFunctionById(TypeEnum.Function.DailySupply) then
    return NekoData.BehaviorManager.BM_Activity:ShowDailySupplyRedDotByActivityId(DataCommon.Activities.StarMirageCopy)
  end
end

function BM_StarMirageCopy:GetAccumulateRewardList()
  return self._data.accumulateRewardList
end

function BM_StarMirageCopy:ShowAccumulateRewardRedDot()
  if self:IsUnlockFunctionById(TypeEnum.Function.AccumulateRewards) then
    return NekoData.BehaviorManager.BM_Activity:ShowAccumulateRedDot(DataCommon.Activities.StarMirageCopy)
  end
end

function BM_StarMirageCopy:IsPackageOpen()
  local leftTime = NekoData.BehaviorManager.BM_Activity:GetOtherActivityLeftTimeWithActivityId(DataCommon.Activities.StarMirageCopy)
  return 0 < leftTime
end

function BM_StarMirageCopy:ShowActivityRedDot()
  if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.StarMirageCopy) then
    return true
  end
  if self:ShowDailySupplyRedDot() then
    return true
  end
  if self:ShowAccumulateRewardRedDot() then
    return true
  end
end

function BM_StarMirageCopy:ShowRedDot()
  if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.StarMirageCopy) then
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

function BM_StarMirageCopy:HasFreeGood()
  if not self:IsPackageOpen() then
    return false
  end
  local shopData = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(DataCommon.StarMirage1[DataCommon.Activities.StarMirageCopy].Other.ShopId) or {}
  local allFreeSoldOut = true
  for _, good in ipairs(shopData) do
    if good.discountPrice == 0 then
      allFreeSoldOut = true
      if good.goodRemain ~= 0 then
        allFreeSoldOut = false
        break
      end
    end
  end
  return not allFreeSoldOut
end

function BM_StarMirageCopy:HasScoreAward()
  if not self:IsPackageOpen() then
    return false
  end
  for _, v in ipairs(self._data.package.award) do
    if v == 1 then
      return true
    end
  end
end

return BM_StarMirageCopy
