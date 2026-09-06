-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/view/DivineTunTianExtView.lua

module("logic.extensions.divinetuntian.view.DivineTunTianExtView", package.seeall)

local DivineTunTianExtView = class("DivineTunTianExtView", ViewComponent)
local COLOR_GREEN = "00E114FF"
local COLOR_RED = "FF0000FF"

function DivineTunTianExtView:ctor()
	DivineTunTianExtView.super.ctor(self)
end

function DivineTunTianExtView:unbindEvents()
	DivineTunTianExtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnReset)
end

function DivineTunTianExtView:bindEvents()
	DivineTunTianExtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
end

function DivineTunTianExtView:buildUI()
	DivineTunTianExtView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnChallenge = self:getGo("rightCol/btnChallenge")
	self._btnReset = self:getGo("rightCol/btnReset")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtPower = self:getTxt("rightCol/txtPower")
	self._Content = self:getTxt("rightCol/rule/ScrollView/Viewport/Content")
	self._petTip = self:getGo("rightCol/pet/txtPetTip")
	self._txtBtn = self:getTxt("rightCol/btnChallenge/txt")
	self._stages = self:getGo("stages")
	self._stageList = {}

	for i = 1, 7 do
		local stage = self:getGo("stages/stage" .. i)

		table.insert(self._stageList, stage)
	end

	self._tableview = self:getGo("rightCol/tableview")
	self._cell = self:getGo("rightCol/cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tablecellPet = self:getGo("rightCol/pet/tableview/tablecell")
	self._tableviewPet = self:getGo("rightCol/pet/tableview")
	self._scrollListPet = ScrollerList.create(self._tableviewPet, self._tablecellPet, GameUtil.handler(self._updateCellPet, self), GameUtil.handler(self._clearCellPet, self))
end

function DivineTunTianExtView:onExit()
	DivineTunTianExtView.super.onExit(self)
	self:clearStages()
	self._scrollList:dispose()
	self._scrollListPet:dispose()
end

function DivineTunTianExtView:onEnter()
	DivineTunTianExtView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineTunTianClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_DivineTunTianClgExtremeResetRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 508001
	end

	self._actCfg = DivineTunTianConfig.instance:getActCfg(self._activityId)
	self._buffPlanId = self._actCfg.extremeBuffPlanId
	self._stageCfgs = DivineTunTianConfig.instance:getExtStageCfgs(self._activityId)
	self._buffCfgs = DivineTunTianConfig.instance:getBuffCfgs(self._buffPlanId)
	self._stageId = 1

	local changeSetId = DivineTunTianModel.instance:popChangeSetId()

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end

	DivineTunTianController.instance:sendPM_DivineTunTianClgGetInfoReq(self._activityId)
end

function DivineTunTianExtView:_onUpdate()
	self._info = DivineTunTianModel.instance:getInfo(self._activityId)
	self._stageInfo = self._info and self._info.extremeStageInfoMap[self._stageId]

	local totalPower = DivineTunTianController.instance:getTotalPower(self._activityId)

	if self._stageInfo then
		if not self._stageInfo.lockRaceIds then
			local lockRaceIds = {}
			local curStageCfg = self._stageCfgs[self._stageId]
			local activateBuffIdx = DivineTunTianController.instance:getExtCurActivateBuffIdx(self._activityId)

			self._Content.text = curStageCfg.desc
			self._txtPower.text = string.format("当前能量总和：%d", totalPower)
			self._txtBtn.text = "进入战斗"

			if self._stageInfo then
				local getPassPower = DivineTunTianModel.instance:getPassPower(self._activityId, self._stageInfo.stageId)
				local totalPower = self._stageInfo.score + getPassPower

				if totalPower >= curStageCfg.passPowerCondition then
					self._txtBtn.text = "已通关"
				end
			end

			self:updateStages()
			self._scrollList:reloadData(self._buffCfgs)
			self._scrollList:MoveCellToCenter(activateBuffIdx - 1)
			self._scrollListPet:reloadData(lockRaceIds)
			GameUtil.SetActive(self._petTip, self._stageInfo == nil)

			local getPassPower = DivineTunTianModel.instance:getPassPower(self._activityId, self._stageId)
			local totalPower = ((self._stageInfo or nil) and self._stageInfo.score) + getPassPower
			local curStageCfg = self._stageCfgs[self._stageId]
			local hasWin = DivineTunTianModel.instance:hasWin(self._activityId, self._stageId)
			local hasChallenged = totalPower >= curStageCfg.passPowerCondition

			GameUtil.SetGray(self._btnChallenge, hasChallenged and hasWin)
		end
	end
end

function DivineTunTianExtView:updateStages()
	for i, stageCfg in ipairs(self._stageCfgs) do
		if self._info then
			local stageGo = self._stageList[i]
			local btnChoose = goutil.findChild(stageGo, "btnChoose")
			local imgChoose = goutil.findChild(stageGo, "imgChoose")
			local pass = goutil.findChild(stageGo, "pass")
			local txtPurpose = goutil.findChildTextComponent(stageGo, "txtPurpose")
			local txtOriginPower = goutil.findChildTextComponent(stageGo, "txtOriginPower")
			local txtGetPower = goutil.findChildTextComponent(stageGo, "txtGetPower")
			local getPassPower = DivineTunTianModel.instance:getPassPower(self._activityId, stageCfg.stageId)
			local curStageScore = 0

			if self._info then
				curStageScore = self._info.score
			end

			local totalPower = curStageScore + getPassPower
			local hasWin = DivineTunTianModel.instance:hasWin(self._activityId, stageCfg.stageId)
			local color = COLOR_RED

			if totalPower >= stageCfg.passPowerCondition then
				color = COLOR_GREEN
			end

			txtOriginPower.text = string.format("本关变身：%d", curStageScore)
			txtGetPower.text = string.format("接收传导：%d", getPassPower)
			txtPurpose.text = string.format("<color=#%s>%d</color>/%d", color, totalPower, stageCfg.passPowerCondition)

			GameUtil.SetActive(pass, totalPower >= stageCfg.passPowerCondition and hasWin)
			GameUtil.SetActive(imgChoose, self._stageId == stageCfg.stageId)
			GameUtil.addClickHandler(btnChoose, function()
				self._stageId = stageCfg.stageId

				self:_onUpdate()
			end, self)
		end
	end
end

function DivineTunTianExtView:clearStages()
	for idx, stageGo in ipairs(self._stageList) do
		if self._info then
			local btnChoose = goutil.findChild(stageGo, "btnChoose")

			GameUtil.rmClickHandler(btnChoose)
		end
	end
end

function DivineTunTianExtView:_updateCell(view, cell, data)
	local curActivate = goutil.findChild(cell, "curActivate")
	local bg = goutil.findChild(cell, "bg")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local totalPower = DivineTunTianController.instance:getTotalPower(self._activityId)
	local powerArr = string.split(data.powerArrDesc, "-")

	txtDesc.text = data.desc

	local buffCanActive = totalPower >= checknumber(powerArr[1]) and totalPower <= checknumber(powerArr[2])

	txtScore.text = data.powerArrDesc

	if checknumber(powerArr[2]) == 0 then
		buffCanActive = totalPower >= checknumber(powerArr[1])
		txtScore.text = checknumber(powerArr[1]) .. "以上"
	end

	GameUtil.SetActive(curActivate, buffCanActive)
	GameUtil.SetActive(bg, cell.index % 2 == 0)
end

function DivineTunTianExtView:_clearCell(cell)
	return
end

function DivineTunTianExtView:_updateCellPet(view, cell, data)
	local petId = DivineTunTianController.instance:getMaxFightPowerPetIdByRaceId(data)

	MaterialMgr.setIcon(cell, MatType.Pet, data, nil, nil)
	GameUtil.addClickHandler(cell, function()
		local curBagPetMo = BagPetsController.instance:getPet(petId)

		CommonTipsMgr.instance:showPetTips(curBagPetMo)
	end, self)
end

function DivineTunTianExtView:_clearCellPet(cell)
	MaterialMgr.clearIcon(cell)
	GameUtil.rmClickHandler(cell)
end

function DivineTunTianExtView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyExt

	TipsFacade.instance:openRulesView(key)
end

function DivineTunTianExtView:_onClickBtnChallenge()
	local getPassPower = DivineTunTianModel.instance:getPassPower(self._activityId, self._stageId)
	local totalPower = ((self._stageInfo or nil) and self._stageInfo.score) + getPassPower
	local curStageCfg = self._stageCfgs[self._stageId]
	local hasWin = DivineTunTianModel.instance:hasWin(self._activityId, self._stageId)
	local hasChallenged = totalPower >= curStageCfg.passPowerCondition

	if hasChallenged and hasWin then
		FloatWordMgr.instance:show("已达成本关要求，无需重复挑战")
	else
		DivineTunTianController.instance:enterExtBattleClg(self._activityId, self._stageId)
	end
end

function DivineTunTianExtView:_onClickBtnReset()
	local function okFunc()
		DivineTunTianController.instance:sendPM_DivineTunTianClgExtremeResetReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow("提示", "是否将全部关卡能量重置为初始值，解除精灵封印", okFunc, nil, "确认", "取消")
end

return DivineTunTianExtView
