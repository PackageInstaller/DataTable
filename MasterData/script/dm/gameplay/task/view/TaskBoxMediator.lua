-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/task/view/TaskBoxMediator.lua

require("dm.gameplay.popup.BaseRewardBoxMediator")

TaskBoxMediator = class("TaskBoxMediator", BaseRewardBoxMediator, _M)

function TaskBoxMediator:initialize()
	super.initialize(self)
end

function TaskBoxMediator:dispose()
	super.dispose(self)
end

function TaskBoxMediator:onRegister()
	super.onRegister(self)
end

function TaskBoxMediator:setupView(data)
	super.setupView(self, data)

	local liveness = data.liveness
	local rewardId = data.rewardId
	local hasGet = data.hasGet
	local descId = data.descId
	local desc = data.desc
	local isRich = data.isRich
	local rewards = RewardSystem:getRewardsById(rewardId)

	if rewards then
		self:addRewardIcons(rewards)
	end

	self._sureBtn:setVisible(not hasGet)
	self._hasReceivedImg:setVisible(hasGet)
	self._normalBoxInfo:setVisible(true)

	local descLabel = self._normalBoxInfo:getChildByFullName("desc_text")

	if isRich then
		descLabel:setString("")

		local richText = ccui.RichText:createWithXML(desc, {})

		richText:setAnchorPoint(descLabel:getAnchorPoint())
		richText:setPosition(cc.p(descLabel:getPosition()))
		richText:addTo(descLabel:getParent())
	else
		local descStr = Strings:get(descId, {
			num = liveness
		})

		descLabel:setString(descStr)
	end
end
