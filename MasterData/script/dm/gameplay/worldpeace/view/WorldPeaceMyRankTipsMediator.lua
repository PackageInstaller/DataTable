-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceMyRankTipsMediator.lua

WorldPeaceMyRankTipsMediator = class("WorldPeaceMyRankTipsMediator", DmPopupViewMediator, _M)

WorldPeaceMyRankTipsMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WorldPeaceMyRankTipsMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
WorldPeaceMyRankTipsMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {}

function WorldPeaceMyRankTipsMediator:initialize()
	super.initialize(self)
end

function WorldPeaceMyRankTipsMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function WorldPeaceMyRankTipsMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByFullName("main")

	self._main:setTouchEnabled(false)

	local rewardList = self._main:getChildByFullName("resultShow.Image_1")

	rewardList:offset(-10, -3)
	self._main:getChildByFullName("Image_1"):setTouchEnabled(false)

	local rewardList = self._main:getChildByFullName("resultShow.reward")

	rewardList:setScrollBarEnabled(false)

	self._resultShow = self._main:getChildByFullName("resultShow")
	self._touchPanel = self._main:getChildByFullName("touchpanel")

	self._touchPanel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:close()
		end
	end)
	self._touchPanel:setTouchEnabled(true)
end

function WorldPeaceMyRankTipsMediator:enterWithData(data)
	self._worldPeace = self._worldPeaceSystem:getWorldPeace()
	self._clubInfoOj = self._clubSystem:getClubInfoOj()

	local developSystem = self:getInjector():getInstance(DevelopSystem)

	self._player = developSystem:getPlayer()

	self:setupView()
end

function WorldPeaceMyRankTipsMediator:setupView()
	local resultData = self._worldPeace:getResultShowData() or {}
	local topClub = self._resultShow:getChildByFullName("topClub")
	local topPlayer = self._resultShow:getChildByFullName("topPlayer")

	do
		local clubIcon = topClub:getChildByName("ClubIcon")

		if not clubIcon then
			local icon = IconFactory:createClubIcon({
				id = self._clubInfoOj:getIcon()
			}, {
				isNoBG = true
			})

			icon:addTo(topClub, -1):center(topClub:getContentSize()):offset(-10, -5):setName("ClubIcon")
			icon:setScale(1.83)
		end

		local clubName = self._clubSystem:getName()
		local clubNameText = topClub:getChildByName("Text_name")

		clubNameText:setString(clubName)

		local rankNameText = topClub:getChildByName("Text_rank")

		if resultData.clubRank == -1 then
			local var_6_0 = Strings:get("StagePractice_Text19")

			if not var_6_0 then
				var_6_0 = Strings:get("ClubMapBoss_ranking", {
					num = resultData.clubRank
				})

				local rankTitle = var_6_0

				rankNameText:setString(rankTitle)
				topClub:setTouchEnabled(false)
				topClub:addTouchEventListener(function(sender, eventType)
					if eventType == ccui.TouchEventType.ended then
						self._worldPeaceSystem:getOtherClubDetail({
							clubId = self._clubInfoOj:getClubId()
						}, true, function(data)
							local view = self:getInjector():getInstance("WordPeaceAssociationMainView")

							self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
						end)
					end
				end)
			end
		end
	end

	do
		local playerIcon = topPlayer:getChildByName("PlayerIcon")

		if not playerIcon and self._player:getHeadId() then
			local headicon, oldIcon = IconFactory:createPlayerIcon({
				clipType = 4,
				id = self._player:getHeadId(),
				size = cc.size(93, 94),
				headFrameId = self._player:getCurHeadFrame()
			})

			headicon:setScale(1.15)
			oldIcon:setScale(0.45)
			headicon:addTo(topPlayer):center(topPlayer:getContentSize()):offset(-5, 2):setName("PlayerIcon")
		end

		local nickNameText = topPlayer:getChildByName("Text_name")

		nickNameText:setString(self._player:getNickName())

		local scroceNameText = topPlayer:getChildByName("Text_scroce")

		if resultData.myScoreRank == -1 then
			local var_6_1 = Strings:get("StagePractice_Text19")

			if not var_6_1 then
				local var_6_2 = {}

				var_6_2.num2 = resultData.myScore or 1
				var_6_2.num1 = resultData.myScoreRank or 1
				var_6_1 = Strings:get("ClubMapBoss_pointranking", var_6_2)

				local rankTitle = var_6_1

				scroceNameText:setString(rankTitle)

				local killNameText = topPlayer:getChildByName("Text_kill")

				if resultData.myKillRank == -1 then
					local var_6_3 = Strings:get("StagePractice_Text19")

					if not var_6_3 then
						local var_6_4 = {}

						var_6_4.num2 = resultData.myKill or 1
						var_6_4.num1 = resultData.myKillRank or 1
						var_6_3 = Strings:get("ClubMapBoss_killranking", var_6_4)

						local rankTitle = var_6_3

						killNameText:setString(rankTitle)
						topPlayer:setTouchEnabled(false)
						topPlayer:addTouchEventListener(function(sender, eventType)
							if eventType == ccui.TouchEventType.ended then
								local friendSystem = self:getInjector():getInstance(FriendSystem)

								friendSystem:showFriendInfoNewView(self._player:getRid())
							end
						end)
					end
				end
			end
		end
	end

	local myClubRank = resultData.clubRank

	dump(myClubRank, "myClubRank____myClubRank")

	local data = self._worldPeace:getClubChatReward() or {}

	dump(data, "data_____data")

	local groupId = self._worldPeaceSystem:getMainPlayer():getGroupId()

	dump(groupId, "groupId____groupId")

	local myData = data[groupId]

	if myClubRank and myData then
		local rewards = myData.totalRewards

		if rewards then
			self:createReward(rewards, rewardNode, myClubRank)
		end
	end
end

function WorldPeaceMyRankTipsMediator:createReward(rewards, rewardList, myClubRank)
	local rewardList = self._main:getChildByFullName("resultShow.reward")
	local tipnode = self._main:getChildByFullName("resultShow.tipnode")

	tipnode:setVisible(false)

	local factorText = tipnode:getChildByFullName("Text_factor")
	local rankFactor = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Bride_RankFactor", "content")
	local delay = 0.3

	if rankFactor[tostring(myClubRank)] then
		tipnode:setVisible(true)
		factorText:setString("+" .. rankFactor[tostring(myClubRank)] * 100 .. "%")
		tipnode:setColorTransform(ColorTransform(1, 1, 1, 0))
		tipnode:setScale(3)
		tipnode:runAction(CascadeFadeTo:create(delay, 1))
		tipnode:runAction(cc.ScaleTo:create(delay, 1))
	end

	local delay = 0.2

	for index = 1, #rewards do
		local reward = rewards[index]

		if reward then
			local layout = ccui.Layout:create()

			layout:setContentSize(cc.size(85, 74))
			rewardList:pushBackCustomItem(layout)
			dump(reward, "reward___reward")

			local icon = IconFactory:createRewardIcon(reward, {
				isWidget = true
			})

			icon:addTo(layout):posite(35, 35)
			icon:setScaleNotCascade(0.5)
			icon:setScale(0.56)
			icon:setBrightness(-20)
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
				needDelay = true
			})

			local endAction = cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
				if icon.getAmountLabel then
					local label = icon:getAmountLabel()
					local initScale = label:getScale()
					local action1 = cc.EaseBackOut:create(cc.ScaleTo:create(delay, initScale + 0.6))
					local action2 = cc.CallFunc:create(function()
						if label then
							label:setColor(cc.c3b(60, 255, 0))
						end
					end)
					local action3 = cc.EaseBackOut:create(cc.ScaleTo:create(delay, initScale))
					local action4 = cc.CallFunc:create(function()
						local label = icon:getAmountLabel()

						if label then
							label:setColor(cc.c3b(255, 255, 255))
						end
					end)
					local sequence = cc.Sequence:create(action1, action2, action3, action4)

					icon:runAction(cc.Sequence:create(BrightnessTo:create(delay + 0.1, 100), BrightnessTo:create(delay, 0)))
					label:runAction(sequence)
					icon:setAmount(reward.amount * (rankFactor[tostring(myClubRank)] or 1))
				end
			end))

			icon:runAction(endAction)
		end
	end
end

function WorldPeaceMyRankTipsMediator:onClickReward()
	self._worldPeaceSystem:tryEnterRankView(nil, true)
end
