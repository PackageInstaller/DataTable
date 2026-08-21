-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemopen/view/OpenFunctionsHintTips.lua

module("logic.extensions.systemopen.view.OpenFunctionsHintTips", package.seeall)

local M = class("OpenFunctionsHintTips", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._btnClose = self:getBtn("open_functions_hint_tips_1762342196")
	self._imgIcon = self:getImage("open_functions_hint_tips_1437542000")
	self._txtTitle = self:getText("open_functions_hint_tips_519049734")
	self._txtName = self:getText("open_functions_hint_tips_58201772")
	self._txtDesc = self:getText("open_functions_hint_tips_-941572365")

	local rawImgBlur = goutil.findChildRawImageComponent(self.mainGO, "common_blur_rt")

	rawImgBlur.raycastTarget = false
end

function M:destroyUI()
	self._codeIndex = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self._playingTimeLineAni = "open"

	local info = self:getFirstParam() or {}

	self._orgCode = info.code
	self._singleMode = info.singleMode
	self._exitFunc = info.exitFunc
	self._exitHandler = info.exitHandler

	if Astral.OSDef.isEditor then
		TableUtil.dump(info)
	end

	self:setEvent(true)

	self._codeIndex = 0

	self:tryShowNext()
end

function M:onExit()
	self:setEvent(false)

	if not self._singleMode then
		SystemOpenModel.instance:clearSystemOpenHint()
	end

	if self._exitFunc then
		if self._exitHandler then
			self._exitFunc(self._exitHandler)
		else
			self._exitFunc()
		end
	end

	self._exitFunc = nil
	self._exitHandler = nil
end

function M:onExitFinished()
	GlobalDispatcher:dispatchEvent(EventType.CHECK_MONUMENTS_POP_EVENT)
end

function M:setEvent(add)
	if add then
		self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	else
		self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	end
end

function M:_handleViewAniDoneEvent(key, tagName, reason)
	self._playingTimeLineAni = false
end

function M:_onClickClose()
	local gadgetView = self._viewPresentor:getTimelineGadgetView()

	if gadgetView and not gadgetView:getOpenAniFinish() then
		return
	end

	if self._playingTimeLineAni then
		if enableLog then
			printWarn("正在播:", self._playingTimeLineAni)
		end

		return
	end

	self:tryShowNext()
end

function M:getCode(index)
	if self._singleMode then
		return nil
	end

	local lst = SystemOpenModel.instance:getSystemOpenHintLst()

	return lst[index]
end

function M:tryShowNext()
	self._codeIndex = self._codeIndex + 1

	local code = self:getCode(self._codeIndex)

	if not code and self._codeIndex == 1 then
		code = self._orgCode
	end

	if not code then
		self:close()

		return
	end

	GlobalDispatcher:dispatchEvent(EventType.ON_SYSTEM_OPEN_HINT_SHOW, code)

	local cfg = SystemOpenConfig.instance:getSystemOpenHint(code)

	if not cfg then
		printError(string.format("无法从[t_%s]找到code[%s]的配置", ConfigName.SystemOpenHint, code))
		self:close()

		return
	end

	self._orgCode = nil

	self:refreshView(cfg)
end

function M:refreshView(cfg)
	self._txtTitle.text = string.nilorempty(cfg.title) and lang("new_system_open") or cfg.title
	self._txtName.text = cfg.name
	self._txtDesc.text = cfg.unlockHintDesc

	if not string.nilorempty(cfg.icon) then
		IconLoader.setSprite(self._imgIcon, IconType.Skinlib, cfg.icon)
	end

	if not self._playingTimeLineAni then
		self._playingTimeLineAni = "cutover"

		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName(self._playingTimeLineAni)
	end
end

return M
