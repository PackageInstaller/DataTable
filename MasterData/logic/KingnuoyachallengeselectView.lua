-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingnuoya/view/KingnuoyachallengeselectView.lua

module("logic.extensions.kingnuoya.view.KingnuoyachallengeselectView", package.seeall)

local KingnuoyachallengeselectView = class("KingnuoyachallengeselectView", ViewComponent)

function KingnuoyachallengeselectView:ctor()
	KingnuoyachallengeselectView.super.ctor(self)
end

function KingnuoyachallengeselectView:unbindEvents()
	KingnuoyachallengeselectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for i, list in ipairs(self._allStepList) do
		for j, btn in ipairs(list) do
			GameUtil.rmClickHandler(btn)
		end
	end
end

function KingnuoyachallengeselectView:bindEvents()
	KingnuoyachallengeselectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChange, self._onClickChange, self)

	for i, list in ipairs(self._allStepList) do
		for j, btn in ipairs(list) do
			GameUtil.addClickHandler(btn, GameUtil.handler(self._goStep, self, i, j))
		end
	end
end

function KingnuoyachallengeselectView:buildUI()
	KingnuoyachallengeselectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._tips = self:getGo("tips")
	self._txtTitleSuc = self:getTxt("tips/bgSuccess/txtTitle")
	self._txtTitleLose = self:getTxt("tips/bgLose/txtTitle")
	self._bgSuccess = self:getGo("tips/bgSuccess")
	self._bgLose = self:getGo("tips/bgLose")
	self._timeBg = self:getGo("timeBg")
	self._txtTime = self:getTxt("timeBg/txtTime")
	self._btnChange = self:getGo("btnChange")
	self._bgImgDay = self:getGo("bgImg/bgCell1")
	self._bgImgNight = self:getGo("bgImg/bgCell2")
	self._dayGroup = self._bgImgDay:GetComponent("CanvasGroup")
	self._nightGroup = self._bgImgNight:GetComponent("CanvasGroup")
	self._step1List = {}

	for i = 1, 4 do
		local btn = self:getGo("btnInfo/step1/btnChallenge_" .. i)

		table.insert(self._step1List, btn)

		local pass = goutil.findChild(btn, "pass")

		GameUtil.SetActive(pass, false)
	end

	self._step2List = {}

	for i = 1, 4 do
		local btn = self:getGo("btnInfo/step2/btnChallenge_" .. i)

		table.insert(self._step2List, btn)

		local pass = goutil.findChild(btn, "pass")

		GameUtil.SetActive(pass, false)
	end

	self._step3List = {}

	for i = 1, 4 do
		local btn = self:getGo("btnInfo/step3/btnChallenge_" .. i)

		table.insert(self._step3List, btn)

		local pass = goutil.findChild(btn, "pass")

		GameUtil.SetActive(pass, false)
	end

	self._allStepList = {}

	table.insert(self._allStepList, self._step1List)
	table.insert(self._allStepList, self._step2List)
	table.insert(self._allStepList, self._step3List)

	self._itemList = {}

	for i = 1, 3 do
		local item = self:getGo("right/item_" .. i)

		table.insert(self._itemList, item)
	end
end

function KingnuoyachallengeselectView:onExit()
	KingnuoyachallengeselectView.super.onExit(self)
	removetimer(self._onTimer, self)
	removetimer(self._goNextState, self)
end

function KingnuoyachallengeselectView:onEnter()
	KingnuoyachallengeselectView.super.onEnter(self)

	self._activityId = KingNuoyaChallengeController.instance:getActivityId()

	if not self._activityId then
		self:close()
	end

	self.addGEvent(self, GlobalNotify.KingNuoyaChallengeUpdate, self._refreshUI, self)

	if KingNuoyaChallengeController.instance.isTypeFinish then
		KingNuoyaChallengeController.instance.isTypeFinish = false

		self:_changeTips(KingNuoyaChallengeController.instance.lastType, true)
	else
		self:_refreshUI()
		KingNuoyaChallengeController.instance:sendGetInfo(self._activityId)
	end
end

function KingnuoyachallengeselectView:_refreshUI()
	self:_stopTime()
	GameUtil.SetActive(self._tips, false)

	local tb = KingNuoyaChallengeModel.instance:getInfo(self._activityId) or {}

	if not tb.finishedType then
		local finishedType = {}
		local lastType = checknumber(tb.lastType)
		local info = tb.info

		if info == nil then
			if lastType == 0 then
				self._curType = KingNuoyaChallengeModel.TYPE_DAY

				if table.indexof(finishedType, self._curType) ~= false then
					self._curType = KingNuoyaChallengeModel.TYPE_NIGHT
				end
			else
				local next, isChange = self:_getNetType(lastType)

				self._curType = next
			end
		else
			self._curType = info.curType
		end

		self:_reInitList(finishedType)

		if self._curType == KingNuoyaChallengeModel.TYPE_DAY then
			self._dayGroup.alpha = 1
			self._nightGroup.alpha = 0
		else
			self._dayGroup.alpha = 0
			self._nightGroup.alpha = 1
		end

		self._curStepId = 1

		if info then
			self:_showInfo(info)
			GameUtil.SetActive(self._btnChange, #finishedType == 2 and lastType == 0)
		else
			GameUtil.SetActive(self._btnChange, (#finishedType == 2 or #finishedType == 0) and lastType == 0)
		end
	end
end

function KingnuoyachallengeselectView:_reInitList(finishedType)
	for i, list in ipairs(self._allStepList) do
		local stepCfg = KingNuoyaChallengeConfig.instance:getStepCfgById(self._activityId, self._curType, i) or {}
		local prize = stepCfg.prize
		local item = self._itemList[i]

		if item then
			local receive = goutil.findChild(item, "receive")
			local con = goutil.findChild(item, "con")

			MaterialMgr.setCellByCfg(prize, con)
			GameUtil.SetActive(receive, table.indexof(finishedType, self._curType) ~= false)
		end

		if not stepCfg.stages then
			local stages = {}

			for j, btn in ipairs(list) do
				GameUtil.SetActive(btn, j <= #stages)

				local pass = goutil.findChild(btn, "pass")

				GameUtil.SetActive(pass, false)

				local lock = goutil.findChild(btn, "lock")

				GameUtil.SetActive(lock, i > 1)

				if table.indexof(finishedType, self._curType) ~= false then
					GameUtil.SetActive(pass, true)
					GameUtil.SetActive(lock, false)
				end

				local top = goutil.findChild(btn, "top")

				GameUtil.SetActive(top, false)

				local attr = goutil.findChild(btn, "attr")
				local stageCfg = KingNuoyaChallengeConfig.instance:getStageCfgById(self._activityId, stages[j]) or {}
				local str = stageCfg.showAttr

				if str then
					local arr = string.splitToNumber(str, "#")

					GameUtil.setUIImageSpriteIdx(attr, arr[1])

					if #arr > 1 then
						GameUtil.SetActive(top, true)

						local attr = goutil.findChild(top, "attr")

						GameUtil.setUIImageSpriteIdx(attr, arr[2])
					end
				end
			end
		end
	end
end

function KingnuoyachallengeselectView:_showInfo(info)
	local curStepId = info.curStepId

	self._curStepId = curStepId

	if not info.finishedStage then
		local finishedStage = {}
		local endTimeMillis = checknumber(info.endTimeMillis) / 1000

		self:_startTime(endTimeMillis)

		local tb = KingNuoyaChallengeModel.instance:getInfo(self._activityId) or {}

		if not tb.gainedStepIds then
			local gainedStepIds = {}
			local gainedPrizeStepIds = {}

			for i, v in ipairs(gainedStepIds) do
				if self._curType == v.typeId then
					gainedPrizeStepIds = v.gainedPrizeStepIds or {}

					break
				end
			end

			local stepCfg = KingNuoyaChallengeConfig.instance:getStepCfgById(self._activityId, self._curType, curStepId) or {}

			if not stepCfg.stages then
				local stages = {}

				for i, list in ipairs(self._allStepList) do
					local item = self._itemList[i]

					if item then
						local receive = goutil.findChild(item, "receive")

						GameUtil.SetActive(receive, table.indexof(gainedPrizeStepIds, i) ~= false)
					end

					for j, btn in ipairs(list) do
						local lock = goutil.findChild(btn, "lock")

						GameUtil.SetActive(lock, false)

						if curStepId == i then
							local sid = stages[j]
							local idx = table.indexof(finishedStage, sid)
							local pass = goutil.findChild(btn, "pass")

							GameUtil.SetActive(pass, idx ~= false)
						elseif curStepId < i then
							GameUtil.SetActive(lock, i > 1)
						else
							local pass = goutil.findChild(btn, "pass")

							GameUtil.SetActive(pass, true)
						end
					end
				end
			end
		end
	end
end

function KingnuoyachallengeselectView:_showCurStep(type)
	self:_stopTime()

	local tb = KingNuoyaChallengeModel.instance:getInfo(self._activityId) or {}

	if not tb.finishedType then
		local finishedType = {}

		self:_reInitList(finishedType)

		if table.indexof(finishedType, type) == false then
			local info = tb.info

			if info and info.curType == type then
				self:_showInfo(info)
			end
		end
	end
end

function KingnuoyachallengeselectView:_stopTime()
	GameUtil.SetActive(self._timeBg, false)

	self._txtTime.text = ""

	removetimer(self._onTimer, self)
	removetimer(self._goNextState, self)
end

function KingnuoyachallengeselectView:_startTime(endTime)
	self._endTime = endTime

	local now = ServerTime.now()
	local leftTime = self._endTime - now

	if leftTime > 0 then
		settimer(1, self._onTimer, self)
		self:_onTimer()
	else
		self:_stopTime()
	end
end

function KingnuoyachallengeselectView:_onTimer()
	local now = ServerTime.now()
	local leftTime = self._endTime - now

	self._txtTime.text = langPara("关卡倒计时：\n<color=#FFDAACFF>%s</color>", GameUtil.FormatTimeSymbol(leftTime))

	GameUtil.SetActive(self._timeBg, true)

	if leftTime <= 0 then
		self:_stopTime()
		self:_changeTips(self._curType, false)
	end
end

function KingnuoyachallengeselectView:_changeTips(type, isWin)
	GameUtil.SetActive(self._tips, true)

	self._tempType = type

	if type == KingNuoyaChallengeModel.TYPE_DAY then
		self._txtTitleSuc.text = "白昼关卡挑战"
		self._txtTitleLose.text = "白昼关卡挑战"
	else
		self._txtTitleSuc.text = "极夜关卡挑战"
		self._txtTitleLose.text = "极夜关卡挑战"
	end

	GameUtil.SetActive(self._bgSuccess, isWin)
	GameUtil.SetActive(self._bgLose, not isWin)
	settimer(1, self._goNextState, self, false)
end

function KingnuoyachallengeselectView:_goNextState()
	UIStateManager.instance:popByName(ViewName.KingNuoyaBuffView)
	GameUtil.SetActive(self._tips, false)

	local next, isChange = self:_getNetType(self._tempType)

	self._curType = next

	if isChange then
		self:_changeBGTypeAniTo(self._curType)
	end

	KingNuoyaChallengeController.instance:sendGetInfo(self._activityId)
end

function KingnuoyachallengeselectView:_getNetType(type)
	local isChange = false
	local next = 0

	next = type == KingNuoyaChallengeModel.TYPE_DAY and KingNuoyaChallengeModel.TYPE_NIGHT or KingNuoyaChallengeModel.TYPE_DAY

	local tb = KingNuoyaChallengeModel.instance:getInfo(self._activityId) or {}

	if not tb.finishedType then
		local finishedType = {}

		if table.indexof(finishedType, next) == false then
			isChange = true

			return next, true
		else
			return type, isChange
		end
	end
end

function KingnuoyachallengeselectView:_changeBGTypeAniTo(toType, time)
	time = time or 1

	UnityTweens.UITweenFade.StopTween(self._bgImgDay)
	UnityTweens.UITweenFade.StopTween(self._bgImgNight)

	if toType == KingNuoyaChallengeModel.TYPE_DAY then
		self._petIconFaceComp1 = UnityTweens.UITweenFade.StartTween(self._bgImgDay.gameObject, 0, 1, time)
		self._petIconFaceComp2 = UnityTweens.UITweenFade.StartTween(self._bgImgNight.gameObject, 1, 0, time)
	else
		self._petIconFaceComp1 = UnityTweens.UITweenFade.StartTween(self._bgImgDay.gameObject, 1, 0, time)
		self._petIconFaceComp2 = UnityTweens.UITweenFade.StartTween(self._bgImgNight.gameObject, 0, 1, time)
	end

	self._petIconFaceComp1.autoDestroy = true
	self._petIconFaceComp2.autoDestroy = true
end

function KingnuoyachallengeselectView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("kingnuoyachallengeview_rules")
end

function KingnuoyachallengeselectView:_goStep(step, idx)
	local tb = KingNuoyaChallengeModel.instance:getInfo(self._activityId) or {}

	if not tb.finishedType then
		local finishedType = {}

		if table.indexof(finishedType, self._curType) ~= false then
			TipsFacade.instance:openCommonTips("当前关卡已经通关")

			return
		end

		if self._curStepId == step then
			self:_goOpenView(idx)
		elseif step < self._curStepId then
			TipsFacade.instance:openCommonTips("当前关卡已经通关")
		else
			TipsFacade.instance:openCommonTips("请先完成内层关卡")
		end
	end
end

function KingnuoyachallengeselectView:_goOpenView(idx)
	local tb = KingNuoyaChallengeModel.instance:getInfo(self._activityId) or {}
	local stepCfg = KingNuoyaChallengeConfig.instance:getStepCfgById(self._activityId, self._curType, self._curStepId) or {}

	if not stepCfg.stages then
		local stages = {}
		local challengeId = stages[idx]
		local info = tb.info

		if info and info.curType == self._curType then
			if not info.finishedStage then
				if table.indexof(info.finishedStage, challengeId) ~= false then
					TipsFacade.instance:openCommonTips("当前关卡已经通关")

					return
				end
			end
		end

		self:_openBuffView(challengeId)
	end
end

function KingnuoyachallengeselectView:_openBuffView(challengeId)
	local tb = KingNuoyaChallengeModel.instance:getInfo(self._activityId) or {}
	local lastType = checknumber(tb.lastType)

	if lastType == 0 then
		TipsFacade.instance:openPopupWindow(lang("tip"), "完成第一次挑战后，将无法自由切换昼夜状态，倒计时结束后自动切换", function()
			UIStateManager.instance:push(ViewName.KingNuoyaBuffView, self._activityId, self._curType, self._curStepId, challengeId)
		end)
	else
		UIStateManager.instance:push(ViewName.KingNuoyaBuffView, self._activityId, self._curType, self._curStepId, challengeId)
	end
end

function KingnuoyachallengeselectView:_onClickChange()
	self._curType = self._curType == KingNuoyaChallengeModel.TYPE_DAY and KingNuoyaChallengeModel.TYPE_NIGHT or KingNuoyaChallengeModel.TYPE_DAY

	self:_changeBGTypeAniTo(self._curType)
	self:_showCurStep(self._curType)
end

return KingnuoyachallengeselectView
