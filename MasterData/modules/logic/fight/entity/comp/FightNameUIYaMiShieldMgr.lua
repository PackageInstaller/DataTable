-- chunkname: @modules/logic/fight/entity/comp/FightNameUIYaMiShieldMgr.lua

module("modules.logic.fight.entity.comp.FightNameUIYaMiShieldMgr", package.seeall)

local FightNameUIYaMiShieldMgr = class("FightNameUIYaMiShieldMgr", FightBaseClass)

function FightNameUIYaMiShieldMgr:onConstructor(entity, viewGO)
	self:newClass(FightNameUIYaMiShieldSliderMgr, entity, viewGO)

	self.entity = entity
	self.entityData = entity.entityData
	self.viewGO = viewGO
	self.yamiShield = gohelper.findChild(viewGO, "go_yami")
	self.yamiSlider = gohelper.findChild(viewGO, "layout/hp/container/yami_shield")
	self.buffDic = {}

	self:com_registMsg(FightMsgId.OnAddYaMiShield, self.onAddYaMiShield)
	self:checkWhenInit()
end

function FightNameUIYaMiShieldMgr:checkWhenInit()
	local buffDic = self.entityData.buffDic

	for k, buffData in pairs(buffDic) do
		local actInfo = buffData.actInfo

		for i, v in ipairs(actInfo) do
			if v.actId == 1125 then
				self:onAddYaMiShield(buffData)

				return
			end
		end
	end
end

function FightNameUIYaMiShieldMgr:onAddYaMiShield(buffData)
	if buffData.entityId ~= self.entity.id then
		return
	end

	if self.buffDic[buffData.uid] then
		return
	end

	self.buffDic[buffData.uid] = true

	local url = "ui/viewres/fight/fight_yami_shieldview.prefab"

	self:com_loadAsset(url, self.onAssetLoaded, buffData)
end

function FightNameUIYaMiShieldMgr:onAssetLoaded(success, assetItem, buffData)
	if not success then
		return
	end

	local resObj = assetItem:GetResource()
	local obj = gohelper.clone(resObj, self.yamiShield)

	self:newClass(FightNameUIYaMiShieldItem, obj, buffData, self.entityData)
end

return FightNameUIYaMiShieldMgr
