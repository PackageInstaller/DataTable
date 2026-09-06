-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/view/DreamTeamView.lua

module("logic.extensions.dreamteam.view.DreamTeamView", package.seeall)

local DreamTeamView = class("DreamTeamView", ViewComponent)

function DreamTeamView:ctor()
	DreamTeamView.super.ctor(self)
end

function DreamTeamView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtDay = self:getTxt("remainDay/txtDay")
	self._btnSmallGame = self:getBtn("btnSmallGame")
	self._btnAward = self:getBtn("btnAward")
	self._txtTime = self:getTxt("txtTime")
	self._txtCount = self:getTxt("count/txtCount")
	self._redPoint = self:getGo("btnAward/redPoint")
	self._redPoint2 = self:getGo("btnSmallGame/redPoint")
	self._effectGo = self:getGo("effect")
	self._flyEffectGo1 = self:getGo("flyEffect1")
	self._flyEffectGo2 = self:getGo("flyEffect2")
	self._cellInfos = {}

	for i = 1, 5 do
		local go = self:getGo("team/team" .. i)
		local cellInfo = GameUtil.AddLuaOnce(go, DreamTeamItem)

		cellInfo:buildUI(go)
		table.insert(self._cellInfos, cellInfo)
	end

	self._startPosition = self._btnSmallGame.transform.position
end

function DreamTeamView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnSmallGame:AddClickListener(self._onClickGame, self)
	self._btnAward:AddClickListener(self._onClickAward, self)
end

function DreamTeamView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnSmallGame:RemoveClickListener()
	self._btnAward:RemoveClickListener()
end

function DreamTeamView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.FlipTouchGetInfo, self._onGetInfoRes, self)
	self:_loadEffect()
	self:_resetFlyEffectGo()
	self:_getGameCfgs()
end

function DreamTeamView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.FlipTouchGetInfo, self._onGetInfoRes, self)
	self:_removeEffect()
	self:_removeBaokaiEffect()
	self:_removeTweens()

	if self._cellInfos then
		for i, v in ipairs(self._cellInfos) do
			v:reset()
		end
	end
end

function DreamTeamView:_getGameCfgs()
	local activityId = 24007

	self._cfgFlipActivity = DreamTeamConfig.instance:getActivityCfgById(activityId)

	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.DreamTeam)

	if self._cfgFlipActivity then
		self._activityId = activityId

		FlipTouchAgent.instance:sendPM_FlipTouchGetInfoReq(activityId)
		self:_setTextShow()
		self:_setTeams()
	elseif cfg then
		self._cfgFlipActivity = DreamTeamConfig.instance:getActivityCfgById(cfg.activityId)
		self._activityId = cfg.activityId

		FlipTouchAgent.instance:sendPM_FlipTouchGetInfoReq(cfg.activityId)
		self:_setTextShow()
		self:_setTeams()
	else
		self:_showCloseTip()
	end
end

function DreamTeamView:_onClickClose()
	self:close()
end

function DreamTeamView:_onClickTip()
	local cfgKey = "dreamteam"

	ViewMgr.instance:open(ViewName.RulesView, cfgKey)
end

function DreamTeamView:_onClickGame()
	if not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.DreamTeam, self._activityId) then
		self:_showCloseTip()
	end

	if DreamTeamModel.instance:isGetAllOutPrizeIds() then
		FloatWordMgr.instance:show("你已点亮全部梦梦！")

		return
	end

	if self:_getLeftCount() > 0 then
		FlipGameController.instance:openGameStart(self._activityId)
	else
		FloatWordMgr.instance:show("今日次数已用完，明天再来吧！")
	end
end

function DreamTeamView:_onClickAward()
	local curTotalNum = DreamTeamModel.instance:getGlobalGainNum()

	UIStateManager.instance:open(ViewName.DreamTeamReward, curTotalNum, self._cfgFlipActivity.planId, self._activityId)
end

function DreamTeamView:_showCloseTip()
	local title = "提示"
	local text = "点亮梦之队活动未在活动时间内哦"

	local function func()
		self:_onClickClose()
	end

	local btnText = "知道了"

	TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)
end

function DreamTeamView:_onGetInfoRes()
	self:_setTextShow()
	self:_setRedPoint()
	self:_setBtnState()

	local animData = DreamTeamModel.instance:getAnimData()

	self:_playFlyEffect(animData)
	self:_setTeamsByPlayAnim(animData)
end

function DreamTeamView:_getLeftCountTxt()
	local num = self:_getLeftCount()

	return string.format("今日剩余<color=#ebad32>%d</color>次", num)
end

function DreamTeamView:_getLeftCount()
	return DreamTeamController.instance:getLeftUseTimes(self._activityId)
end

function DreamTeamView:_getActivityTimeTxt(activityId)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.DreamTeam, activityId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	return string.format("活动时间：%02d.%02d - %02d.%02d", startDate.month, startDate.day, endDate.month, endDate.day)
end

function DreamTeamView:_getLeftDay(activityId)
	local leftDay = DreamTeamController.instance:getLeftDay(activityId)

	return string.format("距离梦之队登场剩余：<color=#ebad32>%d</color>天", leftDay)
end

function DreamTeamView:_setTextShow()
	self._txtCount.text = self:_getLeftCountTxt()
	self._txtTime.text = self:_getActivityTimeTxt(self._activityId)
	self._txtDay.text = self:_getLeftDay(self._activityId)
end

function DreamTeamView:_setBtnState()
	self._btnSmallGame.btn.interactable = not DreamTeamModel.instance:isGetAllOutPrizeIds()
end

function DreamTeamView:_setTeams()
	local planId = self._cfgFlipActivity.planId
	local energy = DreamTeamModel.instance:getEnergy()
	local cfgPrizes = DreamTeamConfig.instance:getOutPrizeCfgs(planId)

	if cfgPrizes then
		for i, cfg in ipairs(cfgPrizes) do
			if self._cellInfos[i] then
				local param = {}

				param.activityId = self._activityId
				param.cfg = cfg
				param.curEnergy = 0

				if energy <= cfg.energy then
					param.curEnergy = energy
					energy = 0
				else
					param.curEnergy = cfg.energy
					energy = energy - cfg.energy
				end

				param.view = self
				param.index = i

				self._cellInfos[i]:init(param)
			end
		end
	end
end

function DreamTeamView:_setRedPoint()
	local isShowRed = false
	local cfgs = DreamTeamConfig.instance:getGlobalPrizeCfgs(self._cfgFlipActivity.planId)
	local curTotalNum = DreamTeamModel.instance:getGlobalGainNum()

	for i, v in ipairs(cfgs) do
		local isGeted = DreamTeamModel.instance:isGetedGlobalPrize(v.id)

		if not isGeted and curTotalNum >= v.globalGainNum then
			isShowRed = true

			break
		end
	end

	local isGetAllPrize = DreamTeamModel.instance.instance:isGetAllOutPrizeIds()

	isShowRed = isShowRed and not isGetAllPrize

	self._redPoint:SetActive(isShowRed)

	local leftCount = self:_getLeftCount()

	self._redPoint2:SetActive(leftCount > 0 and not isGetAllPrize)
end

function DreamTeamView:_loadEffect()
	self._dizuoUIEffect = UIEffectManager.instance:playEffect(self, DreamTeamViewPresentor.DiZuoPath, self._effectGo.transform, 0, 0, true, false)

	self._dizuoUIEffect:setParent(self._effectGo.transform)
	self._dizuoUIEffect:setScale(1)

	self._flyUIEffect1 = UIEffectManager.instance:playEffect(self, DreamTeamViewPresentor.TuoWei, self._flyEffectGo1.transform, 0, 0, true, false)

	self._flyUIEffect1:setParent(self._flyEffectGo1.transform)
	self._flyUIEffect1:setScale(1)
	self._flyUIEffect1:setLocalPos(0, 0, 0)

	self._flyUIEffect2 = UIEffectManager.instance:playEffect(self, DreamTeamViewPresentor.TuoWei, self._flyEffectGo2.transform, 0, 0, true, false)

	self._flyUIEffect2:setParent(self._flyEffectGo2.transform)
	self._flyUIEffect2:setScale(1)
	self._flyUIEffect2:setLocalPos(0, 0, 0)
end

function DreamTeamView:_removeEffect()
	if self._dizuoUIEffect then
		UIEffectManager.instance:stopEffect(self._dizuoUIEffect)

		self._dizuoUIEffect = nil
	end

	if self._flyUIEffect1 then
		UIEffectManager.instance:stopEffect(self._flyUIEffect1)

		self._flyUIEffect1 = nil
	end

	if self._flyUIEffect2 then
		UIEffectManager.instance:stopEffect(self._flyUIEffect2)

		self._flyUIEffect2 = nil
	end
end

function DreamTeamView:_setTeamsByPlayAnim(animData)
	if animData then
		local energyList = DreamTeamController.instance:getEnergyList(self._cfgFlipActivity.planId, animData.oldEnergy, animData.newEnergy)

		for i, v in ipairs(self._cellInfos) do
			if energyList[i] and energyList[i].oldEnergy < energyList[i].newEnergy then
				v:playAnimation(energyList[i].oldEnergy, energyList[i].newEnergy)
			end
		end
	else
		self:_setTeams()
	end
end

function DreamTeamView:_resetFlyEffectGo()
	self._flyEffectGo1.transform.position = self._startPosition
	self._flyEffectGo2.transform.position = self._startPosition

	goutil.setActive(self._flyEffectGo1, false)
	goutil.setActive(self._flyEffectGo2, false)
end

function DreamTeamView:_playFlyEffect(animData)
	if animData then
		local effectIndexList = {}
		local energyList = DreamTeamController.instance:getEnergyList(self._cfgFlipActivity.planId, animData.oldEnergy, animData.newEnergy)

		for i, v in ipairs(self._cellInfos) do
			if energyList[i] and energyList[i].oldEnergy < energyList[i].newEnergy then
				table.insert(effectIndexList, i)
			end
		end

		self._tweenList = {}

		for i, index in ipairs(effectIndexList) do
			if self["_flyEffectGo" .. i] and self._cellInfos[index] then
				goutil.setActive(self["_flyEffectGo" .. i], true)

				local endPosition = self._cellInfos[index]:getPosition()
				local tween = self["_flyEffectGo" .. i].transform:DOMove(endPosition, 0.5):OnComplete(function()
					goutil.setActive(self["_flyEffectGo" .. i], false)
					self:_loadBaokaiEffect(endPosition)
				end)

				table.insert(self._tweenList, tween)
			end
		end
	end
end

function DreamTeamView:_removeTweens()
	if self._tweenList then
		for i, v in ipairs(self._tweenList) do
			v:Kill()
		end

		self._tweenList = nil
	end
end

function DreamTeamView:_loadBaokaiEffect(position)
	self._baokaiUIEffect = UIEffectManager.instance:playEffect(self, DreamTeamViewPresentor.BaoKai, self._effectGo.transform, 0, 0, true, false)

	self._baokaiUIEffect:setParent(self._effectGo.transform)
	self._baokaiUIEffect:setScale(1)
	self._baokaiUIEffect:setPos(position.x, position.y, position.z)

	self._baokaiUIEffect.hideEffWhileNotOnTop = false
end

function DreamTeamView:_removeBaokaiEffect()
	if self._baokaiUIEffect then
		UIEffectManager.instance:stopEffect(self._baokaiUIEffect)

		self._baokaiUIEffect = nil
	end
end

return DreamTeamView
