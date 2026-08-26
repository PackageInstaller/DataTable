-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/work/YaXianInteractMoveWork.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.work.YaXianInteractMoveWork", package.seeall)

local YaXianInteractMoveWork = class("YaXianInteractMoveWork", BaseWork)

function YaXianInteractMoveWork:ctor(paramDict)
	self.transform = paramDict.transform
	self.targetX = paramDict.targetX
	self.targetY = paramDict.targetY
	self.targetZ = paramDict.targetZ
	self.duration = paramDict.duration
	self.isPlayer = paramDict.isPlayer
	self.interactMo = paramDict.interactMo
end

function YaXianInteractMoveWork:onStart()
	if self.isPlayer then
		if self:isPassedWall() then
			AudioMgr.instance:trigger(AudioEnum.YaXian.ThroughWall)
		else
			AudioMgr.instance:trigger(AudioEnum.YaXian.YaXianMove)
		end
	end

	self.tweenId = ZProj.TweenHelper.DOLocalMove(self.transform, self.targetX, self.targetY, self.targetZ, self.duration or YaXianGameEnum.MoveDuration, self.onMoveCompleted, self, nil, EaseType.Linear)
end

function YaXianInteractMoveWork:isPassedWall()
	if not self.isPlayer then
		return false
	end

	if not self.interactMo then
		logError("not found interactMo ... ")

		return false
	end

	local canWalkPos2Dir = YaXianGameModel.instance:getCanWalkPos2Direction()
	local moveDir = canWalkPos2Dir[YaXianGameHelper.getPosHashKey(self.interactMo.posX, self.interactMo.posY)]

	if moveDir then
		local canWaldTargetPos = YaXianGameModel.instance:getCanWalkTargetPosDict()
		local var_3_0

		if canWaldTargetPos then
			::label_3_0::

			var_3_0 = canWaldTargetPos[moveDir] and canWaldTargetPos[moveDir].passedWall
		end

		return var_3_0
	end

	return false
end

function YaXianInteractMoveWork:onMoveCompleted()
	self:onDone(true)
end

function YaXianInteractMoveWork:clearWork()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

return YaXianInteractMoveWork
