-- chunkname: @modules/logic/weekwalk/model/MapInfoMO.lua

module("modules.logic.weekwalk.model.MapInfoMO", package.seeall)

local MapInfoMO = pureTable("MapInfoMO")

function MapInfoMO:init(info)
	self.id = info.id
	self.sceneId = info.sceneId
	self.isFinish = info.isFinish
	self.isFinished = info.isFinished
	self.buffId = info.buffId
	self.isShowBuff = info.isShowBuff
	self.isShowFinished = info.isShowFinished
	self.isShowSelectCd = info.isShowSelectCd

	if self.id == 9477 then
		self.sceneId = 17
	end

	self.battleIds = {}
	self.battleInfos = {}
	self.battleInfoMap = {}

	for i, v in ipairs(info.battleInfos) do
		if not self.battleInfoMap[v.battleId] then
			local mo = BattleInfoMO.New()

			mo:init(v)
			mo:setIndex(i)
			table.insert(self.battleIds, v.battleId)
			table.insert(self.battleInfos, mo)

			self.battleInfoMap[mo.battleId] = mo
		end
	end

	self.elementInfos = {}
	self.elementInfoMap = {}

	for i, v in ipairs(info.elementInfos) do
		local mo = WeekwalkElementInfoMO.New()

		mo:init(v)
		mo:setMapInfo(self)
		table.insert(self.elementInfos, mo)

		self.elementInfoMap[mo.elementId] = mo
	end

	self._heroInfos = {}
	self._heroInfoList = {}

	if info.heroInfos then
		for i, v in ipairs(info.heroInfos) do
			local info = WeekwalkHeroInfoMO.New()

			info:init(v)

			self._heroInfos[v.heroId] = info

			table.insert(self._heroInfoList, info)
		end
	end

	self._storyIds = {}

	for i, v in ipairs(info.storyIds) do
		self._storyIds[v] = v
	end

	self._mapConfig = WeekWalkConfig.instance:getMapConfig(self.id)

	if self._mapConfig then
		self._typeConfig = lua_weekwalk_type.configDict[self._mapConfig.type]
	end
end

function MapInfoMO:getBattleInfoByIndex(index)
	return self.battleInfos[index]
end

function MapInfoMO:getLayer()
	return self._mapConfig and self._mapConfig.layer
end

function MapInfoMO:getMapConfig()
	return self._mapConfig
end

function MapInfoMO:storyIsFinished(storyId)
	return self._storyIds[storyId]
end

function MapInfoMO:getElementInfo(id)
	return self.elementInfoMap[id]
end

function MapInfoMO:getBattleInfo(id)
	return self.battleInfoMap[id]
end

function MapInfoMO:getHasStarIndex()
	for i = #self.battleInfos, 1, -1 do
		if self.battleInfos[i].star > 0 then
			return i
		end
	end

	return 0
end

function MapInfoMO:getStarInfo()
	local cur = 0

	for i, v in ipairs(self.battleInfos) do
		cur = cur + v.maxStar
	end

	return cur, #self.battleInfos * self._typeConfig.starNum
end

function MapInfoMO:getCurStarInfo()
	local cur = 0

	for i, v in ipairs(self.battleInfos) do
		cur = cur + v.star
	end

	return cur, #self.battleInfos * self._typeConfig.starNum
end

function MapInfoMO:getStarNumConfig()
	return self._typeConfig.starNum
end

function MapInfoMO:getNoStarBattleInfo()
	for i, v in ipairs(self.battleInfos) do
		if v.star <= 0 then
			return v
		end
	end
end

function MapInfoMO:getNoStarBattleIndex()
	for i, v in ipairs(self.battleInfos) do
		if v.maxStar <= 0 then
			return i
		end
	end

	return #self.battleInfos
end

function MapInfoMO:getHeroInfoList()
	return self._heroInfoList
end

function MapInfoMO:getHeroCd(id)
	local info = self._heroInfos[id]

	return (info or nil) and (info.cd or 0)
end

function MapInfoMO:clearHeroCd(list)
	self.isShowSelectCd = false

	for i, heroId in ipairs(list) do
		self._heroInfos[heroId] = nil
	end
end

return MapInfoMO
