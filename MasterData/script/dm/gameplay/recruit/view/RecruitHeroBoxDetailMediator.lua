-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recruit/view/RecruitHeroBoxDetailMediator.lua

require("dm.gameplay.popup.BaseRewardBoxMediator")

RecruitHeroBoxDetailMediator = class("RecruitHeroBoxDetailMediator", BaseRewardBoxMediator, _M)

RecruitHeroBoxDetailMediator:has("_recruitSystem", {
	is = "r"
}):injectWith("RecruitSystem")

function RecruitHeroBoxDetailMediator:initialize()
	super.initialize(self)
end

function RecruitHeroBoxDetailMediator:dispose()
	super.dispose(self)
end

function RecruitHeroBoxDetailMediator:onRegister()
	super.onRegister(self)
end

function RecruitHeroBoxDetailMediator:setupView(data)
	super.setupView(self, data)

	self._boxData = data.boxData
	self._boxRewardRecruitTimes = data.recruitTimes

	local rewardId = self._boxData.rewardId
	local rewards = RewardSystem:getRewardsById(rewardId)

	if rewards then
		self:addRewardIcons(rewards)
	end

	self._descTextNode:setVisible(true)

	local content = Strings:get("Recruit_Desc2", {
		recruitCount = self._boxRewardRecruitTimes,
		fontName = TTF_FONT_FZYH_R
	})
	local descText = ccui.RichText:createWithXML(content, {})

	descText:setAnchorPoint(cc.p(0.5, 1))
	descText:addTo(self._descTextNode)
	self:updateView()
end

function RecruitHeroBoxDetailMediator:updateView()
	local boxState = self._boxData.state

	if boxState then
		self._sureBtn:setVisible(boxState == RecruitBoxState.kCannotReceive)
		self._receiveBtn:setVisible(boxState == RecruitBoxState.kCanReceive)
		self._hasReceivedImg:setVisible(boxState == RecruitBoxState.kHasReceived)
	end
end
