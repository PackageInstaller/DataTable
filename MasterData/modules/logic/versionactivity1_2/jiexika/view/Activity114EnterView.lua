-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114EnterView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114EnterView", package.seeall)

local Activity114EnterView = class("Activity114EnterView", BaseView)

function Activity114EnterView:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._golightspine = gohelper.findChild(self.viewGO, "scale/#go_lightspine")
	self._normalGo = gohelper.findChild(self.viewGO, "#go_normal")
	self._btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Reward")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Enter")
	self._goSchoolBack = gohelper.findChild(self.viewGO, "#btn_Enter/#go_schoolback")
	self._goSchoolEnter = gohelper.findChild(self.viewGO, "#btn_Enter/#go_schoolenter")
	self._btnPhoto = gohelper.findChildButtonWithAudio(self.viewGO, "#go_photos/#btn_photot")
	self._txtphotoprogress = gohelper.findChildTextMesh(self.viewGO, "#go_photos/title/#txt_progress")
	self._txtdurTime = gohelper.findChildTextMesh(self.viewGO, "#go_info/#txt_durTime")

	gohelper.setActive(self._txtdurTime, false)

	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114EnterView:addEvents()
	self._btnReward:AddClickListener(self.openTaskView, self)
	self._btnPhoto:AddClickListener(self.openPhotoView, self)
	self._btnEnter:AddClickListener(self.enter, self)
	self._btnReset:AddClickListener(self.reset, self)
	self.addEventCb(self, Activity114Controller.instance, Activity114Event.OnCGUpdate, self.onPhotoChange, self)
	self.addEventCb(self, Activity114Controller.instance, Activity114Event.OnEnterSchoolUpdate, self.onEnterSchoolUpdate, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullViewFinish, self._onCloseFullViewFinish, self, LuaEventSystem.Low)
end

function Activity114EnterView:removeEvents()
	self._btnReward:RemoveClickListener()
	self._btnPhoto:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self.removeEventCb(self, Activity114Controller.instance, Activity114Event.OnCGUpdate, self.onPhotoChange, self)
	self.removeEventCb(self, Activity114Controller.instance, Activity114Event.OnEnterSchoolUpdate, self.onEnterSchoolUpdate, self)
end

Activity114EnterView.canShowSpineView = {
	ViewName.Activity114PhotoView
}

function Activity114EnterView:_editableInitView()
	self._taskRed = gohelper.findChild(self.viewGO, "#btn_Reward/redPoint")
	self._photoRed = gohelper.findChild(self.viewGO, "#go_photos/redPoint")
	self._photoGo = self:getUserDataTb_()

	for i = 1, 9 do
		self._photoGo[i] = gohelper.findChildImage(self.viewGO, "#go_photos/photo/" .. i)
	end

	RedDotController.instance:addRedDot(self._taskRed, RedDotEnum.DotNode.ActivityJieXiKaTask)
	RedDotController.instance:addRedDot(self._photoRed, RedDotEnum.DotNode.ActivityJieXiKaPhoto)
end

function Activity114EnterView:onOpen()
	gohelper.setActive(self._btnReset.gameObject, Activity114Model.instance.serverData.canReset and Activity114Model.instance.serverData.isEnterSchool)
	self:onPhotoChange()
	self:onEnterSchoolUpdate()
	self._viewAnim:Play("open", 0, 0)
end

function Activity114EnterView:onOpenFinish()
	self._viewAnim.enabled = true
end

function Activity114EnterView:openTaskView()
	self.viewContainer:switchTab(Activity114Enum.TabIndex.TaskView)
	self._viewAnim:Play("close", 0, 0)
end

function Activity114EnterView:enter()
	if Activity114Model.instance:isEnd() then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	if Activity114Model.instance.serverData.battleEventId > 0 then
		local eventCo = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, Activity114Model.instance.serverData.battleEventId)

		Activity114Controller.instance:enterActivityFight(eventCo.config.battleId)

		return
	end

	self.viewContainer:switchTab(Activity114Enum.TabIndex.MainView)
	self._viewAnim:Play("close", 0, 0)
end

function Activity114EnterView:openPhotoView()
	self:playCloseAnimAndOpenView(ViewName.Activity114PhotoView)
end

function Activity114EnterView:playCloseAnimAndOpenView(viewName)
	self.viewContainer.openViewName = viewName

	self.viewContainer:playCloseTransition()
end

function Activity114EnterView:reset()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act114Reset, MsgBoxEnum.BoxType.Yes_No, function()
		Activity114Rpc.instance:resetRequest(Activity114Model.instance.id)
	end)
end

function Activity114EnterView:onEnterSchoolUpdate()
	gohelper.setActive(self._goSchoolBack, Activity114Model.instance.serverData.isEnterSchool)
	gohelper.setActive(self._btnReset.gameObject, Activity114Model.instance.serverData.canReset and Activity114Model.instance.serverData.isEnterSchool)
	gohelper.setActive(self._goSchoolEnter, not Activity114Model.instance.serverData.isEnterSchool)
end

function Activity114EnterView:onPhotoChange()
	self._txtphotoprogress.text = #Activity114Model.instance.serverData.photos .. "/9"

	local photoCo = Activity114Config.instance:getPhotoCoList(Activity114Model.instance.id)

	for i = 1, 9 do
		if Activity114Model.instance.unLockPhotoDict[i] then
			UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(self._photoGo[i], photoCo[i].smallCg)
		elseif i == 9 then
			UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(self._photoGo[i], "img_empty1")
		else
			UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(self._photoGo[i], "img_empty2")
		end
	end
end

function Activity114EnterView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[Activity114Model.instance.id]

	self._txtdurTime.text = (Activity114Model.instance:isEnd() or not actInfoMo) and luaLang("versionactivity_1_2_114enterview_isend") or string.format(luaLang("remain"), actInfoMo:getRemainTimeStr2ByEndTime())
end

function Activity114EnterView:_onCloseFullViewFinish(viewName)
	for k, v in pairs(Activity114EnterView.canShowSpineView) do
		if v == viewName and self._viewAnim then
			self.viewContainer:playOpenTransition()

			return
		end
	end
end

function Activity114EnterView:onDestroyView()
	return
end

return Activity114EnterView
