-- chunkname: @modules/logic/fight/entity/comp/FightNameUIYaMiShieldSliderMgr.lua

module("modules.logic.fight.entity.comp.FightNameUIYaMiShieldSliderMgr", package.seeall)

local FightNameUIYaMiShieldSliderMgr = class("FightNameUIYaMiShieldSliderMgr", FightBaseClass)

function FightNameUIYaMiShieldSliderMgr:onConstructor(entity, viewGO)
	self.entity = entity
	self.entityData = entity.entityData
	self.viewGO = viewGO
	self.yamiSlider = gohelper.findChild(viewGO, "layout/hp/container/yami_shield")
	self.buffDic = {}

	self:com_registMsg(FightMsgId.ShowYaMiNameUISlider, self.onShowYaMiNameUISlider)
end

function FightNameUIYaMiShieldSliderMgr:onShowYaMiNameUISlider(entityData, buffData, actInfo)
	if entityData.side ~= self.entityData.side then
		return
	end

	if self.buffDic[buffData.uid] then
		return
	end

	self.buffDic[buffData.uid] = true

	local url = "ui/viewres/fight/fightnameuiyamishieldslider.prefab"
	local param = {
		buffData = buffData,
		actInfo = actInfo
	}

	self:com_loadAsset(url, self.onAssetLoaded, param)
end

function FightNameUIYaMiShieldSliderMgr:onAssetLoaded(success, assetItem, param)
	if not success then
		return
	end

	local resObj = assetItem:GetResource()
	local obj = gohelper.clone(resObj, self.yamiSlider)

	self:newClass(FightNameUIYaMiShieldSliderItem, obj, self.entityData, param.buffData, param.actInfo)
end

return FightNameUIYaMiShieldSliderMgr
