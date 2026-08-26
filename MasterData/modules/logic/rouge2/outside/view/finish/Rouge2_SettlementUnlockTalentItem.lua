-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_SettlementUnlockTalentItem.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_SettlementUnlockTalentItem", package.seeall)

local Rouge2_SettlementUnlockTalentItem = class("Rouge2_SettlementUnlockTalentItem", LuaCompBase)

function Rouge2_SettlementUnlockTalentItem:init(go)
	self.go = go
	self._simagetalent = gohelper.findChildSingleImage(self.go, "has/#image_talent")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_SettlementUnlockTalentItem:_editableInitView()
	self._goEmpty = gohelper.findChild(self.go, "empty")
	self._goHas = gohelper.findChild(self.go, "has")
end

function Rouge2_SettlementUnlockTalentItem:setInfo(talentId, scale)
	local haveTalent = talentId > 0

	gohelper.setActive(self._goEmpty, not haveTalent)
	gohelper.setActive(self._goHas, haveTalent)
	gohelper.setActive(self._simagetalent, haveTalent)
	transformhelper.setLocalScale(self.go.transform, scale, scale, 1)

	if haveTalent then
		Rouge2_IconHelper.setTalentIcon(talentId, self._simagetalent)
	end
end

function Rouge2_SettlementUnlockTalentItem:onDestroy()
	return
end

return Rouge2_SettlementUnlockTalentItem
