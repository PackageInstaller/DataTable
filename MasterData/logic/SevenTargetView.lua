-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/SevenTargetView.lua

module("logic.extensions.sevendays.view.SevenTargetView", package.seeall)

local SevenTargetView = class("SevenTargetView")

function SevenTargetView:ctor(go, view)
	self._mainGo = go
	self._view = view

	local rewardRoot = goutil.findChild(go, "rewardRoot")

	self._playerSliderMo = PlayerSliderMo.New(rewardRoot)
	self._taskTab = goutil.findChild(go, "taskRoot/taskItemSR")
	self._taskCell = goutil.findChild(go, "taskRoot/taskItem")
	self._btnDayTran = goutil.findChild(go, "btnDayTran")
	self._txtTotal = goutil.findChildTextComponent(rewardRoot, "txtTotal")
	self._btnDayList = {}

	for i = 1, 7 do
		local list = {}

		list.go = goutil.findChild(self._btnDayTran, "btnDay_" .. i)
		list.select = goutil.findChild(list.go, "select")
		list.lock = goutil.findChild(list.go, "lock")
		list.redPoint = goutil.findChild(list.go, "redPoint")
		list.idx = i

		table.insert(self._btnDayList, list)
	end

	self._selectDay = 1
	self._taskList = ScrollerList.create(self._taskTab, self._taskCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearItemCell, self))
end

function SevenTargetView:_init()
	return
end

function SevenTargetView:onEnter(activityId)
	self._activityId = activityId

	for k, v in pairs(self._btnDayList) do
		if v then
			local time = RoleModel.instance:getActiveTimeSec()
			local day = GameUtil.getDaysByTimestamp(time, ServerTime.now())

			v.isLock = day < v.idx

			goutil.setActive(v.lock, v.isLock)
			GameUtil.asBtn(v.go):RemoveClickListener()
			GameUtil.asBtn(v.go):AddClickListener(function()
				self:_onClickDayBtn(v.idx)
			end)
		end
	end

	self:_initPlayerParams()
end

function SevenTargetView:onExit()
	self._taskList:dispose()
end

function SevenTargetView:_setRedPointState()
	for k, v in pairs(self._btnDayList) do
		goutil.setActive(v.redPoint, false)

		local info = self._taskInfo[v.idx]

		if info and not v.isLock then
			for k, val in pairs(info) do
				if val.state == 1 then
					goutil.setActive(v.redPoint, true)

					break
				end
			end
		end
	end
end

function SevenTargetView:refreshTaskList()
	self._taskInfo = {}

	local taskList = SevenDaysModel.instance:getNewHandTargetInfo(self._activityId)
	local taskListCfg = ExcellentClassConfig.instance:GetClassAllTaskCfgs(self._activityId)

	for k, v in pairs(taskListCfg) do
		if not taskList[v.id] then
			local cfg = {}

			if v and v.subType then
				v.gainPrize = cfg.isReceive
				v.curProgress = checknumber(cfg.havePro)
				v.state = cfg.isReceive and 3 or checknumber(cfg.havePro) >= v.maxProgress and 1 or 2
				self._taskInfo[v.subType] = self._taskInfo[v.subType] or {}

				table.insert(self._taskInfo[v.subType], v)
			end
		end
	end

	for k, v in pairs(self._taskInfo) do
		table.sort(v, function(a, b)
			if a.state == b.state then
				return a.id < b.id
			end

			return a.state < b.state
		end)
	end

	self._taskList:reloadData(self._taskInfo[self._selectDay])
	self:_onClickDayBtn(self._selectDay)
	self:_refreshProgress()
	self:_setRedPointState()
end

function SevenTargetView:_onClickDayBtn(idx)
	local time = RoleModel.instance:getActiveTimeSec()
	local day = GameUtil.getDaysByTimestamp(time, ServerTime.now())

	if day < idx then
		FloatWordMgr.instance:show("没到时间哦~")

		return
	end

	for i, v in pairs(self._btnDayList) do
		goutil.setActive(v.select, v.idx == idx)
	end

	self._selectDay = idx

	self._taskList:reloadData(self._taskInfo[idx])
end

function SevenTargetView:_updateCell(view, cell, data)
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local txtProgress = goutil.findChildTextComponent(cell, "txtProgress")
	local btnReceive = goutil.findChild(cell, "btnReceive")
	local btnGoto = goutil.findChild(cell, "btnGoto")
	local receiveGo = goutil.findChild(cell, "receiveGo")
	local slider = goutil.findChild(cell, "progressSlider")
	local rewardTran = goutil.findChild(cell, "rewardTran")
	local sliderAdapter = Framework.SliderAdapter.Get(slider)
	local prize = string.split(data.prize_client, "#")

	for i = 1, rewardTran.transform.childCount do
		local reward = goutil.findChild(rewardTran, "rewardPos_" .. i)

		goutil.setActive(reward, i <= #prize)

		if i <= #prize then
			MaterialMgr.resetAll(reward)
			MaterialMgr.setCellByCfg(prize[i], reward)
		end
	end

	goutil.setActive(btnReceive, data.state == 1)
	goutil.setActive(btnGoto, data.state == 2)
	goutil.setActive(receiveGo, data.state == 3)

	txtTitle.text = data.desc
	txtProgress.text = data.curProgress .. "/" .. data.maxProgress

	sliderAdapter:SetValue(data.curProgress / data.maxProgress)
	GameUtil.asBtn(btnGoto):RemoveClickListener()
	GameUtil.asBtn(btnGoto):AddClickListener(function()
		if string.nilorempty(data.source) then
			FloatWordMgr.instance:show("未满足领取条件！")
		else
			UIStateManager.instance:push(ViewName.ItemSource, data.source, true)
		end
	end)
	GameUtil.asBtn(btnReceive):RemoveClickListener()
	GameUtil.asBtn(btnReceive):AddClickListener(function()
		TrainerCourseNewAgent.instance:sendPM_GainTrainerCourseNewPrizeReq(self._activityId, data.id)
	end)
end

function SevenTargetView:_clearItemCell(cell)
	local rewardTran = goutil.findChild(cell, "rewardTran")

	for i = 1, rewardTran.transform.childCount do
		local reward = goutil.findChild(rewardTran, "rewardPos_" .. i)

		MaterialMgr.resetAll(reward)
	end
end

function SevenTargetView:_refreshProgress()
	local list = SevenDaysModel.instance:GetClassScoreList(self._activityId)

	self._txtTotal.text = list.haveScore

	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function SevenTargetView:_initPlayerParams()
	local param = {}

	param.view = self._view
	param.prizeCfgs = ExcellentClassConfig.instance:GetClsaaScoreCfgs(self._activityId)

	function param.getPlayerProgress()
		local list = SevenDaysModel.instance:GetClassScoreList(self._activityId)

		return checknumber(list.haveScore)
	end

	function param.getPrizeByRewardCfg(cfg)
		local prizes = string.split(cfg.goods, "#")

		return prizes[1]
	end

	function param.getNeedScoreByRewardCfg(cfg)
		return checknumber(cfg.score)
	end

	function param.isPlayerRewardCanGet(cfg)
		local list = SevenDaysModel.instance:GetClassScoreList(self._activityId)
		local info = list.scoreList[cfg.prizeId]

		return not info.isReceive and info.score <= list.haveScore
	end

	function param.isPlayerRewardGeted(cfg)
		local list = SevenDaysModel.instance:GetClassScoreList(self._activityId)

		return list.scoreList[cfg.prizeId].isReceive
	end

	function param.sendGainPlayerPrizeReq(cfg)
		TrainerCourseNewAgent.instance:sendPM_GainTrainerCourseScoreNewPrizeReq(self._activityId, cfg.prizeId - 1)
	end

	function param.parseGetProgress(cfg)
		return StringUtil.numberToString(cfg.score)
	end

	self._playerSliderMo:initParam(param, true)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

return SevenTargetView
