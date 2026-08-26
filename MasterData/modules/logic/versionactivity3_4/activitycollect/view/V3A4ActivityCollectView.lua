-- chunkname: @modules/logic/versionactivity3_4/activitycollect/view/V3A4ActivityCollectView.lua

module("modules.logic.versionactivity3_4.activitycollect.view.V3A4ActivityCollectView", package.seeall)

local V3A4ActivityCollectView = class("V3A4ActivityCollectView", BaseView)
local kState_Available = 1
local kState_Received = 2

function V3A4ActivityCollectView:onInitView()
	self.txtTime = gohelper.findChildTextMesh(self.viewGO, "root/#txt_time")
	self.btnActivity1 = gohelper.findChildButtonWithAudio(self.viewGO, "root/activity1/#btn_go")
	self.goActivityTime1 = gohelper.findChild(self.viewGO, "root/activity1/#go_limittime")
	self.txtActivityTime1 = gohelper.findChildTextMesh(self.viewGO, "root/activity1/#go_limittime/#txt_time")
	self.goActivityRewardIcon1 = gohelper.findChild(self.viewGO, "root/activity1/go_reward/go_icon")
	self.goActivity1OpenTime = gohelper.findChild(self.viewGO, "root/activity1/go_opentiem")
	self.txtActivity1OpenTime = gohelper.findChildTextMesh(self.viewGO, "root/activity1/go_opentiem/#txt_time")
	self.activityReward1Items = {}
	self.btnActivity2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/activity2/#btn_go")
	self.btnActivity3 = gohelper.findChildButtonWithAudio(self.viewGO, "root/activity3/#btn_go")
	self.btnActivity4 = gohelper.findChildButtonWithAudio(self.viewGO, "root/activity4/#btn_go")
	self.goActivityTime4 = gohelper.findChild(self.viewGO, "root/activity4/#go_limittime")
	self.txtActivityTime4 = gohelper.findChildTextMesh(self.viewGO, "root/activity4/#go_limittime/#txt_time")
	self.goActivity4OpenTime = gohelper.findChild(self.viewGO, "root/activity4/go_opentiem")
	self.txtActivity4OpenTime = gohelper.findChildTextMesh(self.viewGO, "root/activity4/go_opentiem/#txt_time")
	self.goReward1 = gohelper.findChild(self.viewGO, "root/activity5/reward1/#go_itemicon1")
	self.goReward2 = gohelper.findChild(self.viewGO, "root/activity5/reward2/#go_itemicon2")
	self.goReward3 = gohelper.findChild(self.viewGO, "root/activity5/reward3/#go_itemicon")
	self.rougeActId = VersionActivity3_2Enum.ActivityId.Rouge2
	self.partyActId = VersionActivity3_4Enum.ActivityId.PartyGame

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A4ActivityCollectView:addEvents()
	self.addClickCb(self, self.btnActivity1, self.onClickActivity1, self)
	self.addClickCb(self, self.btnActivity2, self.onClickActivity2, self)
	self.addClickCb(self, self.btnActivity3, self.onClickActivity3, self)
	self.addClickCb(self, self.btnActivity4, self.onClickActivity4, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.onRefreshNorSignActivity, self)
end

function V3A4ActivityCollectView:removeEvents()
	self:removeClickCb(self.btnActivity1)
	self:removeClickCb(self.btnActivity2)
	self:removeClickCb(self.btnActivity3)
	self:removeClickCb(self.btnActivity4)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.onRefreshNorSignActivity, self)
end

function V3A4ActivityCollectView:_editableInitView()
	return
end

function V3A4ActivityCollectView:onRefreshNorSignActivity()
	self:refreshActivity5()
end

function V3A4ActivityCollectView:onClickActivity1()
	if not ActivityModel.instance:isActOnLine(VersionActivity3_4Enum.ActivityId.PartyGame) then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(PartyGameLobbyEnum.DailyOpenId) then
		VersionActivity3_4EnterController.instance:directOpenVersionActivityEnterView(VersionActivity3_4Enum.ActivityId.PartyGame)

		return
	end

	PartyGameLobbyController.instance:enterGameLobby()
end

function V3A4ActivityCollectView:onClickActivity2()
	GameFacade.jump(610002)
end

function V3A4ActivityCollectView:onClickActivity3()
	local seasonCardId = 832006
	local goodsMo = StoreModel.instance:getGoodsMO(seasonCardId)

	if not goodsMo or goodsMo:isSoldOut() then
		StoreController.instance:openStoreView(614, 610001, true)
	else
		StoreController.instance:openStoreView(612, seasonCardId, true)
	end
end

function V3A4ActivityCollectView:onClickActivity3Reward()
	BpController.instance:showSpecialBonusMaterialInfo()
end

function V3A4ActivityCollectView:onClickActivity4()
	if not Rouge2_Controller.instance:checkIsOpen(true) then
		return
	end

	Rouge2_ViewHelper.openEnterView()
end

function V3A4ActivityCollectView:onClickActivity5Item(index)
	local infos = ActivityType101Model.instance:getType101Info(self._actId)
	local curIndex = index
	local data = infos[curIndex]

	if not data then
		return
	end

	if data.state == kState_Available then
		Activity101Rpc.instance:sendGet101BonusRequest(self._actId, curIndex)
	end
end

function V3A4ActivityCollectView:onUpdateParam()
	return
end

function V3A4ActivityCollectView:onOpen()
	if self.viewParam then
		local parentGO = self.viewParam.parent

		gohelper.addChild(parentGO, self.viewGO)
	end

	self._actId = VersionActivity3_4Enum.ActivityId.ActivityCollect
	self._config = ActivityConfig.instance:getActivityCo(self._actId)

	self:refreshView()
end

function V3A4ActivityCollectView:refreshView()
	self:refreshTime()
	self:refreshActivity1()
	self:refreshActivity5()
end

function V3A4ActivityCollectView:refreshActivity1()
	local actCo = ActivityConfig.instance:getActivityCo(self._actId)
	local rewards = GameUtil.splitString2(actCo.activityBonus, true) or {}

	for i = 1, math.max(#rewards, #self.activityReward1Items) do
		local item = self.activityReward1Items[i]
		local data = rewards[i]

		if not item then
			local go = gohelper.cloneInPlace(self.goActivityRewardIcon1)

			item = IconMgr.instance:getCommonPropItemIcon(go)

			table.insert(self.activityReward1Items, item)
		end

		if data then
			gohelper.setActive(item.go, true)
			item:setMOValue(data[1], data[2], data[3] or 1, nil, true)
			item:setScale(0.5)
			item:isShowEquipAndItemCount(false)
			item:hideEquipLvAndBreak(true)
		else
			gohelper.setActive(item.go, false)
		end
	end
end

function V3A4ActivityCollectView:refreshActivity5()
	local infos = ActivityType101Model.instance:getType101Info(self._actId) or {}
	local loginCount = ActivityType101Model.instance:getType101LoginCount(self._actId)
	local list = ActivityConfig.instance:getNorSignActivityCos(self._actId)

	self.activity5ItemList = self.activity5ItemList or {}

	for i = 1, 3 do
		local curIndex = i
		local item = self.activity5ItemList[i]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.findChild(self.viewGO, string.format("root/activity5/reward%s", curIndex))
			item.btnClaim = gohelper.findChildButtonWithAudio(item.go, "#btn_claim")
			item.goHasget = gohelper.findChild(item.go, "#go_hasget")
			item.goTag = gohelper.findChild(item.go, "tag_today")
			item.goTomorrow = gohelper.findChild(item.go, "tag_tomorrow")

			item.btnClaim:AddClickListener(self.onClickActivity5Item, self, curIndex)

			self.activity5ItemList[i] = item
		end

		local data = infos[curIndex]

		gohelper.setActive(item.go, data ~= nil)

		if data then
			local hasget = data.state == kState_Received
			local couldGet = data.state == kState_Available

			gohelper.setActive(item.btnClaim, couldGet)
			gohelper.setActive(item.goTag, false)
			gohelper.setActive(item.goHasget, hasget)
			gohelper.setActive(item.goTomorrow, not hasget and loginCount == curIndex - 1)
		end
	end
end

function V3A4ActivityCollectView:refreshTime()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
	TaskDispatcher.runRepeat(self.everySecondCall, self, 1)
	self:everySecondCall()
end

function V3A4ActivityCollectView:everySecondCall()
	self:refreshMainActTime()
	self:refreshActTime1()
	self:refreshActTime4()
end

function V3A4ActivityCollectView:refreshMainActTime()
	local actInfoMo = ActivityModel.instance:getActMO(self._actId)

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		self.txtTime.text = TimeUtil.secondToRoughTime3(offsetSecond)
	end
end

function V3A4ActivityCollectView:refreshActTime1()
	local actInfoMo = ActivityModel.instance:getActMO(self.partyActId)

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealStartTimeStamp() - ServerTime.now()
	local isNotOpen = offsetSecond > 0

	if isNotOpen then
		local timeStr = TimeUtil.secondToRoughTime3(offsetSecond)

		self.txtActivity1OpenTime.text = string.format(luaLang("seasonmainview_timeopencondition"), timeStr)
	else
		offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
		self.txtActivityTime1.text = TimeUtil.secondToRoughTime3(offsetSecond)
	end

	gohelper.setActive(self.goActivity1OpenTime, isNotOpen)
	gohelper.setActive(self.goActivityTime1, not isNotOpen)
	gohelper.setActive(self.btnActivity1, not isNotOpen)
end

function V3A4ActivityCollectView:refreshActTime4()
	local actInfoMo = ActivityModel.instance:getActMO(self.rougeActId)

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealStartTimeStamp() - ServerTime.now()
	local isNotOpen = offsetSecond > 0

	if isNotOpen then
		local timeStr = TimeUtil.secondToRoughTime3(offsetSecond)

		self.txtActivity4OpenTime.text = string.format(luaLang("seasonmainview_timeopencondition"), timeStr)
	else
		offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
		self.txtActivityTime4.text = TimeUtil.secondToRoughTime3(offsetSecond)
	end

	gohelper.setActive(self.goActivity4OpenTime, isNotOpen)
	gohelper.setActive(self.goActivityTime4, not isNotOpen)
	gohelper.setActive(self.btnActivity4, not isNotOpen)
end

function V3A4ActivityCollectView:onClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function V3A4ActivityCollectView:onDestroyView()
	TaskDispatcher.cancelTask(self.everySecondCall, self)

	if self.activity5ItemList then
		for i, v in ipairs(self.activity5ItemList) do
			v.btnClaim:RemoveClickListener()
		end
	end

	if self.activityReward1Items then
		for k, v in pairs(self.activityReward1Items) do
			v:onDestroy()
		end

		self.activityReward1Items = nil
	end
end

return V3A4ActivityCollectView
