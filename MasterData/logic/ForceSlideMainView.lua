-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/forceslide/ForceSlideMainView.lua

module("logic.extensions.forceslide.view.ForceSlideMainView", package.seeall)

local ForceSlideMainView = class("ForceSlideMainView", ViewComponent)
local StoryKey = "20220429.ForceSlideMainView"
local SliderEffectPath = "20220429/lilianghuizong/fx_ui_lilianghuizong_jindu.prefab"

function ForceSlideMainView:ctor()
	ForceSlideMainView.super.ctor(self)
end

function ForceSlideMainView:unbindEvents()
	ForceSlideMainView.super.unbindEvents(self)
	self._btnStory:RemoveClickListener()
	self._btnClose:RemoveClickListener()

	for i = 1, #self._btnMsgs do
		GameUtil.rmClickHandler(self._btnMsgs[i])
	end
end

function ForceSlideMainView:bindEvents()
	ForceSlideMainView.super.bindEvents(self)
	self._btnStory:AddClickListener(self._onClickStory, self)
	self._btnClose:AddClickListener(self.close, self)

	for i = 1, #self._btnMsgs do
		GameUtil.addClickHandler(self._btnMsgs[i], GameUtil.handler(self._onClickMsg, self, i))
	end
end

function ForceSlideMainView:buildUI()
	ForceSlideMainView.super.buildUI(self)

	self._btnStory = self:getBtn("btnStory")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnCell = self:getGo("btnCell")
	self._btnMsgs = {}
	self._txtMsgTitles = {}

	for i = 1, 2 do
		table.insert(self._btnMsgs, self:getBtn(string.format("btnMsg_%d", i)))
		table.insert(self._txtMsgTitles, self:getTxt(string.format("btnMsg_%d/text", i)))

		self._txtMsgTitles[i].text = ""
	end

	self._imgRedPoint = goutil.findChild(self._btnMsgs[1], "imgRedPoint")
	self._jumpContainer = self:getGo("jumpContainer")
	self._txtTime = self:getTxt("time/txtTime")
	self._proSld = self:getSlider("proSld")
	self._txtRepair = self:getTxt("txtRepair")
	self._txtDestory = self:getTxt("txtDestory")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._txtRepair.text = ""
	self._txtDestory.text = ""
	self._sldEffectGo = goutil.findChild(self._proSld, "effect")
	self._mainEffectGo = self:getGo("effect")
	self._activityId = ForceSlideModel.instance:getActivityId()
	self._proWidth = GameUtil.getWidth(self._proSld)
end

function ForceSlideMainView:onExit()
	ForceSlideMainView.super.onExit(self)
	GlobalDispatcher:removeListener(ForceSlideController.AfterGetInfoResponse, self._updateView, self)
	ClockMgr.instance:removeListener(ClockMgr.TickHour, self._checkRefreshTime, self)
	RedPointController.instance:unregRedPoint(self._imgRedPoint)

	if self._jumpItems then
		for _, cell in ipairs(self._jumpItems) do
			GameUtil.rmClickHandler(cell.btn)

			if cell.bHasIcon then
				uGuiUtil.clearImage(cell.icon)
			end

			if cell.redpointId then
				RedPointController.instance:unregRedPoint(cell.redpointId)
			end

			goutil.destroy(cell.mainGo)
		end

		self._jumpItems = {}
	end

	self:_removeMainEffect()
	self:_removeSldEffect()
end

function ForceSlideMainView:onEnter()
	ForceSlideMainView.super.onEnter(self)
	ClockMgr.instance:addListener(ClockMgr.TickHour, self._checkRefreshTime, self)
	GlobalDispatcher:addListener(ForceSlideController.AfterGetInfoResponse, self._updateView, self)

	local activityId = checknumber(ForceSlideConfig.instance:getCommonValue("ACTIVITY_ID"))
	local taskConf = OperationSummaryConfig.instance:getTaskBaseCfg(activityId)

	if taskConf and not string.nilorempty(taskConf.summaryName) then
		self._txtTitle.text = taskConf.summaryName
	end

	self:_addMainEffect()
	self:_addSldEffect()
	self:_initJumps()
	self:_checkRefreshTime()

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(checknumber(GameEnum.ActivityType.ForceSlide), self._activityId)

	self:_setActivityTime(startTime, endTime)
	GameUtil.getUserData(StoryKey, function(value)
		if checknumber(value) == 0 then
			self:_onClickStory()
			GameUtil.saveUserData(StoryKey, 1)
		end
	end)
	RedPointController.instance:regRedPoint(self._imgRedPoint, RedPointModel.ID_FORCE_SLIDE)
end

function ForceSlideMainView:_updateView()
	local model = ForceSlideModel.instance
	local repairValue = model:getRepairValue()
	local destoryValue = model:getDestoryValue()
	local totalValue = repairValue + destoryValue

	if totalValue == 0 then
		totalValue = 1
	end

	local repairPercentT = repairValue / totalValue
	local repairPercent = math.floor(repairPercentT * 100)
	local destoryPercent = 100 - repairPercent

	self._txtRepair.text = langPara("修复度%s", string.format("%d%%", repairPercent))
	self._txtDestory.text = langPara("崩坏度%s", string.format("%d%%", destoryPercent))
	self._proValue = repairPercentT

	self._proSld:SetValue(repairPercentT)

	for i = 1, 2 do
		local conf = ForceSlideConfig.instance:getTabConf(self._activityId, i)
		local value = model:getTabValue(i)

		self._txtMsgTitles[i].text = string.format(langPara(conf.desc, string.format("%d/h", value)))
	end

	self:_updateSldEffectPos()
end

function ForceSlideMainView:_checkRefreshTime()
	ForceSlideController.instance:sendGetInfo()
	self:_updateJumps()
end

function ForceSlideMainView:_setActivityTime(startTime, endTime)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

function ForceSlideMainView:_createJumpBtn(data)
	local cell = {}
	local btnT = goutil.cloneAndSetParent(self._btnCell, self._jumpContainer.transform)
	local btn = btnT:GetComponent(goutil.Type_UIButton)
	local txtName = goutil.findChildTextComponent(btn, "text")
	local txtTag = goutil.findChildTextComponent(btn, "txtTag")
	local imgRedPoint = goutil.findChild(btn, "imgRedPoint")

	cell.btn = btn
	cell.mainGo = btnT
	cell.imgRedPoint = imgRedPoint
	cell.icon = goutil.findChild(btn, "icon")
	cell.newGo = goutil.findChild(btn, "new")
	cell.data = data

	btnT:SetActive(true)
	table.insert(self._jumpItems, cell)

	txtName.text = data.name
	txtTag.text = data.tips

	if data.pos then
		GameUtil.setLocalPos(btn, data.pos[1] or 0, data.pos[2] or 0, 0)
	end

	if not string.nilorempty(data.icon) then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/%s.png", data.icon)

		uGuiUtil.setSpriteToImage(cell.icon, spriteType, spriteName)

		cell.bHasIcon = true
	end

	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickJump, self, cell, data))
end

function ForceSlideMainView:_updateJumpBtn(data, cell)
	local actCfg = ActivityDefineConfig.instance:getCfgById(data.activityType, data.activityId)
	local bInPeriod = GameUtil.checkIsInTimePeriod(actCfg.startTime, actCfg.endTime)

	cell.mainGo:SetActive(bInPeriod)
	RedPointController.instance:unregRedPoint(data.redpointId)
	cell.imgRedPoint:SetActive(false)

	if not string.nilorempty(data.redpointId) then
		cell.redpointId = data.redpointId

		RedPointController.instance:regRedPoint(cell.imgRedPoint, unpack(string.split(data.redpointId or "", "#")))
	end

	local isNew = OpSummaryModel.instance:isNewItem(data, math.floor(data.planId / 1000))

	goutil.setActive(cell.newGo, isNew)
end

function ForceSlideMainView:_initJumps()
	local activityId = checknumber(ForceSlideConfig.instance:getCommonValue("ACTIVITY_ID"))

	self._jumpItems = {}

	local taskItemsConfs = OperationSummaryConfig.instance:getTaskItemsCfg(activityId)

	for _, data in pairs(taskItemsConfs) do
		self:_createJumpBtn(data)
	end
end

function ForceSlideMainView:_updateJumps()
	if self._jumpItems then
		for _, cell in ipairs(self._jumpItems) do
			self:_updateJumpBtn(cell.data, cell)
		end
	end
end

function ForceSlideMainView:_removeMainEffect()
	if self._mainEffect then
		UIEffectManager.instance:stopEffect(self._mainEffect)

		self._mainEffect = nil
	end
end

function ForceSlideMainView:_removeSldEffect()
	if self._sldEffect then
		UIEffectManager.instance:stopEffect(self._sldEffect)

		self._sldEffect = nil
	end
end

function ForceSlideMainView:_addMainEffect()
	self:_removeMainEffect()

	local activityId = checknumber(ForceSlideConfig.instance:getCommonValue("ACTIVITY_ID"))
	local taskConf = OperationSummaryConfig.instance:getTaskBaseCfg(activityId)

	if not string.nilorempty(taskConf.effect) then
		local effectPath = taskConf.effect

		if not string.find(effectPath, ".prefab") then
			effectPath = string.format("%s.prefab", taskConf.effect)
		end

		local eff = UIEffectManager.instance:playEffect(self, effectPath, self._mainEffectGo.transform, 0, 0, true)

		eff:setParent(self._mainEffectGo.transform)
		eff:setScale(1)
		eff:setLocalPos(0, 0, 0)

		self._mainEffect = eff
	end
end

function ForceSlideMainView:_addSldEffect()
	self:_removeSldEffect()

	local eff = UIEffectManager.instance:playEffect(self, SliderEffectPath, self._sldEffectGo.transform, 0, 0, true)

	eff:setParent(self._sldEffectGo.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._sldEffect = eff
end

function ForceSlideMainView:_updateSldEffectPos()
	if self._sldEffectGo then
		local value = ((self._proValue or 0) - 0.5) * self._proWidth

		Framework.TransformUtil.SetLocalPos(self._sldEffectGo.transform, value, 0, 0)
	end
end

function ForceSlideMainView:_onClickStory()
	local storyId = checknumber(ForceSlideConfig.instance:getCommonValue("STORY_ID"))

	GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
end

function ForceSlideMainView:_onClickJump(cell, data)
	local actCfg = ActivityDefineConfig.instance:getCfgById(data.activityType, data.activityId)

	if GameUtil.checkIsInTimePeriod(actCfg.startTime, actCfg.endTime) == false then
		FloatWordMgr.instance:show("不在开放时间内噢~")

		return
	end

	if not string.nilorempty(data.gotoStr) then
		SurveyController.instance:reportBehavior(data.reportBehavior)
		GotoMgr.gotoByString(data.gotoStr)
		OpSummaryModel.instance:setNewItem(data)
	elseif checknumber(data.funcId) > 0 then
		SurveyController.instance:reportBehavior(data.reportBehavior)

		if string.nilorempty(data.params) then
			FuncOpenController.instance:openFunc(data.funcId)
			OpSummaryModel.instance:setNewItem(data)
		else
			local arr = string.split(data.params, "#")

			FuncOpenController.instance:openFunc(data.funcId, unpack(arr))
			OpSummaryModel.instance:setNewItem(data)
		end
	elseif not string.nilorempty(data.viewname) then
		SurveyController.instance:reportBehavior(data.reportBehavior)
		FuncOpenController.instance:openFuncByViewName(data.viewname)
		OpSummaryModel.instance:setNewItem(data)
	end
end

local SurveyIds = {
	200939,
	200940
}

function ForceSlideMainView:_onClickMsg(index)
	SurveyController.instance:reportBehavior(SurveyIds[index])

	if index == 1 then
		RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_FORCE_SLIDE)
	end

	ViewMgr.instance:open(ViewName.ForceSlideTipsView, index, self._btnMsgs[index])
end

return ForceSlideMainView
