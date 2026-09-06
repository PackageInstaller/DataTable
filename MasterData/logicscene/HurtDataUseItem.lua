-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/HurtDataUseItem.lua

module("logicscene.scene.battle.skills.hurts.HurtDataUseItem", package.seeall)

local HurtDataUseItem = class("HurtDataUseItem", HurtDataBase)

function HurtDataUseItem:_onTarget()
	local itemCo = BattleConfig.instance:getBattleItem(self.itemId)

	if itemCo.type == GameEnum.BattleItemType.Ball then
		BattleItemsModel.instance:pushCatchedUnits(self.target)
		self.target:onCatchedSuccess(self.itemId)
	else
		self.target:onItemUseSuccess(self.itemId)
	end
end

function HurtDataUseItem:generateFromCharactorResult(result)
	HurtDataUseItem.super.generateFromCharactorResult(self, result)
end

function HurtDataUseItem:generateFromResultNum(targetNum)
	self:generateBeforeHurtEvtsFromResultNum(targetNum)
	HurtDataUseItem.super.generateFromResultNum(self, targetNum)
	self:generateAfterHurtEvtsFromResultNum(targetNum)
end

function HurtDataUseItem:_onDodge()
	local itemCo = BattleConfig.instance:getBattleItem(self.itemId)

	if itemCo.type == GameEnum.BattleItemType.Ball then
		self.target:onCatchedFailed(self.itemId)
	else
		self.target:onItemUseFailed(self.itemId)
	end
end

function HurtDataUseItem:_generateRecords()
	return
end

return HurtDataUseItem
