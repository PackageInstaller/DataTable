-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/WaterTianYanClgBuildView.lua

module("logic.extensions.watertianyan.view.WaterTianYanClgBuildView", package.seeall)

local WaterTianYanClgBuildView = class("WaterTianYanClgBuildView", ViewComponent)

function WaterTianYanClgBuildView:ctor()
	WaterTianYanClgBuildView.super.ctor(self)
end

function WaterTianYanClgBuildView:buildUI()
	WaterTianYanClgBuildView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnBuff = self:getBtn("btnBuff")
	self._btnRefresh = self:getBtn("btnRefresh")
	self._txtTime = self:getTxt("time/txt")
	self._txtChallenge = self:getTxt("challengeNum/txtChallenge")
	self._cell = self:getGo("cell")
	self._stages = self:getGo("stages")

	goutil.setActive(self._cell, false)

	self._cellList = {}

	for i = 1, 5 do
		local go = goutil.cloneAndSetParent(self._cell, self._stages.transform, "cell" .. i)

		goutil.setActive(go, true)

		local element = {}

		element.go = go
		element.con = goutil.findChild(go, "con")
		element.txtName = goutil.findChildTextComponent(go, "txtName")
		element.txtNum = goutil.findChildTextComponent(go, "txtNum")
		element.outLineEx = element.txtNum.gameObject:GetComponent(ComponentType.OutlineEx)
		element.btn = Framework.ButtonAdapter.GetFrom(go, "btn")
		element.bgSpriteChange = goutil.findChild(go, "bg"):GetComponent(ComponentType.UIImageSpriteChange)
		self._cellList[i] = element
	end

	local recordPos = self._stages:GetComponent("TestRecordPos")

	recordPos:LoadPlan(0)
end

function WaterTianYanClgBuildView:bindEvents()
	WaterTianYanClgBuildView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)
	self._btnRefresh:AddClickListener(self._onClickRefresh, self)
end

function WaterTianYanClgBuildView:unbindEvents()
	WaterTianYanClgBuildView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
end

function WaterTianYanClgBuildView:onEnter()
	WaterTianYanClgBuildView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.WaterTianYanRefreshBuildingStageListRes, self._onRefreshBuildingStageListRes, self)

	self._activityId = self:getFirstParam()
	self._activityType = WaterTianYanModel.instance:getActivityType()
	self._cfgActivity = WaterTianYanConfig.instance:getActivityCfg(self._activityId)

	self:_initActivityTime()
	self:_updateChallengeNum()
	self:_updateStages()
end

function WaterTianYanClgBuildView:onExit()
	WaterTianYanClgBuildView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.WaterTianYanRefreshBuildingStageListRes, self._onRefreshBuildingStageListRes, self)
end

function WaterTianYanClgBuildView:_onClickTip()
	local rule = self._cfgActivity.buildRule

	UIStateManager.instance:push(ViewName.RulesView, rule)
end

function WaterTianYanClgBuildView:_getBuffView()
	return WaterTianYanEnum.ViewNames[self._activityId][WaterTianYanEnum.ViewTypes_BuffView]
end

function WaterTianYanClgBuildView:_onClickBuff()
	UIStateManager.instance:push(self:_getBuffView(), self._activityId, WaterTianYanModel.BuffViewBuild)
end

function WaterTianYanClgBuildView:_onClickRefresh()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._cfgActivity.buildingRefreshCost)
	local text = string.format("是否消耗%s*%d，刷新所有关卡？", MaterialMgr.getMaterialsName(matType, matId), matNum)

	local function okFunc()
		if not MaterialMgr.getMatEnough(self._cfgActivity.buildingRefreshCost) then
			FloatWordMgr.instance:show(string.format("%s道具不足", MaterialMgr.getMaterialsName(matType, matId)))

			return
		end

		WaterTianYanAgent.instance:sendPM_WaterTianYanRefreshBuildingStageListReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
end

function WaterTianYanClgBuildView:_onRefreshBuildingStageListRes()
	FloatWordMgr.instance:show("刷新成功")
	self:_updateStages()
end

function WaterTianYanClgBuildView:_initActivityTime()
	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
end

function WaterTianYanClgBuildView:_updateChallengeNum()
	local usedNum = WaterTianYanModel.instance:getBuildingStageChallengeTimes(self._activityId)
	local maxNum = self._cfgActivity.buildingDailyChallengeTimes
	local leftNum = Mathf.Max(maxNum - usedNum, 0)

	if leftNum > 0 then
		if not ColorConst.Green then
			local colorStr = ColorConst.Red

			self._txtChallenge.text = string.format("今日可挑战次数：<color=#%s>%d</color>/%d", colorStr, leftNum, maxNum)
		end
	end
end

function WaterTianYanClgBuildView:_updateStages()
	local stageIds = WaterTianYanModel.instance:getBuildingStageIds(self._activityId)

	for i, stageId in ipairs(stageIds) do
		if self._cellList[i] then
			local element = self._cellList[i]
			local cfg = WaterTianYanConfig.instance:getBuildingStageCfg(self._activityId, stageId)

			if cfg then
				local matType, id, matNum = MaterialMgr.getMatParams(cfg.passPrize)

				element.txtNum.text = matNum

				local cfgCreep = WaterTianYanConfig.instance:getMonsterCfg(cfg.creepsMasterId)

				if cfgCreep then
					element.txtName.text = cfgCreep.name or ""
				end

				element.bgSpriteChange:SetState(Mathf.Clamp(cfg.typeId - 1, 0, 1))

				element.outLineEx.OutlineColor = Mathf.Clamp(cfg.typeId - 1, 0, 1) == 1 and Color.New(0.027450980392156862, 0.5333333333333333, 0.788235294117647, 1) or Color.New(0.6313725490196078, 0.2549019607843137, 0.13333333333333333, 1)
			end

			element.btn:AddClickListener(function()
				self:_onClickStage(stageId, i)
			end)
		end
	end
end

function WaterTianYanClgBuildView:_clearStages()
	for i, v in ipairs(self._cellList) do
		MaterialMgr.ResetAll(v.con)
		v.btn:RemoveClickListener()
	end
end

function WaterTianYanClgBuildView:_onClickStage(stageId, index)
	local usedNum = WaterTianYanModel.instance:getBuildingStageChallengeTimes(self._activityId)
	local maxNum = self._cfgActivity.buildingDailyChallengeTimes
	local leftNum = Mathf.Max(maxNum - usedNum, 0)

	if leftNum <= 0 then
		FloatWordMgr.instance:show("今日无可挑战次数")

		return
	end

	WaterTianYanController.instance:openBuildMissionView(self._activityId, stageId, index)
end

return WaterTianYanClgBuildView
