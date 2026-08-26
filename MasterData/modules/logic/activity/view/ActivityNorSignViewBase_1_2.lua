-- chunkname: @modules/logic/activity/view/ActivityNorSignViewBase_1_2.lua

module("modules.logic.activity.view.ActivityNorSignViewBase_1_2", package.seeall)

local ActivityNorSignViewBase_1_2 = class("ActivityNorSignViewBase_1_2", BaseView)

function ActivityNorSignViewBase_1_2:onInitView()
	self._simagebanner = gohelper.findChildSingleImage(self.viewGO, "#simage_banner")
	self._godaylist = gohelper.findChild(self.viewGO, "#go_daylist")
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "#go_daylist/#scroll_item")
	self._titleicon = gohelper.findChildSingleImage(self.viewGO, "title/#titleicon")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "title/#txt_remaintime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityNorSignViewBase_1_2:addEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
end

function ActivityNorSignViewBase_1_2:removeEvents()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
end

function ActivityNorSignViewBase_1_2:_editableInitView()
	assert(false, "please override this function")
end

function ActivityNorSignViewBase_1_2:_btnhelpOnClick()
	local data = {}
	local co = ActivityConfig.instance:getActivityCo(self._actId)

	data.title = luaLang("rule")
	data.desc = co.actTip
	data.rootGo = self._btnhelp.gameObject

	ViewMgr.instance:openView(ViewName.ActivityTipView, data)
end

function ActivityNorSignViewBase_1_2:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
end

function ActivityNorSignViewBase_1_2:onDestroyView()
	self._simagebanner:UnLoadImage()
	self._titleicon:UnLoadImage()
end

function ActivityNorSignViewBase_1_2:_refresh()
	local data = {}

	for i = 1, 7 do
		local o = {}

		o.data = ActivityConfig.instance:getNorSignActivityCo(self._actId, i)

		table.insert(data, o)
	end

	ActivityNorSignItemListModel_1_2.instance:setList(data)

	local day, hour = ActivityModel.instance:getRemainTime(self._actId)

	self._txtremaintime.text = string.format(luaLang("activitynorsignview_remaintime"), day, hour)
end

return ActivityNorSignViewBase_1_2
