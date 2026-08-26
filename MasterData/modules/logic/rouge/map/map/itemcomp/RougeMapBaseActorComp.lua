-- chunkname: @modules/logic/rouge/map/map/itemcomp/RougeMapBaseActorComp.lua

module("modules.logic.rouge.map.map.itemcomp.RougeMapBaseActorComp", package.seeall)

local RougeMapBaseActorComp = class("RougeMapBaseActorComp", UserDataDispose)

function RougeMapBaseActorComp:init(go, map)
	self:__onInit()

	self.map = map
	self.goActor = go

	self:initActor()
end

function RougeMapBaseActorComp:initActor()
	self.trActor = self.goActor.transform

	local x, y = self.map:getActorPos()

	transformhelper.setLocalPos(self.trActor, x, y, RougeMapHelper.getOffsetZ(y))
end

function RougeMapBaseActorComp:getActorWordPos()
	return self.trActor.position
end

function RougeMapBaseActorComp:moveToMapItem(id, callback, callbackObj)
	logNormal("base move to map item")
end

function RougeMapBaseActorComp:moveToPieceItem(pieceMo, callback, callbackObj)
	logNormal("base move to piece item")
end

function RougeMapBaseActorComp:onMovingDone()
	self:endBlock()
	AudioMgr.instance:trigger(AudioEnum.UI.StopMoveAudio)

	self.movingTweenId = nil

	if self.callback then
		self.callback(self.callbackObj)
	end

	self.callback = nil
	self.callbackObj = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onActorMovingDone)
end

function RougeMapBaseActorComp:startBlock()
	UIBlockMgr.instance:startBlock(RougeMapEnum.MovingBlock)
	UIBlockMgrExtend.setNeedCircleMv(false)
end

function RougeMapBaseActorComp:endBlock()
	UIBlockMgr.instance:endBlock(RougeMapEnum.MovingBlock)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function RougeMapBaseActorComp:clearTween()
	if self.movingTweenId then
		ZProj.TweenHelper.KillById(self.movingTweenId)

		self.movingTweenId = nil
	end
end

function RougeMapBaseActorComp:destroy()
	self:endBlock()

	self.callback = nil
	self.callbackObj = nil

	self:clearTween()
	self:__onDispose()
end

return RougeMapBaseActorComp
