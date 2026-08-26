-- chunkname: @modules/logic/activity/view/show/ActivityStoryShowView.lua

module("modules.logic.activity.view.show.ActivityStoryShowView", package.seeall)

local ActivityStoryShowView = class("ActivityStoryShowView", BaseView)

function ActivityStoryShowView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_icon")
	self._simagescrollbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_scrollbg")
	self._txttime = gohelper.findChildText(self.viewGO, "title/time/#txt_time")
	self._txtdesc = gohelper.findChildText(self.viewGO, "title/#txt_desc")
	self._scrolltask = gohelper.findChildScrollRect(self.viewGO, "#scroll_task")
	self._gotaskContent = gohelper.findChild(self.viewGO, "#scroll_task/Viewport/#go_taskContent")
	self._gotaskitem = gohelper.findChild(self.viewGO, "#scroll_task/Viewport/#go_taskContent/#go_taskitem")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_jump")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityStoryShowView:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
end

function ActivityStoryShowView:removeEvents()
	self._btnjump:RemoveClickListener()
end

ActivityStoryShowView.unlimitDay = 42

function ActivityStoryShowView:_btnjumpOnClick()
	local jumpId = self._taskConfigDataTab[1].jumpId

	if jumpId ~= 0 then
		GameFacade.jump(jumpId, self.jumpFinishCallBack, self)
	end
end

function ActivityStoryShowView:_editableInitView()
	self._simageimgchar = gohelper.findChildSingleImage(self.viewGO, "bg/character/img_character")

	self._simagebg:LoadImage(ResUrl.getActivityBg("full/img_begin_bg"))
	self._simageicon:LoadImage(ResUrl.getActivityBg("show/img_begin_lihui"))
	self._simagescrollbg:LoadImage(ResUrl.getActivityBg("show/img_begin_reward_bg"))
	self._simageimgchar:LoadImage(ResUrl.getActivityBg("show/img_begin_lihui"))
	gohelper.setActive(self._gotaskitem, false)
end

function ActivityStoryShowView:onUpdateParam()
	return
end

function ActivityStoryShowView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._actId = self.viewParam.actId
	self._taskConfigDataTab = self:getUserDataTb_()
	self._taskItemTab = self:getUserDataTb_()

	self:refreshData()
	self:refreshView()
end

function ActivityStoryShowView:refreshData()
	for i = 1, GameUtil.getTabLen(ActivityConfig.instance:getActivityShowTaskCount(self._actId)) do
		local config = ActivityConfig.instance:getActivityShowTaskList(self._actId, i)

		table.insert(self._taskConfigDataTab, config)
	end
end

function ActivityStoryShowView:refreshView()
	self._txtdesc.text = self._taskConfigDataTab[1].actDesc

	local day, hour = ActivityModel.instance:getRemainTime(self._actId)

	self._txttime.text = day > ActivityStoryShowView.unlimitDay and luaLang("activityshow_unlimittime") or string.format(luaLang("activityshow_remaintime"), day, hour)

	for index, taskConfig in ipairs(self._taskConfigDataTab) do
		local taskItem = self._taskItemTab[index]

		if not taskItem then
			taskItem = self:getUserDataTb_()
			taskItem.go = gohelper.clone(self._gotaskitem, self._gotaskContent, "task" .. index)
			taskItem.item = ActivityStoryShowItem.New()

			taskItem.item:init(taskItem.go, index, taskConfig)
			table.insert(self._taskItemTab, taskItem)
		end

		gohelper.setActive(taskItem.go, true)
	end

	for i = #self._taskConfigDataTab + 1, #self._taskItemTab do
		gohelper.setActive(self._taskItemTab[i].go, false)
	end
end

function ActivityStoryShowView:jumpFinishCallBack()
	ViewMgr.instance:closeView(ViewName.ActivityWelfareView)
end

function ActivityStoryShowView:onClose()
	return
end

function ActivityStoryShowView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageicon:UnLoadImage()
	self._simagescrollbg:UnLoadImage()
	self._simageimgchar:UnLoadImage()
end

return ActivityStoryShowView
