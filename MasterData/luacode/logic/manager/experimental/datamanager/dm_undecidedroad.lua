local DM_UndecidedRoad = class("DM_UndecidedRoad")

function DM_UndecidedRoad:Ctor()
  self._undecidedroad = NekoData.Data.undecidedroad
  self._undecidedroad.isSeasonOpen = false
  self._undecidedroad.seasonData = {}
  self._undecidedroad.receiveAward = {}
  self._undecidedroad.maxContinueId = 0
  self._undecidedroad.totalScore = 0
  self._undecidedroad.endTime = 0
  self._undecidedroad.trainData = {}
end

function DM_UndecidedRoad:Clear()
  if self._undecidedroad.gameTimerId then
    ServerGameTimer.RemoveTask(self._undecidedroad.gameTimerId)
  end
  for k, v in pairs(self._undecidedroad) do
    self._undecidedroad[k] = nil
  end
end

function DM_UndecidedRoad:OnSSendUndecidedState(protocol)
  self._undecidedroad.isSeasonOpen = protocol.state == 1
  if protocol.state == 0 then
    if not self._undecidedroad.seasonData then
      return
    end
    for k, v in pairs(self._undecidedroad.seasonData) do
      self._undecidedroad.seasonData[k] = nil
    end
  end
end

function DM_UndecidedRoad:OnSOpenUndecidedRoad(protocol)
  if not self._undecidedroad.seasonData then
    self._undecidedroad.seasonData = {}
  end
  self._undecidedroad.seasonData.seasonId = protocol.seasonId
  self._undecidedroad.seasonData.leftTime = protocol.leftTime
  self._undecidedroad.seasonData.challengeInfo = protocol.challenge
  self._undecidedroad.seasonData.curday = protocol.day - 1
  self._undecidedroad.seasonData.battleIds = protocol.battleIds
  self._undecidedroad.totalScore = protocol.totalScore
end

function DM_UndecidedRoad:OnSOpenRewardList(protocol)
  self._undecidedroad.receiveAward = protocol.receiveAward
  self._undecidedroad.maxContinueId = protocol.maxContinueId
  self._undecidedroad.totalScore = protocol.score
  self._undecidedroad.endTime = protocol.endTime
  if self._undecidedroad.gameTimerId then
    ServerGameTimer.RemoveTask(self._undecidedroad.gameTimerId)
  end
  local leftTime = protocol.endTime - ServerGameTimer.GetServerTimeForecast()
  if 0 < leftTime then
    self._undecidedroad.gameTimerId = ServerGameTimer.AddTask(math.ceil(leftTime / 1000), 0, function()
      for k, v in pairs(self._undecidedroad.receiveAward) do
        self._undecidedroad.receiveAward[k] = nil
      end
      self._undecidedroad.maxContinueId = 0
      self._undecidedroad.totalScore = 0
      self._undecidedroad.endTime = 0
      local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
      if sceneController then
        local dialog = DialogManager.GetDialog("mainline.undecidedroad.undecidedroadmaindialog")
        if dialog then
          DialogManager.DestroySingletonDialog("mainline.undecidedroad.undecidedroadmaindialog")
        end
      end
    end)
  else
    for k, v in pairs(self._undecidedroad.receiveAward) do
      self._undecidedroad.receiveAward[k] = nil
    end
    self._undecidedroad.maxContinueId = 0
    self._undecidedroad.totalScore = 0
    self._undecidedroad.endTime = 0
  end
end

function DM_UndecidedRoad:OnSreceiveReward(protocol)
  for k, v in pairs(protocol.rewardIds) do
    table.insert(self._undecidedroad.receiveAward, v)
  end
end

function DM_UndecidedRoad:OnSOpenTrain(protocol)
  self._undecidedroad.trainData = protocol
end

return DM_UndecidedRoad
