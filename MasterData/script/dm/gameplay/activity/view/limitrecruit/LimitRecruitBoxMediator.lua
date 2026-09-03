-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/limitrecruit/LimitRecruitBoxMediator.lua

LimitRecruitBoxMediator = class("LimitRecruitBoxMediator", DmPopupViewMediator, _M)

LimitRecruitBoxMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

function LimitRecruitBoxMediator:initialize()
	super.initialize(self)
end

function LimitRecruitBoxMediator:dispose()
	super.dispose(self)
end

function LimitRecruitBoxMediator:onRegister()
	super.onRegister(self)
	self:bindWidgets()

	self._main = self:getView():getChildByName("main")
end

function LimitRecruitBoxMediator:bindWidgets()
	self._sureWidget = self:bindWidget("main.sure_btn", TwoLevelMainButton, {
		handler = bind1(self.onClickSure, self)
	})
end

function LimitRecruitBoxMediator:enterWithData(data)
	dump("LimitRecruitBoxMediator___")

	self._data = data
	self._bgWidget = bindWidget(self, "main.bg_node", PopupNormalWidget, {
		title1 = "",
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:find("CUSTOM_REWARD_TITLE1")
	})

	self:setupView()
end

function LimitRecruitBoxMediator:setupView()
	local descText = self._main:getChildByName("desc_text")

	descText:setString(Strings:get("SPDrawcard_UI01", {
		score = self._data.score
	}))
	self._sureWidget:getView():setVisible(self._data.status == ActivityTaskStatus.kUnfinish)

	local hasgetImg = self._main:getChildByName("has_received_img")

	hasgetImg:setVisible(self._data.status == ActivityTaskStatus.kGet)

	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", self._data.rewardId, "Content")

	if rewards then
		local iconsRect = self._main:getChildByFullName("icons_rect")
		local count = #rewards
		local width = 115
		local firstIconPosX = iconsRect:getPositionX() - (count - 1) * width / 2
		local poxY = iconsRect:getPositionY()

		for index, reward in ipairs(rewards) do
			local icon = IconFactory:createRewardIcon(reward, {
				isWidget = true
			})

			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
				needDelay = true
			})
			icon:setScale(0.8)
			icon:addTo(iconsRect:getParent()):posite(firstIconPosX + (index - 1) * width, poxY)
		end
	end
end

function LimitRecruitBoxMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end

function LimitRecruitBoxMediator:onClickSure(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
