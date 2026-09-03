-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/spStage/view/SpStageBoxMediator.lua

require("dm.gameplay.popup.BaseRewardBoxMediator")

SpStageBoxMediator = class("SpStageBoxMediator", BaseRewardBoxMediator, _M)

function SpStageBoxMediator:initialize()
	super.initialize(self)
end

function SpStageBoxMediator:dispose()
	super.dispose(self)
end

function SpStageBoxMediator:onRegister()
	super.onRegister(self)
end

function SpStageBoxMediator:setupView(data)
	super.setupView(self, data)

	local name = data.name
	local conditionValue = data.conditionValue
	local rewardId = data.rewardId
	local state = data.state
	local rewards = RewardSystem:getRewardsById(rewardId)

	if rewards then
		self:addRewardIcons(rewards)
	end

	self._sureBtn:setVisible(state ~= SpStageBoxState.kHasReceived)
	self._hasReceivedImg:setVisible(state == SpStageBoxState.kHasReceived)
	self._normalBoxInfo:setVisible(true)

	local descLabel = self._normalBoxInfo:getChildByFullName("desc_text")
	local descStr = Strings:get("RewardPreview_3", {
		num = conditionValue,
		name = name
	})

	descLabel:setString(descStr)
end
