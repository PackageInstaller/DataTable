-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/monthSignIn/view/MSPopRewardBoxMediator.lua

MSPopRewardBoxMediator = class("MSPopRewardBoxMediator", DmPopupViewMediator, _M)

MSPopRewardBoxMediator:has("_monthSignInSystem", {
	is = "r"
}):injectWith("MonthSignInSystem")

function MSPopRewardBoxMediator:initialize()
	super.initialize(self)
end

function MSPopRewardBoxMediator:dispose()
	super.dispose(self)
end

function MSPopRewardBoxMediator:onRegister()
	super.onRegister(self)
end

function MSPopRewardBoxMediator:enterWithData(data)
	local day = data.difDay
	local rewards = data.rewards
	local isAct, actUi = self._monthSignInSystem:checkActivity()
	local diImg = self:getView():getChildByName("Image_1")
	local textId = "Setting_Ui_Text_8"

	if isAct and actUi == ActivityType_UI.KActivityBlockHoliday then
		diImg:loadTexture("shuangdan_img_qd_neiqian2.png", ccui.TextureResType.plistType)

		textId = "Newyear_Login_Text"
	end

	local str = Strings:get(textId, {
		num = day,
		fontName = TTF_FONT_FZYH_M
	})
	local richText = ccui.RichText:createWithXML(str, {
		fontName = TTF_FONT_FZYH_M
	})

	richText:addTo(self:getView())
	richText:setPosition(cc.p(603, 370))
	ajustRichTextCustomWidth(richText, 260)

	local layout = ccui.Layout:create()

	layout:setContentSize(cc.size(100, 100))

	local layoutSize

	for i = 1, #rewards do
		local reward = rewards[i]
		local icon = IconFactory:createRewardIcon(reward, {
			isWidget = true
		})

		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
			needDelay = true
		})
		icon:addTo(layout)
		icon:setAnchorPoint(0, 0)
		icon:setScaleNotCascade(0.6)

		local iconSize = icon:getContentSize()

		iconSize = cc.size(iconSize.width * 0.6, iconSize.height * 0.6)
		layoutSize = iconSize

		icon:setPosition((i - 1) * (iconSize.width + 27), 0)
	end

	layout:setContentSize(cc.size(#rewards * (layoutSize.width + 27) - 27, layoutSize.height))
	layout:setAnchorPoint(cc.p(0.5, 0.5))
	layout:addTo(self:getView())
	layout:setPosition(cc.p(603, 295))
end
