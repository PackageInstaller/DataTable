-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzleCircuitView.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzleCircuitView", package.seeall)

local DungeonPuzzleCircuitView = class("DungeonPuzzleCircuitView", BaseView)

function DungeonPuzzleCircuitView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._gobasepoint = gohelper.findChild(self.viewGO, "#go_basepoint")
	self._gocube = gohelper.findChild(self.viewGO, "#go_basepoint/#go_cube")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goedit = gohelper.findChild(self.viewGO, "#go_edit")
	self._btnexport = gohelper.findChildButtonWithAudio(self.viewGO, "#go_edit/#btn_export")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonPuzzleCircuitView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnexport:AddClickListener(self._btnexportOnClick, self)
end

function DungeonPuzzleCircuitView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnexport:RemoveClickListener()
end

function DungeonPuzzleCircuitView:_btnexportOnClick()
	DungeonPuzzleCircuitModel.instance:debugData()
end

function DungeonPuzzleCircuitView:_btncloseOnClick()
	self:closeThis()
end

function DungeonPuzzleCircuitView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getDungeonPuzzleBg("full/bg_beijingtu"))
	self._simagebg2:LoadImage(ResUrl.getDungeonPuzzleBg("bg_caozuotai"))
	gohelper.setActive(self._goedit, false)
end

function DungeonPuzzleCircuitView:_onDropValueChanged(index)
	DungeonPuzzleCircuitModel.instance:setEditIndex(index)
end

function DungeonPuzzleCircuitView:onUpdateParam()
	return
end

function DungeonPuzzleCircuitView:onOpen()
	return
end

function DungeonPuzzleCircuitView:onCloseFinish()
	if self._dropView then
		self._dropView:RemoveOnValueChanged()
	end

	local elementCo = DungeonPuzzleCircuitModel.instance:getElementCo()

	if elementCo and DungeonMapModel.instance:hasMapPuzzleStatus(elementCo.id) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, elementCo.id)
	end

	DungeonPuzzleCircuitModel.instance:release()
end

function DungeonPuzzleCircuitView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
end

return DungeonPuzzleCircuitView
