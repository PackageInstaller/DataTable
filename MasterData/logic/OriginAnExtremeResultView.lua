-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/view/OriginAnExtremeResultView.lua

module("logic.extensions.originan.view.OriginAnExtremeResultView", package.seeall)

local OriginAnExtremeResultView = class("OriginAnExtremeResultView", ViewComponent)

function OriginAnExtremeResultView:buildUI()
	OriginAnExtremeResultView.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")
	self._txtScore = self:getTxt("score/txt")
	self._tagReachScore = self:getTxt("score/tagReach")
	self._petScrCell = self:getGo("petCol/scrCell")
	self._petScrView = self:getGo("petCol/scrView")
	self._petScrollerList = ScrollerList.create(self._petScrView, self._petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._tagEmptyPet = self:getGo("petCol/tagEmpty")
	self._btnSure = self:getGo("btnSure")
	self._fmtView = self:getGo("fmt/fmtView")
	self._fmtCell = self:getGo("fmt/fmtCell")
	self._tagEmptyFmt = self:getGo("fmt/tagEmpty")
	self._tagReachDetail = self:getGo("detail/tagReach")
	self._tagReachScore = self:getGo("score/tagReach")

	GameUtil.SetActive(self._fmtCell, false)
end

function OriginAnExtremeResultView:bindEvents()
	OriginAnExtremeResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function OriginAnExtremeResultView:unbindEvents()
	OriginAnExtremeResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriginAnExtremeResultView:onEnter()
	OriginAnExtremeResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local msg = params[1]

	self._activityId = msg.activityId
	self._stageId = msg.stageId
	self._subMo = OriginAnController.instance:getSubMo(self._activityId)
	self._totalHealTimes = 0
	self._healTimes = {}
	self._maxHealTimes = 0

	for _, info in ipairs(msg.posToBlockHealTimes) do
		local posId = info.left + 1
		local times = info.right

		self._healTimes[posId] = times
		self._totalHealTimes = self._totalHealTimes + times
		self._maxHealTimes = Mathf.Max(self._maxHealTimes, times)
	end

	self._isBreakFmt = msg.isWin

	local needBlockHealTimes = self._subMo:getExtremeStagePassNeedBlockHealTimes(self._stageId)

	self._isEnoughHeal = needBlockHealTimes <= self._totalHealTimes
	self._banRaceIdList = msg.banRaceId
	self._isSuccess = self._isEnoughHeal and self._isBreakFmt

	self:_onUpdate()
end

function OriginAnExtremeResultView:onExit()
	OriginAnExtremeResultView.super.onExit(self)
	self._petScrollerList:dispose()
end

function OriginAnExtremeResultView:_onUpdate()
	self._txtTitle.text = self._isSuccess and "挑战成功" or "挑战失败"

	GameUtil.setUIImageSpriteIdx(self._tagReachDetail, self._isBreakFmt and 0 or 1)

	local needBlockHealTimes = self._subMo:getExtremeStagePassNeedBlockHealTimes(self._stageId)

	self._txtScore.text = self._isEnoughHeal and string.format("禁疗次数：(<color=#20b376>%s</color>/%s)", self._totalHealTimes, needBlockHealTimes) or string.format("禁疗次数：(<color=#eb4624>%s</color>/%s)", self._totalHealTimes, needBlockHealTimes)

	GameUtil.setUIImageSpriteIdx(self._tagReachScore, self._isEnoughHeal and 0 or 1)

	if self._isSuccess then
		self._petScrollerList:reloadData(self._banRaceIdList)
		GameUtil.SetActive(self._tagEmptyPet, #self._banRaceIdList <= 0)
	else
		self._petScrollerList:reloadData({})
		GameUtil.SetActive(self._tagEmptyPet, true)
	end

	local isHaveTimes = false
	local childCount = self._fmtView.transform.childCount

	for posId = 1, 9 do
		local mainGo = posId <= childCount and self._fmtView.transform:GetChild(posId - 1) or goutil.cloneAndSetParent(self._fmtCell.gameObject, self._fmtView.transform, "fmtCell" .. posId)

		GameUtil.SetActive(mainGo, true)

		local count = goutil.findChild(mainGo, "count"):GetComponent(ComponentType.UIImgNumeralText)
		local tagOccupy = goutil.findChild(mainGo, "tagOccupy")

		if not self._healTimes[posId] then
			local times = 0
			local isOccupy = self._maxHealTimes > 0 and self._maxHealTimes == times

			GameUtil.SetActive(tagOccupy, isOccupy)
			GameUtil.SetActive(count.gameObject, times > 0)
			count:SetNum(times)

			isHaveTimes = isHaveTimes or times > 0
		end
	end

	GameUtil.SetActive(self._tagEmptyFmt, not isHaveTimes)
end

function OriginAnExtremeResultView:_updatePetCell(view, cell, raceId, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, item)

	if proxy then
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, 0)

		proxy.binder:setClickCallBack(function()
			CommonTipsMgr.instance:showPetTips(tmpMo, true)
		end)
	end
end

function OriginAnExtremeResultView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function OriginAnExtremeResultView:_onClickBtnSure()
	self:close()
	BattleController.instance:endBattle()
end

return OriginAnExtremeResultView
