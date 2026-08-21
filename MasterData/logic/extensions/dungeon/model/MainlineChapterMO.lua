-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/MainlineChapterMO.lua

module("logic.extensions.dungeon.model.MainlineChapterMO", package.seeall)

local M = class("MainlineChapterMO", DungeonChapterMO)

function M:ctor(chapterCo)
	self.super.ctor(self, chapterCo)

	self._difficulty = chapterCo.difficulty
	self._branchlineDungeonIds = chapterCo.branchlineDungeonIds or {}
	self._starRewardRequire = chapterCo.starRewardRequire
	self._starReward = chapterCo.starReward
	self._sceneCode = chapterCo.sceneCode
	self._sceneRange = chapterCo.sceneRange
	self._sceneCameraRotationY = chapterCo.sceneCameraRotationY
	self._allBranchlineDungeonIds = {}

	for i, list in ipairs(self._branchlineDungeonIds) do
		for _, id in ipairs(list) do
			table.insert(self._allBranchlineDungeonIds, id)
		end
	end

	self._allDungeonIds = {}

	for i, v in ipairs(self._dungeonIds) do
		self._allDungeonIds[i] = v
	end

	for i, list in ipairs(self._branchlineDungeonIds) do
		for j, id in ipairs(list) do
			self._allDungeonIds[i * 100 + j] = id
		end
	end
end

function M:getChapterDifficulty()
	return self._difficulty
end

function M:getDungeonIds()
	return self._allDungeonIds
end

function M:getNormalDungeonIds()
	return self._dungeonIds
end

function M:getBranchlineDungeonIds()
	return self._branchlineDungeonIds
end

function M:getAllBranchlineIds()
	return self._allBranchlineDungeonIds
end

function M:getStarRewardRequire()
	return self._starRewardRequire
end

function M:getStarReward()
	return self._starReward
end

function M:getSceneCode()
	return self._sceneCode
end

function M:getSceneRange()
	return self._sceneRange
end

function M:getSpecialSelectPosByDungeonId(dungeonId)
	local dungeonUnlockCO = DungeonConfig.instance:getMainlineDungeonUnlockCOByDungeonId(dungeonId)

	return dungeonUnlockCO.specialDungeonSelectPos
end

function M:getDungeonNodePosY(dungeonId)
	local dungeonUnlockCO = DungeonConfig.instance:getMainlineDungeonUnlockCOByDungeonId(dungeonId)

	return dungeonUnlockCO.nodePosY
end

function M:getCameraRotationY()
	return self._sceneCameraRotationY
end

function M:getChapterIconRes()
	return self._chapterCo.iconRes
end

function M:getChapterBannerRes()
	return self._chapterCo.bannerRes
end

function M:getIsChaterPassed()
	for i, v in pairs(self._dungeonIds) do
		local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(v)

		if not dungeonMo:hasPassed() then
			return false
		end
	end

	return true
end

function M:getLastUnlockDungeonIndex()
	for i = #self._dungeonIds, 1, -1 do
		local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(self._dungeonIds[i])

		if dungeonMo:getIsUnlock() then
			return i
		end
	end
end

function M:getLastPassDungeonIndex()
	local index = 0

	for i = #self._dungeonIds, 1, -1 do
		local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(self._dungeonIds[i])

		if dungeonMo:hasPassed() then
			index = i

			break
		end
	end

	return index
end

function M:getIsOnlyFirstDungonUnlock()
	local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(self._dungeonIds[2])

	return not dungeonMo:getIsUnlock()
end

function M:recordIsUnlock()
	if self._isUnlock then
		return
	end

	local isUnlock = self:getIsChapterUnlock()

	if self._isUnlock == false and isUnlock then
		DungeonMainLineChapterModel.instance:localStorageNewUnlockChapterId(self._chapterId)
	end

	self._isUnlock = isUnlock
end

function M:isPreChapterPassed()
	if DungeonModel.instance:getAllDungeonUnlock() then
		return true
	end

	if self._chapterCo.unlockChaperId > 0 then
		local chapterMo = DungeonMainLineChapterModel.instance:getChapterMoByIdAndDifficulty(self._chapterCo.unlockChaperId, 1)

		if not chapterMo:getIsChaterPassed() then
			return false
		end
	end

	return true
end

function M:getIsChapterUnlock()
	if DungeonModel.instance:getAllDungeonUnlock() then
		return true
	end

	if self._chapterCo.unlockLv > PlayerModel.instance:getLevel() then
		return false
	end

	if self._chapterCo.unlockChaperId > 0 then
		local chapterMo = DungeonMainLineChapterModel.instance:getChapterMoByIdAndDifficulty(self._chapterCo.unlockChaperId, 1)

		if not chapterMo:getIsChaterPassed() then
			return false
		end
	end

	if self._chapterCo.unlockCondition then
		for i, v in ipairs(self._chapterCo.unlockCondition) do
			if v.type == "dungeon" then
				local dungeonIds = string.split(v.value, ",")

				for _, dungeonIdStr in ipairs(dungeonIds) do
					local dungeonId = tonumber(dungeonIdStr)
					local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonId)

					if dungeonMO then
						local hasPassTarget = dungeonMO:hasPassed()

						if not hasPassTarget then
							return false
						end
					end
				end
			end

			if v.type == "characterLv" then
				local splitStr = string.split(v.value, "_")
				local heroId = tonumber(splitStr[1])
				local level = tonumber(splitStr[2])
				local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

				if not heroData or level > heroData:getLevel() then
					return false
				end
			end

			if v.type == "tacitLv" then
				local splitStr = string.split(v.value, "_")
				local heroId = tonumber(splitStr[1])
				local tacitLv = tonumber(splitStr[2])
				local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

				if not heroData or tacitLv > heroData:getTacit() then
					return false
				end
			end
		end
	end

	if self._difficulty == 2 then
		local chapterMo = DungeonMainLineChapterModel.instance:getChapterMoByIdAndDifficulty(self._chapterId, 1)

		if not chapterMo:getIsChaterPassed() then
			return false
		end
	end

	return true
end

function M:getChapterLockString()
	local chapterCO = self._chapterCo

	if chapterCO.unlockLv > PlayerModel.instance:getLevel() then
		return string.format(lang("tip_dungeon_chpater_lock_level"), StringUtil.convertLevel(chapterCO.unlockLv))
	elseif chapterCO.unlockCondition then
		for i, v in ipairs(chapterCO.unlockCondition) do
			if v.type == "dungeon" then
				local dungeonIds = string.split(v.value, ",")

				for _, dungeonIdStr in ipairs(dungeonIds) do
					local dungeonId = tonumber(dungeonIdStr)
					local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonId)

					if dungeonMO then
						local hasPassTarget = dungeonMO:hasPassed()

						if not hasPassTarget then
							local dungeonIndex = dungeonMO:getIndex() or ""

							return langF("tip_unlock_branch_fail_by_dungeon_limit", dungeonIndex)
						end
					end
				end
			end
		end
	end

	return ""
end

function M:getStarCount()
	local count = 0

	for i, v in pairs(self._allDungeonIds) do
		local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(v)

		count = count + dungeonMo:getStarCount()
	end

	return count
end

function M:getTotalStarCount()
	return self._chapterCo.starRewardRequire[3]
end

function M:getStarRewardGotStatus()
	return DungeonMainLineChapterModel.instance:getStarBoxTakenData(self._chapterId, self._difficulty)
end

function M:getChapterStarRewardStatus()
	local starRequireList = self:getStarRewardRequire()
	local starHasGotList = self:getStarRewardGotStatus()
	local rewardStatus = CommEnum.RewardEnum.CanNotGot
	local hasGot = true

	for k, status in pairs(starHasGotList) do
		if not status then
			hasGot = false
		end
	end

	if hasGot then
		return CommEnum.RewardEnum.HasGot
	end

	local starCount = self:getStarCount()

	for i, v in ipairs(starRequireList) do
		if not starHasGotList[i] and v <= starCount then
			return CommEnum.RewardEnum.CanGot
		end
	end

	return CommEnum.RewardEnum.CanNotGot
end

function M:hasRedDot()
	local status = self:getChapterStarRewardStatus()

	return status == CommEnum.RewardEnum.CanGot
end

function M:getUnlockDungeonCount()
	local cnt = 0

	for _, id in pairs(self._allDungeonIds) do
		local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(id)

		if dungeonMo:hasPassed() then
			cnt = cnt + 1
		end
	end

	return cnt
end

return M
