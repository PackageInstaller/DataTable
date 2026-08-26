-- chunkname: @modules/logic/handbook/view/HandbookWeekWalkView.lua

module("modules.logic.handbook.view.HandbookWeekWalkView", package.seeall)

local HandbookWeekWalkView = class("HandbookWeekWalkView", BaseView)

function HandbookWeekWalkView:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookWeekWalkView:addEvents()
	return
end

function HandbookWeekWalkView:removeEvents()
	return
end

function HandbookWeekWalkView:_editableInitView()
	return
end

function HandbookWeekWalkView:onUpdateParam()
	return
end

function HandbookWeekWalkView:onOpen()
	self.mapId = self.viewParam.id
end

function HandbookWeekWalkView:onClose()
	return
end

function HandbookWeekWalkView:onDestroyView()
	return
end

return HandbookWeekWalkView
