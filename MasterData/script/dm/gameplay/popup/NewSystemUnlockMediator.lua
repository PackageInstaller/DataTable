-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/popup/NewSystemUnlockMediator.lua

NewSystemUnlockMediator = class("NewSystemUnlockMediator", DmPopupViewMediator, _M)

function NewSystemUnlockMediator:initialize()
	super.initialize(self)
end

function NewSystemUnlockMediator:dispose()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("exit_newsystem_view")
	super.dispose(self)
end

function NewSystemUnlockMediator:onRemove()
	super.onRemove(self)
end

function NewSystemUnlockMediator:onRegister()
	super.onRegister(self)
end

function NewSystemUnlockMediator:userInject()
	return
end

function NewSystemUnlockMediator:enterWithData(data)
	self._targetPos = data.targetPos
	self._systemData = data.systemData
	self._type = data.type
	self._touchSta = false
	self._clearSta = data.clearSta or 1

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self:getView():setContentSize(winSize)
	self:initAnim()
end

function NewSystemUnlockMediator:ShowAnim()
	self._main = self:getView():getChildByName("main")
	self._bg = self._main:getChildByName("bg")

	self._bg:setLocalZOrder(101)
	self._bg:setOpacity(0)

	self._iconNode = self._main:getChildByName("systemIcon")

	self._iconNode:setLocalZOrder(102)
	self._iconNode:removeChildByTag(4001, true)

	local icon = cc.Sprite:create("asset/ui/unlock/" .. self._systemData.Icon)

	icon:addTo(self._iconNode, 101):center(self._iconNode:getContentSize())
	icon:setTag(4001)
	self._iconNode:setScale(1.6)
	self._iconNode:setOpacity(0)

	self._plist = self._iconNode:getChildByName("Particle_1")

	self._plist:setVisible(false)
	self._plist:setPositionType(0)
end

function NewSystemUnlockMediator:initAnim()
	AudioEngine:getInstance():playEffect("Se_Alert_New_System", false)

	local anim = cc.MovieClip:create("xingongnengkaiqi_xingongnengkaiqi")

	anim:setPlaySpeed(1.5)
	anim:setPosition(cc.p(568, 320))
	anim:addTo(self:getView(), -1)
	anim:addEndCallback(function()
		anim:stop()
	end)
	anim:addCallbackAtFrame(20, function()
		local sysNameStr = Strings:get(self._systemData.Name)
		local sysNameText = ccui.Text:create(sysNameStr, TTF_FONT_FZYH_M, 26)

		sysNameText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
		sysNameText:addTo(anim)
		sysNameText:setPosition(cc.p(5, -44))
	end)

	self._anim = anim
	self._targetNode = self._anim:getChildByName("node")
end

function NewSystemUnlockMediator:moveIcon()
	local plist = self:getView():getChildByName("Particle_1")

	plist:setVisible(true)
	plist:setPositionType(0)
	plist:setPosition(cc.p(568, 320))
	self._targetNode:changeParent(plist)
	self._targetNode:setScale(0.25)
	self._targetNode:setPosition(cc.p(0, 0))
	self._anim:removeFromParent(true)

	local winSize = cc.Director:getInstance():getWinSize()
	local endPos = self._targetPos
	local pos = self:getView():convertToNodeSpace(endPos)
	local k = (winSize.width / 2 - pos.x) / (winSize.height / 2 - pos.y)

	plist:setRotation(360 + math.atan(k) * (180 / math.pi))

	local time = math.sqrt(math.pow(winSize.width / 2 - pos.x, 2) + math.pow(winSize.height / 2 - pos.y, 2))
	local moveAct = cc.MoveTo:create(time * 0.00065, pos)
	local delayTime = cc.DelayTime:create(0.01)
	local callFunc = cc.CallFunc:create(function()
		if self._clearSta == 1 then
			local systemKeeper = self:getInjector():getInstance(SystemKeeper)

			systemKeeper:clearCacheSystem(self._type)
		end

		local closeMc = cc.MovieClip:create("donghua_baodian_gongnengkaiqi")

		closeMc:addTo(plist)
		closeMc:addCallbackAtFrame(15, function()
			closeMc:stop()
			self:close()
		end)
	end)

	plist:runAction(cc.Sequence:create(moveAct, delayTime, callFunc))
end

function NewSystemUnlockMediator:onTouchMaskLayer()
	if self._touchSta then
		return
	end

	self._touchSta = true

	self:moveIcon()
end
