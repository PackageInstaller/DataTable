-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotEnterView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEnterView", package.seeall)

local V1a6_CachotEnterView = class("V1a6_CachotEnterView", VersionActivityEnterBaseSubView)

function V1a6_CachotEnterView:onInitView()
	self._simagelevelbg = gohelper.findChildSingleImage(self.viewGO, "#simage_levelbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "#simage_leftbg")
	self._txttitle = gohelper.findChildText(self.viewGO, "right/#simage_rightbg/#txt_title")
	self._txtdesc = gohelper.findChildText(self.viewGO, "right/#simage_rightbg/#txt_desc")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "right/#txt_LimitTime")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "right/scroll_Reward")
	self._gorewards = gohelper.findChild(self.viewGO, "right/scroll_Reward/Viewport/#go_rewards")
	self._gostart = gohelper.findChild(self.viewGO, "right/node/start")
	self._golocked = gohelper.findChild(self.viewGO, "right/node/locked")
	self._btnlocked = gohelper.findChildButtonWithAudio(self.viewGO, "right/node/locked/#btn_locked")
	self._gocontinue = gohelper.findChild(self.viewGO, "right/node/continue")
	self._goreddot = gohelper.findChild(self.viewGO, "right/node/#go_reddot")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "right/node/start/#btn_start")
	self._txttips = gohelper.findChildText(self.viewGO, "right/node/locked/#txt_tips")
	self._btncontinue = gohelper.findChildButtonWithAudio(self.viewGO, "right/node/continue/#btn_continue")
	self._btnabandon = gohelper.findChildButtonWithAudio(self.viewGO, "right/node/continue/#btn_abandon")
	self._goprogress = gohelper.findChild(self.viewGO, "right/node/continue/#go_progress")
	self._simgeprogress = gohelper.findChildSingleImage(self.viewGO, "right/node/continue/#go_progress/icon")
	self._txtprogress1 = gohelper.findChildText(self.viewGO, "right/node/continue/#go_progress/#txt_progress1")
	self._txtprogress2 = gohelper.findChildText(self.viewGO, "right/node/continue/#go_progress/#txt_progress2")
	self._goreward = gohelper.findChild(self.viewGO, "right/#go_reward")
	self._txtscore = gohelper.findChildText(self.viewGO, "right/#go_reward/#txt_score")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_reward/#btn_reward")
	self._gorewardreddot = gohelper.findChild(self.viewGO, "right/#go_reward/#go_rewardreddot")
	self._itemObjects = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotEnterView:addEvents()
	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueStateInfo, self._refreshUI, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btncontinue:AddClickListener(self._btncontinueOnClick, self)
	self._btnabandon:AddClickListener(self._btnabandonOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
end

function V1a6_CachotEnterView:removeEvents()
	self.removeEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueStateInfo, self._refreshUI, self)
	self._btnstart:RemoveClickListener()
	self._btnabandon:RemoveClickListener()
	self._btncontinue:RemoveClickListener()
	self._btnlocked:RemoveClickListener()
	self._btnreward:RemoveClickListener()
end

function V1a6_CachotEnterView:_btnabandonOnClick()
	local function func()
		V1a6_CachotController.instance:abandonGame()
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.V1a6CachotMsgBox01, MsgBoxEnum.BoxType.Yes_No, func, nil, nil, self)
end

function V1a6_CachotEnterView:_btnrewardOnClick()
	V1a6_CachotController.instance:openV1a6_CachotProgressView()
end

function V1a6_CachotEnterView:_btnstartOnClick()
	V1a6_CachotStatController.instance:statStart()
	V1a6_CachotController.instance:enterMap(false)
end

function V1a6_CachotEnterView:_btncontinueOnClick()
	V1a6_CachotStatController.instance:statStart()
	V1a6_CachotController.instance:enterMap(false)
end

function V1a6_CachotEnterView:_editableInitView()
	return
end

function V1a6_CachotEnterView:onUpdateParam()
	return
end

function V1a6_CachotEnterView:onOpen()
	V1a6_CachotEnterView.super.onOpen(self)
	self:_refreshUI()
	self:_showLeftTime()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V1a6RogueRewardEnter)
	RedDotController.instance:addRedDot(self._gorewardreddot, RedDotEnum.DotNode.V1a6RogueRewardEnter)
end

function V1a6_CachotEnterView:_refreshUI()
	local actMo = ActivityModel.instance:getActMO(V1a6_CachotEnum.ActivityId)

	self.config = ActivityConfig.instance:getActivityCo(V1a6_CachotEnum.ActivityId)
	self._txtdesc.text = self.config.actDesc

	local isOpen = actMo:isOpen()

	if isOpen then
		local actCo = ActivityConfig.instance:getActivityCo(V1a6_CachotEnum.ActivityId)
		local openId = actCo.openId
		local isUnlock = openId and openId ~= 0 and OpenModel.instance:isFunctionUnlock(openId)

		if isUnlock then
			self.stateMo = V1a6_CachotModel.instance:getRogueStateInfo()

			if self.stateMo then
				local isStart = self.stateMo:isStart()

				if self.stateMo and self.stateMo.totalScore then
					self._txtscore.text = self.stateMo.totalScore
				end

				if isStart then
					self:refreshContinue()
				end

				gohelper.setActive(self._gostart, not isStart)
				gohelper.setActive(self._gocontinue, isStart)
				recthelper.setAnchorX(self._goreward.transform, isStart and 76 or 192)
			end
		else
			local episodeId = OpenConfig.instance:getOpenCo(openId).episodeId
			local episodetxt = DungeonConfig.instance:getEpisodeDisplay(episodeId)

			self._txttips.text = formatLuaLang("dungeon_unlock_episode_mode", episodetxt)

			self._btnlocked:AddClickListener(function()
				GameFacade.showToast(ToastEnum.DungeonMapLevel, episodetxt)
			end, self)
			gohelper.setActive(self._gostart, false)
			gohelper.setActive(self._gocontinue, false)
		end

		gohelper.setActive(self._golocked, not isUnlock)
		gohelper.setActive(self._txttips.gameObject, not isUnlock)
		gohelper.setActive(self._goreward, isUnlock)
	end

	self:initRewards()

	self._scrollReward.horizontalNormalizedPosition = 0
end

function V1a6_CachotEnterView:refreshContinue()
	local diffco = V1a6_CachotConfig.instance:getDifficultyConfig(self.stateMo.difficulty)
	local layer = self.stateMo.layer

	self._simgeprogress:LoadImage(ResUrl.getV1a6CachotIcon("v1a6_cachot_layerchange_level_" .. layer))

	self._txtprogress1.text = diffco.title
	self._txtprogress2.text = V1a6_CachotRoomConfig.instance:getLayerName(self.stateMo.layer, self.stateMo.difficulty)
end

function V1a6_CachotEnterView:initRewards()
	local rewards = GameUtil.splitString2(self.config.activityBonus, true)

	if rewards then
		for i, reward in ipairs(rewards) do
			local item = self._itemObjects[i]

			if not item then
				item = IconMgr.instance:getCommonPropItemIcon(self._gorewards)

				table.insert(self._itemObjects, item)
			end

			item:setMOValue(reward[1], reward[2], 1)
			item:isShowCount(false)
		end
	end
end

function V1a6_CachotEnterView:_showLeftTime()
	local leftSecond = ActivityModel.instance:getRemainTimeSec(V1a6_CachotEnum.ActivityId)

	if leftSecond then
		self._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(leftSecond)
	end
end

function V1a6_CachotEnterView:everySecondCall()
	self:_showLeftTime()
end

function V1a6_CachotEnterView:onClose()
	V1a6_CachotEnterView.super.onClose(self)
	self._simgeprogress:UnLoadImage()
end

function V1a6_CachotEnterView:onDestroyView()
	return
end

return V1a6_CachotEnterView
