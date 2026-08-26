-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114Live2dView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114Live2dView", package.seeall)

local Activity114Live2dView = class("Activity114Live2dView", BaseView)

function Activity114Live2dView:ctor(path)
	self._path = path
end

function Activity114Live2dView:onInitView()
	self.go = gohelper.findChild(self.viewGO, self._path or "")
	self._lightspine = gohelper.findChild(self.go, "#simage_spinemask/roleContainer/#go_lightspine")
	self._btnClick = gohelper.findChildButton(self.go, "#simage_spinemask/#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114Live2dView:addEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	Activity114Controller.instance:registerCallback(Activity114Event.OnEventProcessStart, self._onEventBegin, self)
	Activity114Controller.instance:registerCallback(Activity114Event.OnEventEndWithResult, self._onEventEnd, self)
	self._btnClick:AddClickListener(self._onClick, self)
end

function Activity114Live2dView:removeEvents()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnEventProcessStart, self._onEventBegin, self)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnEventEndWithResult, self._onEventEnd, self)
	self._btnClick:RemoveClickListener()
end

function Activity114Live2dView:onOpen()
	self._motionCo = Activity114Config.instance:getMotionCo()
end

function Activity114Live2dView:_onOpenView(viewName)
	if viewName ~= ViewName.Activity114PhotoView then
		return
	end

	self._pauseAnim = true

	TaskDispatcher.cancelTask(self._playTriggerAnim, self)
end

function Activity114Live2dView:_onClick()
	local anim = self._motionCo[Activity114Enum.MotionType.Click]

	if self._clickDt and ServerTime.now() - self._clickDt < tonumber(anim.param) then
		return
	end

	self._clickDt = math.huge

	TaskDispatcher.cancelTask(self._playTriggerAnim, self)

	self._isFirstTime = true

	self:_playMotion(anim)
end

function Activity114Live2dView:_playMotion(config)
	if not self._uiSpine then
		return
	end

	local voiceConfig = {
		mouth = "",
		motion = config.motion,
		face = config.face
	}

	self._uiSpine:playVoice(voiceConfig)
end

function Activity114Live2dView:_onEventBegin()
	self._pauseAnim = true

	TaskDispatcher.cancelTask(self._playTriggerAnim, self)
end

function Activity114Live2dView:_onEventEnd(type, result)
	self._pauseAnim = false

	local motionType

	if type == Activity114Enum.EventType.Rest then
		motionType = Activity114Enum.MotionType.Rest
	elseif type == Activity114Enum.EventType.KeyDay then
		motionType = Activity114Enum.MotionType.KeyDay
	elseif type == Activity114Enum.EventType.Edu then
		motionType = Activity114Enum.MotionType.Edu
	else
		return
	end

	local co = self._motionCo[motionType]

	co = co and co[result]
	self._isFirstTime = true

	if co then
		self:_playMotion(co)
	else
		TaskDispatcher.runDelay(self._playTriggerAnim, self, self._motionCo.firstTime)
	end
end

function Activity114Live2dView:_onCloseView(viewName)
	if viewName ~= ViewName.Activity114PhotoView then
		return
	end

	self._pauseAnim = false
	self._isFirstTime = true

	TaskDispatcher.runDelay(self._playTriggerAnim, self, self._motionCo.firstTime)
end

function Activity114Live2dView:_playTriggerAnim()
	self._isFirstTime = false

	local allAnim = self._motionCo[Activity114Enum.MotionType.Time]
	local rand = allAnim[math.random(1, #allAnim)]

	self:_playMotion(rand)
end

function Activity114Live2dView:_onAnimEnd(actName)
	if self._clickDt == math.huge then
		self._clickDt = ServerTime.now()
	end

	if self._pauseAnim then
		return
	end

	if self._isFirstTime then
		TaskDispatcher.runDelay(self._playTriggerAnim, self, self._motionCo.firstTime)
	else
		TaskDispatcher.runDelay(self._playTriggerAnim, self, self._motionCo.nextTime)
	end
end

function Activity114Live2dView:_editableInitView()
	self._uiSpine = GuiModelAgent.Create(self._lightspine, true)

	self._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, self.viewName)

	local skinCo = lua_skin.configDict[305601]

	self._uiSpine:setResPath(skinCo, self.onSpineLoaded, self)
	self._uiSpine:setModelVisible(true)

	self._l2d = self._uiSpine:_getLive2d()

	self._l2d:setActionEventCb(self._onAnimEnd, self)
end

function Activity114Live2dView:onSpineLoaded()
	return
end

function Activity114Live2dView:getUISpine()
	if self._uiSpine then
		return self._uiSpine
	end
end

function Activity114Live2dView:onClose()
	TaskDispatcher.cancelTask(self._playTriggerAnim, self)
end

function Activity114Live2dView:onDestroyView()
	TaskDispatcher.cancelTask(self._playTriggerAnim, self)

	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end
end

return Activity114Live2dView
