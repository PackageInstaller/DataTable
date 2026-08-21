-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/starter/request/StartGameRequestor.lua

module("logic.starter.request.StartGameRequestor", package.seeall)

local M = class("StartGameRequestor")

function M:ctor()
	self._firstRequestList = {
		{
			isNeedBeforeName = true,
			isNeedForNewAccount = true,
			func = self._loadPlayerInfo
		},
		{
			isNeedBeforeName = false,
			isNeedForNewAccount = true,
			func = self._loadDungeonData
		},
		{
			isNeedBeforeName = true,
			isNeedForNewAccount = true,
			func = self._loadGuideData
		},
		{
			isNeedBeforeName = true,
			isNeedForNewAccount = true,
			func = self._loadHeroDepot
		},
		{
			isNeedBeforeName = true,
			isNeedForNewAccount = true,
			func = self._loadBackpack
		},
		{
			isNeedBeforeName = true,
			isNeedForNewAccount = true,
			func = self._loadPreEnterActivityData
		},
		{
			isNeedBeforeName = false,
			isNeedForNewAccount = true,
			func = self._loadMonthSignin
		},
		{
			isNeedBeforeName = true,
			isNeedForNewAccount = true,
			func = self._loadRedDotData
		},
		{
			isFirstOver = true
		},
		{
			isNeedBeforeName = false,
			isNeedForNewAccount = true,
			func = self._loadAfterEnterActivityData
		},
		{
			isNeedBeforeName = false,
			isNeedForNewAccount = true,
			func = self._loadEquipment
		},
		{
			isNeedBeforeName = false,
			isNeedForNewAccount = true,
			func = self._loadEchoItem
		},
		{
			isNeedBeforeName = false,
			isNeedForNewAccount = true,
			func = self._loadTeamData
		},
		{
			isNeedBeforeName = false,
			isNeedForNewAccount = true,
			func = self._loadHouseData
		},
		{
			isNeedBeforeName = false,
			isNeedForNewAccount = true,
			func = self._loadSkinData
		},
		{
			isNeedBeforeName = false,
			isNeedForNewAccount = true,
			func = self._loadStoreData
		},
		{
			isNeedBeforeName = false,
			isNeedForNewAccount = true,
			func = self._loadThinkingData
		},
		{
			isNeedBeforeName = false,
			isNeedForNewAccount = true,
			func = self._loadHouseHoldData
		},
		{
			isNeedBeforeName = false,
			isNeedForNewAccount = false,
			func = self._loadFriendData
		},
		{
			isNeedBeforeName = false,
			isNeedForNewAccount = false,
			func = self._loadAirWork
		},
		{
			isNeedBeforeName = false,
			isNeedForNewAccount = false,
			func = self._loadCharacterSkill
		},
		{
			isNeedBeforeName = false,
			isNeedForNewAccount = false,
			func = self._loadSeason
		}
	}
	self._curIndex = 0
	self._isNewAccount = false
	self._isAllowEnterGame = true
	self._totalCount = #self._firstRequestList
	self._secondRequestList = {}

	GlobalDispatcher:dispatchEvent(EventType.START_GAME_REQUEST)
end

function M:_loadPlayerInfo()
	UserAgent.instance:sendGetServerTimeRequest()
	PlayerAgent.instance:sendLoadPlayerRequest()
	SystemOpenAgent.instance:sendGetSystemOpenInfoRequest()
end

function M:_loadRedDotData()
	LoginController.instance.reconnectHandler:setIsInEnterGame(true)
	RedDotAgent.instance:sendLoadAllRedPointRequest()
end

function M:_loadBackpack()
	BackpackAgent.instance:sendLoadBagRequest()
end

function M:_loadEquipment()
	return
end

function M:_loadEchoItem()
	EchoItemAgent.instance:sendGetEchoItemInfoRequest()
end

function M:_loadHeroDepot()
	HeroDepotAgent.instance:sendLoadHerosRequest()
end

function M:_loadTeamData()
	TeamAgent.instance:sendLoadTeamsRequest()
end

function M:_loadMonthSignin()
	MonthSignInAgent.instance:sendGetMonthSignInInfoRequest()
end

function M:_loadPreEnterActivityData()
	ActivityAgent.instance:sendGetActivityInfoRequest()
	NewbieTaskAgent.instance:sendGetTaskListRequest()
	PlayerAgent.instance:sendGetMasterTrainingTaskListRequest()
	ActivityAgent.instance:sendGetScoreActivityInfoRequest()
end

function M:_loadAfterEnterActivityData()
	return
end

function M:_loadDungeonData()
	GuideAgent.instance:sendGetPlotAnswersRequest()
	DungeonAgent.instance:sendGetDungeonInfoRequest()
	AirWorkShopDefAgent.instance:sendGetAirMapListRequest()
	AirWorkShopDefAgent.instance:sendGetAllAirMapNewsReq()
end

function M:_loadHouseData()
	if SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.House, false) then
		HouseAgent.instance:sendGetSelfHouseInfoRequest()
		HouseAgent.instance:sendGetHeroFeatureRequest()
		HouseAgent.instance:sendGetFurnituresRequest()
		LivingFacilitiesAgent.instance:sendGetHouseInfoRequest()
	end
end

function M:_loadHouseHoldData()
	if SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.House, false) then
		ContainmentZoneAgent.instance:sendGetHoldRoomInfoRequest()
		ContainmentZoneAgent.instance:sendGetProtomerInfoRequest()
	end
end

function M:_loadSkinData()
	HeroSkinModel.instance:initConfig()
end

function M:_loadGuideData()
	GuideAgent.instance:sendGetGuideInfoRequest()
end

function M:_loadStoreData()
	StoreAgent.instance:sendGetMallListRequest()
	BackpackAgent.instance:sendExchangeRemainedTimesRequest()
end

function M:_loadThinkingData()
	ThinkingController.instance:requestThinkingData()
end

function M:_loadFriendData()
	local relationType = GameEnum.RelationTypeEnum.Friend

	FriendAgent.instance:sendGetUserListRequest(relationType)
end

function M:_loadAirWork()
	PlayerAgent.instance:sendGetUnlockInfoAllTypAirStudio()
end

function M:_loadCharacterSkill()
	AchievementAgent.instance:sendGetAllAchievementRequest()
end

function M:_loadSeason()
	SeasonAgent.instance:sendSeasonInfoRequest()
	SeasonAgent.instance:sendSeasonListTaskRequest()
end

function M:start(isNewAccount)
	self._isNewAccount = isNewAccount
	self._curIndex = 0
	self._totalCount = #self._firstRequestList

	removetimer(self._onTick, self)
	settimer(0.05, self._onTick, self, true)
end

function M:startSecond()
	self._curIndex = 0
	self._totalCount = #self._secondRequestList

	removetimer(self._onTickSecond, self)
	settimer(0.1, self._onTickSecond, self, true)
end

function M:_onTick()
	self._curIndex = self._curIndex + 1

	if self._curIndex <= self._totalCount then
		local info = self._firstRequestList[self._curIndex]

		if info then
			if info.isFirstOver then
				self:stop()
				settimer(0.1, self._onTick, self, true)
			elseif not self._isNewAccount or self._isNewAccount == info.isNeedForNewAccount then
				if self._isNewAccount then
					if info.isNeedBeforeName then
						info.func(self)
					else
						table.insert(self._secondRequestList, info)
					end
				else
					info.func(self)
				end
			end
		elseif enableLog then
			print(self._curIndex .. "   " .. self._totalCount)
		end
	end

	if self._curIndex >= self._totalCount then
		self:stop()
	end
end

function M:_onTickSecond()
	self._curIndex = self._curIndex + 1

	if self._curIndex <= self._totalCount then
		local info = self._secondRequestList[self._curIndex]

		if info then
			if self._isNewAccount then
				info.func(self)
			end
		elseif enableLog then
			print(self._curIndex .. "   " .. self._totalCount)
		end
	else
		self:stop()
	end
end

function M:stop()
	removetimer(self._onTick, self)
	removetimer(self._onTickSecond, self)
end

M.instance = M.New()

return M
