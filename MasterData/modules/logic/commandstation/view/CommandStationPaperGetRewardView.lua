-- chunkname: @modules/logic/commandstation/view/CommandStationPaperGetRewardView.lua

module("modules.logic.commandstation.view.CommandStationPaperGetRewardView", package.seeall)

local CommandStationPaperGetRewardView = class("CommandStationPaperGetRewardView", BaseView)

function CommandStationPaperGetRewardView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationPaperGetRewardView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function CommandStationPaperGetRewardView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function CommandStationPaperGetRewardView:_btncloseOnClick()
	self:closeThis()
	self:_showItem()
end

function CommandStationPaperGetRewardView:onClickModalMask()
	self:closeThis()
	self:_showItem()
end

function CommandStationPaperGetRewardView:_showItem()
	if not self.viewParam.isDone and self.viewParam.autoShowReward then
		local item = self.viewParam.paperCo.item

		if string.nilorempty(item) then
			return
		end

		local params = string.splitToNumber(item, "#")
		local mo = MaterialDataMO.New()

		mo:initValue(params[1], params[2], params[3])

		local materialDataMOList = {
			mo
		}

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, materialDataMOList)
	end
end

return CommandStationPaperGetRewardView
