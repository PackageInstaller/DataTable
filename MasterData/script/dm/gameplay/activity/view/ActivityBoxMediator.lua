-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityBoxMediator.lua

require("dm.gameplay.popup.BaseRewardBoxMediator")

ActivityBoxMediator = class("ActivityBoxMediator", BaseRewardBoxMediator, _M)

function ActivityBoxMediator:initialize()
	super.initialize(self)
end

function ActivityBoxMediator:dispose()
	super.dispose(self)
end

function ActivityBoxMediator:onRegister()
	super.onRegister(self)
end

function ActivityBoxMediator:setupView(data)
	super.setupView(self, data)

	local rewardId = data.rewardId
	local hasGet = data.hasGet
	local descStr = data.tips
	local rewards = ConfigReader:getRecordById("Reward", rewardId).Content

	if rewards then
		self:addRewardIcons(rewards)
	end

	self._sureBtn:setVisible(not hasGet)
	self._hasReceivedImg:setVisible(hasGet)
	self._hasReceivedImg:getChildByName("text"):setTextColor(cc.c3b(255, 255, 255))
	self._normalBoxInfo:setVisible(true)

	local descLabel = self._normalBoxInfo:getChildByFullName("desc_text")
	local richText = ccui.RichText:createWithXML(descStr, {})

	richText:setAnchorPoint(descLabel:getAnchorPoint())
	richText:setPosition(cc.p(descLabel:getPosition()))
	richText:addTo(descLabel:getParent())
	descLabel:setVisible(false)
end
