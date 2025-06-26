require "GameLogic.Battle.Common.BattleConstants"
require "GameLogic.Battle.Common.BattleMessages"
require "GameLogic.Battle.Data.Unit"
require "GameLogic.Battle.Data.Character"
BattleUtil = require "GameLogic.Battle.Util.BattleUtil"
BattleCalculator = require "GameLogic.Battle.Util.BattleCalculator"

BattleDataManager = require "GameLogic.Battle.Common.BattleDataManager"
BattleDataManager:GetInstance()

BattleEffectManager = require "GameLogic.Battle.SkillLogic.EffectManager"
BattleEffectManager:GetInstance()

BattleTriggerManager = require "GameLogic.Battle.SkillLogic.TriggerManager"
BattleTriggerManager:GetInstance()

BattleConditionManager = require "GameLogic.Battle.SkillLogic.ConditionManager"
BattleConditionManager:GetInstance()


