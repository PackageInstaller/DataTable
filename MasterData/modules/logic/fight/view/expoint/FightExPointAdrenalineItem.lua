-- chunkname: @modules/logic/fight/view/expoint/FightExPointAdrenalineItem.lua

module("modules.logic.fight.view.expoint.FightExPointAdrenalineItem", package.seeall)

local FightExPointAdrenalineItem = class("FightExPointAdrenalineItem", UserDataDispose)

function FightExPointAdrenalineItem:init(goItem)
	self:__onInit()

	self.goItem = goItem
	self.animator = self.goItem:GetComponent(gohelper.Type_Animator)
end

function FightExPointAdrenalineItem:refresh(index, light)
	self.index = index

	if light then
		self.animator:Play("open", 0, 1)
	else
		self.animator:Play("close", 0, 1)
	end
end

function FightExPointAdrenalineItem:setActive(active)
	gohelper.setActive(self.goItem, active)
end

function FightExPointAdrenalineItem:playAnim(animName)
	self.animator:Play(animName, 0, 0)
end

function FightExPointAdrenalineItem:dispose()
	self:__onDispose()
end

return FightExPointAdrenalineItem
