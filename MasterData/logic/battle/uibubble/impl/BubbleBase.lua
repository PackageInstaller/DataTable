-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uibubble/impl/BubbleBase.lua

module("logic.battle.uibubble.impl.BubbleBase", package.seeall)

local BubbleBase = class("BubbleBase", IBattleReusable)
local kBubbleRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.Bubble)

function BubbleBase:ctor()
	local resPath = self:_getBubbleResourcePath()
	local resMgr = BattleMgr.instance:getResourceMgr()
	local mainGO = resMgr:getInst(resPath)

	goutil.addChildToParent(mainGO, kBubbleRoot)

	self.mainGO = mainGO
	self._transform = mainGO.transform
	self._handler = Handler.New()

	self:buildUI()
	self:reuse()
end

function BubbleBase:reuse()
	goutil.setActive(self.mainGO, true)
end

function BubbleBase:reset()
	self._handler:clear()
	self:stopLifeTime()
	self:resetUI()
	goutil.setActive(self.mainGO, false)
	goutil.addChildToParent(self.mainGO, kBubbleRoot)
end

function BubbleBase:destroy()
	self._handler:clear()
	self:stopLifeTime()
	self:destroyUI()
	goutil.destroy(self.mainGO)

	self._transform = nil
	self.mainGO = nil
end

function BubbleBase:buildUI()
	return
end

function BubbleBase:resetUI()
	return
end

function BubbleBase:destroyUI()
	return
end

function BubbleBase:_getBubbleResourcePath()
	return
end

function BubbleBase:getHeight()
	return 0
end

function BubbleBase:getPriority()
	return 0
end

function BubbleBase:setLifeTime(duration)
	Scheduler.addListener(duration, self._onCompoleteBubble, self, false)
end

function BubbleBase:setBubbleContent(value)
	return
end

function BubbleBase:stopLifeTime()
	Scheduler.removeListener(self._onCompoleteBubble, self)
end

function BubbleBase:setFinishListener(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
end

function BubbleBase:setPositionXY(x, y)
	RectTransformUtils.SetAnchoredPosition(self._transform, x, y)
end

function BubbleBase:_onCompoleteBubble()
	self._handler:call(self)
	self:returnSelf()
end

return BubbleBase
