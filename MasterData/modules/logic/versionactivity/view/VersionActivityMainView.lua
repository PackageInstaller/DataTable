-- chunkname: @modules/logic/versionactivity/view/VersionActivityMainView.lua

module("modules.logic.versionactivity.view.VersionActivityMainView", package.seeall)

local VersionActivityMainView = class("VersionActivityMainView", BaseView)

function VersionActivityMainView:onInitView()
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_enter")
	self._gostamp = gohelper.findChild(self.viewGO, "leftcontent/#go_stamp")
	self._txtstampNum = gohelper.findChildText(self.viewGO, "leftcontent/#go_stamp/#txt_stampNum")
	self._goreddot = gohelper.findChild(self.viewGO, "leftcontent/#go_stamp/#go_reddot")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "leftcontent/#btn_store")
	self._txtendtime = gohelper.findChildText(self.viewGO, "leftcontent/#txt_endtime")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityMainView:addEvents()
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
end

function VersionActivityMainView:removeEvents()
	self._btnenter:RemoveClickListener()
	self._btnstore:RemoveClickListener()
end

function VersionActivityMainView:_btnenterOnClick()
	VersionActivityDungeonController.instance:openVersionActivityDungeonMapView()
end

function VersionActivityMainView:_btnstoreOnClick()
	VersionActivityController.instance:openLeiMiTeBeiStoreView()
end

function VersionActivityMainView:enterTaskView()
	VersionActivityController.instance:openLeiMiTeBeiTaskView()
end

function VersionActivityMainView:_editableInitView()
	self.taskClick = gohelper.getClick(self._gostamp)

	self.taskClick:AddClickListener(self.enterTaskView, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshTaskUI, self)
end

function VersionActivityMainView:onUpdateParam()
	return
end

function VersionActivityMainView:onOpen()
	self:refreshTaskUI()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.LeiMiTeBeiTask)

	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivityEnum.ActivityId.Act113]

	if actInfoMo then
		local tag = {
			actInfoMo:getEndTimeStr(),
			actInfoMo:getRemainTimeStr()
		}

		self._txtendtime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("versionactivity_baozhi_time"), tag)
	end
end

function VersionActivityMainView:refreshTaskUI()
	self._txtstampNum.text = string.format("%s/%s", self:getFinishTaskCount(), VersionActivityConfig.instance:getAct113TaskCount())
end

function VersionActivityMainView:getFinishTaskCount()
	self.finishTaskCount = 0

	local taskMo

	for _, taskCo in ipairs(lua_activity113_task.configList) do
		taskMo = TaskModel.instance:getTaskById(taskCo.id)

		if taskMo and taskMo.finishCount >= taskCo.maxFinishCount then
			self.finishTaskCount = self.finishTaskCount + 1
		end
	end

	return self.finishTaskCount
end

function VersionActivityMainView:onClose()
	return
end

function VersionActivityMainView:onDestroyView()
	self.taskClick:RemoveClickListener()
end

return VersionActivityMainView
