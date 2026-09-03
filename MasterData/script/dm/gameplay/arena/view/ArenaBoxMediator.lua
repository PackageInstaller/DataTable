-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/view/ArenaBoxMediator.lua

require("dm.gameplay.popup.BaseRewardBoxMediator")

ArenaBoxMediator = class("ArenaBoxMediator", BaseRewardBoxMediator, _M)

function ArenaBoxMediator:initialize()
	super.initialize(self)
end

function ArenaBoxMediator:dispose()
	super.dispose(self)
end

function ArenaBoxMediator:onRegister()
	super.onRegister(self)
end

function ArenaBoxMediator:setupView(data)
	super.setupView(self, data)

	local rewardId = data.rewardId
	local hasGet = data.hasGet
	local desc = data.desc
	local rewards = RewardSystem:getRewardsById(rewardId)

	if rewards then
		self:addRewardIcons(rewards)
	end

	self._sureBtn:setVisible(not hasGet)
	self._hasReceivedImg:setVisible(hasGet)
	self._normalBoxInfo:setVisible(true)

	local descLabel = self._normalBoxInfo:getChildByFullName("desc_text")

	descLabel:setString(desc)
end
