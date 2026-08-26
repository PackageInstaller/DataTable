-- chunkname: @modules/logic/survival/view/shelter/ShelterMapBagView.lua

module("modules.logic.survival.view.shelter.ShelterMapBagView", package.seeall)

local ShelterMapBagView = class("ShelterMapBagView", SurvivalMapBagView)

function ShelterMapBagView:onInitView()
	ShelterMapBagView.super.onInitView(self)

	local goToggle = gohelper.findChild(self.viewGO, "root/toggleGroup")

	gohelper.setActive(goToggle, false)
	gohelper.setActive(self._goheavy, false)
end

function ShelterMapBagView:onOpen()
	ShelterMapBagView.super.onOpen(self)
	self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 1, 2)
end

function ShelterMapBagView:getBag()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	return weekInfo:getBag(SurvivalEnum.ItemSource.Shelter)
end

return ShelterMapBagView
