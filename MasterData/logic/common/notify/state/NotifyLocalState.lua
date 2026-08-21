-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/notify/state/NotifyLocalState.lua

module("logic.common.notify.state.NotifyLocalState", package.seeall)

local NotifyLocalState = class("NotifyLocalState")

function NotifyLocalState:ctor()
	return
end

function NotifyLocalState:init()
	GlobalDispatcher:addListener(GlobalNotify.RoleInfoPushed, self._handleGetPlayerInfoFinish, self)
	GlobalDispatcher:addListener(GlobalNotify.RoleLevelUp, self._handlePlayerUpGradeStatus, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationPause, self._handleGamePause, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationQuit, self._handleGameQuit, self)

	if SDKManager.getSDKInstacne():isIOS() then
		self:_registerAllLocalPush()
	elseif NotificationMgr.isXiaoMi() then
		self:_registerAllLocalPush()
	end
end

function NotifyLocalState:_registerAllLocalPush()
	NotificationMgr.clearNotifications()

	local dataList = PushConfig.instance:getPushCfg().dataList
	local dailyIds = {}
	local intervalIds = {}
	local weekIds = {}

	for i = 1, #dataList do
		local data = dataList[i]

		if data.isServer == 0 then
			if data.type == NotificationType.TYPE_INTERVAL then
				table.insert(intervalIds, data.code)
			elseif data.type == NotificationType.TYPE_DAILY then
				-- block empty
			elseif data.type == NotificationType.TYPE_WEEKLY then
				-- block empty
			end
		end
	end

	NotificationMgr.registerNotifyIds(NotificationType.TYPE_INTERVAL, intervalIds)
end

function NotifyLocalState:_handleGetPlayerInfoFinish()
	self:_updateAllConfigToPushData()
end

function NotifyLocalState:_handlePlayerUpGradeStatus(status)
	self:_updateAllConfigToPushData()
end

function NotifyLocalState:_handleGamePause(status)
	if enableLog then
		print("===========NotifyLocalState:_handleGamePause================")
	end

	self:_updateAllConfigToPushData()
end

function NotifyLocalState:_handleGameQuit(status)
	if enableLog then
		print("===========NotifyLocalState:_handleGameQuit================")
	end

	self:_updateAllConfigToPushData()
end

function NotifyLocalState:_updateAllConfigToPushData()
	if SDKManager.getSDKInstacne():isIOS() then
		if enableLog then
			print("===========SDKManager.getSDKInstacne():isIOS()================")
		end
	elseif not NotificationMgr.isXiaoMi() then
		NotificationMgr.clearNotifications()
	end

	local dataList = PushConfig.instance:getPushCfg().dataList

	for i = 1, #dataList do
		local data = dataList[i]

		if data.isServer == 0 then
			if data.type == NotificationType.TYPE_DAILY then
				self:_setDaily(data)
			elseif data.type == NotificationType.TYPE_WEEKLY then
				self:_setWeekly(data)
			elseif data.type == NotificationType.TYPE_INTERVAL then
				self:_setInterval(data)
			end
		end
	end
end

function NotifyLocalState:_setDaily(co)
	local curPlayerLevel = RoleFacade.instance:getRoleLevel()

	if curPlayerLevel >= co.level then
		NotificationMgr.notifyIntervalBatch(co, true)
	end
end

function NotifyLocalState:_setWeekly(co)
	local curPlayerLevel = RoleFacade.instance:getRoleLevel()

	if curPlayerLevel >= co.level then
		NotificationMgr.notifyIntervalBatch(co, false)
	end
end

function NotifyLocalState:_setInterval(co)
	if co.subType == NotifyLocalConfigType.Common then
		self:_setIntervalCommon(co)
	elseif co.subType == NotifyLocalConfigType.EquipCast then
		self:_setEquipCash(co)
	elseif co.subType == NotifyLocalConfigType.Fishing then
		self:_setFishing(co)
	end
end

function NotifyLocalState:_setIntervalCommon(co)
	local curPlayerLevel = RoleFacade.instance:getRoleLevel()

	if curPlayerLevel >= co.level then
		local remainT = checknumber(co.time) * 24 * 3600 * 1000
		local intervalModel = NotificationModel.getIntervalModel(co.code, co.title, co.content, remainT, false)

		NotificationMgr.notifyInterval(intervalModel)
	end
end

function NotifyLocalState:_setEquipCash(co)
	local castRemainTime = EquipmentStrengthenCastModel.instance:getCastRemainTime()

	if enableLog then
		print("===========NotifyLocalState:_setEquipCash===============castRemainTime=" .. castRemainTime)
	end

	if castRemainTime == 0 then
		return
	end

	local curPlayerLevel = RoleFacade.instance:getRoleLevel()

	if curPlayerLevel >= co.level then
		local remainT = castRemainTime * 1000
		local intervalModel = NotificationModel.getIntervalModel(co.code, co.title, co.content, remainT, false)

		NotificationMgr.notifyInterval(intervalModel)
	end
end

function NotifyLocalState:_setFishing(co)
	local fishRemainTime = FishingCatchModel.instance:getCurMinCatchTime()

	if enableLog then
		print("===========NotifyLocalState:_setFishing===============fishRemainTime=" .. fishRemainTime)
	end

	if fishRemainTime == 0 then
		return
	end

	local curPlayerLevel = RoleFacade.instance:getRoleLevel()

	if curPlayerLevel >= co.level then
		local remainT = fishRemainTime * 1000
		local intervalModel = NotificationModel.getIntervalModel(co.code, co.title, co.content, remainT, false)

		NotificationMgr.notifyInterval(intervalModel)
	end
end

NotifyLocalState.instance = NotifyLocalState.New()

return NotifyLocalState
