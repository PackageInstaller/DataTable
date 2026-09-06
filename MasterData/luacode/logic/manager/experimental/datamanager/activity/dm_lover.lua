local CLoverActivityEvent = require("protocols.def.protocol.activity.cloveractivityevent")
local SLoverRedPoint = LuaNetManager.GetProtocolDef("protocol.activity.sloverredpoint")
local CInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cvalentineinterfacefunction")
local DM_Lover = class("DM_Lover")

function DM_Lover:Ctor()
  self._data = NekoData.Data.activities.lover
  self._data.constructions = {}
  self._data.Function = {}
  self._data.Function.ItemShop = 0
  self._data.Function.Chocolate = 0
  self._data.Function.Flowers = 0
  self._data.Function.DialogueStore = 0
  self._data.ChocolateEntry = {}
  self._data.FlowerEntry = {}
  self._data.redPoint = {
    [SLoverRedPoint.LOVER_CHOCOLATE] = false,
    [SLoverRedPoint.LOVER_FLOWER] = false
  }
end

function DM_Lover:Clear()
  self._data.constructions = {}
  self._data.foodStallsData = {}
  self._data.Function = {}
  self._data.Function.ItemShop = 0
  self._data.Function.Chocolate = 0
  self._data.Function.Flowers = 0
  self._data.Function.DialogueStore = 0
  self._data.ChocolateEntry = {}
  self._data.FlowerEntry = {}
  self._data.redPoint = {}
end

function DM_Lover:OnSGetLoverActivityInfo(protocol)
  self._data.constructions = protocol.constructions
  for _, construction in ipairs(self._data.constructions) do
    if next(construction.event) ~= nil then
      local recorder = CInterfaceFunction:GetRecorder(construction.event[1])
      if recorder then
        local type = CInterfaceFunction:GetRecorder(construction.event[1]).type
        if type == CLoverActivityEvent.ITEM_SHOP then
          self._data.Function.ItemShop = 1
        end
        if type == CLoverActivityEvent.CHOCOLATE then
          self._data.Function.Chocolate = 1
          self._data.ChocolateEntry.constructionID = construction.ID
          self._data.ChocolateEntry.eventID = construction.event[1]
        end
        if type == CLoverActivityEvent.FLOWER_LIST then
          self._data.Function.Flowers = 1
          self._data.FlowerEntry.constructionID = construction.ID
          self._data.FlowerEntry.eventID = construction.event[1]
        end
        if type == CLoverActivityEvent.DIALOGUE_STORE then
          self._data.Function.DialogueStore = 1
        end
      else
        LogErrorFormat("DM_Lover", "Error Event:%s", construction.event[1])
      end
    end
  end
end

function DM_Lover:OnSUpdateConstructionEvent(protocol)
  for _, event in ipairs(protocol.updates) do
    for _, construction in ipairs(self._data.constructions) do
      if construction.ID == event.construction then
        construction.event = event.events
        for _, v in ipairs(event.autoExplore) do
          table.insert(construction.autoExplore, v)
        end
        for _, v in ipairs(construction.event) do
          local index = table.indexof(construction.locked, v)
          if index then
            table.remove(construction.locked, index)
          end
        end
        if next(construction.event) ~= nil then
          local type = CInterfaceFunction:GetRecorder(construction.event[1]).type
          if type == CLoverActivityEvent.ITEM_SHOP then
            self._data.Function.ItemShop = 1
          end
          if type == CLoverActivityEvent.CHOCOLATE then
            self._data.Function.Chocolate = 1
          end
          if type == CLoverActivityEvent.FLOWER_LIST then
            self._data.Function.Flowers = 1
            self._data.FlowerEntry.constructionID = construction.ID
            self._data.FlowerEntry.eventID = construction.event[1]
          end
          if type == CLoverActivityEvent.DIALOGUE_STORE then
            self._data.Function.DialogueStore = 1
          end
        end
        break
      end
    end
  end
end

function DM_Lover:OnSLoverRedPoint(protocol)
  LogInfoFormat("DM_Lover", "state %s", protocol.state)
  self._data.redPoint[protocol.state] = true
end

return DM_Lover
