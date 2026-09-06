-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wheelfortune/view/WheelFortuneView.lua

module("logic.extensions.wheelfortune.view.WheelFortuneView", package.seeall)

local WheelFortuneView = class("WheelFortuneView", ViewComponent)

function WheelFortuneView:ctor()
	WheelFortuneView.super.ctor(self)

	self.itemList = {}
	self.uiImgChangeList = {}
	self._wheelData = {
		chipCount = 11,
		startRotation = 16.3
	}
end

function WheelFortuneView:buildUI()
	WheelFortuneView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self.ruleBtn = self:getBtn("ruleBtn")
	self.lotteryBtn = self:getBtn("lotteryBtn")
	self.ImgC_Icon = self:getGo("lotteryBtn/Nego_TabCell/ImgC_Icon")
	self._txtCost = self:getTxt("lotteryBtn/Nego_TabCell/TxtC_Num")
	self._txtRounds = self:getTxt("lotteryBtn/roundsNum/TxtC_Num")
	self.costText = goutil.findChildTextComponent(self.mainGO, "costText")
	self.timeText = goutil.findChildTextComponent(self.mainGO, "timeText")
	self.lunpanGO = self:getGo("lunpan")
	self.arrow = self:getGo("lunpan/arrow")
	self.cellClone = self:getGo("lunpan/rewardCon/cell")
	self.rewardCon = self:getGo("lunpan/rewardCon")
	self.bigRewardNumText = goutil.findChildTextComponent(self.mainGO, "rewardCenter/text")
	self._prizeShowTable = self:getGo("prizeShowRoot")
	self._prizeShowCell = self:getGo("prizeShowCell")
	self._btnPre = self:getBtn("btnPre")
	self._btnNext = self:getBtn("btnNext")
	self._txtPrizeShowTitle = self:getTxt("txtPrizeShowTitle/txt")
	self._txtFortunePlayer = self:getTxt("txtFortunePlayer")

	GameUtil.SetActive(self.cellClone, false)

	self._roleConGo = self:getGo("roleCon")
	self._goldBarConGo = self:getGo("goldBarCon")
end

function WheelFortuneView:bindEvents()
	WheelFortuneView.super.bindEvents(self)
	self.ruleBtn:AddClickListener(self.onClickRule, self)
	self.lotteryBtn:AddClickListener(self.onClickLottery, self)
	self._btnPre:AddClickListener(self._onClickPre, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function WheelFortuneView:unbindEvents()
	WheelFortuneView.super.unbindEvents(self)
	self.ruleBtn:RemoveClickListener()
	self.lotteryBtn:RemoveClickListener()
	self._btnPre:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function WheelFortuneView:destroyUI()
	WheelFortuneView.super.destroyUI(self)
end

function WheelFortuneView:onEnter()
	WheelFortuneView.super.onEnter(self)

	WheelFortuneModel.instance.isDrawing = false
	self.actId = WheelFortuneModel.instance:getCurrActId()

	GlobalDispatcher:addListener(GlobalNotify.WheelFortuneInfoRes, self.initView, self)
	GlobalDispatcher:addListener(GlobalNotify.WheelFortuneDrawRes, self.drawSuccessed, self)
	GlobalDispatcher:addListener(GlobalNotify.WheelFortuneRecordsRes, self.refreshFortuneRecord, self)

	self._prizeShowList = ScrollerList.create(self._prizeShowTable, self._prizeShowCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	if self.actId then
		WheelFortuneAgent.instance:sendPM_WheelFortuneInfoReq(self.actId)
		self:_getNewRecord()
		self:initView()
	end

	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_WHEELFORTUNE_OPEN)
end

function WheelFortuneView:onEnterFinished()
	WheelFortuneView.super.onEnterFinished(self)

	if self.actId then
		local btn_list = {
			{
				showAdd = true,
				id = string.format("%s:%s", MatType.ACTIVITY_ITEM, self.actId)
			}
		}

		MainUIController.instance:showGlodBar(self._goldBarConGo, self._viewPresentor, btn_list)
		MaterialMgr.setIcon(self.ImgC_Icon, MatType.ACTIVITY_ITEM, self.actId)

		local actCfg = WheelFortuneConfig.instance:getActCfgById(self.actId)
		local cost

		_, _, cost = MaterialMgr.getMatParams(actCfg.activityItem)
		self._txtCost.text = checknumber(cost)
	end
end

function WheelFortuneView:onExit()
	WheelFortuneView.super.onExit(self)

	WheelFortuneModel.instance.isDrawing = false

	GlobalDispatcher:removeListener(GlobalNotify.WheelFortuneInfoRes, self.initView, self)
	GlobalDispatcher:removeListener(GlobalNotify.WheelFortuneDrawRes, self.drawSuccessed, self)
	GlobalDispatcher:removeListener(GlobalNotify.WheelFortuneRecordsRes, self.refreshFortuneRecord, self)
	self:stopTimer()
	removetimer(self._getNewRecord, self)
	removetimer(self._setNotifyByRecord, self)
	removetimer(self._checkRotation, self)
	removetimer(self._scrollerPrizeShow, self)
	removetimer(self.drwaAnimEnd, self)
	RoleObjectPool.instance:removeRole(self._roleObj)
	MaterialMgr.clearIcon(self.ImgC_Icon)
end

function WheelFortuneView:onExitFinished()
	WheelFortuneView.super.onExitFinished(self)
end

function WheelFortuneView:onClickRule()
	TipsFacade.instance:openRulesView("luckystar_rule")
end

function WheelFortuneView:onClickLottery()
	if WheelFortuneModel.instance.isDrawing then
		FloatWordMgr.instance:show(lang("正在抽奖中"))

		return
	end

	if WheelFortuneModel.instance:isGetFirstPrize() == true then
		local info = WheelFortuneModel.instance:getDrawInfo()

		FloatWordMgr.instance:show(lang("已经获得最终大奖"))

		return
	end

	self.actId = WheelFortuneModel.instance:getCurrActId()

	if self.actId then
		local cfg = WheelFortuneConfig.instance:getActCfgById(self.actId)
		local cost = string.split(cfg.activityItem, ":")
		local has_num = MaterialFacade.instance:getMatNumber(checknumber(cost[1]), checknumber(cost[2]))

		if has_num < checknumber(cost[3]) then
			local acfg = ItemConfig.instance:getActItemCfgById(self.actId)

			if acfg then
				MaterialMgr.openGetSource(MatType.ACTIVITY_ITEM, checknumber(cost[2]))
			end

			return
		end

		WheelFortuneAgent.instance:sendPM_WheelFortuneDrawReq(self.actId)

		return
	end
end

function WheelFortuneView:initView()
	local info = WheelFortuneModel.instance:getDrawInfo()

	if info then
		local actCfg = WheelFortuneConfig.instance:getActCfgById(self.actId)
		local orderId = info.orderId
		local rewardCfg = WheelFortuneConfig.instance:getPoolCfg(actCfg.prizePool)
		local rewardList = rewardCfg[orderId]
		local hasGetList = info.datas

		self:setReward(rewardList, hasGetList)
		self:setLeftTime()

		self._showPage = math.min(WheelFortuneConfig.instance:getMaxOrder(self.actId), orderId)
		self._txtRounds.text = langPara("<color=#FEFFC4FF>%d</color>/%d", orderId, WheelFortuneConfig.instance:getMaxOrder(self.actId))

		self:refreshPrizeShow()
		removetimer(self._scrollerPrizeShow, self)
		settimer(30, self._scrollerPrizeShow, self)
	end

	GameUtil.setLocalScale(self.lotteryBtn, 1, 1, 1)
	GameUtil.setLocalScale(self.lunpanGO, 1, 1, 1)
end

function WheelFortuneView:setReward(rewardList, hasGetList)
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

					obj.name = "cell_" .. i

					local rotationZ = -(i - 1) * 33

					Framework.TransformUtil.SetLocalRotation(obj.transform, 0, 0, rotationZ)
					Framework.TransformUtil.SetLocalRotation(iconGo.transform, 0, 0, 0)
					Framework.TransformUtil.SetLocalRotation(yhdGo.transform, 0, 0, 0)

					self.itemList[realIndex] = item
				end

				item:setData(cfg, hasGetList[cfg.rewardId], i)
			end

			self:setWheelRotation()
		end
	end
end

function WheelFortuneView:setWheelRotation()
	self.rotationList = {}

	if not self.rotationList[self._wheelData.chipCount] then
		self.rotationList[self._wheelData.chipCount] = {}

		local preRotation = 360 / self._wheelData.chipCount
		local totalRotation = 0

		while totalRotation < 360 do
			table.insert(self.rotationList[self._wheelData.chipCount], totalRotation)

			totalRotation = totalRotation + preRotation
		end
	end

	self._wheelData.rotationList = self.rotationList[self._wheelData.chipCount]

	if self._wheelData.chipCount > 1 then
		local endAngle, startAngle

		_, _, endAngle = GameUtil.getLocalRotation(self.itemList[self._wheelData.chipCount - 1].mainGO)
		_, _, startAngle = GameUtil.getLocalRotation(self.itemList[0].mainGO)

		if endAngle > 180 then
			endAngle = endAngle % 360 - 360
		end

		if startAngle > 180 then
			startAngle = startAngle % 360 - 360
		end

		self._wheelData.startRotation = (endAngle + startAngle) / 2
	end
end

function WheelFortuneView:setLeftTime()
	if self.actId then
		local actCfg = WheelFortuneConfig.instance:getActCfgById(self.actId)
		local actDefCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.WHEEL_FORTUNE, self.actId)
		local fun1 = string.gmatch(actDefCfg.startTime, "%d+")
		local fun2 = string.gmatch(actDefCfg.endTime, "%d+")

		fun1()
		fun2()

		local timeStart = fun1() .. "." .. fun1()
		local timeEnd = fun2() .. "." .. fun2()

		self.timeText.text = "活动时间：" .. timeStart .. " - " .. timeEnd

		local info = WheelFortuneModel.instance:getDrawInfo()

		if info then
			if not info.orderId then
				local cfg = WheelFortuneConfig.instance:getPoolCfg(actCfg.prizePool)

				self.costText.text = ""
			end
		end
	end
end

function WheelFortuneView:drawSuccessed()
	local rewardId = WheelFortuneModel.instance:getDrawRewardId()

	self:stopTimer()

	local info = WheelFortuneModel.instance:getDrawInfo()

	if info and self.actId then
		WheelFortuneModel.instance.isDrawing = true
		info.datas[rewardId] = false

		local hasGetList = info.datas
		local actCfg = WheelFortuneConfig.instance:getActCfgById(self.actId)
		local rewardCfg = WheelFortuneConfig.instance:getPoolCfg(actCfg.prizePool)
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

			local rotationZ = -(rewardId - 1) * 33
			local duration = 2
			local waitEndTime = 1

			if WheelFortuneModel.instance:isGetFirstPrize() == true then
				duration = 1.5
				waitEndTime = 0

				UnityTweens.TweenScale.StartTween(self.lunpanGO, Vector3.New(1, 1, 1), Vector3.New(0, 0, 0), 1.5)
				UnityTweens.TweenScale.StartTween(self.lotteryBtn.gameObject, Vector3.New(1, 1, 1), Vector3.New(0, 0, 0), duration)
			end

			UnityTweens.TweenRotate.StartTween(self.lunpanGO, Vector3.New(0, 0, 0), Vector3.New(0, 0, 720 + math.random(0, 360)), duration + 1, UnityTweens.EaseType.easeInOutCubic)

			local tweenLong = UnityTweens.TweenRotate.StartTween(self.arrow, Vector3.New(0, 0, 0), Vector3.New(0, 0, rotationZ - 1080), duration + 1, UnityTweens.EaseType.easeInOutCubic)

			tweenLong:RemoveListener()
			tweenLong:AddListener(function()
				removetimer(self._checkRotation, self)
				removetimer(self.drwaAnimEnd, self)
				settimer(waitEndTime, self.drwaAnimEnd, self, false)
			end)
			self:_startRotation()
		else
			self:drwaAnimEnd()
		end
	end
end

function WheelFortuneView:drwaAnimEnd()
	UIStateManager.instance:popByName(ViewName.commonInstruction)

	WheelFortuneModel.instance.isDrawing = false

	GameUtil.setLocalRotation(self.arrow, 0, 0, 0)
	GameUtil.setLocalRotation(self.lunpanGO, 0, 0, 0)
	self:stopTimer()

	if WheelFortuneModel.instance:isNextOrderIdChange() == true then
		local info = WheelFortuneModel.instance:getDrawInfo()
		local count = 0

		for i, v in pairs(info.datas) do
			if v == true then
				count = count + 1
			end
		end

		UIStateManager.instance:push(ViewName.WheelFortuneChangePoolTipView, count + 1, info.orderId)
	end

	WheelFortuneModel.instance:drwaAnimEnd()
	WheelFortuneAgent.instance:sendPM_WheelFortuneInfoReq(self.actId)
end

function WheelFortuneView:startTimer()
	self.oriTimeScale = UnityEngine.Time.timeScale
	UnityEngine.Time.timeScale = 2

	local time = 0.02

	if self.phase == 1 then
		time = 0.2
	elseif self.phase >= 9 then
		time = 0.3
	end

	settimer(time, self.updateTimer, self)
	self:updateTimer()
end

local lastData = false

function WheelFortuneView:updateTimer()
	if self.animRewardList and self.startIndex and self.rewardLen then
		if lastData and self.phase == 10 and self.rewardEndId == lastData.rewardId then
			self:drwaAnimEnd(self.rewardEndId)

			return
		end

		if self.startIndex > self.rewardLen then
			self.phase = self.phase + 1

			if self.phase > 10 then
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

function WheelFortuneView:stopTimer()
	removetimer(self.updateTimer, self)

	UnityEngine.Time.timeScale = self.oriTimeScale or 1
end

function WheelFortuneView:_startRotation()
	for k, item in pairs(self.itemList) do
		item:setSelect()
	end

	GameUtil.setLocalRotation(self.arrow, 0, 0, 0)
	GameUtil.setLocalRotation(self.lunpanGO, 0, 0, 0)
	self:_checkRotation()
	removetimer(self._checkRotation, self)
	settimer(0.02, self._checkRotation, self)
end

function WheelFortuneView:_checkRotation()
	_, _, self._tempLongRotationZ = GameUtil.getLocalRotation(self.arrow)
	self._tempLongRotationZ = self._tempLongRotationZ % -360
	self._tempLongRotationZ = (self._tempLongRotationZ - self._wheelData.startRotation) % -360
	self._tempLongRotationZ = -self._tempLongRotationZ

	local index = 0

	for i, v in ipairs(self._wheelData.rotationList) do
		if v < self._tempLongRotationZ then
			index = i
		end
	end

	for i, v in ipairs(self._wheelData.rotationList) do
		if i == index then
			if i > 1 then
				self.itemList[i - 2]:setSelect()
			end

			if not self.itemList[i - 1]:getSelect() then
				self.itemList[i - 1]:setSelect(true)
			end
		else
			self.itemList[i - 1]:setSelect()
		end
	end
end

function WheelFortuneView:refreshPrizeShow()
	local data = {}
	local info = WheelFortuneModel.instance:getDrawInfo()

	if self._showPage then
		local actCfg = WheelFortuneConfig.instance:getActCfgById(self.actId)
		local rewardCfgs = WheelFortuneConfig.instance:getPoolCfg(actCfg.prizePool)
		local dataPage = math.min(WheelFortuneConfig.instance:getMaxOrder(self.actId), self._showPage)
		local rewardList = rewardCfgs[dataPage]

		table.sort(rewardList, function(a, b)
			return a.rank < b.rank
		end)

		for i, rewardCfg in ipairs(rewardList) do
			if rewardCfg.type == 1 or rewardCfg.type == 2 then
				if info.orderId > self._showPage then
					table.insert(data, {
						isGain = true,
						cfg = rewardCfg.reward
					})
				elseif info.orderId < self._showPage then
					table.insert(data, {
						isGain = false,
						cfg = rewardCfg.reward
					})
				else
					table.insert(data, {
						cfg = rewardCfg.reward,
						isGain = info.datas[rewardCfg.rewardId]
					})
				end
			end
		end

		if info.orderId > WheelFortuneConfig.instance:getMaxOrder(self.actId) then
			GameUtil.SetActive(self._btnNext, self._showPage < info.orderId)
		else
			GameUtil.SetActive(self._btnNext, self._showPage < WheelFortuneConfig.instance:getMaxOrder(self.actId))
		end

		GameUtil.SetActive(self._btnPre, self._showPage > info.orderId)

		self._txtPrizeShowTitle.text = info.orderId == self._showPage and langPara("第%s轮(当前)", GameUtil.getChineseNumber(self._showPage)) or langPara("第%s轮", GameUtil.getChineseNumber(self._showPage))
	end

	self._prizeShowList:reloadData(data)
end

function WheelFortuneView:_scrollerPrizeShow()
	local info = WheelFortuneModel.instance:getDrawInfo()

	self._showPage = self._showPage + 1

	if info.orderId > WheelFortuneConfig.instance:getMaxOrder(self.actId) and self._showPage > info.orderId then
		self._showPage = info.orderId
	elseif self._showPage > WheelFortuneConfig.instance:getMaxOrder(self.actId) then
		self._showPage = info.orderId
	end

	self:refreshPrizeShow()
end

function WheelFortuneView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local proxy = MaterialMgr.setCellByCfg(data.cfg, go)

	if proxy then
		proxy.binder:setGray(data.isGain)
	end
end

function WheelFortuneView:_clearCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function WheelFortuneView:_onClickNext()
	local info = WheelFortuneModel.instance:getDrawInfo()

	self._showPage = info.orderId > WheelFortuneConfig.instance:getMaxOrder(self.actId) and math.min(info.orderId, self._showPage + 1) or math.min(WheelFortuneConfig.instance:getMaxOrder(self.actId), self._showPage + 1)

	self:refreshPrizeShow()
end

function WheelFortuneView:_onClickPre()
	self._showPage = math.max(1, self._showPage - 1)

	self:refreshPrizeShow()
end

function WheelFortuneView:_onClickClose()
	if not WheelFortuneModel.instance.isDrawing then
		self:close()
	else
		FloatWordMgr.instance:show(lang("正在抽奖中"))
	end
end

function WheelFortuneView:refreshFortuneRecord()
	local fortunePlayerInfo = WheelFortuneModel.instance:getFortunePlayerInfo()
	local waitTime = 5

	self._recordCount = 0

	if not fortunePlayerInfo or #fortunePlayerInfo <= 0 then
		removetimer(self._getNewRecord, self)
		settimer(waitTime, self._getNewRecord, self, false)
		self:_setFortunePlayerNotify(nil)
	else
		self._recordCount = 1

		self:_setNotifyByRecord()
		removetimer(self._setNotifyByRecord, self)
		settimer(waitTime, self._setNotifyByRecord, self, true)
	end
end

function WheelFortuneView:_getNewRecord()
	WheelFortuneAgent.instance:sendPM_WheelFortuneRecordsReq(self.actId)
end

function WheelFortuneView:_setNotifyByRecord()
	local fortunePlayerInfo = WheelFortuneModel.instance:getFortunePlayerInfo()

	if fortunePlayerInfo and fortunePlayerInfo[self._recordCount] then
		self:_setFortunePlayerNotify(fortunePlayerInfo[self._recordCount])

		self._recordCount = self._recordCount + 1
	else
		self:_getNewRecord()
	end
end

function WheelFortuneView:_setFortunePlayerNotify(record)
	if record then
		local cfgOrder = WheelFortuneConfig.instance:getMaxOrder(self.actId)

		if cfgOrder > record.orderId then
			cfgOrder = record.orderId
		end

		local cfg = WheelFortuneConfig.instance:getFirstPrize(self.actId, cfgOrder)
		local matName = MaterialMgr.getMaterialsNameByCfg(cfg.reward)
		local _, _, matCount = MaterialMgr.getMatParams(cfg.reward)

		self._txtFortunePlayer.text = langPara("%s-%s-在第%d轮-仅用%d次就抽出了%s*%d", record.areaName, record.userName, record.orderId, record.drawNum, matName, matCount)
	else
		self._txtFortunePlayer.text = lang("目前暂无幸运玩家上榜，再接再厉！！")
	end
end

return WheelFortuneView
