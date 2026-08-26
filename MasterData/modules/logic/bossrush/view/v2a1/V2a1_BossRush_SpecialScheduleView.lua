-- chunkname: @modules/logic/bossrush/view/v2a1/V2a1_BossRush_SpecialScheduleView.lua

module("modules.logic.bossrush.view.v2a1.V2a1_BossRush_SpecialScheduleView", package.seeall)

local V2a1_BossRush_SpecialScheduleView = class("V2a1_BossRush_SpecialScheduleView", BaseView)

function V2a1_BossRush_SpecialScheduleView:onInitView()
	self._txtTotalScore = gohelper.findChildText(self.viewGO, "Left/Total/#txt_TotalScore")
	self._goSlider = gohelper.findChild(self.viewGO, "Left/Slider/#go_Slider")
	self._scrollprogress = gohelper.findChildScrollRect(self.viewGO, "Left/Slider/#go_Slider/#scroll_progress")
	self._imageSliderBG = gohelper.findChildImage(self.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG")
	self._imageSliderFG1 = gohelper.findChildImage(self.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1")
	self._imageSliderFG2 = gohelper.findChildImage(self.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1/#image_SliderFG2")
	self._goprefabInst = gohelper.findChild(self.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#go_prefabInst")
	self._scrollScoreList = gohelper.findChildScrollRect(self.viewGO, "Right/#scroll_ScoreList")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "Left/#go_AssessIcon")
	self._goRight = gohelper.findChild(self.viewGO, "Right")
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._isFirstOpen = true

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a1_BossRush_SpecialScheduleView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._refresh, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._refresh, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refresh, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._refresh, self)
end

function V2a1_BossRush_SpecialScheduleView:removeEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._refresh, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._refresh, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refresh, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._refresh, self)
end

function V2a1_BossRush_SpecialScheduleView:_editableInitView()
	self.scoreList = self:getUserDataTb_()
end

function V2a1_BossRush_SpecialScheduleView:onUpdateParam()
	return
end

function V2a1_BossRush_SpecialScheduleView:onOpen()
	self.stage = self.viewParam.stage

	gohelper.setActive(self._goRight, true)
	self:_initAssessIcon()
	self:_refresh()
	gohelper.setActive(self._gostatus, false)

	if self._isFirstOpen then
		if not BossRushEnum.V1a6_BonusViewAnimName.Open then
			local anim = BossRushEnum.V1a6_BonusViewAnimName.In

			self:playAnim(anim)

			self._isFirstOpen = nil
			self._scrollScoreList.verticalNormalizedPosition = 1
		end
	end
end

function V2a1_BossRush_SpecialScheduleView:onClose()
	gohelper.setActive(self._goRight, false)
	self:playAnim(BossRushEnum.V1a6_BonusViewAnimName.Out)
	self:_clearKillTween()
end

function V2a1_BossRush_SpecialScheduleView:onDestroyView()
	if self._assessIcon then
		self._assessIcon:onDestroyView()
	end
end

function V2a1_BossRush_SpecialScheduleView:_initAssessIcon()
	if not self._assessIcon then
		local itemClass = V1a4_BossRush_Task_AssessIcon
		local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_achievement_assessicon, self._goAssessIcon, itemClass.__cname)

		self._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)
	end

	local highestPoint = BossRushModel.instance:getLayer4HightScore(self.stage)

	self._assessIcon:setData(self.stage, highestPoint, true)
end

function V2a1_BossRush_SpecialScheduleView:refreshScore()
	local curNum = BossRushModel.instance:getLayer4CurScore(self.stage)
	local maxNum = BossRushModel.instance:getLayer4MaxRewardScore(self.stage)

	curNum = Mathf.Min(curNum, maxNum)

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
	local grayWidth, gotWidth = V1a6_BossRush_BonusModel.instance:getLayer4ProgressWidth(self.stage, spacing, offset)
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

function V2a1_BossRush_SpecialScheduleView:_onTweenNumUpdate(value, param)
	self:_refreshNumTxt(value, param.maxNum)
end

function V2a1_BossRush_SpecialScheduleView:_onTweenSliderUpdate(value, param)
	self:_refrehSlider(value, param.grayWidth, param.gotWidth)
end

function V2a1_BossRush_SpecialScheduleView:_clearKillTween()
	if self._tweenSliderId then
		ZProj.TweenHelper.KillById(self._tweenSliderId)

		self._tweenSliderId = nil
	end

	if self._tweenNumId then
		ZProj.TweenHelper.KillById(self._tweenNumId)

		self._tweenNumId = nil
	end
end

function V2a1_BossRush_SpecialScheduleView:_refreshNumTxt(cur, max)
	if self._txtTotalScore then
		cur = Mathf.Ceil(cur)
		self._txtTotalScore.text = string.format("<color=#41D9C5><size=50>%s</size></color>/%s", cur, max)
	end
end

function V2a1_BossRush_SpecialScheduleView:_refrehSlider(width, gray, got)
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

function V2a1_BossRush_SpecialScheduleView:refreshScoreItem()
	local dataList = BossRushModel.instance:getSpecialScheduleViewRewardList(self.stage)
	local cur = BossRushModel.instance:getLayer4CurScore(self.stage)

	for i, data in pairs(dataList) do
		local co = data.config

		if co then
			local item = self.scoreList[i]
			local num = co.maxProgress

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

			local isAlready = num <= cur

			UISpriteSetMgr.instance:setV1a4BossRushSprite(item.img, BossRushConfig.instance:getSpriteRewardStatusSpriteName(isAlready))
		end
	end
end

function V2a1_BossRush_SpecialScheduleView:_refresh()
	self:_refreshRight()
	self:refreshScoreItem()
	self:refreshScore()
end

function V2a1_BossRush_SpecialScheduleView:_refreshRight()
	V1a6_BossRush_BonusModel.instance:selectSpecialScheduleTab(self.stage)
end

function V2a1_BossRush_SpecialScheduleView:playAnim(name, callback, callbackobj)
	if self._animatorPlayer then
		self._animatorPlayer:Play(name, callback, callbackobj)
	end
end

function V2a1_BossRush_SpecialScheduleView:_getPrefsSchedule(stage)
	local prefs = GameUtil.playerPrefsGetStringByUserId(self:_getPrefsKey(stage), "0|0")
	local split = string.split(prefs, "|")
	local score, width = tonumber(split[1]), tonumber(split[2])

	return score, width
end

function V2a1_BossRush_SpecialScheduleView:_setPrefsSchedule(stage, score, width)
	GameUtil.playerPrefsSetStringByUserId(self:_getPrefsKey(stage), string.format("%s|%s", score, width))
end

function V2a1_BossRush_SpecialScheduleView:_getPrefsKey(stage)
	local actId = BossRushConfig.instance:getActivityId()

	return "V2a1_BossRush_SpecialScheduleView_Schedule_" .. actId .. "_" .. stage
end

return V2a1_BossRush_SpecialScheduleView
