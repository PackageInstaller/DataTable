-- chunkname: @modules/logic/versionactivity3_3/igor/view/comp/IgorSkillTransferItem.lua

module("modules.logic.versionactivity3_3.igor.view.comp.IgorSkillTransferItem", package.seeall)

local IgorSkillTransferItem = class("IgorSkillTransferItem", IgorSkillBaseItem)

function IgorSkillTransferItem:onInit()
	self.goMask = gohelper.findChild(self.go, "Mask")
	self.imgMask = gohelper.findChildImage(self.go, "Mask/image_SliderFG")
	self.goTips = gohelper.findChild(self.go, "#go_Tips")
	self.goSelect = gohelper.findChild(self.go, "select")
end

function IgorSkillTransferItem:addEventListeners()
	IgorSkillTransferItem.super.addEventListeners(self)
	self.addEventCb(self, IgorController.instance, IgorEvent.OnUseTransferSkill, self.onUseTransferSkill, self)
end

function IgorSkillTransferItem:removeEventListeners()
	IgorSkillTransferItem.super.removeEventListeners(self)
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnUseTransferSkill, self.onUseTransferSkill, self)
end

function IgorSkillTransferItem:onUseTransferSkill()
	self:enterCD()
	gohelper.setActive(self.goTips, false)
	gohelper.setActive(self.goSelect, false)
end

function IgorSkillTransferItem:refreshSkill()
	gohelper.setActive(self.goTips, false)
	gohelper.setActive(self.goSelect, false)
end

function IgorSkillTransferItem:onUseCard()
	AudioMgr.instance:trigger(AudioEnum3_3.Igor.play_ui_transverse_tabs_click)

	if self:isInCD() or not self:isCostEnough() then
		return
	end

	local gameMO = IgorModel.instance:getCurGameMo()

	if not gameMO:getOursideMo():transfer() then
		return
	end

	gohelper.setActive(self.goTips, true)
	gohelper.setActive(self.goSelect, true)
end

function IgorSkillTransferItem:showTips()
	local datas = {}
	local desc = IgorConfig.instance:getConstValue2(IgorEnum.ConstId.TransferTips)
	local attr = string.split(desc, "#")

	table.insert(datas, {
		title = attr[1],
		desc = attr[2]
	})

	local screenPos = recthelper.uiPosToScreenPos(self.transform)
	local offsetX = 400
	local offsetY = 50

	ViewMgr.instance:openView(ViewName.IgorTipsView, {
		list = datas,
		pivot = Vector2(0.5, 0.5),
		screenPos = screenPos,
		offsetX = offsetX,
		offsetY = offsetY
	})
end

return IgorSkillTransferItem
