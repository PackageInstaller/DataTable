-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/spStage/view/SpStageRuleMediator.lua

SpStageRuleMediator = class("SpStageRuleMediator", DmPopupViewMediator, _M)

SpStageRuleMediator:has("_spStageSystem", {
	is = "r"
}):injectWith("SpStageSystem")

local kBtnHandlers = {}
local kLabelWidth = 465

function SpStageRuleMediator:initialize()
	super.initialize(self)

	local __close = self.close
	local this = self

	function self.close()
		__close(this)

		if this._callback then
			this._callback()
		end
	end
end

function SpStageRuleMediator:dispose()
	super.dispose(self)
end

function SpStageRuleMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function SpStageRuleMediator:enterWithData(data)
	self._ruleList = data.rules
	self._callback = data.callback

	self:initContent(data)
end

function SpStageRuleMediator:initContent(data)
	local title = self:getView():getChildByFullName("main.title")

	title:setString(data.title or "")

	self._listView = self:getView():getChildByFullName("main.listview")
	self._contextPanel = self:getView():getChildByName("content_panel")

	self._contextPanel:setVisible(false)
	self._listView:setScrollBarEnabled(false)

	local length = #self._ruleList

	for i = 1, length do
		local rule = self._ruleList[i]

		self:addContent(Strings:get(rule, {
			fontName = TTF_FONT_FZYH_R
		}), tonumber(i) == length)
	end
end

function SpStageRuleMediator:addContent(text, isAddHeight)
	local panel = self._contextPanel:clone()

	panel:setVisible(true)

	local context = panel:getChildByName("content")

	context:setString("")

	local contentRt = ccui.RichText:createWithXML(text, {})

	contentRt:setVerticalSpace(15)
	contentRt:setAnchorPoint(cc.p(0, 0.5))
	panel:addChild(contentRt, 1)
	contentRt:renderContent(kLabelWidth, 0)

	panel.contentRt = contentRt

	panel:setPosition(cc.p(0, 0))
	self:adjustContionDesc(contentRt, panel, isAddHeight)
	self._listView:pushBackCustomItem(panel)
end

function SpStageRuleMediator:adjustContionDesc(contentRt, panel, isAddHeight)
	local labelSize = contentRt:getContentSize()
	local height = labelSize.height + 17

	panel:setContentSize(cc.size(kLabelWidth, height))
	contentRt:setPosition(cc.p(0, height / 2))
end

function SpStageRuleMediator:onClickClose(sender, eventType)
	self:close()
end
