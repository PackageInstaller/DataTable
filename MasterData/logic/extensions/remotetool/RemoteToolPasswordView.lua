-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/remotetool/RemoteToolPasswordView.lua

module("logic.extensions.remotetool.RemoteToolPasswordView", package.seeall)

local RemoteToolPasswordView = class("RemoteToolPasswordView", ViewComponent)

RemoteToolPasswordView.password = "100110"
RemoteToolPasswordView.inputPassword = ""
RemoteToolPasswordView.inputCount = 0

function RemoteToolPasswordView:buildUI()
	self._btn0 = self:getBtn("login_start_view_copy_-1903504391")
	self._btn1 = self:getBtn("login_start_view_copy_715222292")
end

function RemoteToolPasswordView:bindEvents()
	self._btn0:AddClickListener(self._onClickBtn0, self)
	self._btn1:AddClickListener(self._onClickBtn1, self)
end

function RemoteToolPasswordView:unbindEvents()
	self._btn1:RemoveClickListener()
	self._btn0:RemoveClickListener()
end

function RemoteToolPasswordView:onEnter()
	GlobalDispatcher:addEventListener(EventType.RESET_REMOTE_TOOL_PASSARD, self._reset, self)
	self:_reset()

	local value = GameUtils.getLocalInt(BackDoorToolView.cacheKey, 0)

	if value == 1 and not enableDebug then
		GameUtils.changeDebugState(true)
		GlobalDispatcher:dispatchEvent(EventType.ENABLE_DEBUG_STATUS_CHANGE, true)

		local go = goutil.find("AstralUnityStarter")

		if go then
			goutil.addComponentOnce(go, typeof(DebugToolServerComponent))
		end
	end
end

function RemoteToolPasswordView:onExit()
	GlobalDispatcher:removeEventListener(EventType.RESET_REMOTE_TOOL_PASSARD, self._reset, self)

	self._comp = nil
end

function RemoteToolPasswordView:destroyUI()
	return
end

function RemoteToolPasswordView:_onClickBtn1()
	if RemoteToolPasswordView.inputCount > 6 then
		return
	end

	RemoteToolPasswordView.inputPassword = RemoteToolPasswordView.inputPassword .. "1"

	self:_checkPassWord()
end

function RemoteToolPasswordView:_onClickBtn0()
	if RemoteToolPasswordView.inputCount > 6 then
		return
	end

	RemoteToolPasswordView.inputPassword = RemoteToolPasswordView.inputPassword .. "0"

	self:_checkPassWord()
end

function RemoteToolPasswordView:_checkPassWord()
	RemoteToolPasswordView.inputCount = RemoteToolPasswordView.inputCount + 1

	if RemoteToolPasswordView.inputPassword == RemoteToolPasswordView.password then
		ViewMgr.instance:open(ViewName.BackDoorToolView)
	end
end

function RemoteToolPasswordView:_reset()
	RemoteToolPasswordView.inputPassword = ""
	RemoteToolPasswordView.inputCount = 0
end

return RemoteToolPasswordView
