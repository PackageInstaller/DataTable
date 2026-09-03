-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/model/StagePracticePoint.lua

StagePracticePlayerInfo = class("StagePracticePlayerInfo", objectlua.Object, _M)

StagePracticePlayerInfo:has("_headImg", {
	is = "r"
})
StagePracticePlayerInfo:has("_name", {
	is = "r"
})
StagePracticePlayerInfo:has("_time", {
	is = "r"
})
StagePracticePlayerInfo:has("_isFirstPass", {
	is = "r"
})
StagePracticePlayerInfo:has("_starCount", {
	is = "rw"
})

function StagePracticePlayerInfo:initialize()
	super.initialize(self)

	self._headImg = ""
	self._name = ""
	self._time = 0
	self._isFirstPass = false
end

function StagePracticePlayerInfo:hasInfo()
	return self._headImg ~= ""
end

function StagePracticePlayerInfo:sync(data)
	if data.avatar then
		self._headImg = data.avatar
	end

	if data.nickname then
		self._name = data.nickname
	end

	if data.nickname then
		self._name = data.nickname
	end

	if data.value then
		self._time = data.value
	end

	self._isFirstPass = true
end

StagePracticePoint = class("StagePracticePoint", objectlua.Object, _M)

StagePracticePoint:has("_id", {
	is = "rw"
})
StagePracticePoint:has("_config", {
	is = "r"
})
StagePracticePoint:has("_team", {
	is = "r"
})
StagePracticePoint:has("_star", {
	is = "r"
})
StagePracticePoint:has("_lockState", {
	is = "r"
})
StagePracticePoint:has("_playerInfo", {
	is = "r"
})
StagePracticePoint:has("_firstPassState", {
	is = "r"
})
StagePracticePoint:has("_fullStarReward", {
	is = "r"
})
StagePracticePoint:has("_teamBook", {
	is = "r"
})
StagePracticePoint:has("_mapId", {
	is = "r"
})
StagePracticePoint:has("_passed", {
	is = "r"
})
StagePracticePoint:has("_starIds", {
	is = "r"
})
StagePracticePoint:has("_hasPlay", {
	is = "r"
})

SPracticePointType = {
	kCHALLENGE = "CHALLENGE",
	kTEACH = "TEACH"
}

function StagePracticePoint:initialize(id, mapId)
	super.initialize(self)

	self._id = id
	self._mapId = mapId
	self._config = ConfigReader:getRecordById("StagePracticePoint", tostring(id))
	self._team = Team:new({
		teamId = 0,
		teamType = ""
	})
	self._star = 0
	self._lockState = StagePracticeLockState.kLock
	self._firstPassState = SPracticeRewardState.kNotCanGet
	self._fullStarReward = SPracticeRewardState.kNotCanGet
	self._playerInfo = StagePracticePlayerInfo:new()
	self._starIds = {}
	self._hasPlay = false
end

function StagePracticePoint:initTeam()
	local formation = self:getFormation()
	local teamData = {}

	for pos = 1, #formation do
		local member = self._team:getMember(pos)
		local data = formation[pos]

		if data.type == "INIT" or data.type == "FIXED" then
			teamData[tostring(pos)] = data.id
		end
	end

	local subData = {}
	local subFixed = self:getSubFixed()

	for pos = 1, #subFixed do
		subData[tostring(pos)] = subFixed[pos]
	end

	self._team:sync({
		waves = {
			teamData
		},
		sub = subData
	})
end

function StagePracticePoint:sync(data)
	self._hasPlay = true

	if data.passed then
		self._passed = data.passed
	end

	if data.starIds then
		self._starIds = {}

		for _, value in pairs(data.starIds) do
			self._starIds[value] = true
		end
	end

	if data.firstPassReward then
		self._firstPassState = data.firstPassReward
	end

	if data.fullStarReward then
		self._fullStarReward = data.fullStarReward
	end

	if data.stars then
		self._star = data.stars
	end

	if data.teams then
		self._team:synchronize(data.teams)
	end

	self._lockState = StagePracticeLockState.kUnLock
end

function StagePracticePoint:isLock()
	return self._lockState == StagePracticeLockState.kLock
end

function StagePracticePoint:hasRedPoint()
	return self._firstPassState == SPracticeRewardState.kCanGet
end

function StagePracticePoint:haseGetReward()
	return self._hasGetReward == SPracticeRewardState.kHasGet
end

function StagePracticePoint:hasGuidance()
	local guidance = self:getGuidance()

	if type(guidance) == "table" and #guidance > 0 then
		return true
	end

	return false
end

function StagePracticePoint:recordOldStar()
	self._oldStar = self._starCount or 0
end

function StagePracticePoint:getStarCondDescs()
	local list = {}
	local conditionDes = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Stage_StarConditionDesc", "content")
	local starIds = self:getStarIds()
	local starCondition = self:getStarCondition()

	for i = 1, #starCondition do
		local condition = starCondition[i]
		local textStr = Strings:get(conditionDes[condition.type], condition)

		list[i] = {
			desc = textStr,
			pass = starIds[i] ~= nil
		}
	end

	return list
end

function StagePracticePoint:getName()
	return Strings:get(self._config.Name)
end

function StagePracticePoint:getStageDesc()
	return Strings:get(self._config.StageDesc)
end

function StagePracticePoint:getStageWinCondition()
	return Strings:get(self._config.VictoryDesc)
end

function StagePracticePoint:getStageHeroNum()
	return self._config.HeroNumber
end

function StagePracticePoint:getStageHardLevel()
	return self._config.DifficultyLevel
end

function StagePracticePoint:getEnemysOccupation()
	local occupations = {}
	local heroids = ConfigReader:getDataByNameIdAndKey("EnemyCard", self._config.EnemyHero, "CardCollection")

	for k, v in pairs(heroids) do
		occupations[k] = ConfigReader:getDataByNameIdAndKey("EnemyHero", v, "Type")
	end

	return occupations
end

function StagePracticePoint:getPrePoint()
	return self._config.PrePoint
end

function StagePracticePoint:getHeroNumber()
	local battleMatrixId = self._config.BattleMatrix

	return (ConfigReader:getDataByNameIdAndKey("BattleMatrix", battleMatrixId, "Martrix"))
end

function StagePracticePoint:getSubstitute()
	local battleMatrixId = self._config.BattleMatrix

	return (ConfigReader:getDataByNameIdAndKey("BattleMatrix", battleMatrixId, "Substitution"))
end

function StagePracticePoint:getBattleField()
	local battleMatrixId = self._config.BattleMatrix

	return (ConfigReader:getDataByNameIdAndKey("BattleMatrix", battleMatrixId, "BattleField"))
end

function StagePracticePoint:getPassReward()
	return self._config.PassReward
end

function StagePracticePoint:getCost()
	return self._config.Cost
end

function StagePracticePoint:getRoleModel()
	return self._config.RoleModel
end

function StagePracticePoint:getImg()
	return self._config.Img
end

function StagePracticePoint:getLosePrompt()
	return self._config.LosePrompt
end

function StagePracticePoint:getGuidance()
	return self._config.Guidance
end

function StagePracticePoint:getSpecialRules()
	return self._config.SpecialRules or {}
end

function StagePracticePoint:needPopGuidance()
	return self._config.PopGuidance == 1 and self._star < 1
end

function StagePracticePoint:getGuidanceEnemy()
	return self._config.GuidanceEnemy
end

function StagePracticePoint:getIcon()
	return self._config.Icon
end

function StagePracticePoint:getPlayerEnergy()
	local stageBattleId = self._config.StageBattleConfig

	return (ConfigReader:getDataByNameIdAndKey("BattleConfig", stageBattleId, "StageEnergy"))
end

function StagePracticePoint:getStarCondition()
	return self._config.StarCondition
end

function StagePracticePoint:getUnlockCondition()
	return self._config.UnlockCondition
end

function StagePracticePoint:getType()
	return self._config.Type
end

function StagePracticePoint:getGuideDesc()
	return self._config.StageDesc
end

function StagePracticePoint:getPointIndex(mapid, pid)
	self._pindex = mapid .. "." .. pid

	return self._pindex
end

function StagePracticePoint:getPointId()
	if not self._pindex then
		return "1.1"
	end

	return self._pindex
end
