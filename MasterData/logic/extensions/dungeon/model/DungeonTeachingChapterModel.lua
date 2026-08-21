-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/DungeonTeachingChapterModel.lua

module("logic.extensions.dungeon.model.DungeonTeachingChapterModel", package.seeall)

local M = class("DungeonTeachingChapterModel", BaseModel)
local kTeachDungeonFailCountKey = "teach_dungeon_fail_count"

function M:ctor()
	M.super.ctor(self)
	BattleDispatcher:addEventListener(BattleEventType.OnFailTimesUpdate, self._onFailTimesUpdate, self)
	BattleDispatcher:addEventListener(BattleEventType.OnBattleFinish, self._onBattleFinish, self)
end

function M:onReset()
	self._dungeonMoList = {}
	self._unlockDungeonIds = {}
	self._chapterList = {}
	self._dungeonPreDungeonIdList = {}
	self._dungeonToChapterId = {}
	self._dungeonIdToMaterialDungeonId = {}

	local chapterCfg = DungeonConfig.instance:getCfgTeachingChapter()

	for k, chapterCo in ipairs(chapterCfg) do
		local chapterMo = TeachingChapterMO.New(chapterCo)

		self._chapterList[chapterCo.chapterId] = chapterMo

		local preDungeonId

		for i, v in ipairs(chapterMo:getDungeonIds()) do
			self._dungeonPreDungeonIdList[v] = preDungeonId
			preDungeonId = v
			self._dungeonToChapterId[v] = chapterCo.chapterId
		end
	end
end

function M:onInit()
	self:onReset()
end

function M:initRewardTaken(StarTakenMainlineNOList)
	for i, v in ipairs(StarTakenMainlineNOList) do
		local chapterMo = self:getChapterMoByChapterId(v.chapter)

		if chapterMo then
			chapterMo:initRewardTaken(v.stars)
		end
	end
end

function M:initUnlockDungeon(unlockDungeonIds)
	for i, v in ipairs(unlockDungeonIds) do
		self._unlockDungeonIds[v] = true
	end
end

function M:takeOneReward(chapter, index)
	local chapterMo = self:getChapterMoByChapterId(chapter)

	if chapterMo then
		chapterMo:setRewardTaken(index)
	end
end

function M:getChapterMoByChapterId(id)
	return self._chapterList[id]
end

function M:getAllChapter()
	return self._chapterList
end

function M:getDungeonMoById(dungeonId)
	if not self._dungeonMoList[dungeonId] then
		local dungeonCo = DungeonConfig.instance:getDungeonCfgById(dungeonId)

		if not dungeonCo then
			return
		end

		local dungeonMo = TeachingDungeonMO.New()

		dungeonMo:initByConfig(dungeonCo)
		dungeonMo:initByAgent(DungeonModel.instance:getDungeonPassDataByDungeonId(dungeonId))
		dungeonMo:setPreDungeonId(self._dungeonPreDungeonIdList[dungeonId])
		dungeonMo:setChapterIdAndDifficulty(self._dungeonToChapterId[dungeonId])

		self._dungeonMoList[dungeonId] = dungeonMo
	end

	return self._dungeonMoList[dungeonId]
end

function M:setClickChapterIdAndDungeonIndex(chapterId, index)
	self._curClickChapterId = chapterId
	self._curDungeonIndex = index
end

function M:getClickChapterIdAndDungeonIndex()
	return self._curClickChapterId, self._curDungeonIndex
end

function M:getIsInUnlockedDungeonList(dungeonId)
	return self._unlockDungeonIds[dungeonId]
end

function M:hasMetPassTipsConditions(dungeonMO)
	local teachCO = dungeonMO:geteachingDungeonCO()

	if not teachCO.conditions or teachCO.tipsContent == "" then
		return false
	end

	if teachCO.conditions.type == 1 and self:getTeachFailCount(dungeonMO:getId()) >= teachCO.conditions.count then
		return true
	end

	return false
end

function M:_onFailTimesUpdate()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	if dungeonCode then
		local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)

		if dungeonMO and not dungeonMO:hasPassed() and dungeonMO:getType() == CommEnum.DungeonType.Teaching then
			local model = BattleMgr.instance:getModel()
			local isInReady = model:getPhase() == BattleEnum.Phase.READY

			if not isInReady then
				self:addTeachFailCount(dungeonCode)
			end
		end
	end
end

function M:_onBattleFinish(_, isWin)
	if isWin then
		local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

		if dungeonCode then
			local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)

			if dungeonMO and dungeonMO:getType() == CommEnum.DungeonType.Teaching then
				self:deleteTeachFailCount(dungeonCode)
			end
		end
	end
end

function M:getTeachFailCount(dungeonId)
	local key = string.format("%s_%s_%s", kTeachDungeonFailCountKey, PlayerModel.instance:getId(), dungeonId)

	return Astral.LocalStorage.Instance:GetInt(key, 0)
end

function M:addTeachFailCount(dungeonId)
	local key = string.format("%s_%s_%s", kTeachDungeonFailCountKey, PlayerModel.instance:getId(), dungeonId)
	local count = Astral.LocalStorage.Instance:GetInt(key, 0)

	Astral.LocalStorage.Instance:SetInt(key, count + 1)
end

function M:deleteTeachFailCount(dungeonId)
	local key = string.format("%s_%s_%s", kTeachDungeonFailCountKey, PlayerModel.instance:getId(), dungeonId)

	Astral.LocalStorage.Instance:DeleteKey(key)
end

M.instance = M.New()

return M
