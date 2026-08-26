-- chunkname: @modules/logic/activity/view/ActivityNoviceInsightView.lua

module("modules.logic.activity.view.ActivityNoviceInsightView", package.seeall)

local ActivityNoviceInsightView = class("ActivityNoviceInsightView", BaseView)

function ActivityNoviceInsightView:onInitView()
	self._txtnamecn = gohelper.findChildText(self.viewGO, "name/title/#txt_namecn")
	self._txtnameen = gohelper.findChildText(self.viewGO, "name/title/#txt_nameen")
	self._gotime = gohelper.findChild(self.viewGO, "time")
	self._txttime = gohelper.findChildText(self.viewGO, "time/#txt_time")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_jump")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityNoviceInsightView:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
end

function ActivityNoviceInsightView:removeEvents()
	self._btnjump:RemoveClickListener()
end

function ActivityNoviceInsightView:_btnjumpOnClick()
	self:closeThis()

	if ViewMgr.instance:isOpen(ViewName.ActivityBeginnerView) then
		ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
	end

	GameFacade.jump(53)
end

function ActivityNoviceInsightView:_editableInitView()
	gohelper.addUIClickAudio(self._btnjump.gameObject, AudioEnum.UI.play_ui_activity_jump)
end

function ActivityNoviceInsightView:onUpdateParam()
	return
end

function ActivityNoviceInsightView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	local co = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.NoviceInsight)

	self._txtnamecn.text = co.name
	self._txtnameen.text = co.nameEn

	local actStartTime = ActivityModel.instance:getActStartTime(ActivityEnum.Activity.NoviceInsight)
	local actEndTime = ActivityModel.instance:getActEndTime(ActivityEnum.Activity.NoviceInsight)

	if type(co.endTime) == "number" then
		gohelper.setActive(self._gotime, true)

		local startTime = type(actStartTime) == "number" and TimeUtil.timestampToString1(actStartTime / 1000) or "   "
		local tag = {
			startTime,
			TimeUtil.timestampToString1(actEndTime / 1000)
		}

		self._txttime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("activitynoviceinsightview_time"), tag)
	else
		gohelper.setActive(self._gotime, false)
	end

	self._txtdesc.text = co.actTip
end

function ActivityNoviceInsightView:onClose()
	return
end

function ActivityNoviceInsightView:onDestroyView()
	return
end

return ActivityNoviceInsightView
