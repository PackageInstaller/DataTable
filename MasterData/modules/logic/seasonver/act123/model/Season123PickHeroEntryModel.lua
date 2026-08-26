-- chunkname: @modules/logic/seasonver/act123/model/Season123PickHeroEntryModel.lua

module("modules.logic.seasonver.act123.model.Season123PickHeroEntryModel", package.seeall)

local Season123PickHeroEntryModel = class("Season123PickHeroEntryModel", BaseModel)

function Season123PickHeroEntryModel:release()
	self:clear()

	self._supportPosMO = nil
	self.stage = nil
	self._equipIdList = nil
	self._lastHeroList = nil
end

function Season123PickHeroEntryModel:init(actId, stage)
	self.activityId = actId
	self.stage = stage

	self:initDatas()
	self:initFromLocal()
	self:clearLastSupportHero()
end

function Season123PickHeroEntryModel:initDatas()
	local list = {}

	for i = 1, Activity123Enum.PickHeroCount do
		local mo = Season123PickHeroEntryMO.New(i)

		table.insert(list, mo)

		if i == Activity123Enum.SupportPosIndex then
			self._supportPosMO = mo
		end
	end

	self:setList(list)
end

function Season123PickHeroEntryModel:initFromLocal()
	local list = self:readSelectionFromLocal()

	for i = 1, #list do
		local mo = self:getByIndex(i)
		local heroMO = HeroModel.instance:getById(list[i])

		mo:updateByHeroMO(heroMO, false)
	end
end

function Season123PickHeroEntryModel:savePickHeroDatas(moList)
	if not self._supportPosMO then
		return
	end

	for pos = 1, Activity123Enum.PickHeroCount do
		local mo = moList[pos]
		local entryMO = self:getByIndex(pos)

		if entryMO == nil then
			logError("Season123PickHeroEntryModel entryMO is nil : " .. tostring(pos))

			return
		end

		if mo then
			if self._supportPosMO.isSupport and mo.heroId == self._supportPosMO.heroId then
				self._supportPosMO:setEmpty()
			end

			entryMO:updateByPickMO(mo)
		elseif not entryMO.isSupport then
			entryMO:setEmpty()
		end
	end
end

function Season123PickHeroEntryModel:setPickAssistData(pickAssistMO)
	if not self._supportPosMO then
		return
	end

	if pickAssistMO == nil then
		if not self._supportPosMO:getIsEmpty() and self._supportPosMO.isSupport then
			self._supportPosMO:setEmpty()
		end
	else
		local moList = self:getList()

		for pos = 1, Activity123Enum.PickHeroCount do
			local mo = moList[pos]

			if pickAssistMO.heroMO and pickAssistMO.heroMO.heroId == mo.heroId then
				mo:setEmpty()
			end
		end

		self._supportPosMO:updateByPickAssistMO(pickAssistMO)
	end
end

function Season123PickHeroEntryModel:setMainEquips(equipIdList)
	self._equipIdList = equipIdList
end

function Season123PickHeroEntryModel:getSupportPosMO()
	return self._supportPosMO
end

function Season123PickHeroEntryModel:getSupporterHeroUid()
	if self._supportPosMO and self._supportPosMO.isSupport and not self._supportPosMO:getIsEmpty() then
		return self._supportPosMO.heroUid
	end
end

function Season123PickHeroEntryModel:getSelectCount()
	local count = 0
	local list = self:getList()

	for _, mo in ipairs(list) do
		if not mo:getIsEmpty() then
			count = count + 1
		end
	end

	return count
end

function Season123PickHeroEntryModel:getLimitCount()
	return Activity123Enum.PickHeroCount
end

function Season123PickHeroEntryModel:getHeroUidList()
	local list = self:getList()
	local rs = {}

	for _, mo in ipairs(list) do
		table.insert(rs, mo.heroUid)
	end

	return rs
end

function Season123PickHeroEntryModel:getMainCardList()
	return self._equipIdList
end

function Season123PickHeroEntryModel:getMainCardItemMO(index)
	if self._equipIdList then
		local equipUid = self._equipIdList[index]

		if equipUid and equipUid ~= Activity123Enum.EmptyUid then
			local seasonMO = Season123Model.instance:getActInfo(self.activityId)

			if not seasonMO then
				return
			end

			return (seasonMO:getItemMO(equipUid))
		end
	end
end

function Season123PickHeroEntryModel:flushSelectionToLocal()
	local list = self:getList()
	local rs = {}

	for _, mo in ipairs(list) do
		if not mo:getIsEmpty() and not mo.isSupport then
			table.insert(rs, mo.heroUid)
		end
	end

	PlayerPrefsHelper.setString(self:getLocalKey(), cjson.encode(rs))
end

function Season123PickHeroEntryModel:readSelectionFromLocal()
	local list
	local rs = PlayerPrefsHelper.getString(self:getLocalKey(), "")

	return not string.nilorempty(rs) and cjson.decode(rs) or {}
end

function Season123PickHeroEntryModel:getLocalKey()
	return PlayerPrefsKey.Season123PickHeroList .. "#" .. tostring(self.activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function Season123PickHeroEntryModel:getCutHeroList()
	if not self._lastHeroList then
		local list = self:readSelectionFromLocal()
		local lastHeroIdList = {}
		local cutHeroPosList = {}

		for i = 1, #list do
			local heroMO = HeroModel.instance:getById(list[i])

			if heroMO then
				table.insert(lastHeroIdList, heroMO.heroId)
			end
		end

		for pos = 1, Activity123Enum.PickHeroCount do
			local mo = self:getByIndex(pos)

			if mo and not mo:getIsEmpty() then
				if mo.isSupport then
					if self._lastSupportHeroId ~= mo.heroId then
						table.insert(cutHeroPosList, pos)
					end
				elseif lastHeroIdList then
					if not LuaUtil.tableContains(lastHeroIdList, mo.heroId) then
						table.insert(cutHeroPosList, pos)
					end
				else
					table.insert(cutHeroPosList, pos)
				end
			end
		end

		return cutHeroPosList
	end
end

function Season123PickHeroEntryModel:refeshLastHeroList()
	local list = self:getList()

	self._lastHeroList = {}

	for _, mo in ipairs(list) do
		if not mo:getIsEmpty() then
			table.insert(self._lastHeroList, mo.heroUid)
		end

		if mo.isSupport then
			if mo:getIsEmpty() then
				self:clearLastSupportHero()
			else
				self._lastSupportHeroId = mo.heroId
			end
		end
	end
end

function Season123PickHeroEntryModel:clearLastSupportHero()
	self._lastSupportHeroId = nil
end

Season123PickHeroEntryModel.instance = Season123PickHeroEntryModel.New()

return Season123PickHeroEntryModel
