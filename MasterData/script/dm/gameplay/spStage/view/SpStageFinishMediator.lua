-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/spStage/view/SpStageFinishMediator.lua

SpStageFinishMediator = class("SpStageFinishMediator", DmPopupViewMediator, _M)

SpStageFinishMediator:has("_spStageSystem", {
	is = "r"
}):injectWith("SpStageSystem")
SpStageFinishMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local stageAccount

function SpStageFinishMediator:initialize()
	super.initialize(self)
end

function SpStageFinishMediator:dispose()
	super.dispose(self)
end

function SpStageFinishMediator:onRegister()
	super.onRegister(self)
end

function SpStageFinishMediator:enterWithData(data)
	self._data = data

	self:getMvpRoleModel()
	self:initWidgetInfo()
	AudioEngine:getInstance():playBackgroundMusic("Mus_Battle_Common_Over")
end

function SpStageFinishMediator:initWidgetInfo()
	local pointId = self._data.pointId
	local pointConfig = ConfigReader:requireRecordById("BlockSpPoint", pointId)

	if not pointConfig then
		return true
	end

	local bg = self:getView():getChildByName("bg")
	local touchPanel = bg:getChildByName("touchPanel")

	touchPanel:setTouchEnabled(true)

	local Panel_reward = bg:getChildByFullName("Panel_reward")

	Panel_reward:setOpacity(0)

	self._rewardListView = Panel_reward:getChildByFullName("mRewardList")

	self._rewardListView:setScrollBarEnabled(false)

	local animNode = bg:getChildByFullName("animNode")
	local anim = cc.MovieClip:create("tiaozhanjieshu_fubenjiesuan")

	anim:addTo(animNode)
	anim:addEndCallback(function()
		anim:stop()
	end)

	local winNode = anim:getChildByFullName("winNode")
	local winAnim = cc.MovieClip:create("shengliz_jingjijiesuan")

	winAnim:addEndCallback(function()
		winAnim:stop()
	end)
	winAnim:addTo(winNode)

	local winPanel = winAnim:getChildByFullName("winTitle")
	local title = ccui.ImageView:create("zyfb_tzjs.png", 1)

	title:addTo(winPanel)

	local heroNode = anim:getChildByFullName("roleNode")
	local roleModel = stageAccount[1]

	roleModel = IconFactory:getSpMvpBattleEndMid(roleModel)

	local heroIcon = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe17",
		id = roleModel
	})

	heroIcon:setScale(0.8)
	heroIcon:setPosition(cc.p(-250, -200))
	heroNode:addChild(heroIcon)
	anim:addCallbackAtFrame(9, function()
		bg:getChildByFullName("sloganPanel"):fadeIn({
			time = 0.3333333333333333
		})
	end)

	local addExp = bg:getChildByFullName("addExp")

	if self._data.playerExp and self._data.playerExp ~= 0 then
		addExp:setString("+" .. self._data.playerExp)
	else
		addExp:setVisible(false)
	end

	local sloganPanel = bg:getChildByFullName("sloganPanel")
	local sloganLabel = sloganPanel:getChildByName("slogan")
	local image1 = sloganPanel:getChildByFullName("image1")
	local image2 = sloganPanel:getChildByFullName("image2")

	sloganLabel:setString(Strings:get(stageAccount[2]))

	local size = sloganLabel:getContentSize()

	if size.width > 285 then
		sloganLabel:getVirtualRenderer():setDimensions(285, 0)
	end

	image2:setPosition(cc.p(image1:getPositionX() + size.width - 40, image1:getPositionY() - size.height + 80))

	local barBg = bg:getChildByName("bar_bg")

	barBg:setVisible(false)

	local imgPointS = barBg:getChildByFullName("img_point_s")
	local imgPointA = barBg:getChildByFullName("img_point_a")
	local imgPointB = barBg:getChildByFullName("img_point_b")
	local imgPointC = barBg:getChildByFullName("img_point_c")
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local config = ConfigReader:getRecordById("LevelConfig", tostring(player:getLevel()))
	local currentExp = player:getExp()
	local percent = currentExp / config.PlayerExp * 100
	local levelLabel = bg:getChildByFullName("titlePanel.level")

	levelLabel:setString(Strings:get("CUSTOM_FIGHT_LEVEL") .. player:getLevel())

	local loadingBar = bg:getChildByFullName("titlePanel.loadingBar")

	loadingBar:setScale9Enabled(true)
	loadingBar:setCapInsets(cc.rect(1, 1, 1, 1))
	loadingBar:setPercent(percent)

	local pointName = bg:getChildByFullName("titlePanel.pointName")
	local unlockName = bg:getChildByFullName("titlePanel.unlockName")
	local battleTime = bg:getChildByFullName("timePanel.battleTime")

	if not self._data.thisProgress then
		local progress = 0

		if not barBg:getChildByName("ProgressTimer") then
			local barImage = cc.Sprite:createWithSpriteFrameName("zyfb_bar_01.png")
			local progrLoading = cc.ProgressTimer:create(barImage)

			progrLoading:setType(1)
			progrLoading:setAnchorPoint(cc.p(0.5, 0.5))
			progrLoading:setMidpoint(cc.p(0, 0))
			progrLoading:setBarChangeRate(cc.p(1, 0))
			progrLoading:addTo(barBg)

			local posX, posY = barBg:getChildByFullName("bg"):getPositionX(), barBg:getChildByFullName("bg"):getPositionY()

			progrLoading:setPosition(cc.p(posX, posY))
			progrLoading:setName("ProgressTimer")
		end

		local showProgress = progress * 100

		battleTime:setString(math.floor(showProgress) .. "%")

		local showScoreImg
		local starCondition = pointConfig.StarCondition.value

		if starCondition then
			if progress >= starCondition[1] and progress < starCondition[2] then
				showScoreImg = imgPointC
			elseif progress >= starCondition[2] and progress < starCondition[3] then
				showScoreImg = imgPointB
			elseif progress >= starCondition[3] and progress < starCondition[4] then
				showScoreImg = imgPointA
			elseif progress >= starCondition[4] then
				showProgress = 100
				showScoreImg = imgPointS
			end
		end

		barBg:getChildByName("ProgressTimer"):setPercentage(showProgress)

		local unlockNewPoint = self._data.unlockNewPoint
		local pointName_ = Strings:get(pointConfig.PointName)
		local unlockStr = ""

		if unlockNewPoint and pointConfig.NextPoint[1] then
			local nextPointName = ConfigReader:getDataByNameIdAndKey("BlockSpPoint", pointConfig.NextPoint[1], "PointName")

			if not nextPointName then
				return true
			end

			unlockStr = Strings:get("SPECIAL_STAGE_TEXT_27", {
				name = Strings:get(nextPointName)
			})
		end

		pointName:setString(pointName_)
		unlockName:setString(unlockStr)
		unlockName:setPositionX(pointName:getPositionX() + pointName:getAutoRenderWidth() + 10)
		unlockName:setOpacity(0)
		bg:stopAllActions()

		local action = cc.CSLoader:createTimeline("asset/ui/SpecialStageFinish.csb")

		bg:runAction(action)
		action:clearFrameEventCallFunc()
		action:gotoFrameAndPlay(0, 35, false)

		if not self._data.extraRewards then
			local extraRewards = {}

			if not self._data.activityExtraReward then
				local activityExtraReward = {}

				if not self._data.spExRewards then
					local spExRewards = {}

					if not self._data.spNmReward then
						local spNmReward = {}

						for i = 1, #spExRewards do
							table.insert(self._data.extraRewards, spExRewards[i])
						end

						for i = 1, #spNmReward do
							table.insert(self._data.extraRewards, spNmReward[i])
						end

						for i = 1, #activityExtraReward do
							table.insert(self._data.extraRewards, activityExtraReward[i])
						end

						local function showReward(rewards)
							local hasFirstRewards

							if self._data.rewards then
								hasFirstRewards = true

								for k, v in ipairs(self._data.rewards) do
									local layout = ccui.Layout:create()

									if k == 1 then
										local extMc = cc.MovieClip:create("titleText_fubenjiesuan")

										extMc:addEndCallback(function()
											extMc:stop()
										end)
										extMc:addTo(layout)
										extMc:setPosition(cc.p(35, 45))

										local firstRewardText = ccui.Text:create("", TTF_FONT_FZYH_M, 24)
										local mcPanel = extMc:getChildByName("lastText")

										firstRewardText:ignoreContentAdaptWithSize(false)
										firstRewardText:setContentSize(cc.size(107, 28))
										firstRewardText:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
										firstRewardText:setTextVerticalAlignment(cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
										firstRewardText:setString(Strings:get("BLOCKSP_UI15"))
										firstRewardText:addTo(mcPanel):posite(-2, 1)

										local lineGradiantVec2 = {
											{
												ratio = 0.1,
												color = cc.c4b(255, 255, 255, 255)
											},
											{
												ratio = 0.9,
												color = cc.c4b(254, 245, 162, 255)
											}
										}

										firstRewardText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
											x = 0,
											y = -1
										}))
									end

									layout:setContentSize(cc.size(100.5, 85))

									local icon = IconFactory:createRewardIcon(v, {
										isWidget = true
									})

									IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), v, {
										needDelay = true
									})
									icon:setScaleNotCascade(0.8)
									icon:addTo(layout):center(layout:getContentSize()):setName("rewardIcon")
									self._rewardListView:pushBackCustomItem(layout)
								end
							end

							for k, v in ipairs(extraRewards) do
								local layout = ccui.Layout:create()

								if k == 1 then
									local extMc = cc.MovieClip:create("titleText_fubenjiesuan")

									extMc:addEndCallback(function()
										extMc:stop()
									end)
									extMc:addTo(layout)
									extMc:setPosition(cc.p(35, 45))

									local secondRewardText = ccui.Text:create("", TTF_FONT_FZYH_M, 24)
									local mcPanel = extMc:getChildByName("lastText")

									secondRewardText:ignoreContentAdaptWithSize(false)
									secondRewardText:setContentSize(cc.size(107, 28))
									secondRewardText:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
									secondRewardText:setTextVerticalAlignment(cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
									secondRewardText:setString(Strings:get("BLOCKSP_UI21"))
									secondRewardText:addTo(mcPanel):posite(-2, 1)

									if hasFirstRewards then
										local imaLayout = ccui.Layout:create()

										imaLayout:setContentSize(cc.size(20, 84))

										local image = ccui.ImageView:create("zdjs_bg_line.png", ccui.TextureResType.plistType)

										image:addTo(imaLayout):center(imaLayout:getContentSize()):setName("line")
										self._rewardListView:pushBackCustomItem(imaLayout)
									end
								end

								layout:setContentSize(cc.size(100.5, 85))

								local icon = IconFactory:createRewardIcon(v, {
									isWidget = true
								})

								IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), v, {
									needDelay = true
								})
								icon:addTo(layout):center(layout:getContentSize()):setName("rewardIcon")
								icon:setScaleNotCascade(0.8)
								self._rewardListView:pushBackCustomItem(layout)
							end

							local items = self._rewardListView:getItems()

							for i = 1, #items do
								local _item = items[i]:getChildByName("rewardIcon")

								if _item then
									local posX, posY = _item:getPosition()

									_item:setPositionX(posX + 30)
									_item:setOpacity(0)
									_item:runAction(cc.Spawn:create(cc.FadeIn:create(0.2), cc.MoveTo:create(0.2, cc.p(posX, posY))))
								else
									_item = items[i]:getChildByName("line")

									_item:setOpacity(0)
									_item:runAction(cc.FadeIn:create(0.2))
								end
							end
						end

						local function onFrameEvent(frame)
							if frame == nil then
								return
							end

							local str = frame:getEvent()

							if str == "showProgressTimer" then
								barBg:setVisible(true)

								local progressTimer = barBg:getChildByName("ProgressTimer")
								local action1 = cc.ProgressFromTo:create(0.3, 0, showProgress)
								local action2 = cc.CallFunc:create(function()
									if showScoreImg then
										local anim = cc.MovieClip:create("tiaozhanjindu_tiaozhanjindu")

										anim:addTo(barBg)
										anim:setPosition(cc.p(showScoreImg:getPositionX() - 4, showScoreImg:getPositionY() + 1))
										showScoreImg:setLocalZOrder(2)
										unlockName:fadeIn({
											time = 0.2
										})
									end
								end)

								progressTimer:runAction(cc.Sequence:create(action1, action2))
							end

							if str == "addReward" then
								Panel_reward:fadeIn({
									time = 0.2
								})
								showReward()
							end

							if str == "AnimStop" then
								touchPanel:setTouchEnabled(false)
							end
						end

						action:setFrameEventCallFunc(onFrameEvent)
					end
				end
			end
		end
	end
end

function SpStageFinishMediator:getMvpRoleModel()
	local statistData = self._data.statist

	if statistData and statistData.players then
		local playerId = self._developSystem:getPlayer():getRid()
		local userData = statistData.players[playerId]
		local heroModel
		local mvpPoint = 0
		local model, roleId
		local summonedIdList = {}

		for __, v in pairs(userData.unitSummary) do
			if not v.summoned then
				local summonList = {}

				for __, id in pairs(summonList) do
					summonedIdList[id] = true
				end
			end
		end

		for k, v in pairs(userData.unitSummary) do
			if not summonedIdList[k] then
				if v.type == "hero" then
					local unitMvpPoint = 0
					local _unitDmg = v.damage

					if _unitDmg then
						unitMvpPoint = unitMvpPoint + _unitDmg
					end

					local _unitCure = v.cure

					if _unitCure then
						unitMvpPoint = unitMvpPoint + _unitCure
					end

					if mvpPoint < unitMvpPoint then
						mvpPoint = unitMvpPoint
						model = v.model
						roleId = v.cid
					end
				elseif v.type == "master" then
					heroModel = v.model
				end
			end
		end

		if model then
			stageAccount = {}
			stageAccount[1] = model
			stageAccount[2] = ConfigReader:getDataByNameIdAndKey("HeroBase", roleId, "MVPText") or ""

			return
		end

		if heroModel then
			stageAccount = {}
			stageAccount[1] = heroModel
			stageAccount[2] = "......"

			return
		end
	end

	local stageSpAccount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StageSp_Account", "content")
	local unlockKey = kSpStageTeamAndPointType[self._data.spType].unlockType

	stageAccount = stageSpAccount[unlockKey]
end

function SpStageFinishMediator:onTouchMaskLayer()
	BattleLoader:popBattleView(self, {
		viewName = "SpStageMainView",
		spType = self._data.spType
	})
end
