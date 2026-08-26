-- chunkname: @modules/logic/playercard/view/comp/PlayerCardLayoutItemCardGroup.lua

module("modules.logic.playercard.view.comp.PlayerCardLayoutItemCardGroup", package.seeall)

local PlayerCardLayoutItemCardGroup = class("PlayerCardLayoutItemCardGroup", PlayerCardLayoutItem)

PlayerCardLayoutItemCardGroup.TweenDuration = 0.16

function PlayerCardLayoutItemCardGroup:init(go)
	PlayerCardLayoutItemCardGroup.super.init(self, go)

	self.frameSingle = gohelper.findChild(go, "frame_single")
	self.goSelectSingle = gohelper.findChild(go, "card/select_single")

	gohelper.setActive(self.frame, false)
	gohelper.setActive(self.goSelect, false)
	gohelper.setActive(self.frameSingle, false)
	gohelper.setActive(self.goSelectSingle, false)
end

function PlayerCardLayoutItemCardGroup:setEditMode(isEdit)
	local isSingle = self.cardComp:isSingle()

	if isSingle then
		gohelper.setActive(self.frame, false)
		gohelper.setActive(self.goSelect, false)
		gohelper.setActive(self.frameSingle, isEdit)
		gohelper.setActive(self.goSelectSingle, isEdit)
	else
		gohelper.setActive(self.frame, isEdit)
		gohelper.setActive(self.goSelect, isEdit)
		gohelper.setActive(self.frameSingle, false)
		gohelper.setActive(self.goSelectSingle, false)
	end

	recthelper.setHeight(self.go.transform, isSingle and 137 or 274)

	if isEdit then
		self.animCard:Play("wiggle")
	end
end

return PlayerCardLayoutItemCardGroup
