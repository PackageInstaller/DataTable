-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceRuleMediator.lua

WorldPeaceRuleMediator = class("WorldPeaceRuleMediator", DmPopupViewMediator, _M)

WorldPeaceRuleMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WorldPeaceRuleMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function WorldPeaceRuleMediator:initialize()
	super.initialize(self)
end

function WorldPeaceRuleMediator:dispose()
	super.dispose(self)
end

function WorldPeaceRuleMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
end

function WorldPeaceRuleMediator:setupView(data)
	self._rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBossRules", "content")
	self._ruleReplaceInfo = self._worldPeaceSystem:formatTimeParams()

	if not self._init then
		self._init = true

		self:initContent()
	end
end

function WorldPeaceRuleMediator:initContent()
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

		for j = 1, #rule.Desc do
			self:addContent(Strings:get(rule.Desc[j], stringParams), j == #rule.Desc)
		end
	end
end

function WorldPeaceRuleMediator:addTitle(text, hideLine)
	local panel = self._titlePanel:clone()

	panel:setVisible(true)

	local title = panel:getChildByFullName("title")

	title:setString(text)
	self._listView:pushBackCustomItem(panel)
end

function WorldPeaceRuleMediator:addContent(text, isAddHeight)
	local panel = self._contextPanel:clone()

	panel:setVisible(true)

	local context = panel:getChildByName("content")

	context:setVisible(false)

	local textData = string.split(text, "<font")

	if #textData <= 1 then
		text = "<font face='${fontName}' size='18' color='#FFFFFF'>" .. text .. "</font> "

		local t = TextTemplate:new(text)

		text = t:stringify({
			fontName = TTF_FONT_FZYH_M
		})
	end

	local contentRt = ccui.RichText:createWithXML(text, {})

	contentRt:setVerticalSpace(10)
	contentRt:setAnchorPoint(cc.p(0, 1))
	panel:addChild(contentRt, 1)
	contentRt:renderContent(self._width, 0)
	self:adjustContainDesc(contentRt, panel, isAddHeight)
	self._listView:pushBackCustomItem(panel)
end

function WorldPeaceRuleMediator:adjustContainDesc(contentRt, panel, isAddHeight)
	local panelSize = panel:getContentSize()
	local kLabelHeight = 40
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
