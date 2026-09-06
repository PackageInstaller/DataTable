-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/usualviews/BtnLongPressHelper.lua

module("logiccommon.common.viewlib.usualviews.BtnLongPressHelper", package.seeall)

local BtnLongPressHelper = class("BtnLongPressHelper")

function BtnLongPressHelper:ctor()
	self._maxPressTime = 0.2
	self._pressCallTime = -1
end

function BtnLongPressHelper.create(mainGo)
	if goutil.isNil(mainGo) then
		printError("传入实例为空")

		return nil
	end

	local instance = BtnLongPressHelper.New()

	instance:_init(mainGo)

	return instance
end

function BtnLongPressHelper:addClickHandler(handler)
	self._clickHandler = handler
end

function BtnLongPressHelper:rmClickHandler()
	self._clickHandler = nil
end

function BtnLongPressHelper:addPressUpdateHandler(handler)
	self._pressUpdateHandler = handler
end

function BtnLongPressHelper:rmPressUpdateHandler()
	self._pressUpdateHandler = nil
end

function BtnLongPressHelper:addPressStartHandler(handler)
	self._pressStartHandler = handler
end

function BtnLongPressHelper:rmPressStartHandler()
	self._pressStartHandler = nil
end

function BtnLongPressHelper:addLongPressStartHandler(handler)
	self._longPressStartHandler = handler
end

function BtnLongPressHelper:rmLongPressStartHandler()
	self._longPressStartHandler = nil
end

function BtnLongPressHelper:addPressEndHandler(handler)
	self._pressEndHandler = handler
end

function BtnLongPressHelper:rmPressEndHandler()
	self._pressEndHandler = nil
end

function BtnLongPressHelper:addPressHandler(startHandler, endHandler, progressHandler)
	self:addPressStartHandler(startHandler)
	self:addPressEndHandler(endHandler)
	self:addPressUpdateHandler(progressHandler)
end

function BtnLongPressHelper:onPressTimeHandler(time, handler)
	self._pressCallTime = time
	self._pressTimeCallHandler = handler
end

function BtnLongPressHelper:rmPressTimeHandler()
	self._pressCallTime = -1
	self._pressTimeCallHandler = nil
end

function BtnLongPressHelper:clearAllHandlers()
	self:_resetData()
	self:rmClickHandler()
	self:rmPressUpdateHandler()
	self:rmPressEndHandler()
	self:rmPressStartHandler()
	self:rmLongPressStartHandler()
	self:rmPressTimeHandler()

	if self._longPress then
		self._longPress:RemoveListener()
		self._longPress:RemoveToggledListener()
	end
end

function BtnLongPressHelper:reInit(mainGo)
	self:_init(mainGo)
end

function BtnLongPressHelper:_init(mainGo)
	self._mainGo = mainGo.gameObject

	local scaleBtn = mainGo.gameObject:GetComponent("UIScaleButton")

	if scaleBtn == nil then
		local btn = goutil.addComponentOnce(mainGo.gameObject, typeof(UnityEngine.UI.Button))

		if btn then
			btn.enabled = false
		end
	end

	self:_resetData()

	self._longPress = mainGo.gameObject:GetComponent(typeof(UILongPressed))

	if self._longPress == nil then
		self._longPress = mainGo.gameObject:AddComponent(typeof(UILongPressed))
	end

	if self._longPress then
		self._longPress:AddListener(function(tar, isUp)
			self:_onLongPress(isUp)
		end, self)

		self._longPress.pressAndHoldDelay = 0
		self._longPress.pressedToggledDelta = 0
		self._longPress.distancePercent = 1280

		self._longPress:AddToggledListener(function()
			if self._isPressing == false then
				return
			end

			local deltaTime = UnityEngine.Time.deltaTime

			self._pressTime = self._pressTime + deltaTime

			if self._pressTime >= self._maxPressTime and not self._isLongPress then
				self._isLongPress = true

				GameUtil.callBack(self._pressStartHandler)
				GameUtil.callBack(self._longPressStartHandler)
			end

			if self._isLongPress then
				GameUtil.callBack(self._pressUpdateHandler, deltaTime, self._pressTime)

				if self._pressCallTime > 0 and self._pressTime >= self._pressCallTime and not self._isCallTimeHanlder then
					self._isCallTimeHanlder = true

					GameUtil.callBack(self._pressTimeCallHandler, self._pressTime)
				end
			end
		end, self)
	end
end

function BtnLongPressHelper:_onLongPress(isUp)
	if isUp then
		if self._pressTime < self._maxPressTime then
			GameUtil.callBack(self._clickHandler)
		else
			GameUtil.callBack(self._pressEndHandler, self._pressTime)
		end

		self:_resetData()
	else
		self:_resetData()

		self._isPressing = true

		GameUtil.callBack(self._pressStartHandler)
	end
end

function BtnLongPressHelper:dispose()
	self:clearAllHandlers()
end

function BtnLongPressHelper:_resetData()
	self._isPressing = false
	self._pressTime = 0
	self._isLongPress = false
	self._isCallTimeHanlder = false
end

return BtnLongPressHelper
