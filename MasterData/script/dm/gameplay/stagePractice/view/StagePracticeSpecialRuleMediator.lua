-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/view/StagePracticeSpecialRuleMediator.lua

StagePracticeSpecialRuleMediator = class("StagePracticeSpecialRuleMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {
	["main.closeBtn"] = {
		clickAudio = "Se_Click_Close_1",
		func = "onClickClose"
	}
}

function StagePracticeSpecialRuleMediator:initialize()
	super.initialize(self)
end

function StagePracticeSpecialRuleMediator:dispose()
	super.dispose(self)
end

function StagePracticeSpecialRuleMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function StagePracticeSpecialRuleMediator:enterWithData(data)
	dump(data, "data >>>>>>")

	self._ruleList = data.ruleList or {}
	self._title = self._ruleList[1]

	self:initContent()
end

function StagePracticeSpecialRuleMediator:initContent()
	local title = self:getView():getChildByFullName("main.title")

	title:setString(Strings:get(self._title))

	local listView = self:getView():getChildByFullName("main.ListView_1")
	local textLayer = self:getView():getChildByFullName("main.textLayer")
	local textImg = self:getView():getChildByFullName("main.textImg")
	local layer = textLayer:clone()

	layer:setAnchorPoint(cc.p(0, 1))
	listView:setScrollBarEnabled(false)

	local length = 0

	for i = #self._ruleList, 2, -1 do
		local img = textImg:clone()
		local text = Strings:get(self._ruleList[i], {
			fontName = TTF_FONT_FZYH_R
		})
		local richText = ccui.RichText:createWithXML(text, {})

		richText:addTo(img)
		richText:setAnchorPoint(cc.p(0, 1))
		richText:setPosition(cc.p(42, 43))
		richText:renderContent(372, 0, true)

		length = length + richText:getContentSize().height + 10

		img:addTo(layer):posite(-15, length)
	end

	layer:setContentSize(textLayer:getContentSize().width, length)
	listView:pushBackCustomItem(layer)

	local bublingText = self:getView():getChildByFullName("main.bubling.text")
	local strs = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Point_Skill_Text", "content")
	local text = Strings:get(strs[math.random(1, #strs)])

	bublingText:setString(text)
	bublingText:getVirtualRenderer():setMaxLineWidth(120)
end

function StagePracticeSpecialRuleMediator:onTouchMaskLayer()
	return
end

function StagePracticeSpecialRuleMediator:onClickClose()
	self:close()
end
