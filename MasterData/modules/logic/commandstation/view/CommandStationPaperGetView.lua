-- chunkname: @modules/logic/commandstation/view/CommandStationPaperGetView.lua

module("modules.logic.commandstation.view.CommandStationPaperGetView", package.seeall)

local CommandStationPaperGetView = class("CommandStationPaperGetView", BaseView)

function CommandStationPaperGetView:onInitView()
	self._imageDisk = gohelper.findChildSingleImage(self.viewGO, "image_Disk")
	self._txtDesc = gohelper.findChildTextMesh(self.viewGO, "#txt_Descr")
	self._btnReward = gohelper.findChildButton(self.viewGO, "image_icon")
end

function CommandStationPaperGetView:onClickModalMask()
	self:closeThis()
end

function CommandStationPaperGetView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_tangren_fei)
	self._imageDisk:LoadImage(ResUrl.getCommandStationPaperIcon(self.viewParam.paperCo.diskIcon))

	self._txtDesc.text = self.viewParam.paperCo.diskText
	self._hasReward = not string.nilorempty(self.viewParam.paperCo.item)

	gohelper.setActive(self._btnReward, self._hasReward)
	self._btnReward:AddClickListener(self._onBtnRewardClickHandler, self)

	self._btnClose = gohelper.findChildButton(self.viewGO, "#btn_close")

	self._btnClose:AddClickListener(self.closeThis, self)
end

function CommandStationPaperGetView:onOpenFinish()
	if self._hasReward and not self.viewParam.isDone then
		self.viewParam.autoShowReward = true

		ViewMgr.instance:openView(ViewName.CommandStationPaperGetRewardView, self.viewParam)
	end
end

function CommandStationPaperGetView:_onBtnRewardClickHandler()
	self.viewParam.autoShowReward = false

	ViewMgr.instance:openView(ViewName.CommandStationPaperGetRewardView, self.viewParam)
end

function CommandStationPaperGetView:onClose()
	self._btnReward:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

return CommandStationPaperGetView
