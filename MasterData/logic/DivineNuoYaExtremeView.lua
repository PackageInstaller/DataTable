-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/view/DivineNuoYaExtremeView.lua

module("logic.extensions.divinenuoyachallenge.view.DivineNuoYaExtremeView", package.seeall)

local DivineNuoYaExtremeView = class("DivineNuoYaExtremeView", ViewComponent)

function DivineNuoYaExtremeView:ctor()
	DivineNuoYaExtremeView.super.ctor(self)
end

function DivineNuoYaExtremeView:buildUI()
	DivineNuoYaExtremeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnReset = self:getBtn("btnReset")
	self._transformBtnReset = self._btnReset.gameObject.transform
	self._levelList = {}

	for i = 1, 3 do
		local go = self:getGo("level" .. i)
		local element = {}

		element.btnClg = Framework.ButtonAdapter.GetFrom(go, "btnClg")
		element.txtName = goutil.findChildTextComponent(go, "btnClg/txtName")
		element.clging = goutil.findChild(go, "clging")
		element.resetPos = goutil.findChild(go, "clging/resetPos")
		element.lock = goutil.findChild(go, "lock")
		element.txtLock = goutil.findChildTextComponent(go, "lock/txt")
		element.pass = goutil.findChild(go, "pass")

		table.insert(self._levelList, element)
	end
end

function DivineNuoYaExtremeView:bindEvents()
	DivineNuoYaExtremeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnReset:AddClickListener(self._onClickReset, self)

	for i, v in ipairs(self._levelList) do
		v.btnClg:AddClickListener(function()
			self:_onClickLevel(i)
		end)
	end
end

function DivineNuoYaExtremeView:unbindEvents()
	DivineNuoYaExtremeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function DivineNuoYaExtremeView:onEnter()
	DivineNuoYaExtremeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DivineNuoYaExtremeClgResetStageRes, self._onResetStageRes, self)

	self._activityId = self:getFirstParam()

	self:_refreshView(true)
end

function DivineNuoYaExtremeView:onExit()
	DivineNuoYaExtremeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DivineNuoYaExtremeClgResetStageRes, self._onResetStageRes, self)
end

function DivineNuoYaExtremeView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "divinenuoyaextremeview_rule")
end

function DivineNuoYaExtremeView:_onClickReset()
	local isPassAll = DivineNuoYaChallengeModel.instance:isPassExtremeClgStageProgress(self._activityId)

	if isPassAll then
		return
	end

	local isSelectedPet = DivineNuoYaChallengeModel.instance:isExtremeSelectedPet()

	if not isSelectedPet then
		FloatWordMgr.instance:show("请先选择精灵进入挑战")

		return
	end

	local text = "即将重置此关卡的进度，并重新选择精灵"

	local function okFunc()
		DivineNuoYaChallengeAgent.instance:sendPM_DivineNuoYaExtremeClgResetStageReq(self._activityId)
	end

	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc, cencelFunc, okFuncText, cancelFuncText, alignment)
end

function DivineNuoYaExtremeView:_onClickLevel(level)
	printInfo("test DivineNuoYaExtremeView:_onClickLevel", level)

	local progress = DivineNuoYaChallengeModel.instance:getExtremeBigStageProgress()

	if level <= progress then
		FloatWordMgr.instance:show("已通关")

		return
	end

	if level > progress + 1 then
		FloatWordMgr.instance:show("请先完成前置关卡")

		return
	end

	if DivineNuoYaChallengeModel.instance:isPassExtremeClgStageDaily() then
		FloatWordMgr.instance:show("今天已完成关卡，请明日再来")

		return
	end

	if not DivineNuoYaChallengeModel.instance:isExtremeSelectedPet() then
		UIStateManager.instance:push(ViewName.DivineNuoYaSelectView, self._activityId, level, DivineNuoYaChallengeModel.SelectPet)

		return
	end

	UIStateManager.instance:push(ViewName.DivineNuoYaExtremeClgView, self._activityId, level)
end

function DivineNuoYaExtremeView:_onResetStageRes()
	self:_refreshView()
	UIStateManager.instance:push(ViewName.DivineNuoYaTipView, self._activityId, DivineNuoYaChallengeModel.ResetPet)
end

function DivineNuoYaExtremeView:_refreshView(isInit)
	local isPassAll = DivineNuoYaChallengeModel.instance:isPassExtremeClgStageProgress(self._activityId)

	if isPassAll then
		for i, v in ipairs(self._levelList) do
			goutil.setActive(v.clging, false)
			goutil.setActive(v.lock, false)
			goutil.setActive(v.pass, true)

			if isInit then
				local cfg = DivineNuoYaChallengeConfig.instance:getExtremeStage(self._activityId, i)

				v.txtName.text = cfg.name

				local preCfg = DivineNuoYaChallengeConfig.instance:getExtremeStage(self._activityId, i - 1)

				v.txtLock.text = preCfg and string.format("完成%s后\n次日05:00解锁", preCfg.name) or ""
			end
		end

		goutil.setActive(self._btnReset.gameObject, false)
	else
		local bigStageProgress = DivineNuoYaChallengeModel.instance:getExtremeBigStageProgress()
		local smallStageProgress = DivineNuoYaChallengeModel.instance:getExtremeSmallStageProgress()
		local curBigStage = bigStageProgress + 1
		local isPassToday = DivineNuoYaChallengeModel.instance:isPassExtremeClgStageDaily()

		goutil.setActive(self._btnReset.gameObject, not isPassToday)

		for i, v in ipairs(self._levelList) do
			goutil.setActive(v.clging, curBigStage == i and not isPassToday)
			goutil.setActive(v.lock, curBigStage < i or curBigStage == i and isPassToday)
			goutil.setActive(v.pass, i < curBigStage)

			if isInit then
				local cfg = DivineNuoYaChallengeConfig.instance:getExtremeStage(self._activityId, i)

				v.txtName.text = cfg.name

				local preCfg = DivineNuoYaChallengeConfig.instance:getExtremeStage(self._activityId, i - 1)

				v.txtLock.text = preCfg and string.format("完成%s后\n次日05:00解锁", preCfg.name) or ""
			end
		end

		if self._levelList[curBigStage] then
			self._transformBtnReset.position = self._levelList[curBigStage].resetPos.transform.position
		end
	end
end

return DivineNuoYaExtremeView
