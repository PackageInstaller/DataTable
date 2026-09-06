-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/superghostlottery/view/SuperGhostLotteryView.lua

module("logic.extensions.superghostlottery.view.SuperGhostLotteryView", package.seeall)

local SuperGhostLotteryView = class("SuperGhostLotteryView", ViewComponent)
local SUPERGHOSTLOTTERYVIEW_TOGGLE = "superghostlotteryview_toggle"

function SuperGhostLotteryView:ctor()
	SuperGhostLotteryView.super.ctor(self)

	self.itemList = {}
	self.uiImgChangeList = {}
	self._wheelData = {
		startRotation = 16.363636363636363,
		chipCount = 11,
		bigPrizeIndex = {
			1,
			5,
			8
		}
	}
end

SuperGhostLotteryView.NormalPrizeType = 1
SuperGhostLotteryView.BigPrizeType = 2

function SuperGhostLotteryView:buildUI()
	SuperGhostLotteryView.super.buildUI(self)

	self._bgGo = self:getGo("bg")
	self._btnClose = self:getBtn("btnClose")
	self.ruleBtn = self:getBtn("ruleBtn")
	self.timeText = goutil.findChildTextComponent(self.mainGO, "timebg/timeText")
	self._roleConGo = self:getGo("roleCon")
	self._goldBarConGo = self:getGo("goldBarCon")
	self.lotteryBtn = self:getBtn("lotteryBtn")
	self._lotteryBtnImgGo = self:getGo("lotteryBtn/img")
	self._lotteryBtnCostGo = self:getGo("lotteryBtn/Nego_TabCell")
	self._lotteryBtnRoundGo = self:getGo("lotteryBtn/roundsNum")
	self.ImgC_Icon = self:getGo("lotteryBtn/Nego_TabCell/ImgC_Icon")
	self._txtCost = self:getTxt("lotteryBtn/Nego_TabCell/TxtC_Num")
	self._txtRounds = self:getTxt("lotteryBtn/roundsNum/TxtC_Num")
	self.lunpanGO = self:getGo("lunpan")
	self.arrow = self:getGo("lunpan/arrow")
	self.cellClone = self:getGo("lunpan/rewardCon/cell")
	self.rewardCon = self:getGo("lunpan/rewardCon")

	GameUtil.SetActive(self.cellClone, false)

	self._prizeShowTable = self:getGo("prizeShow/prizeShowRoot")
	self._prizeShowCell = self:getGo("prizeShow/prizeShowCell")
	self._btnPre = self:getBtn("prizeShow/btnPre")
	self._btnNext = self:getBtn("prizeShow/btnNext")
	self._txtPrizeShowTitle = self:getTxt("prizeShow/txtPrizeShowTitle/txt")
	self._txtPrizeShowTabTitle = self:getTxt("prizeShow/txtTitle")
	self._activityTab = self:getGo("tableActivity/ScrollView")
	self._activityCell = self:getGo("tableActivity/BtnCell")
	self._txtIntroduce = self:getTxt("txtIntroduce/txt")
	self._toggle = self:getGo("Toggle"):GetComponent("Toggle")
end

function SuperGhostLotteryView:bindEvents()
	SuperGhostLotteryView.super.bindEvents(self)
	self.ruleBtn:AddClickListener(self.onClickRule, self)
	self.lotteryBtn:AddClickListener(self.onClickLottery, self)
	self._btnPre:AddClickListener(self._onClickPre, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function SuperGhostLotteryView:unbindEvents()
	SuperGhostLotteryView.super.unbindEvents(self)
	self.ruleBtn:RemoveClickListener()
	self.lotteryBtn:RemoveClickListener()
	self._btnPre:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function SuperGhostLotteryView:destroyUI()
	SuperGhostLotteryView.super.destroyUI(self)
end

function SuperGhostLotteryView:onEnter()
	SuperGhostLotteryView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SuperGhostLotteryGetInfoRes, self.refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SuperGhostLotteryDrawRes, self.drawSuccessed, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SuperGhostLotterySelectBigPrizeRes, self.refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.SuperGhostLotteryEmptyItemClick, self._onClickEmpty, self)

	self._prizeShowList = ScrollerList.create(self._prizeShowTable, self._prizeShowCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._activityList = ScrollerList.create(self._activityTab, self._activityCell, GameUtil.handler(self._updateActCell, self), GameUtil.handler(self._clearActCell, self))

	local list = SuperGhostLotteryConfig.instance:getActivityShowList()

	self._activityList:reloadData(list)

	if #list > 0 then
		self:_onClickActTab(list[1])
	else
		FloatWordMgr.instance:show(lang("活动已过期"))
		self:close()
	end

	self._toggle.isOn = false

	GameUtil.getUserData(SUPERGHOSTLOTTERYVIEW_TOGGLE, function(value)
		if checknumber(value) == 1 then
			self._toggle.isOn = true
		end
	end)
end

function SuperGhostLotteryView:onExit()
	SuperGhostLotteryView.super.onExit(self)

	self.actId = nil
	SuperGhostLotteryModel.instance.isDrawing = false

	GlobalDispatcher:removeListener(GlobalNotify.PM_SuperGhostLotteryGetInfoRes, self.refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SuperGhostLotteryDrawRes, self.drawSuccessed, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SuperGhostLotterySelectBigPrizeRes, self.refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.SuperGhostLotteryEmptyItemClick, self._onClickEmpty, self)
	removetimer(self._getNewRecord, self)
	removetimer(self._setNotifyByRecord, self)
	removetimer(self._checkRotation, self)
	removetimer(self.drwaAnimEnd, self)
	RoleObjectPool.instance:removeRole(self._roleObj)
	MaterialMgr.clearIcon(self.ImgC_Icon)

	if self._toggle.isOn then
		GameUtil.saveUserData(SUPERGHOSTLOTTERYVIEW_TOGGLE, 1)
	else
		GameUtil.saveUserData(SUPERGHOSTLOTTERYVIEW_TOGGLE, 0)
	end
end

function SuperGhostLotteryView:refreshView()
	self:resetCost()

	local actCfg = SuperGhostLotteryConfig.instance:getActivityCfg(self.actId)

	if not string.nilorempty(actCfg.bgRes) then
		uGuiUtil.setSpriteToImage(self._bgGo, nil, GameUrl.getBigbgPngUrl(actCfg.bgRes))
	else
		uGuiUtil.clearImage(self._bgGo)
	end

	local info = SuperGhostLotteryModel.instance:getDrawInfo()

	if info then
		self._showPage = info.orderId
	end

	local introduceRule = RulesConfig.instance:getRuleCo(actCfg.introduceKey)

	if self._txtIntroduce and introduceRule then
		self._txtIntroduce.text = introduceRule.rules
	end

	self:refreshLottery()
	self:refreshPrizeShow()
	self:setTime()
end

function SuperGhostLotteryView:_updateActCell(view, cell, data, tag)
	local go = cell.gameObject
	local redPoint = goutil.findChild(go, "dot")
	local tag = goutil.findChild(go, "tag")
	local btnClick = GameUtil.asBtn(goutil.findChild(go, "click"))
	local txtTitle = goutil.findChildTextComponent(go, "text")
	local txtSelectChange = goutil.findChildComponent(go, "text", "UITextColorChange")
	local select = goutil.findChild(go, "select")
	local unSelect = goutil.findChild(go, "unselect")

	if self.actId == data.activityId then
		txtSelectChange:SetState(1)
		GameUtil.SetActive(select, true)
		GameUtil.SetActive(unSelect, false)
	else
		txtSelectChange:SetState(0)
		GameUtil.SetActive(select, false)
		GameUtil.SetActive(unSelect, true)
	end

	txtTitle.text = data.titleName

	btnClick:AddClickListener(function()
		self:_onClickActTab(data)
	end, self)
	GameUtil.SetActive(redPoint, false)
	GameUtil.SetActive(tag, false)
end

function SuperGhostLotteryView:_clearActCell(cell)
	local go = cell.gameObject
	local btnClick = GameUtil.asBtn(goutil.findChild(go, "click"))

	btnClick:RemoveClickListener()
end

function SuperGhostLotteryView:_onClickActTab(actCfg)
	if self.actId ~= actCfg.activityId then
		self.actId = actCfg.activityId

		self._activityList:refresh()
		SuperGhostLotteryController.instance:sendPM_SuperGhostLotteryGetInfoReq(self.actId)
	end
end

function SuperGhostLotteryView:refreshLottery()
	GameUtil.SetActive(self._lotteryBtnImgGo, false)
	GameUtil.SetActive(self._lotteryBtnCostGo, false)
	GameUtil.SetActive(self._lotteryBtnRoundGo, false)

	local info = SuperGhostLotteryModel.instance:getDrawInfo()

	if info then
		local actCfg = SuperGhostLotteryConfig.instance:getActivityCfg(self.actId)
		local round = self._showPage
		local rewardCfg = SuperGhostLotteryConfig.instance:getPrizeCfgByRound(actCfg.prizePlanId, round)
		local bigPrizeSelect = SuperGhostLotteryModel.instance:getSelectedBigPrizeIds()

		self._rewardList = {}

		for i, v in ipairs(self._wheelData.bigPrizeIndex) do
			if i > actCfg.bigPrizeNum then
				break
			end

			self._rewardList[v] = {}

			if bigPrizeSelect[i] then
				self._rewardList[v].data = SuperGhostLotteryConfig.instance:getPrizeCfg(actCfg.prizePlanId, bigPrizeSelect[i])
				self._rewardList[v].isEmpty = false
			else
				self._rewardList[v].data = nil
				self._rewardList[v].isEmpty = true
			end
		end

		local bigIndex = 1

		for i, v in ipairs(rewardCfg[SuperGhostLotteryView.NormalPrizeType]) do
			for j = bigIndex, self._wheelData.chipCount do
				if not self._rewardList[j] then
					bigIndex = j

					break
				end
			end

			self._rewardList[bigIndex] = {}
			self._rewardList[bigIndex].data = v
		end

		for i = 1, self._wheelData.chipCount do
			if not self._rewardList[i] then
				self._rewardList[i] = {}
				self._rewardList[i].isNotDifine = true
			end
		end

		local hasGetList = info.datas

		self:setReward(self._rewardList, hasGetList)

		self._txtRounds.text = langPara("<color=#FEFFC4FF>%d</color>/%d", info.orderId, SuperGhostLotteryConfig.instance:getMaxRound(actCfg.prizePlanId))

		if self._showPage == info.orderId then
			GameUtil.SetActive(self._lotteryBtnImgGo, true)
			GameUtil.SetActive(self._lotteryBtnCostGo, true)
			GameUtil.SetActive(self._lotteryBtnRoundGo, true)
		end
	end

	GameUtil.setLocalScale(self.lotteryBtn, 1, 1, 1)
	GameUtil.setLocalScale(self.lunpanGO, 1, 1, 1)
end

function SuperGhostLotteryView:setReward(rewardList, hasGetList)
	if rewardList then
		if not #rewardList then
			local len = 0

			if len <= 0 then
				return
			end

			for i = 1, len do
				local reward = rewardList[i]
				local realIndex = i - 1
				local item = self.itemList[realIndex]

				if not item then
					local obj = goutil.cloneAndSetParent(self.cellClone, self.rewardCon.transform)
					local iconGo = goutil.findChild(obj, "icon")
					local yhdGo = goutil.findChild(obj, "yhd")
					local imgAdd = goutil.findChild(obj, "imgAdd")

					GameUtil.SetActive(obj, true)

					item = GameUtil.AddLuaOnce(obj, SuperGhostItem)

					GameUtil.setLocalPos(obj, 0, 0)

					obj.name = "cell_" .. i

					local rotationZ = -(i - 1) * 360 / self._wheelData.chipCount

					Framework.TransformUtil.SetLocalRotation(obj.transform, 0, 0, rotationZ)
					Framework.TransformUtil.SetLocalRotation(iconGo.transform, 0, 0, 0)
					Framework.TransformUtil.SetLocalRotation(yhdGo.transform, 0, 0, 0)
					Framework.TransformUtil.SetLocalRotation(imgAdd.transform, 0, 0, -rotationZ)

					self.itemList[realIndex] = item
				end

				if reward.data then
					item:setData(reward, hasGetList[reward.data.prizeId], i)
				else
					item:setData(reward, false, i)
				end
			end

			self:setWheelRotation()
		end
	end
end

function SuperGhostLotteryView:setWheelRotation()
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

function SuperGhostLotteryView:setTime()
	if self.actId then
		local actCfg = SuperGhostLotteryConfig.instance:getActivityCfg(self.actId)
		local actDefCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.SUPER_GHOST_LOTTERY, self.actId)
		local fun1 = string.gmatch(actDefCfg.startTime, "%d+")
		local fun2 = string.gmatch(actDefCfg.endTime, "%d+")

		fun1()
		fun2()

		local timeStart = fun1() .. "." .. fun1()
		local timeEnd = fun2() .. "." .. fun2()

		self.timeText.text = "活动时间：" .. timeStart .. " - " .. timeEnd
	end
end

function SuperGhostLotteryView:drawSuccessed()
	local prizeId = SuperGhostLotteryModel.instance:getDrawPrizeId()
	local info = SuperGhostLotteryModel.instance:getDrawInfo()

	if info and self.actId then
		SuperGhostLotteryModel.instance.isDrawing = true

		if checknumber(prizeId) > 0 and not self._toggle.isOn then
			local tagIndex = 1

			for i, v in ipairs(self._rewardList) do
				if v.data and v.data.prizeId == prizeId then
					tagIndex = i
				end
			end

			local rotationZ = -(tagIndex - 1) * 360 / self._wheelData.chipCount
			local duration = 2
			local waitEndTime = 1

			if SuperGhostLotteryModel.instance:isGetFirstPrize() == true then
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

function SuperGhostLotteryView:drwaAnimEnd()
	UIStateManager.instance:popByName(ViewName.commonInstruction)

	SuperGhostLotteryModel.instance.isDrawing = false

	GameUtil.setLocalRotation(self.arrow, 0, 0, 0)
	GameUtil.setLocalRotation(self.lunpanGO, 0, 0, 0)

	if SuperGhostLotteryModel.instance:isNextOrderIdChange() == true then
		local info = SuperGhostLotteryModel.instance:getDrawInfo()
		local count = 0

		for i, v in pairs(info.datas) do
			if v == true then
				count = count + 1
			end
		end
	end

	SuperGhostLotteryModel.instance:drwaAnimEnd()
	SuperGhostLotteryController.instance:sendPM_SuperGhostLotteryGetInfoReq(self.actId)
end

function SuperGhostLotteryView:_startRotation()
	for k, item in pairs(self.itemList) do
		item:setSelect()
	end

	GameUtil.setLocalRotation(self.arrow, 0, 0, 0)
	GameUtil.setLocalRotation(self.lunpanGO, 0, 0, 0)
	self:_checkRotation()
	removetimer(self._checkRotation, self)
	settimer(0.02, self._checkRotation, self)
end

function SuperGhostLotteryView:_checkRotation()
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

function SuperGhostLotteryView:refreshPrizeShow()
	local data = {}
	local info = SuperGhostLotteryModel.instance:getDrawInfo()

	if self._showPage then
		local actCfg = SuperGhostLotteryConfig.instance:getActivityCfg(self.actId)
		local roundPrizeCfgs = SuperGhostLotteryConfig.instance:getPrizeCfgByRound(actCfg.prizePlanId, self._showPage)
		local rewardList = roundPrizeCfgs[SuperGhostLotteryView.BigPrizeType]

		for i, rewardCfg in ipairs(rewardList) do
			if self._showPage == info.orderId then
				table.insert(data, {
					cfg = rewardCfg,
					isGain = info.datas[rewardCfg.prizeId]
				})
			else
				table.insert(data, {
					isGain = false,
					cfg = rewardCfg
				})
			end
		end

		GameUtil.SetActive(self._btnNext, self._showPage < SuperGhostLotteryConfig.instance:getMaxRound(actCfg.prizePlanId))
		GameUtil.SetActive(self._btnPre, self._showPage > 1)

		if info.orderId == self._showPage then
			self._txtPrizeShowTitle.text = langPara("第%s轮(当前)", GameUtil.getChineseNumber(self._showPage))
			self._txtPrizeShowTabTitle.text = lang("本轮所有大奖")
		else
			self._txtPrizeShowTitle.text = langPara("第%s轮", GameUtil.getChineseNumber(self._showPage))
			self._txtPrizeShowTabTitle.text = lang("可选奖励预览")
		end
	end

	self._prizeShowList:reloadData(data)
end

function SuperGhostLotteryView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local proxy = MaterialMgr.setCellByCfg(data.cfg.prize, go)
	local isGainGo = goutil.findChild(go, "receive")

	GameUtil.SetActive(isGainGo, data.isGain)
end

function SuperGhostLotteryView:_clearCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function SuperGhostLotteryView:setToPage(page)
	local actCfg = SuperGhostLotteryConfig.instance:getActivityCfg(self.actId)

	self._showPage = math.min(SuperGhostLotteryConfig.instance:getMaxRound(actCfg.prizePlanId), page)
	self._showPage = math.max(1, self._showPage)

	self:refreshLottery()
	self:refreshPrizeShow()
end

function SuperGhostLotteryView:_onClickNext()
	self:setToPage(self._showPage + 1)
end

function SuperGhostLotteryView:_onClickPre()
	self:setToPage(self._showPage - 1)
end

function SuperGhostLotteryView:_onClickClose()
	if not SuperGhostLotteryModel.instance.isDrawing then
		self:close()
	else
		FloatWordMgr.instance:show(lang("正在抽奖中"))
	end
end

function SuperGhostLotteryView:onClickRule()
	local actCfg = SuperGhostLotteryConfig.instance:getActivityCfg(self.actId)

	TipsFacade.instance:openRulesView(actCfg.ruleKey)
end

function SuperGhostLotteryView:onClickLottery()
	local cfg = SuperGhostLotteryConfig.instance:getActivityCfg(self.actId)
	local info = SuperGhostLotteryModel.instance:getDrawInfo()

	if SuperGhostLotteryModel.instance.isDrawing then
		FloatWordMgr.instance:show(lang("正在抽奖中"))

		return
	end

	if self._showPage ~= info.orderId then
		self:setToPage(info.orderId)

		return
	end

	if SuperGhostLotteryModel.instance:getSelectedBigPrizeIds() and #SuperGhostLotteryModel.instance:getSelectedBigPrizeIds() < cfg.bigPrizeNum then
		self:_onClickEmpty()

		return
	end

	if SuperGhostLotteryModel.instance:isGetFirstPrize() == true then
		FloatWordMgr.instance:show(lang("已经获得最终大奖"))

		return
	end

	self.actId = SuperGhostLotteryModel.instance:getCurrActId()

	if self.actId then
		local costType, costId, costNum = MaterialMgr.getMatParams(cfg.drawCost)

		if MaterialFacade.instance:checkMatEnough(costType, costId, costNum) == false then
			local acfg = ItemConfig.instance:getActItemCfgById(self.actId)

			if acfg then
				MaterialMgr.openGetSource(costType, costId)
			end

			return
		end

		SuperGhostLotteryAgent.instance:sendPM_SuperGhostLotteryDrawReq(self.actId)

		return
	end
end

function SuperGhostLotteryView:_onClickEmpty()
	local info = SuperGhostLotteryModel.instance:getDrawInfo()

	if self._showPage ~= info.orderId then
		self:setToPage(info.orderId)

		return
	end

	UIStateManager.instance:push(ViewName.SuperGhostLotterySelectView)
end

function SuperGhostLotteryView:resetCost()
	if self.actId then
		local actCfg = SuperGhostLotteryConfig.instance:getActivityCfg(self.actId)
		local matType, matId, cost = MaterialMgr.getMatParams(actCfg.drawCost)
		local btn_list = {
			{
				showAdd = true,
				id = string.format("%s:%s", matType, matId)
			}
		}

		MainUIController.instance:showGlodBar(self._goldBarConGo, self._viewPresentor, btn_list)
		MaterialMgr.setIcon(self.ImgC_Icon, matType, matId)

		self._txtCost.text = checknumber(cost)
	end
end

return SuperGhostLotteryView
