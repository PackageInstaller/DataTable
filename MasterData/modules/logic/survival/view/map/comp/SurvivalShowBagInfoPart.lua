-- chunkname: @modules/logic/survival/view/map/comp/SurvivalShowBagInfoPart.lua

module("modules.logic.survival.view.map.comp.SurvivalShowBagInfoPart", package.seeall)

local SurvivalShowBagInfoPart = class("SurvivalShowBagInfoPart", SurvivalBagInfoPart)

function SurvivalShowBagInfoPart:_onSelectClick()
	SurvivalShelterChooseEquipListModel.instance:setSelectIdToPos(self.mo.id)
end

function SurvivalShowBagInfoPart:init(go)
	SurvivalShowBagInfoPart.super.init(self, go)

	local frequency = gohelper.findChild(go, "root/#go_info/Frequency")

	gohelper.setActive(frequency, false)
end

function SurvivalShowBagInfoPart:updateBaseInfo()
	SurvivalShowBagInfoPart.super.updateBaseInfo(self)
	gohelper.setActive(self._btnselect, self._showUseBtn)
	self:_refreshUseState()
end

function SurvivalShowBagInfoPart:_onUnEquipClick()
	SurvivalShelterChooseEquipListModel.instance:setSelectIdToPos(nil)
end

function SurvivalShowBagInfoPart:_refreshUseState()
	local id = SurvivalShelterChooseEquipListModel.instance:getSelectIdByPos(1)

	gohelper.setActive(self._btnselect, id == nil or id ~= self.mo.id)
	gohelper.setActive(self._btnunequip, id ~= nil and id == self.mo.id)
end

return SurvivalShowBagInfoPart
