-- chunkname: @modules/logic/gm/view/fight/FightGmNameUIComp.lua

module("modules.logic.gm.view.fight.FightGmNameUIComp", package.seeall)

local FightGmNameUIComp = class("FightGmNameUIComp", LuaCompBase)

function FightGmNameUIComp:ctor(entity)
	self.entity = entity
end

FightGmNameUIComp.GmNameUIPath = "ui/viewres/gm/gmnameui.prefab"
FightGmNameUIComp.SideAnchorY = {
	[FightEnum.EntitySide.MySide] = 93,
	[FightEnum.EntitySide.EnemySide] = 147
}

function FightGmNameUIComp:init(go)
	self.goContainer = go
	self.loaded = false

	loadAbAsset(FightGmNameUIComp.GmNameUIPath, true, self.onLoadDone, self)
end

function FightGmNameUIComp:onLoadDone(assetItem)
	local oldAsstet = self.assetItem

	self.assetItem = assetItem

	self.assetItem:Retain()

	if oldAsstet then
		oldAsstet:Release()
	end

	self.go = gohelper.clone(assetItem:GetResource(), self.goContainer)
	self.labelText = gohelper.findChildText(self.go, "label")
	self.labelText.text = ""

	local side = self.entity:getMO().side

	recthelper.setAnchorY(self.go.transform, FightGmNameUIComp.SideAnchorY[side] or 0)
	self:hide()

	self.loaded = true

	self:_startStatBuffType()
end

function FightGmNameUIComp:show()
	gohelper.setActive(self.go, true)
end

function FightGmNameUIComp:hide()
	gohelper.setActive(self.go, false)
end

function FightGmNameUIComp:startStatBuffType(buffTypeId)
	self.buffTypeId = buffTypeId

	self:_startStatBuffType()
end

function FightGmNameUIComp:_startStatBuffType()
	if not self.loaded then
		return
	end

	if not self.buffTypeId then
		return
	end

	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.refreshLabel, self)
	self:show()
	self:refreshLabel()
end

function FightGmNameUIComp:stopStatBuffType()
	self.buffTypeId = nil

	self:hide()
	self.removeEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.refreshLabel, self)
end

function FightGmNameUIComp:refreshLabel()
	local entityMo = self.entity:getMO()
	local buffList = entityMo:getBuffList()
	local count = 0

	for _, buffMo in ipairs(buffList) do
		local buffCo = buffMo:getCO()

		if buffCo.typeId == self.buffTypeId then
			count = count + 1
		end
	end

	self.labelText.text = string.format("%s : %s", self.buffTypeId, count)
end

function FightGmNameUIComp:onDestroy()
	removeAssetLoadCb(FightGmNameUIComp.GmNameUIPath, self.onLoadDone, self)

	self.entity = nil

	if self.assetItem then
		self.assetItem:Release()
	end
end

return FightGmNameUIComp
