-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarActivityResultMediator.lua

PlaneWarActivityResultMediator = class("PlaneWarActivityResultMediator", DmPopupViewMediator, _M)

PlaneWarActivityResultMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PlaneWarActivityResultMediator:has("_gameServer", {
	is = "r"
}):injectWith("GameServerAgent")
PlaneWarActivityResultMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")

local kBtnHandlers = {
	["main.sharebtn"] = "onClickShare"
}

function PlaneWarActivityResultMediator:initialize()
	super.initialize(self)
end

function PlaneWarActivityResultMediator:dispose()
	super.dispose(self)
end

function PlaneWarActivityResultMediator:userInject()
	return
end

function PlaneWarActivityResultMediator:onRegister()
	super.onRegister(self)
end

function PlaneWarActivityResultMediator:bindWidgets()
	return
end

function PlaneWarActivityResultMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
end

function PlaneWarActivityResultMediator:enterWithData(data)
	self._data = data

	self:mapButtonHandlers(kBtnHandlers)
	self:initData()
	self:initNodes()
	self:createAnim(data)
	self:refreshView(data)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_MINIGAME_BUYTIMES_SCUESS, self, self.buyTimesScuess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_CLOSE, self, self.activityClose)
end

function PlaneWarActivityResultMediator:buyTimesScuess(event)
	self:refreshTimesPanel()
end

function PlaneWarActivityResultMediator:activityClose(event)
	local data = event:getData()

	if data.activityId == self._data.activityId then
		self:close()
	end
end

function PlaneWarActivityResultMediator:initData()
	self._planeWarActivity = self._miniGameSystem:getPlaneWarSystem():getPlaneWarActivity()
end

function PlaneWarActivityResultMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._beginBtn = self._mainPanel:getChildByFullName("beginbtn")
	self._shareBtn = self._mainPanel:getChildByFullName("sharebtn")

	if GameConfigs.closeMiniGameShareButton then
		self._shareBtn:setVisible(false)
	else
		self._shareBtn:setVisible(true)
	end

	self._beginBtn:setOpacity(0)
	self._shareBtn:setOpacity(0)
	self._beginBtn:offset(0, 0)

	self._bgImg = self._mainPanel:getChildByFullName("bgimg")
	self._rewardNode = cc.Node:create()

	self._rewardNode:addTo(self._mainPanel):center(self._mainPanel:getContentSize())

	self._beginBtnWidget = self:bindWidget(self._beginBtn, TwoLevelMainButton, {
		handler = bind1(self.onClickAgain, self)
	})
end

function PlaneWarActivityResultMediator:createAnim(data)
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

function PlaneWarActivityResultMediator:refreshView(data)
	if data.rewards then
		self:refreshRewards(data.rewards)
	end

	self:refreshScorePanel(data)
	self:refreshTimesPanel()
end

function PlaneWarActivityResultMediator:refreshTimesPanel()
	local timeAnim = self._mainAnim:getChildByName("time")
	local curTimes = self._planeWarActivity:getTimes()
	local allTimes = self._planeWarActivity:getAllTimes()
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
	self._timeLabel:addTo(parent, 1, 234):center(parent:getContentSize()):offset(-6, 6)
end

local labelTag = 123

function PlaneWarActivityResultMediator:refreshScorePanel(data)
	local scoreAnim = self._mainAnim:getChildByName("score")

	self._mainPanel:removeChildByTag(labelTag)

	if not data.curScore then
		if not data.hightScore then
			local hightScore = 0
			local isHightScore = data.isHightScore

			if isHightScore then
				local numNode = cc.Node:create()
				local count = utf8.len(hightScore)
				local numNodeCache = {}

				for i = 1, count do
					local num = string.sub(tostring(hightScore), i, i)
					local numAnim = cc.MovieClip:create("count1" .. "_feijijieshu")

					numNodeCache[#numNodeCache + 1] = {
						anim = numAnim,
						num = num
					}

					numAnim:addEndCallback(function(fid)
						numAnim:stop()
					end)
					numAnim:setVisible(false)
					numAnim:stop()

					local parent = numAnim:getChildByName("num")
					local numLabel = cc.Label:createWithTTF(num, ALI_TTF_FONT, 40)
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

					numLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
						x = 0,
						y = -1
					}))
					numLabel:addTo(parent):center(parent:getContentSize())
					numAnim:addTo(numNode):posite(-40 + (i - 1) * 30, 50)
				end

				self:getView():runAction(DelayAction:create(function()
					if #numNodeCache == 1 then
						-- block empty
					else
						for i = #numNodeCache, 1, -1 do
							self:getView():runAction(DelayAction:create(function()
								local anim = numNodeCache[i].anim
								local num = numNodeCache[i].num

								anim:setPlaySpeed(0.3 + num * 0.02 + i * 0.1)
								anim:setVisible(true)
								anim:gotoAndPlay(0)
								anim:addCallbackAtFrame(num + 1, function(fid, mc, frameIndex)
									anim:removeCallback(fid)
									anim:stop()
								end)
							end, 0.1 * (#numNodeCache - i)))
						end
					end
				end, 0.3))
				numNode:addTo(self._mainPanel):posite(190 - count * 10, 304)

				local label = cc.Label:createWithTTF(Strings:get("MiniPlaneText18"), ALI_TTF_FONT, 26)

				label:addTo(scoreAnim, 1, labelTag):center(scoreAnim:getContentSize()):offset(-90, -20)
				label:setAnchorPoint(0, 0)

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
			elseif hightScore >= 0 then
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
						color = cc.c4b(240, 243, 249, 255)
					},
					{
						ratio = 0.7,
						color = cc.c4b(189, 207, 241, 255)
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
						color = cc.c4b(255, 203, 39, 255)
					},
					{
						ratio = 0.7,
						color = cc.c4b(223, 154, 17, 255)
					}
				}

				numLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
					x = 0,
					y = -1
				}))
				numLabel:setAnchorPoint(0, 0)
			end
		end
	end
end

function PlaneWarActivityResultMediator:refreshRewards(rewards)
	local rewardStrAnim = self._mainAnim:getChildByName("rewardstr")

	if table.nums(rewards) > 0 then
		local iconImg = cc.Sprite:createWithSpriteFrameName("jli_feijijieshuimage.png")

		iconImg:addTo(rewardStrAnim):center(rewardStrAnim:getContentSize())
	end

	local width = 0
	local index = 0
	local animCache = {}

	for id, amount in pairs(rewards) do
		local anim = cc.MovieClip:create("kuang_feijijieshu")

		anim:stop()
		anim:addEndCallback(function(fid)
			anim:stop()
		end)
		anim:setVisible(false)

		animCache[#animCache + 1] = anim

		local nodeAnim = anim:getChildByName("icon")
		local data = {
			id = id,
			amount = amount
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
		anim:addTo(self._rewardNode):posite(4 + (index - 1) * 96, 0)

		width = width + icon:getContentSize().width * 0.8
		index = index + 1
	end

	for i = 1, #animCache do
		self:getView():runAction(DelayAction:create(function()
			animCache[i]:setVisible(true)
			animCache[i]:gotoAndPlay(0)
		end, 0.3 * i))
	end
end

function PlaneWarActivityResultMediator:refreshWinView(data)
	return
end

function PlaneWarActivityResultMediator:refreshLoseView(data)
	return
end

function PlaneWarActivityResultMediator:onClickAgain(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		snkAudio.play("Se_Click_Common_1")

		local factor1 = self._planeWarActivity:getTimes() == 0
		local factor2 = self._planeWarActivity:getBuyTimes() == 0

		if factor1 and factor2 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Activity_Darts_Text2")
			}))

			return
		end

		if factor1 and not factor2 then
			local view = self:getInjector():getInstance("ClubGameBuyTimesView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				costData = {
					id = self._planeWarActivity:getBuyCostItemId(),
					amount = self._planeWarActivity:getCostBuyTimes(self._planeWarActivity:getExtraTimes() + 1)
				},
				gameType = MiniGameType.kPlaneWar
			}, nil))

			return
		end

		self._miniGameSystem:requestActivityGameBegin(self._planeWarActivity:getId(), function()
			self:dispatch(Event:new(EVT_ACTIVITY_MINIGAME_BUYTIMESANDBEGIN_SCUESS))
			self:close({
				rStartGame = true
			})
		end)
	end
end

function PlaneWarActivityResultMediator:onClickShare(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		snkAudio.play("Se_Click_Common_2")
		self:dispatch(ShowTipEvent({
			tip = Strings:get("IM_CTeam9_Desc")
		}))
	end
end
