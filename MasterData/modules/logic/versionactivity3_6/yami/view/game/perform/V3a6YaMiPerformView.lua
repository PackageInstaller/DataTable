-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/perform/V3a6YaMiPerformView.lua

module("modules.logic.versionactivity3_6.yami.view.game.perform.V3a6YaMiPerformView", package.seeall)

local V3a6YaMiPerformView = class("V3a6YaMiPerformView", BaseView)

function V3a6YaMiPerformView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "root")
	self._gobottom = gohelper.findChild(self.viewGO, "root/bottom")
	self._goProgressbar1 = gohelper.findChildImage(self.viewGO, "root/bottom/schedule/#go_Progressbar1")
	self._goProgressbar2 = gohelper.findChildImage(self.viewGO, "root/bottom/schedule/#go_Progressbar2")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/bottom/schedule/txt_schedule/#txt_num")
	self._goattr = gohelper.findChild(self.viewGO, "root/bottom/#go_attr")
	self._btnskill = gohelper.findChildButtonWithAudio(self.viewGO, "root/bottom/#btn_skill")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiPerformView:addEvents()
	self._btnskill:AddClickListener(self._btnskillOnClick, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onFinishPerform, self._onFinishPerform, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onFinishEvent, self._onFinishEvent, self)
end

function V3a6YaMiPerformView:removeEvents()
	self._btnskill:RemoveClickListener()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onFinishPerform, self._onFinishPerform, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onFinishEvent, self._onFinishEvent, self)
end

function V3a6YaMiPerformView:_btnskillOnClick()
	V3a6YaMiController.instance:openSkillView()
end

function V3a6YaMiPerformView:_editableInitView()
	self._second = 0
	self._attrItem = self:getUserDataTb_()
	self._attrMo = V3a6YaMiAttrMO.New()

	for type, info in pairs(V3a6YaMiEnum.AttrInfo) do
		local item = self:getUserDataTb_()

		item.txtnum = gohelper.findChildText(self.viewGO, "root/bottom/#go_attr/#txt_num" .. type)
		item.go = item.txtnum.gameObject
		item.icon = gohelper.findChildImage(item.go, "image_icon")

		local _info = V3a6YaMiEnum.AttrInfo[type]

		UISpriteSetMgr.instance:setV3a6YaMiSprite(item.icon, _info.Icon)

		item.anim = item.go:GetComponent(typeof(UnityEngine.Animator))
		self._attrItem[type] = item

		self:_refreshAttr(type, 0)
	end

	self._goProgressbar2.fillAmount = 0
	self._savePerformTimePoint = V3a6YaMiConfig.instance:getConstValueByConst(V3a6YaMiEnum.ConstId.SavePerformTimePoint) or 10
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function V3a6YaMiPerformView:_refreshAttr(type, value)
	if not self._attrItem or not self._attrItem[type] then
		return
	end

	local item = self._attrItem[type]

	if value > 0 and value > self._attrMo:getAttrValue(type) then
		item.anim:Play("add", 0, 0)
	end

	item.txtnum.text = value

	self._attrMo:setAttrValue(type, value)
end

function V3a6YaMiPerformView:_checkStep()
	if not self._researchInfo then
		return
	end

	self._curStepIndex = 1
	self._stepInfos = self._researchInfo:getSecondStepInfos(self._performTime)

	if not self._stepInfos then
		return
	end

	self:_startStep()
end

function V3a6YaMiPerformView:_startStep()
	local stepInfo = self._stepInfos[self._curStepIndex]

	if not stepInfo then
		return
	end

	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onStartPerformStep, stepInfo)

	if stepInfo.type == V3a6YaMiEnum.PerformStepType.skill then
		self:_startFSkillStep(stepInfo)
	elseif stepInfo.type == V3a6YaMiEnum.PerformStepType.heroAttr then
		self:_onNextStep()
	elseif stepInfo.type == V3a6YaMiEnum.PerformStepType.productAttr then
		self:_startFloatAttrStep(stepInfo)
	elseif stepInfo.type == V3a6YaMiEnum.PerformStepType.Event then
		self:_startEventStep(stepInfo)
	end
end

function V3a6YaMiPerformView:_onNextStep()
	local stepInfo = self._stepInfos[self._curStepIndex]

	if not stepInfo then
		return
	end

	if stepInfo.isFinish then
		self._researchInfo:onFinishResearch()

		return
	end

	self._curStepIndex = self._curStepIndex + 1

	self:_startStep()
end

function V3a6YaMiPerformView:_startFSkillStep(stepInfo)
	if not stepInfo then
		return
	end

	self._entityMgr:useSkill(stepInfo.researcherId, stepInfo.skillId, stepInfo.effectId)
	self:_onNextStep()
end

function V3a6YaMiPerformView:_startFloatAttrStep(stepInfo)
	if not stepInfo then
		return
	end

	local index = 0

	for _, type in pairs(V3a6YaMiEnum.AttrType) do
		local value1 = self._attrMo:getAttrValue(type)
		local value2 = stepInfo.attr:getAttrValue(type)

		if value2 - value1 ~= 0 then
			local function cb()
				self:_refreshAttr(type, value2)
			end

			if stepInfo.researcherId > 0 then
				local delayTime = index * V3a6YaMiEnum.ShowAttrFloatTime

				self._entityMgr:showAttrFloatItem(type, value2 - value1, stepInfo.researcherId, delayTime, cb, self)

				index = index + 1
			else
				self:_refreshAttr(type, value2)
			end
		end
	end

	self:_onNextStep()
end

function V3a6YaMiPerformView:_startEventStep(stepInfo)
	self:_clear()

	if not stepInfo then
		return
	end

	self._isPerforming = false

	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onMeetEvent, stepInfo)
	V3a6YaMiRpc.instance:sendAct231PauseResearchRequest(self._performTime)
end

function V3a6YaMiPerformView:_onFinishEvent()
	self._isPerforming = true

	self:_onNextStep()
end

function V3a6YaMiPerformView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_open1)
	self:_initProgress()
	self:_refreshInfo()

	self._entityMgr = self.viewContainer:getEntityMgr()
end

function V3a6YaMiPerformView:onOpenFinish()
	self:_startPerform()
end

function V3a6YaMiPerformView:_onFinishPerform()
	self:_clear()
	gohelper.setActive(self._gobottom, false)
end

function V3a6YaMiPerformView:_refreshInfo()
	self._researchInfo = V3a6YaMiModel.instance:getResearchInfo()
	self._performTime = self._researchInfo:getPerformPauseSecond()
	self._totalTime = self._researchInfo:getTotalTime()

	self:_refreshProgress(self._performTime)

	local attrMo = self:_getInitAttr()

	for type, _ in pairs(V3a6YaMiEnum.AttrInfo) do
		local value = attrMo and attrMo:getAttrValue(type) or 0

		self._attrMo:setAttrValue(value)
		self:_refreshAttr(type, value)
	end
end

function V3a6YaMiPerformView:_getInitAttr()
	local stepInfos = self:_getInitStep()

	if stepInfos then
		for i = #stepInfos, 1, -1 do
			if stepInfos[i].attr then
				return stepInfos[i].attr
			end
		end
	end
end

function V3a6YaMiPerformView:_getInitStep()
	for i = self._performTime - 1, 1, -1 do
		local info = self._researchInfo:getSecondStepInfos(i)

		if info then
			return info
		end
	end
end

function V3a6YaMiPerformView:_startPerform()
	self._isPerforming = true
	self._second = 0

	self:_clear()
	self:_checkStep()

	self._updateHandle = UpdateBeat:CreateListener(self._onFrame, self)

	UpdateBeat:AddListener(self._updateHandle)
end

function V3a6YaMiPerformView:_onFrame()
	if not self._isPerforming or not self._researchInfo then
		return
	end

	if self._researchInfo:isFinishResearch() and self._totalTime - self._performTime < 0 then
		self:_onFinishResearch()

		return
	end

	self._second = self._second + Time.deltaTime * Time.timeScale

	if self._second >= 1 then
		self._performTime = self._performTime + 1
		self._second = 0

		self:_checkStep()

		if self._performTime % self._savePerformTimePoint == 0 and self._performTime < self._totalTime and self._isPerforming then
			V3a6YaMiRpc.instance:sendAct231RecordPlaySecondRequest(self._performTime)
		end
	end

	self:_refreshProgress(self._performTime + self._second)
end

function V3a6YaMiPerformView:_onFinishResearch()
	V3a6YaMiRpc.instance:sendAct231FinishResearchRequest(self._onFinishResearchCB, self)

	self._isPerforming = false
end

function V3a6YaMiPerformView:_onFinishResearchCB()
	local lang = luaLang("v3a6_yami_percent")

	self._txtnum.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, 100)
	self._goProgressbar2.fillAmount = 1

	self._anim:Play("swicth", 0, 0)
end

function V3a6YaMiPerformView:_refreshView()
	return
end

function V3a6YaMiPerformView:_initProgress()
	ZProj.TweenHelper.KillByObj(self._goProgressbar2)

	if self._progressTweenId then
		ZProj.TweenHelper.KillById(self._progressTweenId)

		self._progressTweenId = nil
	end
end

function V3a6YaMiPerformView:_refreshProgress(second)
	second = second or 0

	if self._totalTime then
		if not (second / self._totalTime) then
			local progress = 0

			progress = math.min(progress, 1)

			self:_tweenProgressFrame(progress)

			self._goProgressbar2.fillAmount = progress
		end
	end
end

function V3a6YaMiPerformView:_showProgress(startSecond, endSecond)
	endSecond = endSecond or self._totalTime

	local startProgress = startSecond / self._totalTime
	local endProgress = endSecond / self._totalTime
	local time = endSecond - startSecond

	self._goProgressbar2.fillAmount = startProgress

	self:_tweenProgressFrame(startProgress)

	self._progressTweenId = ZProj.TweenHelper.DOTweenFloat(startProgress, endProgress, time, self._tweenProgressFrame, nil, self, nil, EaseType.Linear)

	ZProj.TweenHelper.DOFillAmount(self._goProgressbar2, endProgress, time, nil, self, nil, EaseType.Linear)
end

function V3a6YaMiPerformView:_tweenProgressFrame(value)
	if value then
		local num = value and math.floor(value * 100) or 0

		if num ~= self._progressNum then
			local lang = luaLang("v3a6_yami_percent")

			self._txtnum.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, num)
			self._progressNum = num
		end
	end
end

function V3a6YaMiPerformView:_clear()
	ZProj.TweenHelper.KillByObj(self._goProgressbar2)

	if self._progressTweenId then
		ZProj.TweenHelper.KillById(self._progressTweenId)

		self._progressTweenId = nil
	end
end

function V3a6YaMiPerformView:_onReturnMainView()
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onReturnMainView)
	self:_clear()
end

function V3a6YaMiPerformView:onClose()
	local status = ActivityHelper.getActivityStatus(VersionActivity3_6Enum.ActivityId.YaMi)

	if status == ActivityEnum.ActivityStatus.Normal then
		local isFinishPerform = self._totalTime - self._performTime <= 0

		if isFinishPerform or not self._isPerforming then
			self:_onReturnMainView()
		else
			V3a6YaMiRpc.instance:sendAct231PauseResearchRequest(self._performTime, self._onReturnMainView, self)
		end
	end

	if self._updateHandle then
		UpdateBeat:RemoveListener(self._updateHandle)
	end

	self._isPerforming = false
end

function V3a6YaMiPerformView:onDestroyView()
	return
end

return V3a6YaMiPerformView
