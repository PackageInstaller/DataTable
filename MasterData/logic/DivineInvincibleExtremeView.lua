-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/view/DivineInvincibleExtremeView.lua

module("logic.extensions.kingofradiantgoldclg.view.DivineInvincibleExtremeView", package.seeall)

local DivineInvincibleExtremeView = class("DivineInvincibleExtremeView", ViewComponent)

function DivineInvincibleExtremeView:ctor()
	DivineInvincibleExtremeView.super.ctor(self)
end

function DivineInvincibleExtremeView:buildUI()
	DivineInvincibleExtremeView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._stageCell = self:getGo("stageCol/stageCell")
	self._stageView = self:getGo("stageCol/stageView")
	self._posView = self:getGo("posCol/posView")
	self._posCell = self:getGo("posCol/posCell")
	self._prizeCol = self:getGo("infoCol/prizeCol")
	self._prizeItem = self:getGo("infoCol/prizeCol/prizeItem")
	self._btnPetLock = self:getGo("infoCol/btnPetLock")
	self._btnReset = self:getGo("infoCol/btnReset")

	local buffScrView = goutil.findChild(self.mainGO, "infoCol/buffScrView")
	local buffScrCell = goutil.findChild(self.mainGO, "infoCol/buffScrCell")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._countUlt = self:getGo("infoCol/countUlt")
	self._txtCountUlt = self:getTxt("infoCol/countUlt/txt")

	GameUtil.SetActive(self._countUlt, false)
	GameUtil.SetActive(self._posCell, false)
	self:_recordGoDefaultActive(self._prizeCol)
end

function DivineInvincibleExtremeView:bindEvents()
	DivineInvincibleExtremeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClikBtnTip, self)
	GameUtil.addClickHandler(self._btnPetLock, self._onClikBtnPetLock, self)
	GameUtil.addClickHandler(self._btnReset, self._onClikBtnReset, self)
end

function DivineInvincibleExtremeView:unbindEvents()
	DivineInvincibleExtremeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPetLock)
	GameUtil.rmClickHandler(self._btnReset)
end

function DivineInvincibleExtremeView:onEnter()
	DivineInvincibleExtremeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = DivineInvincibleController.instance:getActivityType()

	local isInTime = DivineInvincibleController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isUltTrialClg = UltimateTrialController.instance:isUltTrialClg(self._activityId)
	self._clgMo = DivineInvincibleController.instance:getClgMo(self._activityId)
	self._actData = DivineInvincibleConfig.instance:getActData(self._activityId)
	self._finishNum = 0

	if self._isUltTrialClg then
		GameUtil.SetActive(self._prizeCol, false)
	else
		self:_refreshDefaultActive(self._prizeCol)
	end

	self.addGEvent(self, GlobalNotify.HandlePM_DivineInvincibleClgExtremeInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineInvincibleClgExtremeConfirmRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineInvincibleClgExtremeResetRes, self._onUpdate, self)
	DivineInvincibleController.instance:sendPM_DivineInvincibleClgExtremeInfoReq(self._activityId)
end

function DivineInvincibleExtremeView:onExit()
	DivineInvincibleExtremeView.super.onExit(self)
	self:_onClearStageCol()
	self:_onClearPosCol()
	self:_onClearInfoCol()
end

function DivineInvincibleExtremeView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function DivineInvincibleExtremeView:_onUpdateData()
	return
end

function DivineInvincibleExtremeView:_onUpdateUI()
	self:_onUpdateStageCol()
	self:_onUpdatePosCol()
	self:_onUpdateInfoCol()

	while true do
		local changeSetId = self._clgMo:popChangeSetId()

		if changeSetId then
			MaterialController.instance:showChangeSetInTemp(changeSetId)
		else
			break
		end
	end

	GameUtil.SetActive(self._countUlt, self._isUltTrialClg)

	if self._isUltTrialClg then
		local total = 0

		for posId = 1, 9 do
			local times = self._clgMo:getTimesInExtPass(posId)

			total = total + times
		end

		self._txtCountUlt.text = string.format("总群攻：%s", total)
	end
end

function DivineInvincibleExtremeView:_onUpdateStageCol()
	local cfg = DivineInvincibleConfig.instance:getExtStageCfg(self._activityId) or {}

	GameUtil.updateCellsList(self._stageView, self._stageCell, cfg, self._updateStageCell, self)
end

function DivineInvincibleExtremeView:_onClearStageCol()
	GameUtil.clearCells(self._stageView, self._clearStageCell, self)
end

function DivineInvincibleExtremeView:_updateStageCell(mainGo, data, tabIdx)
	local stageId = data.stageId
	local skinId = data.skinId
	local isPass = self._clgMo:isPassStageInExt(stageId)
	local icon = goutil.findChild(mainGo, "icon")
	local passTag = goutil.findChild(mainGo, "passTag")

	MaterialMgr.setIcon(icon, MatType.Pet, skinId, nil, nil)

	if not data.pos then
		local pos = {}
		local x, y = checknumber(pos[1]), checknumber(pos[2])

		GameUtil.setLocalPos(mainGo, x, y)
		GameUtil.SetActive(passTag, isPass)
		GameUtil.addClickHandler(mainGo, function()
			if UltimateTrialController.instance:isBanInUltTrialClg(true, self._activityId) then
				return
			end

			local result = self._clgMo:getTryResultAndTipsStartExtremeStageClg(true, stageId)

			if result ~= GameEnum.ResultCode.Success then
				return
			end

			DivineInvincibleController.instance:enterBattleExtreme(self._activityId, stageId)
		end)
	end
end

function DivineInvincibleExtremeView:_clearStageCell(mainGo)
	local icon = goutil.findChild(mainGo, "icon")

	GameUtil.rmClickHandler(mainGo)
	MaterialMgr.clearIcon(icon)
end

function DivineInvincibleExtremeView:_onUpdatePosCol()
	local childCount = self._posView.transform.childCount

	for posId = 1, 9 do
		local mainGo = posId <= childCount and self._posView.transform:GetChild(posId - 1).gameObject or goutil.cloneAndSetParent(self._posCell, self._posView.transform, self._posCell.name .. posId)

		GameUtil.SetActive(mainGo, true)

		local imgFinish = goutil.findChild(mainGo, "imgFinish")
		local content = goutil.findChild(mainGo, "content")
		local iconAtlas = goutil.findChild(mainGo, "content/tag/iconAtlas")
		local txtName = goutil.findChildTextComponent(mainGo, "content/tag/txtName")
		local txtCond = goutil.findChildTextComponent(mainGo, "content/txtCond")
		local txtPos = goutil.findChildComponent(mainGo, "content/txtPos", ComponentType.UIImgNumeralText)
		local data = DivineInvincibleConfig.instance:getExtPassData(self._activityId, posId)
		local isFinish = self._clgMo:isFinishInExtPass(posId)
		local curTimes = self._clgMo:getTimesInExtPass(posId)
		local needTimes = self._clgMo:getNeedTimesInExtPass(posId)
		local stateKey

		if not string.nilorempty(data.validator) then
			local arr = string.split(data.validator, "$")

			stateKey = arr[2]
		end

		txtPos:SetNum(posId)

		txtCond.text = needTimes <= curTimes and string.format("%s/%s", curTimes, needTimes) or string.format("<color=#FFFFFFFF>%s</color>/%s", curTimes, needTimes)

		GameUtil.SetActive(imgFinish, isFinish)
		GameUtil.SetActive(content, stateKey ~= nil)

		if stateKey then
			local state = (GameEnum.Races[stateKey] or 1) - 1

			GameUtil.setUIImageSpriteIdx(iconAtlas, state)

			txtName.text = stateKey
		end
	end
end

function DivineInvincibleExtremeView:_onClearPosCol()
	return
end

function DivineInvincibleExtremeView:_onUpdateInfoCol()
	MaterialMgr.setCellByCfg(self._actData.extremePrize, self._prizeItem)

	local buffCfg = DivineInvincibleConfig.instance:getExtBuffCfg(self._activityId)

	self._buffScrollerList:reloadData(buffCfg)

	local index = 1

	self._activeBuffId = 0
	self._finishNum = self._clgMo:getFinishNumInExtPass()

	local data = DivineInvincibleConfig.instance:getExtBuffData(self._activityId, self._finishNum)

	if data then
		index = data.id
		self._activeBuffId = data.id
	end

	self._buffScrollerList:MoveCellToCenter(index - 1)
end

function DivineInvincibleExtremeView:_onClearInfoCol()
	MaterialMgr.resetAll(self._prizeItem)
	self._buffScrollerList:dispose()
end

function DivineInvincibleExtremeView:_updateBuffCell(view, cell, data, tag)
	local index = cell.data
	local mainGo = cell.gameObject
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local activeTag = goutil.findChild(mainGo, "activeTag")
	local imgSelect = goutil.findChild(mainGo, "imgSelect")
	local bg = goutil.findChild(mainGo, "bg")

	txtCount.text = data.finishNum
	txtDesc.text = data.desc

	GameUtil.SetActive(activeTag, self._activeBuffId == data.id)
	GameUtil.SetActive(imgSelect, self._activeBuffId == data.id)
	GameUtil.SetActive(bg, index % 2 == 0)
end

function DivineInvincibleExtremeView:_clearBuffCell(cell)
	return
end

function DivineInvincibleExtremeView:_onClikBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DivineInvincibleExtremeView:_onClikBtnPetLock()
	UIStateManager.instance:push(ViewName.DivineInvincibleExtLockPetView, self._activityId)
end

function DivineInvincibleExtremeView:_onClikBtnReset()
	if UltimateTrialController.instance:isBanInUltTrialClg(true, self._activityId) then
		return
	end

	local result = self._clgMo:getTryResultAndTipsResetExtremeStageClg(true)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local tipsContent = "重置后当前进度将会清零，是否确认重置？"

	local function okFunc()
		DivineInvincibleController.instance:sendPM_DivineInvincibleClgExtremeResetReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function DivineInvincibleExtremeView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function DivineInvincibleExtremeView:_isActiveInDefault(go)
	self._goDefaultActives = self._goDefaultActives or {}

	return self._goDefaultActives[go]
end

function DivineInvincibleExtremeView:_refreshDefaultActive(go)
	GameUtil.SetActive(go, self:_isActiveInDefault(go))
end

return DivineInvincibleExtremeView
