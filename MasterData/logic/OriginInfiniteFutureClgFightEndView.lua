-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origininfinitefutureclg/view/OriginInfiniteFutureClgFightEndView.lua

module("logic.extensions.origininfinitefutureclg.view.OriginInfiniteFutureClgFightEndView", package.seeall)

local OriginInfiniteFutureClgFightEndView = class("OriginInfiniteFutureClgFightEndView", ViewComponent)

function OriginInfiniteFutureClgFightEndView:ctor()
	OriginInfiniteFutureClgFightEndView.super.ctor(self)
end

function OriginInfiniteFutureClgFightEndView:unbindEvents()
	OriginInfiniteFutureClgFightEndView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriginInfiniteFutureClgFightEndView:bindEvents()
	OriginInfiniteFutureClgFightEndView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function OriginInfiniteFutureClgFightEndView:buildUI()
	OriginInfiniteFutureClgFightEndView.super.buildUI(self)

	self._btnSure = self:getGo("bg/btnSure")
	self._txtTitle = self:getTxt("bg/title/txtTitle")
	self._txtKillEnemy = self:getTxt("targets/killEnemy/txtNum")
	self._imgKillEnemyTarget = self:getGo("targets/killEnemy/imgTarget"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtResonateRate = self:getTxt("targets/resonateRate/txtNum")
	self._imgResonateRateTarget = self:getGo("targets/resonateRate/imgTarget"):GetComponent(ComponentType.UIImageSpriteChange)
	self._emptyPet = self:getGo("emptyPet")
	self._tableviewPets = self:getGo("pets/tableview")
	self._tablecellPets = self:getGo("pets/tableview/tablecell")
	self._scrollListPet = ScrollerList.create(self._tableviewPets, self._tablecellPets, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._txtSuperKillNum = self:getTxt("detail/content/txtSuperKillNum")
	self._txtReviveNum = self:getTxt("detail/content/txtReviveNum")
	self._txtCriticalNum = self:getTxt("detail/content/txtCriticalNun")
	self._txtSuperKillRate = self:getTxt("detail/content/txtSuperKillRate")
	self._txtReviveRate = self:getTxt("detail/content/txtReviveRate")
	self._txtCriticalRate = self:getTxt("detail/content/txtCriticalRate")
end

function OriginInfiniteFutureClgFightEndView:onExit()
	OriginInfiniteFutureClgFightEndView.super.onExit(self)
	self._scrollListPet:dispose()
end

function OriginInfiniteFutureClgFightEndView:onEnter()
	OriginInfiniteFutureClgFightEndView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	if not params[1] then
		local msg = {}

		self._fightEndInfo = GameUtil.pbToTable(msg) or msg
		self._activityId = checknumber(self._fightEndInfo.activityId)

		if self._activityId <= 0 then
			self._activityId = 619001
		end

		self._stageId = checknumber(self._fightEndInfo.stageId)

		if self._stageId <= 0 then
			self._stageId = 1
		end

		self._stageCfg = OriginInfiniteFutureClgConfig.instance:getStageCfgById(self._activityId, self._stageId) or {}

		self:_onSetUI()
	end
end

function OriginInfiniteFutureClgFightEndView:_onSetUI()
	local isWin = self._fightEndInfo.isWin == true
	local isPass = self._fightEndInfo.isPass == true
	local resultPass = isWin and isPass
	local targetValue = checknumber(self._stageCfg.passValuePercent)
	local valueMap = self:_buildValueMap(self._fightEndInfo.valueList)
	local totalValue = OriginInfiniteFutureClgController.instance:getStageTotalValueWanPercent(self._activityId, self._stageId)
	local targetPercent = self:_getPercentText(targetValue)
	local totalPercent = self:_getPercentText(totalValue)
	local targetText = langPara("共振率：%s%%/%s%%", totalPercent, targetPercent)

	self._txtTitle.text = resultPass and lang("挑战成功") or lang("挑战失败")
	self._txtKillEnemy.text = lang("破阵成功")
	self._txtResonateRate.text = targetText

	self._imgKillEnemyTarget:SetState(isWin and 1 or 0)
	self._imgResonateRateTarget:SetState(isPass and 1 or 0)
	GameUtil.SetActive(self._tableviewPets, resultPass)
	GameUtil.SetActive(self._emptyPet, not resultPass)
	self._scrollListPet:setCenterMode(true)
	self._scrollListPet:reloadData(resultPass and checktable(self._fightEndInfo.raceIds) or {})
	self:_updateDetail(valueMap)
end

function OriginInfiniteFutureClgFightEndView:_updateDetail(valueMap)
	self:_setValueTexts(1, self._txtSuperKillNum, self._txtSuperKillRate, valueMap)
	self:_setValueTexts(3, self._txtReviveNum, self._txtReviveRate, valueMap)
	self:_setValueTexts(2, self._txtCriticalNum, self._txtCriticalRate, valueMap)
end

function OriginInfiniteFutureClgFightEndView:_setValueTexts(valueType, txtNum, txtRate, valueMap)
	local count = checknumber(valueMap[valueType])
	local valueCfg = OriginInfiniteFutureClgConfig.instance:getValueCfgByType(self._activityId, valueType) or {}
	local valueWanPercent = count * checknumber(valueCfg.valueWanPercent)

	txtNum.text = count
	txtRate.text = langPara("%s%%", self:_getPercentText(valueWanPercent))
end

function OriginInfiniteFutureClgFightEndView:_updatePetCell(view, cell, data)
	local pet = goutil.findChild(cell, "pet")
	local petId = BagModel.instance:getMaxZdlPetIdByRaceId(data)
	local bagPetMo = BagPetsController.instance:getPet(petId)

	if bagPetMo then
		local proxy = MaterialMgr.setCellByMo(bagPetMo, pet)

		proxy.binder:setAutoTips(false)
		proxy:setCallBack(function()
			CommonTipsMgr.instance:showPetTips(bagPetMo)
		end)
	else
		MaterialMgr.setCell(MatType.Pet, data, pet)
	end
end

function OriginInfiniteFutureClgFightEndView:_clearPetCell(cell)
	local pet = goutil.findChild(cell, "pet")

	MaterialMgr.resetAll(pet)
end

function OriginInfiniteFutureClgFightEndView:_onClickBtnSure()
	BattleController.instance:endBattle()
	self:close()
end

function OriginInfiniteFutureClgFightEndView:_buildValueMap(valueList)
	local valueMap = {}

	for _, valueInfo in ipairs(checktable(valueList)) do
		valueMap[valueInfo.left] = valueInfo.right
	end

	return valueMap
end

function OriginInfiniteFutureClgFightEndView:_getPercentText(valueWanPercent)
	local percent = checknumber(valueWanPercent) / 100

	if percent == math.floor(percent) then
		return percent
	end

	return string.format("%.2f", percent)
end

return OriginInfiniteFutureClgFightEndView
