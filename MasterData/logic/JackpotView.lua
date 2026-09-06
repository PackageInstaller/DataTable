-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jackpot/view/JackpotView.lua

module("logic.extensions.jackpot.view.JackpotView", package.seeall)

local JackpotView = class("JackpotView", ViewComponent)

function JackpotView:ctor()
	JackpotView.super.ctor(self)

	self.itemList = {}
	self.uiImgChangeList = {}
end

function JackpotView:buildUI()
	JackpotView.super.buildUI(self)

	self.ruleBtn = self:getBtn("ruleBtn")
	self.lotteryBtn = self:getBtn("lotteryBtn")
	self.ImgC_Icon = self:getGo("lotteryBtn/Nego_TabCell/ImgC_Icon")
	self.costText = goutil.findChildTextComponent(self.mainGO, "costText")
	self.timeText = goutil.findChildTextComponent(self.mainGO, "timeText")
	self.cellClone = self:getGo("rewardCon/cell")
	self.rewardCon = self:getGo("rewardCon")
	self.bigRewardNumText = goutil.findChildTextComponent(self.mainGO, "rewardCenter/text")

	GameUtil.SetActive(self.cellClone, false)

	self._roleConGo = self:getGo("roleCon")
	self._goldBarConGo = self:getGo("goldBarCon")
end

function JackpotView:bindEvents()
	JackpotView.super.bindEvents(self)
	self.ruleBtn:AddClickListener(self.onClickRule, self)
	self.lotteryBtn:AddClickListener(self.onClickLottery, self)
end

function JackpotView:unbindEvents()
	JackpotView.super.unbindEvents(self)
	self.ruleBtn:RemoveClickListener()
	self.lotteryBtn:RemoveClickListener()
end

function JackpotView:destroyUI()
	JackpotView.super.destroyUI(self)
end

function JackpotView:onEnter()
	JackpotView.super.onEnter(self)

	JackpotModel.instance.isDrawing = false
	self.actId = JackpotModel.instance:getCurrActId()

	if self.actId then
		JackpotController.instance:registerLocalNotify(JackpotModel.UpdateDrawInfos, self.initView, self)
		JackpotController.instance:registerLocalNotify(JackpotModel.DrawSuccessed, self.drawSuccessed, self)
		JackpotAgent.instance:sendGetJackpotDrawInfoReq(self.actId)
		self:initView()
	end

	self:_setRole()
end

function JackpotView:onEnterFinished()
	JackpotView.super.onEnterFinished(self)

	if self.actId then
		local btn_list = {
			{
				showAdd = true,
				id = string.format("%s:%s", MatType.ACTIVITY_ITEM, self.actId),
				params = {
					customTxt = true,
					moduleName = "JackpotView",
					actId = self.actId
				}
			}
		}

		MainUIController.instance:showGlodBar(self._goldBarConGo, self._viewPresentor, btn_list)
		MaterialMgr.setIcon(self.ImgC_Icon, MatType.ACTIVITY_ITEM, self.actId)
	end
end

function JackpotView:onExit()
	JackpotView.super.onExit(self)

	JackpotModel.instance.isDrawing = false

	JackpotController.instance:unregisterLocalNotify(JackpotModel.UpdateDrawInfos, self.initView, self)
	JackpotController.instance:unregisterLocalNotify(JackpotModel.DrawSuccessed, self.drawSuccessed, self)
	JackpotModel.instance:setChangeSetId(nil)
	self:stopTimer()
	RoleObjectPool.instance:removeRole(self._roleObj)
	MaterialMgr.clearIcon(self.ImgC_Icon)
end

function JackpotView:onExitFinished()
	JackpotView.super.onExitFinished(self)
end

function JackpotView:onClickRule()
	TipsFacade.instance:openRulesView("jackpot")
end

function JackpotView:onClickLottery()
	if JackpotModel.instance.isDrawing then
		FloatWordMgr.instance:show("正在抽奖中")

		return
	end

	self.actId = JackpotModel.instance:getCurrActId()

	if self.actId then
		local cfg = JackpotConfig.instance:getActCfgById(self.actId)
		local cost = string.split(cfg.activityItem, ":")
		local has_num = MaterialFacade.instance:getMatNumber(checknumber(cost[1]), checknumber(cost[2]))

		if has_num < checknumber(cost[3]) then
			local acfg = ItemConfig.instance:getActItemCfgById(self.actId)

			if acfg then
				MaterialMgr.openGetSource(MatType.ACTIVITY_ITEM, checknumber(cost[2]))
			end

			return
		end

		JackpotController.instance:sendJackpotDrawReq(self.actId, true)
	end
end

function JackpotView:initView()
	local info = JackpotModel.instance:getDrawInfo()

	if info then
		local actCfg = JackpotConfig.instance:getActCfgById(self.actId)
		local orderId = info.orderId
		local rewardCfg = JackpotConfig.instance:getPoolCfg(actCfg.jackpot)
		local rewardList = rewardCfg[orderId]
		local hasGetList = info.datas

		self:setReward(rewardList, hasGetList)
		self:setLeftTime()
	end
end

function JackpotView:setReward(rewardList, hasGetList)
	if rewardList then
		if not #rewardList then
			local len = 0

			if len <= 0 then
				return
			end

			table.sort(rewardList, function(a, b)
				return a.rank < b.rank
			end)

			for i = 1, len do
				local cfg = rewardList[i]
				local realIndex = i - 1
				local item = self.itemList[realIndex]

				if not item then
					local obj = goutil.cloneAndSetParent(self.cellClone, self.rewardCon.transform)
					local iconGo = goutil.findChild(obj, "icon")
					local yhdGo = goutil.findChild(obj, "yhd")

					GameUtil.SetActive(obj, true)

					item = GameUtil.AddLuaOnce(obj, JackpotItem)

					GameUtil.setLocalPos(obj, 0, 0)

					local rotationZ = -(i - 1) * 33

					Framework.TransformUtil.SetLocalRotation(obj.transform, 0, 0, rotationZ)
					Framework.TransformUtil.SetLocalRotation(iconGo.transform, 0, 0, -rotationZ)
					Framework.TransformUtil.SetLocalRotation(yhdGo.transform, 0, 0, -rotationZ)

					self.itemList[realIndex] = item
				end

				item:setData(cfg, hasGetList[cfg.rewardId], i)
			end
		end
	end
end

function JackpotView:setLeftTime()
	if self.actId then
		local actCfg = JackpotConfig.instance:getActCfgById(self.actId)
		local actDefCfg = ActivityDefineConfig.instance:getCfgById(3, self.actId)
		local fun1 = string.gmatch(actDefCfg.startTime, "%d+")
		local fun2 = string.gmatch(actDefCfg.endTime, "%d+")

		fun1()
		fun2()

		local timeStart = fun1() .. "." .. fun1()
		local timeEnd = fun2() .. "." .. fun2()

		self.timeText.text = "活动时间：" .. timeStart .. " - " .. timeEnd

		local info = JackpotModel.instance:getDrawInfo()

		if info then
			if not info.orderId then
				local cfg = JackpotConfig.instance:getPoolCfg(actCfg.jackpot)

				self.costText.text = ""
			end
		end
	end
end

function JackpotView:drawSuccessed(rewardId)
	self:stopTimer()

	local info = JackpotModel.instance:getDrawInfo()

	if info and self.actId then
		JackpotModel.instance.isDrawing = true
		info.datas[rewardId] = false

		local hasGetList = info.datas
		local actCfg = JackpotConfig.instance:getActCfgById(self.actId)
		local rewardCfg = JackpotConfig.instance:getPoolCfg(actCfg.jackpot)
		local orderId = info.orderId
		local rewardList = {}
		local tempList = rewardCfg[orderId]

		for k, v in pairs(tempList) do
			if not hasGetList[v.rewardId] then
				table.insert(rewardList, v)
			end
		end

		table.sort(rewardList, function(a, b)
			return a.rank < b.rank
		end)

		local rewardLen = #rewardList

		if rewardLen > 0 then
			self.animRewardList = rewardList
			self.startIndex = 1
			self.rewardLen = rewardLen
			self.rewardEndId = rewardId
			self.phase = 1

			self:startTimer()
		else
			self:drwaAnimEnd(rewardId)
		end
	end
end

function JackpotView:drwaAnimEnd(rewardId)
	UIStateManager.instance:popByName(ViewName.commonInstruction)

	JackpotModel.instance.isDrawing = false

	self:stopTimer()
	JackpotModel.instance:drwaAnimEnd(rewardId)
	self:initView()
end

function JackpotView:startTimer()
	self.oriTimeScale = UnityEngine.Time.timeScale
	UnityEngine.Time.timeScale = 2

	local time = 0.1

	if self.phase == 1 then
		time = 0.2
	elseif self.phase == 5 then
		time = 0.3
	end

	settimer(time, self.updateTimer, self)
	self:updateTimer()
end

local lastData = false

function JackpotView:updateTimer()
	if self.animRewardList and self.startIndex and self.rewardLen then
		if lastData and self.phase == 5 and self.rewardEndId == lastData.rewardId then
			self:drwaAnimEnd(self.rewardEndId)

			return
		end

		if self.startIndex > self.rewardLen then
			self.phase = self.phase + 1

			if self.phase > 5 then
				self:drwaAnimEnd(self.rewardEndId)
			else
				self:stopTimer()

				self.startIndex = 1

				self:startTimer()
			end

			return
		end

		local data = self.animRewardList[self.startIndex]

		lastData = data

		for k, item in pairs(self.itemList) do
			item:setSelect(item.cfg and item.cfg.rewardId == data.rewardId)
		end

		self.startIndex = self.startIndex + 1
	else
		self:drwaAnimEnd(self.rewardEndId)
	end
end

function JackpotView:stopTimer()
	removetimer(self.updateTimer, self)

	UnityEngine.Time.timeScale = self.oriTimeScale or 1
end

function JackpotView:_setRole()
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, 10100, self._roleConGo, 1.2, nil, true, 0, 98)
end

return JackpotView
