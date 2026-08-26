-- chunkname: @modules/logic/seasonver/act123/model/Season123PickHeroModel.lua

module("modules.logic.seasonver.act123.model.Season123PickHeroModel", package.seeall)

local Season123PickHeroModel = class("Season123PickHeroModel", ListScrollModel)

function Season123PickHeroModel:release()
	self:clear()

	self._lastSelectedMap = nil
	self._curSelectMap = nil
	self._curSelectList = nil
end

function Season123PickHeroModel:init(actId, stage, entryMOList, selectUid)
	self.activityId = actId
	self.stage = stage
	self._curSelectMap = {}
	self._curSelectList = {}

	self:initSelectedList(entryMOList)
	self:initHeroList(self._lastSelectedMap, selectUid)
end

function Season123PickHeroModel:initHeroList(selectedMap, selectUid)
	local result = {}
	local list = tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	local index = 0

	for _, heroMO in ipairs(list) do
		index = index + 1

		local mo = Season123PickHeroMO.New()

		mo:init(heroMO.uid, heroMO.heroId, heroMO.skin, index)
		table.insert(result, mo)

		if selectedMap and selectedMap[heroMO.heroId] and not self._curSelectMap[heroMO.uid] then
			self._curSelectMap[heroMO.uid] = true

			table.insert(self._curSelectList, heroMO.uid)
		end

		if selectUid and selectUid == heroMO.uid then
			self._lastSelectedHeroUid = selectUid
		end
	end

	logNormal("hero list count : " .. tostring(#result))
	table.sort(result, Season123PickHeroModel.sortList)
	self:setList(result)

	self.heroMOList = self:getHeroMOList()
end

function Season123PickHeroModel:initSelectedList(entryMOList)
	self._maxLimit = Activity123Enum.PickHeroCount
	self._lastSelectedMap = {}

	if not entryMOList then
		return
	end

	for pos = 1, Activity123Enum.PickHeroCount do
		local entryMO = entryMOList[pos]

		if not entryMO.isSupport and not entryMO:getIsEmpty() then
			self._lastSelectedMap[entryMO.heroId] = true
		end

		if entryMO.isSupport then
			self._maxLimit = self._maxLimit - 1
		end
	end
end

function Season123PickHeroModel.sortList(a, b)
	local inTeamA = Season123PickHeroModel.instance._curSelectMap[a.uid]
	local inTeamB = Season123PickHeroModel.instance._curSelectMap[b.uid]

	if inTeamA ~= inTeamB then
		return inTeamA
	end

	return a.index < b.index
end

function Season123PickHeroModel:getHeroMOList()
	local result = {}
	local list = self:getList()

	for i, pickMO in ipairs(list) do
		local heroMO = HeroModel.instance:getById(pickMO.uid)

		if heroMO then
			table.insert(result, heroMO)
		end
	end

	return result
end

function Season123PickHeroModel:refreshList()
	self:initHeroList(nil)
end

function Season123PickHeroModel:cleanSelected()
	for k, v in pairs(self._curSelectMap) do
		self._curSelectMap[k] = nil
	end

	for k, v in pairs(self._curSelectList) do
		self._curSelectList[k] = nil
	end
end

function Season123PickHeroModel:setHeroSelect(heroUid, value)
	local mo = self:getById(heroUid)

	if mo then
		if value then
			if not self._curSelectMap[heroUid] then
				self._curSelectMap[heroUid] = true

				table.insert(self._curSelectList, heroUid)
			end
		elseif self._curSelectMap[heroUid] then
			self._curSelectMap[heroUid] = nil

			tabletool.removeValue(self._curSelectList, heroUid)
		end

		mo.isSelect = value
	end

	self._lastSelectedHeroUid = heroUid
end

function Season123PickHeroModel:getSelectCount()
	return #self._curSelectList
end

function Season123PickHeroModel:getSelectedHeroMO()
	if self._lastSelectedHeroUid then
		return (HeroModel.instance:getById(self._lastSelectedHeroUid))
	end
end

function Season123PickHeroModel:isHeroSelected(heroUid)
	return self._curSelectMap[heroUid]
end

function Season123PickHeroModel:getSelectedIndex(heroUid)
	return tabletool.indexOf(self._curSelectList, heroUid)
end

function Season123PickHeroModel:getLimitCount()
	return self._maxLimit
end

function Season123PickHeroModel:getSelectMOList()
	local rs = {}

	for _, heroUid in ipairs(self._curSelectList) do
		local mo = self:getById(heroUid)

		if mo == nil and heroUid ~= 0 and heroUid ~= Activity123Enum.EmptyUid then
			mo = Season123PickHeroMO.New()

			local heroMO = HeroModel.instance:getById(heroUid)

			if heroMO then
				mo:init(heroMO.uid, heroMO.heroId, heroMO.skin, 0)
			end
		end

		table.insert(rs, mo)
	end

	return rs
end

Season123PickHeroModel.instance = Season123PickHeroModel.New()

return Season123PickHeroModel
