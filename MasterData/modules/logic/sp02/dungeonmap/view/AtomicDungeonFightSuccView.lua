-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonFightSuccView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonFightSuccView", package.seeall)

local AtomicDungeonFightSuccView = class("AtomicDungeonFightSuccView", FightSuccView)

function AtomicDungeonFightSuccView:_loadBonusItems()
	AtomicDungeonFightSuccView.super._loadBonusItems(self)

	local costTalentNum = AtomicModel.instance:getAllUnlockTalentCost()

	self.maxTalentCoinNum = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.AtomicTalentMaxCoinNum, true)
	self.fightResultData = AtomicDungeonModel.instance:getFightResultData()

	if self.fightResultData and #self.fightResultData.bonuseList > 0 then
		local materialDataList = ItemModel.instance:processRPCItemList(self.fightResultData.bonuseList)
		local materialList = LuaUtil.deepCopy(materialDataList)

		for k, material in ipairs(materialList) do
			material.bonusTag = FightEnum.FightBonusTag.NormalBonus

			local curTalentNum = ItemModel.instance:getItemQuantity(material.materilType, material.materilId)

			if curTalentNum + costTalentNum < self.maxTalentCoinNum then
				self:_addNormalItem(material)
			end
		end

		self:checkHadHighRareProp(materialList)
	end
end

return AtomicDungeonFightSuccView
