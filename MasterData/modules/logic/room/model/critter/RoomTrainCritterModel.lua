-- chunkname: @modules/logic/room/model/critter/RoomTrainCritterModel.lua

module("modules.logic.room.model.critter.RoomTrainCritterModel", package.seeall)

local RoomTrainCritterModel = class("RoomTrainCritterModel", BaseModel)

function RoomTrainCritterModel:onInit()
	self:reInit()
end

function RoomTrainCritterModel:reInit()
	self._selectOptionInfos = {}
	self._totalSelectCount = 0
	self._storyPlayedList = {}

	local playStr = PlayerPrefsHelper.getString(PlayerPrefsKey.RoomCritterTrainStoryPlayed, "")

	if not LuaUtil.isEmptyStr(playStr) then
		local serverTime = ServerTime.now()
		local storyStrs = string.split(playStr, "#")

		if #storyStrs > 1 and TimeUtil.isSameDay(tonumber(storyStrs[1]), serverTime) then
			for i = 2, #storyStrs do
				table.insert(self._storyPlayedList, tonumber(storyStrs[i]))
			end
		end
	end
end

function RoomTrainCritterModel:isEventTrainStoryPlayed(heroId)
	for _, v in pairs(self._storyPlayedList) do
		if v == heroId then
			return true
		end
	end

	return false
end

function RoomTrainCritterModel:setEventTrainStoryPlayed(heroId)
	if self:isEventTrainStoryPlayed(heroId) then
		return
	end

	table.insert(self._storyPlayedList, heroId)

	local playStr = tostring(ServerTime.now())

	for _, v in ipairs(self._storyPlayedList) do
		playStr = string.format("%s#%s", playStr, v)
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.RoomCritterTrainStoryPlayed, playStr)
end

function RoomTrainCritterModel:isCritterTrainStory(storyId)
	if #tostring(storyId) ~= 9 then
		return false
	end

	local subStoryId = storyId % 100000

	for _, eventCfg in pairs(lua_critter_train_event.configDict) do
		if eventCfg.type == CritterEnum.EventType.ActiveTime and (subStoryId == eventCfg.initStoryId or subStoryId == eventCfg.normalStoryId or subStoryId == eventCfg.skilledStoryId) then
			return true
		end
	end

	return false
end

function RoomTrainCritterModel:getCritterTrainStory(heroId, subStoryId)
	return 100000 * heroId + subStoryId
end

function RoomTrainCritterModel:clearSelectOptionInfos()
	self._totalSelectCount = 0
	self._selectOptionInfos = {}
end

function RoomTrainCritterModel:getSelectOptionInfos()
	if not self._selectOptionInfos or not next(self._selectOptionInfos) then
		self._selectOptionInfos = {
			{
				optionId = 1,
				count = 0
			},
			{
				optionId = 2,
				count = 0
			},
			{
				optionId = 3,
				count = 0
			}
		}
	end

	return self._selectOptionInfos
end

function RoomTrainCritterModel:addSelectOptionCount(optionId)
	if not self._selectOptionInfos[optionId] then
		self:getSelectOptionInfos()
	end

	self._selectOptionInfos[optionId].count = self._selectOptionInfos[optionId].count + 1
end

function RoomTrainCritterModel:cancelSelectOptionCount(optionId)
	if not self._selectOptionInfos[optionId] then
		self:getSelectOptionInfos()
	end

	if self._selectOptionInfos[optionId].count < 1 then
		return
	end

	self._selectOptionInfos[optionId].count = self._selectOptionInfos[optionId].count - 1
end

function RoomTrainCritterModel:getSelectOptionCount(optionId)
	if not self._selectOptionInfos[optionId] then
		self:getSelectOptionInfos()
	end

	return self._selectOptionInfos[optionId].count
end

function RoomTrainCritterModel:getSelectOptionTotalCount()
	local count = 0

	for _, v in pairs(self._selectOptionInfos) do
		count = count + v.count
	end

	return count
end

function RoomTrainCritterModel:setOptionsSelectTotalCount(count)
	self._totalSelectCount = count
end

function RoomTrainCritterModel:getOptionsSelectTotalCount()
	return self._totalSelectCount
end

function RoomTrainCritterModel:getSelectOptionLimitCount()
	local count = self:getSelectOptionTotalCount()

	if self._totalSelectCount - count <= 0 then
		return 0
	end

	return self._totalSelectCount - count
end

function RoomTrainCritterModel:getProductGood(productId)
	local goods = StoreConfig.instance:getRoomCritterProductGoods(productId)

	if #goods < 1 then
		return nil
	end

	for _, v in pairs(goods) do
		local goodMo = StoreModel.instance:getGoodsMO(v.id)

		if goodMo.buyCount < goodMo.config.maxBuyCount then
			return goodMo
		end
	end

	for _, v in pairs(goods) do
		local goodMo = StoreModel.instance:getGoodsMO(v.id)

		if goodMo.config.maxBuyCount == 0 then
			return goodMo
		end
	end

	return nil
end

RoomTrainCritterModel.instance = RoomTrainCritterModel.New()

return RoomTrainCritterModel
