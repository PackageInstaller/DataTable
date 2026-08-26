-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogSystemMessageItem.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogSystemMessageItem", package.seeall)

local AergusiDialogSystemMessageItem = class("AergusiDialogSystemMessageItem", AergusiDialogItem)

function AergusiDialogSystemMessageItem:initView()
	self._txtSystemMessage = gohelper.findChildText(self.go, "#txt_systemmessage")
	self._goline = gohelper.findChild(self.go, "line")
	self._txtSystemMessageGrey = gohelper.findChildText(self.go, "#txt_systemmessage_grey")
	self._golinegrey = gohelper.findChild(self.go, "line_grey")
	self.go.name = string.format("systemmessageitem_%s_%s", self.stepCo.id, self.stepCo.stepId)
end

function AergusiDialogSystemMessageItem:refresh()
	local curGroupId = AergusiDialogModel.instance:getCurDialogGroup()

	gohelper.setActive(self._txtSystemMessage.gameObject, curGroupId == self.stepCo.id)
	gohelper.setActive(self._txtSystemMessageGrey.gameObject, curGroupId ~= self.stepCo.id)
	gohelper.setActive(self._goline, curGroupId == self.stepCo.id)
	gohelper.setActive(self._golinegrey, curGroupId ~= self.stepCo.id)

	if curGroupId == self.stepCo.id then
		self._txtSystemMessage.text = self.stepCo.content
	else
		self._txtSystemMessageGrey.text = self.stepCo.content
	end
end

function AergusiDialogSystemMessageItem:calculateHeight()
	self.height = AergusiEnum.MinHeight[self.type]
end

function AergusiDialogSystemMessageItem:onDestroy()
	return
end

return AergusiDialogSystemMessageItem
