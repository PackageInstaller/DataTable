-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogTaskView.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogTaskView", package.seeall)

local AergusiDialogTaskView = class("AergusiDialogTaskView", BaseView)

function AergusiDialogTaskView:onInitView()
	self._gotask = gohelper.findChild(self.viewGO, "#go_task")
	self._gotarget1 = gohelper.findChild(self.viewGO, "#go_task/TargetList/#go_target1")
	self._txttarget1desc = gohelper.findChildText(self.viewGO, "#go_task/TargetList/#go_target1/#txt_target1desc")
	self._gotarget2 = gohelper.findChild(self.viewGO, "#go_task/TargetList/#go_target2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AergusiDialogTaskView:addEvents()
	return
end

function AergusiDialogTaskView:removeEvents()
	return
end

function AergusiDialogTaskView:_editableInitView()
	self._taskItems = {}

	self:_addEvents()
end

function AergusiDialogTaskView:onOpen()
	gohelper.setActive(self._gotarget1, false)
	gohelper.setActive(self._gotarget2, false)
end

function AergusiDialogTaskView:showTaskItems()
	local curGroupId = AergusiDialogModel.instance:getCurDialogGroup()
	local groupConfig = AergusiConfig.instance:getEvidenceConfig(curGroupId)

	gohelper.setActive(self._gotarget1, false)

	if LuaUtil.getStrLen(groupConfig.puzzleTxt) ~= 0 then
		gohelper.setActive(self._gotarget1, true)

		self._txttarget1desc.text = groupConfig.puzzleTxt
	end

	for _, v in pairs(self._taskItems) do
		v:hide()
	end

	local targetList = AergusiDialogModel.instance:getTargetGroupList()

	for i = #targetList, 1, -1 do
		if not self._taskItems[i] then
			local item = AergusiDialogTaskItem.New()
			local go = gohelper.cloneInPlace(self._gotarget2, "target" .. i)

			item:init(go, i)

			self._taskItems[i] = item
		end

		self._taskItems[i]:setCo(targetList[i])
		self._taskItems[i]:refreshItem()
	end
end

function AergusiDialogTaskView:onClose()
	return
end

function AergusiDialogTaskView:_addEvents()
	self.addEventCb(self, AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, self._onShowDialogGroupFinished, self)
	self.addEventCb(self, AergusiController.instance, AergusiEvent.OnStartDialogGroup, self._onStartDialogGroup, self)
end

function AergusiDialogTaskView:_removeEvents()
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, self._onShowDialogGroupFinished, self)
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.OnStartDialogGroup, self._onStartDialogGroup, self)
end

function AergusiDialogTaskView:_onShowDialogGroupFinished()
	self:showTaskItems()
	AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideShowTask)
end

function AergusiDialogTaskView:_onStartDialogGroup()
	for _, v in pairs(self._taskItems) do
		v:refreshItem()
	end
end

function AergusiDialogTaskView:onDestroyView()
	self:_removeEvents()

	if self._taskItems then
		for _, v in pairs(self._taskItems) do
			v:destroy()
		end

		self._taskItems = nil
	end
end

return AergusiDialogTaskView
