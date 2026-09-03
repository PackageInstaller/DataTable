-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarClubGameResultMediator.lua

PlaneWarClubGameResultMediator = class("PlaneWarClubGameResultMediator", DmPopupViewMediator, _M)

PlaneWarClubGameResultMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PlaneWarClubGameResultMediator:has("_gameServer", {
	is = "r"
}):injectWith("GameServerAgent")
PlaneWarClubGameResultMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")

local kBtnHandlers = {
	["main.sharebtn"] = "onClickShare"
}

function PlaneWarClubGameResultMediator:initialize()
	super.initialize(self)
end

function PlaneWarClubGameResultMediator:dispose()
	super.dispose(self)
end

function PlaneWarClubGameResultMediator:userInject()
	return
end

function PlaneWarClubGameResultMediator:onRegister()
	super.onRegister(self)
end

function PlaneWarClubGameResultMediator:bindWidgets()
	return
end

function PlaneWarClubGameResultMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
end

function PlaneWarClubGameResultMediator:enterWithData(data)
	self._data = data

	self:mapButtonHandlers(kBtnHandlers)
	self:initData()
	self:initNodes()
	self:refreshNode()
	self:createAnim(data)
	self:refreshView(data)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_MINIGAME_BUYTIMES_SCUESS, self, self.buyTimesScuess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dayRsetPush)
	self:dispatch(Event:new(EVT_CLUB_MINIGAME_STOPSCENESOUND_CONFIRM))
	snkAudio.play("Se_Alert_New_Reward")
end

function PlaneWarClubGameResultMediator:buyTimesScuess(event)
	self:refreshTimesPanel()
end

function PlaneWarClubGameResultMediator:dayRsetPush(event)
	self:refreshTimesPanel()
end

function PlaneWarClubGameResultMediator:initData()
	self._planeWarData = self._miniGameSystem:getPlaneWarSystem():getClubGamePlaneData()
	self._pointData = self._planeWarData:getPoint()

	local levelNeed = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MiniGame_Plane_Sweep_Level", "content")

	self._hasSweepBtn = not GameConfigs.closeClubPlaneSweep and levelNeed <= self._developSystem:getPlayerLevel() and self._planeWarData:getEverKillBoss()
end

function PlaneWarClubGameResultMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._beginBtn = self._mainPanel:getChildByFullName("beginbtn")
	self._beginBtn.initPos = cc.p(self._beginBtn:getPosition())
	self._sweepBtn = self._mainPanel:getChildByFullName("sweepbtn")
	self._sweepBtn.initPos = cc.p(self._sweepBtn:getPosition())
	self._shareBtn = self._mainPanel:getChildByFullName("sharebtn")
	self._shareBtn.initPos = cc.p(self._shareBtn:getPosition())

	self._shareBtn:setVisible(false)

	self._bgImg = self._mainPanel:getChildByFullName("bgimg")
	self._rewardBg = cc.Sprite:create("asset/ui/minigame/img_xys_bg1.png")

	self._rewardBg:addTo(self._mainPanel):center(self._mainPanel:getContentSize()):offset(0, 8)

	self._rewardNode = cc.Node:create()

	self._rewardNode:addTo(self._mainPanel):center(self._mainPanel:getContentSize())

	self._beginBtnWidget = self:bindWidget(self._beginBtn, TwoLevelMainButton, {
		handler = bind1(self.onClickAgain, self)
	})
	self._sweepBtnWidget = self:bindWidget(self._sweepBtn, TwoLevelViceButton, {
		handler = bind1(self.onClickSweep, self)
	})
end

function PlaneWarClubGameResultMediator:refreshNode()
	if self._timeLabel then
		self._timeLabel:removeFromParent(true)

		self._timeLabel = nil
	end

	if GameConfigs.closeMiniGameShareButton then
		self._shareBtn:setVisible(false)
	else
		self._shareBtn:setVisible(true)
	end

	self._shareBtn:setVisible(false)
	self._beginBtn:setPosition(self._beginBtn.initPos)
	self._sweepBtn:setPosition(self._sweepBtn.initPos)
	self._shareBtn:setPosition(self._shareBtn.initPos)
	self._sweepBtn:setOpacity(0)
	self._beginBtn:setOpacity(0)
	self._shareBtn:setOpacity(0)

	if self._hasSweepBtn then
		self._sweepBtn:setVisible(true)
		self._sweepBtn:offset(100, 0)
		self._beginBtn:offset(100, 0)
		self._shareBtn:offset(80, 0)
	end
end

function PlaneWarClubGameResultMediator:createAnim(data)
	if self._mainAnim then
		self._mainAnim:removeFromParent(true)

		self._mainAnim = nil
	end

	local isWin = data.isWin
	local animPath = isWin and "main_feijijieshu" or "lose_feijijieshu"

	self._mainAnim = cc.MovieClip:create(animPath)

	self._mainAnim:addEndCallback(function(fid)
		self._mainAnim:stop()
		self._mainAnim:removeCallback(fid)
	end)
	self._mainAnim:addTo(self._mainPanel, -1):center(self._mainPanel:getContentSize())

	local timeAnim = self._mainAnim:getChildByName("time")
	local btnAnim = self._mainAnim:getChildByName("btn")

	self._mainAnim:addCallbackAtFrame(30, function(fid, mc, frameIndex)
		local actionTime = 0.3

		self._beginBtn:setScale(0.8)
		self._beginBtn:runAction(cc.FadeIn:create(actionTime))
		self._beginBtn:runAction(cc.ScaleTo:create(actionTime, 1))
		self._shareBtn:runAction(cc.FadeIn:create(actionTime))
		self._shareBtn:runAction(cc.ScaleTo:create(actionTime, 1))

		if self._hasSweepBtn then
			self._sweepBtn:setScale(0.8)
			self._sweepBtn:runAction(cc.FadeIn:create(actionTime))
			self._sweepBtn:runAction(cc.ScaleTo:create(actionTime, 1))
		end
	end)
	self._mainAnim:addCallbackAtFrame(34, function(fid, mc, frameIndex)
		local actionTime = 0.3

		self._shareBtn:setScale(0.8)
		self._shareBtn:runAction(cc.FadeIn:create(actionTime))
		self._shareBtn:runAction(cc.ScaleTo:create(actionTime, 1))
	end)

	local shareBtnAnim = self._mainAnim:getChildByName("sharebtn")
	local back1Anim = self._mainAnim:getChildByName("back1")
	local backImg = cc.Sprite:create("asset/ui/miniplane/miniplaneback4.png")

	backImg:addTo(back1Anim):center(back1Anim:getContentSize())

	local paths = {
		"guang6",
		"guang3",
		"guang7"
	}

	for i = 1, #paths do
		local backAnim = self._mainAnim:getChildByName(paths[i])
		local backImg = cc.Sprite:create("asset/ui/miniplane/miniplaneback2.png")

		backImg:addTo(backAnim):center(backAnim:getContentSize())
	end

	local paths = {
		"guang1",
		"guang4",
		"back2"
	}

	for i = 1, #paths do
		local backAnim = self._mainAnim:getChildByName(paths[i])
		local backImg = cc.Sprite:create("asset/ui/miniplane/miniplaneback1.png")

		backImg:addTo(backAnim):center(backAnim:getContentSize())
	end

	local paths = {
		"guang2",
		"guang5",
		"back3"
	}

	for i = 1, #paths do
		local backAnim = self._mainAnim:getChildByName(paths[i])
		local backImg = cc.Sprite:create("asset/ui/miniplane/miniplaneback3.png")

		backImg:addTo(backAnim):center(backAnim:getContentSize())
	end
end

function PlaneWarClubGameResultMediator:refreshView(data)
	if data.rewards then
		self:refreshRewards(data.rewards)
	end

	self:refreshScorePanel(data)
	self:refreshTimesPanel()
end

function PlaneWarClubGameResultMediator:refreshTimesPanel()
	local timeAnim = self._mainAnim:getChildByName("time")
	local curTimes = self._planeWarData:getTimes()
	local allTimes = self._planeWarData:getTimesMax()
	local parent = timeAnim

	if self._timeLabel then
		parent = self._timeLabel:getParent()

		self._timeLabel:removeFromParent(true)

		self._timeLabel = nil
	end

	self._timeLabel = ccui.RichText:createWithXML(Strings:get("MiniPlaneText14", {
		num = curTimes,
		num2 = allTimes,
		color = curTimes > 0 and "#47ff65" or "#ff2828",
		fontName = DEFAULT_TTF_FONT
	}), {})

	self._timeLabel:ignoreContentAdaptWithSize(true)
	self._timeLabel:rebuildElements()
	self._timeLabel:formatText()
	self._timeLabel:setAnchorPoint(cc.p(0.5, 0.5))
	self._timeLabel:renderContent()
	self._timeLabel:addTo(parent, 1, 234):center(parent:getContentSize()):offset(-6 + ((self._hasSweepBtn or nil) and 100), 6)
end

local labelTag = 123

function PlaneWarClubGameResultMediator:refreshScorePanel(data)
	local scoreAnim = self._mainAnim:getChildByName("score")

	self._mainPanel:removeChildByTag(labelTag)

	if not data.curScore then
		if not data.hightScore then
			local hightScore = 0
			local isHightScore = data.isHightScore

			if isHightScore then
				local label = cc.Label:createWithTTF(Strings:get("MiniPlaneText12"), ALI_TTF_FONT, 26)

				label:addTo(scoreAnim, 1, labelTag):center(scoreAnim:getContentSize()):offset(-90, -20)

				local lineGradiantVec2 = {
					{
						ratio = 0.3,
						color = cc.c4b(240, 243, 249, 255)
					},
					{
						ratio = 0.7,
						color = cc.c4b(189, 207, 241, 255)
					}
				}

				label:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
					x = 0,
					y = -1
				}))
				label:setAnchorPoint(0, 0)

				local scoreLabel = cc.Label:createWithTTF("", ALI_TTF_FONT, 40)

				scoreLabel:setString(data.curScore)

				local lineGradiantVec2 = {
					{
						ratio = 0.3,
						color = cc.c4b(255, 203, 39, 255)
					},
					{
						ratio = 0.7,
						color = cc.c4b(223, 154, 17, 255)
					}
				}

				scoreLabel:setAnchorPoint(1, 0)
				scoreLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
					x = 0,
					y = -1
				}))
				scoreLabel:addTo(scoreAnim, 1, labelTag):setPosition(label:getPosition()):offset(-10, 0)

				local numLabel = cc.Label:createWithTTF(hightScore, ALI_TTF_FONT, 26)

				numLabel:addTo(scoreAnim, 1, labelTag):setPosition(label:getPosition()):offset(label:getContentSize().width)

				local lineGradiantVec2 = {
					{
						ratio = 0.3,
						color = cc.c4b(240, 243, 249, 255)
					},
					{
						ratio = 0.7,
						color = cc.c4b(189, 207, 241, 255)
					}
				}

				numLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
					x = 0,
					y = -1
				}))
				numLabel:setAnchorPoint(0, 0)

				local curText = cc.Label:createWithTTF(Strings:get("LittleGame_NewScore"), ALI_TTF_FONT, 26)

				curText:addTo(scoreAnim, 1, labelTag):setPosition(scoreLabel:getPosition()):offset(-scoreLabel:getContentSize().width)

				local lineGradiantVec2 = {
					{
						ratio = 0.3,
						color = cc.c4b(240, 243, 249, 255)
					},
					{
						ratio = 0.7,
						color = cc.c4b(189, 207, 241, 255)
					}
				}

				curText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
					x = 0,
					y = -1
				}))
				curText:setAnchorPoint(1, 0)

				local newRecord = cc.MovieClip:create("xinshangjia_xinjilu")

				newRecord:addTo(numLabel):offset(numLabel:getContentSize().width + 40, numLabel:getContentSize().height / 2 - 3)
				newRecord:play()
			else
				local label = cc.Label:createWithTTF(Strings:get("MiniPlaneText12"), ALI_TTF_FONT, 26)

				label:addTo(scoreAnim, 1, labelTag):center(scoreAnim:getContentSize()):offset(-90, -20)

				local lineGradiantVec2 = {
					{
						ratio = 0.3,
						color = cc.c4b(240, 243, 249, 255)
					},
					{
						ratio = 0.7,
						color = cc.c4b(189, 207, 241, 255)
					}
				}

				label:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
					x = 0,
					y = -1
				}))
				label:setAnchorPoint(0, 0)

				local scoreLabel = cc.Label:createWithTTF("", ALI_TTF_FONT, 40)

				scoreLabel:setString(data.curScore)

				local lineGradiantVec2 = {
					{
						ratio = 0.3,
						color = cc.c4b(255, 203, 39, 255)
					},
					{
						ratio = 0.7,
						color = cc.c4b(223, 154, 17, 255)
					}
				}

				scoreLabel:setAnchorPoint(1, 0)
				scoreLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
					x = 0,
					y = -1
				}))
				scoreLabel:addTo(scoreAnim, 1, labelTag):setPosition(label:getPosition()):offset(-10, 0)

				local numLabel = cc.Label:createWithTTF(hightScore, ALI_TTF_FONT, 26)

				numLabel:addTo(scoreAnim, 1, labelTag):setPosition(label:getPosition()):offset(label:getContentSize().width)

				local lineGradiantVec2 = {
					{
						ratio = 0.3,
						color = cc.c4b(240, 243, 249, 255)
					},
					{
						ratio = 0.7,
						color = cc.c4b(189, 207, 241, 255)
					}
				}

				numLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
					x = 0,
					y = -1
				}))
				numLabel:setAnchorPoint(0, 0)

				local curText = cc.Label:createWithTTF(Strings:get("LittleGame_NewScore"), ALI_TTF_FONT, 26)

				curText:addTo(scoreAnim, 1, labelTag):setPosition(scoreLabel:getPosition()):offset(-scoreLabel:getContentSize().width)

				local lineGradiantVec2 = {
					{
						ratio = 0.3,
						color = cc.c4b(240, 243, 249, 255)
					},
					{
						ratio = 0.7,
						color = cc.c4b(189, 207, 241, 255)
					}
				}

				curText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
					x = 0,
					y = -1
				}))
				curText:setAnchorPoint(1, 0)
			end
		end
	end
end

function PlaneWarClubGameResultMediator:refreshRewards(rewards)
	local rewardStrAnim = self._mainAnim:getChildByName("rewardstr")

	rewardStrAnim:removeAllChildren()

	local rewardItemNum = 0

	for k, v in pairs(rewards) do
		if v.num ~= 0 then
			rewardItemNum = rewardItemNum + 1
		end
	end

	local rewardPos = {
		-19,
		-39,
		-44,
		-48
	}
	local iconImg = cc.Sprite:createWithSpriteFrameName("jli_feijijieshuimage.png")

	iconImg:addTo(rewardStrAnim):center(rewardStrAnim:getContentSize()):offset(rewardPos[rewardItemNum + 1] + 24, -27)

	local width = 0
	local index = 0
	local animCache = {}

	for k, v in pairs(rewards) do
		if v.num ~= 0 then
			local anim = cc.MovieClip:create("kuang_feijijieshu")

			anim:stop()
			anim:addEndCallback(function(fid)
				anim:stop()
			end)
			anim:setVisible(false)

			animCache[#animCache + 1] = anim

			local nodeAnim = anim:getChildByName("icon")
			local data = {
				id = v.id,
				amount = v.num
			}
			local icon = IconFactory:createIcon(data, {
				isWidget = true
			})

			IconFactory:bindTouchHander(icon, IconTouchHander:new(self), data, {
				stopActionWhenMove = true,
				needDelay = true
			})
			icon:setScale(0.7)
			icon:addTo(nodeAnim):center(nodeAnim:getContentSize())
			anim:addTo(self._rewardNode):posite(rewardPos[rewardItemNum + 1] + index * 96, 0)

			width = width + icon:getContentSize().width * 0.8
			index = index + 1
		end
	end

	if rewardItemNum == 0 then
		iconImg:setVisible(false)
	else
		iconImg:setPosition(iconImg:getPositionX() + 48 * (3 - rewardItemNum), iconImg:getPositionY())
	end

	for i = 1, #animCache do
		self:getView():runAction(DelayAction:create(function()
			animCache[i]:setVisible(true)
			animCache[i]:gotoAndPlay(0)
		end, 0.3 * i))
	end
end

function PlaneWarClubGameResultMediator:refreshWinView(data)
	return
end

function PlaneWarClubGameResultMediator:refreshLoseView(data)
	return
end

function PlaneWarClubGameResultMediator:onClickAgain(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		snkAudio.play("Se_Click_Common_1")

		local factor1 = self._planeWarData:getTimes() == 0
		local factor2 = self._planeWarData:getExtraTimes() >= self._planeWarData:getMaxBuyCostTimes()

		if factor1 and factor2 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Activity_Darts_Text2")
			}))

			return
		end

		if factor1 and not factor2 then
			local popupDelegate, outSelf = {}, self

			function popupDelegate:onContinue(dialog)
				return
			end

			function popupDelegate:onLeave(dialog)
				return
			end

			local view = outSelf:getInjector():getInstance("ClubGameBuyTimesView")

			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 156,
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				costData = {
					id = self._planeWarData:getBuyCostItemId(),
					amount = self._planeWarData:getCostBuyTimes(self._planeWarData:getExtraTimes() + 1)
				},
				gameType = MiniGameType.kPlaneWar
			}, popupDelegate))

			return
		end

		self._miniGameSystem:requestClubGameStart(self._planeWarData:getId(), function()
			self:dispatch(Event:new(EVT_CLUB_MINIGAME_BUYTIMESANDBEGIN_SCUESS))
			self:close({
				rStartGame = true
			})
		end)
	end
end

function PlaneWarClubGameResultMediator:onClickSweep(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		snkAudio.play("Se_Click_Common_1")

		local factor1 = self._planeWarData:getTimes() == 0
		local factor2 = self._planeWarData:getExtraTimes() >= self._planeWarData:getMaxBuyCostTimes()

		if factor1 and factor2 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Activity_Darts_Text2")
			}))

			return
		end

		if factor1 and not factor2 then
			local popupDelegate, outSelf = {}, self

			function popupDelegate:onContinue(dialog)
				return
			end

			function popupDelegate:onLeave(dialog)
				return
			end

			local view = outSelf:getInjector():getInstance("ClubGameBuyTimesView")

			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 156,
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				costData = {
					id = self._planeWarData:getBuyCostItemId(),
					amount = self._planeWarData:getCostBuyTimes(self._planeWarData:getExtraTimes() + 1)
				},
				gameType = MiniGameType.kPlaneWar
			}, popupDelegate))

			return
		end

		self._miniGameSystem:getClubGameSweep(self._planeWarData:getId(), function(response)
			local preHightScore = self._planeWarData:getHistoryHighScore()
			local var_32_0 = {
				isWin = true
			}

			var_32_0.rewards = response.data.reward or {}
			var_32_0.isHightScore = preHightScore < response.data.score
			var_32_0.curScore = response.data.score
			var_32_0.hightScore = preHightScore

			local data = var_32_0

			self:initData()
			self:refreshNode()
			self:createAnim(data)
			self:refreshView(data)
		end)
	end
end

function PlaneWarClubGameResultMediator:onClickShare(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		snkAudio.play("Se_Click_Common_2")
		self:dispatch(ShowTipEvent({
			tip = Strings:get("IM_CTeam9_Desc")
		}))
	end
end
