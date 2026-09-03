-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/view/StagePracticeHelpTipMediator.lua

StagePracticeHelpTipMediator = class("StagePracticeHelpTipMediator", DmPopupViewMediator, _M)

StagePracticeHelpTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function StagePracticeHelpTipMediator:initialize()
	super.initialize(self)
end

function StagePracticeHelpTipMediator:dispose()
	super.dispose(self)
end

function StagePracticeHelpTipMediator:userInject()
	return
end

function StagePracticeHelpTipMediator:onRegister()
	super.onRegister(self)
end

function StagePracticeHelpTipMediator:enterWithData(data)
	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByName("listview")

	local pointId = data.pointId
	local config = ConfigReader:getRecordById("StagePracticePoint", tostring(pointId))
	local nameLabel = self._main:getChildByName("namelabel")

	nameLabel:setString(Strings:get(config.Name))

	local descLabel = self._main:getChildByName("desclabel")

	descLabel:setString("")

	local label = ccui.RichText:createWithXML(Strings:get("StagePtc_Skill_Guid1", {
		skill = Strings:get(config.Name),
		fontName = TTF_FONT_FZYH_M
	}), {})

	label:ignoreContentAdaptWithSize(true)
	label:rebuildElements()
	label:formatText()
	label:setAnchorPoint(cc.p(0.5, 0))
	label:renderContent()
	label:addTo(self._main):center(self._main:getContentSize()):offset(140, 50)

	if config.TeachWord and #config.TeachWord > 0 then
		for i = 1, #config.TeachWord do
			local id = config.TeachWord[i]

			self:addDescPanel(Strings:get(id, {
				fontName = TTF_FONT_FZYH_M
			}))
		end
	end
end

function StagePracticeHelpTipMediator:addDescPanel(str)
	local width = 600
	local panel = ccui.Layout:create()

	panel:setSwallowTouches(false)

	local data = string.split(str, "<font")

	if #data <= 1 then
		str = Strings:get("StagePracticeGuideDesc2_Text", {
			desc = str,
			fontName = TTF_FONT_FZYH_M
		})
	end

	local label = ccui.RichText:createWithXML(str, {})

	label:ignoreContentAdaptWithSize(true)
	label:rebuildElements()
	label:formatText()
	label:setAnchorPoint(cc.p(0, 0))
	label:renderContent()
	label:setVerticalSpace(2)
	label:ignoreContentAdaptWithSize(false)
	label:setContentSize(cc.size(420, 0))
	label:renderContent()

	local offsetX = 4
	local height = label:getContentSize().height + 2

	panel:setContentSize(cc.size(width, height + 0))
	label:addTo(panel):posite(40 + offsetX, 0)
	self._listView:pushBackCustomItem(panel)

	local icon = cc.Sprite:createWithSpriteFrameName("img_common_lingxing.png")

	icon:addTo(panel):posite(24 + offsetX, height - 18)
end
