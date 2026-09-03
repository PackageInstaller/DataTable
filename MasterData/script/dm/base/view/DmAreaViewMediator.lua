-- chunkname: @/tmp/or_script/lua_compile/dm/base/view/DmAreaViewMediator.lua

DmAreaViewMediator = class("DmAreaViewMediator", AreaViewMediator, _M)

DmAreaViewMediator:has("_payload", {
	is = "r"
})
DmAreaViewMediator:has("_bAreaAnimEnd", {
	is = "rw"
})

function DmAreaViewMediator:initialize()
	super.initialize(self)

	self._spinePool = SpineResManager.pushReleasePool()
end

function DmAreaViewMediator:enterWithData(data)
	super.enterWithData(self, data)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_VIEW_ENTER_REQUEST, self, self.onViewEnterRequestSuccess)

	self._payload = data or {}

	local waitInfo = self._payload.waitInfo

	self._waitInfo = waitInfo or {}

	if self._waitInfo.opCode then
		self:viewEnterRequestWithData(self._waitInfo.opCode)
	end
end

function DmAreaViewMediator:dispose()
	SpineResManager.popReleasePool(self._spinePool)
	super.dispose(self)
end

function DmAreaViewMediator:adjustLayout(targetFrame)
	self._view:setContentSize(CC_DESIGN_RESOLUTION)
	tolua.cast(self._view, "cc.Layer")
	self._view:onTouch(function()
		return true
	end, false, true)
	AdjustUtils.adjustLayoutUIByRootNode(self._view)
end

function DmAreaViewMediator:adaptBackground(node, targetWorldRect, anchorPt)
	if not node then
		return
	end

	local parent = node:getParent()
	local visibleSize = cc.Director:getInstance():getVisibleSize()
	local tmpTargetWorldRect = setmetatable({}, {
		__index = targetWorldRect
	})

	if parent then
		local worldToNodePoint = parent:convertToNodeSpace(cc.p(tmpTargetWorldRect.x or 0, tmpTargetWorldRect.y or 0))

		tmpTargetWorldRect.x = worldToNodePoint.x
		tmpTargetWorldRect.y = worldToNodePoint.y

		if targetWorldRect and targetWorldRect.width and targetWorldRect.height then
			tmpTargetWorldRect.width = targetWorldRect.width or visibleSize.width
			tmpTargetWorldRect.height = targetWorldRect.height or visibleSize.height
		else
			tmpTargetWorldRect.width = visibleSize.width
			tmpTargetWorldRect.height = visibleSize.height
		end
	end

	node:coverRegion(tmpTargetWorldRect, anchorPt)
end

function DmAreaViewMediator:didFinishEnterTransition(transition)
	dump("didFinishEnterTransition")
	super.didFinishEnterTransition(self, transition)

	self._bAreaAnimEnd = true

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

function DmAreaViewMediator:didFinishLaunching(data)
	return
end

function DmAreaViewMediator:setupUIViewHierarchy(data, didFinishLaunching, responseData)
	if didFinishLaunching then
		didFinishLaunching(data, responseData)
	end
end

function DmAreaViewMediator:willBeCovered()
	return
end

function DmAreaViewMediator:closeWaitTask()
	if self._delayShowTask then
		cancelDelayCall(self._delayShowTask)

		self._delayShowTask = nil
	end
end

function DmAreaViewMediator:dealShowViewInfo(response)
	dump("dealShowViewInfo")
	self:closeWaitTask()
	self:viewEnterRequestShowInfo(response)

	self._viewOpCode = nil
	self._responseData = nil
end

function DmAreaViewMediator:onViewEnterRequestSuccess(event)
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
			self:hideWaitingAnim()
		end
	end
end

function DmAreaViewMediator:viewEnterRequestWithData(opCode)
	self._viewOpCode = opCode

	self:viewEnterRequestHideInfo()
	self:showWaitingAnim()
end

function DmAreaViewMediator:viewEnterRequestShowInfo(responseData)
	self._viewOpCode = nil
	responseData = responseData or {}

	local data = self:getPayload()

	self:setupUIViewHierarchy(data, bind1(self.didFinishLaunching, self), responseData)
	self:hideWaitingAnim()
	self:refreshInfoViewVisible(true)
end

function DmAreaViewMediator:viewEnterRequestHideInfo()
	self:refreshInfoViewVisible(false)
end

function DmAreaViewMediator:refreshInfoViewVisible(isVisible)
	return
end

function DmAreaViewMediator:showWaitingAnim()
	dump("showWaitingAnim11111")

	local function showAnim()
		if DisposableObject:isDisposed(self) then
			return
		end

		local view = self:getView()

		if tolua.isnull(view) then
			return
		end

		dump("showWaitingAnim")

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

function DmAreaViewMediator:hideWaitingAnim()
	if self._waitingAnim then
		self._waitingAnim:stop()
		self._waitingAnim:removeFromParent()

		self._waitingAnim = nil
	end
end
