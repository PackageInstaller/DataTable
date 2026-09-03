-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/PetRaceRuleMediator.lua

PetRaceRuleMediator = class("PetRaceRuleMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {}

function PetRaceRuleMediator:initialize()
	super.initialize(self)
end

function PetRaceRuleMediator:dispose()
	super.dispose(self)
end

function PetRaceRuleMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function PetRaceRuleMediator:enterWithData(data)
	self._rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "KOF_RuleText", "content")

	self:initContent()

	self._bgWidget = bindWidget(self, "main.bg_node", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("EXPLORE_UI16"),
		title1 = Strings:get("UITitle_EN_Guizeshuoming")
	})

	self:setupClickEnvs()
end

function PetRaceRuleMediator:initContent()
	self._listView = self:getView():getChildByFullName("main.listview")
	self._contextPanel = self:getView():getChildByName("content_panel")

	self._contextPanel:setVisible(false)

	self._titlePanel = self:getView():getChildByName("title_panel")

	self._titlePanel:setVisible(false)
	self._listView:setScrollBarEnabled(false)

	self._width = self._listView:getContentSize().width

	local openTimes = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "KOF_MatchNumber", "content")
	local localDates = {}

	for k, v in pairs(openTimes) do
		localDates[#localDates + 1] = TimeUtil:localDate("%H:%M:%S", TimeUtil:getTimeByDateForTargetTimeInToday({
			hour = string.split(v, ":")[1],
			min = string.split(v, ":")[2],
			sec = string.split(v, ":")[3]
		}))
	end

	local startTime = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "KOF_JoinStartTime", "content")
	local endTime = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "KOF_JoinEndTime", "content")

	startTime = TimeUtil:localDate("%H:%M:%S", TimeUtil:getTimeByDateForTargetTimeInToday({
		hour = string.split(startTime, ":")[1],
		min = string.split(startTime, ":")[2],
		sec = string.split(startTime, ":")[3]
	}))
	endTime = TimeUtil:localDate("%H:%M:%S", TimeUtil:getTimeByDateForTargetTimeInToday({
		hour = string.split(endTime, ":")[1],
		min = string.split(endTime, ":")[2],
		sec = string.split(endTime, ":")[3]
	}))

	for i = 1, #self._rule do
		local rule = self._rule[i]

		self:addTitle(Strings:get(rule.Title), i == 1)

		for j = 1, #rule.Desc do
			self:addContent(Strings:get(rule.Desc[j], {
				fontName = TTF_FONT_FZYH_M,
				time1 = localDates[1],
				time2 = localDates[2],
				time3 = localDates[3],
				starttime = startTime,
				endtime = endTime
			}), j == #rule.Desc)
		end
	end
end

function PetRaceRuleMediator:addTitle(text, hideLine)
	local panel = self._titlePanel:clone()

	panel:setVisible(true)

	local title = panel:getChildByFullName("title")

	title:setString(text)
	self._listView:pushBackCustomItem(panel)
	panel:getChildByFullName("line"):setVisible(not hideLine)
end

function PetRaceRuleMediator:addContent(text, isAddHeight)
	local panel = self._contextPanel:clone()

	panel:setVisible(true)

	local context = panel:getChildByName("content")

	context:setVisible(false)

	local contentRt = ccui.RichText:createWithXML(text, {})

	contentRt:setVerticalSpace(10)
	contentRt:setAnchorPoint(cc.p(0, 1))
	panel:addChild(contentRt, 1)
	contentRt:renderContent(self._width, 0)
	self:adjustContainDesc(contentRt, panel, isAddHeight)
	self._listView:pushBackCustomItem(panel)
end

function PetRaceRuleMediator:adjustContainDesc(contentRt, panel, isAddHeight)
	local panelSize = panel:getContentSize()
	local kLabelHeight = 32
	local labelSize = contentRt:getContentSize()

	panel:setContentSize(cc.size(panelSize.width, kLabelHeight))

	if kLabelHeight < labelSize.height then
		local count = math.ceil(labelSize.height / kLabelHeight)

		panel:setContentSize(cc.size(panelSize.width, kLabelHeight * count))
	end

	if isAddHeight then
		panel:setContentSize(cc.size(panelSize.width, panel:getContentSize().height + 10))
	end

	local height = panel:getContentSize().height - 6

	contentRt:setPositionY(height)
end

function PetRaceRuleMediator:onClickClose()
	self:close()
end

function PetRaceRuleMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local btnBack = self._bgWidget:getView():getChildByFullName("btn_close")

		storyDirector:setClickEnv("ExplorePointRuleMediator.btnBack", btnBack, function(sender, eventType)
			AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)
			self:onClickClose()
			storyDirector:notifyWaiting("exit_ExplorePointRuleMediator")
		end)
		storyDirector:notifyWaiting("enter_ExplorePointRuleMediator")
	end))

	self:getView():runAction(sequence)
end
