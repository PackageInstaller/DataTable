-- chunkname: @modules/logic/dialogue/view/items/DialogueOptionItem.lua

module("modules.logic.dialogue.view.items.DialogueOptionItem", package.seeall)

local DialogueOptionItem = class("DialogueOptionItem", DialogueItem)

function DialogueOptionItem:initView()
	self.goOptionItem = gohelper.findChild(self.go, "#go_suboptionitem")

	gohelper.setActive(self.goOptionItem, false)

	self.optionList = GameUtil.splitString2(self.stepCo.content, false)
	self.optionItemList = {}
	self.handled = false
end

function DialogueOptionItem:refresh()
	for _, option in ipairs(self.optionList) do
		self:createOption(option[1], tonumber(option[2]))
	end
end

function DialogueOptionItem:createOption(content, jumpStepId)
	local optionItem = self:getUserDataTb_()

	optionItem.go = gohelper.cloneInPlace(self.goOptionItem)
	optionItem.btn = gohelper.findChildButton(optionItem.go, "#btn_suboption")
	optionItem.txtOption = gohelper.findChildText(optionItem.go, "#btn_suboption/#txt_suboption")
	optionItem.txtOption.text = content
	optionItem.goBtn = optionItem.btn.gameObject

	optionItem.btn:AddClickListener(self.onClickOption, self, jumpStepId)

	optionItem.jumpStepId = jumpStepId

	gohelper.setActive(optionItem.go, true)
	table.insert(self.optionItemList, optionItem)
end

function DialogueOptionItem:onClickOption(jumpStepId)
	if self.handled then
		return
	end

	self.handled = true

	for _, optionItem in ipairs(self.optionItemList) do
		ZProj.UGUIHelper.SetGrayscale(optionItem.goBtn, jumpStepId ~= optionItem.jumpStepId)
	end

	DialogueController.instance:dispatchEvent(DialogueEvent.OnClickOption, jumpStepId)
end

function DialogueOptionItem:calculateHeight()
	ZProj.UGUIHelper.RebuildLayout(self.go.transform)

	self.height = recthelper.getHeight(self.go.transform)
end

function DialogueOptionItem:onDestroy()
	for _, optionItem in ipairs(self.optionItemList) do
		optionItem.btn:RemoveClickListener()
	end
end

return DialogueOptionItem
