-- chunkname: @modules/logic/fight/model/data/FightMeiLeiErExRoundDataMgr.lua

module("modules.logic.fight.model.data.FightMeiLeiErExRoundDataMgr", package.seeall)

local FightMeiLeiErExRoundDataMgr = FightDataClass("FightMeiLeiErExRoundDataMgr", FightDataMgrBase)

function FightMeiLeiErExRoundDataMgr:onConstructor()
	self.value = 0
	self.limit = 1000
	self.trigger = 1000
	self.fromId = "0"
end

function FightMeiLeiErExRoundDataMgr:onStageChanged(stage)
	if stage == FightStageMgr.StageType.Operate then
		self:refreshData()
	end
end

function FightMeiLeiErExRoundDataMgr:refreshData()
	self.value = 0

	for k, entityData in pairs(FightDataHelper.entityMgr.entityDataDic) do
		if not entityData:isStatusDead() then
			local buffDic = entityData.buffDic

			for _, buffData in pairs(buffDic) do
				local actInfo = buffData.actInfo

				for i, v in ipairs(actInfo) do
					if v.actId == 1139 then
						local featuresSplit = entityData:getFeaturesSplitInfoByBuffId(buffData.buffId)

						if featuresSplit then
							for _, oneFeature in ipairs(featuresSplit) do
								if oneFeature[1] == 1139 then
									self.trigger = oneFeature[2]
									self.limit = oneFeature[3]
									self.value = v.param[1]
									self.fromId = buffData.entityId

									return
								end
							end
						end
					end
				end
			end
		end
	end
end

return FightMeiLeiErExRoundDataMgr
