-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetEquipTipsView.lua

module("logic.extensions.equipment.view.PetEquipTipsView", package.seeall)

local PetEquipTipsView = class("PetEquipTipsView", ViewComponent)

function PetEquipTipsView:ctor()
	PetEquipTipsView.super.ctor(self)

	self.titleName = lang("text_equip_desc_71")
	self.viewDes = ""
	self.sureClick = nil
	self.sureName = lang("mail_confirm")
	self.cancelClick = nil
	self.cancelName = lang("mail_cancel")
end

function PetEquipTipsView:onExitFinished()
	PetEquipTipsView.super.onExitFinished(self)
end

function PetEquipTipsView:onEnterFinished()
	PetEquipTipsView.super.onEnterFinished(self)
end

function PetEquipTipsView:buildUI()
	PetEquipTipsView.super.buildUI(self)

	local bgGo = self:getGo("viewBg")

	self.titleShowTxt = goutil.findChildTextComponent(bgGo, "titleShowTxt")
	self.showDesTxt = goutil.findChildTextComponent(bgGo, "showDesTxt")
	self.cancelBtn = Framework.ButtonAdapter.GetFrom(bgGo, "cancelBtn")
	self.cancelTxt = goutil.findChildTextComponent(bgGo, "cancelBtn/cancelTxt")
	self.sureBtn = Framework.ButtonAdapter.GetFrom(bgGo, "sureBtn")
	self.sureTxt = goutil.findChildTextComponent(bgGo, "sureBtn/sureTxt")
end

function PetEquipTipsView:bindEvents()
	PetEquipTipsView.super.bindEvents(self)
	self.cancelBtn:AddClickListener(function()
		self:close()

		if self.cancelClick then
			self.cancelClick()
		end
	end, self)
	self.sureBtn:AddClickListener(function()
		print("sr_ PetEquipTipsView:bindEvents()  确定换装")
		self:close()

		if self.sureClick then
			self.sureClick()
		end
	end, self)
end

function PetEquipTipsView:onEnter()
	local param = self._viewPresentor._openParam

	if param then
		self.titleName = param[1] or lang("text_equip_desc_71")
		self.viewDes = param[2] or ""
		self.sureClick = param[3]
		self.cancelClick = param[4]
		self.sureName = param[5] or lang("mail_confirm")
		self.cancelName = param[6] or lang("mail_cancel")
	end

	self.titleShowTxt.text = self.titleName
	self.showDesTxt.text = self.viewDes
	self.sureTxt.text = self.sureName
	self.cancelTxt.text = self.cancelName
end

function PetEquipTipsView:unbindEvents()
	PetEquipTipsView.super.unbindEvents(self)
	self.cancelBtn:RemoveClickListener()
	self.sureBtn:RemoveClickListener()
end

function PetEquipTipsView:onExit()
	return
end

function PetEquipTipsView:destroyUI()
	PetEquipTipsView.super.destroyUI(self)
end

return PetEquipTipsView
