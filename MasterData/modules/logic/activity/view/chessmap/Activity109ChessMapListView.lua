-- chunkname: @modules/logic/activity/view/chessmap/Activity109ChessMapListView.lua

module("modules.logic.activity.view.chessmap.Activity109ChessMapListView", package.seeall)

local Activity109ChessMapListView = class("Activity109ChessMapListView", BaseView)

function Activity109ChessMapListView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_task")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity109ChessMapListView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
end

function Activity109ChessMapListView:removeEvents()
	self._btntask:RemoveClickListener()
end

function Activity109ChessMapListView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getActivityBg("full/barqiandao_bj_009"))
end

function Activity109ChessMapListView:onDestroyView()
	self._simagebg:UnLoadImage()
end

function Activity109ChessMapListView:onOpen()
	return
end

function Activity109ChessMapListView:onClose()
	return
end

function Activity109ChessMapListView:_btntaskOnClick()
	local actId = Activity109ChessModel.instance:getActId()
	local mapId = Activity109ChessModel.instance:getMapId()
	local episodeId = Activity109ChessModel.instance:getEpisodeId()
	local targetEpisodeId = 1

	Activity109ChessController.instance:startNewEpisode(targetEpisodeId)
end

return Activity109ChessMapListView
