-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogTaskItem.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogTaskItem", package.seeall)

local AergusiDialogTaskItem = class("AergusiDialogTaskItem", LuaCompBase)

function AergusiDialogTaskItem:init(go, index)
	self.go = go
	self._index = index
	self._groupId = 0
	self._txttarget2desc = gohelper.findChildText(go, "#txt_target2desc")
	self._goTargetFinished = gohelper.findChild(go, "#go_TargetFinished")

	gohelper.setSibling(go, 2)
	self:_addEvents()
end

function AergusiDialogTaskItem:hide()
	gohelper.setActive(self.go, false)
end

function AergusiDialogTaskItem:setCo(groupId)
	self._groupId = groupId
end

function AergusiDialogTaskItem:refreshItem()
	gohelper.setActive(self.go, false)

	local groupCo = AergusiConfig.instance:getEvidenceConfig(self._groupId)

	if LuaUtil.getStrLen(groupCo.conditionStr) == 0 then
		return
	end

	gohelper.setActive(self.go, true)

	local curGroupId = AergusiDialogModel.instance:getCurDialogGroup()

	self._txttarget2desc.text = curGroupId ~= self._groupId and string.format("<s>%s</s>", groupCo.conditionStr) or groupCo.conditionStr

	gohelper.setActive(self._goTargetFinished, curGroupId ~= self._groupId)
end

function AergusiDialogTaskItem:_addEvents()
	return
end

function AergusiDialogTaskItem:_removeEvents()
	return
end

function AergusiDialogTaskItem:destroy()
	self:_removeEvents()
end

return AergusiDialogTaskItem
