-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/TwentyoneTargetView.lua

module("logic.extensions.sevendays.view.TwentyoneTargetView", package.seeall)

local TwentyoneTargetView = class("TwentyoneTargetView")
local posValues = {
	{
		-301,
		0
	},
	{
		0,
		0
	},
	{
		301,
		0
	}
}

function TwentyoneTargetView:ctor(go, view)
	self._mainGo = go
	self._view = view

	local rewardRoot = goutil.findChild(go, "rewardRoot")

	self._playerSliderMo = PlayerSliderMo.New(rewardRoot)
	self._txtTotal = goutil.findChildTextComponent(rewardRoot, "txtTotal")
	self._taskRoot = goutil.findChild(go, "taskRoot")
	self._taskItem = goutil.findChild(go, "taskRoot/taskItem")
	self._taskItemList = {}

	for i = 1, 3 do
		local list = {}
		local pos = posValues[i]

		list.go = goutil.cloneAndSetParent(self._taskItem, self._taskRoot.transform)
		list.go.name = "taskItem_" .. i
		list.sliderAdapter = Framework.SliderAdapter.Get(goutil.findChild(list.go, "progressSlider"))
		list.btnGoto = goutil.findChild(list.go, "btnGoto")
		list.btnReceive = goutil.findChild(list.go, "btnReceive")
		list.finishGo = goutil.findChild(list.go, "finishGo")
		list.txtProgress = goutil.findChildTextComponent(list.go, "txtProgress")
		list.txtScore = goutil.findChild(list.go, "txtScore"):GetComponent(typeof(UIImgNumeralText))
		list.txtDes = goutil.findChildTextComponent(list.go, "txtDes")
		list.rewardList = {}

		for i = 1, 2 do
			local reward = goutil.findChild(list.go, "rewardTran/rewardPos_" .. i)

			table.insert(list.rewardList, reward)
		end

		Framework.TransformUtil.SetLocalPos(list.go.transform, pos[1], pos[2], 0)
		table.insert(self._taskItemList, list)
	end

	self._btnRoot = goutil.findChild(go, "btnRoot")
	self._btnCultivate = goutil.findChild(go, "btnRoot/btnCultivate")
	self._btnCultivateTran = goutil.findChild(go, "btnRoot/btnCultivateTran")
	self._selectPage = 1
end

function TwentyoneTargetView:_init()
	return
end

function TwentyoneTargetView:onEnter(activityId)
	self._activityId = activityId

	self:_initPageBtn()
	goutil.setActive(self._taskItem, false)
	goutil.setActive(self._btnCultivate, false)

	for k, v in pairs(self._btnPageList) do
		GameUtil.asBtn(v.go):AddClickListener(function()
			self:_onClickTab(v.id)
		end)
	end

	self:_initPlayerParams()
end

function TwentyoneTargetView:onExit()
	for k, v in pairs(self._taskItemList) do
		for i, val in pairs(v.rewardList) do
			MaterialMgr.resetAll(val)
		end

		GameUtil.asBtn(v.btnGoto):RemoveClickListener()
		GameUtil.asBtn(v.btnReceive):RemoveClickListener()
	end

	for k, v in pairs(self._btnPageList) do
		GameUtil.asBtn(v.go):RemoveClickListener()
	end
end

function TwentyoneTargetView:_setPagRedPoint()
	for k, v in pairs(self._btnPageList) do
		local info = self._taskInfo[v.id]

		goutil.setActive(v.redPoint, false)

		if info then
			for k, val in pairs(info) do
				for k, task in pairs(val) do
					if task.state == 1 then
						goutil.setActive(v.redPoint, true)

						break
					end
				end
			end
		end
	end
end

function TwentyoneTargetView:refreshTaskList()
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
				self._taskInfo[v.tabID] = self._taskInfo[v.tabID] or {}
				self._taskInfo[v.tabID][v.subType] = self._taskInfo[v.tabID][v.subType] or {}

				table.insert(self._taskInfo[v.tabID][v.subType], v)
			end
		end
	end

	for k, val in pairs(self._taskInfo) do
		for i, v in pairs(val) do
			table.sort(v, function(a, b)
				if a.state == b.state then
					return a.id < b.id
				end

				return a.state < b.state
			end)
		end
	end

	self:_onClickTab(self._selectPage)
	self:_refreshProgress()
	self:_setPagRedPoint()
end

function TwentyoneTargetView:_initPageBtn()
	if self._btnPageList and #self._btnPageList > 0 then
		return
	end

	local taskListCfg = ExcellentClassConfig.instance:GetClassAllTaskCfgs(self._activityId)

	self._btnPageList = {}

	for i, v in ipairs(taskListCfg) do
		if not self._btnPageList[v.tabID] then
			local btn = {}

			btn.go = goutil.cloneAndSetParent(self._btnCultivate, self._btnCultivateTran.transform)
			btn.img = btn.go:GetComponent(ComponentType.UIImageSpriteChange)
			btn.name = goutil.findChildTextComponent(btn.go, "txt")
			btn.txtColor = goutil.findChild(btn.go, "txt"):GetComponent(ComponentType.UITextColorChange)
			btn.redPoint = goutil.findChild(btn.go, "redPoint")
			btn.name.text = v.tab
			btn.id = v.tabID
			self._btnPageList[v.tabID] = btn
		end
	end
end

function TwentyoneTargetView:_refreshSelectBtn(idx)
	for k, v in pairs(self._btnPageList) do
		v.img:SetState(idx == v.id and 1 or 0)
		v.txtColor:SetState(idx == v.id and 1 or 0)
	end
end

function TwentyoneTargetView:_onClickTab(idx)
	local taskInfo = self._taskInfo[idx]

	for i, v in ipairs(taskInfo) do
		local cell = self._taskItemList[i]

		self:_updateItemList(cell, v[1])
	end

	self:_refreshSelectBtn(idx)

	self._selectPage = idx
end

function TwentyoneTargetView:_updateItemList(cell, data)
	local prize = string.split(data.prize, "#")

	for i = 1, #cell.rewardList do
		goutil.setActive(cell.rewardList[i], i <= #prize)

		if i <= #prize then
			MaterialMgr.resetAll(cell.rewardList[i])
			MaterialMgr.setCellByCfg(prize[i], cell.rewardList[i])
		end
	end

	goutil.setActive(cell.btnReceive, data.state == 1)
	goutil.setActive(cell.btnGoto, data.state == 2)
	goutil.setActive(cell.finishGo, data.state == 3)

	cell.txtDes.text = data.desc

	cell.txtScore:SetNum(data.score)

	cell.txtProgress.text = data.curProgress .. "/" .. data.maxProgress

	cell.sliderAdapter:SetValue(data.curProgress / data.maxProgress)
	GameUtil.asBtn(cell.btnGoto):RemoveClickListener()
	GameUtil.asBtn(cell.btnGoto):AddClickListener(function()
		if string.nilorempty(data.source) then
			FloatWordMgr.instance:show("未满足领取条件！")
		else
			UIStateManager.instance:push(ViewName.ItemSource, data.source, true)
		end
	end)
	GameUtil.asBtn(cell.btnReceive):RemoveClickListener()
	GameUtil.asBtn(cell.btnReceive):AddClickListener(function()
		TrainerCourseNewAgent.instance:sendPM_GainTrainerCourseNewPrizeReq(self._activityId, data.id)
	end)
end

function TwentyoneTargetView:_refreshProgress()
	local list = SevenDaysModel.instance:GetClassScoreList(self._activityId)

	self._txtTotal.text = list.haveScore

	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function TwentyoneTargetView:_initPlayerParams()
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
		return cfg.score
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

return TwentyoneTargetView
