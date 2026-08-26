-- chunkname: @modules/logic/activity/view/ActivityNorSignView.lua

module("modules.logic.activity.view.ActivityNorSignView", package.seeall)

local ActivityNorSignView = class("ActivityNorSignView", BaseView)

function ActivityNorSignView:onInitView()
	self._simagebanner = gohelper.findChildSingleImage(self.viewGO, "#simage_banner")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "title/#txt_remaintime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityNorSignView:addEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
end

function ActivityNorSignView:removeEvents()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
end

function ActivityNorSignView:_editableInitView()
	gohelper.setActive(self._gorule, false)

	self._actId = ActivityEnum.Activity.NorSign

	Activity101Rpc.instance:sendGet101InfosRequest(self._actId)
	self._simagebanner:LoadImage(ResUrl.getActivityBg("bg_qiridenglubeijing"))
end

function ActivityNorSignView:onUpdateParam()
	return
end

function ActivityNorSignView:_btnhelpOnClick()
	local data = {}
	local co = ActivityConfig.instance:getActivityCo(self._actId)

	data.title = luaLang("rule")
	data.desc = co.actTip
	data.rootGo = self._btnhelp.gameObject

	ViewMgr.instance:openView(ViewName.ActivityTipView, data)
end

function ActivityNorSignView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
end

function ActivityNorSignView:_refresh()
	local data = {}

	for i = 1, 7 do
		local o = {}

		o.data = ActivityConfig.instance:getNorSignActivityCo(self._actId, i)

		table.insert(data, o)
	end

	ActivityNorSignItemListModel.instance:setDayList(data)

	local day, hour = ActivityModel.instance:getRemainTime(self._actId)

	self._txtremaintime.text = string.format(luaLang("activitynorsignview_remaintime"), day, hour)
end

function ActivityNorSignView:onClose()
	return
end

function ActivityNorSignView:onDestroyView()
	self._simagebanner:UnLoadImage()
end

return ActivityNorSignView
