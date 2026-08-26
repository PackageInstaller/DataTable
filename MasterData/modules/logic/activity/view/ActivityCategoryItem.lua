-- chunkname: @modules/logic/activity/view/ActivityCategoryItem.lua

module("modules.logic.activity.view.ActivityCategoryItem", package.seeall)

local ActivityCategoryItem = class("ActivityCategoryItem", ListScrollCell)

function ActivityCategoryItem:init(go)
	self.go = go
	self._goselect = gohelper.findChild(go, "beselected")
	self._goselectbg = gohelper.findChild(go, "beselected/selecticon")
	self._gounselect = gohelper.findChild(go, "noselected")
	self._txtnamecn = gohelper.findChildText(go, "beselected/activitynamecn")
	self._txtnameen = gohelper.findChildText(go, "beselected/activitynamecn/activitynameen")
	self._txtunselectnamecn = gohelper.findChildText(go, "noselected/noactivitynamecn")
	self._txtunselectnameen = gohelper.findChildText(go, "noselected/noactivitynamecn/noactivitynameen")
	self._goreddot = gohelper.findChild(go, "#go_reddot")
	self._itemClick = gohelper.getClickWithAudio(self.go)

	gohelper.setActive(self._goselectbg, false)

	self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._openAnimTime = 0.43

	self:playEnterAnim()
end

function ActivityCategoryItem:addEventListeners()
	self._itemClick:AddClickListener(self._onItemClick, self)
end

function ActivityCategoryItem:removeEventListeners()
	self._itemClick:RemoveClickListener()
end

function ActivityCategoryItem:_onItemClick()
	if self._selected then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)
	ActivityRpc.instance:sendGetActivityInfosRequest()
	self:setRedDotData()
	ActivityModel.instance:setTargetActivityCategoryId(self._mo.id)
	ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivitySelectState)
end

function ActivityCategoryItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshItem()

	if Time.realtimeSinceStartup - ActivityBeginnerCategoryListModel.instance.openViewTime > self._openAnimTime then
		self._anim:Play(UIAnimationName.Idle, 0, 1)
	end
end

function ActivityCategoryItem:_refreshItem()
	local center, dotId
	local actId = self._mo.id
	local ActivityCo = ActivityConfig.instance:getActivityCo(actId)
	local redDotId = ActivityCo.redDotId
	local typeId = ActivityCo.typeId

	self._txtnamecn.text = ActivityCo.name
	self._txtnameen.text = ActivityCo.nameEn
	self._txtunselectnamecn.text = ActivityCo.name
	self._txtunselectnameen.text = ActivityCo.nameEn

	gohelper.setActive(self._goreddot, true)

	if self._mo.type == ActivityEnum.ActivityType.Normal then
		center = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.NorSign).showCenter
		dotId = ActivityConfig.instance:getActivityCenterCo(center).reddotid
		self._selected = actId == ActivityModel.instance:getTargetActivityCategoryId(center)

		if actId == ActivityEnum.Activity.NoviceInsight then
			RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.ActivityNoviceInsight)

			if self._selected then
				RedDotRpc.instance:sendShowRedDotRequest(RedDotEnum.DotNode.ActivityNoviceInsight, false)
			end
		else
			RedDotController.instance:addRedDot(self._goreddot, dotId, actId)
		end
	elseif self._mo.type == ActivityEnum.ActivityType.Beginner then
		self._selected = actId == ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Beginner)
		dotId = ActivityConfig.instance:getActivityCenterCo(ActivityEnum.ActivityType.Beginner).reddotid

		if actId == ActivityEnum.Activity.DreamShow then
			RedDotController.instance:addRedDot(self._goreddot, redDotId, nil, self.checkActivityShowFirstEnter, self)
		elseif actId == DoubleDropModel.instance:getActId() or typeId == ActivityEnum.ActivityTypeID.Act217 and Activity217Config.instance:getSubTypeCO(actId) then
			RedDotController.instance:addRedDot(self._goreddot, redDotId, nil, self.checkActivityShowFirstEnter, self)

			if self._selected and redDotId > 0 then
				RedDotRpc.instance:sendShowRedDotRequest(redDotId, false)
			end
		elseif actId == ActivityEnum.Activity.Activity1_7WarmUp or actId == V3a6_WarmUpConfig.instance:actId() then
			if self._selected then
				Activity125Controller.instance:saveEnterActDateInfo(actId)

				local parentReddot = RedDotConfig.instance:getRedDotCO(dotId).parent

				RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
					[tonumber(parentReddot)] = true
				})
			end

			RedDotController.instance:addRedDot(self._goreddot, redDotId, nil, self.checkIsV1A7WarmupRed, self)
		elseif actId == ActivityEnum.Activity.Activity1_5WarmUp then
			if self._selected then
				Activity146Controller.instance:saveEnterActDateInfo()

				local parentReddot = RedDotConfig.instance:getRedDotCO(dotId).parent

				RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
					[tonumber(parentReddot)] = true
				})
			end

			RedDotController.instance:addRedDot(self._goreddot, redDotId, nil, self.checkIsAct146NeedReddot, self)
		elseif actId == ActivityEnum.Activity.Activity1_8WarmUp then
			if self._selected then
				Activity125Controller.instance:saveEnterActDateInfo(actId)

				local parentReddot = RedDotConfig.instance:getRedDotCO(dotId).parent

				RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
					[tonumber(parentReddot)] = true
				})
			end

			RedDotController.instance:addRedDot(self._goreddot, redDotId, nil, self.checkIsV1A8WarmupRed, self)
		elseif actId == ActivityEnum.Activity.V2a2_TurnBack_H5 then
			RedDotController.instance:addRedDot(self._goreddot, redDotId, nil, self.checkActivityShowFirstEnter, self)
		elseif actId == VersionActivity2_2Enum.ActivityId.LimitDecorate then
			RedDotController.instance:addRedDot(self._goreddot, dotId, actId, self.checkActivityShowFirstEnter, self)
		elseif actId == ActivityEnum.Activity.V2a4_WarmUp then
			if self._selected then
				Activity125Controller.instance:saveEnterActDateInfo(actId)

				local parentReddot = RedDotConfig.instance:getRedDotCO(dotId).parent

				RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
					[tonumber(parentReddot)] = true
				})
			end

			RedDotController.instance:addRedDot(self._goreddot, redDotId ~= 0 and redDotId or RedDotEnum.DotNode.Activity125Task, nil, self._checkIsV2a4WarmupRed, self)
		elseif actId == ActivityEnum.Activity.V2a9_FreeMonthCard then
			RedDotController.instance:addRedDot(self._goreddot, dotId, self._mo.id)

			local isRewardGet = V2a9FreeMonthCardModel.instance:isCurDayCouldGet()

			gohelper.setActive(self._goreddot, isRewardGet)
		elseif actId == ActivityEnum.Activity.V3a3_SkinDiscount then
			if self._selected then
				ActivityBeginnerController.instance:setFirstWeekEnter(self._mo.id)

				local parentReddot = RedDotConfig.instance:getRedDotCO(dotId).parent

				RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
					[tonumber(parentReddot)] = true
				})
			end

			RedDotController.instance:addRedDot(self._goreddot, redDotId, nil, self.checkActivityShowFirstWeekEnter, self)
		elseif actId == ActivityEnum.Activity.V3a8_DragonBoatActivity_FullView then
			local redList = {
				{
					id = redDotId,
					uid = actId
				},
				{
					uid = 0,
					id = RedDotEnum.DotNode.V3a8DragonBoat
				},
				{
					id = RedDotEnum.DotNode.V3a8DragonBoatVoteFinal,
					uid = V3a8_DragonBoatConfig.instance:getVoteFinalResultActId()
				}
			}

			RedDotController.instance:addMultiRedDot(self._goreddot, redList)
		elseif typeId == ActivityEnum.ActivityTypeID.Act125 then
			if self._selected then
				Activity125Controller.instance:saveEnterActDateInfo(actId)

				local parentReddot = RedDotConfig.instance:getRedDotCO(dotId).parent

				RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
					[tonumber(parentReddot)] = true
				})
			end

			RedDotController.instance:addRedDot(self._goreddot, redDotId, nil, self.checkIsV1A9WarmupRed, self)
		elseif typeId == ActivityEnum.ActivityTypeID.Act189 then
			local infoList_red = {
				{
					id = redDotId,
					uid = actId
				},
				{
					id = RedDotEnum.DotNode.Activity189Task,
					uid = actId
				},
				{
					id = RedDotEnum.DotNode.Activity189OnceReward,
					uid = actId
				}
			}

			RedDotController.instance:addMultiRedDot(self._goreddot, infoList_red)
		elseif typeId == ActivityEnum.ActivityTypeID.Act201 or typeId == ActivityEnum.ActivityTypeID.Act209 or typeId == ActivityEnum.ActivityTypeID.Act212 or typeId == ActivityEnum.ActivityTypeID.Act214 or typeId == ActivityEnum.ActivityTypeID.Act100 then
			RedDotController.instance:addRedDot(self._goreddot, redDotId, nil, self.checkActivityShowFirstEnter, self)
		elseif typeId == ActivityEnum.ActivityTypeID.Act217 then
			RedDotController.instance:addRedDot(self._goreddot, redDotId, nil, self.checkIsAct217NeedReddot, self)
		elseif actId == ActivityEnum.Activity.V3a5_SchoolStart or actId == VersionActivity3_8Enum.ActivityId.FreeMonthCard then
			RedDotController.instance:addRedDot(self._goreddot, redDotId)
		elseif actId == ActivityEnum.Activity.SP02_LinkGift then
			local infoList_red = {
				{
					id = RedDotEnum.DotNode.ActivityNoviceTab,
					uid = actId
				},
				{
					id = RedDotEnum.DotNode.SPO2LinkGift
				},
				{
					id = RedDotEnum.DotNode.SPO2LinkGiftPackage
				}
			}

			RedDotController.instance:addMultiRedDot(self._goreddot, infoList_red, self._checkIsV3a7LinkGiftRed, self)
		else
			RedDotController.instance:addRedDot(self._goreddot, dotId, self._mo.id)
		end
	end

	gohelper.setActive(self._goselect, self._selected)
	gohelper.setActive(self._gounselect, not self._selected)
end

function ActivityCategoryItem:checkActivityShowFirstEnter(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		redDotIcon.show = ActivityBeginnerController.instance:checkFirstEnter(self._mo.id)

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end
end

function ActivityCategoryItem:checkActivityShowFirstWeekEnter(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		redDotIcon.show = ActivityBeginnerController.instance:checkFirstWeekEnter(self._mo.id)

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end
end

function ActivityCategoryItem:checkActivityNewStage(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		redDotIcon.show = ActivityBeginnerController.instance:checkActivityNewStage(self._mo.id)

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end
end

function ActivityCategoryItem:checkIsAct217NeedReddot(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		redDotIcon.show = ActivityBeginnerController.instance:checkFirstEnter(self._mo.id)

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end
end

function ActivityCategoryItem:checkIsAct146NeedReddot(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		local isFirstEnterToday = Activity146Controller.instance:isActFirstEnterToday()
		local isAllEpisodeFinish = Activity146Model.instance:isAllEpisodeFinish()
		local hasEpisodeCanReceiveReward = Activity146Model.instance:isHasEpisodeCanReceiveReward()

		redDotIcon.show = isFirstEnterToday and (not isAllEpisodeFinish or hasEpisodeCanReceiveReward)

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end
end

function ActivityCategoryItem:checkIsV1A7WarmupRed(redDotIcon)
	local actId = self._mo.id

	redDotIcon.show = Activity125Controller.instance:checkActRed(actId)

	redDotIcon:showRedDot(RedDotEnum.Style.Normal)
end

function ActivityCategoryItem:checkIsV1A8WarmupRed(redDotIcon)
	redDotIcon.show = Activity125Controller.instance:checkActRed1(ActivityEnum.Activity.Activity1_8WarmUp)

	redDotIcon:showRedDot(RedDotEnum.Style.Normal)
end

function ActivityCategoryItem:checkIsV1A9WarmupRed(redDotIcon)
	local actId = self._mo.id

	redDotIcon.show = Activity125Controller.instance:checkActRed2(actId)

	redDotIcon:showRedDot(RedDotEnum.Style.Normal)
end

function ActivityCategoryItem:setRedDotData()
	ActivityBeginnerController.instance:setFirstEnter(self._mo.id)
end

function ActivityCategoryItem:playEnterAnim()
	local openAnimProgress = Mathf.Clamp01((Time.realtimeSinceStartup - ActivityBeginnerCategoryListModel.instance.openViewTime) / self._openAnimTime)

	self._anim:Play(UIAnimationName.Open, 0, openAnimProgress)
end

function ActivityCategoryItem:onDestroy()
	return
end

function ActivityCategoryItem:_checkIsV2a4WarmupRed(redDotIcon)
	local actId = self._mo.id

	redDotIcon.show = Activity125Controller.instance:checkActRed3(actId)

	redDotIcon:showRedDot(RedDotEnum.Style.Normal)
end

function ActivityCategoryItem:_checkIsV3a7LinkGiftRed(redDotIcon)
	redDotIcon:defaultRefreshDot()

	local actId = self._mo.id

	redDotIcon.show = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.ActivityNoviceTab, actId) or ActivityBeginnerController.instance:checkGoodsTaskReward(actId)

	redDotIcon:showRedDot(RedDotEnum.Style.Normal)
end

return ActivityCategoryItem
