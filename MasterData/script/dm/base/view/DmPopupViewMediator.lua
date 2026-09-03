-- chunkname: @/tmp/or_script/lua_compile/dm/base/view/DmPopupViewMediator.lua

require("dm.gameplay.popup.PopupBgWidget")
require("dm.gameplay.popup.PopupNormalWidget")

DmPopupViewMediator = class("DmPopupViewMediator", PopupViewMediator)

DmPopupViewMediator:has("_payload", {
	is = "r"
})
DmPopupViewMediator:has("_bgWidget", {
	is = "rw"
})
DmPopupViewMediator:has("_bPopAnimEnd", {
	is = "rw"
})

local BgWidgetArr = {
	middle = PopupMiddleBgWidget,
	small = PopupSmallBgWidget
}

function DmPopupViewMediator:initialize()
	super.initialize(self)

	self._hasEnterAnim = false
	self._bPopAnimEnd = false
end

function DmPopupViewMediator:dispose()
	self._hasEnterAnim = nil

	super.dispose(self)
end

function DmPopupViewMediator:enterWithData(data)
	super.enterWithData(self, data)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_VIEW_ENTER_REQUEST, self, self.onViewEnterRequestSuccess)

	self._payload = data or {}

	local waitInfo = self._payload.waitInfo

	self._waitInfo = waitInfo or {}

	if self._waitInfo.opCode then
		self:viewEnterRequestWithData(self._waitInfo.opCode)
	end
end

function DmPopupViewMediator:setupBgWidget(bgNode, style, params)
	local config = {
		btnHandler = params.btnHandler,
		title = params.title,
		upperCharCount = params.upperCharCount,
		bgNew = params.bgNew,
		showDiImg = params.showDiImg,
		showAnim = params.showAnim,
		height = params.height
	}
	local injector = self:getInjector()
	local widget = BgWidgetArr[style]

	assert(widget ~= nil, "style " .. style .. " not exists!")

	self._bgWidget = injector:injectInto(widget:new(bgNode))

	self._bgWidget:updateView(config)
	self:autoManageObject(self._bgWidget)

	return self._bgWidget
end

function DmPopupViewMediator:adjustLayout(targetFrame)
	self:getView():setContentSize(CC_DESIGN_RESOLUTION)
	AdjustUtils.adjustLayoutUIByRootNode(self:getView())
end

function DmPopupViewMediator:close(data)
	if self._isOnclose then
		return
	end

	self._isOnclose = true

	local options

	if self._hasEnterAnim then
		options = options or {}
		options.transition = ViewTransitionFactory:create(ViewTransitionType.kPopupExit)
	end

	if self._backBtnAnim and false then
		local blockUIPanel = ccui.Layout:create()

		blockUIPanel:setTouchEnabled(true)
		blockUIPanel:setContentSize(cc.size(1386, 852))
		blockUIPanel:setAnchorPoint(cc.p(0.5, 0.5))
		self:getView():addChild(blockUIPanel, 20000)
		blockUIPanel:center(self:getView():getContentSize())
		self._backBtnAnim:addCallbackAtFrame(88, function()
			if data and data.callback then
				data.callback()
			end

			self._backBtnAnim:stop()
			self:closeWithOptions(options, data)
		end)
		self._backBtnAnim:setPlaySpeed(2.3)
		self._backBtnAnim:gotoAndPlay(79)
	else
		if data and data.callback then
			data.callback()
		end

		self:closeWithOptions(options, data)
	end
end

function DmPopupViewMediator:onTouchMaskLayer()
	AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)
	self:close()
end

function DmPopupViewMediator:onCloseCaptureScreen()
	self.closeCaptureScreen = true
end

function DmPopupViewMediator:willStartEnterTransition(transition)
	if GameConfigs.closeCaptureScreenNode then
		return
	end

	if self.closeCaptureScreen then
		return
	end

	local sceneMeditor = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
	local areaCount = sceneMeditor:getViewStackSize()
	local viewName = sceneMeditor:getViewNameAtIndex(areaCount)

	self._areaMedi = nil

	if viewName and viewName ~= self:getViewName() then
		local bottomPopInfo = sceneMeditor:getPopupInfoViewAtIndex(areaCount, 1)

		if bottomPopInfo and bottomPopInfo.options and not bottomPopInfo.options.closeCaptureScreen then
			local areaInfo = sceneMeditor:getAreaViewInfoAtIndex(areaCount)

			if areaInfo and areaInfo.mediator then
				areaInfo.mediator:getView():setVisible(false)

				self._areaMedi = areaInfo.mediator
			end
		end
	end
end

function DmPopupViewMediator:willStartExitTransition(transition)
	if GameConfigs.closeCaptureScreenNode then
		return
	end

	dump("didFinishExitTransition____didFinishExitTransition")

	local sceneMeditor = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
	local areaCount = sceneMeditor:getViewStackSize()
	local viewName = sceneMeditor:getViewNameAtIndex(areaCount)
	local areaInfo = sceneMeditor:getAreaViewInfoAtIndex(areaCount)

	if self._areaMedi and sceneMeditor:hasMediator(self._areaMedi) and self._areaMedi and self._areaMedi.getView then
		local view = self._areaMedi:getView()

		if view then
			view:setVisible(true)
		end
	end
end

function DmPopupViewMediator:didFinishEnterTransition(transition)
	super.didFinishEnterTransition(self, transition)

	self._hasEnterAnim = not not transition
	self._bPopAnimEnd = true

	if self._bgWidget and self._bgWidget.playAnim then
		self._bgWidget:playAnim()
	end

	if not self._viewOpCode then
		local data = self:getPayload()

		if self._responseData then
			if self._waitingAnim and self._bAnimPlayEnd then
				self:dealShowViewInfo(self._responseData)
			end
		else
			self:setupUIViewHierarchy(data, bind1(self.didFinishLaunching, self), self._responseData or {})
		end
	end
end

function DmPopupViewMediator:didFinishLaunching(data)
	return
end

function DmPopupViewMediator:setupUIViewHierarchy(data, didFinishLaunching)
	if didFinishLaunching then
		didFinishLaunching(data)
	end
end

function DmPopupViewMediator:closeWaitTask()
	if self._delayShowTask then
		cancelDelayCall(self._delayShowTask)

		self._delayShowTask = nil
	end
end

function DmPopupViewMediator:dealShowViewInfo(response)
	self:closeWaitTask()
	self:viewEnterRequestShowInfo(response)

	self._responseData = nil
	self._bAnimPlayEnd = false
end

function DmPopupViewMediator:onViewEnterRequestSuccess(event)
	local data = event and event:getData() or {}

	if not data.response then
		local response = {}

		response.resCode = response.resCode or GS_SUCCESS

		local opcode = data.opcode

		if response.resCode == GS_SUCCESS then
			if self._viewOpCode == opcode then
				self._responseData = response
				self._viewOpCode = nil

				if self._bPopAnimEnd and self._waitingAnim and self._bAnimPlayEnd then
					self:dealShowViewInfo(response)
				end
			end
		else
			if self._delayShowTask then
				cancelDelayCall(self._delayShowTask)

				self._delayShowTask = nil
			end

			self:hideWaitingAnim()
		end
	end
end

function DmPopupViewMediator:viewEnterRequestWithData(opCode)
	self._viewOpCode = opCode

	self:viewEnterRequestHideInfo()
	self:showWaitingAnim()
end

function DmPopupViewMediator:viewEnterRequestShowInfo(responseData)
	responseData = responseData or {}

	local data = self:getPayload()

	self:setupUIViewHierarchy(data, bind1(self.didFinishLaunching, self), responseData)
	self:hideWaitingAnim()
	self:refreshInfoViewVisible(true)
end

function DmPopupViewMediator:viewEnterRequestHideInfo()
	self:refreshInfoViewVisible(false)
end

function DmPopupViewMediator:refreshInfoViewVisible(isVisible)
	return
end

function DmPopupViewMediator:showWaitingAnim()
	local function showAnim()
		if DisposableObject:isDisposed(self) then
			return
		end

		local view = self:getView()

		if tolua.isnull(view) then
			return
		end

		local anim = cc.MovieClip:create("jiazaizhong_jiazaizhong")

		anim:gotoAndPlay(1)

		if not self._waitInfo.pos then
			local pos = cc.p(0, 0)

			anim:setPosition(self._waitInfo.pos)
			anim:setPlaySpeed(2)
			anim:addEndCallback(function(cid, mc)
				self._bAnimPlayEnd = true

				if not self._viewOpCode and self._responseData then
					self:dealShowViewInfo(self._responseData)
				end
			end)
			anim:addTo(view, 99999):center(view:getContentSize())

			self._waitingAnim = anim
		end
	end

	self:closeWaitTask()

	self._delayShowTask = delayCallByTime(200, function()
		self._delayShowTask = nil

		showAnim()
	end)
end

function DmPopupViewMediator:hideWaitingAnim()
	if self._waitingAnim then
		self._waitingAnim:stop()
		self._waitingAnim:removeFromParent()

		self._waitingAnim = nil
	end
end
