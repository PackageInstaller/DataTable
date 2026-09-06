local DM_SummerEchoesActivity = class("DM_SummerEchoesActivity")

function DM_SummerEchoesActivity:Ctor()
  self._data = NekoData.Data.activities.summerechoesActivity
  self:Clear()
end

function DM_SummerEchoesActivity:Clear()
  self._data.constructions = {}
  self._data.snackRedpoint = 0
  self._data.foodStallsData = {}
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
  if self._gameTimerIDRes then
    GameTimer.RemoveTask(self._gameTimerIDRes)
    self._gameTimerIDRes = nil
  end
  self._data.freeReddot = false
  self._data.challengeModeData = {
    totalScore = 0,
    curScore = 0,
    passTime = 0,
    rank = -1
  }
  self._data.receiveAward = {}
  self._data.battleresult = nil
end

function DM_SummerEchoesActivity:OnSGetSummerEchoInfo(protocol)
  self._data.constructions = protocol.constructions
  self._data.snackRedpoint = protocol.snackRedpoint
  self:AddGameTimerForRes()
  if PrintTable then
    PrintTable(self._data.constructions, 3, "self._data.constructions", {
      "__debug__class"
    })
    PrintTable(self._data.constructions, 3, "self._data.constructions", {
      "__debug__class",
      "event",
      "abscissa",
      "vertical",
      "autoExplore"
    })
    local a = 0
    local b = {}
    for _, value in pairs(self._data.constructions) do
      if value.fog == 0 then
        a = a + 1
        table.insert(b, value.ID)
      end
    end
    table.sort(b)
    LogError("FFF", tostring(a))
    PrintTable(b, 3, "FFFA")
  end
end

function DM_SummerEchoesActivity:OnSUpdateEchoEvent(protocol)
  for _, summerevent in pairs(protocol.updates) do
    for _, construction in pairs(self._data.constructions) do
      if construction.ID == summerevent.construction then
        construction.event = summerevent.events
        construction.fog = summerevent.fog
        construction.unlockTime = summerevent.unlockTime
        for _, v in ipairs(summerevent.autoExplore) do
          if not table.contain(construction.autoExplore, v) then
            table.insert(construction.autoExplore, v)
          end
        end
        for _, v in ipairs(construction.event) do
          local index = table.indexof(construction.locked, v)
          if index then
            table.remove(construction.locked, index)
          end
        end
        break
      end
    end
  end
  if PrintTable then
    PrintTable(protocol, 3, "OnSUpdateEchoEvent", {
      "__debug__class"
    })
    PrintTable(self._data.constructions, 3, "self._data.constructions", {
      "__debug__class",
      "event",
      "abscissa",
      "vertical",
      "autoExplore"
    })
    local a = 0
    local b = {}
    for _, value in pairs(self._data.constructions) do
      if value.fog == 0 then
        a = a + 1
        table.insert(b, value.ID)
      end
    end
    table.sort(b)
    LogError("FFF", tostring(a))
    PrintTable(b, 3, "FFFA")
  end
  self:AddGameTimerForRes()
end

function DM_SummerEchoesActivity:OnSSummerEchoEvent(protocol)
end

local function AddGameTimer(self)
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
  if self._data.foodStallsData.leftTime and self._data.foodStallsData.leftTime ~= -1 then
    self._gameTimerID = GameTimer.AddTask(math.ceil(self._data.foodStallsData.leftTime / 1000), 0, function()
      local protocol = LuaNetManager.CreateProtocol("protocol.activity.copenechosnack")
      if protocol then
        protocol:Send()
        return
      end
    end)
  end
end

function DM_SummerEchoesActivity:AddGameTimerForRes()
  if self._gameTimerIDRes then
    GameTimer.RemoveTask(self._gameTimerIDRes)
    self._gameTimerIDRes = nil
  end
  local minTime = math.maxinteger
  for _, value in pairs(self._data.constructions) do
    if value.unlockTime > 0 and minTime > value.unlockTime then
      minTime = value.unlockTime
    end
  end
  if 0 < minTime then
    self._gameTimerIDRes = GameTimer.AddTask(math.ceil(minTime / 1000), 0, function()
      local protocol = LuaNetManager.CreateProtocol("protocol.activity.cupdateechoevent")
      if protocol then
        protocol:Send()
        return
      end
    end)
  end
end

function DM_SummerEchoesActivity:SOpenEchoSnack(protocol)
  if protocol.leftTime ~= -1 then
    self._data.foodStallsData = protocol
    AddGameTimer(self)
  else
    self._data.snackRedpoint = 0
    self._data.foodStallsData = {}
  end
end

function DM_SummerEchoesActivity:OnSEchoShopRedPoint(protocol)
  self._data.freeReddot = true
end

function DM_SummerEchoesActivity:OnSOpenChallengeMode(protocol)
  self._data.challengeModeData = protocol
end

function DM_SummerEchoesActivity:OnSBattleEvent(protocol)
  self._data.eventList = protocol
end

function DM_SummerEchoesActivity:OnSOpenSummerAward(protocol)
  self._data.receiveAward = protocol.receiveAward
  self._data.challengeModeData.totalScore = protocol.score
end

function DM_SummerEchoesActivity:OnSBattleScore(protocol)
  self._data.battleresult = protocol
end

return DM_SummerEchoesActivity
