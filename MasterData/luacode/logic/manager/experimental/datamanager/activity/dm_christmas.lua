local CSwimSuitTimeCfg = BeanManager.GetTableByName("activity.cswimsuittimecfg")
local ChrisSollect = BeanManager.GetTableByName("dungeonselect.cchriscollect")
local CChristmasActivityEvent = require("protocols.def.protocol.activity.cchristmasactivityevent")
local CInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cinterfacefunction")
local DM_Christmas = class("DM_Christmas")

function DM_Christmas:Ctor()
  self._data = NekoData.Data.activities.christmas
  self._data.constructions = {}
  self._data.foodStallsData = {}
  self._data.snackRedpoint = 0
  self._data.showMailRedPoint = false
  self._data.showScoreRedPoint = false
  self._data.Function = {}
  self._data.Function.Bag = 0
  self._data.Function.Shop = 0
  self._data.Function.Mail = 0
  self._data.Function.Book = 0
  self._data.scoreData = {}
  self._initScoreData = false
  self._data.roleStatus = {}
  self._data.buffInfo = {}
  self._data.bossTimes = 0
  self._data.canEnterSecond = 0
end

function DM_Christmas:Clear()
  self._data.constructions = {}
  self._data.foodStallsData = {}
  self._data.roleStatus = {}
  self._data.Function = {}
  self._data.Function.Bag = 0
  self._data.Function.Shop = 0
  self._data.Function.Mail = 0
  self._data.Function.Book = 0
  self._data.snackRedpoint = 0
  self._data.showMailRedPoint = false
  self._data.showScoreRedPoint = false
  self._data.buffInfo = {}
  self._data.bossTimes = 0
  self._data.canEnterSecond = 0
  self:ClearScoreData()
end

function DM_Christmas:OnSGetChristmasActivityInfo(protocol)
  self._data.constructions = protocol.constructions
  self._data.canEnterSecond = protocol.canEnterSecond
  for _, construction in ipairs(self._data.constructions) do
    if next(construction.event) ~= nil then
      local recorder = CInterfaceFunction:GetRecorder(construction.event[1])
      if recorder then
        local type = CInterfaceFunction:GetRecorder(construction.event[1]).type
        if type == CChristmasActivityEvent.PACKAGE then
          self._data.Function.Bag = 1
        elseif type == CChristmasActivityEvent.DAILY_MAIL then
          self._data.Function.Mail = 1
        elseif type == CChristmasActivityEvent.PLOT_REVIEW then
          self._data.Function.Book = 1
        elseif type == CChristmasActivityEvent.SHOP then
          self._data.Function.Shop = 1
        end
      else
        LogErrorFormat("DM_Christmas", "Error Event:%s", construction.event[1])
      end
    end
  end
end

function DM_Christmas:OnSUpdateConstructionEvent(protocol)
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
          if type == CChristmasActivityEvent.PACKAGE then
            self._data.Function.Bag = 1
            break
          end
          if type == CChristmasActivityEvent.DAILY_MAIL then
            self._data.Function.Mail = 1
            break
          end
          if type == CChristmasActivityEvent.PLOT_REVIEW then
            self._data.Function.Book = 1
            break
          end
          if type == CChristmasActivityEvent.SHOP then
            self._data.Function.Shop = 1
          end
        end
        break
      end
    end
  end
end

local function AddGameTimer(self)
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
  if self._data.foodStallsData.leftTime and self._data.foodStallsData.leftTime ~= -1 then
    self._gameTimerID = GameTimer.AddTask(math.ceil(self._data.foodStallsData.leftTime / 1000), 0, function()
      local protocol = LuaNetManager.CreateProtocol("protocol.activity.copenchristmasdinner")
      if protocol then
        protocol:Send()
      end
    end)
  end
end

function DM_Christmas:OnRefreshFoodStallsStatus(protocol)
  if protocol.leftTime ~= -1 then
    self._data.foodStallsData = protocol
    AddGameTimer(self)
    if self._data.foodStallsData.isOpen == 1 and self._data.foodStallsData.used == 0 then
      self._data.snackRedpoint = 1
    else
      self._data.snackRedpoint = 0
    end
  else
    self._data.snackRedpoint = 0
    self._data.foodStallsData = {}
  end
end

function DM_Christmas:OnSRefreshMailRedPoint(protocol)
  self._data.showMailRedPoint = protocol.redPoint == 1
end

function DM_Christmas:ClearScoreData()
  self._data.showScoreRedPoint = false
  if self._initScoreData then
    for type, data in pairs(self._data.scoreData) do
      data.score = 0
      data.showRedDot = false
      for _, v in pairs(data.awards) do
        v.status = 0
      end
    end
  end
end

function DM_Christmas:OnSRefreshScore(protocol)
  self:ClearScoreData()
  if not self._initScoreData then
    self._initScoreData = true
    local allIds = ChrisSollect:GetAllIds()
    for i = 1, #allIds do
      local record = ChrisSollect:GetRecorder(allIds[i])
      if not self._data.scoreData[record.collecttype] then
        self._data.scoreData[record.collecttype] = {
          score = 0,
          awards = {},
          showRedDot = false
        }
      end
      self._data.scoreData[record.collecttype].awards[record.id] = {record = record, status = 0}
    end
  end
  for scoreType, v in pairs(protocol.scoreRewards) do
    local data = self._data.scoreData[scoreType]
    if data then
      data.score = v.score
      for _, id in ipairs(v.receiveAward) do
        if data.awards[id] then
          data.awards[id].status = 2
        else
          LogErrorFormat("DM_Christmas", "scoreAwardId: %s is error.", id)
        end
      end
    else
      LogErrorFormat("DM_Christmas", "scoreType: %s is error.", scoreType)
    end
  end
  for scoreType, v in pairs(self._data.scoreData) do
    for id, data in pairs(v.awards) do
      if data.status ~= 2 then
        if v.score >= data.record.collectrequirenum then
          self._data.showScoreRedPoint = true
          data.status = 1
          v.showRedDot = true
        else
          data.status = 0
        end
      end
    end
  end
end

function DM_Christmas:OnSUpdateRolesStatus(roleStatus)
  self._data.roleStatus = roleStatus
end

function DM_Christmas:OnSGetBuffInfo(protocol)
  self._data.buffInfo = protocol.buffIds
end

function DM_Christmas:OnSChristmasBossTimes(protocol)
  self._data.bossTimes = protocol.times
end

return DM_Christmas
