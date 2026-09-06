-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timeserverpetgain/view/ZhiHuiJiaZuHudView.lua

module("logic.extensions.timeserverpetgain.view.ZhiHuiJiaZuHudView", package.seeall)

local ZhiHuiJiaZuHudView = class("ZhiHuiJiaZuHudView", ActivityGrandSummaryView)

function ZhiHuiJiaZuHudView:_getSumActivityId()
	local key = self._viewPresentor.viewName
	local data = OperationSummaryConfig.instance:getSummaryStartUpData(key)

	if data == nil then
		printError(string.format("key错误,无法读到正确配置.( key = %s )", key))

		return
	end

	return data.activityId
end

function ZhiHuiJiaZuHudView:buildUI()
	ZhiHuiJiaZuHudView.super.buildUI(self)

	self._btnBless = self:getBtn("btnBless")
	self._redPoint = self:getGo("btnBless/redPoint")

	local playerRoot = self:getGo("playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._txtPlayerScore = self:getTxt("txtPlayerScore")
	self._uiCustomInput = UICustomInput.Get(self:getGo("btnTip"))
	self._bubble = self:getGo("bubble")

	goutil.setActive(self._bubble, false)
end

function ZhiHuiJiaZuHudView:bindEvents()
	ZhiHuiJiaZuHudView.super.bindEvents(self)
	self._btnBless:AddClickListener(self._onClickBless, self)
	self._uiCustomInput:AddListener(self._onClickCustomInput, self)
end

function ZhiHuiJiaZuHudView:unbindEvents()
	ZhiHuiJiaZuHudView.super.bindEvents(self)
	self._btnBless:RemoveClickListener()
	self._uiCustomInput:RemoveListener()
end

function ZhiHuiJiaZuHudView:onEnter()
	ZhiHuiJiaZuHudView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GodDiShiTianGetInfoRes, self._onGetdishitianInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.TimeServerPetGainGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.TimeServerPetGainGetProgressPrizeRes, self._onGetProgressPrizeRes, self)
	RedPointController.instance:regRedPoint(self._redPoint, RedPointModel.ID_PetGainPrize1)

	if not GodDiShiTianModel.instance:isRecieveGetInfoRes() then
		GodDiShiTianAgent.instance:sendPM_GodDiShiTianGetInfoReq()
	end

	self._activityId = 162001
	self._cfgActivity = TimeServerPetGainConfig.instance:getActivityCfg(self._activityId)
	self._progressPlanId = self._cfgActivity.progressPlanId
	self._targetRaceId = self._cfgActivity.raceId

	self:_initRewardSlider()
	self:_setPlayerScore()
	TimeServerPetGainAgent.instance:sendPM_TimeServerPetGainGetInfoReq(self._activityId)
	GodDiShiTianAgent.instance:sendPM_GodDiShiTianGetInfoReq()

	if not GodDiShiTianModel.instance:isRecieveGetInfoRes() then
		GodDiShiTianAgent.instance:sendPM_GodDiShiTianGetInfoReq()
	end
end

function ZhiHuiJiaZuHudView:onExit()
	ZhiHuiJiaZuHudView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GodDiShiTianGetInfoRes, self._onGetdishitianInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimeServerPetGainGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimeServerPetGainGetProgressPrizeRes, self._onGetProgressPrizeRes, self)
	RedPointController.instance:unregRedPoint(self._redPoint)
	self._playerSliderMo:onExit()
end

function ZhiHuiJiaZuHudView:updateActivityCell(cell)
	ZhiHuiJiaZuHudView.super.updateActivityCell(self, cell)

	if cell.id == 232 then
		local isOver = cell.over.gameObject.activeSelf

		if not isOver then
			local isNewOver = GodDiShiTianModel.instance:isPassFinalLevel()

			cell.txtOver.text = "挑战完成"

			GameUtil.SetActive(cell.over, isNewOver)
		else
			cell.txtOver.text = "已结束"
		end
	end
end

function ZhiHuiJiaZuHudView:onClickActivityCell(cell, data)
	if cell.id == 232 then
		local isOver = cell.over.gameObject.activeSelf
		local isPass = GodDiShiTianModel.instance:isPassFinalLevel()

		if isOver and isPass then
			return
		end
	end

	ZhiHuiJiaZuHudView.super.onClickActivityCell(self, cell, data)
end

function ZhiHuiJiaZuHudView:_onGetdishitianInfoRes()
	self:onUpdateUI()
end

function ZhiHuiJiaZuHudView:_onClickCustomInput(hover)
	if hover then
		if not self._bubble.activeSelf then
			goutil.setActive(self._bubble, true)
		end
	elseif self._bubble.activeSelf then
		goutil.setActive(self._bubble, false)
	end
end

function ZhiHuiJiaZuHudView:_onClickBless()
	local array = MaterialMgr.changeItemStrArr(self._cfgActivity.buff)
	local contentArray = {}

	for _, str in ipairs(array) do
		local type, id, _ = MaterialMgr.getMatParams(str)
		local cfg = MaterialMgr.getMatCfg(type, id)

		table.insert(contentArray, cfg.desc)
	end

	RedPointController.instance:saveUserOnceRedPoint(RedPointModel.ID_PetGainPrize1, true)
	TipsFacade.instance:openTipWindow(lang("tip"), table.concat(contentArray, "\n"), nil, lang("confirm"))
end

function ZhiHuiJiaZuHudView:_initRewardSlider()
	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = TimeServerPetGainConfig.instance:getProgressCfgList(self._progressPlanId)

	function playerParam.getPlayerProgress()
		return TimeServerPetGainModel.instance:getMoByActivityId(self._activityId):getUserNum()
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.userNum
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return TimeServerPetGainModel.instance:getMoByActivityId(self._activityId):isRewardCanGet(rewardCfg.id, rewardCfg.userNum)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return TimeServerPetGainModel.instance:getMoByActivityId(self._activityId):isRewardGeted(rewardCfg.id)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		TimeServerPetGainAgent.instance:sendPM_TimeServerPetGainGetProgressPrizeReq(self._activityId, rewardCfg.id)
	end

	function playerParam.getRewardTip(rewardCfg)
		local isExist = BagModel.instance:isExistRaceId(self._targetRaceId)

		if not isExist then
			return string.format("获得%s后，即可领取哦", MaterialModel:getMaterialsName(MatType.Pet, self._targetRaceId))
		end

		return ""
	end

	local isSkipAnimation = false

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function ZhiHuiJiaZuHudView:_setPlayerScore()
	self._txtPlayerScore.text = TimeServerPetGainModel.instance:getMoByActivityId(self._activityId):getUserNum()
end

function ZhiHuiJiaZuHudView:_onGetInfoRes()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
	self:_setPlayerScore()
end

function ZhiHuiJiaZuHudView:_onGetProgressPrizeRes()
	self._playerSliderMo:updatePlayerReward()
end

return ZhiHuiJiaZuHudView
