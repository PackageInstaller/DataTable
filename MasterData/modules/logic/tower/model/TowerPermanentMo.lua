-- chunkname: @modules/logic/tower/model/TowerPermanentMo.lua

module("modules.logic.tower.model.TowerPermanentMo", package.seeall)

local TowerPermanentMo = pureTable("TowerPermanentMo")

function TowerPermanentMo:init(stage, configList)
	self.ItemType = 1
	self.stage = stage
	self.configList = configList
end

function TowerPermanentMo:reInit()
	return
end

function TowerPermanentMo:getIsUnFold()
	return self.isUnFold
end

function TowerPermanentMo:setIsUnFold(isUnFold)
	self.isUnFold = isUnFold
end

function TowerPermanentMo:getAltitudeHeight(isUnFold)
	local itemCount = tabletool.len(self.configList)

	if isUnFold then
		return itemCount * TowerEnum.PermanentUI.SingleItemH + (itemCount - 1) * TowerEnum.PermanentUI.ItemSpaceH
	end

	return 0
end

function TowerPermanentMo:getStageHeight(isUnFold)
	if self.curUnFoldingH then
		return TowerEnum.PermanentUI.StageTitleH + self.curUnFoldingH
	end

	if tabletool.len(self.configList) == 0 then
		return TowerEnum.PermanentUI.LockTipH
	end

	return TowerEnum.PermanentUI.StageTitleH + self:getAltitudeHeight(isUnFold)
end

function TowerPermanentMo:overrideStageHeight(value)
	self.curUnFoldingH = value
end

function TowerPermanentMo:cleanCurUnFoldingH()
	self.curUnFoldingH = nil
end

function TowerPermanentMo:checkIsOnline()
	return TowerPermanentModel.instance:checkStageIsOnline(self.stage)
end

return TowerPermanentMo
