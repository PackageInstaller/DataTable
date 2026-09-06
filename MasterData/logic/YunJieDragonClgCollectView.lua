-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunjiedragonclg/view/YunJieDragonClgCollectView.lua

module("logic.extensions.yunjiedragonclg.view.YunJieDragonClgCollectView", package.seeall)

local YunJieDragonClgCollectView = class("YunJieDragonClgCollectView", ViewComponent)

function YunJieDragonClgCollectView:ctor()
	YunJieDragonClgCollectView.super.ctor(self)
end

function YunJieDragonClgCollectView:unbindEvents()
	YunJieDragonClgCollectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGet)
end

function YunJieDragonClgCollectView:bindEvents()
	YunJieDragonClgCollectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickBtnGet, self)
end

function YunJieDragonClgCollectView:buildUI()
	YunJieDragonClgCollectView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnGet = self:getGo("btnGet")
	self._hasGain = self:getGo("btnGet/hasGain")
	self._txtProgress = self:getTxt("txtProgress")
	self._cellList = {}

	for i = 1, 9 do
		local cell = self:getGo(string.format("goldView/cell%d", i))

		table.insert(self._cellList, cell)
	end
end

function YunJieDragonClgCollectView:onExit()
	YunJieDragonClgCollectView.super.onExit(self)
end

function YunJieDragonClgCollectView:onEnter()
	YunJieDragonClgCollectView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_YunJieDragonClgOneKeyPassRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 572001
	end

	self._stageCfgs = YunJieDragonClgConfig.instance:getStageCfgs(self._activityId)
	self._startTime, self._endTime = ActivityDefineController.instance:getStartTimeAndEndTime(572, self._activityId)

	self:_onUpdate()
end

function YunJieDragonClgCollectView:_onUpdate()
	self._info = YunJieDragonClgModel.instance:getInfo(self._activityId)

	if not self._info.passedStageIds then
		local passedStageIds = {}
		local oneKeyPass = self._info.oneKeyPass
		local hasAllPass = #passedStageIds >= #self._stageCfgs or oneKeyPass

		if oneKeyPass then
			if not #self._stageCfgs then
				local passStageNum = #passedStageIds

				for idx, cellGo in ipairs(self._cellList) do
					local icon = goutil.findChild(cellGo, "icon")
					local hasPass = table.indexof(passedStageIds, idx) or oneKeyPass

					GameUtil.SetActive(icon, hasPass)
				end

				self._txtProgress.text = string.format("当前激活进度：<color=#ffd144>%s/%s</color>", passStageNum, #self._stageCfgs)

				GameUtil.SetActive(self._hasGain, hasAllPass)
			end
		end
	end
end

function YunJieDragonClgCollectView:_onClickBtnGet()
	local hasNeedOpenPhase = YunJieDragonClgController.instance:hasNeedOpenPhase(self._activityId)

	if hasNeedOpenPhase then
		FloatWordMgr.instance:show("尚有未开放的大关，无法一键通关")

		return
	end

	local oneKeyPass = self._info.oneKeyPass

	if oneKeyPass then
		FloatWordMgr.instance:show("已一键通关，无需重复通关")

		return
	end

	local phaseCfgs = YunJieDragonClgConfig.instance:getPhaseCfgs(self._activityId)
	local leftStageNum = YunJieDragonClgController.instance:getOpenStageLeftNum(self._activityId)

	if leftStageNum <= 0 then
		FloatWordMgr.instance:show("暂无剩余可通关关卡")

		return
	end

	local costCfg = YunJieDragonClgConfig.instance:getOneKeyPassCostCfg(self._activityId, leftStageNum)
	local costStr = costCfg.cost
	local matType, matId, matNum = MaterialMgr.getMatParams(costStr)
	local matName = MaterialMgr.getMaterialsName(matType, matId)

	local function sureFunc()
		YunJieDragonClgController.instance:sendPM_YunJieDragonClgOneKeyPassReq(self._activityId, leftStageNum)
	end

	local content = string.format("是否确认消耗[%s*%s]\n一键激活剩余的勋章?\nps:价格根据当前勋章的剩余数量换算\n剩余数量越少，价格越低哦!", matName, matNum)

	TipsFacade:openPopupCostMatViewNew(matType, matId, matNum, content, sureFunc)
end

return YunJieDragonClgCollectView
