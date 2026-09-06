-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/controller/MainUISequencePopupController.lua

module("logic.extensions.mainui.controller.MainUISequencePopupController", package.seeall)

local MainUISequencePopupController = class("MainUISequencePopupController", BaseController)

MainUISequencePopupController.AnimationPlayerType = 1
MainUISequencePopupController.PrefabType = 2
MainUISequencePopupController.ViewType_Push = 3
MainUISequencePopupController.ViewType_Open = 4

local DefaultCD = 180
local adaptors = {
	[MainUISequencePopupController.AnimationPlayerType] = "_playAnimationPlayer",
	[MainUISequencePopupController.PrefabType] = "_playPrefabEffect",
	[MainUISequencePopupController.ViewType_Push] = "_playViewShowPush",
	[MainUISequencePopupController.ViewType_Open] = "_playViewShowOpen"
}

function MainUISequencePopupController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._onSceneLoadedFinish, self, NotifyPriority.Low)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClose, self)

	self._cacheQueue = TimeCheckCacheQueue.New()
end

function MainUISequencePopupController:onReset()
	self._cacheQueue:reset()

	self._curViewParams = nil
	self._bPlaying = false
end

function MainUISequencePopupController:regSequence(params)
	if params and params.showType == MainUISequencePopupController.AnimationPlayerType or params.showType == MainUISequencePopupController.PrefabType or params.showType == MainUISequencePopupController.ViewType_Push or params.showType == MainUISequencePopupController.ViewType_Open then
		if string.nilorempty(params.viewNameOrPath) then
			printError("viewNameOrPath is nil", debug.traceback())

			return nil
		end

		if params.cd == nil or params.cd <= 0 then
			params.cd = DefaultCD + ServerTime.now()
		end

		local result = self._cacheQueue:pushBack(params, params.cd)

		self:_tryShowView()

		return result
	end
end

function MainUISequencePopupController:removeSequence(index)
	return self._cacheQueue:remove(index)
end

function MainUISequencePopupController:_onSceneLoadedFinish(sceneType, sceneId)
	self._curRcdSceneType = sceneType

	self:_tryShowView()
end

function MainUISequencePopupController:_onViewClose(view)
	if view.viewName == ViewName.ItemFly then
		return
	end

	if GuideController.instance:checkHasGuideView(view.viewName) then
		return
	end

	if self._curViewParams and self._curViewParams.viewNameOrPath == view.viewName then
		self:_setPlayEnd()

		return
	end

	self:_tryShowView()
end

function MainUISequencePopupController:_addDelayCheckTimer(time)
	self:_removeDelayCheckTimer()
	settimer(time, self._tryDelayShowView, self, false)
end

function MainUISequencePopupController:_removeDelayCheckTimer()
	removetimer(self._tryDelayShowView, self)
end

function MainUISequencePopupController:_tryShowView()
	if self:_isCanShow() then
		self:_addDelayCheckTimer(1)
	end
end

function MainUISequencePopupController:_tryDelayShowView()
	self:_removeDelayCheckTimer()

	if self:_isCanShow() then
		local params, bPause = self._cacheQueue:popFront(ServerTime.now())

		if bPause then
			self:_addDelayCheckTimer(0.1)

			return
		end

		if params then
			self:_playAdaptor(params)
		end
	end
end

function MainUISequencePopupController:_isCanShow()
	if self._curRcdSceneType == SceneType.City then
		local v = GlobalModel.instance:getTopView()

		if v ~= nil and v.viewName == ViewName.MainUI and ViewAutoShowController.instance:getCheckState() == ViewAutoShowController.ECheckState_Hiding then
			return not self._bPlaying
		end
	end

	return false
end

function MainUISequencePopupController:_playAdaptor(params)
	local showType = params.showType
	local funcName = adaptors[showType]

	if not string.nilorempty(funcName) and self[funcName] then
		local func = self[funcName]

		xpcall(func, function(errMsg)
			printError(errMsg)
		end, self, params)
	end
end

function MainUISequencePopupController:_setPlayStart()
	self._bPlaying = true
end

function MainUISequencePopupController:_setPlayEnd()
	self._bPlaying = false

	self:_addDelayCheckTimer(0.5)
end

function MainUISequencePopupController:_callback(func, thisArg, otherArg, ...)
	if not func or type(func) ~= "function" then
		return
	end

	local args = {
		...
	}

	if otherArg then
		table.insert(args, 1, otherArg)
	end

	if thisArg then
		table.insert(args, 1, thisArg)
	end

	local status, result = xpcall(func, function(errMsg)
		printError(errMsg)
	end, unpack(args))

	return result
end

function MainUISequencePopupController:_playAnimationPlayer(params)
	local animationPlayer

	if self:_callback(params.onBeforeStart, params.thisArg, params.otherArg) then
		self:_addDelayCheckTimer(0.5)

		return
	end

	self:_setPlayStart()

	local function playEnd()
		self:_callback(params.onPlayEnd, params.thisArg, params.otherArg, animationPlayer)
		self:_setPlayEnd()
	end

	local function playStart()
		self:_callback(params.onPlayStart, params.thisArg, params.otherArg, animationPlayer)
	end

	animationPlayer = AnimationPlayer.play(params.viewNameOrPath, playEnd, playStart)
end

function MainUISequencePopupController:_playPrefabEffect(params)
	local effect

	if self:_callback(params.onBeforeStart, params.thisArg, params.otherArg) then
		self:_addDelayCheckTimer(0.5)

		return
	end

	self:_setPlayStart()

	local function playEnd()
		self:_callback(params.onPlayEnd, params.thisArg, params.otherArg, animationPlayer)
		self:_setPlayEnd()
	end

	local function playStart()
		self:_callback(params.onPlayStart, params.thisArg, params.otherArg, animationPlayer)
	end

	effect = UIEffectManager.instance:playEffect(nil, params.viewNameOrPath, nil, 0, 0, false, nil, playEnd, playStart)
end

function MainUISequencePopupController:_playViewShowPush(params)
	if self:_callback(params.onBeforeStart, params.thisArg, params.otherArg) then
		self:_addDelayCheckTimer(0.5)

		return
	end

	self:_setPlayStart()

	self._curViewParams = params

	UIStateManager.instance:push(params.viewNameOrPath, params.otherArg)
end

function MainUISequencePopupController:_playViewShowOpen(params)
	if self:_callback(params.onBeforeStart, params.thisArg, params.otherArg) then
		self:_addDelayCheckTimer(0.5)

		return
	end

	self:_setPlayStart()

	self._curViewParams = params

	UIStateManager.instance:open(params.viewNameOrPath, params.otherArg)
end

MainUISequencePopupController.instance = MainUISequencePopupController.New()

return MainUISequencePopupController
