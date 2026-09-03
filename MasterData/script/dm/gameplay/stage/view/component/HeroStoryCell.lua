-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/component/HeroStoryCell.lua

HeroStoryCell = class("HeroStoryCell", DisposableObject, _M)

local color1 = cc.c3b(224, 210, 208)
local color2 = cc.c3b(255, 255, 255)

function HeroStoryCell:initialize(view, info)
	super.initialize(self)

	self._view = view
	self._mediator = info.mediator

	self:initWigetInfo()
end

function HeroStoryCell:dispose()
	super.dispose(self)
end

function HeroStoryCell:getView()
	return self._view
end

function HeroStoryCell:initWigetInfo()
	self._img = self:getView():getChildByName("imgPanel")
	self._star = self:getView():getChildByName("star3")
	self._name = self:getView():getChildByName("name")

	self._name:enableOutline(cc.c4b(0, 0, 0, 178.5), 1)

	self._content = self:getView():getChildByName("content")

	self._content:enableOutline(cc.c4b(0, 0, 0, 178.5), 1)

	self._lock = self:getView():getChildByName("Lock")
	self._boss = self:getView():getChildByName("boss")
	self._bossName = self._boss:getChildByFullName("dark.bossName")
	self._isUnLock = false
	self._isPassed = false
	self._boardPanel = self:getView():getChildByName("board")

	self._boardPanel:ignoreContentAdaptWithSize(true)

	self._remainTimes = self:getView():getChildByName("remainTime")
end

function HeroStoryCell:refreshData(point, isModelInfo, selectIndex, index)
	if isModelInfo then
		local heroInfo = self._mediator._heroInfo
		local _point = point
		local pointIndex = _point:getIndex()

		self._isUnLock = _point:isUnlock(heroInfo)
		self._isPassed = _point:isPass()

		self._name:setString(pointIndex)
		self._bossName:setString(pointIndex)
		self._content:setString(Strings:get(_point:getName()))

		local panelBgC = self:getView():getChildByName("decBgC")

		if self._isUnLock == true then
			self._lock:setVisible(false)
			panelBgC:loadTexture("zx_passed_bg.png", ccui.TextureResType.plistType)
		else
			self._lock:setVisible(true)
			panelBgC:loadTexture("zx_locked_bg.png", ccui.TextureResType.plistType)
		end

		if self._isPassed then
			self._rewards = _point:getShowRewards()
			self._getRewardStr = Strings:get("HeroStory_NormalRewardUI")

			self._name:setTextColor(color1)
			self._content:setTextColor(color1)
		else
			self._name:setTextColor(color2)
			self._content:setTextColor(color2)

			self._rewards = _point:getShowFirstKillReward()
			self._getRewardStr = Strings:get("STAGE_FIRST_DROP_TITLE")
		end

		self._star:setVisible(true)

		local starState = _point:getStarState() or {}

		for i = 1, 3 do
			self._star:getChildByName("star" .. i):setVisible(starState[i])
		end

		if _point:isBoss() then
			self._boss:setVisible(true)
		else
			self._boss:setVisible(false)
		end

		local board = _point:getConfig().Board

		if board == 0 then
			self._boardPanel:setVisible(false)
		else
			self._boardPanel:setVisible(true)
		end

		self._remainTimes:setString(Strings:get("HeroStory_Times") .. _point:getChallengeTimes())
	else
		local pointConfig = ConfigReader:getRecordById("HeroStoryPoint", point)
		local pointIndex = index

		self._isUnLock = index == 1 and selectIndex == 1
		self._isPassed = false

		self._name:setString(pointIndex)
		self._bossName:setString(pointIndex)
		self._content:setString(Strings:get(pointConfig.Name))

		local panelBgC = self:getView():getChildByName("decBgC")

		if self._isUnLock == true then
			self._lock:setVisible(false)
			panelBgC:loadTexture("zx_passed_bg.png", ccui.TextureResType.plistType)
		else
			self._lock:setVisible(true)
			panelBgC:loadTexture("zx_locked_bg.png", ccui.TextureResType.plistType)
		end

		self._name:setTextColor(color2)
		self._content:setTextColor(color2)

		local rewardId = pointConfig.FirstKillReward

		self._rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")
		self._getRewardStr = Strings:get("STAGE_FIRST_DROP_TITLE")

		for i = 1, 3 do
			self._star:getChildByName("star" .. i):setVisible(false)
		end

		if pointConfig.PointType == "BOSS" then
			self._boss:setVisible(true)
		else
			self._boss:setVisible(false)
		end

		local board = pointConfig.Board

		if board == 0 then
			self._boardPanel:setVisible(false)
		else
			self._boardPanel:setVisible(true)
		end

		self._remainTimes:setString(Strings:get("HeroStory_Times") .. pointConfig.LimitAmount)
	end
end

function HeroStoryCell:setCellState(selectedIndex, index)
	local panelBgC = self:getView():getChildByName("decBgC")
	local panelBgUC = self:getView():getChildByName("decBgUC")

	panelBgUC:removeChildByTag(9521, true)
	panelBgUC:removeChildByTag(9522, true)
	self._img:removeAllChildren()

	if selectedIndex ~= index and self._isUnLock then
		self._remainTimes:setVisible(true)
	else
		self._remainTimes:setVisible(false)
	end

	if selectedIndex == index then
		local label = ccui.Text:create(self._getRewardStr, TTF_FONT_FZYH_R, 18)

		label:setTextColor(cc.c3b(255, 255, 255))
		label:enableOutline(cc.c3b(0, 0, 0, 255), 1)
		label:setPosition(127, 8)
		label:addTo(self._img)

		local rewardNodes = {}

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
					icon:addTo(self._img)

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
		mc:setPosition(cc.p(-228.5, 56))
		mc:gotoAndPlay(10)
		performWithDelay(self:getView(), function()
			local iconMC = self._boss:isVisible() and cc.MovieClip:create("XZBSsaoguang_zhuxianguanka_UIjiaohudongxiao") or cc.MovieClip:create("XZBS_zhuxianguanka_UIjiaohudongxiao")

			iconMC:addTo(panelBgUC, 1):setTag(9522)
			iconMC:setPosition(cc.p(-110, 36))
		end, 0.3)
		self._img:setOpacity(0)
		panelBgUC:setOpacity(0)
		panelBgC:setOpacity(255)

		local action1 = cc.Spawn:create(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1.5), cc.ScaleTo:create(0.08, 1, 1.2)), cc.FadeOut:create(0.28))

		panelBgC:runAction(action1)

		local action2 = cc.Sequence:create(cc.DelayTime:create(0.25), cc.FadeIn:create(0.25))

		panelBgUC:runAction(action2:clone())
		self._img:runAction(action2:clone())

		for k, v in ipairs(rewardNodes) do
			local action3 = cc.Sequence:create(cc.DelayTime:create(0.1 * k + 0.15), cc.Spawn:create(cc.FadeIn:create(0.25), cc.ScaleTo:create(0.25, 0.32)), cc.ScaleTo:create(0.08, 0.4))

			v:runAction(action3)
		end

		self._content:runAction(cc.Sequence:create(cc.FadeOut:create(0.28), cc.FadeIn:create(0.28)))
		self._name:setVisible(false)
		self._name:runAction(cc.FadeOut:create(0.28))
		performWithDelay(self:getView(), function()
			if self._boss:isVisible() then
				self._name:setFontSize(70)
				self._name:setPosition(cc.p(36, 35))
			else
				self._name:setFontSize(86)
				self._name:setPosition(cc.p(38, 24))
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

		if self._boardPanel:isVisible() then
			self._boardPanel:setOpacity(0)
			self._boardPanel:loadTexture("hb_icon_ts01.png", 1)
			self._boardPanel:setPosition(40, 26)
			self._boardPanel:runAction(cc.FadeIn:create(0.3))
		end

		self._star:setPositionY(10)
	else
		panelBgC:setOpacity(255)
		panelBgUC:setOpacity(0)
		self._name:setFontName(TTF_FONT_FZYH_R)
		self._name:setFontSize(32)

		if self._boss:isVisible() then
			self._boss:getChildByName("dark"):setOpacity(255)
			self._boss:getChildByName("light"):setOpacity(0)
			self._name:setVisible(false)
		end

		if self._boardPanel:isVisible() then
			self._boardPanel:loadTexture("hb_icon_ts02.png", 1)
			self._boardPanel:setPosition(45, 24)
		end

		self._star:setPositionY(20)
	end
end
