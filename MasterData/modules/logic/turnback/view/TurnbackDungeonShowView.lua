-- chunkname: @modules/logic/turnback/view/TurnbackDungeonShowView.lua

module("modules.logic.turnback.view.TurnbackDungeonShowView", package.seeall)

local TurnbackDungeonShowView = class("TurnbackDungeonShowView", BaseView)

function TurnbackDungeonShowView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txttime = gohelper.findChildText(self.viewGO, "tipspanel/#txt_time")
	self._txtrule = gohelper.findChildText(self.viewGO, "tipspanel/#txt_rule")
	self._txttipdesc = gohelper.findChildText(self.viewGO, "tipspanel/tipsbg/#txt_tipdec")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_goto")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackDungeonShowView:addEvents()
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshRemainTime, self._refreshRemainTime, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self._refreshUI, self)
end

function TurnbackDungeonShowView:removeEvents()
	self._btngoto:RemoveClickListener()
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshRemainTime, self._refreshRemainTime, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self._refreshUI, self)
end

function TurnbackDungeonShowView:_btngotoOnClick()
	if self.config.jumpId ~= 0 then
		GameFacade.jump(self.config.jumpId)
	end
end

function TurnbackDungeonShowView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getTurnbackIcon("turnback_fullbg"))
end

function TurnbackDungeonShowView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self.endTime = self:_getEndTime()

	self:_refreshUI()
end

function TurnbackDungeonShowView:_refreshUI()
	self.config = TurnbackConfig.instance:getTurnbackSubModuleCo(self.viewParam.actId)

	local descTab = string.split(self.config.actDesc, "|")

	self._txtrule.text = descTab[1]

	local remainCount, totalCount = TurnbackModel.instance:getAdditionCountInfo()
	local remainStr = remainCount == 0 and "#d97373" or "#FFFFFF"

	self._txttipdesc.text = string.format("%s (<color=%s>%s</color>/%s)", descTab[2], remainStr, remainCount, totalCount)

	self:_refreshRemainTime()
end

function TurnbackDungeonShowView:_refreshRemainTime()
	self._txttime.text = TurnbackController.instance:refreshRemainTime(self.endTime)
end

function TurnbackDungeonShowView:_getEndTime()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()
	local additionalDurationDays = TurnbackConfig.instance:getAdditionDurationDays(turnbackId)
	local mo = TurnbackModel.instance:getCurTurnbackMo()

	return mo.startTime + additionalDurationDays * TimeUtil.OneDaySecond
end

function TurnbackDungeonShowView:onClose()
	return
end

function TurnbackDungeonShowView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return TurnbackDungeonShowView
