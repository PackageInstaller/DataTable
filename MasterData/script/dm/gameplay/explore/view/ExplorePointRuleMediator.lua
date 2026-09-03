-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExplorePointRuleMediator.lua

ExplorePointRuleMediator = class("ExplorePointRuleMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {}

function ExplorePointRuleMediator:initialize()
	super.initialize(self)
end

function ExplorePointRuleMediator:dispose()
	super.dispose(self)
end

function ExplorePointRuleMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ExplorePointRuleMediator:enterWithData(data)
	self._rule = data.rule or {}
	self._urlCallBack = data.urlCallBack or nil
	self._ruleReplaceInfo = data.ruleReplaceInfo or {}

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

function ExplorePointRuleMediator:initContent()
	self._listView = self:getView():getChildByFullName("main.listview")
	self._contextPanel = self:getView():getChildByName("content_panel")

	self._contextPanel:setVisible(false)

	self._titlePanel = self:getView():getChildByName("title_panel")

	self._titlePanel:setVisible(false)
	self._listView:setScrollBarEnabled(false)

	self._width = self._listView:getContentSize().width

	local stringParams = {
		fontName = TTF_FONT_FZYH_R
	}

	for k, v in pairs(self._ruleReplaceInfo) do
		stringParams[k] = v
	end

	for i = 1, #self._rule do
		local rule = self._rule[i]

		self:addTitle(Strings:get(rule.Title, stringParams), i == 1)

		for j = 1, #rule.Desc do
			self:addContent(Strings:get(rule.Desc[j], stringParams), j == #rule.Desc)
		end
	end
end

function ExplorePointRuleMediator:addTitle(text, hideLine)
	local panel = self._titlePanel:clone()

	panel:setVisible(true)

	local title = panel:getChildByFullName("title")

	title:setString(text)
	self._listView:pushBackCustomItem(panel)
	panel:getChildByFullName("line"):setVisible(not hideLine)
end

function ExplorePointRuleMediator:addContent(text, isAddHeight)
	local panel = self._contextPanel:clone()

	panel:setVisible(true)

	local context = panel:getChildByName("content")

	context:setVisible(false)

	local textData = string.split(text, "<font")

	if #textData <= 1 then
		text = "<outline color='#000000' size = '1'><font face='asset/font/CustomFont_FZYH_R.TTF' size='18' color='#FFFEFE'>" .. text .. "</font></outline>"
	end

	local contentRt = ccui.RichText:createWithXML(text, {})

	contentRt:setVerticalSpace(10)
	contentRt:setAnchorPoint(cc.p(0, 1))
	panel:addChild(contentRt, 1)
	contentRt:renderContent(self._width, 0)
	self:adjustContainDesc(contentRt, panel, isAddHeight)
	self._listView:pushBackCustomItem(panel)
	contentRt:setTouchEnabled(true)
	contentRt:setOpenUrlHandler(function(url)
		if self._urlCallBack then
			self._urlCallBack(url)
		end
	end)
end

function ExplorePointRuleMediator:adjustContainDesc(contentRt, panel, isAddHeight)
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

function ExplorePointRuleMediator:onClickClose()
	self:close()
end

function ExplorePointRuleMediator:setupClickEnvs()
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
