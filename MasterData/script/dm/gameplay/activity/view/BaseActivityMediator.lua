-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/BaseActivityMediator.lua

BaseActivityMediator = class("BaseActivityMediator", DmPopupViewMediator, _M)

BaseActivityMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

function BaseActivityMediator:initialize()
	super.initialize(self)
end

function BaseActivityMediator:dispose()
	super.dispose(self)
end

function BaseActivityMediator:onRemove()
	super.onRemove(self)
end

function BaseActivityMediator:onRegister()
	super.onRegister(self)
end

function BaseActivityMediator:userInject()
	return
end

function BaseActivityMediator:setupView(data)
	return
end

function BaseActivityMediator:refreshView(data)
	return
end

function BaseActivityMediator:showRewardView(response, data)
	self:refreshView(data)

	local rewards = response.reward

	if rewards then
		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			rewards = rewards
		}, delegate))
	end
end
