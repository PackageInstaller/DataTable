-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontraildaytaskView.lua

module("logic.extensions.dragontrial.view.DragontraildaytaskView", package.seeall)

local DragontraildaytaskView = class("DragontraildaytaskView", TableViewComponent)

function DragontraildaytaskView:ctor()
	DragontraildaytaskView.super.ctor(self)
end

function DragontraildaytaskView:unbindEvents()
	DragontraildaytaskView.super.unbindEvents(self)
end

function DragontraildaytaskView:bindEvents()
	DragontraildaytaskView.super.bindEvents(self)
end

function DragontraildaytaskView:buildUI()
	DragontraildaytaskView.super.buildUI(self)

	self._scrollList = {}
	self._iconGo = self:getGo("rewardTip/txtNum/icon")
	self._txtNum = goutil.findChildTextComponent(self.mainGO, "rewardTip/txtNum")
end

function DragontraildaytaskView:onExit()
	DragontraildaytaskView.super.onExit(self)
	GlobalDispatcher:removeListener(DragontrialController.PM_DragonTrialGainDailyTaskPrizeRes, self._PM_DragonTrialGainDailyTaskPrizeRes, self)
	GlobalDispatcher:removeListener(DragontrialController.PM_DragonTrialGetInfoRes, self._PM_DragonTrialGetInfoRes, self)
	MaterialMgr.resetAll(self._iconGo)
end

function DragontraildaytaskView:onEnter()
	DragontraildaytaskView.super.onEnter(self)
	GlobalDispatcher:addListener(DragontrialController.PM_DragonTrialGainDailyTaskPrizeRes, self._PM_DragonTrialGainDailyTaskPrizeRes, self)
	GlobalDispatcher:addListener(DragontrialController.PM_DragonTrialGetInfoRes, self._PM_DragonTrialGetInfoRes, self)

	self._activityId = DragontrialModel.instance:getCurrActivityId()
	self._isFirstEnter = true

	self:_updateView()
	self:_setDailyGetCion()
end

function DragontraildaytaskView:_updateView()
	self:_formatCurViewDatas()
	self:reloadData()
end

function DragontraildaytaskView:_formatCurViewDatas()
	local list = DragontrialModel.instance:getDailyTaskCfgsFromModel(self._activityId)
	local isGainList = {}
	local canGainList = {}
	local norList = {}

	for i, v in ipairs(list) do
		local isGain = DragontrialModel.instance:isGainDailyTaskPrize(v.taskId)

		if isGain then
			table.insert(isGainList, v)
		else
			local isCanGain = DragontrialModel.instance:checkCanGainDailyPrizeByTaskId(v.taskId)

			if isCanGain then
				table.insert(canGainList, v)
			else
				table.insert(norList, v)
			end
		end
	end

	table.insertto(canGainList, norList)
	table.insertto(canGainList, isGainList)

	self._curViewDatas = canGainList
end

function DragontraildaytaskView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function DragontraildaytaskView:_updateCell(view, cell, data)
	local btnGoto = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGoto")
	local btnReceive = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnReceive")
	local goItem = goutil.findChild(cell.gameObject, "item")
	local goReceive = goutil.findChild(cell.gameObject, "receive")
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtProgress = goutil.findChildTextComponent(cell.gameObject, "txtProgress")
	local isGain = DragontrialModel.instance:isGainDailyTaskPrize(data.taskId)
	local isCanGain = DragontrialModel.instance:checkCanGainDailyPrizeByTaskId(data.taskId)
	local currProgress = DragontrialModel.instance:getDailyTaskProgress(data.taskId)

	self._scrollList[goItemcon] = self._scrollList[goItemcon] or ItemGroup.New(goItemcon, goItem, nil, nil, true)

	local rewards = string.split(data.prize, "#")

	self._scrollList[goItemcon]:updateWithMoArray(rewards, self._updateRewardCell, self)

	txtDesc.text = data.desc
	txtName.text = data.name
	txtProgress.text = isGain and "" or string.format("%s/%s", math.min(data.maxProgress, currProgress), data.maxProgress)

	goutil.setActive(goReceive, isGain)

	local showJump = not isGain and not isCanGain and not string.nilorempty(data.jumpTo)

	goutil.setActive(btnGoto.gameObject, showJump)
	btnGoto:AddClickListener(function()
		if string.find(data.jumpTo, "func#575") then
			GlobalDispatcher:dispatch(DragontrialController.ForceSelectMainViewTab, DragontrialmainView.TabEnum.Battle)
		else
			GotoMgr.gotoByString(data.jumpTo)
		end
	end)
	goutil.setActive(btnReceive.gameObject, isCanGain)
	btnReceive:AddClickListener(function()
		DragonTrialAgent.instance:sendPM_DragonTrialGainDailyTaskPrizeReq(self._activityId, data.taskId)
	end)
end

function DragontraildaytaskView:_clearTableview(cell)
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")

	if self._scrollList[goItemcon] then
		self._scrollList[goItemcon]:dispose(function(item)
			self:_clearRewardCell(item)
		end)
	end
end

function DragontraildaytaskView:_onReloadFinish()
	if self._isFirstEnter then
		self._isFirstEnter = false

		if DragontrialModel.instance:checkDailyTaskRedPoint() then
			self._tableview:SetOffset(0, false)
		end
	end
end

function DragontraildaytaskView:_updateRewardCell(item, cfgStr)
	MaterialMgr.setCellByCfg(cfgStr, item.mainGO)
end

function DragontraildaytaskView:_clearRewardCell(item)
	MaterialMgr.resetAll(item.mainGO)
end

function DragontraildaytaskView:_PM_DragonTrialGainDailyTaskPrizeRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function DragontraildaytaskView:_setDailyGetCion()
	local cfgs = DragontrialConfig.instance:getDailyTaskCfgs(self._activityId)
	local matType = MatType.ACTIVITY_ITEM
	local matId = self._activityId
	local canGetNum = 0

	for i, v in pairs(cfgs) do
		local arr = string.split(v.prize, "#")
		local arr2 = string.split(arr[1], ":")
		local num = checknumber(arr2[#arr2])

		canGetNum = canGetNum + num
	end

	MaterialMgr.setIcon(self._iconGo, matType, matId)

	self._txtNum.text = canGetNum
end

function DragontraildaytaskView:_PM_DragonTrialGetInfoRes(status)
	if status == 0 then
		self:_updateView()
	end
end

return DragontraildaytaskView
