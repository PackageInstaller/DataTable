-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wheellotterypool/view/WheelLotteryPoolView.lua

module("logic.extensions.wheellotterypool.view.WheelLotteryPoolView", package.seeall)

local WheelLotteryPoolView = class("WheelLotteryPoolView", ViewComponent)

function WheelLotteryPoolView:ctor()
	WheelLotteryPoolView.super.ctor(self)
end

function WheelLotteryPoolView:buildUI()
	WheelLotteryPoolView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTipsBubble = goutil.findChildTextComponent(self.mainGO, "tipsBubble/txt")
	self._con = goutil.findChild(self.mainGO, "con")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._btnGetPrize = self:getGo("right/prizeWheel/btnGetPrize")
	self._btnGetPrizeText = self:getTxt("right/prizeWheel/btnGetPrize/text")
	self._rightArrow = self:getGo("right/rightArrow")
	self._leftArrow = self:getGo("right/leftArrow")
	self._rewardArrow = self:getGo("right/rewardArrow")
	self._imgSelect = self:getGo("right/rewardPool/imgSelect")
	self._rotateDuration = 2
	self._curSelectIndex = 1
	self._rewardPool = self:getGo("right/rewardPool")
	self._tabScrView = goutil.findChild(self.mainGO, "prizeButton/tableview")
	self._tabScrCell = goutil.findChild(self.mainGO, "prizeButton/btnCell")
	self._tabScrollList = ScrollerList.create(self._tabScrView, self._tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._btnToggle = self:getGo("right/btnToggle")
	self._imgBtnToggleSelect = self:getGo("right/btnToggle/imgSelect")
	self._txtTier = self:getTxt("right/tip/txt")
	self._textTierTip = self:getGo("right/tip/Text")
	self._txtTierTip = self:getTxt("right/tip/Text")
	self._icon = self:getGo("right/coin/icon")
	self._txtNum = self:getTxt("right/coin/txtNum")
	self._clipRect = self.mainGO:GetComponent(goutil.Type_RectTransform)
	self._showOrigin = self:getGo("showOrigin")
	self._material = self:getGo("material")
	self._materialIcon = self:getGo("material/icon")
	self._materialTxtNum = self:getTxt("material/txtNum")
end

function WheelLotteryPoolView:bindEvents()
	WheelLotteryPoolView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClikBtnTip, self)
	GameUtil.addClickHandler(self._btnGetPrize, self._onClikBtnGetPrize, self)
	GameUtil.addClickHandler(self._leftArrow, self._onClickBtnLeftArrow, self)
	GameUtil.addClickHandler(self._rightArrow, self._onClickBtnRightArrow, self)
	GameUtil.addClickHandler(self._btnToggle, self._onClickBtnToggle, self)
	GameUtil.addClickHandler(self._material, self._onClickMaterial, self)
end

function WheelLotteryPoolView:unbindEvents()
	WheelLotteryPoolView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnGetPrize)
	GameUtil.rmClickHandler(self._leftArrow)
	GameUtil.rmClickHandler(self._rightArrow)

	for k, v in ipairs(self._rewardGoTable) do
		GameUtil.rmClickHandler(v.icon)
	end
end

function WheelLotteryPoolView:onEnter()
	WheelLotteryPoolView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = WheelLotteryPoolController.instance:getActivityId()
	end

	self._activityType = WheelLotteryPoolController.instance:getActivityType()

	local isInTime = WheelLotteryPoolController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self.addGEvent(self, GlobalNotify.HandlePM_WheelLotteryGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_WheelLotteryLotteryRes, self._playSelectAnim, self)

	self._toggleSelect = false
	self._curPoolId = 1
	self._curPrizePlanId = 0
	self._canSkipAnim = false
	self._canSkipAnimShow = true
	self._rewardGoList = GameUtil.getChildren(self._rewardPool.transform)
	self._rewardGoTable = {}
	self._imgChooseList = {}

	for i = 1, 8 do
		local curTable = {}

		curTable.icon = goutil.findChild(self._rewardGoList[i], "icon")
		curTable.txtNum = goutil.findChildTextComponent(self._rewardGoList[i], "num/txtNum")
		curTable.allReward = goutil.findChild(self._rewardGoList[i], "allRewardTxt")
		curTable.hasGetIcon = goutil.findChild(self._rewardGoList[i], "hasGetIcon")
		curTable.hasGain = goutil.findChild(self._rewardGoList[i], "hasGain")
		curTable.imgChoose = goutil.findChild(self._rewardGoList[i], "imgChoose")

		table.insert(self._rewardGoTable, curTable)

		local imgChooseGo = goutil.findChild(self._rewardGoList[i], "imgChoose")

		table.insert(self._imgChooseList, imgChooseGo)
	end

	for index, v in ipairs(self._rewardGoTable) do
		GameUtil.addClickHandler(v.icon, GameUtil.handler(self._onClickIcon, self, index), self)
	end

	self:_onSetUI()
	WheelLotteryPoolController.instance:sendPM_WheelLotteryGetInfoReq(self._activityId)
end

function WheelLotteryPoolView:onExit()
	WheelLotteryPoolView.super.onExit(self)

	for i, v in pairs(self._rewardGoTable) do
		MaterialMgr.resetAll(v.icon)
		MaterialMgr.resetAll(v.hasGetIcon)
	end
end

function WheelLotteryPoolView:_onUpdate()
	self:_updateData()
	self:_updateLotteryCost()
	self:_updateUI()
end

function WheelLotteryPoolView:_updateData()
	self._model = WheelLotteryPoolModel.instance:GetModel(self._activityId)
	self._curTier = WheelLotteryPoolModel.instance:getRecentTier(self._activityId, self._curPoolId)

	local curLotteryPoolData = WheelLotteryPoolConfig.instance:getWheelLotteryPoolData(self._activityId) or {}

	self._curTierPlanId = curLotteryPoolData[self._curPoolId].tierPlanId

	local tierNum = WheelLotteryPoolConfig.instance:getTierNum(self._activityId, self._curPoolId)

	if tierNum >= self._curTier then
		if not self._curTier then
			local curTierShowNum = tierNum

			self._curPrizePlanId = WheelLotteryPoolConfig.instance:getPrizePlanId(self._activityId, self._curPoolId, curTierShowNum)
			self._curSelectIndex = WheelLotteryPoolModel.instance:getCurPrizeId(self._activityId, self._curPoolId)

			self._tabScrollList:reloadData(curLotteryPoolData)
		end
	end
end

function WheelLotteryPoolView:_updateLotteryCost()
	local tierPlanData = WheelLotteryPoolConfig.instance:getWheelLotteryTierPlanData(self._curTierPlanId)
	local tierNum = WheelLotteryPoolConfig.instance:getTierNum(self._activityId, self._curPoolId)

	if tierNum >= self._curTier then
		if not self._curTier then
			local curTier = tierNum
			local matType, matId, matNum = MaterialMgr.getMatParams(tierPlanData[curTier].lotteryCost)

			self._matType = matType
			self._matId = matId
			self._matNum = matNum
		end
	end
end

function WheelLotteryPoolView:_updateUI()
	self:_initWheelUI()

	local curLotteryPoolData = WheelLotteryPoolConfig.instance:getWheelLotteryPoolData(self._activityId) or {}
	local curLotteryTierPlanData = WheelLotteryPoolConfig.instance:getWheelLotteryTierPlanData(self._curTierPlanId)
	local curPrizePlanData = WheelLotteryPoolConfig.instance:getWheelLotteryPrizePlanData(self._curPrizePlanId)
	local curTierNum = WheelLotteryPoolConfig.instance:getTierNum(self._activityId, self._curPoolId)

	if curTierNum >= self._curTier then
		if not self._curTier then
			local curTierShowNum = curTierNum

			for prizeIndex, v in pairs(self._rewardGoTable) do
				if curPrizePlanData[prizeIndex].prize ~= "" then
					GameUtil.SetActive(v.icon, true)

					local type, id, num = MaterialMgr.getMatParams(curPrizePlanData[prizeIndex].prize)

					MaterialMgr.setIcon(v.icon, type, id)
					MaterialMgr.setIcon(v.hasGetIcon, type, id)

					v.txtNum.text = num
				else
					GameUtil.SetActive(v.allReward, true)
					GameUtil.SetActive(v.txtNum.gameObject, false)
					GameUtil.SetActive(v.icon, false)
				end

				local isHasGain = WheelLotteryPoolModel.instance:isHasGain(self._activityId, self._curPoolId, self._curTier, prizeIndex)

				if prizeIndex ~= 1 then
					GameUtil.SetActive(v.hasGetIcon, isHasGain)
					GameUtil.SetActive(v.hasGain, isHasGain)
				else
					GameUtil.SetActive(v.hasGetIcon, false)
					GameUtil.SetActive(v.hasGain, false)
				end
			end

			if WheelLotteryPoolModel.instance:canGetPrize(self._activityId, self._curPoolId, self._curTier) then
				self._btnGetPrizeText.text = "立即抽奖"

				GameUtil.SetActive(self._textTierTip, true)

				local isInfinitePool = WheelLotteryPoolConfig.instance:isInfinitePool(self._activityId, self._curPoolId)

				self._txtTierTip.text = isInfinitePool and curTierNum <= self._curTier and "为无限池，可以重复抽取" or "所有奖励抽完后进入下一层"
			else
				self._btnGetPrizeText.text = "暂未解锁"

				GameUtil.SetActive(self._textTierTip, false)
			end

			self._txtTier.text = string.format("当前第<color=#ff0000>%d</color>/%d层", curTierShowNum, curTierNum)
			self._txtTipsBubble.text = curLotteryPoolData[self._curPoolId].poolBubble or ""

			if self._curTier <= 1 then
				GameUtil.SetActive(self._leftArrow, false)
			end

			if self._curTier >= #curLotteryTierPlanData then
				GameUtil.SetActive(self._rightArrow, false)
			end

			local key = string.format(self._activityId)
			local isNotFirst = GameUtil.getUserDayData(key)

			if not isNotFirst then
				self._canSkipAnim = false

				GameUtil.SetActive(self._imgBtnToggleSelect, self._canSkipAnim and self._canSkipAnimShow)
			else
				self._canSkipAnim = true

				GameUtil.SetActive(self._imgBtnToggleSelect, self._canSkipAnim and self._canSkipAnimShow)
			end

			GameUtil.SetActive(self._btnToggle, true)
			MaterialMgr.setIcon(self._icon, self._matType, self._matId, nil, nil)

			self._txtNum.text = self._matNum

			local curMaterialNum = MaterialModel.instance:getMaterialsNumber(self._matType, self._matId)

			MaterialMgr.setIcon(self._materialIcon, self._matType, self._matId, nil, nil)

			self._materialTxtNum.text = curMaterialNum
		end
	end
end

function WheelLotteryPoolView:_updateTabCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtComplete = goutil.findChild(cell, "txtComplete")
	local imgChoose = goutil.findChild(cell, "imgChoose")
	local isComplete = WheelLotteryPoolModel.instance:poolIsComplete(self._activityId, data.poolId)

	txtName.text = WheelLotteryPoolConfig.instance:getPoolName(self._activityId, data.poolId)

	GameUtil.SetActive(txtComplete, isComplete)
	GameUtil.SetActive(imgChoose, data.poolId == self._curPoolId)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickTabCell, self, data.poolId))
end

function WheelLotteryPoolView:_onClickTabCell(poolId)
	self._curPoolId = poolId
	self._curTier = WheelLotteryPoolModel.instance:getRecentTier(self._activityId, poolId)
	self._curSelectIndex = 1

	self:_onUpdate()
end

function WheelLotteryPoolView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function WheelLotteryPoolView:_initWheelUI()
	for i = 1, 8 do
		GameUtil.SetActive(self._imgChooseList[i], false)
		GameUtil.SetActive(self._rewardGoTable[i].allReward, false)
		GameUtil.SetActive(self._rewardGoTable[i].hasGetIcon, false)
		GameUtil.SetActive(self._rewardGoTable[i].hasGain, false)
		GameUtil.SetActive(self._rewardGoTable[i].imgChoose, false)
		GameUtil.SetActive(self._rewardGoTable[i].txtNum.gameObject, true)
	end

	GameUtil.setLocalRotation(self._rewardArrow, 0, 0, -45 * (self._curSelectIndex - 1))
	GameUtil.setLocalRotation(self._imgSelect, 0, 0, -270 - 45 * (self._curSelectIndex - 1))
	GameUtil.SetActive(self._leftArrow, true)
	GameUtil.SetActive(self._rightArrow, true)
end

function WheelLotteryPoolView:_onClikBtnTip()
	local key = WheelLotteryPoolConfig.instance:getCommonData(self._activityId).ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function WheelLotteryPoolView:_onClikBtnGetPrize()
	local isComplete = WheelLotteryPoolModel.instance:poolIsComplete(self._activityId, self._curPoolId)
	local curMatNum = MaterialModel.instance:getMaterialsNumber(self._matType, self._matId)

	if isComplete then
		FloatWordMgr.instance:show("奖池已完成，无法再次抽取")

		return
	end

	if curMatNum < self._matNum then
		FloatWordMgr.instance:show("抽奖道具数量不足，请先集齐抽奖道具哦！")
		TipsFacade.instance:openItemSourceView(MaterialMgr.createSerName(self._matType, self._matId))

		return
	end

	if not WheelLotteryPoolModel.instance:canGetPrize(self._activityId, self._curPoolId, self._curTier) then
		FloatWordMgr.instance:show("先抽完前面的奖励，才能解锁本层奖励哦！")

		return
	end

	WheelLotteryPoolController.instance:sendPM_WheelLotteryLotteryReq(self._activityId, self._curPoolId)
end

function WheelLotteryPoolView:_onClickBtnLeftArrow()
	local tierNum = WheelLotteryPoolConfig.instance:getTierNum(self._activityId, self._curPoolId)

	if tierNum >= self._curTier then
		self._curTier = self._curTier - 1 or tierNum - 1
	end

	if tierNum >= self._curTier then
		if not self._curTier then
			local curTierShowNum = tierNum

			self._curPrizePlanId = WheelLotteryPoolConfig.instance:getPrizePlanId(self._activityId, self._curPoolId, curTierShowNum)
			self._curSelectIndex = 1

			self:_updateLotteryCost()
			self:_updateUI()
		end
	end
end

function WheelLotteryPoolView:_onClickBtnRightArrow()
	local tierNum = WheelLotteryPoolConfig.instance:getTierNum(self._activityId, self._curPoolId)
	local recentTier = WheelLotteryPoolModel.instance:getRecentTier(self._activityId, self._curPoolId)

	if self._curTier == tierNum - 1 then
		self._curTier = tierNum < recentTier and recentTier or self._curTier + 1
	elseif self._curTier < tierNum - 1 then
		self._curTier = self._curTier + 1
	end

	if tierNum >= self._curTier then
		if not self._curTier then
			local curTierShowNum = tierNum

			self._curPrizePlanId = WheelLotteryPoolConfig.instance:getPrizePlanId(self._activityId, self._curPoolId, curTierShowNum)
			self._curSelectIndex = 1

			self:_updateLotteryCost()
			self:_updateUI()
		end
	end
end

function WheelLotteryPoolView:_onClickBtnToggle()
	if not self._canSkipAnim then
		FloatWordMgr.instance:show("每日进行首次抽奖后可跳过动画~")

		return
	end

	self._canSkipAnimShow = not self._canSkipAnimShow

	self:_updateUI()
end

function WheelLotteryPoolView:_onClickIcon(index)
	local icon = self._rewardGoTable[index].icon
	local prizePlanData = WheelLotteryPoolConfig.instance:getWheelLotteryPrizePlanData(self._curPrizePlanId)
	local prize = prizePlanData[index].prize

	if prize == "" then
		return
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(prize)

	CommonTipsMgr.instance:openMaterialTips(icon, matType, matId, 0)
end

function WheelLotteryPoolView:_playSelectAnim()
	local key = string.format(self._activityId)

	GameUtil.saveUserDayData(key, true)

	if self._canSkipAnimShow and self._canSkipAnim then
		local changeSetId = WheelLotteryPoolModel.instance:getRecentChangeSetId(self._activityId)

		MaterialController.instance:showChangeSetInTemp(changeSetId)
		self:_onUpdate()

		return
	end

	local preIndex = self._curSelectIndex

	self:_updateData()

	local x, y, z = GameUtil.getLocalRotation(self._imgSelect)
	local finalAngle = z - 45 * (8 - (preIndex - 1)) - 1440 - 45 * (self._curSelectIndex - 1)

	self._imgSelect.transform:DORotate(Vector3.New(0, 0, finalAngle), self._rotateDuration, DG.Tweening.RotateMode.FastBeyond360):SetEase(DG.Tweening.Ease.InOutQuad):OnUpdate(function()
		local x, y, z = GameUtil.getLocalRotation(self._imgSelect)
		local curIndex = math.ceil((z + 270) / -45)
		local calIndex = (z + 270) / -45

		if curIndex - calIndex <= 0.3 then
			GameUtil.SetActive(self._imgChooseList[curIndex % 8 + 1], true)

			if curIndex % 8 ~= 0 then
				if not (curIndex % 8) then
					local lastIndex = 8

					GameUtil.SetActive(self._imgChooseList[lastIndex], false)
				end
			end
		end
	end)
	self._rewardArrow.transform:DORotate(Vector3.New(0, 0, -1440 - 45 * (self._curSelectIndex - 1)), self._rotateDuration, DG.Tweening.RotateMode.FastBeyond360):SetEase(DG.Tweening.Ease.InOutQuad):OnStart(function()
		ViewBlockMgr.instance:blockClick(true, self)
	end):OnComplete(function()
		local changeSetId = WheelLotteryPoolModel.instance:getRecentChangeSetId(self._activityId)

		MaterialController.instance:showChangeSetInTemp(changeSetId)
		self:_updateUI()
		ViewBlockMgr.instance:blockClick(false, self)
	end)
end

function WheelLotteryPoolView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
end

function WheelLotteryPoolView:_getSkinId()
	return WheelLotteryPoolController.instance:getSkinId(self._activityId)
end

function WheelLotteryPoolView:_onClickMaterial()
	TipsFacade.instance:openItemSourceView(MaterialMgr.createSerName(self._matType, self._matId))
end

return WheelLotteryPoolView
