-- chunkname: @modules/logic/abyss/model/AbyssInfoMo.lua

module("modules.logic.abyss.model.AbyssInfoMo", package.seeall)

local AbyssInfoMo = pureTable("AbyssInfoMo")

function AbyssInfoMo:ctor()
	self.stageInfoDic = {}
	self.stageInfoList = {}
	self.allHeroDic = {}
	self.useHeroTimeDic = {}
end

function AbyssInfoMo:init(actId)
	return
end

function AbyssInfoMo:updateInfo(actId, stageInfoList)
	self.actId = actId

	tabletool.clear(self.stageInfoList)
	tabletool.clear(self.stageInfoDic)
	tabletool.clear(self.allHeroDic)

	if stageInfoList and next(stageInfoList) then
		local count = #stageInfoList

		for index, stageInfo in ipairs(stageInfoList) do
			self:updateSingleInfo(stageInfo, index == count)
		end
	end

	self:updateHeroUseInfo()
end

function AbyssInfoMo:updateStageInfo(stageNo)
	local stageInfo = self:getStageInfo(stageNo.stageId)

	if stageInfo then
		local time = tonumber(stageNo.lastUpdateTeamTime)

		stageInfo.lastUpdateTime = time ~= nil and time ~= 0 and time or stageInfo.stageId
	end
end

function AbyssInfoMo:updateHeroUseInfo()
	tabletool.clear(self.useHeroTimeDic)

	for _, stageInfo in ipairs(self.stageInfoList) do
		if not stageInfo:isChallenged() then
			local snapshotType = ModuleEnum.HeroGroupSnapshotType.Abyss
			local heroGroupMO = HeroGroupSnapshotModel.instance:getHeroGroupInfo(snapshotType, stageInfo.heroGroupSubId, true)

			if not heroGroupMO or not heroGroupMO.heroList then
				return
			end

			for _, heroUid in ipairs(heroGroupMO.heroList) do
				if heroUid and tonumber(heroUid) > 0 then
					local heroMo = HeroModel.instance:getById(heroUid)

					if heroMo then
						if not heroMo.heroId then
							local heroId = 0

							self.useHeroTimeDic[heroId] = not self.useHeroTimeDic[heroId] and stageInfo.lastUpdateTime or math.max(self.useHeroTimeDic[heroId], stageInfo.lastUpdateTime)
						end
					end
				end
			end
		end
	end

	local index = 0

	for id, stageId in pairs(self.useHeroTimeDic) do
		local heroConfig = HeroConfig.instance:getHeroCO(id)

		index = index + 1

		logNormal("updateHeroUseInfo index: " .. index .. " id:" .. id .. " name:" .. ((heroConfig or nil) and (heroConfig.name or "")) .. " stageId: " .. stageId)
	end
end

function AbyssInfoMo:isHeroUsed(heroId, lastUpdateTime)
	local maxUseTime = self:getHeroLastUpdateTime(heroId)

	return lastUpdateTime < maxUseTime
end

function AbyssInfoMo:getHeroLastUpdateTime(heroId)
	return self.useHeroTimeDic[heroId] or 0
end

function AbyssInfoMo:updateSingleInfo(stageInfo, sort)
	if stageInfo then
		local stageMo

		if self.stageInfoDic[stageInfo.stageId] then
			stageMo = self.stageInfoDic[stageInfo]

			if self.stageInfoDic[stageInfo]:isChallenged() then
				for _, heroId in ipairs(stageMo.heroList) do
					self.allHeroDic[heroId] = nil
				end
			end
		else
			stageMo = AbyssStageMo.New()
			self.stageInfoDic[stageInfo.stageId] = stageMo

			table.insert(self.stageInfoList, stageMo)
		end

		stageMo:updateInfo(stageInfo, self.actId)

		for _, heroNo in ipairs(stageInfo.heros) do
			self.allHeroDic[heroNo.heroId] = heroNo.heroId
		end

		if sort then
			table.sort(self.stageInfoList, AbyssInfoMo.sortStageList)
		end
	end
end

function AbyssInfoMo:getStageInfo(stageId)
	if not self.stageInfoDic then
		return nil
	end

	return self.stageInfoDic[stageId]
end

function AbyssInfoMo:isHeroLocked(heroId)
	if not self.allHeroDic then
		return false
	end

	return self.allHeroDic[heroId] ~= nil
end

function AbyssInfoMo:resetStage(stageId)
	local stageInfoMo = self.stageInfoDic[stageId]

	if not stageInfoMo then
		return
	end

	if stageInfoMo:isChallenged() then
		for _, heroId in ipairs(stageInfoMo.heroList) do
			self.allHeroDic[heroId] = nil
		end

		stageInfoMo:resetInfo()
	end

	self:updateHeroUseInfo()
end

function AbyssInfoMo.sortStageList(a, b)
	return a.stageId < b.stageId
end

return AbyssInfoMo
