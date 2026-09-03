-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityEggSuccMediator.lua

ActivityEggSuccMediator = class("ActivityEggSuccMediator", DmPopupViewMediator, _M)

ActivityEggSuccMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {}

function ActivityEggSuccMediator:initialize()
	super.initialize(self)
end

function ActivityEggSuccMediator:dispose()
	super.dispose(self)
end

function ActivityEggSuccMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._animNode = self:getView():getChildByName("animNode")
end

function ActivityEggSuccMediator:enterWithData(data)
	AudioEngine:getInstance():playEffect("Se_Alert_Pop_Rabbit", false)

	self._callback = data.callback
	self._activityId = data.activityId
	self._eggActivity = data.eggActivity

	self:initView()
end

function ActivityEggSuccMediator:initView()
	self._canTouch = 1

	local animName = self._eggActivity:getActivityConfig().TuZiAnim or "tuzi_zacaidan"

	self._eggAnim = cc.MovieClip:create(animName)

	self._eggAnim:addTo(self._animNode):posite(-440, -40)
	self._eggAnim:gotoAndPlay(56)
	self._eggAnim:addCallbackAtFrame(104, function()
		self:close()

		if self._callback then
			self._callback()
		end
	end)
end

function ActivityEggSuccMediator:onTouchMaskLayer()
	if self._canTouch == 1 then
		self._canTouch = 2
	end

	if self._canTouch == 2 then
		self._canTouch = 3

		AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)
		self._eggAnim:gotoAndPlay(99)
	end
end
