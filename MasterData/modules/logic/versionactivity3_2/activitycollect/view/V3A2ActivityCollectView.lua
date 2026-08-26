-- chunkname: @modules/logic/versionactivity3_2/activitycollect/view/V3A2ActivityCollectView.lua

module("modules.logic.versionactivity3_2.activitycollect.view.V3A2ActivityCollectView", package.seeall)

local V3A2ActivityCollectView = class("V3A2ActivityCollectView", BaseView)
local kState_None = 0
local kState_Available = 1
local kState_Received = 2

function V3A2ActivityCollectView:onInitView()
	self.txtTime = gohelper.findChildTextMesh(self.viewGO, "root/#txt_time")
	self.btnActivity1 = gohelper.findChildButtonWithAudio(self.viewGO, "root/activity1/#btn_go")
	self.goActivityTime1 = gohelper.findChild(self.viewGO, "root/activity1/#go_limittime")
	self.txtActivityTime1 = gohelper.findChildTextMesh(self.viewGO, "root/activity1/#go_limittime/#txt_time")
	self.btnActivity2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/activity2/#btn_go")
	self.btnActivity3 = gohelper.findChildButtonWithAudio(self.viewGO, "root/activity3/#btn_go")
	self.btnActivity3Reward = gohelper.findChildClickWithAudio(self.viewGO, "root/activity3/image_icon")
	self.btnActivity4 = gohelper.findChildButtonWithAudio(self.viewGO, "root/activity4/#btn_go")
	self.goActivityTime4 = gohelper.findChild(self.viewGO, "root/activity4/#go_time")
	self.txtActivityTime4 = gohelper.findChildTextMesh(self.viewGO, "root/activity4/#go_time/#txt_time")
	self.goReward1 = gohelper.findChild(self.viewGO, "root/activity5/reward1/#go_itemicon1")
	self.goReward2 = gohelper.findChild(self.viewGO, "root/activity5/reward1/#go_itemicon2")
	self.goReward3 = gohelper.findChild(self.viewGO, "root/activity5/reward2/#go_itemicon")
	self.txtSignReward = gohelper.findChildTextMesh(self.viewGO, "root/activity6/#txt_title")
	self.btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "root/activity6/#btn_claim")
	self.goHasget = gohelper.findChild(self.viewGO, "root/activity6/#go_hasget")
	self.goTomorrow = gohelper.findChild(self.viewGO, "root/activity6/#go_hasget/tomorrow")
	self.rougeActId = VersionActivity3_2Enum.ActivityId.Rouge2

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A2ActivityCollectView:addEvents()
	self.addClickCb(self, self.btnActivity1, self.onClickActivity1, self)
	self.addClickCb(self, self.btnActivity2, self.onClickActivity2, self)
	self.addClickCb(self, self.btnActivity3, self.onClickActivity3, self)
	self.addClickCb(self, self.btnActivity3Reward, self.onClickActivity3Reward, self)
	self.addClickCb(self, self.btnActivity4, self.onClickActivity4, self)
	self.addClickCb(self, self.btnClaim, self.onClickClaim, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.onRefreshNorSignActivity, self)
end

function V3A2ActivityCollectView:removeEvents()
	self:removeClickCb(self.btnActivity1)
	self:removeClickCb(self.btnActivity2)
	self:removeClickCb(self.btnActivity3)
	self:removeClickCb(self.btnActivity3Reward)
	self:removeClickCb(self.btnActivity4)
	self:removeClickCb(self.btnClaim)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.onRefreshNorSignActivity, self)
end

function V3A2ActivityCollectView:_editableInitView()
	return
end

function V3A2ActivityCollectView:onRefreshNorSignActivity()
	self:refreshActivity6()
end

function V3A2ActivityCollectView:onClickActivity1()
	if not Rouge2_Controller.instance:checkIsOpen(true) then
		return
	end

	Rouge2_ViewHelper.openEnterView()
end

function V3A2ActivityCollectView:onClickActivity2()
	local seasonCardId = 832006
	local goodsMo = StoreModel.instance:getGoodsMO(seasonCardId)

	if goodsMo and goodsMo:isSoldOut() then
		StoreController.instance:openStoreView(612, 610001, true)
	else
		StoreController.instance:openStoreView(612, seasonCardId, true)
	end
end

function V3A2ActivityCollectView:onClickActivity3()
	GameFacade.jump(610002)
end

function V3A2ActivityCollectView:onClickActivity3Reward()
	BpController.instance:showSpecialBonusMaterialInfo()
end

function V3A2ActivityCollectView:onClickActivity4()
	BossRushController.instance:openV3a2MainView()
end

function V3A2ActivityCollectView:onClickClaim()
	local infos = ActivityType101Model.instance:getType101Info(self._actId)
	local curIndex = #infos

	for i, v in ipairs(infos or {}) do
		if v.state == kState_Available then
			curIndex = i

			break
		elseif v.state == kState_None then
			curIndex = i - 1

			break
		end
	end

	curIndex = Mathf.Clamp(curIndex, 1, #infos)

	local data = infos[curIndex]

	if not data then
		return
	end

	if data.state == kState_Available then
		Activity101Rpc.instance:sendGet101BonusRequest(self._actId, curIndex)
	end
end

function V3A2ActivityCollectView:onUpdateParam()
	return
end

function V3A2ActivityCollectView:onOpen()
	if self.viewParam then
		local parentGO = self.viewParam.parent

		gohelper.addChild(parentGO, self.viewGO)
	end

	self._actId = VersionActivity3_2Enum.ActivityId.ActivityCollect
	self._config = ActivityConfig.instance:getActivityCo(self._actId)

	self:refreshView()
end

function V3A2ActivityCollectView:refreshView()
	self:refreshTime()
	self:refreshActivity5()
	self:refreshActivity6()
end

function V3A2ActivityCollectView:refreshActivity6()
	local infos = ActivityType101Model.instance:getType101Info(self._actId)
	local curIndex = #infos

	for i, v in ipairs(infos or {}) do
		if v.state == kState_Available then
			curIndex = i

			break
		elseif v.state == kState_None then
			curIndex = i - 1

			break
		end
	end

	curIndex = Mathf.Clamp(curIndex, 1, #infos)

	local data = infos[curIndex]

	if not data then
		return
	end

	local hasget = data.state == kState_Received
	local couldGet = data.state == kState_Available

	gohelper.setActive(self.btnClaim, couldGet)
	gohelper.setActive(self.goHasget, hasget)

	if hasget then
		local nextData = ActivityConfig.instance:getNorSignActivityCo(self._actId, curIndex + 1)

		gohelper.setActive(self.goTomorrow, hasget and nextData ~= nil)
	end
end

function V3A2ActivityCollectView:refreshActivity5()
	self.itemIcon1 = self.itemIcon1 or IconMgr.instance:getCommonPropItemIcon(self.goReward1)

	self.itemIcon1:setMOValue(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.HeroExperience)
	self.itemIcon1:isShowQuality(false)
	self.itemIcon1:setInterceptClick(self.onClickItemIcon, self)

	self.itemIcon2 = self.itemIcon2 or IconMgr.instance:getCommonPropItemIcon(self.goReward2)

	self.itemIcon2:setMOValue(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Gold)
	self.itemIcon2:isShowQuality(false)
	self.itemIcon2:setInterceptClick(self.onClickItemIcon, self)

	self.itemIcon3 = self.itemIcon3 or IconMgr.instance:getCommonPropItemIcon(self.goReward3)

	self.itemIcon3:setMOValue(MaterialEnum.MaterialType.Item, 491010)
	self.itemIcon3:isShowQuality(false)
	self.itemIcon3:setInterceptClick(self.onClickItemIcon, self)
end

function V3A2ActivityCollectView:onClickItemIcon()
	return true
end

function V3A2ActivityCollectView:refreshTime()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
	TaskDispatcher.runRepeat(self.everySecondCall, self, 1)
	self:everySecondCall()
end

function V3A2ActivityCollectView:everySecondCall()
	self:refreshMainActTime()
	self:refreshActTime1()
	self:refreshActTime4()
end

function V3A2ActivityCollectView:refreshMainActTime()
	local actInfoMo = ActivityModel.instance:getActMO(self._actId)

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		self.txtTime.text = TimeUtil.secondToRoughTime3(offsetSecond)
	end
end

function V3A2ActivityCollectView:refreshActTime1()
	local actInfoMo = ActivityModel.instance:getActMO(self.rougeActId)

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealStartTimeStamp() - ServerTime.now()
	local isNotOpen = offsetSecond > 0

	if isNotOpen then
		local timeStr = TimeUtil.secondToRoughTime3(offsetSecond)

		self.txtActivityTime1.text = string.format(luaLang("seasonmainview_timeopencondition"), timeStr)
	end

	gohelper.setActive(self.goActivityTime1, isNotOpen)
	gohelper.setActive(self.btnActivity1, not isNotOpen)
end

function V3A2ActivityCollectView:refreshActTime4()
	local actId = BossRushModel.instance:getActivityId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealStartTimeStamp() - ServerTime.now()
	local isNotOpen = offsetSecond > 0

	if isNotOpen then
		local timeStr = TimeUtil.secondToRoughTime3(offsetSecond)

		self.txtActivityTime4.text = string.format(luaLang("seasonmainview_timeopencondition"), timeStr)
	end

	gohelper.setActive(self.goActivityTime4, isNotOpen)
	gohelper.setActive(self.btnActivity4, not isNotOpen)
end

function V3A2ActivityCollectView:onClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function V3A2ActivityCollectView:onDestroyView()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

return V3A2ActivityCollectView
