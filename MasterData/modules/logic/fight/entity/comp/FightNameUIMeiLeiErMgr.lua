-- chunkname: @modules/logic/fight/entity/comp/FightNameUIMeiLeiErMgr.lua

module("modules.logic.fight.entity.comp.FightNameUIMeiLeiErMgr", package.seeall)

local FightNameUIMeiLeiErMgr = class("FightNameUIMeiLeiErMgr", FightBaseClass)

function FightNameUIMeiLeiErMgr:onConstructor(entity, viewGO)
	self.entity = entity
	self.entityData = entity.entityData
	self.viewGO = viewGO
	self.meiLeiErSlider = gohelper.findChild(viewGO, "layout/go_leimeier")
	self.buffDic = {}

	self:checkWhenInit()
	self:com_registMsg(FightMsgId.OnAddMeiLeiErCharge, self.onAddMeiLeiErSlider)
end

function FightNameUIMeiLeiErMgr:checkWhenInit()
	local buffDic = self.entityData.buffDic

	for k, buffData in pairs(buffDic) do
		local actInfo = buffData.actInfo

		for i, v in ipairs(actInfo) do
			if v.actId == 1139 then
				self:onAddMeiLeiErSlider(buffData, v)

				return
			end
		end
	end
end

function FightNameUIMeiLeiErMgr:onAddMeiLeiErSlider(buffData, actInfo)
	if buffData.entityId ~= self.entity.id then
		return
	end

	if self.buffDic[buffData.uid] then
		return
	end

	self.buffDic[buffData.uid] = true

	local url = "ui/viewres/fight/fightmeileierercharge.prefab"
	local tab = {
		buffData = buffData,
		actInfo = actInfo
	}

	self:com_loadAsset(url, self.onAssetLoaded, tab)
end

function FightNameUIMeiLeiErMgr:onAssetLoaded(success, assetItem, tab)
	if not success then
		return
	end

	local resObj = assetItem:GetResource()
	local obj = gohelper.clone(resObj, self.meiLeiErSlider)

	self:newClass(FightNameUIMeiLeiErSliderItem, obj, self.entityData, tab.buffData, tab.actInfo)
end

return FightNameUIMeiLeiErMgr
