-- chunkname: @modules/logic/survival/view/shelter/ShelterCompositeViewContainer.lua

module("modules.logic.survival.view.shelter.ShelterCompositeViewContainer", package.seeall)

local ShelterCompositeViewContainer = class("ShelterCompositeViewContainer", BaseViewContainer)

function ShelterCompositeViewContainer:buildViews()
	local views = {}

	self.materialView = ShelterCompositeMaterialView.New()
	self.compositeView = ShelterCompositeView.New()

	table.insert(views, self.materialView)
	table.insert(views, self.compositeView)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function ShelterCompositeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			navView
		}
	end
end

function ShelterCompositeViewContainer:showMaterialView(index)
	self.materialView:showMaterialView(index)
end

function ShelterCompositeViewContainer:closeMaterialView()
	self.materialView:closeMaterialView()
end

function ShelterCompositeViewContainer:isSelectItem(slotId, itemMo)
	return self.compositeView:isSelectItem(slotId, itemMo)
end

return ShelterCompositeViewContainer
