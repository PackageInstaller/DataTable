-- chunkname: @modules/logic/meilanni/view/MeilanniTaskView.lua

module("modules.logic.meilanni.view.MeilanniTaskView", package.seeall)

local MeilanniTaskView = class("MeilanniTaskView", BaseView)

function MeilanniTaskView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._simageb3 = gohelper.findChildSingleImage(self.viewGO, "#simage_b3")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "right/#scroll_reward")
	self._gorewardcontent = gohelper.findChild(self.viewGO, "right/#scroll_reward/Viewport/#go_rewardcontent")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MeilanniTaskView:addEvents()
	return
end

function MeilanniTaskView:removeEvents()
	return
end

function MeilanniTaskView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getMeilanniIcon("full/bg_beijing"))
	self._simagebg2:LoadImage(ResUrl.getMeilanniIcon("bg_beijing3"))
	self._simageb3:LoadImage(ResUrl.getMeilanniIcon("bg_beijing4"))
end

function MeilanniTaskView:onOpen()
	MeilanniTaskListModel.instance:showTaskList()
	self.addEventCb(self, MeilanniController.instance, MeilanniEvent.bonusReply, self._bonusReply, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Player_Interface_Open)
end

function MeilanniTaskView:_bonusReply()
	MeilanniTaskListModel.instance:showTaskList()
end

function MeilanniTaskView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Player_Interface_Close)
end

function MeilanniTaskView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
	self._simageb3:UnLoadImage()
end

return MeilanniTaskView
