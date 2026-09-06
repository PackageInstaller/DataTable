-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterji/view/SummonMasterJiExtremeView.lua

module("logic.extensions.summonmasterji.view.SummonMasterJiExtremeView", package.seeall)

local SummonMasterJiExtremeView = class("SummonMasterJiExtremeView", ViewComponent)

function SummonMasterJiExtremeView:ctor()
	SummonMasterJiExtremeView.super.ctor(self)
end

function SummonMasterJiExtremeView:buildUI()
	SummonMasterJiExtremeView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnReset = self:getBtn("btnReset")

	local pathPrefix = "textPanel/tableview/viewport/content/"

	self._txtDesc1 = self:getTxt(pathPrefix .. "desc1/txtDesc1")
	self._txtDesc2 = self:getTxt(pathPrefix .. "desc2/txtDesc2")
	self._txtDesc3 = self:getTxt(pathPrefix .. "desc3/txtDesc3")
	self._txtDesc = self:getTxt("txtDesc")
	self._txtLeftNum = self:getTxt("txtLeftNum")
	self._levelList = {}

	local pathPrefix2 = "levelPanel/level"

	for i = 1, 5 do
		local element = {}

		element.txtName = self:getTxt(pathPrefix2 .. i .. "/txt")
		element.txtScore = self:getTxt(pathPrefix2 .. i .. "/txtScore")
		element.mask = self:getGo(pathPrefix2 .. i .. "/mask")
		element.btnGo = self:getGo(pathPrefix2 .. i)

		table.insert(self._levelList, element)
	end
end

function SummonMasterJiExtremeView:bindEvents()
	SummonMasterJiExtremeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)

	for i, v in ipairs(self._levelList) do
		GameUtil.addClickHandler(v.btnGo, GameUtil.handler(self._onClickLevel, self, i))
	end
end

function SummonMasterJiExtremeView:unbindEvents()
	SummonMasterJiExtremeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)

	for i, v in ipairs(self._levelList) do
		GameUtil.rmClickHandler(v.btnGo)
	end
end

function SummonMasterJiExtremeView:onEnter()
	SummonMasterJiExtremeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SummonMasterJiResetExtremeRes, self._onResetExtremeRes, self)

	self._activityId = self:getFirstParam()
	self._cfgActivity = SummonMasterJiConfig.instance:getActivityCfg(self._activityId)

	self:_initTextPanel()
	self:_initLevelPanel()
	self:_updateResetShow()
end

function SummonMasterJiExtremeView:onExit()
	SummonMasterJiExtremeView.super.onExit(self)
end

function SummonMasterJiExtremeView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "summonmasterjiextremeview_rule")
end

function SummonMasterJiExtremeView:_onClickReset()
	local curUsedTimes = SummonMasterJiModel.instance:getDailyHasResetTimes(self._activityId)
	local maxTimes = self._cfgActivity.extremeDailyResetTimes

	if maxTimes <= curUsedTimes then
		FloatWordMgr.instance:show("次数已用尽 明日再来")

		return
	end

	local totalScore = SummonMasterJiModel.instance:getExtremeTotalScore(self._activityId)

	if totalScore == 0 then
		FloatWordMgr.instance:show("总积分为0，无需重置")

		return
	end

	local text = "是否确认重置当前所有关卡积分，确认后将把积分全部清空"
	local activityId = self._activityId

	local function okFunc()
		SummonMasterJiAgent.instance:sendPM_SummonMasterJiResetExtremeReq(activityId)
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
end

function SummonMasterJiExtremeView:_onClickLevel(stageId)
	if SummonMasterJiController.instance:isOpenExtremeStage(self._activityId, stageId) then
		UIStateManager.instance:push(ViewName.SummonMasterJiExtremeClgView, self._activityId, stageId)
	else
		local cfg = SummonMasterJiConfig.instance:getExtremeStageCfg(self._activityId, stageId)

		if cfg then
			local date = GameUtil.string2date(cfg.openTime)

			FloatWordMgr.instance:show(string.format("%d月%d日 5:00开启", date.month, date.day))
		end
	end
end

function SummonMasterJiExtremeView:_onResetExtremeRes()
	self:_updateTextPanel()
	self:_updateLevelPanel()
	self:_updateResetShow()
end

function SummonMasterJiExtremeView:_initTextPanel()
	printInfo("test SummonMasterJiExtremeView:_initTextPanel", SummonMasterJiConfig.instance:getCommonValue("TEXT_DESC1"))

	self._txtDesc1.text = SummonMasterJiConfig.instance:getCommonValue("TEXT_DESC1")
	self._txtDesc3.text = SummonMasterJiController.instance:getExtremeAllDesc(self._activityId)
	self._txtDesc.text = SummonMasterJiConfig.instance:getCommonValue("TEXT_DESC2")

	self:_updateTextPanel()
end

function SummonMasterJiExtremeView:_updateTextPanel()
	local totalScore = SummonMasterJiModel.instance:getExtremeTotalScore(self._activityId)

	self._txtDesc2.text = SummonMasterJiController.instance:getExtremeDescByScore(self._activityId, totalScore)
end

function SummonMasterJiExtremeView:_initLevelPanel()
	for i, v in ipairs(self._levelList) do
		local cfg = SummonMasterJiConfig.instance:getExtremeStageCfg(self._activityId, i)

		v.txtName.text = cfg.name

		goutil.setActive(v.mask, not SummonMasterJiController.instance:isOpenExtremeStage(self._activityId, i))
	end

	self:_updateLevelPanel()
end

function SummonMasterJiExtremeView:_updateLevelPanel()
	for i, v in ipairs(self._levelList) do
		goutil.setActive(v.mask, not SummonMasterJiController.instance:isOpenExtremeStage(self._activityId, i))

		local score = SummonMasterJiModel.instance:getExtremeScoreByStageId(self._activityId, i)

		v.txtScore.text = string.format("积分：" .. score)
	end
end

function SummonMasterJiExtremeView:_updateResetShow()
	local curUsedTimes = SummonMasterJiModel.instance:getDailyHasResetTimes(self._activityId)
	local leftTimes = self._cfgActivity.extremeDailyResetTimes - curUsedTimes

	leftTimes = Mathf.Max(0, leftTimes)
	self._txtLeftNum.text = string.format("次数：%d/%d", leftTimes, self._cfgActivity.extremeDailyResetTimes)
end

return SummonMasterJiExtremeView
