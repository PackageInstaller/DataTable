-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineeternaldragonclg/view/DivineEternalDragonClgStageView.lua

module("logic.extensions.divineeternaldragonclg.view.DivineEternalDragonClgStageView", package.seeall)

local DivineEternalDragonClgStageView = class("DivineEternalDragonClgStageView", ViewComponent)

function DivineEternalDragonClgStageView:ctor()
	DivineEternalDragonClgStageView.super.ctor(self)
end

function DivineEternalDragonClgStageView:unbindEvents()
	DivineEternalDragonClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)

	for i, cell in ipairs(self._formCellList) do
		GameUtil.rmClickHandler(cell.btnChallenge)
	end
end

function DivineEternalDragonClgStageView:bindEvents()
	DivineEternalDragonClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)

	for i, cell in ipairs(self._formCellList) do
		GameUtil.rmClickHandler(cell.btnChallenge)
		GameUtil.addClickHandler(cell.btnChallenge, GameUtil.handler(self._onClickBtnClg, self, i))
	end
end

function DivineEternalDragonClgStageView:buildUI()
	DivineEternalDragonClgStageView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnReset = self:getGo("btnReset")
	self._levelSlider = self:getSlider("info/level")
	self._upLevelTxt = self:getTxt("info/txtUp")
	self._downLevelTxt = self:getTxt("info/txtDown")
	self._curLevelTxt = self:getTxt("info/level/Fill Area/info/txtLevel")
	self._headObj = self:getGo("info/level/Fill Area/info/head")
	self._iconReward = self:getGo("info/reward/icon")
	self._formCellList = {}

	for i = 1, 2 do
		local cell = {}
		local path = "form_" .. i

		cell.go = self:getGo(path)
		cell.pass = goutil.findChild(cell.go, "pass")
		cell.btnChallenge = goutil.findChild(cell.go, "btnChallenge")
		cell.petCellList = {}

		for j = 1, 9 do
			local petCell = {}

			petCell.go = goutil.findChild(cell.go, "formation/cell_" .. j)
			petCell.con = goutil.findChild(petCell.go, "con")
			cell.petCellList[j] = petCell
		end

		self._formCellList[i] = cell
	end

	self._txtTime = self:getTxt("time/txt")
	self._curPrizeCom = self:getGo("desc/prizeCom")
	self._txtDesc = self:getTxt("desc/txt")
	self._descStr = self._txtDesc.text
	self._requireCellList = {}

	for i = 1, 8 do
		local cell = {}
		local path = "require/list/cell_" .. i

		cell.go = self:getGo(path)
		cell.attr = goutil.findChildComponent(cell.go, "attr", "UIImageSpriteChange")
		cell.arrow = goutil.findChild(cell.go, "arrow")
		self._requireCellList[i] = cell
	end

	self._reward = self:getGo("info/reward")
	self._time = self:getGo("time")
	self._prizeCom = self:getGo("desc/prizeCom")
	self._rewardTip = self:getGo("desc/rewardTip")
end

function DivineEternalDragonClgStageView:onExit()
	DivineEternalDragonClgStageView.super.onExit(self)

	for i, cell in ipairs(self._formCellList) do
		for j, petCell in ipairs(cell.petCellList) do
			MaterialMgr.resetAll(petCell.con)
			goutil.setActive(petCell.go, false)
		end
	end

	HeadItemController.instance:resetHeadCell(self._headObj)
	MaterialMgr.resetAll(self._curPrizeCom)
	MaterialMgr.resetAll(self._iconReward)
end

function DivineEternalDragonClgStageView:onEnter()
	DivineEternalDragonClgStageView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	DivineEternalDragonClgController.instance:showCI()
	self:_updateByCfg()
	self:_initAoqiGodUI()
	DivineEternalDragonClgController.instance:getInfo(self._activityId)
	self.addGEvent(self, GlobalNotify.DivineEternalDragonClgUpdateInfo, self._updateByInfo, self)
end

function DivineEternalDragonClgStageView:_initAoqiGodUI()
	if self._isAoqiGodProcessType then
		local descStrArr = string.split(self._descStr, "\n")

		self._txtDesc.text = string.format("%s\n%s", descStrArr[1], descStrArr[2])
	end

	GameUtil.SetActive(self._reward, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._time, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._prizeCom, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._rewardTip, not self._isAoqiGodProcessType)
end

function DivineEternalDragonClgStageView:_updateByCfg()
	self._actCfg = DivineEternalDragonClgConfig.instance:getActivityCfg(self._activityId)
	self._stageCfgs = DivineEternalDragonClgConfig.instance:getStageCfgs(self._activityId)
	self._lastStageCfg = self._stageCfgs[#self._stageCfgs]

	local proxy = MaterialMgr.setCellByCfg(self._lastStageCfg.prize, self._iconReward)

	if proxy then
		proxy.binder:setNum(100)
	end

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function DivineEternalDragonClgStageView:_updateByInfo()
	local baseInfo = DivineEternalDragonClgModel.instance:getBaseInfoByActId(self._activityId)

	if baseInfo.passStageId >= #self._stageCfgs then
		self:close()

		return
	end

	self._curPassFlags = baseInfo.teamIsPass
	self._curStageId = baseInfo.passStageId + 1
	self._curStageCfg = self._stageCfgs[self._curStageId]

	self:_updateCurStage()
	self:_updateSlider()
end

function DivineEternalDragonClgStageView:_onClickBtnTip()
	local ruleKey = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(ruleKey)
end

function DivineEternalDragonClgStageView:_onClickBtnReset()
	local tips = string.format("是否确认重置当前关卡？")

	TipsFacade.instance:openTipWindow("提示", tips, function()
		DivineEternalDragonClgController.instance:resetStage(self._activityId, self._curStageId)
	end, "确定", UnityEngine.TextAnchor.MiddleCenter)
end

function DivineEternalDragonClgStageView:_onClickBtnClg(formId)
	local isPass = self._curPassFlags[formId]

	if isPass then
		TipsFacade.instance:openCommonTips("已通关")

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, 445, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	DivineEternalDragonClgController.instance:openMissionView(self._activityId, self._curStageId, formId)
end

function DivineEternalDragonClgStageView:_updateSlider()
	self._upLevelTxt.text = string.format("%d层", #self._stageCfgs)
	self._downLevelTxt.text = "1层"

	HeadItemController.instance:setMyHeadCell(self._headObj)

	local sValue = (self._curStageId - 1) / (#self._stageCfgs - 1)

	self._levelSlider:SetValue(sValue)

	self._curLevelTxt.text = string.format("当前%d层", self._curStageId)
end

function DivineEternalDragonClgStageView:_updateCurStage()
	for i, cell in ipairs(self._formCellList) do
		goutil.setActive(cell.pass, self._curPassFlags[i])

		local creepCfgs = DivineEternalDragonClgConfig.instance:getCreepCfg(self._curStageCfg.creepsMasterId[i])
		local petMap = {}

		for _, data in ipairs(creepCfgs) do
			petMap[data.posId] = data
		end

		for j, petCell in ipairs(cell.petCellList) do
			MaterialMgr.resetAll(petCell.con)
			goutil.setActive(petCell.go, false)

			local petData = petMap[j]

			if petData then
				goutil.setActive(petCell.go, true)

				local raceId, posId = petData.raceId, petData.posId

				MaterialMgr.setIcon(petCell.con, MatType.PET_SKIN, (checknumber(petData.faceId) > 0 or nil) and checknumber(petData.faceId))
			end
		end
	end

	MaterialMgr.resetAll(self._curPrizeCom)
	MaterialMgr.setCellByCfg(self._curStageCfg.prize, self._curPrizeCom)

	for i, cell in ipairs(self._requireCellList) do
		goutil.setActive(cell.go, false)
		goutil.setActive(cell.arrow, true)
	end

	if self._curStageCfg then
		if not self._curStageCfg.raceTypeSeq then
			local raceTypeSeq = {}

			for i, data in ipairs(raceTypeSeq) do
				local cell = self._requireCellList[i]

				goutil.setActive(cell.go, true)

				if i == #raceTypeSeq then
					goutil.setActive(cell.arrow, false)
				end

				local race = checknumber(GameEnum.Races[data])

				race = race % 10

				cell.attr:SetState(race - 1)
			end
		end
	end
end

return DivineEternalDragonClgStageView
