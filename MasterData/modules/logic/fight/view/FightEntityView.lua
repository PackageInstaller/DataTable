-- chunkname: @modules/logic/fight/view/FightEntityView.lua

module("modules.logic.fight.view.FightEntityView", package.seeall)

local FightEntityView = class("FightEntityView", FightBaseClass)

function FightEntityView:onConstructor(entityId, fightNameObj)
	self.entityId = entityId
	self.entityData = FightDataHelper.entityMgr:getById(entityId)
	self.fightNameObj = fightNameObj
	self.viewComp = self:addComponent(FightViewComponent)
end

function FightEntityView:onLogicEnter()
	self:showEnemyAiUseCardView()
end

function FightEntityView:showEnemyAiUseCardView()
	local root = gohelper.findChild(self.fightNameObj, "layout/top/op")

	if self.entityData:isEnemySide() then
		self.viewComp:openSubView(FightEnemyEntityAiUseCardView, root, nil, self.entityData)
	else
		gohelper.setActive(root, false)
	end
end

function FightEntityView:onDestructor()
	return
end

return FightEntityView
