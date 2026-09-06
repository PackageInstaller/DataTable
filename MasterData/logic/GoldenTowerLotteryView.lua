-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldentowerlottery/view/GoldenTowerLotteryView.lua

module("logic.extensions.goldentowerlottery.view.GoldenTowerLotteryView", package.seeall)

local GoldenTowerLotteryView = class("GoldenTowerLotteryView", ViewComponent)

function GoldenTowerLotteryView:ctor()
	GoldenTowerLotteryView.super.ctor(self)
end

function GoldenTowerLotteryView:unbindEvents()
	GoldenTowerLotteryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnToggle)
	GameUtil.rmClickHandler(self._coin)
end

function GoldenTowerLotteryView:bindEvents()
	GoldenTowerLotteryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickBtnLottery, self)
	GameUtil.addClickHandler(self._btnToggle, self._onClickBtnToggle, self)
	GameUtil.addClickHandler(self._coin, self._onClickBtnCoin, self)
end

function GoldenTowerLotteryView:buildUI()
	GoldenTowerLotteryView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnLottery = self:getGo("btnLottery")
	self._btnToggle = self:getGo("btnToggle")
	self._goldbar = self:getGo("goldbar")
	self._coin = self:getGo("coin")
	self._iconCoin = self:getGo("coin/icon")
	self._txtNumCoin = self:getTxt("coin/txtNum")
	self._con = self:getGo("con")
	self._btnToggle = self:getGo("btnToggle")
	self._imgSelect = self:getGo("btnToggle/imgSelect")
	self._rewardCell = self:getGo("rewardCell")
	self._floorGoList = {}

	for i = 1, 5 do
		local floor = self:getGo("floors/floor" .. i)

		table.insert(self._floorGoList, floor)
	end

	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function GoldenTowerLotteryView:onExit()
	GoldenTowerLotteryView.super.onExit(self)
	MaterialMgr.clearIcon(self._iconCoin)
	RoleObjectPool.instance:removeRole(self._role)
	self:_killLotteryTween()
	self:_clearFloors()
end

function GoldenTowerLotteryView:onEnter()
	GoldenTowerLotteryView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_GoldenTowerLotteryGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_GoldenTowerLotteryLotteryRes, self._onLotteryRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 606001
	end

	self._poolId = 1
	self._cellsMap = {}
	self._poolCfgs = GoldenTowerLotteryConfig.instance:getPoolCfgs(self._activityId) or {}
	self._commonCfg = GoldenTowerLotteryConfig.instance:getCommonCfg(self._activityId)
	self._skipAnim = false

	self:_onSetUI()
	GoldenTowerLotteryController.instance:sendPM_GoldenTowerLotteryGetInfoReq(self._activityId)
end

function GoldenTowerLotteryView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	GameUtil.SetActive(self._imgSelect, self._skipAnim)
end

function GoldenTowerLotteryView:_updateFloors()
	for i, go in ipairs(self._floorGoList) do
		GameUtil.SetActive(go, i <= self._hasFloorNum)
	end

	for i = 1, #self._floorGoList do
		local floorGo = self._floorGoList[i]

		GameUtil.SetActive(floorGo, i <= self._hasFloorNum)

		if i <= self._hasFloorNum then
			local rewards = goutil.findChild(floorGo, "rewards")
			local tierPlanCfg = self._tierPlanCfgs[i]

			if tierPlanCfg then
				local prizePlanId = tierPlanCfg.prizePlanId
				local prizePlanCfgs = GoldenTowerLotteryConfig.instance:getPrizePlanCfgs(prizePlanId) or {}
				local cellsMapDatas = {}

				for j, cfg in ipairs(prizePlanCfgs) do
					local data = {}

					data.tierId = i
					data.cfg = cfg

					table.insert(cellsMapDatas, data)
				end

				self._cellsMap[i] = GameUtil.updateCellsList(rewards, self._rewardCell, cellsMapDatas, self._updateMutiSingleCell, self)
			end
		end
	end
end

function GoldenTowerLotteryView:_updateRole()
	if self._poolCfg then
		if self._poolCfg then
			local pos = self._poolCfg.posNScale

			self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._poolCfg, self._con, nil, nil, true, nil, nil)

			if self._poolCfg > 0 and pos then
				GameUtil.setLocalPos(self._con, checknumber(pos[1]), checknumber(pos[2]), 0)
			end
		end
	end
end

function GoldenTowerLotteryView:_clearFloors()
	for i = 1, #self._floorGoList do
		local floorGo = self._floorGoList[i]
		local rewards = goutil.findChild(floorGo, "rewards")

		GameUtil.clearCells(rewards, self._clearMultiSingleCell, self, false)
	end
end

function GoldenTowerLotteryView:_onUpdate()
	self._poolCfg = self._poolCfgs[self._poolId] or {}

	local tierPlanId = checknumber(self._poolCfg.tierPlanId)

	self._tierPlanCfgs = GoldenTowerLotteryConfig.instance:getTierPlanCfgs(tierPlanId) or {}
	self._hasFloorNum = #self._tierPlanCfgs
	self._curPoolInfo = GoldenTowerLotteryModel.instance:getPoolInfo(self._activityId, self._poolId) or {}

	if checknumber(self._curPoolInfo.curTier) > 0 then
		self._curTier = self._curPoolInfo.curTier or 1
	end

	self._scrollList:reloadData(self._poolCfgs)
	self:_updateFloors()

	local costStr = self._poolCfg.lotteryCost
	local matName = MaterialMgr.getMaterialsNameByCfg(costStr)
	local matType, matId, matNum = MaterialMgr.getMatParams(costStr)
	local hasMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	self._txtNumCoin.text = string.format(langPara("%s/%s", matNum, hasMatNum))

	MaterialMgr.setIcon(self._iconCoin, matType, matId, nil, nil)
	self:_updateRole()
end

function GoldenTowerLotteryView:_updateCell(view, cell, data)
	local time = goutil.findChild(cell, "time")
	local imgChangeComp = goutil.findChild(cell, "img"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtTime = goutil.findChildTextComponent(cell, "time/txtTime")
	local hasSelect = self._poolId == data.poolId
	local changeIdx = hasSelect and 1 or 0
	local curTime = ServerTime.now()
	local openTime = GameUtil.string2time(data.openTime)
	local timeStr = GameUtil.formatTimeStamp(lang("%m.%d %H:%M开启"), openTime)
	local isNotInTime = curTime < openTime

	imgChangeComp:SetState(changeIdx)

	txtName.text = data.name
	txtTime.text = timeStr

	GameUtil.SetActive(time, isNotInTime)
	GameUtil.addClickHandler(cell, function()
		self._poolId = data.poolId

		self:_onUpdate()
	end, self)
end

function GoldenTowerLotteryView:_clearCell(cell)
	GameUtil.rmClickHandler(cell)
end

function GoldenTowerLotteryView:_updateMutiSingleCell(cell, data, index)
	local item = goutil.findChild(cell, "item")
	local allGet = goutil.findChild(cell, "allGet")
	local geted = goutil.findChild(cell, "geted")
	local left = goutil.findChild(cell, "left")
	local btnItem = goutil.findChild(cell, "btnItem")
	local tag = goutil.findChild(cell, "tag")
	local txtLeft = goutil.findChildTextComponent(cell, "left/txt")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local cfg = data.cfg
	local curTier = data.tierId
	local gainAll = cfg.gainAll
	local gainLimit = cfg.gainLimit
	local getedTime = GoldenTowerLotteryModel.instance:getPrizeGainTimes(self._activityId, self._poolId, cfg.prizeId)
	local curTierHasGetTime = self._curTier == curTier and getedTime or 0
	local hasGeted = curTier < self._curTier or gainLimit <= curTierHasGetTime

	txtLeft.text = self._curTier == curTier and gainLimit - getedTime or gainLimit
	txtNum.text = ""

	local matType, matId, matNum = MaterialMgr.getMatParams(cfg.prize)
	local matName = MaterialMgr.getMaterialsNameByCfg(cfg.prize)
	local isGoldenPieces = matType == MatType.Item and matId == 400002

	if not gainAll then
		MaterialMgr.setIcon(item, matType, matId, nil, nil)

		txtNum.text = matNum
	end

	GameUtil.SetActive(tag, isGoldenPieces)
	GameUtil.SetActive(item, not gainAll)
	GameUtil.SetActive(allGet, gainAll)
	GameUtil.SetActive(geted, hasGeted)
	GameUtil.SetActive(left, curTier >= self._curTier and gainLimit - curTierHasGetTime > 0 and not gainAll)
	GameUtil.addClickHandler(btnItem, function()
		if matType then
			CommonTipsMgr.instance:openMaterialTips(item, matType, matId, matNum)
		end
	end)
end

function GoldenTowerLotteryView:_clearMultiSingleCell(cell)
	local item = goutil.findChild(cell, "item")
	local btnItem = goutil.findChild(cell, "btnItem")

	MaterialMgr.clearIcon(item)
	GameUtil.rmClickHandler(btnItem)
end

function GoldenTowerLotteryView:_onClickBtnTip()
	local key = self._commonCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function GoldenTowerLotteryView:_onClickBtnLottery()
	if self._curTier > self._hasFloorNum then
		FloatWordMgr.instance:show(lang("该奖池所有奖励已抽完，不可再抽"))

		return
	end

	local lotteryCfg = GoldenTowerLotteryConfig.instance:getPoolCfg(self._activityId, self._poolId)
	local curTime = ServerTime.now()
	local openTime = GameUtil.string2time(lotteryCfg.openTime)
	local isNotInTime = curTime < openTime

	if isNotInTime then
		FloatWordMgr.instance:show(lang("本奖池暂未开启"))

		return
	end

	local costStr = self._poolCfg.lotteryCost
	local matName = MaterialMgr.getMaterialsNameByCfg(costStr)
	local matType, matId, matNum = MaterialMgr.getMatParams(costStr)
	local hasMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if hasMatNum <= 0 then
		TipsFacade.instance:openItemSourceView(costStr)

		return
	end

	self:_initAllPrize()
	GoldenTowerLotteryController.instance:sendPM_GoldenTowerLotteryLotteryReq(self._activityId, self._poolId)
end

function GoldenTowerLotteryView:_initAllPrize()
	local cells = self._cellsMap[self._curTier]

	for i, cellGo in ipairs(cells) do
		local imgSelect = goutil.findChild(cellGo, "imgSelect")

		GameUtil.SetActive(imgSelect, false)
	end
end

function GoldenTowerLotteryView:_killLotteryTween()
	if self._lotteryTween then
		self._lotteryTween:Kill(false)

		self._lotteryTween = nil
	end

	self._lastLotteryCellGo = nil
end

function GoldenTowerLotteryView:_showLotterySelectByIndex(cells, index)
	if self._lastLotteryCellGo then
		local lastImgSelect = goutil.findChild(self._lastLotteryCellGo, "imgSelect")

		GameUtil.SetActive(lastImgSelect, false)
	end

	local cellGo = cells[index]

	if cellGo then
		local imgSelect = goutil.findChild(cellGo, "imgSelect")

		GameUtil.SetActive(imgSelect, true)

		self._lastLotteryCellGo = cellGo
	end
end

function GoldenTowerLotteryView:_appendLotterySelectStep(sequence, cells, index, interval)
	sequence:AppendCallback(function()
		self:_showLotterySelectByIndex(cells, index)
	end)
	sequence:AppendInterval(interval)
end

function GoldenTowerLotteryView:_showLotteryReward(prizeId)
	local changeSetId = GoldenTowerLotteryModel.instance:popChangeSetId()

	MaterialController.instance:showChangeSetInTemp(changeSetId)

	local cells = self._cellsMap[self._curTier]

	self:_showLotterySelectByIndex(cells, prizeId)
	self:_onUpdate()
end

function GoldenTowerLotteryView:_onLotteryTweenComplete(cells, targetIndex)
	self:_showLotterySelectByIndex(cells, targetIndex)

	self._lotteryTween = nil

	self:_showLotteryReward()
	ViewBlockMgr.instance:blockClick(false, self)
end

function GoldenTowerLotteryView:_bindLotteryTweenComplete(sequence, cells, targetIndex)
	sequence:OnComplete(function()
		self:_onLotteryTweenComplete(cells, targetIndex)
	end)
end

function GoldenTowerLotteryView:_playLotteryTween(prizeId)
	local cells = self._cellsMap[self._curTier]

	if not cells or #cells <= 0 then
		self:_showLotteryReward()

		return
	end

	if not self._tierPlanCfgs[self._curTier] then
		local tierPlanCfg = {}
		local prizePlanId = checknumber(tierPlanCfg.prizePlanId)
		local prizePlanCfgs = GoldenTowerLotteryConfig.instance:getPrizePlanCfgs(prizePlanId) or {}
		local lotteryCellIndexList = {}
		local targetLotteryIndex = 0
		local targetCellIndex = 0

		for i, cfg in ipairs(prizePlanCfgs) do
			local cfgPrizeId = checknumber(cfg.prizeId)
			local isTargetPrize = cfgPrizeId == checknumber(prizeId)
			local getedTime = GoldenTowerLotteryModel.instance:getPrizeGainTimes(self._activityId, self._poolId, cfg.prizeId)
			local gainLimit = cfg.gainLimit
			local hasGeted = gainLimit <= getedTime

			if isTargetPrize then
				targetCellIndex = i
			end

			if not hasGeted or isTargetPrize then
				table.insert(lotteryCellIndexList, i)

				if isTargetPrize then
					targetLotteryIndex = #lotteryCellIndexList
				end
			end
		end

		if targetLotteryIndex <= 0 or #lotteryCellIndexList <= 0 then
			self:_showLotteryReward()

			return
		end

		self:_killLotteryTween()
		self:_initAllPrize()

		local roundNum = 4
		local totalNum = roundNum * #lotteryCellIndexList + targetLotteryIndex
		local minInterval = 0.04
		local maxInterval = 0.28
		local sequence = DG.Tweening.DOTween.Sequence()

		for i = 1, totalNum do
			local lotteryIndex = (i - 1) % #lotteryCellIndexList + 1
			local cellIndex = lotteryCellIndexList[lotteryIndex]
			local percent = i / totalNum
			local interval = minInterval + (maxInterval - minInterval) * percent * percent

			self:_appendLotterySelectStep(sequence, cells, cellIndex, interval)
		end

		self:_bindLotteryTweenComplete(sequence, cells, targetCellIndex)

		self._lotteryTween = sequence
	end
end

function GoldenTowerLotteryView:_onLotteryRes(prizeId)
	if self._skipAnim then
		self:_showLotteryReward(prizeId)
	else
		ViewBlockMgr.instance:blockClick(true, self)
		self:_playLotteryTween(prizeId)
	end
end

function GoldenTowerLotteryView:_onClickBtnToggle()
	self._skipAnim = not self._skipAnim

	GameUtil.SetActive(self._imgSelect, self._skipAnim)
end

function GoldenTowerLotteryView:_onClickBtnCoin()
	local costStr = self._poolCfg.lotteryCost

	TipsFacade.instance:openItemSourceView(costStr)
end

return GoldenTowerLotteryView
