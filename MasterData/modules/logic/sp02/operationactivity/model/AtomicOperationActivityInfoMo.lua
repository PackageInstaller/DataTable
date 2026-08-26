-- chunkname: @modules/logic/sp02/operationactivity/model/AtomicOperationActivityInfoMo.lua

module("modules.logic.sp02.operationactivity.model.AtomicOperationActivityInfoMo", package.seeall)

local AtomicOperationActivityInfoMo = pureTable("AtomicOperationActivityInfoMo")

function AtomicOperationActivityInfoMo:ctor()
	self.actId = 0
	self.progressDic = {}
	self.preparationDic = {}
	self.totalRewardCount = 0
	self.canPreparationDic = {}
end

function AtomicOperationActivityInfoMo:updateInfo(infoNo)
	tabletool.clear(self.preparationDic)
	tabletool.clear(self.progressDic)

	if infoNo.preparationIds and next(infoNo.preparationIds) then
		for _, id in ipairs(infoNo.preparationIds) do
			self.preparationDic[id] = true
		end
	end

	if infoNo.countList and next(infoNo.countList) then
		for _, no in ipairs(infoNo.countList) do
			self.progressDic[no.type] = no.count
		end
	end

	self.totalRewardCount = infoNo.totalRewardCount or 0
end

function AtomicOperationActivityInfoMo:checkPreparation()
	tabletool.clear(self.canPreparationDic)

	local allConfigList = AtomicOperationActivityConfig.instance:getPreparationConfigList()

	for _, config in ipairs(allConfigList) do
		if not self.preparationDic[config.id] and self:isPreparationUnlock(config.id) then
			self.canPreparationDic[config.id] = true
		end
	end
end

function AtomicOperationActivityInfoMo:isPreparationUnlock(id)
	local config = AtomicOperationActivityConfig.instance:getPreparationConfig(id)
	local progress = self.progressDic[config.unlockcond]

	if not progress or progress < config.unlockpara then
		return false
	end

	local preConfig = AtomicOperationActivityConfig.instance:getPreparationConfig(id - 1)

	if preConfig then
		return self.preparationDic[id - 1]
	end

	return true
end

function AtomicOperationActivityInfoMo:isPreparationFixed(id)
	return self.preparationDic[id]
end

function AtomicOperationActivityInfoMo:haveCanActivePreparation()
	return self.canPreparationDic and next(self.canPreparationDic)
end

return AtomicOperationActivityInfoMo
