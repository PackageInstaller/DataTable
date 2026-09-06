-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintsdragonclg/view/OriginTSDragonClgFightEndView.lua

module("logic.extensions.origintsdragonclg.view.OriginTSDragonClgFightEndView", package.seeall)

local OriginTSDragonClgFightEndView = class("OriginTSDragonClgFightEndView", ViewComponent)

function OriginTSDragonClgFightEndView:ctor()
	OriginTSDragonClgFightEndView.super.ctor(self)
end

function OriginTSDragonClgFightEndView:unbindEvents()
	OriginTSDragonClgFightEndView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnReChallenge)
end

function OriginTSDragonClgFightEndView:bindEvents()
	OriginTSDragonClgFightEndView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnReChallenge, self._onClickBtnReChallenge, self)
end

function OriginTSDragonClgFightEndView:buildUI()
	OriginTSDragonClgFightEndView.super.buildUI(self)

	self._btnSure = self:getGo("content/bg/btnSure")
	self._btnReChallenge = self:getGo("content/bg/btnReChallenge")
	self._txtTitle = self:getTxt("content/bg/title/txtTitle")
	self._targetCell = self:getGo("targetCell")
	self._targets = self:getGo("content/targets")
	self._empty = self:getGo("content/pets/empty")
	self._tableview = self:getGo("content/pets/tableview")
	self._tablecell = self:getGo("content/pets/tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginTSDragonClgFightEndView:onExit()
	OriginTSDragonClgFightEndView.super.onExit(self)
	self._scrollList:dispose()
end

function OriginTSDragonClgFightEndView:onEnter()
	OriginTSDragonClgFightEndView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginTSDragonConfirmRes, self._onConfirmRes, self)

	local params = self:getOpenParam() or {}

	if not params[1] then
		local fightEndInfo = {}

		self._activityId = checknumber(fightEndInfo.activityId)

		if self._activityId <= 0 then
			self._activityId = 591001
		end

		self._phaseId = checknumber(fightEndInfo.phaseId)

		if self._phaseId <= 0 then
			self._phaseId = 1
		end

		self._stageId = checknumber(fightEndInfo.stageId)

		if self._stageId <= 0 then
			self._stageId = 1
		end

		self._isWin = fightEndInfo.isWin
		self._usePuzzleId = fightEndInfo.puzzleId
		self._pets = checktable(fightEndInfo.pets)

		self._scrollList:reloadData(self._pets)
		self:_onSetUI()
	end
end

function OriginTSDragonClgFightEndView:_onSetUI()
	local stageCfg = OriginTSDragonClgConfig.instance:getStageCfg(self._activityId, self._phaseId, self._stageId)
	local tb = {}

	if checknumber(stageCfg.targetRound) > 0 then
		local puzzleIds = OriginTSDragonClgController.instance:getActivePuzzleIds(self._activityId, self._phaseId, self._stageId)

		if self._usePuzzleId > 0 then
			table.insert(puzzleIds, {
				phaseId = self._phaseId,
				puzzleId = self._usePuzzleId
			})
		end

		local targetRound = stageCfg.targetRound

		for i, v in ipairs(puzzleIds) do
			local puzzleCfg = OriginTSDragonClgConfig.instance:getPuzzleCfg(self._activityId, v.phaseId, v.puzzleId)

			if checknumber(puzzleCfg.roundChange) ~= 0 then
				targetRound = targetRound + puzzleCfg.roundChange
			end
		end

		tb.desc = langPara("%s回合内破阵即为胜利", targetRound)
	else
		tb.desc = stageCfg.passDesc
	end

	tb.pass = self._isWin

	local list = {}

	table.insert(list, tb)
	GameUtil.updateCellsList(self._targets, self._targetCell, list, self._updateTargetList, self)

	self._txtTitle.text = lang("挑战成功")

	if not self._isWin then
		self._txtTitle.text = lang("挑战失败")
	end

	GameUtil.SetActive(self._targetCell, false)
	GameUtil.SetActive(self._tableview, self._isWin)
	GameUtil.SetActive(self._empty, not self._isWin)
end

function OriginTSDragonClgFightEndView:_updateTargetList(cell, data, index)
	local go = cell
	local imgTargetChangeComp = goutil.findChild(go, "imgTarget"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local changeIdx = data.pass and 1 or 0

	txtNum.text = data.desc

	imgTargetChangeComp:SetState(changeIdx)
	GameUtil.SetActive(go, true)
end

function OriginTSDragonClgFightEndView:_clearTargetCell(cell)
	return
end

function OriginTSDragonClgFightEndView:_onClickBtnSure()
	if self._isWin then
		local save = true

		OriginTSDragonClgController.instance:sendPM_OriginTSDragonConfirmReq(self._activityId, self._phaseId, self._stageId, save)
	else
		BattleController.instance:endBattle()
		self:close()
	end
end

function OriginTSDragonClgFightEndView:_onClickBtnReChallenge()
	if self._isWin then
		local save = false

		OriginTSDragonClgController.instance:sendPM_OriginTSDragonConfirmReq(self._activityId, self._phaseId, self._stageId, save)

		return
	end

	local fmtMo = OriginTSDragonClgModel.instance:getFmtMo(self._activityId)

	fmtMo:updateCfg(self._activityId, self._phaseId, self._stageId)
	UIJumper.instance:pushOneStack(ViewName.CustomMissionView, false, fmtMo)
	BattleController.instance:endBattle()
	self:close()
end

function OriginTSDragonClgFightEndView:_onConfirmRes(msg)
	if not msg.save then
		local fmtMo = OriginTSDragonClgModel.instance:getFmtMo(self._activityId)

		fmtMo:updateCfg(self._activityId, self._phaseId, self._stageId)
		UIJumper.instance:pushOneStack(ViewName.CustomMissionView, false, fmtMo)
	end

	BattleController.instance:endBattle()
	self:close()
end

function OriginTSDragonClgFightEndView:_updateCell(view, cell, data)
	local pet = goutil.findChild(cell, "pet")
	local dead = goutil.findChild(cell, "dead")
	local bloodbar = goutil.findChild(cell, "bloodbar")
	local slider = bloodbar:GetComponent(ComponentType.Slider)
	local txtBlood = goutil.findChildTextComponent(cell, "txtBlood")
	local leftHp = data.leftHp
	local petId = data.petId
	local bagPet = BagPetsController.instance:getPet(petId)

	if bagPet then
		local skinId = checknumber(bagPet.skinId)

		if skinId <= 0 then
			skinId = bagPet.raceId
		end

		local val = checknumber(leftHp) / OriginTSDragonClgController.FULL_HP_VALUE

		slider.value = val
		txtBlood.text = string.format("%s%%", math.ceil(val * 100))

		MaterialMgr.setCell(MatType.Pet, skinId, pet)
		GameUtil.SetActive(dead, leftHp <= 0)
		GameUtil.SetActive(bloodbar, leftHp > 0)
		GameUtil.SetActive(txtBlood, leftHp > 0)
	end
end

function OriginTSDragonClgFightEndView:_clearCell(cell)
	local pet = goutil.findChild(cell, "pet")

	MaterialMgr.resetAll(pet)
end

return OriginTSDragonClgFightEndView
