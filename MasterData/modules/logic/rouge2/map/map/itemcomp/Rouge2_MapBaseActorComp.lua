-- chunkname: @modules/logic/rouge2/map/map/itemcomp/Rouge2_MapBaseActorComp.lua

module("modules.logic.rouge2.map.map.itemcomp.Rouge2_MapBaseActorComp", package.seeall)

local Rouge2_MapBaseActorComp = class("Rouge2_MapBaseActorComp", UserDataDispose)

function Rouge2_MapBaseActorComp:init(go, map)
	self:__onInit()

	self.map = map
	self.goActor = go
	self.goModel = gohelper.findChild(self.goActor, "actor")

	self:initActor()
end

function Rouge2_MapBaseActorComp:initActor()
	self.trActor = self.goActor.transform

	local x, y = self.map:getActorPos()

	transformhelper.setLocalPos(self.trActor, x, y, Rouge2_MapHelper.getOffsetZ(y))
end

function Rouge2_MapBaseActorComp:getActorWordPos()
	return self.trActor.position
end

function Rouge2_MapBaseActorComp:moveToMapItem(id, callback, callbackObj)
	logNormal("base move to map item")
end

function Rouge2_MapBaseActorComp:moveToPieceItem(pieceMo, callback, callbackObj)
	logNormal("base move to piece item")
end

function Rouge2_MapBaseActorComp:onMovingDone()
	self:endBlock()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.EndMoveActor)

	self.movingTweenId = nil

	if self.callback then
		self.callback(self.callbackObj)
	end

	self.callback = nil
	self.callbackObj = nil

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onActorMovingDone)
end

function Rouge2_MapBaseActorComp:startBlock()
	UIBlockMgr.instance:startBlock(Rouge2_MapEnum.MovingBlock)
	UIBlockMgrExtend.setNeedCircleMv(false)
end

function Rouge2_MapBaseActorComp:endBlock()
	UIBlockMgr.instance:endBlock(Rouge2_MapEnum.MovingBlock)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function Rouge2_MapBaseActorComp:clearTween()
	if self.movingTweenId then
		ZProj.TweenHelper.KillById(self.movingTweenId)

		self.movingTweenId = nil
	end
end

function Rouge2_MapBaseActorComp:destroy()
	self:endBlock()

	self.callback = nil
	self.callbackObj = nil

	self:clearTween()
	self:__onDispose()
end

return Rouge2_MapBaseActorComp
