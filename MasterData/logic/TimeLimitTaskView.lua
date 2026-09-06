-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/diamondtask/view/TimeLimitTaskView.lua

module("logic.extensions.diamondtask.view.TimeLimitTaskView", package.seeall)

local TimeLimitTaskView = class("TimeLimitTaskView", ViewComponent)

function TimeLimitTaskView:buildUI()
	TimeLimitTaskView.super.buildUI(self)

	self._tableview = self:getGo("tableview"):GetComponent("UITableview")
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)
end

function TimeLimitTaskView:bindEvents()
	TimeLimitTaskView.super.bindEvents(self)
end

function TimeLimitTaskView:unbindEvents()
	TimeLimitTaskView.super.unbindEvents(self)
end

function TimeLimitTaskView:onEnter()
	TimeLimitTaskView.super.onEnter(self)
	self:_initScrollList()
	self:_updateCurViewDatas()
	self._tableview:ReloadData()
end

function TimeLimitTaskView:onExit()
	TimeLimitTaskView.super.onExit(self)
	self:_disposeScrollList()
end

function TimeLimitTaskView:_initScrollList()
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._curViewDatas = {}
end

function TimeLimitTaskView:_updateCurViewDatas()
	table.clear(self._curViewDatas)

	local cfgs = TaskConfig.instance:getAllTaskSummarizeCfg()

	for i, v in ipairs(cfgs) do
		table.insert(self._curViewDatas, v)
	end

	table.sort(self._curViewDatas, function(a, b)
		return a.rankId < b.rankId
	end)
end

function TimeLimitTaskView:_disposeScrollList()
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}

	self._tableview:UnRegisterAllCallbacks()
end

function TimeLimitTaskView:_numInView()
	return #self._curViewDatas
end

function TimeLimitTaskView:_cellSize(view, idx)
	return 482, 174
end

function TimeLimitTaskView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function TimeLimitTaskView:_updateCell(view, cell, data)
	local btnGo = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGo")
	local imgChange = goutil.findChild(cell.gameObject, "btnGo"):GetComponent("UIImageSpriteChange")
	local btnTxt = goutil.findChildTextComponent(cell.gameObject, "btnGo/Text")
	local txtTaskName = goutil.findChildTextComponent(cell.gameObject, "txtTaskName")
	local txtOpenTime = goutil.findChildTextComponent(cell.gameObject, "txtOpenTime")
	local rewardGoList = {}

	for i = 1, 3 do
		rewardGoList[i] = goutil.findChild(cell.gameObject, "reward" .. i)
	end

	local cfg = data

	txtTaskName.text = cfg.name
	txtOpenTime.text = cfg.show

	self:_setReward(rewardGoList, cfg.reward)
	self:_setBtn(btnGo, btnTxt, imgChange, cfg)
end

function TimeLimitTaskView:_clearTableview(cell)
	local rewardGoList = {}

	for i = 1, 3 do
		rewardGoList[i] = goutil.findChild(cell.gameObject, "reward" .. i)
	end

	self:_resetReward(rewardGoList)
end

function TimeLimitTaskView:_setReward(rewardGoList, rewardStr)
	local rewardList = string.split(rewardStr, "#")

	for i, v in ipairs(rewardList) do
		if rewardGoList[i] then
			MaterialMgr.setCellByCfg(v, rewardGoList[i])
		end
	end
end

function TimeLimitTaskView:_resetReward(rewardGoList)
	for i, v in ipairs(rewardGoList) do
		MaterialMgr.resetAll(v)
	end
end

function TimeLimitTaskView:_setBtn(btn, btnTxt, imgChange, cfg)
	local isInTime = self:_isInAvailableTime(cfg)

	btnTxt.text = isInTime and "前往" or "未解锁"

	imgChange:SetState(isInTime and 1 or 0)
	btn:AddClickListener(function()
		if isInTime then
			local isOpen = FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)

			if isOpen then
				FuncOpenController.instance:openFunc(cfg.funcId)
				GlobalDispatcher:dispatch(GlobalNotify.CloseDiamondTask)
			else
				local str = FuncOpenModel.instance:getFuncLockDescription(cfg.funcId)

				FloatWordMgr.instance:show(str)
			end
		else
			FloatWordMgr.instance:show("当前玩法不在活动时间内哦")
		end
	end)
end

function TimeLimitTaskView:_resetBtn(btn)
	btn:RemoveClickListener()
end

function TimeLimitTaskView:_isInAvailableTime(cfg)
	local curDate = ServerTime.nowDateServerLook()

	if (cfg.type == 1 or cfg.type == 2 or cfg.type == 3 or cfg.type == 4) and string.nilorempty(cfg.onlineTime) then
		return false
	end

	if string.nilorempty(cfg.refreshTime) and (cfg.type == 5 or cfg.type == 6) then
		return false
	end

	if cfg.type == 1 then
		if self:_isInTimeRange(cfg.onlineTime, curDate.year, curDate.month) then
			return true
		end
	elseif cfg.type == 2 then
		local weekParam = {}

		weekParam.isMatch = self:_isMatchWeekDay(curDate.wday, cfg.weekopenTime)

		if self:_isInTimeRange(cfg.onlineTime, curDate.year, curDate.month, curDate.day, weekParam) then
			return true
		end
	elseif cfg.type == 3 then
		if self:_isInTimeRange(cfg.onlineTime, curDate.year, curDate.month, curDate.day) then
			return true
		end
	elseif cfg.type == 4 then
		if self:_isInTimeRange(cfg.onlineTime) then
			return true
		end
	elseif cfg.type == 5 then
		return true
	elseif cfg.type == 6 then
		return true
	end

	return false
end

function TimeLimitTaskView:_isMatchWeekDay(curWeekDay, weekopenTime)
	if string.nilorempty(weekopenTime) then
		return false
	end

	local list = string.split(weekopenTime, "&")

	for i, v in ipairs(list) do
		if curWeekDay == checknumber(v) then
			return true
		end
	end

	return false
end

function TimeLimitTaskView:_isInTimeRange(onlineTime, coverYear, coverMonth, coverDay, weekParam)
	local timeRangeList = string.split(onlineTime, "&")

	for i, v in ipairs(timeRangeList) do
		local timeStrList = string.split(v, "#")

		if timeStrList[1] and timeStrList[2] then
			local startDate = GameUtil.string2date(timeStrList[1])
			local endDate = GameUtil.string2date(timeStrList[2])

			if coverYear then
				startDate.year = coverYear
				endDate.year = coverYear
			end

			if coverMonth then
				startDate.month = coverMonth
				endDate.month = coverMonth
			end

			if coverDay then
				startDate.day = coverDay
				endDate.day = coverDay
			end

			local startTimestamp = os.time(startDate)
			local endTimestamp = os.time(endDate)
			local nowStamp = os.time(ServerTime.nowDateServerLook())

			if startTimestamp <= nowStamp and nowStamp <= endTimestamp then
				if weekParam then
					return weekParam.isMatch
				end

				return true
			end
		end
	end

	return false
end

return TimeLimitTaskView
