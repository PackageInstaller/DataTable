-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/view/CompetitionkingtaskView.lua

module("logic.extensions.competitionking.view.CompetitionkingtaskView", package.seeall)

local CompetitionkingtaskView = class("CompetitionkingtaskView", EventTaskTabFrameView)
local JumpStrFields = {
	"jumpStrOne",
	"jumpStrTwo",
	"jumpStrThree"
}

function CompetitionkingtaskView:ctor()
	CompetitionkingtaskView.super.ctor(self)
end

function CompetitionkingtaskView:unbindEvents()
	CompetitionkingtaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for idx, btnJump in ipairs(self._btnJumpList) do
		GameUtil.rmClickHandler(btnJump)
	end
end

function CompetitionkingtaskView:bindEvents()
	CompetitionkingtaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)

	for idx, btnJump in ipairs(self._btnJumpList) do
		GameUtil.addClickHandler(btnJump, GameUtil.handler(self._onClickBtnJump, self, JumpStrFields[idx]))
	end
end

function CompetitionkingtaskView:buildUI()
	CompetitionkingtaskView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txt")
	self._txtTotal = self:getTxt("progressReward/total/txtProgress")
	self._totalItem = self:getGo("progressReward/total/item")
	self._progressReward = self:getGo("progressReward")
	self._playerSliderMo = PlayerSliderMo.New(self._progressReward)
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJumpList = {
		self._btnJump1,
		self._btnJump2,
		self._btnJump3
	}
	self._leftTop = self:getGo("leftTop")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
end

function CompetitionkingtaskView:onExit()
	CompetitionkingtaskView.super.onExit(self)
	self._playerSliderMo:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.CompetitionKingInfoRes, self._refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.CompetitionKingGainPrizeRes, self._sendInfoReq, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_EventTaskTabUpdate, self._sendInfoReq, self)
end

function CompetitionkingtaskView:onEnter()
	CompetitionkingtaskView.super.onEnter(self)

	self._activityType = CompetitionKingController.instance:getActivityType()

	GlobalDispatcher:addListener(GlobalNotify.CompetitionKingInfoRes, self._refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.CompetitionKingGainPrizeRes, self._sendInfoReq, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_EventTaskTabUpdate, self._sendInfoReq, self)

	self._progressCfg = CompetitionKingConfig.instance:getProgressCfgById(self._activityId)
	self._actCfg = CompetitionKingConfig.instance:getActCfgById(self._activityId)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))

	CompetitionKingController.instance:sendPM_CompetitionKingInfoReq(self._activityId)
	self:_initPlayerParams()
	MaterialMgr.setCell(MatType.ACTIVITY_ITEM, self._actCfg.activityItemId, self._totalItem)

	for idx, btnJump in ipairs(self._btnJumpList) do
		local isNeedJump = not string.nilorempty(self._actCfg[JumpStrFields[idx]])

		GameUtil.SetActive(btnJump, isNeedJump)
	end

	GameUtil.SetActive(self._btnTip, not string.nilorempty(self._actCfg.ruleKeyTask))
	GameUtil.SetActive(self._leftTop, false)
end

function CompetitionkingtaskView:setActId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = CompetitionKingController.instance:getActivityId()
	end
end

function CompetitionkingtaskView:_initPlayerParams()
	if not self._progressCfg then
		GameUtil.SetActive(self._progressReward, false)

		return
	end

	GameUtil.SetActive(self._progressReward, true)

	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = self._progressCfg

	function playerParam.getPlayerProgress()
		return MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, self._actCfg.activityItemId)
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.needScore
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return not CompetitionKingModel.instance:getGainProgressPrizeIds(rewardCfg.prizeId) and MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, self._actCfg.activityItemId) >= rewardCfg.needScore
	end

	playerParam.effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return CompetitionKingModel.instance:getGainProgressPrizeIds(rewardCfg.prizeId)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		CompetitionKingController.instance:sendPM_CompetitionKingGainPrizeReq(self._activityId, rewardCfg.prizeId)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function CompetitionkingtaskView:_refreshUI()
	if self._progressCfg then
		self._playerSliderMo:updatePlayerReward()
		self._playerSliderMo:relocation()
	end

	self._txtTotal.text = string.format("累计：%s", MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, self._actCfg.activityItemId))
end

function CompetitionkingtaskView:_sendInfoReq()
	CompetitionKingController.instance:sendPM_CompetitionKingInfoReq(self._activityId)
end

function CompetitionkingtaskView:_updateTabCell(view, cell, data, tag)
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local UIChangeGroup = mainGo:GetComponent(typeof(UIChangeGroup))
	local goSelect = goutil.findChild(mainGo, "select")

	txtName.text = data.pageName

	self:_setIsCellRed(cell, data)
	UIChangeGroup:SetState(self._curTabIdx == tabIdx and 1 or 0)
	goutil.setActive(goSelect, self._curTabIdx == tabIdx)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data, tabIdx))
end

function CompetitionkingtaskView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	GotoMgr.gotoByString(jumpToStr)
end

function CompetitionkingtaskView:_onClickBtnTips()
	local key = self._actCfg.ruleKeyTask

	TipsFacade.instance:openRulesView(key)
end

return CompetitionkingtaskView
