-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessHandbookMutationItem.lua

module("modules.logic.autochess.main.view.comp.AutoChessHandbookMutationItem", package.seeall)

local AutoChessHandbookMutationItem = class("AutoChessHandbookMutationItem", ListScrollCell)

function AutoChessHandbookMutationItem:init(go)
	self.go = go
	self.txtName = gohelper.findChildText(go, "namebg/txt_Name")
	self.txtDesc = gohelper.findChildText(go, "txt_Desc")
	self.simageMutation = gohelper.findChildSingleImage(go, "simage_Mutation")
end

function AutoChessHandbookMutationItem:onUpdateMO(config)
	self.txtName.text = config.name
	self.txtDesc.text = config.desc

	self.simageMutation:LoadImage(ResUrl.getAutoChessIcon(config.icon, "adventure"))
end

return AutoChessHandbookMutationItem
