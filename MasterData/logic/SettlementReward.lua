-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/SettlementReward.lua

module("logic.extensions.battlesettlement.view.SettlementReward", package.seeall)

local SettlementReward = class("SettlementReward", BSAnimPlay)

function SettlementReward:buildUI(parent)
	SettlementReward.super.buildUI(self, parent)

	self._imgBgTarget = goutil.findChild(parent, "imgBgTarget"):GetComponent(goutil.Type_RectTransform)
	self._rewardList = goutil.findChild(parent, "rewardList"):GetComponent(goutil.Type_RectTransform)
	self._tableview = goutil.findChild(parent, "rewardList"):GetComponent("UITableview")
	self._tableCell = goutil.findChild(parent, "rewardList/itemReward")
	self._txtRewardTips = goutil.findChild(parent, "txtRewardTips"):GetComponent(goutil.Type_UIText)
	self._rewardListGraphic = self._rewardList:GetComponent(typeof(UnityEngine.UI.Graphic))
	self._descTxt = goutil.findChildTextComponent(parent, "imgBgTarget/descTxt")
	self._descTxt.text = ""

	GameUtil.SetActive(self._txtRewardTips, false)
end

function SettlementReward:onEnter(totalHeight, curPosY, delayTime)
	SettlementReward.super.onEnter(self, totalHeight, curPosY, delayTime)

	if self._isEntered then
		return self:_getDefault()
	end

	self._isEntered = true

	self:_setViewOtherShow()
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._curViewDatas = {}

	local isShow = false
	local items = BattleSettlementModel.instance:getRewardList()
	local tem = {}

	if items ~= nil then
		for k, mo in pairs(items) do
			if mo.item.type == MatType.Pet then
				table.insert(tem, mo.item)
			end
		end
	end

	MaterialController.instance:showChangeSetItemMo(tem)

	if not items or #items <= 0 then
		isShow = false
	else
		isShow = true

		for i, v in ipairs(items) do
			local element = {}

			element.rewardType = 0
			element.type = v.item.type
			element.id = v.item.id
			element.num = v.item.num
			element.isDouble = v.isDouble
			element.doubleNum = v.doubleNum
			self._curViewDatas[i] = element
		end
	end

	local captureUnits = BattleModel.instance:getCatchedUnits()

	if #captureUnits > 0 then
		isShow = true

		for i = 1, #captureUnits do
			local index = #self._curViewDatas + 1
			local element = {}

			element.rewardType = 1
			element.raceId = captureUnits[i].raceId
			element.level = captureUnits[i].level
			self._curViewDatas[index] = element
		end
	end

	local settlementType = BattleSettlementModel.instance:getType()

	if settlementType == BattleSettlementModel.Enum.BountyPKCompete then
		isShow = true
	end

	local fakeMatStrList = BattleSettlementModel.instance:getFakeMatStrList()

	if fakeMatStrList and #fakeMatStrList > 0 then
		isShow = true

		for i, matStr in ipairs(fakeMatStrList) do
			local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
			local element = {}

			element.rewardType = 3
			element.matStr = matStr
			element.matType = matType
			element.matId = matId
			element.matNum = matNum
			self._curViewDatas[#self._curViewDatas + 1] = element
		end
	end

	goutil.setActive(self._parent, isShow)
	printInfo("显示奖励", isShow)

	if isShow then
		self._tableview:SetOffsetWithoutRefresh(0)
		self._tableview:ReloadData()
	end

	self._rewardListGraphic.raycastTarget = #self._curViewDatas > 4

	return self:getNextData(isShow)
end

function SettlementReward:_setViewOtherShow()
	self._descTxt.text = ""

	local settlementType = BattleSettlementModel.instance:getType()

	GameUtil.SetActive(self._txtRewardTips, false)

	if settlementType == BattleSettlementModel.Enum.Endless then
		if ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.EndlessAttack) then
			self._descTxt.text = "获得的每日奖励已翻倍"
		end
	elseif settlementType == BattleSettlementModel.Enum.BountyPKCompete then
		local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

		self._txtRewardTips.text = string.format("%s\n%s", langPara("bountypk__14", phaseModel:getChangeScoreStr()), langPara("bountypk__15", phaseModel.newScore))

		GameUtil.SetActive(self._txtRewardTips, true)
	end
end

function SettlementReward:onExit()
	self._isEntered = false

	goutil.setActive(self._parent, false)
	self:doKillTween()
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}

	self._tableview:UnRegisterAllCallbacks()

	self._rewardListGraphic.raycastTarget = true
end

function SettlementReward:_setHeight()
	self.height = self._parentRectTrans.rect.height

	Framework.TransformUtil.SetAnchoredPos(self._parentRectTrans, 0, self:_getCurPosY())
end

function SettlementReward:getMaxHeight()
	return self._parentRectTrans.rect.height
end

function SettlementReward:_setAnimCostTime()
	self.animCostTime = self._delayTime1 * 2
end

function SettlementReward:doTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, 0)
	Framework.TransformUtil.SetAnchoredPos(self._rewardList, 1500, self._rewardList.anchoredPosition.y)

	local curTime = self._time1
	local curDelay = self._delayTime1 + self:_getCurTimePoint()

	self._imgBgTarget:DOAnchorPosX(0, curTime):SetDelay(curDelay)

	curDelay = curDelay + self._delayTime1

	self._rewardList:DOAnchorPosX(0, curTime):SetDelay(curDelay)
end

function SettlementReward:doKillTween()
	SettlementReward.super.doKillTween(self)
	self._imgBgTarget:DOKill(true)
	self._rewardList:DOKill(true)
end

function SettlementReward:doCompleteTween()
	self:doKillTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 0, 0)
	Framework.TransformUtil.SetAnchoredPos(self._rewardList, 0, self._rewardList.anchoredPosition.y)
end

function SettlementReward:_numInView()
	return #self._curViewDatas
end

function SettlementReward:_cellSize()
	return 76, 76
end

function SettlementReward:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function SettlementReward:_updateCell(view, cell, data)
	Framework.TransformUtil.SetLocalScale(cell.gameObject.transform, 0.9, 0.9, 0.9)

	local parentGo = goutil.findChild(cell.gameObject, "node")
	local doubleGo = goutil.findChild(cell.gameObject, "double")
	local doubleTxt = goutil.findChildTextComponent(doubleGo, "Text")

	if data.rewardType == 0 then
		local proxy = MaterialMgr.setCellByGId(data.type, data.id, parentGo)

		if proxy == nil then
			return
		end

		if data.type == MatType.Pet then
			proxy:setCallBack(function()
				CommonTipsMgr.instance:openMaterialTips(parentGo, data.type, data.id)
			end)
		end

		proxy.binder:setNum(data.num)
	elseif data.rewardType == 1 then
		local proxy = MaterialMgr.setCell(MatType.Pet, data.raceId, parentGo)

		if proxy then
			proxy.binder:setLvl(data.level)
		end
	elseif data.rewardType == 2 then
		local proxy = MaterialMgr.setCellByCfg(data.cfgStr, parentGo)
	elseif data.rewardType == 3 then
		local proxy = MaterialMgr.setCellByCfg(data.matStr, parentGo)

		BattleSettlementModel.instance:clearFakeMatStrList()
	end

	if data.isDouble then
		doubleGo:SetActive(true)

		doubleTxt.text = checknumber(data.doubleNum) <= 0 and "+100%" or string.format("+%s%%", data.doubleNum)
	else
		doubleTxt.text = ""

		doubleGo:SetActive(false)
	end
end

function SettlementReward:_clearTableview(cell)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.resetAll(parentGo)
end

return SettlementReward
