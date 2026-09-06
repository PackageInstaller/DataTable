local CSwimSuitTimeCfg = BeanManager.GetTableByName("activity.cswimsuittimecfg")
local DM_SummerActivity = class("DM_SummerActivity")

function DM_SummerActivity:Ctor()
  self._data = NekoData.Data.activities.summerActivity
  self._data.constructions = {}
  self._data.shopConstructionList = {}
  self._data.storageConstructionList = {}
  self._data.foodStallsData = {}
  self._data.missions = {}
  self._data.Timer = nil
  self._data.freeReddot = false
end

function DM_SummerActivity:Clear()
  NekoData.Data.activities.summerActivity = {}
  self._data.constructions = {}
  self._data.shopConstructionList = {}
  self._data.storageConstructionList = {}
  self._data.foodStallsData = {}
  self._data.missions = {}
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
  self._data.freeReddot = false
end

function DM_SummerActivity:OnSGetSummerActivityInfo(protocol)
  if self._data.state then
    self._data.state_Old = self._data.state
  end
  self._data.timeProgress = protocol.sunlight
  self._data.state = protocol.state
  self._data.constructions = protocol.constructions
  self._data.missions = protocol.missions
  self._data.constructionRedpoint = protocol.constructionRedpoint
  self._data.snackRedpoint = protocol.snackRedpoint
  self._data.timeRecorder = CSwimSuitTimeCfg:GetRecorder(self._data.state)
end

function DM_SummerActivity:OnSUpdateSummerConstruction(protocol)
  if protocol.result == 1 then
    if protocol.construction.level == 1 then
      table.insert(self._data.constructions, protocol.construction)
      return
    end
    for i, v in ipairs(self._data.constructions) do
      if v.ID == protocol.construction.ID then
        v.level = protocol.construction.level
        v.vertical = protocol.construction.vertical
        v.abscissa = protocol.construction.abscissa
        v.event = protocol.construction.event
        v.canlvup = protocol.construction.canlvup
        v.event2lock = protocol.construction.event2lock
        v.locked = protocol.construction.locked
        break
      end
    end
  end
end

function DM_SummerActivity:OnSGetSummerConstructionUpdateList(protocol)
  self._data.shopConstructionList = protocol.constructionList
  self._data.storageConstructionList = protocol.constructionList
end

function DM_SummerActivity:OnSMoveSummerConstruction(protocol)
  if protocol.result == 1 then
    for i, v in ipairs(self._data.constructions) do
      if v.ID == protocol.ID then
        v.level = protocol.level
        v.vertical = protocol.vertical
        v.abscissa = protocol.abscissa
        break
      end
    end
  end
end

function DM_SummerActivity:OnSUpdateConstructionEvent(protocol)
  for i, summerevent in ipairs(protocol.updates) do
    for i, construction in ipairs(self._data.constructions) do
      if construction.ID == summerevent.construction then
        construction.event = summerevent.events
        for i, v in ipairs(summerevent.autoExplore) do
          table.insert(construction.autoExplore, v)
        end
        for i, v in ipairs(construction.event) do
          local index = table.indexof(construction.locked, v)
          if index then
            table.remove(construction.locked, index)
          end
        end
        break
      end
    end
  end
  for i, summerevent in ipairs(protocol.updateConstructions) do
    for i, construction in ipairs(self._data.constructions) do
      if construction.ID == summerevent.construction then
        construction.canlvup = summerevent.canlvup
        construction.event2lock = summerevent.unlockEvent
        break
      end
    end
  end
end

function DM_SummerActivity:OnSUpdateSummerMissions(protocol)
  for i, v in ipairs(protocol.missions) do
    local flag = false
    for j, mission in ipairs(self._data.missions) do
      if v.ID == mission.ID then
        self._data.missions[j] = v
        flag = true
        break
      end
    end
    if not flag then
      table.insert(self._data.missions, v)
    end
  end
  self._data.timeProgress = protocol.sunlight
end

local function AddGameTimer(self)
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
  if self._data.foodStallsData.leftTime and self._data.foodStallsData.leftTime ~= -1 then
    self._gameTimerID = GameTimer.AddTask(math.ceil(self._data.foodStallsData.leftTime / 1000), 0, function()
      local protocol = LuaNetManager.CreateProtocol("protocol.activity.copensnackshop")
      if protocol then
        protocol:Send()
        return
      end
    end)
  end
end

function DM_SummerActivity:OnRefreshFoodStallsStatus(protocol)
  if protocol.leftTime ~= -1 then
    self._data.foodStallsData = protocol
    AddGameTimer(self)
  else
    self._data.snackRedpoint = 0
    self._data.foodStallsData = {}
  end
end

function DM_SummerActivity:OnSActivityShopRedDot(protocol)
  self._data.freeReddot = true
end

return DM_SummerActivity
