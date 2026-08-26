-- chunkname: @modules/logic/bossrush/view/v1a6/taskachievement/V1a6_BossRush_ScheduleView.lua

module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_ScheduleView", package.seeall)

local V1a6_BossRush_ScheduleView = class("V1a6_BossRush_ScheduleView", BaseView)

function V1a6_BossRush_ScheduleView:onInitView()
	self._txtTotalScore = gohelper.findChildText(self.viewGO, "Left/Total/#txt_TotalScore")
	self._goSlider = gohelper.findChild(self.viewGO, "Left/Slider/#go_Slider")
	self._scrollprogress = gohelper.findChildScrollRect(self.viewGO, "Left/Slider/#go_Slider/#scroll_progress")
	self._imageSliderBG = gohelper.findChildImage(self.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG")
	self._imageSliderFG1 = gohelper.findChildImage(self.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1")
	self._imageSliderFG2 = gohelper.findChildImage(self.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1/#image_SliderFG2")
	self._goprefabInst = gohelper.findChild(self.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#go_prefabInst")
	self._scrollScoreList = gohelper.findChildScrollRect(self.viewGO, "Right/#scroll_ScoreList")
	self._goRight = gohelper.findChild(self.viewGO, "Right")
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_BossRush_ScheduleView:addEvents()
	self.addEventCb(self, BossRushController.instance, BossRushEvent.OnReceiveGet128SingleRewardReply, self._refresh, self)
	self.addEventCb(self, BossRushController.instance, BossRushEvent.OnReceiveAct128GetTotalRewardsReply, self._refresh, self)
end

function V1a6_BossRush_ScheduleView:removeEvents()
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.OnReceiveGet128SingleRewardReply, self._refresh, self)
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.OnReceiveAct128GetTotalRewardsReply, self._refresh, self)
end

function V1a6_BossRush_ScheduleView:_editableInitView()
	self.scoreList = self:getUserDataTb_()
end

function V1a6_BossRush_ScheduleView:onUpdateParam()
	return
end

function V1a6_BossRush_ScheduleView:onOpen()
	self.stage = self.viewParam.stage
	self._stageCO = self.viewParam.stageCO
	self.actId = self._stageCO.activityId
	self._stageMo = V3a9_BossRushModel.instance:getStageMo(self.actId, self.stage)

	gohelper.setActive(self._goRight, true)
	self:_refresh()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
	gohelper.setActive(self._gostatus, false)
	self:playAnim(BossRushEnum.V1a6_BonusViewAnimName.In)

	self._scrollScoreList.verticalNormalizedPosition = 1
end

function V1a6_BossRush_ScheduleView:onClose()
	gohelper.setActive(self._goRight, false)
	self:playAnim(BossRushEnum.V1a6_BonusViewAnimName.Out)
	self:_clearKillTween()
end

function V1a6_BossRush_ScheduleView:onDestroyView()
	return
end

function V1a6_BossRush_ScheduleView:refreshScore()
	if self._stageMo then
		local score = self._stageMo:getTotalPoint()

		if self._stageMo then
			local maxNum = self._stageMo:getRewardMaxTotalScore()
			local curNum = Mathf.Min(score, maxNum)
			local param1 = {
				curNum = curNum,
				maxNum = maxNum
			}

			self._tweenTime = 1.5

			local lastscore, lastwidth = self:_getPrefsSchedule(self.stage)
			local isChage1 = lastscore < curNum

			if isChage1 then
				self:_refreshNumTxt(lastscore, maxNum)

				self._tweenNumId = ZProj.TweenHelper.DOTweenFloat(0, curNum, self._tweenTime, self._onTweenNumUpdate, nil, self, param1, EaseType.OutQuad)
			else
				self:_refreshNumTxt(curNum, maxNum)
			end

			self._goContent = self._scrollprogress.content

			local layout = self._goContent.gameObject:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
			local cellWidth = self._goprefabInst.transform.rect.width
			local spacing = layout.spacing + cellWidth
			local offset = 30 + cellWidth * 0.5
			local grayWidth, gotWidth = V1a6_BossRush_BonusModel.instance:getScheduleProgressWidth(self.actId, self.stage, spacing, offset)
			local param = {
				grayWidth = grayWidth,
				gotWidth = gotWidth
			}

			recthelper.setWidth(self._imageSliderBG.transform, grayWidth)

			local isChage2 = lastwidth < gotWidth

			if isChage2 then
				self:_refrehSlider(lastwidth, grayWidth, gotWidth)

				self._tweenSliderId = ZProj.TweenHelper.DOTweenFloat(lastwidth, gotWidth, self._tweenTime, self._onTweenSliderUpdate, nil, self, param, EaseType.Linear)
			else
				self:_refrehSlider(gotWidth, grayWidth, gotWidth)
			end

			self:_setPrefsSchedule(self.stage, curNum, gotWidth)
		end
	end
end

function V1a6_BossRush_ScheduleView:_onTweenNumUpdate(value, param)
	self:_refreshNumTxt(value, param.maxNum)
end

function V1a6_BossRush_ScheduleView:_onTweenSliderUpdate(value, param)
	self:_refrehSlider(value, param.grayWidth, param.gotWidth)
end

function V1a6_BossRush_ScheduleView:_clearKillTween()
	if self._tweenSliderId then
		ZProj.TweenHelper.KillById(self._tweenSliderId)

		self._tweenSliderId = nil
	end

	if self._tweenNumId then
		ZProj.TweenHelper.KillById(self._tweenNumId)

		self._tweenNumId = nil
	end
end

function V1a6_BossRush_ScheduleView:_refreshNumTxt(cur, max)
	if self._txtTotalScore then
		cur = Mathf.Ceil(cur)
		self._txtTotalScore.text = string.format("<color=#ff8640><size=50>%s</size></color>/%s", cur, max)
	end
end

function V1a6_BossRush_ScheduleView:_refrehSlider(width, gray, got)
	if self._imageSliderFG1 then
		recthelper.setWidth(self._imageSliderFG1.transform, width)
		recthelper.setWidth(self._imageSliderFG2.transform, got - width)
	end

	if self._scrollprogress then
		if gray and gray > 0 then
			if not (width / gray) then
				self._scrollprogress.horizontalNormalizedPosition = 0
			end
		end
	end
end

function V1a6_BossRush_ScheduleView:refreshScoreItem()
	local dataList = BossRushModel.instance:getScheduleViewRewardList(self.stage)

	if self._stageMo then
		local cur = self._stageMo:getTotalPoint()

		for i, data in pairs(dataList) do
			local co = data.stageRewardCO

			if co then
				local item = self.scoreList[i]
				local num = co.rewardPointNum

				if not item then
					item = {
						go = gohelper.cloneInPlace(self._goprefabInst, "scoreitem_" .. i)
					}
					item.img = item.go:GetComponent(gohelper.Type_Image)
					item.txt = gohelper.findChildText(item.go, "txt_Score")
					self.scoreList[i] = item
				end

				gohelper.setActive(item.go.gameObject, true)

				item.txt.text = num

				local isDisplay = co.display > 0
				local isAlready = num <= cur

				UISpriteSetMgr.instance:setV1a4BossRushSprite(item.img, BossRushConfig.instance:getRewardStatusSpriteName(isDisplay, isAlready))
			end
		end
	end
end

function V1a6_BossRush_ScheduleView:_refresh()
	self:_refreshRight()
	self:refreshScoreItem()
	self:refreshScore()
end

function V1a6_BossRush_ScheduleView:_refreshRight()
	V1a6_BossRush_BonusModel.instance:selectScheduleTab(self.stage, self.actId)
end

function V1a6_BossRush_ScheduleView:playAnim(name, callback, callbackobj)
	if self._animatorPlayer then
		self._animatorPlayer:Play(name, callback, callbackobj)
	end
end

function V1a6_BossRush_ScheduleView:_getPrefsSchedule(stage)
	local prefs = GameUtil.playerPrefsGetStringByUserId(self:_getPrefsKey(stage), "0|0")
	local split = string.split(prefs, "|")
	local score, width = tonumber(split[1]), tonumber(split[2])

	return score, width
end

function V1a6_BossRush_ScheduleView:_setPrefsSchedule(stage, score, width)
	GameUtil.playerPrefsSetStringByUserId(self:_getPrefsKey(stage), string.format("%s|%s", score, width))
end

function V1a6_BossRush_ScheduleView:_getPrefsKey(stage)
	return "V1a6_BossRush_ScheduleView_Schedule_" .. self.actId .. "_" .. stage
end

return V1a6_BossRush_ScheduleView
