-- chunkname: @modules/logic/sp02/operationactivity/model/AtomicOperationActivityGameTargetMo.lua

module("modules.logic.sp02.operationactivity.model.AtomicOperationActivityGameTargetMo", package.seeall)

local AtomicOperationActivityGameTargetMo = pureTable("AtomicOperationActivityGameTargetMo")

function AtomicOperationActivityGameTargetMo:ctor()
	self.targetId = 0
	self.index = 0
	self.disappearTime = 0
	self.state = 0
	self.config = nil
	self.remainTime = 0
	self.stateTime = 0
	self.hitCD = 0
	self.hitCount = 0
	self.posData = nil
	self.hitRadius = 0
end

function AtomicOperationActivityGameTargetMo:updateMo(targetId, index)
	local config = AtomicOperationActivityConfig.instance:getTargetConfig(targetId)

	self.targetId = targetId
	self.index = index
	self.config = config
	self.hitCD = 0
	self.hitCount = 0

	if not config then
		logError("不存在的敌人 id:" .. tostring(targetId))
	end

	if config then
		if not config.hitRadius then
			local radius = AtomicOperationActivityEnum.DefaultHitRadius

			self.hitRadius = radius * radius
		end
	end
end

return AtomicOperationActivityGameTargetMo
