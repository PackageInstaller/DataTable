local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleEngineData = System.NewClass("BattleEngineData")

function BattleEngineData.Create(initData)
  local data = {}
  data._genUid = initData._genUid or 0
  data.gearType = initData.gearType
  data.battlePhase = bc.BattlePhase.None
  data.isIntro = initData.isIntro
  data.battleTid = initData.battleTid
  data.stageId = initData.stageId
  data.difficultyId = initData.difficultyId
  data.passTime = 0
  data.gameSpeed = initData.gameSpeed or 1
  data.curMoney = initData.curMoney or 0
  data.stress = initData.stress or 0
  data.keeperSkill = initData.keeperSkill
  data.finishCb = initData.finishCb
  data.objSet = {}
  data.IsInit = false
  data.cards = initData.cards
  data.isReview = false
  data.stateList = initData.stateList
  data.relics = initData.relics
  data.isMock = initData.isMock
  data.gender = initData.gender
  data.mockWeaponList = initData.mockWeaponList
  data.playerName = initData.playerName
  data.skipTimer = initData.skipTimer
  data.battleUuid = initData.battleUuid
  data.talentList = initData.talentList or {}
  data.needReview = initData.needReview
  data.globalVariable = initData.globalVariable or {}
  data.isMoreGame = initData.isMoreGame
  data.isFriendGame = initData.isFriendGame
  data.draftRelicTid = initData.draftRelicTid
  data.mapNodeGroupId = initData.mapNodeGroupId or 0
  data.respawnCost = initData.respawnCost or 1
  return data
end

return BattleEngineData
