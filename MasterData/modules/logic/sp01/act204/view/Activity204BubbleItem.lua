-- chunkname: @modules/logic/sp01/act204/view/Activity204BubbleItem.lua

module("modules.logic.sp01.act204.view.Activity204BubbleItem", package.seeall)

local Activity204BubbleItem = class("Activity204BubbleItem", LuaCompBase)

function Activity204BubbleItem:init(go)
	self.go = go
	self._goreddot = gohelper.findChild(self.go, "root/Reward/#go_reddot")
	self._gorewardItem = gohelper.findChild(self.go, "root/Reward/rewardList/#go_rewardItem")
	self._gohasget = gohelper.findChild(self.go, "root/Reward/go_hasget")
	self._gocanget = gohelper.findChild(self.go, "root/Reward/go_canget")
	self._gonotget = gohelper.findChild(self.go, "root/Reward/go_notget")
	self._txtremainTime = gohelper.findChildText(self.go, "root/Reward/go_notget/txt_remainTime")
	self._gorewardbg = gohelper.findChild(self.go, "root/image_RewardBG")
	self._rewardItemTab = self:getUserDataTb_()

	gohelper.setActive(self._gorewardItem, false)
end

function Activity204BubbleItem:addEventListeners()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshBonus, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshActivityState, self)
end

function Activity204BubbleItem:removeEventListeners()
	return
end

function Activity204BubbleItem:onUpdateMO(bubbleActIds)
	self:_initActivity101Configs(bubbleActIds)
	self:_initRedDot(bubbleActIds)
	self:_refreshBonus()
end

function Activity204BubbleItem:_initActivity101Configs(bubbleActIds)
	self._bubbleActIds = bubbleActIds
	self._activity101List = {}

	for _, actId in ipairs(self._bubbleActIds) do
		local act101Cfgs = lua_activity101.configDict[actId]

		tabletool.addValues(self._activity101List, act101Cfgs)
	end

	table.sort(self._activity101List, self.activity101SortFunc)
end

function Activity204BubbleItem:_initRedDot()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V2a9_Act204Bubble)
end

function Activity204BubbleItem.activity101SortFunc(aCfg, bCfg)
	local aActId = aCfg.activityId
	local bActId = bCfg.activityId
	local aStartTime = ActivityModel.instance:getActStartTime(aActId)
	local bStartTime = ActivityModel.instance:getActStartTime(bActId)

	if aStartTime ~= bStartTime then
		return aStartTime < bStartTime
	end

	if aActId ~= bActId then
		return aActId < bActId
	end

	return aCfg.id < bCfg.id
end

function Activity204BubbleItem:_refreshBonus()
	local couldGetActList = {}
	local nextCouldGetActList = {}

	for _, activity101Cfg in ipairs(self._activity101List) do
		local activityId = activity101Cfg.activityId
		local status = ActivityHelper.getActivityStatusAndToast(activityId)

		if status == ActivityEnum.ActivityStatus.Normal then
			local canGet = ActivityType101Model.instance:isType101RewardCouldGet(activityId, activity101Cfg.id)

			if canGet then
				table.insert(couldGetActList, activity101Cfg)
			end
		elseif status == ActivityEnum.ActivityStatus.NotOpen and activityId ~= 130525 then
			table.insert(nextCouldGetActList, activity101Cfg)

			break
		end
	end

	self:findNeedShowRewardList(couldGetActList, nextCouldGetActList)
	self:refreshBonusItemList()
end

function Activity204BubbleItem:findNeedShowRewardList(couldGetActList, nextCouldGetActList)
	local bonusActCfgList = {}

	if couldGetActList then
		if not #couldGetActList then
			local couldGetActNum = 0

			if nextCouldGetActList then
				if not #nextCouldGetActList then
					local nextCouldGetActNum = 0

					if couldGetActNum > 0 then
						bonusActCfgList = couldGetActList
					elseif nextCouldGetActNum > 0 then
						bonusActCfgList = nextCouldGetActList
					end

					self._rewardCfgList = {}

					for _, activity101Cfg in ipairs(bonusActCfgList) do
						local bonusCfgList = GameUtil.splitString2(activity101Cfg.bonus, true)

						for _, bonusCfg in ipairs(bonusCfgList) do
							local cfg = {
								materilType = bonusCfg[1],
								materilId = bonusCfg[2],
								quantity = bonusCfg[3],
								activity101Cfg = activity101Cfg
							}

							table.insert(self._rewardCfgList, cfg)
						end
					end

					gohelper.setActive(self._gohasget, couldGetActNum <= 0 and nextCouldGetActNum <= 0)
					gohelper.setActive(self._gocanget, couldGetActNum > 0)
					gohelper.setActive(self._gonotget, couldGetActNum <= 0 and nextCouldGetActNum > 0)
					gohelper.setActive(self._gorewardbg, #self._rewardCfgList > 1)
					TaskDispatcher.cancelTask(self.refreshRemainTime, self)

					if couldGetActNum <= 0 and nextCouldGetActNum > 0 then
						self._nextCouldGetActCo = nextCouldGetActList[1]

						self:refreshRemainTime()
						TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
					end
				end
			end
		end
	end
end

function Activity204BubbleItem:refreshRemainTime()
	if not self._nextCouldGetActCo then
		TaskDispatcher.cancelTask(self.refreshRemainTime, self)

		return
	end

	if self._nextCouldGetActCo then
		local activityId = self._nextCouldGetActCo.activityId
		local startTime = ActivityModel.instance:getActStartTime(activityId)
		local remainTimeSec = startTime / 1000 - ServerTime.now()

		if remainTimeSec <= 0 then
			self._txtremainTime = ActivityHelper.getActivityRemainTimeStr(activityId)

			TaskDispatcher.cancelTask(self.refreshRemainTime, self)
			Activity101Rpc.instance:sendGet101InfosRequest(activityId)

			return
		end

		self._txtremainTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("activity204entranceview_bubble"), TimeUtil.SecondToActivityTimeFormat(remainTimeSec))
	end
end

function Activity204BubbleItem:refreshBonusItemList()
	local useMap = {}

	for index, rewardCfg in ipairs(self._rewardCfgList) do
		local rewardItem = self:_getOrCreateRewardItem(index)

		self:_refreshRewardItem(rewardItem, rewardCfg)

		useMap[rewardItem] = true
	end

	for _, rewardItem in pairs(self._rewardItemTab) do
		if not useMap[rewardItem] then
			gohelper.setActive(rewardItem.go, false)
		end
	end
end

function Activity204BubbleItem:_getOrCreateRewardItem(index)
	local bonusItem = self._rewardItemTab[index]

	if not bonusItem then
		bonusItem = self:getUserDataTb_()
		bonusItem.go = gohelper.cloneInPlace(self._gorewardItem, "rewardItem_" .. index)
		bonusItem.gopos = gohelper.findChild(bonusItem.go, "go_rewardPos")
		bonusItem.icon = IconMgr.instance:getCommonPropItemIcon(bonusItem.gopos)
		bonusItem.gocanget = gohelper.findChild(bonusItem.go, "go_rewardGet")
		bonusItem.golock = gohelper.findChild(bonusItem.go, "go_rewardLock")
		bonusItem.txtnum = gohelper.findChildText(bonusItem.go, "Num/#txt_Num")
		self._rewardItemTab[index] = bonusItem
	end

	return bonusItem
end

function Activity204BubbleItem:_refreshRewardItem(rewardItem, rewardCfg)
	rewardItem.icon:setMOValue(rewardCfg.materilType, rewardCfg.materilId, rewardCfg.quantity, nil, true)
	rewardItem.icon:setConsume(true)
	rewardItem.icon:isShowEffect(true)
	rewardItem.icon:isShowCount(false)
	rewardItem.icon:isShowQuality(false)
	rewardItem.icon:setCanShowDeadLine(false)
	rewardItem.icon:setHideLvAndBreakFlag(true)
	rewardItem.icon:hideEquipLvAndBreak(true)
	rewardItem.icon:setCountFontSize(48)

	local canGetReward = self:_isCouldGetReward(rewardCfg.activity101Cfg)

	gohelper.setActive(rewardItem.gocanget, canGetReward)
	gohelper.setActive(rewardItem.golock, not canGetReward)
	gohelper.setActive(rewardItem.go, true)

	rewardItem.txtnum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), rewardCfg.quantity)

	rewardItem.icon:customOnClickCallback(function()
		if not rewardCfg then
			return
		end

		if rewardCfg then
			local activity101Cfg = rewardCfg.activity101Cfg
			local couldGet = self:_isCouldGetReward(activity101Cfg)

			if couldGet then
				self:_claimAll()

				return
			end

			MaterialTipController.instance:showMaterialInfo(tonumber(rewardCfg.materilType), rewardCfg.materilId)
		end
	end)
end

function Activity204BubbleItem:_claimAll()
	local counldGetActCfgs = {}

	for _, rewardCfg in ipairs(self._rewardCfgList) do
		local activity101Cfg = rewardCfg.activity101Cfg
		local isCouldGetReward = self:_isCouldGetReward(activity101Cfg)

		if isCouldGetReward then
			table.insert(counldGetActCfgs, activity101Cfg)
		end
	end

	for _, actCfg in ipairs(counldGetActCfgs) do
		local activityId = actCfg.activityId
		local index = actCfg.id

		Activity101Rpc.instance:sendGet101BonusRequest(activityId, index)
	end
end

function Activity204BubbleItem:_isCouldGetReward(activity101Cfg)
	if not activity101Cfg then
		return
	end

	local activityId = activity101Cfg.activityId
	local index = activity101Cfg.id

	return ActivityType101Model.instance:isType101RewardCouldGet(activityId, index)
end

function Activity204BubbleItem:_refreshActivityState(actId)
	if not self._bubbleActIds or not tabletool.indexOf(self._bubbleActIds, actId) then
		return
	end

	self:_refreshBonus()
end

function Activity204BubbleItem:onDestroy()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

return Activity204BubbleItem
