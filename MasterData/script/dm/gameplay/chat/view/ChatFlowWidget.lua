-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/chat/view/ChatFlowWidget.lua

ChatFlowWidget = class("ChatFlowWidget", BaseWidget, _M)

function ChatFlowWidget.class:createWidgetNode()
	local resFile = "asset/ui/ChatFlowWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

function ChatFlowWidget:initialize(view)
	super.initialize(self, view)
	view:setOpacity(0)

	local layout = view:getChildByName("layout")

	layout:addTouchEventListener(function(sender, eventType)
		self:onClickGoUrl(sender, eventType)
	end)
end

function ChatFlowWidget:dispose()
	if self._flowTask then
		self._flowTask:stop()

		self._flowTask = nil
	end

	local view = self._view

	if view then
		view:removeFromParent()

		self._view = nil
	end

	super.dispose(self)
end

function ChatFlowWidget:start(channelId)
	self._channelId = channelId

	local view = self:getView()
	local layout = view:getChildByName("layout")
	local layoutSize = layout:getContentSize()

	layout:setSwallowTouches(false)

	local chatSystem = self:getInjector():getInstance("ChatSystem")
	local chat = chatSystem:getChat()
	local channel = chat:getChannel(channelId)
	local speed = 100
	local isRunning = false
	local isVisible = false
	local index = 1

	local function playFlow()
		if isRunning then
			return
		end

		local systemKeeper = self:getInjector():getInstance(SystemKeeper)

		if not systemKeeper:canShow("Announce_System") then
			view:setVisible(false)

			return
		else
			view:setVisible(true)
		end

		if self._message == nil then
			local messages = channel:getMessages()
			local message
			local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
			local currentTime = gameServerAgent:remoteTimeMillis()

			repeat
				message = messages[1]

				table.remove(messages, 1)
			until message == nil or not message:isExpire(currentTime)

			self._message = message

			if self._message == nil then
				if isVisible then
					isRunning = true

					local fadeOutAct = cc.FadeOut:create(0.3)
					local callFuncAct = cc.CallFunc:create(function()
						isRunning = false
						isVisible = false
					end)
					local action = cc.Sequence:create(fadeOutAct, callFuncAct)

					view:runAction(action)
				end

				return
			end
		end

		isRunning = true

		local message = self._message
		local times = message:getTimes()

		local function flowFunc()
			local messageWidget = FlowMessageWidget:new()

			messageWidget:decorateView(message)

			local messageView = messageWidget:getView()

			messageView:setAnchorPoint(0, 0.5)
			messageView:addTo(layout):posite(layoutSize.width, layoutSize.height * 0.5)

			local messageViewSize = messageView:getContentSize()
			local moveDistance = math.max(messageViewSize.width, layoutSize.width)
			local moveByAction = cc.MoveBy:create(moveDistance / speed, cc.p(-moveDistance, 0))
			local delayTimeAct = cc.DelayTime:create(1)
			local fadeOutAct = cc.FadeOut:create(0.4)
			local callFuncAct = cc.CallFunc:create(function()
				isRunning = false

				if index >= times then
					self._message = nil
					index = 1
				else
					index = index + 1
				end

				if messageWidget then
					messageWidget:dispose()

					messageWidget = nil
				end
			end)
			local action = cc.Sequence:create(moveByAction, delayTimeAct, fadeOutAct, callFuncAct)

			messageView:runAction(action)
		end

		if not isVisible then
			local fadeInAct = cc.FadeIn:create(0.3)
			local callFuncAct = cc.CallFunc:create(function()
				isVisible = true

				flowFunc()
			end)
			local action = cc.Sequence:create(fadeInAct, callFuncAct)

			view:runAction(action)
		else
			flowFunc()
		end
	end

	self._flowTask = LuaScheduler:getInstance():schedule(playFlow, 1, true)
end

function ChatFlowWidget:onClickGoUrl(sender, eventType)
	if eventType == ccui.TouchEventType.ended and self._message then
		local url = self._message:getUrl()

		if url and url ~= "" then
			local context = self:getInjector():instantiate(URLContext)
			local entry, params = UrlEntryManage.resolveUrlWithUserData(url)

			if not entry then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Function_Not_Open")
				}))
			else
				entry:response(context, params)
			end
		end
	end
end
