-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_lover.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CLoverActivityEvent = require("protocols.def.protocol.activity.cloveractivityevent")
local SLoverRedPoint = (LuaNetManager.GetProtocolDef)("protocol.activity.sloverredpoint")
local CInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cvalentineinterfacefunction")
local DM_Lover = class("DM_Lover")
DM_Lover.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, SLoverRedPoint
  self._data = ((NekoData.Data).activities).lover
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).constructions = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).Function = {}
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._data).Function).ItemShop = 0
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._data).Function).Chocolate = 0
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._data).Function).Flowers = 0
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._data).Function).DialogueStore = 0
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).ChocolateEntry = {}
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).FlowerEntry = {}
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).redPoint = {[SLoverRedPoint.LOVER_CHOCOLATE] = false, [SLoverRedPoint.LOVER_FLOWER] = false}
end

DM_Lover.Clear = function(self)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).constructions = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).foodStallsData = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).Function = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._data).Function).ItemShop = 0
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._data).Function).Chocolate = 0
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._data).Function).Flowers = 0
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._data).Function).DialogueStore = 0
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).ChocolateEntry = {}
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).FlowerEntry = {}
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).redPoint = {}
end

DM_Lover.OnSGetLoverActivityInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV, CInterfaceFunction, CLoverActivityEvent
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).constructions = protocol.constructions
  for _,construction in ipairs((self._data).constructions) do
    if next(construction.event) ~= nil then
      local recorder = CInterfaceFunction:GetRecorder((construction.event)[1])
      if recorder then
        local type = (CInterfaceFunction:GetRecorder((construction.event)[1])).type
        -- DECOMPILER ERROR at PC31: Confused about usage of register: R9 in 'UnsetPending'

        if type == CLoverActivityEvent.ITEM_SHOP then
          ((self._data).Function).ItemShop = 1
        end
        -- DECOMPILER ERROR at PC37: Confused about usage of register: R9 in 'UnsetPending'

        if type == CLoverActivityEvent.CHOCOLATE then
          ((self._data).Function).Chocolate = 1
          -- DECOMPILER ERROR at PC41: Confused about usage of register: R9 in 'UnsetPending'

          ;
          ((self._data).ChocolateEntry).constructionID = construction.ID
          -- DECOMPILER ERROR at PC46: Confused about usage of register: R9 in 'UnsetPending'

          ;
          ((self._data).ChocolateEntry).eventID = (construction.event)[1]
        end
        -- DECOMPILER ERROR at PC52: Confused about usage of register: R9 in 'UnsetPending'

        if type == CLoverActivityEvent.FLOWER_LIST then
          ((self._data).Function).Flowers = 1
          -- DECOMPILER ERROR at PC56: Confused about usage of register: R9 in 'UnsetPending'

          ;
          ((self._data).FlowerEntry).constructionID = construction.ID
          -- DECOMPILER ERROR at PC61: Confused about usage of register: R9 in 'UnsetPending'

          ;
          ((self._data).FlowerEntry).eventID = (construction.event)[1]
        end
        -- DECOMPILER ERROR at PC67: Confused about usage of register: R9 in 'UnsetPending'

        if type == CLoverActivityEvent.DIALOGUE_STORE then
          ((self._data).Function).DialogueStore = 1
        end
      else
        do
          do
            LogErrorFormat("DM_Lover", "Error Event:%s", (construction.event)[1])
            -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

DM_Lover.OnSUpdateConstructionEvent = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV, CInterfaceFunction, CLoverActivityEvent
  for _,event in ipairs(protocol.updates) do
    for _,construction in ipairs((self._data).constructions) do
      if construction.ID == event.construction then
        construction.event = event.events
        for _,v in ipairs(event.autoExplore) do
          (table.insert)(construction.autoExplore, v)
        end
        for _,v in ipairs(construction.event) do
          local index = (table.indexof)(construction.locked, v)
          if index then
            (table.remove)(construction.locked, index)
          end
        end
        do
          do
            if next(construction.event) ~= nil then
              local type = (CInterfaceFunction:GetRecorder((construction.event)[1])).type
              -- DECOMPILER ERROR at PC60: Confused about usage of register: R13 in 'UnsetPending'

              if type == CLoverActivityEvent.ITEM_SHOP then
                ((self._data).Function).ItemShop = 1
              end
              -- DECOMPILER ERROR at PC66: Confused about usage of register: R13 in 'UnsetPending'

              if type == CLoverActivityEvent.CHOCOLATE then
                ((self._data).Function).Chocolate = 1
              end
              -- DECOMPILER ERROR at PC72: Confused about usage of register: R13 in 'UnsetPending'

              if type == CLoverActivityEvent.FLOWER_LIST then
                ((self._data).Function).Flowers = 1
                -- DECOMPILER ERROR at PC76: Confused about usage of register: R13 in 'UnsetPending'

                ;
                ((self._data).FlowerEntry).constructionID = construction.ID
                -- DECOMPILER ERROR at PC81: Confused about usage of register: R13 in 'UnsetPending'

                ;
                ((self._data).FlowerEntry).eventID = (construction.event)[1]
              end
              -- DECOMPILER ERROR at PC87: Confused about usage of register: R13 in 'UnsetPending'

              if type == CLoverActivityEvent.DIALOGUE_STORE then
                ((self._data).Function).DialogueStore = 1
              end
            end
            do break end
            -- DECOMPILER ERROR at PC89: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC89: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC89: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

DM_Lover.OnSLoverRedPoint = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  LogInfoFormat("DM_Lover", "state %s", protocol.state)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).redPoint)[protocol.state] = true
end

return DM_Lover

