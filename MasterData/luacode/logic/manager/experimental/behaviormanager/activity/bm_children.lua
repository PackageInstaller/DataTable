local BM_Children = class("BM_Children")
local CChildrensDayExtraAward = BeanManager.GetTableByName("mission.cchildrensdayextraaward")
local CChildrensDayShop = BeanManager.GetTableByName("activity.cchildrensdayshop")
local CactivityTasks = LuaNetManager.CreateProtocol("protocol.task.cactivitytasks")
local Item = require("logic.manager.experimental.types.item")

function BM_Children:Ctor()
  self._children = NekoData.Data.activities.children
end

function BM_Children:ShowRedDot()
  if not self:GetIsOpen() then
    return false
  end
  return self:GetTaskRedDot() or self:GetShopRedDot() or self:GetItemShopRedDot()
end

function BM_Children:GetTaskRedDot()
  if self:GetTaskFinish() then
    return false
  end
  return NekoData.BehaviorManager.BM_ActivityTasks:HaveFinishedTask(CactivityTasks.CHILDREN_DAY)
end

function BM_Children:GetShopRedDot()
  if self:GetTaskFinish() then
    return false
  end
  local shopData = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(DataCommon.ChildrenActivity.Shop.ShopID) or {}
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

function BM_Children:HaveAvailable()
  for k, v in pairs(self._children.awards) do
    if v == 2 then
      return true
    end
  end
  return false
end

function BM_Children:GetItemShopRedDot()
  local canbuy = false
  local canReceive = false
  local data = self:GetConversionItemInfo()
  for k, v in pairs(data) do
    if v.leftTimes > 0 and v.price <= NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.Cicada) then
      canbuy = true
      break
    end
  end
  canReceive = self:HaveAvailable()
  return canbuy or canReceive
end

function BM_Children:GetIsOpen()
  return NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.ChildrenDay)
end

function BM_Children:GetTaskFinish()
  return self._children.taskFinish
end

function BM_Children:GetAwardsInfo()
  local result = {}
  local length = self:GetAwardLength()
  for i = 1, length do
    result[i] = {}
    local record = CChildrensDayExtraAward:GetRecorder(i)
    result[i].state = self._children.awards[i]
    result[i].item = Item.Create(record.rewarditem[1])
    result[i].count = record.rewardquantity[1]
    result[i].neednum = record.neednum
  end
  return result
end

function BM_Children:GetConversionItemInfo()
  local result = {}
  for i, v in ipairs(CChildrensDayShop:GetAllIds()) do
    local record = CChildrensDayShop:GetRecorder(v)
    result[v] = {}
    result[v].id = v
    result[v].item = Item.Create(record.Items)
    result[v].num = record.Nums
    result[v].price = record.Price
    result[v].coinItem = Item.Create(record.MoneyType)
    result[v].leftTimes = self._children.leftTimes[v] or 0
  end
  return result
end

function BM_Children:GetScore()
  return self._children.score or 0
end

function BM_Children:IsInit()
  return self._children.init
end

function BM_Children:GetAwardLength()
  return #CChildrensDayExtraAward:GetAllIds()
end

function BM_Children:SendReceiveReward(node)
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.childrenday.cfetchscoreaward")
  if protocol then
    protocol.node = node
    protocol:Send()
  end
end

function BM_Children:SendAwardExchange(node)
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.childrenday.cawardexchange")
  if protocol then
    protocol.node = node
    protocol:Send()
  end
end

return BM_Children
