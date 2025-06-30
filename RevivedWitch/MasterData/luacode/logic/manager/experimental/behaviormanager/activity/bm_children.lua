-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_children.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_Children = class("BM_Children")
local CChildrensDayExtraAward = (BeanManager.GetTableByName)("mission.cchildrensdayextraaward")
local CChildrensDayShop = (BeanManager.GetTableByName)("activity.cchildrensdayshop")
local CactivityTasks = (LuaNetManager.CreateProtocol)("protocol.task.cactivitytasks")
local Item = require("logic.manager.experimental.types.item")
BM_Children.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._children = ((NekoData.Data).activities).children
end

BM_Children.ShowRedDot = function(self)
  -- function num : 0_1
  if not self:GetIsOpen() then
    return false
  end
  if not self:GetTaskRedDot() and not self:GetShopRedDot() then
    return self:GetItemShopRedDot()
  end
end

BM_Children.GetTaskRedDot = function(self)
  -- function num : 0_2 , upvalues : _ENV, CactivityTasks
  if self:GetTaskFinish() then
    return false
  end
  return ((NekoData.BehaviorManager).BM_ActivityTasks):HaveFinishedTask(CactivityTasks.CHILDREN_DAY)
end

BM_Children.GetShopRedDot = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self:GetTaskFinish() then
    return false
  end
  if not ((NekoData.BehaviorManager).BM_Shop):GetShopGoodInfoByID(((DataCommon.ChildrenActivity).Shop).ShopID) then
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

BM_Children.HaveAvailable = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for k,v in pairs((self._children).awards) do
    if v == 2 then
      return true
    end
  end
  return false
end

BM_Children.GetItemShopRedDot = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local canbuy = false
  local canReceive = false
  local data = self:GetConversionItemInfo()
  for k,v in pairs(data) do
    if v.leftTimes > 0 and v.price <= ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.Cicada) then
      canbuy = true
      break
    end
  end
  do
    canReceive = self:HaveAvailable()
    return canbuy or canReceive
  end
end

BM_Children.GetIsOpen = function(self)
  -- function num : 0_6 , upvalues : _ENV
  return ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).ChildrenDay)
end

BM_Children.GetTaskFinish = function(self)
  -- function num : 0_7
  return (self._children).taskFinish
end

BM_Children.GetAwardsInfo = function(self)
  -- function num : 0_8 , upvalues : CChildrensDayExtraAward, Item
  local result = {}
  local length = self:GetAwardLength()
  for i = 1, length do
    result[i] = {}
    local record = CChildrensDayExtraAward:GetRecorder(i)
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (result[i]).state = ((self._children).awards)[i]
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (result[i]).item = (Item.Create)((record.rewarditem)[1])
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (result[i]).count = (record.rewardquantity)[1]
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (result[i]).neednum = record.neednum
  end
  return result
end

BM_Children.GetConversionItemInfo = function(self)
  -- function num : 0_9 , upvalues : _ENV, CChildrensDayShop, Item
  local result = {}
  for i,v in ipairs(CChildrensDayShop:GetAllIds()) do
    local record = CChildrensDayShop:GetRecorder(v)
    result[v] = {}
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (result[v]).id = v
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (result[v]).item = (Item.Create)(record.Items)
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (result[v]).num = record.Nums
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (result[v]).price = record.Price
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (result[v]).coinItem = (Item.Create)(record.MoneyType)
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (result[v]).leftTimes = ((self._children).leftTimes)[v] or 0
  end
  return result
end

BM_Children.GetScore = function(self)
  -- function num : 0_10
  return (self._children).score or 0
end

BM_Children.IsInit = function(self)
  -- function num : 0_11
  return (self._children).init
end

BM_Children.GetAwardLength = function(self)
  -- function num : 0_12 , upvalues : CChildrensDayExtraAward
  return #CChildrensDayExtraAward:GetAllIds()
end

BM_Children.SendReceiveReward = function(self, node)
  -- function num : 0_13 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.childrenday.cfetchscoreaward")
  if protocol then
    protocol.node = node
    protocol:Send()
  end
end

BM_Children.SendAwardExchange = function(self, node)
  -- function num : 0_14 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.childrenday.cawardexchange")
  if protocol then
    protocol.node = node
    protocol:Send()
  end
end

return BM_Children

