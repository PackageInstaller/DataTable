-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/familyhouding/SettlementBossReward.lua

module("logic.extensions.battlesettlement.view.familyhouding.SettlementBossReward", package.seeall)

local SettlementBossReward = class("SettlementBossReward", BSAnimPlay)

function SettlementBossReward:buildUI(parent)
	SettlementBossReward.super.buildUI(self, parent)

	self._imgBgTarget = goutil.findChild(parent, "imgBgTarget"):GetComponent(goutil.Type_RectTransform)
	self._prizeCol = goutil.findChild(parent, "prizeCol"):GetComponent(goutil.Type_RectTransform)
	self._prizeContent = goutil.findChild(parent, "prizeCol/prizeView/Viewport/Content")
	self._prizeView = goutil.findChild(parent, "prizeCol/prizeView")
	self._prizeCell = goutil.findChild(parent, "prizeCol/prizeCell")

	GameUtil.SetActive(self._prizeCell, false)
	GameUtil.SetActive(self._parent, false)
end

function SettlementBossReward:onEnter(totalHeight, curPosY, delayTime)
	SettlementBossReward.super.onEnter(self, totalHeight, curPosY, delayTime)

	if self._isEntered then
		return self:_getDefault()
	end

	self._isEntered = true

	GameUtil.SetActive(self._parent, true)
	self:_onUpdatePrizeColData()
	self:_onUpdatePrizeColUI()

	return self:getNextData(true)
end

function SettlementBossReward:onExit()
	self._isEntered = false

	GameUtil.SetActive(self._parent, true)
	self:_onClearPrizeCol()
end

function SettlementBossReward:_setHeight()
	self.height = self._parentRectTrans.rect.height

	Framework.TransformUtil.SetAnchoredPos(self._parentRectTrans, 0, self:_getCurPosY())
end

function SettlementBossReward:getMaxHeight()
	return self._parentRectTrans.rect.height
end

function SettlementBossReward:_setAnimCostTime()
	self.animCostTime = self._delayTime1 * 2
end

function SettlementBossReward:doTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, 0)

	local curTime = self._time1
	local curDelay = self._delayTime1 + self:_getCurTimePoint()

	self._imgBgTarget:DOAnchorPosX(0, curTime):SetDelay(curDelay)
	Framework.TransformUtil.SetAnchoredPos(self._prizeCol, 1500, 0)
	self._prizeCol:DOAnchorPosX(0, curTime):SetDelay(curDelay + self._delayTime1)
end

function SettlementBossReward:doKillTween()
	SettlementBossReward.super.doKillTween(self)
	self._imgBgTarget:DOKill(true)
	self._prizeCol:DOKill(true)
end

function SettlementBossReward:doCompleteTween()
	self:doKillTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 0, 0)
	Framework.TransformUtil.SetAnchoredPos(self._prizeCol, 0, 0)
end

function SettlementBossReward:_onUpdatePrizeColData()
	self._prizeInfoList = {}

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

	if items and #items > 0 then
		for i, v in ipairs(items) do
			local element = {}

			element.rewardType = 0
			element.type = v.item.type
			element.id = v.item.id
			element.num = v.item.num
			element.isDouble = v.isDouble
			element.doubleNum = v.doubleNum

			table.insert(self._prizeInfoList, element)
		end
	end

	local captureUnits = BattleModel.instance:getCatchedUnits()

	if #captureUnits > 0 then
		for i = 1, #captureUnits do
			local element = {}

			element.rewardType = 1
			element.raceId = captureUnits[i].raceId
			element.level = captureUnits[i].level

			table.insert(self._prizeInfoList, element)
		end
	end
end

function SettlementBossReward:_onUpdatePrizeColUI()
	local parentTran = self._prizeContent.transform
	local childGo = self._prizeCell
	local childCount = #self._prizeInfoList
	local children = GameUtil.getChildren(parentTran)

	for index, mainGo in ipairs(children) do
		GameUtil.SetActive(mainGo, index <= childCount)
	end

	GameUtil.SetActive(self._prizeView, childCount > 0)

	for index = 1, childCount do
		local mainGo = children[index]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, index))
		end

		GameUtil.SetActive(mainGo, true)
		self:_updatePrizeCell(mainGo, self._prizeInfoList[index])
	end
end

function SettlementBossReward:_onClearPrizeCol()
	local children = GameUtil.getChildren(self._prizeContent.transform)

	for index, mainGo in ipairs(children) do
		self:_clearPrizeCell(mainGo)
	end
end

function SettlementBossReward:_updatePrizeCell(mainGo, info)
	local rewardType = info.rewardType
	local isDouble = info.isDouble
	local matType, matId, matNum = info.type, info.id, info.num
	local item = goutil.findChild(mainGo, "item")
	local double = goutil.findChild(mainGo, "double")
	local double_txt = goutil.findChildTextComponent(mainGo, "double/txt")

	if rewardType == 0 then
		local proxy = MaterialMgr.setCellByGId(matType, matId, item)

		if proxy then
			proxy.binder:setNum(matNum)
		end
	elseif rewardType == 1 then
		local proxy = MaterialMgr.setCell(MatType.Pet, info.raceId, mainGo)

		if proxy then
			proxy.binder:setLvl(info.level)
		end
	end

	if isDouble then
		GameUtil.SetActive(double, true)

		double_txt.text = checknumber(info.doubleNum) <= 0 and "+100%" or string.format("+%s%%", info.doubleNum)
	else
		GameUtil.SetActive(double, false)
	end
end

function SettlementBossReward:_clearPrizeCell(mainGo)
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

return SettlementBossReward
