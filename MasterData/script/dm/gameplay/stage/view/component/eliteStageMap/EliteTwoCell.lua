-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/component/eliteStageMap/EliteTwoCell.lua

EliteTwoCell = class("EliteTwoCell", ChapterBase)

local kBtnHandlers = {}

function EliteTwoCell:initialize(data)
	super.initialize(self, data)

	self._stageType = data.stageType
	self._mediator = data.mediator

	self:initView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function EliteTwoCell:update(stageType, redPointTab)
	self._stageType = stageType

	local function callFunc()
		local contentData = {}

		contentData.stageType = self._stageType
		contentData.tabOffX = self._mediator._tableView:getContentOffset().x

		self._mediator:getStageSystem():setContentData(contentData)
	end

	self:initChapterPanel(self._chapter1, "E02", callFunc)
	self._chapter1:setPosition(cc.p(self._chapter1RowX, self._chapter1RowY))
	self._chapter1.redPoint:setVisible(self:checkRedPoint(redPointTab, 2))
	self:initChapterPanel(self._chapter2, "E03", callFunc)
	self._chapter2:setPosition(cc.p(self._chapter2RowX, self._chapter2RowY))
	self._chapter2.redPoint:setVisible(self:checkRedPoint(redPointTab, 3))
	self:setupGuideAnim()
end

function EliteTwoCell:onScroll(offX)
	self:initMobileObj(offX, self._chapter1, 380, cc.p(self._chapter1RowX, self._chapter1RowY), 1617, 230)
	self:initMobileObj(offX, self._chapter2, 500, cc.p(self._chapter2RowX, self._chapter2RowY), 1800, 430)
end

function EliteTwoCell:initView()
	self:initWidget()
	self:initAnim()
end

function EliteTwoCell:initWidget()
	self._main = self:getView():getChildByName("main")
	self._chapter1 = self._main:getChildByName("chapterCell_1")
	self._chapter1.redPoint = self._chapter1:getChildByName("redPoint")

	AdjustUtils.adjustLayoutByType(self._chapter1, AdjustUtils.kAdjustType.Top)

	self._chapter1RowX = self._chapter1:getPositionX()
	self._chapter1RowY = self._chapter1:getPositionY()
	self._chapter2 = self._main:getChildByName("chapterCell_2")
	self._chapter2.redPoint = self._chapter2:getChildByName("redPoint")
	self._chapter2RowX = self._chapter2:getPositionX()
	self._chapter2RowY = self._chapter2:getPositionY()
	self._textPanel = self._main:getChildByName("textPanel")
	self._textPanelRowX = self._textPanel:getPositionX()
	self._textPanelRowY = self._textPanel:getPositionY()

	local Image1 = self._main:getChildByName("Image_1")

	AdjustUtils.adjustLayoutByType(Image1, AdjustUtils.kAdjustType.Bottom)
	self._textPanel:setSwallowTouches(false)

	local function callFunc(sender, eventType)
		local hideText = sender:getChildByName("hideText")

		if eventType == ccui.TouchEventType.began then
			hideText:stopAllActions()

			local fadeAct = cc.FadeIn:create(0.1)

			hideText:runAction(cc.Sequence:create(fadeAct, cc.CallFunc:create(function()
				AudioEngine:getInstance():playEffect("Se_Effect_Display", false)
			end)))
		elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
			hideText:stopAllActions()

			local fadeAct = cc.FadeOut:create(0.5)

			hideText:runAction(fadeAct)
		end
	end

	mapButtonHandlerClick(nil, self._textPanel, {
		ignoreClickAudio = true,
		eventType = 4,
		func = callFunc
	})
end

function EliteTwoCell:initAnim()
	local mc = cc.MovieClip:create("sshu_zhuxianyun")
	local imageBgPanel = self._main:getChildByName("imageBgPanel")

	mc:addTo(imageBgPanel)
	mc:setPosition(cc.p(368, 208))
	AdjustUtils.adjustLayoutByType(mc, AdjustUtils.kAdjustType.Bottom)

	local mc1 = cc.MovieClip:create("qiqiu_zhuxianyun")

	mc1:addTo(self._main)
	mc1:setPosition(cc.p(400, 128))
end

function EliteTwoCell:setupGuideAnim()
	local pointId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayerGuide_EndBlockPoint", "content") or "M03S06"
	local point = self._stageSystem:getPointById(pointId)

	if GameConfigs.closeGuide or self._stageType ~= "NORMAL" or point and point:isPass() then
		if self._circleAnimMapTwo then
			self._circleAnimMapTwo:removeFromParent(true)

			self._circleAnimMapTwo = nil
		end

		if self._circleAnimChapterThree then
			self._circleAnimChapterThree:removeFromParent(true)

			self._circleAnimChapterThree = nil
		end

		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local mapTwoAnimS = false
	local mapThreeAnimS = false

	if not guideAgent:isGuiding() then
		local mapInfo = self._stageSystem:getMapByIndex(2, self._stageType)
		local unlock = mapInfo:isUnlock()
		local isPass = mapInfo:isPass()

		if unlock and not isPass then
			mapTwoAnimS = true
		end

		mapInfo = self._stageSystem:getMapByIndex(3, self._stageType)
		unlock = mapInfo:isUnlock()
		isPass = mapInfo:isPass()

		if unlock and not isPass then
			mapThreeAnimS = true
		end
	end

	if mapTwoAnimS then
		if self._chapter1 then
			if self._circleAnimMapTwo == nil then
				local circleAnim = cc.MovieClip:create("xiaoshou_xinshouyindao")

				circleAnim:addTo(self._chapter1):center(self._chapter1:getContentSize()):offset(0, 0)

				local handNode = circleAnim:getChildByName("handNode")

				if handNode then
					local image = ccui.ImageView:create("xsyd_shou.png", ccui.TextureResType.plistType)

					image:addTo(handNode)
				end

				self._circleAnimMapTwo = circleAnim
			end

			self._circleAnimMapTwo:setVisible(true)
		end
	elseif self._circleAnimMapTwo then
		self._circleAnimMapTwo:setVisible(false)
	end

	if mapThreeAnimS then
		if self._chapter2 then
			if self._circleAnimChapterThree == nil then
				local circleAnim = cc.MovieClip:create("xiaoshou_xinshouyindao")

				circleAnim:addTo(self._chapter2):center(self._chapter2:getContentSize()):offset(0, 0)

				local handNode = circleAnim:getChildByName("handNode")

				if handNode then
					local image = ccui.ImageView:create("xsyd_shou.png", ccui.TextureResType.plistType)

					image:addTo(handNode)
				end

				self._circleAnimChapterThree = circleAnim
			end

			self._circleAnimChapterThree:setVisible(true)
		end
	elseif self._circleAnimChapterThree then
		self._circleAnimChapterThree:setVisible(false)
	end
end
