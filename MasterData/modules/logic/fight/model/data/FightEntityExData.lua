-- chunkname: @modules/logic/fight/model/data/FightEntityExData.lua

module("modules.logic.fight.model.data.FightEntityExData", package.seeall)

local FightEntityExData = FightDataClass("FightEntityExData")

function FightEntityExData:onConstructor(entityId)
	self.entityId = entityId
	self.entityMo = FightDataHelper.entityMgr:getById(entityId)
	self.modelId = self.entityMo and self.entityMo.modelId
	self.customDefaultEntityInitData = nil
	self.aiUseCardList = {}
	self.scaleOffsetDic = {}
	self.entityClass = nil
	self.entityObjectName = nil
	self.spineUrl = nil
	self.needLookCamera = true
	self.useScaleReplaceSpineScale = false
	self.skin = nil
	self.timelineTempEntitySign = {}
	self.needDispatchPositionChangeEvent = self.modelId and FightEnum.NeedDispatchPosChangeEventHeroIdDict[self.modelId]
end

function FightEntityExData:getCustomDefaultEntityInitData()
	self.customDefaultEntityInitData = self.customDefaultEntityInitData or FightCustomDefaultEntityInitData.New()

	return self.customDefaultEntityInitData
end

return FightEntityExData
