-- chunkname: @modules/logic/activity/view/chessmap/Activity109ChessGameClear.lua

module("modules.logic.activity.view.chessmap.Activity109ChessGameClear", package.seeall)

local Activity109ChessGameClear = class("Activity109ChessGameClear", BaseView)

function Activity109ChessGameClear:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gotaskitemcontent = gohelper.findChild(self.viewGO, "#scroll_task/viewport/#go_taskitemcontent")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity109ChessGameClear:addEvents()
	return
end

function Activity109ChessGameClear:removeEvents()
	return
end

function Activity109ChessGameClear:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getActivityBg("full/barqiandao_bj_009"))
end

function Activity109ChessGameClear:onDestroyView()
	self._simagebg:UnLoadImage()
end

function Activity109ChessGameClear:onOpen()
	return
end

function Activity109ChessGameClear:onClose()
	return
end

return Activity109ChessGameClear
