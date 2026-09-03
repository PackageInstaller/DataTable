-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityFocusOn.lua

ActivityFocusOn = class("ActivityFocusOn", BaseActivity, _M)

ActivityFocusOn:has("_rewardStates", {
	is = "r"
})

function ActivityFocusOn:initialize()
	super.initialize(self)
end

function ActivityFocusOn:dispose()
	super.dispose(self)
end

function ActivityFocusOn:synchronize(data)
	if not data then
		return
	end

	self._rewardStates = data.rewardStatus

	super.synchronize(self, data)
end

function ActivityFocusOn:getActivityBgImg()
	return self:getConfig().ActivityConfig.BGM
end

function ActivityFocusOn:getActivityDesc1()
	return self:getConfig().ActivityConfig.Desc1
end

function ActivityFocusOn:getActivityDesc2()
	return self:getConfig().ActivityConfig.Desc2
end

function ActivityFocusOn:getActivityReward()
	return self:getConfig().ActivityConfig.reward
end

function ActivityFocusOn:getActivityURL()
	return self:getConfig().ActivityConfig.URL
end

function ActivityFocusOn:getActivityBtnText()
	return self:getConfig().ActivityConfig.ButtonText
end
