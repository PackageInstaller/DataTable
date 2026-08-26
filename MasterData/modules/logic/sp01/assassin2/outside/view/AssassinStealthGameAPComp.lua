-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameAPComp.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameAPComp", package.seeall)

local AssassinStealthGameAPComp = class("AssassinStealthGameAPComp", LuaCompBase)

function AssassinStealthGameAPComp:init(go)
	self.go = go
	self._goapItem = gohelper.findChild(self.go, "#go_apItem")

	gohelper.setActive(self._goapItem, false)
end

function AssassinStealthGameAPComp:addEventListeners()
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnHeroMove, self._onHeroMove, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnHeroUpdate, self._onHeroUpdate, self)
	self.addEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnBeginNewRound, self._onBeginNewRound, self)
end

function AssassinStealthGameAPComp:removeEventListeners()
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnHeroMove, self._onHeroMove, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnHeroUpdate, self._onHeroUpdate, self)
	self.removeEventCb(self, AssassinStealthGameController.instance, AssassinEvent.OnBeginNewRound, self._onBeginNewRound, self)
end

function AssassinStealthGameAPComp:_onHeroMove()
	self:refreshHeroApUsed(true)
end

function AssassinStealthGameAPComp:_onHeroUpdate(updateHeroUidDict)
	if not self._heroUid then
		return
	end

	if not updateHeroUidDict or updateHeroUidDict and updateHeroUidDict[self._heroUid] then
		self:refreshHeroApUsed(true)
	end
end

function AssassinStealthGameAPComp:_onBeginNewRound()
	if not self._heroUid then
		return
	end

	self:setHeroAp()
end

function AssassinStealthGameAPComp:setHeroUid(uid)
	self._heroUid = uid

	self:setHeroAp(true)
end

function AssassinStealthGameAPComp:setHeroAp(forceSet)
	if not self._heroUid then
		return
	end

	local gameHeroMo = AssassinStealthGameModel.instance:getHeroMo(self._heroUid, true)
	local maxAp = gameHeroMo:getMaxActionPoint()

	if forceSet or not self._apItemList or #self._apItemList ~= maxAp then
		self:setAPCount(maxAp)
		self:refreshHeroApUsed()
	else
		self:refreshHeroApUsed(true)
	end
end

function AssassinStealthGameAPComp:setAPCount(count)
	if not count or count <= 0 then
		gohelper.setActive(self.go, false)

		return
	end

	self._apItemList = {}

	local allApList = {}

	for i = 1, count do
		allApList[#allApList + 1] = i
	end

	gohelper.CreateObjList(self, self._onCreateApItem, allApList, self._go, self._goapItem)
	gohelper.setActive(self.go, true)
end

function AssassinStealthGameAPComp:_onCreateApItem(obj, data, index)
	local apItem = self:getUserDataTb_()

	apItem.go = obj
	apItem.goempty = gohelper.findChild(apItem.go, "#go_normal")
	apItem.gocanuse = gohelper.findChild(apItem.go, "#go_used")
	apItem.animator = apItem.gocanuse:GetComponent(typeof(UnityEngine.Animator))
	apItem.canUse = true

	gohelper.setActive(apItem.goempty, true)
	gohelper.setActive(apItem.gocanuse, true)

	if apItem.animator then
		apItem.animator:Play("open", 0, 1)
	end

	self._apItemList[index] = apItem
end

function AssassinStealthGameAPComp:refreshHeroApUsed(playAnim)
	if not self._heroUid then
		return
	end

	local gameHeroMo = AssassinStealthGameModel.instance:getHeroMo(self._heroUid, true)
	local curAp = gameHeroMo:getActionPoint()

	for index, apItem in ipairs(self._apItemList) do
		local canUse = index <= curAp

		if canUse ~= apItem.canUse then
			local animName = canUse and "open" or "close"

			if playAnim then
				apItem.animator:Play(animName)
			else
				apItem.animator:Play(animName, 0, 1)
			end

			apItem.canUse = canUse
		end
	end
end

function AssassinStealthGameAPComp:onDestroy()
	self._heroUid = nil
end

return AssassinStealthGameAPComp
