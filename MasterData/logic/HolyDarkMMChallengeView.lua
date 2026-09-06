-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydarkmm/view/HolyDarkMMChallengeView.lua

module("logic.extensions.holydarkmm.view.HolyDarkMMChallengeView", package.seeall)

local HolyDarkMMChallengeView = class("HolyDarkMMChallengeView", ViewComponent)
local _curSelectLevel = 1
local _curSelectFormation = 0
local _curRotateAngle = 0

function HolyDarkMMChallengeView:ctor()
	HolyDarkMMChallengeView.super.ctor(self)
end

function HolyDarkMMChallengeView:unbindEvents()
	HolyDarkMMChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnRotate)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._lockMask)
end

function HolyDarkMMChallengeView:bindEvents()
	HolyDarkMMChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickFormationCancel, self)
	GameUtil.addClickHandler(self._btnRotate, self._onClickFormationRotate, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickFormationSure, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._lockMask, self._onClickLockMask, self)

	for i = 1, self._levelMaxNum do
		GameUtil.addClickHandler(self._btnLevels[i].go, GameUtil.handler(self._onClickLevel, self, i))
	end
end

function HolyDarkMMChallengeView:buildUI()
	HolyDarkMMChallengeView.super.buildUI(self)

	self._petOccupied = self:getGo("petOccupied/petCon")
	self._petCell = self:getGo("petOccupied/petcell")
	self._formationRotate = self:getGo("formationRotate")
	self._tableviewGo = self:getGo("formationChoose/tableview")
	self._tableCell = self:getGo("formationChoose/formationCell")
	self._passReward = self:getGo("tip/passReward/item")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnCancel = self:getBtn("formationRotate/btnCancel")
	self._btnRotate = self:getBtn("formationRotate/btnRotate")
	self._btnSure = self:getBtn("formationRotate/btnSure")
	self._btnReset = self:getBtn("btnReset")
	self._txtPassCondition = self:getTxt("tip/txt")
	self._txtCount = self:getTxt("formationChoose/txtCount")
	self._lockMask = self:getGo("lockMask")
	self._txtLockMask = self:getTxt("lockMask/txt")
	self._strTxtLockMask = self._txtLockMask.text
	self._tableview = ScrollerList.create(self._tableviewGo, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnLevels = {}
	self._levelMaxNum = 5

	for i = 1, self._levelMaxNum do
		local btn = {}

		btn.go = self:getGo("level/btnLevel_" .. i)
		btn.select = goutil.findChild(btn.go, "select")
		btn.pass = goutil.findChild(btn.go, "pass")

		table.insert(self._btnLevels, btn)
	end

	self._formationPosSelect = {}

	for i = 1, 9 do
		local pos = goutil.findChild(self._formationRotate, "select/select_" .. i)

		table.insert(self._formationPosSelect, pos)
	end
end

function HolyDarkMMChallengeView:onExit()
	HolyDarkMMChallengeView.super.onExit(self)
	MaterialMgr.resetAll(self._passReward)
	self._tableview:dispose()

	self._formationPos = {}

	for _, clone in ipairs(self._petCloneCell) do
		uGuiUtil.clearImage(clone.icon)
		goutil.destroy(clone.go, true)
	end

	self._petCloneCell = nil
end

function HolyDarkMMChallengeView:onEnter()
	HolyDarkMMChallengeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	self.addGEvent(self, GlobalNotify.HolyDarkMMChallengeInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.HolyDarkMMChallengeResetRes, self._sendInfoReq, self)

	self._actCfg = HolyDarkMMConfig.instance:getHolyDarkMMActCfg(self._activityId)

	self:_sendInfoReq()

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.money)

	GameUtil.SetActive(self._formationRotate, _curRotateAngle > 0)

	self._petSizeX = 156
	self._petSizeY = 156
	self._formationPos = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	self._petCloneCell = {}
end

function HolyDarkMMChallengeView:_sendInfoReq()
	HolyDarkMMController.instance:sendPM_HolyDarkMMChallengeInfoReq(self._activityId)
end

function HolyDarkMMChallengeView:_refresh()
	self._curLevelInfo = HolyDarkMMModel.instance:getChallengeLevelInfo(_curSelectLevel)
	self._curLevelCfg = HolyDarkMMConfig.instance:getHolyDarkMMStageCfg(self._activityId, self._curLevelInfo.stageId)
	self._monstersInfo = HolyDarkMMModel.instance:getMonsterInfo()
	self._usedFormPlanId = HolyDarkMMModel.instance:getUsedFormPlanId(self._curLevelInfo.stageId)

	local formCfg = HolyDarkMMConfig.instance:getHolyDarkMMFormCfg(self._curLevelCfg.formPlanIds)

	for i = 1, self._levelMaxNum do
		GameUtil.SetActive(self._btnLevels[i].select, i == _curSelectLevel)

		local cfg = HolyDarkMMModel.instance:getChallengeLevelInfo(i)

		GameUtil.SetActive(self._btnLevels[i].pass, cfg.isFinished)
	end

	self._tableview:reloadData(formCfg)
	self:_formationSetPos()
	self:_petOccupiedGrid()

	self._txtCount.text = string.format("挑战次数：%d/%d", self._curLevelCfg.times - self._curLevelInfo.times, self._curLevelCfg.times)

	local passNum = HolyDarkMMController.instance:isPassGridNum(self._activityId, self._curLevelInfo.stageId)

	self._txtPassCondition.text = string.format("胜利条件：占领%d/%d个格子", passNum, self._curLevelCfg.passNum)

	MaterialMgr.setCellByCfg(self._curLevelCfg.prize, self._passReward)

	local isUnlock = self:_isUnlockByDay(_curSelectLevel)

	GameUtil.SetActive(self._lockMask, not isUnlock)

	local leftDay = self:_getLeftDayToOpen(_curSelectLevel)

	self._txtLockMask.text = string.format(self._strTxtLockMask, leftDay)
end

function HolyDarkMMChallengeView:resetSaveData()
	_curSelectLevel = 1
	_curSelectFormation = 0
	_curRotateAngle = 0
end

function HolyDarkMMChallengeView:_updateCell(view, cell, data)
	local select = goutil.findChild(cell, "select")
	local used = goutil.findChild(cell, "used")
	local formDotsGo = {}

	for i = 1, 9 do
		local formDot = goutil.findChild(cell, "formation/cell_" .. i)

		table.insert(formDotsGo, formDot)
		GameUtil.SetActive(formDot, false)
	end

	for _, posId in ipairs(data.posIds) do
		GameUtil.SetActive(formDotsGo[posId], true)
	end

	local isUsed = TableUtil.isHad(self._usedFormPlanId, data.formPlanId)

	GameUtil.SetActive(used, isUsed)
	GameUtil.SetActive(select, data.formPlanId == _curSelectFormation)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickFormation, self, data))
end

function HolyDarkMMChallengeView:_clearCell(cell)
	GameUtil.rmClickHandler(cell)
end

function HolyDarkMMChallengeView:_petOccupiedGrid()
	local creepsCfg = HolyDarkMMConfig.instance:getHolyDarkMMCreepGroupCfg(self._curLevelCfg.creepsMasterId)

	for i, cfg in pairs(creepsCfg) do
		if not self._petCloneCell[i] then
			local clone = self:_cloneNewPetCell(i)

			GameUtil.SetActive(clone.go, true)

			local gridX, gridY = HolyDarkMMController.instance:petOccupiedGridNum(cfg.posIds)
			local x = Mathf.Ceil(cfg.posIds[1] / 3)
			local y = cfg.posIds[1] % 3

			if y <= 0 then
				y = 3
			end

			local posX = (x - 1) * self._petSizeX
			local posY = (y - 1) * -self._petSizeY

			GameUtil.setWidth(clone.go, gridX * self._petSizeX)
			GameUtil.setHeight(clone.go, gridY * self._petSizeY)
			GameUtil.setAnchoredPos(clone.go, posX, posY)

			local hpPercent = HolyDarkMMController.instance:calculPetHpRate(self._curLevelInfo.stageId, cfg)

			local function func()
				if gridX == 1 and gridY == 1 then
					GameUtil.setWidth(clone.icon, 154)
					GameUtil.setHeight(clone.icon, 154)
				else
					clone.icon:GetComponent(goutil.Type_UIImage):SetNativeSize()
				end

				GameUtil.setAnchoredPos(clone.icon, cfg.iconOffset[1], cfg.iconOffset[2])
			end

			uGuiUtil.setSpriteToImage(clone.icon, uGuiUtil.SpriteType.BigBg, string.format("ui/%s.png", cfg.res), func)

			clone.txtBood.text = string.format("血量：%d%%", hpPercent)

			clone.changeColor:SetState(hpPercent > 50 and 0 or 1)
			GameUtil.SetActive(clone.defend, hpPercent == 0)
		end
	end

	local creepsCfgCount = #creepsCfg
	local cloneCount = #self._petCloneCell

	if creepsCfgCount < cloneCount then
		for i = creepsCfgCount + 1, cloneCount do
			GameUtil.SetActive(self._petCloneCell[i].go, false)
		end
	end
end

function HolyDarkMMChallengeView:_cloneNewPetCell(i)
	local clone = {}

	clone.go = goutil.cloneAndSetParent(self._petCell, self._petOccupied.transform, "creep_" .. i)
	clone.icon = goutil.findChild(clone.go, "mask/icon")
	clone.txtBood = goutil.findChildTextComponent(clone.go, "blood/txt")
	clone.changeColor = goutil.findChild(clone.go, "blood/txt"):GetComponent(ComponentType.UITextColorChange)
	clone.defend = goutil.findChild(clone.go, "defend")
	self._petCloneCell[i] = clone

	return clone
end

function HolyDarkMMChallengeView:_onClickTip()
	TipsFacade.instance:openRulesView("holydarkmmchallenge_rule")
end

function HolyDarkMMChallengeView:_onClickLevel(id)
	local cfg = HolyDarkMMModel.instance:getChallengeLevelInfo(i)

	_curSelectFormation = 0
	_curRotateAngle = 1

	GameUtil.SetActive(self._btnLevels[_curSelectLevel].select, false)
	GameUtil.SetActive(self._formationRotate, false)

	_curSelectLevel = id

	GameUtil.SetActive(self._btnLevels[_curSelectLevel].select, true)
	self:_petOccupiedGrid()
	self:_refresh()
end

function HolyDarkMMChallengeView:_onClickFormation(data)
	if not self:_isUnlockByDay(_curSelectLevel) then
		FloatWordMgr.instance:show("未开启,无法挑战哦~")

		return
	end

	if self._curLevelCfg.times - self._curLevelInfo.times <= 0 then
		FloatWordMgr.instance:show("挑战次数已用完,可尝试重置关卡重新挑战")

		return
	end

	local isUsed = TableUtil.isHad(self._usedFormPlanId, data.formPlanId)

	if isUsed then
		FloatWordMgr.instance:show("此阵型已使用,请选择其他阵型进行挑战")

		return
	end

	_curRotateAngle = 1
	_curSelectFormation = data.formPlanId

	self._tableview:refresh()
	GameUtil.SetActive(self._formationRotate, true)
	self:_formationSetPos()
end

function HolyDarkMMChallengeView:_formationSetPos()
	if _curSelectFormation <= 0 then
		return
	end

	local formGroupCfg = HolyDarkMMConfig.instance:getHolyDarkFormCfg(_curSelectFormation)
	local posIds = formGroupCfg[_curRotateAngle].posIds

	self._formationPos = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}

	for i, pos in ipairs(posIds) do
		self._formationPos[pos] = 1
	end

	for i, pos in ipairs(self._formationPosSelect) do
		GameUtil.SetActive(pos, self._formationPos[i] == 1)
	end
end

function HolyDarkMMChallengeView:_onClickFormationCancel()
	GameUtil.SetActive(self._formationRotate, false)

	_curRotateAngle = 1
	_curSelectFormation = 0

	self._tableview:refresh()
end

function HolyDarkMMChallengeView:_onClickFormationRotate()
	if not self:_isUnlockByDay(_curSelectLevel) then
		FloatWordMgr.instance:show("未开启,无法挑战哦~")

		return
	end

	if self._curLevelCfg.times - self._curLevelInfo.times <= 0 then
		FloatWordMgr.instance:show("挑战次数已用完,可尝试重置关卡重新挑战")
		GameUtil.SetActive(self._formationRotate, false)

		return
	end

	local isUsed = TableUtil.isHad(self._usedFormPlanId, _curSelectFormation)

	if isUsed then
		FloatWordMgr.instance:show("此阵型已使用，请选择其他阵型进行挑战")

		return
	end

	_curRotateAngle = _curRotateAngle + 1

	if _curRotateAngle > 4 then
		_curRotateAngle = 1
	end

	self:_formationSetPos()
end

function HolyDarkMMChallengeView:_onClickFormationSure()
	if not self:_isUnlockByDay(_curSelectLevel) then
		FloatWordMgr.instance:show("未开启,无法挑战哦~")

		return
	end

	if self._curLevelCfg.times - self._curLevelInfo.times <= 0 then
		FloatWordMgr.instance:show("挑战次数已用完,可尝试重置关卡重新挑战")
		GameUtil.SetActive(self._formationRotate, false)

		return
	end

	local isUsed = TableUtil.isHad(self._usedFormPlanId, _curSelectFormation)

	if isUsed then
		FloatWordMgr.instance:show("此阵型已使用，请选择其他阵型进行挑战")

		return
	end

	HolyDarkMMController.instance:openHolyDarkMMChallengeForm(self._activityId, self._curLevelInfo.stageId, _curSelectFormation, _curRotateAngle, self._formationPos, _curSelectLevel)
end

function HolyDarkMMChallengeView:_onClickClose()
	self:resetSaveData()
	self:close()
end

function HolyDarkMMChallengeView:_onClickReset()
	if self._curLevelInfo.isFinished then
		FloatWordMgr.instance:show("已通关,无法重置哦~")

		return
	end

	if not self:_isUnlockByDay(_curSelectLevel) then
		FloatWordMgr.instance:show("未开启,无法重置哦~")

		return
	end

	local tips = lang("holydarkmm_reset_tip")

	local function sureChange()
		HolyDarkMMController.instance:sendPM_HolyDarkMMChallengeResetReq(self._activityId, self._curLevelInfo.stageId)
	end

	TipsFacade.instance:openTipWindow(lang("text_tong_tips"), tips, sureChange, "确定", UnityEngine.TextAnchor.MiddleCenter)
end

function HolyDarkMMChallengeView:_onClickLockMask()
	return
end

function HolyDarkMMChallengeView:_isUnlockByDay(stageId)
	local left = self:_getLeftDayToOpen(stageId)

	return left <= 0
end

function HolyDarkMMChallengeView:_getOpenDayToOpen(stageId)
	local activityType = GameEnum.ActivityType.HolyDarkMM
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, self._activityId)

	return GameUtil.getDaysByTimestamp(startTime, ServerTime.now()) - 1
end

function HolyDarkMMChallengeView:_getLeftDayToOpen(stageId)
	local day = self:_getOpenDayToOpen(stageId)
	local data = HolyDarkMMConfig.instance:getHolyDarkMMStageCfg(self._activityId, stageId)

	if data then
		if not data.afterUnlock then
			local need = 0

			return Mathf.Max(need - day, 0)
		end
	end
end

return HolyDarkMMChallengeView
