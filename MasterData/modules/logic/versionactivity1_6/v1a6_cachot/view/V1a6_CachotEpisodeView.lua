-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotEpisodeView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEpisodeView", package.seeall)

local V1a6_CachotEpisodeView = class("V1a6_CachotEpisodeView", BaseView)
local EpisodeState = {
	BeforeSelect = 1,
	AfterSelect = 3,
	Select = 2
}

function V1a6_CachotEpisodeView:onInitView()
	self._gorotate = gohelper.findChild(self.viewGO, "rotate")
	self._txttitle = gohelper.findChildTextMesh(self.viewGO, "rotate/#simage_title/#txt_title")
	self._simageepisode = gohelper.findChildSingleImage(self.viewGO, "rotate/layout/#simage_episode")
	self._scroll = gohelper.findChild(self.viewGO, "rotate/layout/#scroll_view"):GetComponent(gohelper.Type_ScrollRect)
	self._viewPort = gohelper.findChild(self.viewGO, "rotate/layout/#scroll_view/Viewport")
	self._txtLeft = gohelper.findChildTextMesh(self.viewGO, "rotate/layout/#scroll_view/Viewport/#txt_NormalContent")
	self._goleftarrow = gohelper.findChild(self.viewGO, "rotate/layout/#scroll_view/Viewport/#txt_NormalContent/arrow")
	self._gobottom = gohelper.findChild(self.viewGO, "bottom")
	self._gobottomarrow = gohelper.findChild(self.viewGO, "bottom/go_normalcontent/arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotEpisodeView:addEvents()
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, self._onTouchScreenUp, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.PlayChoiceDialog, self.playChoiceDialog, self)
end

function V1a6_CachotEpisodeView:removeEvents()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, self._onTouchScreenUp, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.PlayChoiceDialog, self.playChoiceDialog, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V1a6_CachotEpisodeView:_editableInitView()
	self._dialogItem = MonoHelper.addLuaComOnceToGo(self._gobottom, TMPFadeIn)
	self._dialogItemLeft = MonoHelper.addLuaComOnceToGo(self._txtLeft.gameObject, TMPFadeInWithScroll)

	local viewPortTrans = self._viewPort.transform

	self._viewportWidth = recthelper.getWidth(viewPortTrans)
	self._viewportHeight = recthelper.getHeight(viewPortTrans)
end

function V1a6_CachotEpisodeView:onOpen()
	self._openTime = UnityEngine.Time.realtimeSinceStartup
	V1a6_CachotRoomModel.instance.isFromDramaToDrama = false

	self:_refreshView()
end

function V1a6_CachotEpisodeView:onUpdateParam()
	self:_refreshView()
end

function V1a6_CachotEpisodeView:_refreshView()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_choices_open_1)
	V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.Choice)
	gohelper.setActive(self._gobottom, false)

	self._eventCo = lua_rogue_event_drama_choice.configDict[lua_rogue_event.configDict[self.viewParam.eventId].eventId]
	self._dialogCo = lua_rogue_dialog.configDict[self._eventCo.dialogId]
	self._txttitle.text = self._eventCo.title
	self._status = EpisodeState.BeforeSelect
	self._stepIndex = 1

	if not self._dialogCo then
		gohelper.setActive(self._gorotate, false)
	end

	self:onStep()
end

function V1a6_CachotEpisodeView:_onTouchScreen()
	self._touchScreenDt = nil

	if not self:_checkCanNextStep() then
		return
	end

	if self._dialogItem:isPlaying() then
		self._dialogItem:conFinished()

		return
	end

	if self._dialogItemLeft:isPlaying() then
		self._dialogItemLeft:conFinished()

		return
	end

	local mousePosition = GamepadController.instance:getMousePosition()
	local touchPos = recthelper.screenPosToAnchorPos(mousePosition, self._viewPort.transform)

	if touchPos.x >= 0 and touchPos.x <= self._viewportWidth and touchPos.y <= 0 and touchPos.y >= -self._viewportHeight then
		local txtHeight = recthelper.getHeight(self._txtLeft.transform)

		if txtHeight > self._viewportHeight then
			self._touchScreenDt = UnityEngine.Time.realtimeSinceStartup
			self._touchPos = mousePosition

			return
		end
	end

	self._stepIndex = self._stepIndex + 1

	self:onStep()
end

function V1a6_CachotEpisodeView:_onTouchScreenUp()
	if self._touchScreenDt then
		if UnityEngine.Time.realtimeSinceStartup - self._touchScreenDt > 0.2 then
			self._touchScreenDt = nil

			return
		end

		self._touchScreenDt = nil

		local mousePosition = GamepadController.instance:getMousePosition()

		if math.abs(self._touchPos.x - mousePosition.x) <= 10 and math.abs(self._touchPos.y - mousePosition.y) <= 10 then
			self._stepIndex = self._stepIndex + 1

			self:onStep()
		end
	end
end

function V1a6_CachotEpisodeView:_checkCanNextStep()
	if not self._openTime or UnityEngine.Time.realtimeSinceStartup - self._openTime < 1 then
		return false
	end

	if self._status == EpisodeState.Select then
		return false
	end

	if PopupController.instance:getPopupCount() > 0 then
		return false
	end

	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return false
	end

	return true
end

function V1a6_CachotEpisodeView:playChoiceDialog(dialogId)
	self._stepIndex = 1
	self._status = EpisodeState.AfterSelect
	self._dialogCo = lua_rogue_dialog.configDict[dialogId]

	if self:_checkCanNextStep() then
		self:onStep()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	end
end

function V1a6_CachotEpisodeView:_onCloseViewFinish()
	if self:_checkCanNextStep() then
		self:onStep()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	end
end

function V1a6_CachotEpisodeView:onStep()
	if not self._dialogCo or not self._dialogCo[self._stepIndex] then
		if self._status == EpisodeState.BeforeSelect then
			self._status = EpisodeState.Select

			gohelper.setActive(self._gobottom, false)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_choices_open_2)
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.ShowHideChoice, V1a6_CachotEventConfig.instance:getChoiceCos(self._eventCo.group))
		elseif self._status == EpisodeState.AfterSelect then
			local topEvent = V1a6_CachotRoomModel.instance:getNowTopEventMo()

			if topEvent and topEvent:getEventCo().type == V1a6_CachotEnum.EventType.ChoiceSelect then
				V1a6_CachotEventController.instance:setPause(false, V1a6_CachotEnum.EventPauseType.Choice)
				V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.ShowHideChoice, false)
			else
				self:closeThis()
			end
		end

		return
	end

	local co = self._dialogCo[self._stepIndex]

	if co.type == 1 then
		gohelper.setActive(self._gorotate, true)
		self._dialogItemLeft:playNormalText(co.text)

		self._scroll.horizontalNormalizedPosition = 0

		self._scroll:StopMovement()
		self._simageepisode:LoadImage(ResUrl.getV1a6CachotIcon("event/" .. co.photo))
	else
		gohelper.setActive(self._gobottom, true)
		self._dialogItem:playNormalText(co.text)
	end

	gohelper.setActive(self._goleftarrow, co.type == 1)
	gohelper.setActive(self._gobottomarrow, co.type == 2)
end

function V1a6_CachotEpisodeView:onClose()
	V1a6_CachotEventController.instance:setPause(false, V1a6_CachotEnum.EventPauseType.Choice)
end

function V1a6_CachotEpisodeView:onDestroyView()
	self._simageepisode:UnLoadImage()
end

return V1a6_CachotEpisodeView
