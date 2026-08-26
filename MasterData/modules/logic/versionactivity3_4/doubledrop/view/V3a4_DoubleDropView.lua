-- chunkname: @modules/logic/versionactivity3_4/doubledrop/view/V3a4_DoubleDropView.lua

module("modules.logic.versionactivity3_4.doubledrop.view.V3a4_DoubleDropView", package.seeall)

local V3a4_DoubleDropView = class("V3a4_DoubleDropView", BaseView)

function V3a4_DoubleDropView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "go_time/go_deadline/#txt_time")
	self._txtdesc = gohelper.findChildText(self.viewGO, "go_desc/#scroll_desc/Viewport/#txt_desc")
	self._txttotaltimes = gohelper.findChildText(self.viewGO, "go_times/go_total/#txt_totaltimes")
	self._txttotalday = gohelper.findChildText(self.viewGO, "go_times/go_today/#txt_totalday")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_jump")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4_DoubleDropView:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
end

function V3a4_DoubleDropView:removeEvents()
	self._btnjump:RemoveClickListener()
end

function V3a4_DoubleDropView:_btnjumpOnClick()
	GameFacade.jump(JumpEnum.JumpView.DoubleDrop)
end

function V3a4_DoubleDropView:_editableInitView()
	return
end

function V3a4_DoubleDropView:onUpdateParam()
	return
end

function V3a4_DoubleDropView:onOpen()
	StatController.instance:track(StatEnum.EventName.EnterDoubleEquip)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_page_turn)

	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self.actId = self.viewParam.actId

	self:refresh()
end

function V3a4_DoubleDropView:refresh()
	local actId = self.actId

	self._mo = Activity217Model.instance:getActInfoById(actId)
	self._configList = Activity217Config.instance:getControlCos(actId)

	for index, config in ipairs(self._configList) do
		local type = config.type
		local limit = config.limit
		local dailyLimit = config.dailyLimit
		local dayUseTimes = self._mo:getDailyUseCountByType(type)
		local totalUseTimes = self._mo:getTotalUseCountByType(type)
		local totalRemainTime = limit - totalUseTimes
		local dailyRemainTime = dailyLimit - dayUseTimes

		dailyRemainTime = totalRemainTime < dailyRemainTime and totalRemainTime or dailyRemainTime
		self._txttotaltimes.text = totalRemainTime > 0 and string.format("<color=#DE9854>%s</color>/%s", totalRemainTime, limit) or string.format("<color=#BF2E11>%s</color>/%s", totalRemainTime, limit)
		self._txttotalday.text = dailyRemainTime > 0 and string.format("<color=#DE9854>%s</color>/%s", dailyRemainTime, dailyLimit) or string.format("<color=#BF2E11>%s</color>/%s", dailyRemainTime, dailyLimit)
	end

	local actCo = ActivityConfig.instance:getActivityCo(actId)

	if actCo then
		self._txtdesc.text = actCo.actDesc or ""
	end

	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
end

function V3a4_DoubleDropView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txttime.text = offsetSecond > 0 and TimeUtil.SecondToActivityTimeFormat(offsetSecond) or luaLang("ended")
end

function V3a4_DoubleDropView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function V3a4_DoubleDropView:onDestroyView()
	return
end

return V3a4_DoubleDropView
