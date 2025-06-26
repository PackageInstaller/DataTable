-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_undecidedroad.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_UndecidedRoad = class("DM_UndecidedRoad")
DM_UndecidedRoad.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._undecidedroad = (NekoData.Data).undecidedroad
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._undecidedroad).isSeasonOpen = false
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._undecidedroad).seasonData = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._undecidedroad).receiveAward = {}
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._undecidedroad).maxContinueId = 0
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._undecidedroad).totalScore = 0
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._undecidedroad).endTime = 0
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._undecidedroad).trainData = {}
end

DM_UndecidedRoad.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if (self._undecidedroad).gameTimerId then
    (ServerGameTimer.RemoveTask)((self._undecidedroad).gameTimerId)
  end
  for k,v in pairs(self._undecidedroad) do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R6 in 'UnsetPending'

    (self._undecidedroad)[k] = nil
  end
end

DM_UndecidedRoad.OnSSendUndecidedState = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._undecidedroad).isSeasonOpen = protocol.state == 1
  if protocol.state == 0 then
    if not (self._undecidedroad).seasonData then
      return 
    end
    for k,v in pairs((self._undecidedroad).seasonData) do
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

      ((self._undecidedroad).seasonData)[k] = nil
    end
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

DM_UndecidedRoad.OnSOpenUndecidedRoad = function(self, protocol)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if not (self._undecidedroad).seasonData then
    (self._undecidedroad).seasonData = {}
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._undecidedroad).seasonData).seasonId = protocol.seasonId
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._undecidedroad).seasonData).leftTime = protocol.leftTime
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._undecidedroad).seasonData).challengeInfo = protocol.challenge
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._undecidedroad).seasonData).curday = protocol.day - 1
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._undecidedroad).seasonData).battleIds = protocol.battleIds
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._undecidedroad).totalScore = protocol.totalScore
end

DM_UndecidedRoad.OnSOpenRewardList = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._undecidedroad).receiveAward = protocol.receiveAward
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._undecidedroad).maxContinueId = protocol.maxContinueId
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._undecidedroad).totalScore = protocol.score
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._undecidedroad).endTime = protocol.endTime
  if (self._undecidedroad).gameTimerId then
    (ServerGameTimer.RemoveTask)((self._undecidedroad).gameTimerId)
  end
  local leftTime = protocol.endTime - (ServerGameTimer.GetServerTimeForecast)()
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

  if leftTime > 0 then
    (self._undecidedroad).gameTimerId = (ServerGameTimer.AddTask)((math.ceil)(leftTime / 1000), 0, function()
    -- function num : 0_4_0 , upvalues : _ENV, self
    for k,v in pairs((self._undecidedroad).receiveAward) do
      -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'

      ((self._undecidedroad).receiveAward)[k] = nil
    end
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (self._undecidedroad).maxContinueId = 0
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (self._undecidedroad).totalScore = 0
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (self._undecidedroad).endTime = 0
    local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
    if sceneController then
      local dialog = (DialogManager.GetDialog)("mainline.undecidedroad.undecidedroadmaindialog")
      if dialog then
        (DialogManager.DestroySingletonDialog)("mainline.undecidedroad.undecidedroadmaindialog")
      end
    end
  end
)
  else
    for k,v in pairs((self._undecidedroad).receiveAward) do
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R8 in 'UnsetPending'

      ((self._undecidedroad).receiveAward)[k] = nil
    end
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._undecidedroad).maxContinueId = 0
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._undecidedroad).totalScore = 0
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._undecidedroad).endTime = 0
  end
end

DM_UndecidedRoad.OnSreceiveReward = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV
  for k,v in pairs(protocol.rewardIds) do
    (table.insert)((self._undecidedroad).receiveAward, v)
  end
end

DM_UndecidedRoad.OnSOpenTrain = function(self, protocol)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._undecidedroad).trainData = protocol
end

return DM_UndecidedRoad

