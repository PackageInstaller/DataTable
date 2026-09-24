-- chunkname: @modules/logic/fight/entity/comp/FightNameUIDeLeiKeSliderMgr.lua

module("modules.logic.fight.entity.comp.FightNameUIDeLeiKeSliderMgr", package.seeall)

local FightNameUIDeLeiKeSliderMgr = class("FightNameUIDeLeiKeSliderMgr", FightBaseClass)

function FightNameUIDeLeiKeSliderMgr:onConstructor(entity, viewGO)
	self.entity = entity
	self.entityData = entity.entityData
	self.viewGO = viewGO
	self.deLeiKeSlider = gohelper.findChild(viewGO, "layout/go_deleike")
	self.buffDic = {}

	self:checkWhenInit()
	self:com_registMsg(FightMsgId.OnAddBuff, self.onAddBuff)
end

function FightNameUIDeLeiKeSliderMgr:onAddBuff(buffData)
	if buffData.buffId ~= 31580002 then
		return
	end

	if buffData.entityId ~= self.entityData.id then
		return
	end

	if self.buffDic[buffData.uid] then
		return
	end

	gohelper.setActive(self.deLeiKeSlider, true)

	self.buffDic[buffData.uid] = true

	local url = "ui/viewres/fight/fightdeleikeslider.prefab"

	self:com_loadAsset(url, self.onAssetLoaded, buffData)
end

function FightNameUIDeLeiKeSliderMgr:onAssetLoaded(success, assetItem, buffData)
	if not success then
		return
	end

	local resObj = assetItem:GetResource()
	local obj = gohelper.clone(resObj, self.deLeiKeSlider)

	self.obj = obj

	self:newClass(FightNameUIDeLeiKeSliderItem, obj, self.entityData, buffData)
end

function FightNameUIDeLeiKeSliderMgr:checkWhenInit()
	local buffDic = self.entityData.buffDic

	for k, buffData in pairs(buffDic) do
		if buffData.buffId == 31580002 then
			self:onAddBuff(buffData)

			return
		end
	end
end

function FightNameUIDeLeiKeSliderMgr:onDestructor()
	if self.obj then
		gohelper.destroy(self.obj)

		self.obj = nil
	end
end

return FightNameUIDeLeiKeSliderMgr
