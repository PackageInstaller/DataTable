-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/audio/criwareAudio/CriwareAudioController.lua

module("logic.common.audio.criwareAudio.CriwareAudioController", package.seeall)

local M = class("CriwareAudioController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self._isDropDownOpen = false
	self._blockerClick = false

	GlobalDispatcher:addEventListener(EventType.FW_VIEW_OPENING_EVENT, self._onViewOpen, self)
	GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSING_EVENT, self._onViewClose, self)
	GlobalDispatcher:addEventListener(EventType.APPLICATION_QUIT, self._applicationQuit, self)
end

function M:onReset()
	self._isDropDownOpen = false
end

function M:_onViewOpen()
	return
end

function M:_onViewClose()
	return
end

function M:setIsDropDownOpen()
	self._isDropDownOpen = true

	local uiRoot = ViewMgr.instance:getUIRoot()
	local blocker = goutil.findChild(uiRoot, "Blocker")

	if blocker then
		self._blockerClick = Astral.UIClickTrigger.Get(blocker.gameObject)

		self._blockerClick:AddClickListener(self._onClickDropDown, self)
	end
end

function M:_onClickDropDown()
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_tickup, nil, nil, nil)
	self:blockerClickUnbind()
end

function M:blockerClickUnbind()
	if self._blockerClick then
		self._blockerClick:RemoveClickListener()
	end

	self._blockerClick = false
end

function M:_applicationQuit()
	CriwareAudioPlayer.instance:clearCueSheets()
end

M.instance = M.New()

return M
