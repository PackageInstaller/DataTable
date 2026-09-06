-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/view/DivineTunTianExtFightendView.lua

module("logic.extensions.divinetuntian.view.DivineTunTianExtFightendView", package.seeall)

local DivineTunTianExtFightendView = class("DivineTunTianExtFightendView", ViewComponent)
local COLOR_GREEN = "03E605FF"
local COLOR_RED = "CE0303FF"

function DivineTunTianExtFightendView:ctor()
	DivineTunTianExtFightendView.super.ctor(self)
end

function DivineTunTianExtFightendView:unbindEvents()
	DivineTunTianExtFightendView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnGet)
end

function DivineTunTianExtFightendView:bindEvents()
	DivineTunTianExtFightendView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onBtnSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onBtnCancel, self)
	GameUtil.addClickHandler(self._btnGet, self._onBtnGet, self)
end

function DivineTunTianExtFightendView:buildUI()
	DivineTunTianExtFightendView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._btnGet = self:getGo("btnGet")
	self._title = self:getTxt("title")
	self._txtOriginPower = self:getTxt("power/txtOriginPower")
	self._txtGetPower = self:getTxt("power/txtGetPower")
	self._txtTotalPower = self:getTxt("power/txtTotalPower")
	self._txtPower = self:getTxt("txtPower")
	self._imgPetPassChangeComp = self:getGo("imgPetPass"):GetComponent(ComponentType.UIImageSpriteChange)
	self._imgPowerPassChangeComp = self:getGo("imgPowerPass"):GetComponent(ComponentType.UIImageSpriteChange)
	self._stageList = {}

	for i = 1, 7 do
		local stage = self:getGo("stages/stage" .. i)

		table.insert(self._stageList, stage)
	end

	self._tableview = self:getGo("pet/tableview")
	self._tablecell = self:getGo("pet/tableview/tablecell")
	self._scrollListPet = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineTunTianExtFightendView:onExit()
	DivineTunTianExtFightendView.super.onExit(self)
	self._scrollListPet:dispose()
end

function DivineTunTianExtFightendView:onEnter()
	DivineTunTianExtFightendView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineTunTianClgExtremeConfirmRes, self._onConfirmRes, self)

	local params = self:getOpenParam() or {}

	self._fightEndInfo = params[1]
	self._activityId = self._fightEndInfo.activityId

	if self._activityId <= 0 then
		self._activityId = 508001
	end

	self._info = DivineTunTianModel.instance:getInfo(self._activityId)
	self._extremeStageInfoMap = self._info.extremeStageInfoMap
	self._stageId = self._fightEndInfo.stageId
	self._stageCfgs = DivineTunTianConfig.instance:getExtStageCfgs(self._activityId)
	self._stageCfg = DivineTunTianConfig.instance:getExtStageCfgByStageId(self._activityId, self._stageId)

	self:_onSetUI()
end

function DivineTunTianExtFightendView:_onSetUI()
	local color = COLOR_RED
	local isPassIdx = 0

	if self._fightEndInfo.stageScore + self._fightEndInfo.transmitScore >= self._stageCfg.passPowerCondition then
		color = COLOR_GREEN
		isPassIdx = 1
	end

	local isWinIdx = 0

	if self._fightEndInfo.win then
		isWinIdx = 1
	end

	self._txtOriginPower.text = checknumber(self._fightEndInfo.stageScore)
	self._txtGetPower.text = checknumber(self._fightEndInfo.transmitScore)
	self._txtTotalPower.text = checknumber(self._fightEndInfo.stageScore) + checknumber(self._fightEndInfo.transmitScore)
	self._txtPower.text = string.format("能量达到%d(<color=#%s>%d</color>/%d)", self._stageCfg.passPowerCondition, color, checknumber(self._fightEndInfo.stageScore) + checknumber(self._fightEndInfo.transmitScore), self._stageCfg.passPowerCondition)
	self._title.text = self._fightEndInfo.pass and "挑战成功" or "挑战失败"

	self._imgPowerPassChangeComp:SetState(isPassIdx)
	self._imgPetPassChangeComp:SetState(isWinIdx)

	if not self._fightEndInfo.petScores then
		table.sort(self._fightEndInfo.petScores, function(a, b)
			return a.right > b.right
		end)
		self._scrollListPet:reloadData(self._fightEndInfo.petScores)
		self:_updateStageUI()
		GameUtil.SetActive(self._btnGet, not self._fightEndInfo.pass)
		GameUtil.SetActive(self._btnSure, self._fightEndInfo.pass)
		GameUtil.SetActive(self._btnCancel, self._fightEndInfo.pass)
	end
end

function DivineTunTianExtFightendView:_updateStageUI()
	for i, stageGo in ipairs(self._stageList) do
		local imgChoose = goutil.findChild(stageGo, "imgChoose")
		local curStage = goutil.findChild(stageGo, "curStage")
		local txtPower = goutil.findChildTextComponent(stageGo, "txtPower")

		if i ~= self._stageId then
			local stageInfo = self._extremeStageInfoMap[i]
			local curScore = 0

			if stageInfo then
				curScore = stageInfo.score
			end

			local curStageCfg = self._stageCfgs[i]
			local curStageId = curStageCfg.stageId

			if self._fightEndInfo.pass then
				local passPower = DivineTunTianModel.instance:getPassPowerAfterAddScore(self._activityId, curStageId, self._fightEndInfo.stageScore, self._stageId)

				txtPower.text = string.format("%d+<color=#FFBF65>%d</color>/%d", curScore, passPower, curStageCfg.passPowerCondition)
			else
				local passPower = DivineTunTianModel.instance:getPassPower(self._activityId, curStageId)

				txtPower.text = string.format("%d/%d", curScore + passPower, curStageCfg.passPowerCondition)
			end
		else
			local curPower = checknumber(self._fightEndInfo.stageScore) + checknumber(self._fightEndInfo.transmitScore)
			local passPower = DivineTunTianModel.instance:getPassPower(self._activityId, self._stageId)

			txtPower.text = self._fightEndInfo.pass and string.format("%d+<color=#FFBF65>%d</color>/%d", passPower, checknumber(self._fightEndInfo.stageScore), self._stageCfg.passPowerCondition) or string.format("%d/%d", 0, self._stageCfg.passPowerCondition)
		end

		GameUtil.SetActive(imgChoose, self._stageId == i)
		GameUtil.SetActive(curStage, self._stageId == i)
	end
end

function DivineTunTianExtFightendView:_updateCell(view, cell, data)
	local pet = goutil.findChild(cell, "pet")
	local btnPet = goutil.findChild(cell, "btnPet")
	local img = goutil.findChild(cell, "img")
	local txt = goutil.findChild(cell, "txt")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local petId = data.left

	if petId then
		local petMo = BagPetsController.instance:getPet(petId)
		local raceId = petMo.raceId

		GameUtil.addClickHandler(btnPet, function()
			local curBagPetMo = BagPetsController.instance:getPet(petId)

			CommonTipsMgr.instance:showPetTips(curBagPetMo)
		end, self)
		MaterialMgr.setCell(MatType.Pet, raceId, pet)

		local hasBeenLock = table.indexof(self._fightEndInfo.lockRaceIds, raceId)

		GameUtil.SetActive(img, hasBeenLock)
		GameUtil.SetActive(txt.gameObject, hasBeenLock)

		txtNum.text = string.format("变身:%d", data.right)
	end
end

function DivineTunTianExtFightendView:_clearCell(cell)
	local pet = goutil.findChild(cell, "pet")
	local btnPet = goutil.findChild(cell, "btnPet")

	MaterialMgr.resetAll(pet)
	GameUtil.rmClickHandler(btnPet)
end

function DivineTunTianExtFightendView:_onBtnSure()
	DivineTunTianController.instance:sendPM_DivineTunTianClgExtremeConfirmReq(self._activityId, self._stageId, true)
end

function DivineTunTianExtFightendView:_onBtnCancel()
	DivineTunTianController.instance:sendPM_DivineTunTianClgExtremeConfirmReq(self._activityId, self._stageId, false)
end

function DivineTunTianExtFightendView:_onBtnGet()
	BattleController.instance:endBattle()
	self:close()
end

function DivineTunTianExtFightendView:_onConfirmRes()
	BattleController.instance:endBattle()
	self:close()
end

return DivineTunTianExtFightendView
