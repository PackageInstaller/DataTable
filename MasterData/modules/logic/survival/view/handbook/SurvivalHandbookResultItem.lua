-- chunkname: @modules/logic/survival/view/handbook/SurvivalHandbookResultItem.lua

module("modules.logic.survival.view.handbook.SurvivalHandbookResultItem", package.seeall)

local SurvivalHandbookResultItem = class("SurvivalHandbookResultItem", LuaCompBase)

function SurvivalHandbookResultItem:ctor()
	return
end

function SurvivalHandbookResultItem:init(go)
	self.go = go
	self.animGo = gohelper.findComponentAnim(go)
	self.imgEmpty = gohelper.findChild(go, "#imgEmpty")
	self.simage_ending = gohelper.findChildSingleImage(go, "#normal/#simage_ending")
	self.txt_title = gohelper.findChildTextMesh(go, "#normal/Title/#txt_title")
	self.txt_desc = gohelper.findChildTextMesh(go, "#normal/#txt_desc")
	self.empty = gohelper.findChild(go, "#empty")
	self.normal = gohelper.findChild(go, "#normal")
end

function SurvivalHandbookResultItem:getAnimator()
	return self.animGo
end

function SurvivalHandbookResultItem:onStart()
	return
end

function SurvivalHandbookResultItem:addEventListeners()
	return
end

function SurvivalHandbookResultItem:removeEventListeners()
	return
end

function SurvivalHandbookResultItem:onDestroy()
	return
end

function SurvivalHandbookResultItem:setData(data)
	self.survivalHandbookMo = data.mo

	gohelper.setActive(self.empty, not self.survivalHandbookMo.isUnlock)
	gohelper.setActive(self.normal, self.survivalHandbookMo.isUnlock)

	if self.survivalHandbookMo.isUnlock then
		self.txt_title.text = self.survivalHandbookMo:getResultTitle()
		self.txt_desc.text = self.survivalHandbookMo:getResultDesc()

		self.simage_ending:LoadImage(self.survivalHandbookMo:getResultImage())
	end
end

function SurvivalHandbookResultItem:refresh()
	return
end

return SurvivalHandbookResultItem
