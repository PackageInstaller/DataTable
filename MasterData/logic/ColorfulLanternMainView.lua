-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfullantern/view/ColorfulLanternMainView.lua

module("logic.extensions.colorfullantern.view.ColorfulLanternMainView", package.seeall)

local ColorfulLanternMainView = class("ColorfulLanternMainView", ViewComponent)

function ColorfulLanternMainView:buildUI()
	ColorfulLanternMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnIntro = self:getBtn("btnLinkageIntro")
	self._txtUnlockIntro = self:getTxt("btnLinkageIntro/txtUnlock")
	self._lockBgIntro = self:getGo("btnLinkageIntro/lockBg")
	self._btnMaster = self:getBtn("btnMaster")
	self._txtUnlockMaster = self:getTxt("btnMaster/txtUnlock")
	self._lockBgMaster = self:getGo("btnMaster/lockBg")
	self._btnMake = self:getBtn("btnColorfulLantern")
	self._txtUnlcokMake = self:getTxt("btnColorfulLantern/txtUnlock")
	self._lockBgMake = self:getGo("btnColorfulLantern/lockBg")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtTime = self:getTxt("time/txt")
	self._btnGet = self:getBtn("btnGet")
	self._txtScore = self:getTxt("score/TxtC_Num")
	self._txtGetTip = self:getTxt("txtGetTip")
	self._txtUseTip = self:getTxt("txtUseTip/txt")
	self._puzzleGO = self:getGo("puzzle")
	self._puzzleGroup = {
		self:getGo("puzzle/img_1"),
		self:getGo("puzzle/img_2"),
		self:getGo("puzzle/img_3"),
		self:getGo("puzzle/img_4"),
		self:getGo("puzzle/img_5")
	}
	self._barIcon = self:getGo("score/ImgC_Icon")
	self._getTipIcon = self:getGo("txtGetTip/icon")
	self._getUseIcon = self:getGo("txtUseTip/icon")
end

function ColorfulLanternMainView:bindEvents()
	ColorfulLanternMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnIntro, self._onClickIntro, self)
	GameUtil.addClickHandler(self._btnMaster, self._onClickMaster, self)
	GameUtil.addClickHandler(self._btnMake, self._onClickMake, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickGet, self)

	for i, v in ipairs(self._puzzleGroup) do
		GameUtil.addClickHandler(GameUtil.asBtn(v), function()
			self:_onClickFragment(i)
		end, self)
	end
end

function ColorfulLanternMainView:unbindEvents()
	ColorfulLanternMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnIntro)
	GameUtil.rmClickHandler(self._btnMaster)
	GameUtil.rmClickHandler(self._btnMake)
	GameUtil.rmClickHandler(self._btnGet)

	for i, v in ipairs(self._puzzleGroup) do
		GameUtil.rmClickHandler(GameUtil.asBtn(v))
	end
end

function ColorfulLanternMainView:onEnter()
	ColorfulLanternMainView.super.onEnter(self)
	GlobalDispatcher:addListener(ColorfulLanternController.PM_ColorfulLanternGetInfoRes, self._refreshUI, self)
	GlobalDispatcher:addListener(ColorfulLanternController.PM_ColorfulLanternActivateRes, self._PM_ColorfulLanternActivateRes, self)

	self._unlockCfg = ColorfulLanternConfig.instance:getUnlockCfg()
	self._activityId = ColorfulLanternConfig.instance:getActivityId()
	self._activityType = 182
	self._txtUnlockIntro.text = langPara("绘制<color=#cd7800>%d</color>个拼图解锁", self._unlockCfg[1].unlockCount)
	self._txtUnlockMaster.text = langPara("绘制<color=#cd7800>%d</color>个拼图解锁", self._unlockCfg[2].unlockCount)
	self._txtUnlcokMake.text = langPara("绘制<color=#cd7800>%d</color>个拼图解锁", self._unlockCfg[3].unlockCount)

	local perActivity, perScore, costScore
	local var_5_0, var_5_1, var_5_2 = ColorfulLanternConfig.instance:getScoreTipCfg()

	costScore = var_5_2
	perActivity = var_5_0
	self._txtGetTip.text = langPara("累计获得30/60/100日常活跃度时，可分别获得%d", startTime)
	self._txtUseTip.text = langPara("消耗%d", var_5_2)

	local timeCfg = ActivityDefineConfig.instance:getCfgById(self._activityType, self._activityId)
	local startTime = GameUtil.string2date(timeCfg.startTime)
	local startMin = startTime.min

	if startMin < 10 then
		startMin = string.format("0%d", startMin)
	end

	local endTime = GameUtil.string2date(timeCfg.endTime)
	local endMin = endTime.min

	if startTime < 10 then
		endMin = string.format("0%d", startTime)
	end

	self._txtTime.text = langPara("活动时间：%d.%d %d:%s-%d.%d %d:%s", startTime.month, startTime.day, startTime.hour, startMin, endTime.month, endTime.day, endTime.hour, startTime)

	uGuiUtil.clearImage(self._barIcon)
	uGuiUtil.clearImage(self._getTipIcon)
	uGuiUtil.clearImage(self._getUseIcon)
	uGuiUtil.setSpriteToImage(self._barIcon, nil, GameUrl.getItemIconUrl("icon_shengdan_hsshenshui"))
	uGuiUtil.setSpriteToImage(self._getTipIcon, nil, GameUrl.getItemIconUrl("icon_shengdan_hsshenshui"))
	uGuiUtil.setSpriteToImage(self._getUseIcon, nil, GameUrl.getItemIconUrl("icon_shengdan_hsshenshui"))
	self:_refreshUI()
	ColorfulLanternAgent.instance:sendPM_ColorfulLanternGetInfoReq(self._activityId)
end

function ColorfulLanternMainView:onExit()
	ColorfulLanternMainView.super.onExit(self)
	GlobalDispatcher:removeListener(ColorfulLanternController.PM_ColorfulLanternGetInfoRes, self._refreshUI, self)
	GlobalDispatcher:removeListener(ColorfulLanternController.PM_ColorfulLanternActivateRes, self._PM_ColorfulLanternActivateRes, self)
	uGuiUtil.clearImage(self._barIcon)
	uGuiUtil.clearImage(self._getTipIcon)
	uGuiUtil.clearImage(self._getUseIcon)
end

function ColorfulLanternMainView:_refreshUI()
	local list = ColorfulLanternModel.instance:getFragmentList()

	self._txtScore.text = ColorfulLanternModel.instance:getCurScore()

	for i, v in ipairs(self._puzzleGroup) do
		GameUtil.SetActive(v, true)
	end

	for i, v in ipairs(list) do
		GameUtil.SetActive(self._puzzleGroup[v], false)
	end

	GameUtil.SetActive(self._txtUnlockIntro, self._unlockCfg[1].unlockCount > #list)
	GameUtil.SetActive(self._txtUnlockMaster, self._unlockCfg[2].unlockCount > #list)
	GameUtil.SetActive(self._txtUnlcokMake, self._unlockCfg[3].unlockCount > #list)
end

function ColorfulLanternMainView:_onClickFragment(idx)
	local list = ColorfulLanternModel.instance:getFragmentList()

	for i, v in ipairs(list) do
		if idx == v then
			return
		end
	end

	local needScore = ColorfulLanternConfig.instance:getFragmentCost(idx)
	local score = ColorfulLanternModel.instance:getCurScore()

	if needScore <= score then
		ColorfulLanternAgent.instance:sendPM_ColorfulLanternActivateReq(self._activityId, idx)
	else
		FloatWordMgr.instance:show(lang("积分不足"))
	end
end

function ColorfulLanternMainView:_onClickIntro()
	local list = ColorfulLanternModel.instance:getFragmentList()

	if self._unlockCfg[1].unlockCount <= #list then
		UIStateManager.instance:push(ViewName.ColorfulLanternIntroView)
		SurveyController.instance:reportBehavior(201164)
	else
		FloatWordMgr.instance:show(lang("尚未解锁"))
	end
end

function ColorfulLanternMainView:_onClickMaster()
	local list = ColorfulLanternModel.instance:getFragmentList()

	if self._unlockCfg[2].unlockCount <= #list then
		UIStateManager.instance:push(ViewName.ColorfulLanternMasterView)
		SurveyController.instance:reportBehavior(201165)
	else
		FloatWordMgr.instance:show(lang("尚未解锁"))
	end
end

function ColorfulLanternMainView:_onClickMake()
	local list = ColorfulLanternModel.instance:getFragmentList()

	if self._unlockCfg[3].unlockCount <= #list then
		UIStateManager.instance:push(ViewName.ColorfulLanternMakeView)
		SurveyController.instance:reportBehavior(201166)
	else
		FloatWordMgr.instance:show(lang("尚未解锁"))
	end
end

function ColorfulLanternMainView:_onClickGet()
	GotoMgr.gotoByString("func#5")
	SurveyController.instance:reportBehavior(201167)
end

function ColorfulLanternMainView:_PM_ColorfulLanternActivateRes()
	ColorfulLanternAgent.instance:sendPM_ColorfulLanternGetInfoReq(self._activityId)
end

return ColorfulLanternMainView
