-- chunkname: @modules/logic/character/model/CharacterDestinyModel.lua

module("modules.logic.character.model.CharacterDestinyModel", package.seeall)

local CharacterDestinyModel = class("CharacterDestinyModel", BaseModel)

function CharacterDestinyModel:onInit()
	return
end

function CharacterDestinyModel:reInit()
	return
end

function CharacterDestinyModel:onRankUp(heroId)
	return
end

function CharacterDestinyModel:isOpenDestinySystem(isShowToast)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DestinyStone) then
		return true
	end

	local openCo = OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.DestinyStone)

	if openCo and VersionValidator.instance:isInReviewing() then
		if not openCo.verifingEpisodeId then
			local episodeId = openCo.episodeId

			if isShowToast and episodeId and episodeId ~= 0 and not DungeonModel.instance:hasPassLevel(episodeId) then
				local episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(episodeId)

				GameFacade.showToast(ToastEnum.DungeonMapLevel, episodeDisplay)
			end
		end
	end
end

function CharacterDestinyModel:getCurSlotAttrInfos(heroId, rank, level)
	local attrInfos = {}
	local specialAttrInfos = {}
	local lockAttrInfos = {}
	local curAddAttr = CharacterDestinyConfig.instance:getCurDestinySlotAddAttr(heroId, rank, level)
	local nextCo = CharacterDestinyConfig.instance:getNextDestinySlotCo(heroId, rank, level)
	local lockAttr = CharacterDestinyConfig.instance:getLockAttr(heroId, rank)
	local nextAttrInfo = {}

	if nextCo then
		local effects = GameUtil.splitString2(nextCo.effect, true)

		for _, v in ipairs(effects) do
			local attrCo = HeroConfig.instance:getHeroAttributeCO(v[1])

			if attrCo.showType == 1 then
				if not (v[2] * 0.1) then
					nextAttrInfo[v[1]] = v[2]
				end
			end
		end
	end

	if rank > 0 then
		if curAddAttr then
			for attrId, _ in pairs(curAddAttr) do
				if LuaUtil.tableContains(CharacterDestinyEnum.DestinyUpBaseAttr, attrId) then
					local info = {}

					info.attrId = attrId
					info.curNum = curAddAttr[attrId]
					info.nextNum = nextAttrInfo[attrId]
					info.isSpecial = false

					table.insert(attrInfos, info)
				else
					local info = {}

					info.attrId = attrId
					info.curNum = curAddAttr[attrId]
					info.nextNum = nextAttrInfo[attrId]
					info.isSpecial = true

					table.insert(specialAttrInfos, info)
				end
			end

			table.sort(attrInfos, self.sortAttr)
			table.sort(specialAttrInfos, self.sortAttr)
		end
	else
		lockAttrInfos[1] = lockAttrInfos[1] or {}

		for attrId, num in pairs(nextAttrInfo) do
			if LuaUtil.tableContains(CharacterDestinyEnum.DestinyUpBaseAttr, attrId) then
				local info = {}

				info.attrId = attrId
				info.curNum = num

				table.insert(lockAttrInfos[1], info)
			end
		end
	end

	if lockAttr then
		for rank, attrs in pairs(lockAttr) do
			for attrId, curNum in pairs(attrs) do
				local info = {}

				info.attrId = attrId
				info.curNum = curNum

				local isNewAttr = not self:__isHadAttr(attrInfos, attrId) and not self:__isHadAttr(specialAttrInfos, attrId) and not self:_isHadAttr(lockAttrInfos, attrId)

				if isNewAttr then
					lockAttrInfos[rank] = lockAttrInfos[rank] or {}

					table.insert(lockAttrInfos[rank], info)
				end
			end
		end

		for _, infos in pairs(lockAttrInfos) do
			table.sort(infos, self.sortAttr)
		end
	end

	return attrInfos, specialAttrInfos, lockAttrInfos
end

function CharacterDestinyModel.sortAttr(info1, info2)
	local isNormalAttr1 = LuaUtil.tableContains(CharacterDestinyEnum.DestinyUpBaseAttr, info1.attrId)
	local isNormalAttr2 = LuaUtil.tableContains(CharacterDestinyEnum.DestinyUpBaseAttr, info2.attrId)

	if isNormalAttr1 ~= isNormalAttr2 then
		return isNormalAttr1
	end

	return info1.attrId < info2.attrId
end

function CharacterDestinyModel:_isHadAttr(tb, attrId)
	if tb then
		for _, info in pairs(tb) do
			if self:__isHadAttr(info, attrId) then
				return true
			end
		end
	end
end

function CharacterDestinyModel:__isHadAttr(tb, attrId)
	if tb then
		for _, info in ipairs(tb) do
			if info.attrId == attrId then
				return true
			end
		end
	end
end

function CharacterDestinyModel:destinyUpBaseReverseParseAttr(attrId)
	if not self._reverseParseBaseAttrList then
		self._reverseParseBaseAttrList = {}

		for k, v in pairs(CharacterDestinyEnum.DestinyUpBaseParseAttr) do
			for _, _attrId in ipairs(v) do
				self._reverseParseBaseAttrList[_attrId] = k
			end
		end
	end

	return self._reverseParseBaseAttrList[attrId]
end

function CharacterDestinyModel:setShowReshape(isShow)
	self._isShowReshape = isShow
end

function CharacterDestinyModel:getIsShowReshape()
	return self._isShowReshape
end

CharacterDestinyModel.instance = CharacterDestinyModel.New()

return CharacterDestinyModel
