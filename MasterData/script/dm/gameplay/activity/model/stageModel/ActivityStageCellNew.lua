-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/stageModel/ActivityStageCellNew.lua

ActivityStageCellNew = class("ActivityStageCellNew", DisposableObject, _M)

local lockIconPosX = {
	243,
	243
}

local function checkRewardContainDiamond(rewards)
	if not rewards then
		return false
	end

	for i = 1, #rewards do
		local reward = rewards[i]

		if reward.code == "IR_Diamond" then
			return true, reward.amount
		end
	end

	return false
end

local color1 = cc.c3b(224, 210, 208)
local color2 = cc.c3b(255, 255, 255)
local outlineColor = cc.c4b(0, 0, 0, 178.5)

function ActivityStageCellNew:initialize(view, info)
	super.initialize(self)

	self._view = view
	self._model = info.model
	self._parentMediator = info.parentMediator

	self:setupView()
end

function ActivityStageCellNew:getView()
	return self._view
end

function ActivityStageCellNew:setupView()
	self:initWigetInfo()
end

function ActivityStageCellNew:initWigetInfo()
	self._img = self:getView():getChildByName("imgPanel")
	self._name = self:getView():getChildByName("name")
	self._content = self:getView():getChildByName("content")
	self._storyPointPanel = self:getView():getChildByName("storyPoint")
	self._lock = self:getView():getChildByName("Lock")
	self._bar = self:getView():getChildByName("bar")
	self._hideStory = self:getView():getChildByName("hideStory")
	self._boss = self:getView():getChildByName("boss")
	self._bossName = self._boss:getChildByFullName("dark.bossName")
	self._showDiamondView = self:getView():getChildByName("showDiamondNode")
	self._passImg = self:getView():getChildByName("Image_pass")
	self._perfectImg = self:getView():getChildByName("Image_perfect")
	self.isUnLock = false
	self._isPassed = false

	self._name:enableOutline(outlineColor, 1)
	self._content:enableOutline(outlineColor, 1)
	self._showDiamondView:getChildByFullName("diamond.num"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._showDiamondView:getChildByName("image"):ignoreContentAdaptWithSize(true)
end

function ActivityStageCellNew:refreshData(selectPointId, pointId)
	local pointInfo, pointType = self._model:getPointById(pointId)

	self._pointInfo = pointInfo
	self._pointType = pointType
	self.isUnLock = pointInfo:isUnlock()
	self._isPassed = pointInfo:isPass()
	self._type = pointInfo:getConfig().Type

	local hardTopImage = self:getView():getChildByTag(1111)

	if hardTopImage then
		hardTopImage:removeFromParent(true)
	end

	local panelBgC = self:getView():getChildByName("decBgC")
	local image = panelBgC:getChildByFullName("clipPanel.Image_1")

	if self.isUnLock == true then
		self._lock:setVisible(false)
		self._name:setTextColor(color1)
		self._content:setTextColor(color1)

		if self._type == StageType.kHard then
			panelBgC:loadTexture("img_actblock_bh_1.png", ccui.TextureResType.plistType)
			image:loadTexture("img_actblock_bh_3.png", ccui.TextureResType.plistType)

			if selectPointId ~= pointId and not self._isPassed then
				local img = ccui.ImageView:create("img_actblock_bh_4.png", 1)

				img:addTo(self:getView()):posite(36, 25)
				img:setTag(1111)
			end
		else
			panelBgC:loadTexture("zx_passed_bg.png", ccui.TextureResType.plistType)
			image:loadTexture("zx_passed.png", ccui.TextureResType.plistType)
		end
	else
		self._lock:setVisible(true)
		self._name:setTextColor(color2)
		self._content:setTextColor(color2)
		panelBgC:loadTexture("zx_locked_bg.png", ccui.TextureResType.plistType)
		image:loadTexture("zx_locked.png", ccui.TextureResType.plistType)
	end

	local panelBgUC = self:getView():getChildByName("decBgUC")

	if self._type == StageType.kHard then
		panelBgUC:setBackGroundImage("img_actblock_bh_2.png", ccui.TextureResType.plistType)
	else
		panelBgUC:setBackGroundImage("zx_choosed_bg.png", ccui.TextureResType.plistType)
	end

	self._boss:setVisible(self._pointInfo:isBoss())

	if self._bar then
		self._bar:setVisible(self._pointInfo:isBoss() and self.isUnLock)
	end

	if self._bar and self._pointInfo:isBoss() then
		local hpRate = self._pointInfo:getHpRate()

		self._bar:getChildByName("loadingBar"):setPercent(hpRate * 100)
	end

	if self._hideStory then
		self._hideStory:setVisible(false)
	end

	self._showDiamondView:setVisible(false)

	if self._pointType == kStageTypeMap.point then
		self._isPerfect = pointInfo:isPerfect()

		self:setupCommonPoint()
	elseif self._pointType == kStageTypeMap.StoryPoint then
		self:setupStoryPoint()
	end
end

function ActivityStageCellNew:setHiddenStory(isHidden)
	if not self._hideStory then
		return
	end

	if self._pointType == kStageTypeMap.point then
		self._hideStory:setVisible(not isHidden)
	elseif self._pointType == kStageTypeMap.StoryPoint then
		self._hideStory:setVisible(false)
	end
end

function ActivityStageCellNew:setCellState(selectPointId, id)
	local panelBgC = self:getView():getChildByName("decBgC")
	local panelBgUC = self:getView():getChildByName("decBgUC")
	local tag9521 = panelBgUC:getChildByTag(9521)

	if tag9521 then
		tag9521:removeFromParent(true)
	end

	local tag9522 = panelBgUC:getChildByTag(9522)

	if tag9522 then
		tag9522:removeFromParent(true)
	end

	self._img:setVisible(selectPointId == id)

	local redPoint = self:getView():getChildByName("redPoint")

	redPoint:setVisible(false)

	if self._pointType ~= kStageTypeMap.StoryPoint then
		local rid = self._parentMediator._developSystem:getPlayer():getRid()
		local value = cc.UserDefault:getInstance():getBoolForKey("activityStageRed" .. self._pointInfo:getId() .. rid, false)

		redPoint:setVisible(self._pointInfo:isUnlock() and self._pointInfo:isPass() and not self._pointInfo:isPerfect() and not value)
	end

	self._storyPointPanel:getChildByName("dark"):setVisible(selectPointId ~= id)
	self._storyPointPanel:getChildByName("light"):setVisible(selectPointId == id)

	if selectPointId == id then
		local barImg = self._img:getChildByName("Image_111")
		local bar = self._img:getChildByName("bar")
		local normal = self._img:getChildByName("normal")
		local elite = self._img:getChildByName("elite")
		local hard = self._img:getChildByName("hard")
		local rewardPanel = self._img:getChildByName("reward")

		barImg:setVisible(false)
		bar:setVisible(false)
		normal:setVisible(false)
		elite:setVisible(false)
		hard:setVisible(false)
		rewardPanel:setVisible(false)

		local rewardNodes

		if self._pointType == kStageTypeMap.StoryPoint then
			rewardPanel:setVisible(true)

			if self._rewards and #self._rewards > 0 then
				local label = ccui.Text:create(self._getRewardStr, TTF_FONT_FZYH_R, 18)

				label:setTextColor(cc.c3b(255, 255, 255))
				label:enableOutline(cc.c4b(0, 0, 0, 255), 1)
				label:setPosition(127, 8)
				label:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
				label:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
				label:getVirtualRenderer():setDimensions(100, 38)
				label:addTo(rewardPanel)
			end

			rewardNodes = {}

			if self._rewards then
				for i = 1, 4 do
					local reward = self._rewards[i]

					if reward then
						local icon = IconFactory:createRewardIcon(reward, {
							isWidget = true,
							showAmount = not self._isPassed
						})

						icon:setAnchorPoint(cc.p(0.5, 0.5))
						icon:setScale(0.8)
						icon:setPosition(cc.p(149 + i * 51.7, -3))
						icon:setOpacity(0)
						icon:addTo(rewardPanel, 2)

						rewardNodes[#rewardNodes + 1] = icon

						if icon.getAmountLabel then
							local label = icon:getAmountLabel()

							if label then
								label:setScale(2)
								label:enableOutline(cc.c4b(0, 0, 0, 255), 1)
							end
						end
					end
				end
			end
		else
			barImg:setVisible(true)
			bar:setVisible(true)
			normal:setVisible(false)
			elite:setVisible(false)
			hard:setVisible(false)

			local count = #self._subPointList
			local loadingWidth = bar:getContentSize().width

			for i = 1, count do
				local subPoint = self._subPointList[i]
				local cell

				if subPoint:getType() == StageType.kNormal then
					cell = normal
				elseif subPoint:getType() == StageType.kElite then
					cell = elite
				elseif subPoint:getType() == StageType.kHard then
					cell = hard
				end

				cell:setVisible(true)
				cell:posite(77 + loadingWidth / count * i, -19)

				local doneImg = cell:getChildByName("Image_done")

				if subPoint:getType() == StageType.kNormal then
					doneImg:setVisible(self._isPassed)
				elseif subPoint:getType() == StageType.kElite then
					doneImg:setVisible(self._isPerfect)
				end
			end

			local percent = 0

			if count == 1 then
				percent = self._isPassed and 100 or 1
			elseif self._isPerfect then
				percent = 100
			elseif self._isPassed then
				percent = 50
			end

			bar:setPercent(percent)
		end

		local mc = cc.MovieClip:create("tiaozhankuanghebin_zhuxianguanka_UIjiaohudongxiao")

		mc:addCallbackAtFrame(32, function()
			mc:getChildByName("word1"):setOpacity(0)
			mc:getChildByName("word2"):setOpacity(0)
		end)
		mc:addCallbackAtFrame(42, function()
			mc:stop()
		end)
		mc:setScale(0.6)
		mc:setPlaySpeed(1.6)
		mc:addTo(panelBgUC, 2):setTag(9521)
		mc:setPosition(cc.p(-378, 56))
		mc:gotoAndPlay(10)
		performWithDelay(self:getView(), function()
			if self._pointType == kStageTypeMap.point then
				local iconMC = self._boss:isVisible() and cc.MovieClip:create("XZBSsaoguang_zhuxianguanka_UIjiaohudongxiao") or cc.MovieClip:create("XZBS_zhuxianguanka_UIjiaohudongxiao")

				iconMC:addTo(panelBgUC, 1):setTag(9522)
				iconMC:setPosition(cc.p(-113, 36))
			end
		end, 0.3)
		self._img:setOpacity(0)
		panelBgUC:setOpacity(0)
		panelBgC:setOpacity(255)

		local action1 = cc.Spawn:create(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1.5), cc.ScaleTo:create(0.08, 1, 1.2)), cc.FadeOut:create(0.28))

		panelBgC:runAction(action1)

		local action2 = cc.Sequence:create(cc.DelayTime:create(0.25), cc.FadeIn:create(0.25))

		panelBgUC:runAction(action2:clone())
		self._img:runAction(action2:clone())

		if rewardNodes then
			for k, v in ipairs(rewardNodes) do
				local action3 = cc.Sequence:create(cc.DelayTime:create(0.1 * k + 0.15), cc.Spawn:create(cc.FadeIn:create(0.25), cc.ScaleTo:create(0.25, 0.32)), cc.ScaleTo:create(0.08, 0.4))

				v:runAction(action3)
			end
		end

		self._name:setTextColor(color2)
		self._bossName:setTextColor(color2)
		self._content:runAction(cc.Sequence:create(cc.FadeOut:create(0.28), cc.CallFunc:create(function()
			self._content:setPositionX(105)
			self._content:setTextColor(color2)
		end), cc.FadeIn:create(0.28)))

		if self._pointType == kStageTypeMap.StoryPoint then
			self._storyPointPanel:runAction(cc.Sequence:create(cc.FadeOut:create(0.28), cc.FadeIn:create(0.28)))
		end

		self._name:setVisible(false)
		self._name:runAction(cc.FadeOut:create(0.28))
		performWithDelay(self:getView(), function()
			if self._boss:isVisible() then
				self._name:setFontSize(70)
				self._name:setPosition(cc.p(33, 35))
			else
				self._name:setFontSize(86)
				self._name:setPosition(cc.p(35, 22))
			end

			self._name:setFontName(CUSTOM_TTF_FONT_2)
			self._name:setScale(1.5)
			self._name:setVisible(true)
			self._name:runAction(cc.Spawn:create(cc.FadeIn:create(0.25), cc.ScaleTo:create(0.2, 1)))
		end, 0.5)

		if self._boss:isVisible() then
			local light = self._boss:getChildByName("light")

			light:setOpacity(0)
			light:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.FadeIn:create(0.3)))
			self._boss:getChildByName("dark"):setOpacity(0)
		end

		performWithDelay(self:getView(), function()
			if self._bar and self._bar:isVisible() then
				self._bar:getChildByName("title"):setTextColor(color2)
				self._bar:setScale(1)
			end
		end, 0.5)

		if self._showDiamondView:isVisible() then
			local image = self._showDiamondView:getChildByName("image")

			image:loadTexture("zx_bg_qp_l.png", 1)

			local diamond = self._showDiamondView:getChildByName("diamond")

			diamond:setScale(0.6)
			diamond:setPosition(cc.p(-45, 51))
			diamond:getChildByName("num"):setScale(1.67)
		end
	else
		panelBgC:setOpacity(255)
		panelBgUC:setOpacity(0)
		self._name:setFontName(TTF_FONT_FZYH_M)
		self._name:setFontSize(22)

		if self.isUnLock then
			self._name:setTextColor(color1)
			self._bossName:setTextColor(color1)
			self._content:setTextColor(color1)
		else
			self._name:setTextColor(color2)
			self._bossName:setTextColor(color2)
			self._content:setTextColor(color2)
		end

		if self._boss:isVisible() then
			self._boss:getChildByName("dark"):setOpacity(255)
			self._boss:getChildByName("light"):setOpacity(0)
			self._name:setVisible(false)
		end

		self._content:setPositionX(89)

		if self._showDiamondView:isVisible() then
			local image = self._showDiamondView:getChildByName("image")

			image:loadTexture("zx_bg_qp_s.png", 1)

			local diamond = self._showDiamondView:getChildByName("diamond")

			diamond:setScale(0.4)
			diamond:setPosition(cc.p(-32, 42))
			diamond:getChildByName("num"):setScale(2)
		end

		if self._bar and self._bar:isVisible() then
			self._bar:getChildByName("title"):setTextColor(color1)
			self._bar:setScale(0.8)
		end
	end
end

function ActivityStageCellNew:setupCommonPoint()
	self._lock:setPositionX(lockIconPosX[1])

	local panelBgC = self:getView():getChildByName("decBgC")

	panelBgC:getChildByName("clipPanel"):setVisible(true)
	self._name:setString(self._pointInfo:getIndex())
	self._bossName:setString(self._pointInfo:getIndex())
	self._name:setVisible(true)
	self._content:setString(self._pointInfo:getName())
	self._storyPointPanel:setVisible(false)
	self._passImg:setVisible(false)
	self._perfectImg:setVisible(false)

	if self._isPerfect then
		self._passImg:setVisible(false)
		self._perfectImg:setVisible(true)
	elseif self._isPassed then
		self._passImg:setVisible(true)
	end

	self._subPointList = self._pointInfo:getPointList()
end

function ActivityStageCellNew:setupStoryPoint()
	self._lock:setPositionX(lockIconPosX[2])

	local panelBgC = self:getView():getChildByName("decBgC")

	panelBgC:getChildByName("clipPanel"):setVisible(false)
	self._name:setVisible(false)
	self._storyPointPanel:setVisible(true)
	self._name:setString("")
	self._content:setString(self._pointInfo:getName())

	if not self._isPassed then
		local rewardId = self._pointInfo:getFirstReward()

		self._rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")
		self._getRewardStr = Strings:get("STAGE_FIRST_DROP_TITLE")

		local isContainDiamond, amount = checkRewardContainDiamond(self._rewards)

		if isContainDiamond then
			self._showDiamondView:setVisible(true)
			self._showDiamondView:getChildByFullName("diamond.num"):setString(amount)
		end
	else
		self._isPassed = nil
	end

	self._passImg:setVisible(false)
	self._perfectImg:setVisible(false)
end
