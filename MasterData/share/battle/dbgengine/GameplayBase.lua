local System = require("System.System")
local BattleConst = require("Battle.BattleConst")
local GameplayBase = System.NewClass("GameplayBase")

function GameplayBase:ctor(battleEngine)
  self.battleEngine = battleEngine
  self.logger = self.battleEngine.logger
  self.battleInitData = battleEngine.initData
  self:Init()
end

function GameplayBase:Init()
  self:OnInit()
end

function GameplayBase:InitBattle()
  self:OnInitBattle()
end

function GameplayBase:AfterBattleInit()
  self:OnAfterBattleInit()
end

function GameplayBase:BattleBegin()
  self:OnBattleBegin()
end

function GameplayBase:AfterBattleBegin()
  self:OnAfterBattleBegin()
end

function GameplayBase:BattleFinish(winCamp, battleFinishData)
  self:OnBattleFinish(winCamp, battleFinishData)
end

function GameplayBase:OnInit()
end

function GameplayBase:StartBattle(playerId)
end

function GameplayBase:OnInitBattle()
end

function GameplayBase:OnAfterBattleInit()
end

function GameplayBase:OnBattleBegin()
end

function GameplayBase:OnAfterBattleBegin()
end

function GameplayBase:OnBattleFinish(winCamp, battleFinishData)
end

function GameplayBase:GetTargetModel()
  return self.targetModel
end

function GameplayBase:SetTargetModel(playerUid, model)
  self.targetModel = model
  self.battleEngine.instantRecordMgr:OnSwitchTargetModel(playerUid, model)
end

return GameplayBase
