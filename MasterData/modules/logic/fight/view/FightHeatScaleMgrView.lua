-- chunkname: @modules/logic/fight/view/FightHeatScaleMgrView.lua

module("modules.logic.fight.view.FightHeatScaleMgrView", package.seeall)

local FightHeatScaleMgrView = class("FightHeatScaleMgrView", FightBaseView)

function FightHeatScaleMgrView:onConstructor(teamType)
	self.teamType = teamType
	self.curType = nil
end

local Type2ViewRes = {
	[FightEnum.HeatScaleType.Normal] = "ui/viewres/fight/fight_burngem_normal.prefab",
	[FightEnum.HeatScaleType.BLE] = "ui/viewres/fight/fight_burngem_beilier.prefab"
}
local Type2View = {
	[FightEnum.HeatScaleType.Normal] = FightHeatScaleView,
	[FightEnum.HeatScaleType.BLE] = FightHeatScaleView_BLE
}

function FightHeatScaleMgrView:addEvents()
	self:com_registFightEvent(FightEvent.Crystal_ValueChange, self.onCrystalValueChange)
end

function FightHeatScaleMgrView:onCrystalValueChange()
	self:refreshView()
end

function FightHeatScaleMgrView:onOpen()
	self:refreshView()
end

function FightHeatScaleMgrView:getType()
	local heatScale = FightDataHelper.getHeatScale(self.teamType)
	local hasCrystal = heatScale:hasCrystal()

	if hasCrystal then
		return FightEnum.HeatScaleType.BLE
	else
		return FightEnum.HeatScaleType.Normal
	end
end

function FightHeatScaleMgrView:refreshView()
	local type = self:getType()

	if type == self.curType then
		return
	end

	self.curType = type

	self:createViewByType()
end

function FightHeatScaleMgrView:createViewByType()
	self:clearLoader()
	self:clearView()

	self.loader = MultiAbLoader.New()

	self.loader:addPath(Type2ViewRes[self.curType])
	self.loader:startLoad(self.onLoadViewDone, self)
end

function FightHeatScaleMgrView:onLoadViewDone(loader)
	local assetItem = self.loader:getFirstAssetItem()
	local prefab = assetItem:GetResource()
	local parentRoot = self.viewContainer.rightBottomElementLayoutView:getElementContainer(FightRightBottomElementEnum.Elements.HeatScale)

	self.viewContainer.rightBottomElementLayoutView:showElement(FightRightBottomElementEnum.Elements.HeatScale)

	local viewGo = gohelper.clone(prefab, parentRoot)

	self.view = Type2View[self.curType].New()

	self.view:initView(viewGo, self.teamType)
	self.view:addEvents()
	self.view:onOpen()
end

function FightHeatScaleMgrView:clearView()
	if self.view then
		self.view:destroy()

		self.view = nil
	end
end

function FightHeatScaleMgrView:clearLoader()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

function FightHeatScaleMgrView:onDestroyView()
	self:clearLoader()
	self:clearView()
end

return FightHeatScaleMgrView
