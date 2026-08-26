-- chunkname: @modules/logic/fight/view/FightExPointView.lua

module("modules.logic.fight.view.FightExPointView", package.seeall)

local FightExPointView = class("FightExPointView", FightBaseClass)

function FightExPointView:onConstructor(entityId, fightNameObj)
	self.entityId = entityId
	self.fightNameObj = fightNameObj
	self.containerObj = gohelper.findChild(self.fightNameObj, "expointContainer")
	self.viewComp = self:addComponent(FightViewComponent)
end

local type2Class = {
	[FightEnum.ExPointType.Common] = FightExPointCommonView,
	[FightEnum.ExPointType.Belief] = FightExPointBeliefView,
	[FightEnum.ExPointType.Synchronization] = FightExPointSynchronizationView,
	[FightEnum.ExPointType.Adrenaline] = FightExPointAdrenalineView,
	[FightEnum.ExPointType.DevicePower] = FightExPointDevicePowerView
}
local type2url = {
	[FightEnum.ExPointType.Belief] = "ui/viewres/fight/fight_nuodika_energyview.prefab",
	[FightEnum.ExPointType.Synchronization] = "ui/viewres/fight/fightaijiaoenergeyview.prefab",
	[FightEnum.ExPointType.Adrenaline] = "ui/viewres/fight/fight_expoint_adrenalineview.prefab",
	[FightEnum.ExPointType.DevicePower] = "ui/viewres/fight/fight3_7deviceenergeyview.prefab"
}

function FightExPointView:onLogicEnter()
	self.entityData = FightDataHelper.entityMgr:getById(self.entityId)

	if not self.entityData then
		return
	end

	local exPointType = self.entityData.exPointType

	if exPointType ~= FightEnum.ExPointType.Common then
		local transform = self.containerObj.transform

		for i = 0, transform.childCount - 1 do
			local child = transform:GetChild(i)

			gohelper.setActive(child.gameObject, false)
		end
	end

	local class = type2Class[exPointType]

	if class then
		if not type2url[exPointType] then
			self.viewComp:openSubView(class, type2url[exPointType], self.containerObj, self.entityData)
		end
	end
end

function FightExPointView:onDestructor()
	return
end

return FightExPointView
