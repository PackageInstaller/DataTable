-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceTopRankTipsMediator.lua

WorldPeaceTopRankTipsMediator = class("WorldPeaceTopRankTipsMediator", DmPopupViewMediator, _M)

WorldPeaceTopRankTipsMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WorldPeaceTopRankTipsMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kBtnHandlers = {}

function WorldPeaceTopRankTipsMediator:initialize()
	super.initialize(self)
end

function WorldPeaceTopRankTipsMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function WorldPeaceTopRankTipsMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function WorldPeaceTopRankTipsMediator:enterWithData(data)
	self._worldPeace = self._worldPeaceSystem:getWorldPeace()
	self._main = self:getView():getChildByFullName("main")
	self._resultShow = self._main:getChildByFullName("resultShow")
	self._touchPanel = self._main:getChildByFullName("touchpanel")

	self._touchPanel:setTouchEnabled(true)
	self._touchPanel:setLocalZOrder(9999)

	local function enterView()
		self:close()

		local popupDelegate = {}

		function popupDelegate:willClose(sender)
			return
		end

		local view = self:getInjector():getInstance("WorldPeaceMyRankTipsView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {}, popupDelegate))
	end

	self._touchPanel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._main:stopAllActions()
			enterView()
		end
	end)

	local function func()
		enterView()
	end

	self._main:runAction(DelayAction:create(func, 3))
	self:setupView()
end

function WorldPeaceTopRankTipsMediator:setupView()
	local resultData = self._worldPeace:getResultShowData() or {}
	local topClub = self._resultShow:getChildByFullName("topClub")
	local topPlayer = self._resultShow:getChildByFullName("topPlayer")
	local topData = resultData.firstGroup

	if topData then
		local clubIcon = topClub:getChildByName("ClubIcon")

		if not clubIcon then
			local var_9_0 = {}

			var_9_0.id = topData.groupHeadImg or topData.headImg

			local icon = IconFactory:createClubIcon(var_9_0, {
				isNoBG = true
			})

			icon:addTo(topClub, -1):center(topClub:getContentSize()):offset(0, -20):setName("ClubIcon")
			icon:setScale(2.3)
		end

		local clubNameText = topClub:getChildByName("Text_name")

		clubNameText:setString(topData.groupName)
		topClub:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self._worldPeaceSystem:getOtherClubDetail({
					clubId = topData.gId
				}, true, function(data)
					local view = self:getInjector():getInstance("WordPeaceAssociationMainView")

					self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
				end)
			end
		end)
	end

	local topPlayerData = resultData.firstPlayer

	if topPlayerData then
		local playerIcon = topPlayer:getChildByName("PlayerIcon")

		if not playerIcon and topPlayerData.headImage then
			local headicon, oldIcon = IconFactory:createPlayerIcon({
				clipType = 4,
				id = topPlayerData.headImage,
				headFrameId = topPlayerData.headFrame
			})

			headicon:setScale(1.55)
			oldIcon:setScale(0.45)
			headicon:addTo(topPlayer):center(topPlayer:getContentSize()):offset(0, 0):setName("PlayerIcon")
		end

		local nickNameText = topPlayer:getChildByName("Text_name")

		nickNameText:setString(topPlayerData.nickName)
		topPlayer:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				local friendSystem = self:getInjector():getInstance(FriendSystem)

				friendSystem:showFriendInfoNewView(topPlayerData.rid)
			end
		end)
	end
end

function WorldPeaceTopRankTipsMediator:onClickReward()
	self._worldPeaceSystem:tryEnterRankView(nil, true)
end
