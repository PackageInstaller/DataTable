-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/DragonLimitChallengeView.lua

module("logic.extensions.dragonlords.view.DragonLimitChallengeView", package.seeall)

local DragonLimitChallengeView = class("DragonLimitChallengeView", ViewComponent)

function DragonLimitChallengeView:ctor()
	DragonLimitChallengeView.super.ctor(self)
end

function DragonLimitChallengeView:unbindEvents()
	DragonLimitChallengeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnRules:RemoveClickListener()
	self._resetbtn:RemoveClickListener()
end

function DragonLimitChallengeView:bindEvents()
	DragonLimitChallengeView.super.bindEvents(self)
	self._btnClose:AddClickListener(function()
		self:close()
	end, self)
	self._btnRules:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "dragonlimitchallengeview_rule")
	end, self)
	self._resetbtn:AddClickListener(self._resetBtnOnClick, self)
end

function DragonLimitChallengeView:onExit()
	DragonLimitChallengeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DragonLimitChallenge, self._updateStageList, self)
	GlobalDispatcher:removeListener(GlobalNotify.DragonLordsMain, self._updatePassNum, self)

	for i, v in ipairs(self._stageList) do
		v:exit()
	end

	MaterialMgr.resetAll(self._petIcon)
end

function DragonLimitChallengeView:buildUI()
	DragonLimitChallengeView.super.buildUI(self)

	self._resetbtn = self:getBtn("resetbtn")
	self._btnRules = self:getBtn("topleft/btnRules")
	self._btnClose = self:getBtn("topleft/btn_close")
	self._challengeTip = self:getTxt("right/tip/challengeTip")
	self._buffTip = self:getTxt("right/tip/buffTip")
	self._txtScore = self:getTxt("right/score/txtScore")
	self._petIcon = self:getGo("right/tip/buffTip/con")
	self._stageList = {}

	for i = 1, 5 do
		local cls = LimitStageItemView.New(self:getGo("right/btn_" .. i), i)

		table.insert(self._stageList, cls)
	end
end

function DragonLimitChallengeView:onEnter()
	DragonLimitChallengeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DragonLimitChallenge, self._updateStageList, self)
	GlobalDispatcher:addListener(GlobalNotify.DragonLordsMain, self._updatePassNum, self)

	self._actId = DrogonLordsModel.instance:getActivityId()

	if self._actId <= 0 then
		UIStateManager.instance:clear()
		FloatWordMgr.instance:show("活动已经结束")

		return
	end

	DragonRespectChallengeAgent.instance:sendPM_ExtremeChallengeInfoReq(self._actId)
	self:_loadTextAndIcon()
	goutil.setActive(self._resetbtn.gameObject, true)
end

function DragonLimitChallengeView:_resetBtnOnClick()
	local tipsContent = "是否确认将战斗进度重置回第一关？"

	local function okFunc()
		DragonRespectChallengeAgent.instance:sendPM_ExtremeChallengeRestReq(self._actId)
	end

	local function cencelFunc()
		return
	end

	if DrogonLordsModel.instance:getCurLimitStage() > #self._stageList then
		FloatWordMgr.instance:show("已通关极限挑战，无法重置~")

		return
	end

	TipsFacade.instance:openPopupWindow("重置战斗", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

function DragonLimitChallengeView:_updateStageList()
	for i, v in ipairs(self._stageList) do
		v:initData()
	end

	local passNum = DrogonLordsModel.instance:getPassNum()

	self._txtScore.text = string.format(DragonLordsConfig.instance:getCommonCfg("LIMIT_NUM_TEXT"), passNum, DragonLordsConfig.instance:getCommonCfg("EXTREME_PASS_LIMIT"))

	if DrogonLordsModel.instance:getCurLimitStage() > #self._stageList then
		goutil.setActive(self._resetbtn.gameObject, false)
	end
end

function DragonLimitChallengeView:_updatePassNum()
	local passNum = DrogonLordsModel.instance:getPassNum()
	local limitNum = checknumber(DragonLordsConfig.instance:getCommonCfg("EXTREME_PASS_LIMIT"))

	if limitNum <= passNum then
		FloatWordMgr.instance:show(DragonLordsConfig.instance:getCommonCfg("LIMIT_TIPS_TEXT"))

		return
	end

	CustomFmtController.instance:showMissionView(DrogonLordsModel.instance:getLimitCustomFmtMo())
end

function DragonLimitChallengeView:_loadTextAndIcon()
	self._challengeTip.text = DragonLordsConfig.instance:getCommonCfg("EXTREME_CHALLENGE_TEXT")
	self._buffTip.text = DragonLordsConfig.instance:getCommonCfg("EXTREME_CHALLENGE_BUFF_TEXT")

	local raceId = checknumber(DragonLordsConfig.instance:getCommonCfg("EXTREME_CHALLENGE_PET_ID"))

	MaterialMgr.setIcon(self._petIcon, MatType.PET_SKIN, raceId)
	GameUtil.asBtn(self._petIcon):RemoveClickListener()
	GameUtil.asBtn(self._petIcon):AddClickListener(function()
		MaterialMgr.openGetSource(MatType.Pet, raceId)
	end)
end

return DragonLimitChallengeView
