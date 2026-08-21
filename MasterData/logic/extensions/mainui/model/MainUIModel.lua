-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/model/MainUIModel.lua

module("logic.extensions.mainui.model.MainUIModel", package.seeall)

local M = class("MainUIModel", BaseModel)
local GM_PERFORM_EDITOR_KEY = "GM_main_perform_editor_visible"
local GM_UI_DETECT_KEY = "GM_main_ui_detect_visible"
local GM_LOG_TIPS_KEY = "GM_log_tips_visible"

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self._performEditorVisible = Astral.LocalStorage.Instance:GetInt(GM_PERFORM_EDITOR_KEY, 0) == 1
	self._uiDetectVisible = Astral.LocalStorage.Instance:GetInt(GM_UI_DETECT_KEY, 1) == 1
	self._logTipsVisible = Astral.LocalStorage.Instance:GetInt(GM_LOG_TIPS_KEY, 1) == 1

	self:onReset()
end

function M:onReset()
	self:setLoginMark(true)

	self._lastMainSceneBgPerformData = nil
	self._aniCamEditorVisible = nil
	self._clickedHouseBtn = false
	self._hasPlayLookAt = false
	self._showMailTips = true

	ViewMgr.instance:close(ViewName.MainPerformEditorView)
end

function M:setLoginMark(mark)
	self._loginMark = mark
end

function M:getLoginMark()
	return self._loginMark
end

function M:getLastBgPerformData()
	return self._lastMainSceneBgPerformData
end

function M:setLastBgPerformFormula(formula, pointPerformData, recordTime, withEditorData)
	if not self._lastMainSceneBgPerformData then
		self._lastMainSceneBgPerformData = {}
	end

	self._lastMainSceneBgPerformData.formula = formula
	self._lastMainSceneBgPerformData.pointPerformData = pointPerformData

	if recordTime then
		self._lastMainSceneBgPerformData.time = ServerTime.now()
	end

	if Astral.OSDef.isEditor then
		TableUtil.dump(self._lastMainSceneBgPerformData)
	end
end

function M:setPerformEditorVisible(visible)
	self._performEditorVisible = visible

	Astral.LocalStorage.Instance:SetInt(GM_PERFORM_EDITOR_KEY, visible and 1 or 0)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_PERFORM_EDITOR, visible)
end

function M:getPerformEditorVisible()
	return self._performEditorVisible
end

function M:setAniCamEditorVisible(visible)
	self._aniCamEditorVisible = visible

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_ANI_CAM_EDITOR, visible)
end

function M:getAniCamEditorVisible()
	return self._aniCamEditorVisible
end

function M:setUIDetectVisible(visible)
	if not Astral.OSDef.isEditor then
		visible = false
	end

	self._uiDetectVisible = visible

	Astral.LocalStorage.Instance:SetInt(GM_UI_DETECT_KEY, visible and 1 or 0)
end

function M:getUIDetectVisible()
	if not Astral.OSDef.isEditor then
		return false
	end

	if self._uiDetectVisible == nil then
		self._uiDetectVisible = Astral.LocalStorage.Instance:GetInt(GM_UI_DETECT_KEY, 1) == 1
	end

	return self._uiDetectVisible
end

function M:setLogTipsVisible(visible)
	self._logTipsVisible = visible

	Astral.LocalStorage.Instance:SetInt(GM_LOG_TIPS_KEY, visible and 1 or 0)
end

function M:getLogTipsVisible()
	return self._logTipsVisible
end

function M:setClickedHouseBtn(isClicked)
	self._clickedHouseBtn = isClicked
end

function M:getClickedHouseBtn()
	return self._clickedHouseBtn
end

function M:setPlayLookAtState(hasPlay)
	self._hasPlayLookAt = hasPlay
end

function M:getPlayLookAtState()
	return self._hasPlayLookAt
end

function M:setShowMailTips(show)
	self._showMailTips = show
end

function M:getShowMailTips()
	return self._showMailTips
end

M.instance = M.New()

return M
