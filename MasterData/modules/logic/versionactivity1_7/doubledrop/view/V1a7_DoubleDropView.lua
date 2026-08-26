-- chunkname: @modules/logic/versionactivity1_7/doubledrop/view/V1a7_DoubleDropView.lua

module("modules.logic.versionactivity1_7.doubledrop.view.V1a7_DoubleDropView", package.seeall)

local V1a7_DoubleDropView = class("V1a7_DoubleDropView", BaseView)

function V1a7_DoubleDropView:onInitView()
	self._txtTime = gohelper.findChildTextMesh(self.viewGO, "go_time/#go_deadline2/#txt_deadline2")
	self._txtDesc = gohelper.findChildTextMesh(self.viewGO, "go_desc/#scroll_desc/Viewport/#txt_desc")
	self._txtTotalTimes = gohelper.findChildTextMesh(self.viewGO, "go_times/go_total/#txt_totaltimes")
	self._goToday = gohelper.findChild(self.viewGO, "go_times/go_today")
	self._txtTotalDayTimes = gohelper.findChildTextMesh(self.viewGO, "go_times/go_today/#txt_totalday")
	self._btnJump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_jump")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a7_DoubleDropView:addEvents()
	self.addClickCb(self, self._btnJump, self._onClickJump, self)
end

function V1a7_DoubleDropView:removeEvents()
	self:removeClickCb(self._btnJump)
end

function V1a7_DoubleDropView:_editableInitView()
	return
end

function V1a7_DoubleDropView:onUpdateParam()
	self.actId = self.viewParam.actId

	self:refresh()
end

function V1a7_DoubleDropView:onOpen()
	StatController.instance:track(StatEnum.EventName.EnterDoubleEquip)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_page_turn)

	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self.actId = self.viewParam.actId

	self:refresh()
end

function V1a7_DoubleDropView:refresh()
	local actId = self.actId
	local act153Mo = DoubleDropModel.instance:getById(actId)

	if act153Mo then
		if not act153Mo.totalCount then
			local totalUseTimes = 0

			if act153Mo and act153Mo.config then
				if not act153Mo.config.totalLimit then
					local totalTimes = 0
					local totalRemainTime = totalTimes - totalUseTimes

					self._txtTotalTimes.text = totalRemainTime > 0 and string.format("<color=#DE9854>%s</color>/%s", totalRemainTime, totalTimes) or string.format("<color=#BF2E11>%s</color>/%s", totalRemainTime, totalTimes)

					local dailyRemainTime, todayTimes = DoubleDropModel.instance:getDailyRemainTimes(actId)

					self._txtTotalDayTimes.text = dailyRemainTime > 0 and string.format("<color=#DE9854>%s</color>/%s", dailyRemainTime, todayTimes) or string.format("<color=#BF2E11>%s</color>/%s", dailyRemainTime, todayTimes)

					gohelper.setActive(self._goToday, totalRemainTime > 0)

					local actCo = ActivityConfig.instance:getActivityCo(actId)

					if actCo then
						self._txtDesc.text = actCo.actDesc or ""
					end

					self:refreshRemainTime()
					TaskDispatcher.cancelTask(self.refreshRemainTime, self)
					TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
				end
			end
		end
	end
end

function V1a7_DoubleDropView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtTime.text = offsetSecond > 0 and TimeUtil.SecondToActivityTimeFormat(offsetSecond) or luaLang("ended")
end

function V1a7_DoubleDropView:_onClickJump()
	GameFacade.jump(3601)
end

function V1a7_DoubleDropView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function V1a7_DoubleDropView:onDestroyView()
	return
end

return V1a7_DoubleDropView
