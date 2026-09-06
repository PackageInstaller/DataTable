-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgExtremeView.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgExtremeView", package.seeall)

local NuoYaSisterClgExtremeView = class("NuoYaSisterClgExtremeView", ViewComponent)

function NuoYaSisterClgExtremeView:ctor()
	NuoYaSisterClgExtremeView.super.ctor(self)
end

function NuoYaSisterClgExtremeView:unbindEvents()
	NuoYaSisterClgExtremeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnShowPrize)
	GameUtil.rmClickHandler(self._btnClose)

	for i, v in ipairs(self._teamInfoList) do
		GameUtil.rmClickHandler(v.btnShow)
		GameUtil.rmClickHandler(v.btnChallenge)
	end
end

function NuoYaSisterClgExtremeView:bindEvents()
	NuoYaSisterClgExtremeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnShowPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i, v in ipairs(self._teamInfoList) do
		GameUtil.addClickHandler(v.btnShow, function()
			self:_onClickPetShow(i)
		end, self)
		GameUtil.addClickHandler(v.btnChallenge, function()
			self:_onClickChallenge(i)
		end, self)
	end
end

function NuoYaSisterClgExtremeView:buildUI()
	NuoYaSisterClgExtremeView.super.buildUI(self)

	self._btnBuff = self:getGo("btnBuff")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnReset = self:getGo("btnReset")
	self._showPrizeCon = self:getGo("stageInfo/showPrize/con")
	self._showPrize = self:getGo("stageInfo/showPrize")
	self._teamCell = self:getGo("teamCell")
	self._teamInfoList = {}

	for i = 1, 2 do
		local info = {}

		info.go = self:getGo("teamInfo_" .. i)
		info.btnShow = goutil.findChild(info.go, "btnShow")
		info.btnChallenge = goutil.findChild(info.go, "btnChallenge")
		info.tableView = goutil.findChild(info.go, "tableview")
		info.teamEnemy = goutil.findChild(info.go, "teamEnemy")
		info.txtName = goutil.findChildTextComponent(info.go, "txtName")
		info.txtBuffCount = goutil.findChildTextComponent(info.go, "txtBuffCount")
		info.txtBuffDesc = goutil.findChildTextComponent(info.go, "txtBuffCount/txtBuffDesc")
		info.tableList = ScrollerList.create(info.tableView, self._teamCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

		local enemyList = {}

		for i = 1, 9 do
			enemyList[i] = {
				go = goutil.findChild(info.teamEnemy, "cell_" .. i),
				con = goutil.findChild(info.teamEnemy, "cell_" .. i .. "/icon")
			}
		end

		info.teamEnemyList = enemyList
		self._teamInfoList[i] = info
	end

	self._txtMaxStage = self:getTxt("stageInfo/txtMaxStage")
	self._stageSlider = self:getSlider("stageInfo/slider")
	self._imgSliderHead = self:getGo("stageInfo/slider/FillArea/info/head")
	self._txtCurStage = self:getTxt("stageInfo/slider/FillArea/info/txtLevel")

	self:_recordGoDefaultActive(self._showPrize)
end

function NuoYaSisterClgExtremeView:onExit()
	NuoYaSisterClgExtremeView.super.onExit(self)
	MaterialMgr.resetAll(self._showPrizeCon)
end

function NuoYaSisterClgExtremeView:onEnter()
	NuoYaSisterClgExtremeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_NotifyNuoYaSisterExtremeClgFinishRes, self._refreshView, self)

	self._activityId = self:getFirstParam()
	self._activityType = NuoYaSisterClgController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._activityCfg = NuoYaSisterClgConfig.instance:getActivityCfg(self._activityId)

	local proxy = MaterialMgr.setCellByCfg(self._activityCfg.extremeShowPrize, self._showPrizeCon)

	if proxy then
		proxy.binder:setAutoTips(false)
		proxy.binder:setCallBack(function()
			self:_onClickPrize()
		end)
	end

	HeadItemController.instance:setMyHeadCell(self._imgSliderHead)

	if self._isAoqiGodProcessType then
		GameUtil.SetActive(self._showPrize, false)
	else
		self:_refreshDefaultActive(self._showPrize)
	end

	self:_refreshView()
end

function NuoYaSisterClgExtremeView:_refreshView()
	local maxPassStageId = NuoYaSisterClgModel.instance:getMaxStageId(self._activityId)
	local isPass = true

	for i = 1, 2 do
		if NuoYaSisterClgConfig.instance:getStageCfg(self._activityId, i, maxPassStageId + 1) then
			isPass = false

			break
		end
	end

	if isPass == true then
		TipsFacade.instance:openTipWindowValidX(lang("提示"), lang("已通关全部关卡"), function()
			self:close()
		end)

		return
	end

	self._stageId = NuoYaSisterClgModel.instance:getCurStageId(self._activityId) + 1

	local maxStage = 0

	for i = 1, 2 do
		local stageCfgs = NuoYaSisterClgConfig.instance:getStageCfgs(self._activityId, i)

		if maxStage < #stageCfgs then
			maxStage = #stageCfgs
		end

		self:_updateTeamCell(i)
	end

	self._stageSlider:SetValue(self._stageId / maxStage)

	self._txtMaxStage.text = langPara("%d层", maxStage)
	self._txtCurStage.text = langPara("当前：%d层", self._stageId)
end

function NuoYaSisterClgExtremeView:_updateTeamCell(teamId)
	local info = self._teamInfoList[teamId]
	local typeCfg = NuoYaSisterClgConfig.instance:getExtremeClgType(self._activityId, teamId)
	local stageCfg = NuoYaSisterClgConfig.instance:getStageCfg(self._activityId, teamId, self._stageId)
	local masterCfg = NuoYaSisterClgConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)

	for i = 1, 9 do
		MaterialMgr.resetAll(info.teamEnemyList[i].con)
		GameUtil.SetActive(info.teamEnemyList[i].go, false)
	end

	for i, v in ipairs(masterCfg) do
		if info.teamEnemyList[v.posId] then
			GameUtil.setLocalScale(info.teamEnemyList[v.posId].con, 0.8, 0.8, 0.8)

			local proxy = MaterialMgr.setCell(MatType.Pet, v.raceId, info.teamEnemyList[v.posId].con)

			if proxy then
				proxy.binder:setAutoTips(true)
			end

			GameUtil.SetActive(info.teamEnemyList[v.posId].go, true)
		end
	end

	local teamInfo = NuoYaSisterClgModel.instance:getTeamInfo(self._activityId, teamId)
	local buffIndex = teamInfo.stageNum

	if buffIndex > 0 then
		local buffCfg = NuoYaSisterClgConfig.instance:getBuffCfg(self._activityId, teamId)
		local acivityBuffIndex = buffIndex

		if not buffCfg[acivityBuffIndex] then
			acivityBuffIndex = #buffCfg
		end

		info.txtBuffDesc.text = buffCfg[acivityBuffIndex].buffDesc
		info.txtBuffCount.text = langPara("%s加成<color=#53C93CFF>（%s层）</color>:%s", typeCfg.name, GameUtil.getChineseNumber(teamInfo.stageNum), buffCfg[acivityBuffIndex].buffDesc)
	else
		info.txtBuffDesc.text = lang("无加成效果")
		info.txtBuffCount.text = langPara("%s加成<color=#53C93CFF>（%s层）</color>:无加成效果", typeCfg.name, GameUtil.getChineseNumber(teamInfo.stageNum))
	end

	if not teamInfo.pets then
		local list = {}

		table.sort(list, function(a, b)
			local petInfoA = NuoYaSisterClgModel.instance:getPetInfo(self._activityId, a)
			local petInfoB = NuoYaSisterClgModel.instance:getPetInfo(self._activityId, b)
			local deadA = petInfoA and petInfoA.hp == 0 or false
			local deadB = petInfoB and petInfoB.hp == 0 or false

			if deadA ~= deadB then
				return deadB
			else
				return a < b
			end
		end)
		info.tableList:reloadData(list)
	end
end

function NuoYaSisterClgExtremeView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local petMo = BagPetsController.instance:getPet(data)
	local proxy = MaterialMgr.setCellByMo(petMo, con)
	local slider = goutil.findChildComponent(go, "Slider", ComponentType.Slider)
	local petInfo = NuoYaSisterClgModel.instance:getPetInfo(self._activityId, data)

	if proxy then
		if petInfo and petInfo.hp == 0 then
			proxy.binder:setGray(true)
		else
			proxy.binder:setGray(false)
		end
	end

	if petInfo and petInfo.hp >= 0 then
		local rate = petInfo.hp / petMo._maxHp * 100

		slider.value = rate / 100
	else
		slider.value = 1
	end
end

function NuoYaSisterClgExtremeView:_clearCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function NuoYaSisterClgExtremeView:_onClickPrize()
	UIStateManager.instance:push(ViewName.NuoYaSisterClgPrizeView, self._activityId)
end

function NuoYaSisterClgExtremeView:_onClickBuff()
	UIStateManager.instance:push(ViewName.NuoYaSisterClgBuffView, self._activityId)
end

function NuoYaSisterClgExtremeView:_onClickPetShow(teamId)
	local teamInfo = NuoYaSisterClgModel.instance:getTeamInfo(self._activityId, teamId)

	if not teamInfo.pets then
		local resultList = {}

		for i, v in ipairs(teamInfo.pets) do
			local petMo = BagPetsController.instance:getPet(v)

			table.insert(resultList, petMo)
		end

		UIStateManager.instance:push(ViewName.NuoYaSisterClgPetView, self._activityId, resultList)
	end
end

function NuoYaSisterClgExtremeView:_onClickChallenge(teamId)
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local fmtMo = NuoYaSisterClgModel.instance:getExtFmtMo()

	fmtMo:initParams(self._activityId, self._stageId, teamId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function NuoYaSisterClgExtremeView:_onClickReset()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否重置所有关卡，精灵状态重置，可重新调整带入挑战的精灵，已通关的关卡奖励不重置"), function()
		NuoYaSisterClgAgent.instance:sendPM_NuoYaSisterExtremeClgResetReq(self._activityId)
	end)
end

function NuoYaSisterClgExtremeView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function NuoYaSisterClgExtremeView:_refreshDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}

	GameUtil.SetActive(go, checkbool(self._goDefaultActives[go]))
end

return NuoYaSisterClgExtremeView
