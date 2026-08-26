-- chunkname: @modules/logic/box/equiplvup/view/EquipLvUpChooseViewContainer.lua

module("modules.logic.box.equiplvup.view.EquipLvUpChooseViewContainer", package.seeall)

local EquipLvUpChooseViewContainer = class("EquipLvUpChooseViewContainer", BaseViewContainer)

function EquipLvUpChooseViewContainer:buildViews()
	local views = {}

	table.insert(views, EquipLvUpChooseView.New())

	return views
end

return EquipLvUpChooseViewContainer
