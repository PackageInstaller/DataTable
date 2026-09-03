-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/model/StageManager.lua

StageType = {
	kElite = "ELITE",
	kHard = "HARD",
	kNormal = "NORMAL"
}
kHeroStroy = "HEROSTORY"
StageTypeNumToDesc = {
	"NORMAL",
	"ELITE",
	"HARD"
}
StageManager = class("StageManager", objectlua.Object, _M)

StageManager:has("_player", {
	is = "rw"
})

function StageManager:initialize()
	super.initialize(self)

	self._stagesMap = {}
	self._stagesMap[StageType.kNormal] = CommonStage:new()
	self._stagesMap[StageType.kElite] = EliteStage:new()
	self._stagesMap[kHeroStroy] = HeroStory:new()

	for type, stage in pairs(self._stagesMap) do
		if stage then
			stage:setOwner(self)
			stage:setType(type)
		end
	end
end

function StageManager:dispose()
	super.dispose(self)
end

function StageManager:getStage(stageType)
	if type(stageType) == "number" then
		stageType = StageTypeNumToDesc[stageType]
	end

	return self._stagesMap[stageType]
end

function StageManager:sync(data)
	data = data or {}

	local stagesMap = self._stagesMap

	for type, stage in pairs(stagesMap) do
		if stage and stage.sync then
			stage:sync(data[type])
		end
	end
end

function StageManager:syncHeroStory(data)
	local heroStory = self._stagesMap[kHeroStroy]

	heroStory:syncHeroStory(data)
end

function StageManager:checkEliteMapIsUnlock(mapindex)
	if not mapindex then
		return false
	end

	local normalStageMap = self._stagesMap[StageType.kNormal]:getMapByIndex(mapindex)

	if not normalStageMap then
		return false
	end

	local lastPoint = normalStageMap:getPointByIndex(normalStageMap:getPointCount())

	return lastPoint:isPass()
end

function StageManager:eliteStageExtraInit()
	local eliteStage = self._stagesMap[StageType.kElite]

	eliteStage:eliteStageExtraInit()
end

function StageManager:getAllStageStar()
	local comStar = self._stagesMap[StageType.kNormal]:getStageStar()
	local eliteStar = self._stagesMap[StageType.kElite]:getStageStar()

	return comStar + eliteStar
end
