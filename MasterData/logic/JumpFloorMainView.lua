-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/JumpFloorMainView.lua

module("logic.extensions.jumpfloor.view.JumpFloorMainView", package.seeall)

local JumpFloorMainView = class("JumpFloorMainView", ViewComponent)

function JumpFloorMainView:ctor()
	JumpFloorMainView.super.ctor(self)
end

function JumpFloorMainView:buildUI()
	JumpFloorMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnLevel = self:getBtn("btnLevel")
	self._btnEndless = self:getBtn("btnEndless")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._txtTime = self:getTxt("time/txt")
	self._txtLevel = self:getTxt("btnLevel/tip/txtLevel")
	self._txtEndless1 = self:getTxt("btnEndless/tips/txt1")
	self._txtEndless2 = self:getTxt("btnEndless/tips/txt2")
	self._con = self:getGo("con")
	self._effect = self:getGo("effect")
	self._redPoint = self:getGo("btnTask/redPoint")
	self._levelRedPoint = self:getGo("btnLevel/redpoint")
	self._endlessRedPoint = self:getGo("btnEndless/redpoint")

	goutil.setActive(self._redPoint, false)
	goutil.setActive(self._levelRedPoint, false)
	goutil.setActive(self._endlessRedPoint, false)
end

function JumpFloorMainView:bindEvents()
	JumpFloorMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnLevel:AddClickListener(self._onClickLevelMode, self)
	self._btnEndless:AddClickListener(self._onClickEndlessMode, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function JumpFloorMainView:unbindEvents()
	JumpFloorMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnLevel:RemoveClickListener()
	self._btnEndless:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function JumpFloorMainView:onEnter()
	JumpFloorMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DancingLionJumpGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.DancingLionJumpOnChangeDate, self._onChangeDate, self)

	self._activityId = JumpFloorModel.instance:getActivityId()
	self._activityType = JumpFloorModel.instance:getActivityType()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(self._activityType, self._activityId)

	self:_initGameObject()
	self:_showRoleModel()
	self:_loadEffect()

	if not isInTime then
		self:_showPopupView()

		return
	end

	self._cfgActivity = JumpFloorConfig.instance:getActivityCfg(self._activityId)
	self._stageCfgList = JumpFloorConfig.instance:getStageListById(self._cfgActivity.stagePlanId)

	RedPointController.instance:regRedPoint(self._redPoint, RedPointModel.ID_DANCING_LION_JUMP_TASK)
	RedPointController.instance:regRedPoint(self._levelRedPoint, RedPointModel.ID_DANCING_LION_JUMP_LEVEL)
	RedPointController.instance:regRedPoint(self._endlessRedPoint, RedPointModel.ID_C16)

	self._isGetRes = false

	self:_initActivityTime()
	self:_updateDesc()
	JumpFloorAgent.instance:sendPM_DancingLionJumpGetInfoReq(self._activityId)
end

function JumpFloorMainView:onExit()
	JumpFloorMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DancingLionJumpGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.DancingLionJumpOnChangeDate, self._onChangeDate, self)
	RedPointController.instance:unregRedPoint(self._redPoint)
	RedPointController.instance:unregRedPoint(self._levelRedPoint)
	RedPointController.instance:unregRedPoint(self._endlessRedPoint)
	self:_resetRoleModel()
	self:_clearEffect()
end

function JumpFloorMainView:_onClickLevelMode()
	if not self._isGetRes then
		return
	end

	UIStateManager.instance:push(ViewName.JumpFloorLevelView, self._activityId)
end

function JumpFloorMainView:_onClickEndlessMode()
	if not self._isGetRes then
		return
	end

	UIStateManager.instance:push(ViewName.JumpFloorEndlessView, self._activityId)
end

function JumpFloorMainView:_onClickTask()
	UIStateManager.instance:push(ViewName.JumpFloorTaskView, self._activityId)
end

function JumpFloorMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "jumpfloormainview")
end

function JumpFloorMainView:_onGetInfoRes()
	self._isGetRes = true

	self:_updateDesc()
	self:_levelLightLevelRed()
end

function JumpFloorMainView:_onChangeDate()
	local isInTime = ActivityDefineController.instance:isInActivityTimeById(self._activityType, self._activityId)

	if not isInTime then
		self:_showPopupView()

		return
	end

	self:_onGetInfoRes()
end

function JumpFloorMainView:_showPopupView()
	local title = lang("tip")
	local text = lang("outtime")

	local function func()
		self:close()
	end

	TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)
end

function JumpFloorMainView:_initGameObject()
	self._txtTime.text = lang("activitytime")
	self._txtLevel.text = "当前第1关"
end

function JumpFloorMainView:_initActivityTime()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("%s：%02d.%02d 5:00-%02d.%02d 5:00", lang("activitytime"), startDate.month, startDate.day, endDate.month, endDate.day)
end

function JumpFloorMainView:_levelLightLevelRed()
	local leftNum = JumpFloorController.instance:getDailyLeftNum(self._activityId)
	local curCanChallnegeStageNum = JumpFloorController.instance:getLeftOpenNum(self._cfgActivity.stagePlanId)
	local isRedPoint = leftNum > 0 and curCanChallnegeStageNum > 0

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DANCING_LION_JUMP_LEVEL, isRedPoint)
end

function JumpFloorMainView:_updateDesc()
	local finishStageNum = JumpFloorModel.instance:getFinishNum()
	local totalStageNum = #self._stageCfgList

	self._txtLevel.text = finishStageNum < totalStageNum and string.format("当前第%d关", finishStageNum + 1) or "已通关"

	local endlessMaxFloor = JumpFloorModel.instance:getEndlessMaxNum()
	local endlessMaxPercent = JumpFloorModel.instance:getEndlessMaxPercent()

	self._txtEndless1.text = string.format("已经登上%d个木桩", endlessMaxFloor)
	self._txtEndless2.text = string.format("超越全服<color=#65C858FF>%d</color>%%的玩家", endlessMaxPercent)
end

function JumpFloorMainView:_showRoleModel()
	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, 17021, self._con, 1, nil, true, 0, 0)
end

function JumpFloorMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function JumpFloorMainView:_loadEffect()
	self:_clearEffect()

	local path = "20230120/kaizhuangqiwu/fx_ui_kzqw_fw.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._effect.transform, 0, 0, true, false)

	uiEffect:setParent(self._effect.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._bgEffect = uiEffect
end

function JumpFloorMainView:_clearEffect()
	if self._bgEffect then
		UIEffectManager.instance:stopEffect(self._bgEffect)

		self._bgEffect = nil
	end
end

return JumpFloorMainView
