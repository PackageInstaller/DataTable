-- chunkname: @modules/logic/gm/view/GMRougeTool.lua

module("modules.logic.gm.view.GMRougeTool", package.seeall)

local GMRougeTool = class("GMRougeTool", BaseView)

function GMRougeTool:onInitView()
	self.btnRougeMapEditor = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/rouMap/btnRougeMapEditor")
	self.btnEnterTestMap = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/rouMap/btnEnterTestMap")
	self.showAreaToggle = gohelper.findChildToggle(self.viewGO, "viewport/content/rouMap1/showNodeClickAreaToggle")
	self.btnEditPathSelectMap = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/rouMap1/btnEditPathSelectMap")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GMRougeTool:_editableInitView()
	self.showAreaToggle.isOn = RougeEditorController.instance:getIsShowing()
end

function GMRougeTool:addEvents()
	self.btnRougeMapEditor:AddClickListener(self.onClickRougeMapEditor, self)
	self.btnEnterTestMap:AddClickListener(self.onClickEnterTestMap, self)
	self.showAreaToggle:AddOnValueChanged(self.onToggleValueChanged, self)

	if self.btnEditPathSelectMap then
		self.btnEditPathSelectMap:AddClickListener(self.onClickRougeSelectMapEditor, self)
	end
end

function GMRougeTool:removeEvents()
	self.btnRougeMapEditor:RemoveClickListener()
	self.btnEnterTestMap:RemoveClickListener()
	self.showAreaToggle:RemoveOnValueChanged()

	if self.btnEditPathSelectMap then
		self.btnEditPathSelectMap:RemoveClickListener()
	end
end

function GMRougeTool:onClickRougeMapEditor()
	RougeEditorController.instance:enterRougeMapEditor()
	self:closeThis()
end

function GMRougeTool:onClickEnterTestMap()
	RougeMapModel.instance.inited = false

	GMRpc.instance:sendGMRequest("rougeMapInitTest 1", self.onReceiveRpc, self)
end

function GMRougeTool:onReceiveRpc()
	RougeEditorController.instance:enterRougeTestMap()
	self:closeThis()
end

function GMRougeTool:onToggleValueChanged()
	if self.showAreaToggle.isOn then
		RougeEditorController.instance:showNodeClickArea()
	else
		RougeEditorController.instance:hideNodeClickArea()
	end
end

function GMRougeTool:onClickRougeSelectMapEditor()
	RougeEditorController.instance:enterPathSelectMapEditorView()
	self:closeThis()
end

function GMRougeTool:onOpen()
	return
end

function GMRougeTool:onClose()
	return
end

function GMRougeTool:onDestroyView()
	return
end

return GMRougeTool
