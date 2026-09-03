-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/widgets/StoryChooseDialogWidget.lua

StoryChooseDialogWidget = class("StoryChooseDialogWidget", BaseWidget)

function StoryChooseDialogWidget:initialize(view)
	super.initialize(self, view)
end

function StoryChooseDialogWidget:dispose()
	super.dispose(self)
end

function StoryChooseDialogWidget:setupView()
	local view = self:getView()

	self._main = view:getChildByName("main")
	self._storyType = {}
	self._storyType.novice = {}
	self._storyType.novice.bg = self._main:getChildByFullName("novice.bg")
	self._storyType.novice.title = self._main:getChildByFullName("novice.title")
	self._storyType.novice.choose = self._main:getChildByFullName("novice.choose")
	self._storyType.novice.unchoose = self._main:getChildByFullName("novice.unchoose")
	self._storyType.veteran = {}
	self._storyType.veteran.bg = self._main:getChildByFullName("veteran.bg")
	self._storyType.veteran.title = self._main:getChildByFullName("veteran.title")
	self._storyType.veteran.choose = self._main:getChildByFullName("veteran.choose")
	self._storyType.veteran.unchoose = self._main:getChildByFullName("veteran.unchoose")

	self._storyType.novice.bg:setGray(true)
	self._storyType.novice.choose:setVisible(false)
	self._storyType.novice.unchoose:setVisible(true)
	self._storyType.veteran.bg:setGray(true)
	self._storyType.veteran.choose:setVisible(false)
	self._storyType.veteran.unchoose:setVisible(true)

	self._button = self._main:getChildByFullName("ok_btn")

	self._button:getChildByName("name"):setString(Strings:get("Common_button1"))
	self._button:getChildByName("name1"):setString(Strings:get("UITitle_EN_Queding"))

	self._title = self._main:getChildByFullName("title")

	local descLabel = ccui.RichText:createWithXML(Strings:get("GuideMode_Choice_Title", {
		num = 33,
		fontName = CUSTOM_TTF_FONT_1
	}), {})

	descLabel:setPosition(cc.p(568, 45))
	self._title:addChild(descLabel)
	ajustRichTextCustomWidth(descLabel, 980)

	local lineGradiantVec = {
		{
			ratio = 0.3,
			color = cc.c4b(10, 23, 9, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(72, 99, 41, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	self._storyType.novice.title:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec, lineGradiantDir))
	self._storyType.veteran.title:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec, lineGradiantDir))

	local noviceBtn = view:getChildByFullName("main.novice")

	noviceBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			self._complexityNum = kGuideComplexityList.novice

			self:selectStory(true)
		end
	end)

	local veteranBtn = view:getChildByFullName("main.veteran")

	veteranBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			self._complexityNum = kGuideComplexityList.veteran

			self:selectStory(false)
		end
	end)

	local okBtn = self._button:getChildByFullName("button")

	okBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			if self._complexityNum == kGuideComplexityList.none then
				self:showTip(Strings:get("GuideMode_Choice_Tips"))

				return
			end

			local point = ""

			self._agent:saveGuideComplexNum(self._complexityNum)

			if self._complexityNum == kGuideComplexityList.novice then
				point = "story_difficult_novice"
			elseif self._complexityNum == kGuideComplexityList.veteran then
				point = "story_difficult_veteran"
			end

			local content = {
				type = "loginchoose",
				point = point
			}

			StatisticSystem:send(content)

			local onEnd = self._onEnd

			self._onEnd = nil

			if onEnd ~= nil then
				onEnd()
				AudioEngine:getInstance():setElide(false)
			end

			if SDKHelper and SDKHelper:isEnableSdk() then
				SDKHelper:reportByAD("Toturial_begin")
				SDKHelper:reportByWM("Toturial_begin")
			end
		end
	end)
	self:initAnim()
end

function StoryChooseDialogWidget:initAnim()
	local actionPanel = self._main:getChildByName("actionPanel")
	local bgMc = cc.MovieClip:create("denglu_denglu")

	bgMc:addTo(actionPanel)
	bgMc:setPosition(cc.p(568, 320))
end

function StoryChooseDialogWidget:selectStory(isNew)
	self._storyType.novice.bg:setGray(not isNew)
	self._storyType.novice.choose:setVisible(isNew)
	self._storyType.novice.unchoose:setVisible(not isNew)
	self._storyType.veteran.bg:setGray(isNew)
	self._storyType.veteran.choose:setVisible(not isNew)
	self._storyType.veteran.unchoose:setVisible(isNew)
end

function StoryChooseDialogWidget:updateView(data, onEnd, agent)
	self._onEnd = onEnd
	self._agent = agent
	self._complexityNum = self._agent:getGuideComplexNum()

	AudioEngine:getInstance():setElide(true)
end

function StoryChooseDialogWidget:showTip(str)
	local direc = self._agent:getDirector()
	local developSystem = direc:getInjector():getInstance(DevelopSystem)

	developSystem:dispatch(ShowTipEvent({
		tip = str
	}))
end
