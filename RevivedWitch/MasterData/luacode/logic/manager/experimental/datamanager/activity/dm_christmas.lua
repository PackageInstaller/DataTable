-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_christmas.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSwimSuitTimeCfg = (BeanManager.GetTableByName)("activity.cswimsuittimecfg")
local ChrisSollect = (BeanManager.GetTableByName)("dungeonselect.cchriscollect")
local CChristmasActivityEvent = require("protocols.def.protocol.activity.cchristmasactivityevent")
local CInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cinterfacefunction")
local DM_Christmas = class("DM_Christmas")
DM_Christmas.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).christmas
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).constructions = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).foodStallsData = {}
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).snackRedpoint = 0
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).showMailRedPoint = false
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).showScoreRedPoint = false
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).Function = {}
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._data).Function).Bag = 0
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._data).Function).Shop = 0
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._data).Function).Mail = 0
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._data).Function).Book = 0
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).scoreData = {}
  self._initScoreData = false
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).roleStatus = {}
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).buffInfo = {}
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).bossTimes = 0
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).canEnterSecond = 0
end

DM_Christmas.Clear = function(self)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).constructions = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).foodStallsData = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).roleStatus = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).Function = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._data).Function).Bag = 0
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._data).Function).Shop = 0
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._data).Function).Mail = 0
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._data).Function).Book = 0
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).snackRedpoint = 0
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).showMailRedPoint = false
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).showScoreRedPoint = false
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).buffInfo = {}
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).bossTimes = 0
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).canEnterSecond = 0
  self:ClearScoreData()
end

DM_Christmas.OnSGetChristmasActivityInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV, CInterfaceFunction, CChristmasActivityEvent
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).constructions = protocol.constructions
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).canEnterSecond = protocol.canEnterSecond
  for _,construction in ipairs((self._data).constructions) do
    if next(construction.event) ~= nil then
      local recorder = CInterfaceFunction:GetRecorder((construction.event)[1])
      if recorder then
        local type = (CInterfaceFunction:GetRecorder((construction.event)[1])).type
        -- DECOMPILER ERROR at PC34: Confused about usage of register: R9 in 'UnsetPending'

        if type == CChristmasActivityEvent.PACKAGE then
          ((self._data).Function).Bag = 1
        else
          -- DECOMPILER ERROR at PC41: Confused about usage of register: R9 in 'UnsetPending'

          if type == CChristmasActivityEvent.DAILY_MAIL then
            ((self._data).Function).Mail = 1
          else
            -- DECOMPILER ERROR at PC48: Confused about usage of register: R9 in 'UnsetPending'

            if type == CChristmasActivityEvent.PLOT_REVIEW then
              ((self._data).Function).Book = 1
            else
              -- DECOMPILER ERROR at PC55: Confused about usage of register: R9 in 'UnsetPending'

              if type == CChristmasActivityEvent.SHOP then
                ((self._data).Function).Shop = 1
              end
            end
          end
        end
      else
        do
          do
            LogErrorFormat("DM_Christmas", "Error Event:%s", (construction.event)[1])
            -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

DM_Christmas.OnSUpdateConstructionEvent = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV, CInterfaceFunction, CChristmasActivityEvent
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

              if type == CChristmasActivityEvent.PACKAGE then
                ((self._data).Function).Bag = 1
                break
              end
              -- DECOMPILER ERROR at PC67: Confused about usage of register: R13 in 'UnsetPending'

              if type == CChristmasActivityEvent.DAILY_MAIL then
                ((self._data).Function).Mail = 1
                break
              end
              -- DECOMPILER ERROR at PC74: Confused about usage of register: R13 in 'UnsetPending'

              if type == CChristmasActivityEvent.PLOT_REVIEW then
                ((self._data).Function).Book = 1
                break
              end
              -- DECOMPILER ERROR at PC81: Confused about usage of register: R13 in 'UnsetPending'

              if type == CChristmasActivityEvent.SHOP then
                ((self._data).Function).Shop = 1
              end
            end
            do break end
            -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

local AddGameTimer = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
  if ((self._data).foodStallsData).leftTime and ((self._data).foodStallsData).leftTime ~= -1 then
    self._gameTimerID = (GameTimer.AddTask)((math.ceil)(((self._data).foodStallsData).leftTime / 1000), 0, function()
    -- function num : 0_4_0 , upvalues : _ENV
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.copenchristmasdinner")
    if protocol then
      protocol:Send()
    end
  end
)
  end
end

DM_Christmas.OnRefreshFoodStallsStatus = function(self, protocol)
  -- function num : 0_5 , upvalues : AddGameTimer
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  if protocol.leftTime ~= -1 then
    (self._data).foodStallsData = protocol
    AddGameTimer(self)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

    if ((self._data).foodStallsData).isOpen == 1 and ((self._data).foodStallsData).used == 0 then
      (self._data).snackRedpoint = 1
    else
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self._data).snackRedpoint = 0
    end
  else
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._data).snackRedpoint = 0
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._data).foodStallsData = {}
  end
end

DM_Christmas.OnSRefreshMailRedPoint = function(self, protocol)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).showMailRedPoint = protocol.redPoint == 1
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_Christmas.ClearScoreData = function(self)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).showScoreRedPoint = false
  if self._initScoreData then
    for type,data in pairs((self._data).scoreData) do
      data.score = 0
      data.showRedDot = false
      for _,v in pairs(data.awards) do
        v.status = 0
      end
    end
  end
end

DM_Christmas.OnSRefreshScore = function(self, protocol)
  -- function num : 0_8 , upvalues : ChrisSollect, _ENV
  self:ClearScoreData()
  if not self._initScoreData then
    self._initScoreData = true
    local allIds = ChrisSollect:GetAllIds()
    for i = 1, #allIds do
      local record = ChrisSollect:GetRecorder(allIds[i])
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R8 in 'UnsetPending'

      if not ((self._data).scoreData)[record.collecttype] then
        ((self._data).scoreData)[record.collecttype] = {score = 0, 
awards = {}
, showRedDot = false}
      end
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((((self._data).scoreData)[record.collecttype]).awards)[record.id] = {record = record, status = 0}
    end
  end
  do
    for scoreType,v in pairs(protocol.scoreRewards) do
      local data = ((self._data).scoreData)[scoreType]
      if data then
        data.score = v.score
        for _,id in ipairs(v.receiveAward) do
          -- DECOMPILER ERROR at PC64: Confused about usage of register: R13 in 'UnsetPending'

          if (data.awards)[id] then
            ((data.awards)[id]).status = 2
          else
            LogErrorFormat("DM_Christmas", "scoreAwardId: %s is error.", id)
          end
        end
      else
        do
          do
            LogErrorFormat("DM_Christmas", "scoreType: %s is error.", scoreType)
            -- DECOMPILER ERROR at PC79: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC79: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC79: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    for scoreType,v in pairs((self._data).scoreData) do
      for id,data in pairs(v.awards) do
        -- DECOMPILER ERROR at PC99: Confused about usage of register: R12 in 'UnsetPending'

        if data.status ~= 2 then
          if (data.record).collectrequirenum <= v.score then
            (self._data).showScoreRedPoint = true
            data.status = 1
            v.showRedDot = true
          else
            data.status = 0
          end
        end
      end
    end
  end
end

DM_Christmas.OnSUpdateRolesStatus = function(self, roleStatus)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).roleStatus = roleStatus
end

DM_Christmas.OnSGetBuffInfo = function(self, protocol)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).buffInfo = protocol.buffIds
end

DM_Christmas.OnSChristmasBossTimes = function(self, protocol)
  -- function num : 0_11
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).bossTimes = protocol.times
end

return DM_Christmas

