-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/view/StagePracticeBoxTipMediator.lua

require("dm.gameplay.popup.BaseRewardBoxMediator")

StagePracticeBoxTipMediator = class("StagePracticeBoxTipMediator", BaseRewardBoxMediator, _M)

function StagePracticeBoxTipMediator:initialize()
	super.initialize(self)
end

function StagePracticeBoxTipMediator:dispose()
	super.dispose(self)
end

function StagePracticeBoxTipMediator:onRegister()
	super.onRegister(self)
end

function StagePracticeBoxTipMediator:setupView(data)
	super.setupView(self, data)

	local star = data.star
	local starEngouh = data.starEngouh
	local rewardId = data.rewardId
	local state = data.state
	local rewards

	if rewardId then
		rewards = ConfigReader:getRecordById("Reward", rewardId).Content
	end

	if rewards then
		self:addRewardIcons(rewards)
	end

	self._sureBtn:setVisible(state ~= SpStageBoxState.kHasReceived)
	self._hasReceivedImg:setVisible(state == SpStageBoxState.kHasReceived)
	self._normalBoxInfo:setVisible(true)

	local descLabel = self._normalBoxInfo:getChildByFullName("desc_text")

	descLabel:setString("")

	local str = Strings:get("Practice_RewardTips", {
		fontName = TTF_FONT_FZYH_M,
		color = starEngouh and "#834428" or "#ff2828",
		num = star
	})
	local descLabel = ccui.RichText:createWithXML(str, {})

	descLabel:ignoreContentAdaptWithSize(true)
	descLabel:rebuildElements()
	descLabel:formatText()
	descLabel:setAnchorPoint(cc.p(0.5, 1))
	descLabel:renderContent()
	descLabel:addTo(self._normalBoxInfo):offset(80, 40)
end
