-- chunkname: @modules/logic/login/controller/work/LoginGetInfoWork.lua

module("modules.logic.login.controller.work.LoginGetInfoWork", package.seeall)

local LoginGetInfoWork = class("LoginGetInfoWork", BaseWork)

function LoginGetInfoWork:_initInfo()
	self.GetInfoFuncList = {
		{
			PlayerRpc.sendGetSimplePropertyRequest,
			PlayerRpc.instance,
			"sendGetSimplePropertyRequest",
			false
		},
		{
			PlayerRpc.sendGetClothInfoRequest,
			PlayerRpc.instance,
			"sendGetClothInfoRequest",
			false
		},
		{
			HeroRpc.sendHeroInfoListRequest,
			HeroRpc.instance,
			"sendHeroInfoListRequest",
			false
		},
		{
			HeroGroupRpc.sendGetHeroGroupCommonListRequest,
			HeroGroupRpc.instance,
			"sendGetHeroGroupCommonListRequest",
			false
		},
		{
			HeroGroupRpc.sendGetHeroGroupListRequest,
			HeroGroupRpc.instance,
			"sendGetHeroGroupListRequest",
			false
		},
		{
			HeroGroupRpc.sendGetAllHeroGroupSnapshotListRequest,
			HeroGroupRpc.instance,
			"sendGetAllHeroGroupSnapshotListRequest",
			false
		},
		{
			ItemRpc.sendGetItemListRequest,
			ItemRpc.instance,
			"sendGetItemListRequest",
			false
		},
		{
			DungeonRpc.sendGetDungeonRequest,
			DungeonRpc.instance,
			"sendGetDungeonRequest",
			false
		},
		{
			FightRpc.sendReconnectFightRequest,
			FightRpc.instance,
			"sendReconnectFightRequest",
			true
		},
		{
			CurrencyRpc.sendGetBuyPowerInfoRequest,
			CurrencyRpc.instance,
			"sendGetBuyPowerInfoRequest",
			false
		},
		{
			EquipRpc.sendGetEquipInfoRequest,
			EquipRpc.instance,
			"sendGetEquipInfoRequest",
			false
		},
		{
			StoryRpc.sendGetStoryRequest,
			StoryRpc.instance,
			"sendGetStoryRequest",
			false
		},
		{
			ChargeRpc.sendGetChargeInfoRequest,
			ChargeRpc.instance,
			"sendGetChargeInfoRequest",
			false
		},
		{
			ChargeRpc.sendGetMonthCardInfoRequest,
			ChargeRpc.instance,
			"sendGetMonthCardInfoRequest",
			false
		},
		{
			RoomRpc.sendGetBlockPackageInfoRequset,
			RoomRpc.instance,
			"sendGetBlockPackageInfoRequset",
			false
		},
		{
			RoomRpc.sendGetBuildingInfoRequest,
			RoomRpc.instance,
			"sendGetBuildingInfoRequest",
			false
		},
		{
			RoomRpc.sendGetCharacterInteractionInfoRequest,
			RoomRpc.instance,
			"sendGetCharacterInteractionInfoRequest",
			false
		},
		{
			SummonRpc.sendGetSummonInfoRequest,
			SummonRpc.instance,
			"sendGetSummonInfoRequest",
			false
		},
		{
			AchievementRpc.sendGetAchievementInfoRequest,
			AchievementRpc.instance,
			"sendGetAchievementInfoRequest",
			false
		},
		{
			DialogueRpc.sendGetDialogInfoRequest,
			DialogueRpc.instance,
			"sendGetDialogInfoRequest",
			false
		},
		{
			AntiqueRpc.sendGetAntiqueInfoRequest,
			AntiqueRpc.instance,
			"sendGetAntiqueInfoRequest",
			false
		},
		{
			UnlockVoucherRpc.sendGetUnlockVoucherInfoRequest,
			UnlockVoucherRpc.instance,
			"sendGetUnlockVoucherInfoRequest",
			false
		},
		{
			CurrencyRpc.sendExchangeSameCurrencyRequest,
			CurrencyRpc.instance,
			"sendExchangeSameCurrencyRequest",
			false
		}
	}

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		table.insert(self.GetInfoFuncList, {
			WeekwalkRpc.sendGetWeekwalkInfoRequest,
			WeekwalkRpc.instance,
			"sendGetWeekwalkInfoRequest",
			false
		})
		table.insert(self.GetInfoFuncList, {
			Weekwalk_2Rpc.sendWeekwalkVer2GetInfoRequest,
			Weekwalk_2Rpc.instance,
			"sendWeekwalkVer2GetInfoRequest",
			false
		})
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Explore) then
		table.insert(self.GetInfoFuncList, {
			ExploreRpc.sendGetExploreSimpleInfoRequest,
			ExploreRpc.instance,
			"sendGetExploreSimpleInfoRequest",
			false
		})
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Tower) then
		table.insert(self.GetInfoFuncList, {
			TowerRpc.sendGetTowerInfoRequest,
			TowerRpc.instance,
			"sendGetTowerInfoRequest",
			false
		})
		table.insert(self.GetInfoFuncList, {
			TowerComposeRpc.sendTowerComposeGetInfoRequest,
			TowerComposeRpc.instance,
			"sendTowerComposeGetInfoRequest",
			false,
			false
		})
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.PlayerCard) then
		table.insert(self.GetInfoFuncList, {
			PlayerCardRpc.sendGetPlayerCardInfoRequest,
			PlayerCardRpc.instance,
			"sendGetPlayerCardInfoRequest",
			false
		})
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CommandStation) then
		table.insert(self.GetInfoFuncList, {
			CommandStationRpc.sendGetCommandPostInfoRequest,
			CommandStationRpc.instance,
			"sendGetCommandPostInfoRequest",
			false
		})
	end

	if RougeOutsideController.instance:isOpen() then
		local season = RougeOutsideModel.instance:season()

		table.insert(self.GetInfoFuncList, {
			RougeOutsideRpc.sendGetRougeOutSideInfoRequest,
			RougeOutsideRpc.instance,
			"sendGetRougeOutSideInfoRequest",
			false,
			season
		})
	end

	self._callbackIdDict = {}
end

function LoginGetInfoWork:onStart(context)
	self:_initInfo()

	self._leftInfoCount = #self.GetInfoFuncList
	self._waitCount = 0
	self._waitCount = self._waitCount + 1

	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, self._onDungeonInfoUpdateAll, self)

	for i, requestCfg in ipairs(self.GetInfoFuncList) do
		local reqFun = requestCfg[1]
		local rpcObj = requestCfg[2]
		local reqLog = requestCfg[3]
		local ignoreRetCode = requestCfg[4]
		local optionalParam = requestCfg[5]

		local function tempCallbackFunc(cmd, resultCode, msg)
			if not ignoreRetCode and resultCode ~= 0 then
				logError((rpcObj.__cname or "nil") .. " " .. reqLog .. " 服务端报错了 resultCode = " .. resultCode)
			end

			self:_onGetInfo(i)
		end

		local callbackId = optionalParam ~= nil and reqFun(rpcObj, optionalParam, tempCallbackFunc) or reqFun(rpcObj, tempCallbackFunc)

		if callbackId then
			self._callbackIdDict[i] = callbackId
		else
			logError(((not rpcObj.__cname or nil) and "nil") .. " " .. reqLog .. " 不支持callback")
			self:_onGetInfo(i)
		end
	end

	TaskDispatcher.runDelay(self._getInfoTimeout, self, 30)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnLostConnect, self._onLostConnect, self)
end

function LoginGetInfoWork:_onGetInfo(index)
	if self._callbackIdDict[index] == nil then
		logError("登录流程有问题 index:" .. index)

		return
	end

	self._leftInfoCount = self._leftInfoCount - 1
	self._callbackIdDict[index] = nil

	self:_checkIsDone()
end

function LoginGetInfoWork:_checkIsDone()
	if self._leftInfoCount == 0 and self._waitCount == 0 then
		LoginController.instance:dispatchEvent(LoginEvent.OnGetInfoFinish)
		self:onDone(true)
	end
end

function LoginGetInfoWork:_onDungeonInfoUpdateAll()
	self._waitCount = self._waitCount - 1

	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, self._onDungeonInfoUpdateAll, self)
	self:_checkIsDone()
end

function LoginGetInfoWork:_getInfoTimeout()
	for index, callbackId in pairs(self._callbackIdDict) do
		local requestCfg = self.GetInfoFuncList[index]
		local rpcObj = requestCfg[2]
		local reqLog = requestCfg[3]

		rpcObj:removeCallbackById(callbackId)
		logError("获取信息超时，跳过保证不卡登录流程：" .. reqLog)
	end

	self._callbackIdDict = {}

	LoginController.instance:stopHeartBeat()
	ConnectAliveMgr.instance:stopReconnect()
	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginLostConnect1, MsgBoxEnum.BoxType.Yes, function()
		LoginController.instance:logout()
	end)
	self:onDone(false)
end

function LoginGetInfoWork:_onLostConnect()
	return
end

function LoginGetInfoWork:clearWork()
	self:_removeEvents()

	for index, callbackId in pairs(self._callbackIdDict) do
		local requestCfg = self.GetInfoFuncList[index]
		local rpcObj = requestCfg[2]

		rpcObj:removeCallbackById(callbackId)
	end

	self._callbackIdDict = {}
end

function LoginGetInfoWork:_removeEvents()
	TaskDispatcher.cancelTask(self._getInfoTimeout, self)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnLostConnect, self._onLostConnect, self)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, self._onDungeonInfoUpdateAll, self)
end

return LoginGetInfoWork
