-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originzhengli/view/OriginZhengliStageView.lua

module("logic.extensions.originzhengli.view.OriginZhengliStageView", package.seeall)

local OriginZhengliStageView = class("OriginZhengliStageView", ViewComponent)

function OriginZhengliStageView:ctor()
	OriginZhengliStageView.super.ctor(self)
end

function OriginZhengliStageView:unbindEvents()
	OriginZhengliStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)

	for i, line in ipairs(self._selectlines) do
		GameUtil.rmClickHandler(line)
	end
end

function OriginZhengliStageView:bindEvents()
	OriginZhengliStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)

	for i, line in ipairs(self._selectlines) do
		GameUtil.addClickHandler(line, function()
			self:_onClickSelectRoute(i)
		end, self)
	end
end

function OriginZhengliStageView:buildUI()
	OriginZhengliStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnReset = self:getGo("btnReset")
	self._pirzeIcon = self:getGo("info/pirzeIcon")
	self._markGained = self:getGo("info/markGained")
	self._gotopcell = self:getGo("stageInfo/topcell")
	self._gotopposlist = self:getGo("stageInfo/topposlist")
	self._gobottomcell = self:getGo("stageInfo/bottomcell")
	self._gobottomposlist = self:getGo("stageInfo/bottomposlist")
	self._conShowLines = self:getGo("stageInfo/showLines")
	self._conSelectLines = self:getGo("stageInfo/selectLines")
	self._showlines = {}
	self._selectlines = {}

	for i = 1, 3 do
		self._selectlines[i] = self:getGo("stageInfo/selectLines/line" .. i)
		self._showlines[i] = self:getGo("stageInfo/showLines/line" .. i)
	end

	self._markPlayer = self:getGo("markPlayer")
	self._txtBuffDesc = self:getTxt("buffShow/Viewport/txtDesc")
	self._bgBuffDesc = self:getGo("buffShow/bg")
end

function OriginZhengliStageView:onExit()
	OriginZhengliStageView.super.onExit(self)
	MaterialMgr.resetAll(self._pirzeIcon)
	GameUtil.clearCells(self._gotopposlist, self._clearStageTopCell, self)
	GameUtil.clearCells(self._gobottomposlist, self._clearStageBottomCell, self)

	if self._effLine1 then
		UIEffectManager.instance:stopEffect(self._effLine1)

		self._effLine1 = nil
	end

	if self._effLine2 then
		UIEffectManager.instance:stopEffect(self._effLine2)

		self._effLine2 = nil
	end

	if self._effLine3 then
		UIEffectManager.instance:stopEffect(self._effLine3)

		self._effLine3 = nil
	end

	removetimer(self._updateBuffDescBg, self)
end

function OriginZhengliStageView:onEnter()
	OriginZhengliStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginJusticeClgGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_OriginZhengliResetRes, self._handleResetInfo, self)
	self.addGEvent(self, GlobalNotify.PM_OriginZhengliSelectRouteRes, self._updateUIByInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = OriginZhengliController.instance:getDefaultActivityId() or 0
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	OriginZhengliController.instance:getInfo(self._activityId)

	local effPath = "20260430/zhenglitiaozhan/fx_ui_zhenglitiaozhan_jiantou1.prefab"

	self._effLine3 = UIEffectManager.instance:playEffect(self, effPath, self._selectlines[2].transform, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self._selectlines[3].transform)
		eff:setLocalPos(-5, 2, 0)
		eff:setScaleXYZ(1, 1, 1)
	end)

	local effPath1 = "20260430/zhenglitiaozhan/fx_ui_zhenglitiaozhan_jiantou2.prefab"

	self._effLine1 = UIEffectManager.instance:playEffect(self, effPath1, self._selectlines[1].transform, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self._selectlines[1].transform)
		eff:setLocalPos(-15, 0, 0)
		eff:setScaleXYZ(-1, 1, 1)
	end)
	self._effLine2 = UIEffectManager.instance:playEffect(self, effPath1, self._selectlines[2].transform, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self._selectlines[2].transform)
		eff:setLocalPos(15, 5, 0)
		eff:setScaleXYZ(1, 1, 1)
	end)

	OriginZhengliController.instance:showCI()
end

function OriginZhengliStageView:_updateUIByCfg()
	self._actCfg = OriginZhengliConfig.instance:getActivityCfg(self._activityId)

	if not self._actCfg.firstPassPrize then
		MaterialMgr.setCellByCfg(self._actCfg.firstPassPrize, self._pirzeIcon)

		self._stageCfgs = OriginZhengliConfig.instance:getStageCfgs(self._activityId) or {}
		self._routeCfgs = OriginZhengliConfig.instance:getRouteCfgs(self._activityId) or {}
		self._txtCurPoint = self:getTxt("txtCurPoint")
		self._startPosId = self._actCfg.startingStageId or 0
	end
end

function OriginZhengliStageView:_updateUIByInfo()
	self._isGained = false
	self._isExistOldInfo = false
	self._hasPassRouteIds = {}
	self._hasPassRouteIdsMap = {}
	self._actBuffIds = {}
	self._allPassed = false
	self._curRouteId = 0
	self._curStageId = 0

	local info = OriginZhengliModel.instance:getInfoByActId(self._activityId)

	if info then
		self._isGained = info.isGainPrize or false

		if not info.stageInfo then
			local stageInfos = {}

			for _, stageInfo in pairs(stageInfos) do
				if not stageInfo.banRaceId then
					if #stageInfo.banRaceId > 0 then
						self._isExistOldInfo = true
					end

					if not stageInfo.activateBuff then
						local buffId = 0

						if buffId > 0 then
							table.insert(self._actBuffIds, buffId)
						end
					end
				end
			end

			if info.curRoute ~= 0 then
				self._isExistOldInfo = true
			end

			self._hasPassRouteIds = info.hasPassRouteId or {}
			self._hasPassRouteIdsMap = {}

			for _, routeId in ipairs(self._hasPassRouteIds) do
				self._hasPassRouteIdsMap[routeId] = true
			end

			self._curRouteId = info.curRoute or 0
			self._curStageId = info.curStageId or 0
			self._allPassed = #self._hasPassRouteIds >= #self._routeCfgs
		end
	end

	goutil.setActive(self._markGained, self._isGained)
	GameUtil.updateCellsList(self._gotopposlist, self._gotopcell, self._stageCfgs, self._updateStageTopCell, self)
	GameUtil.updateCellsList(self._gobottomposlist, self._gobottomcell, self._stageCfgs, self._updateStageBottomCell, self)

	local curPoints = OriginZhengliModel.instance:getCurPoints(self._activityId)
	local curRemainPoints = OriginZhengliModel.instance:getRemainPoints(self._activityId)

	self._txtCurPoint.text = langPara("轮回点数：<color=#ff1bc8>%s</color>/%s", curRemainPoints, curPoints)

	if self._curRouteId == 0 and not self._allPassed then
		self._txtCurPoint.text = lang("请选择一条线路开始挑战")
	end

	self:_updateLines()
	self:_updateBuffDesc()
end

function OriginZhengliStageView:_handleResetInfo()
	TipsFacade.instance:openCommonTips(lang("重置成功"))
	self:_updateUIByInfo()
end

function OriginZhengliStageView:getCurPosId()
	if self._curStageId == 0 then
		return self._startPosId
	end

	if self._allPassed then
		return self._startPosId
	end

	return self._curStageId
end

function OriginZhengliStageView:getNextPosId()
	if self._allPassed then
		return self._startPosId
	end

	if self._curStageId == 0 then
		return self._startPosId
	end

	if self._curRouteId == 0 then
		return self._startPosId
	end

	if not self._routeCfgs[self._curRouteId] then
		local curRouteCfg = {}

		if not curRouteCfg then
			return 0
		end

		if not curRouteCfg.stageSequence then
			local stageSequence = {}
			local curStagePosId = -1

			for i, stageId in ipairs(stageSequence) do
				if stageId == self:getCurPosId() then
					curStagePosId = i

					break
				end
			end

			if stageSequence[curStagePosId + 1] then
				return stageSequence[curStagePosId + 1]
			end

			return 0
		end
	end
end

function OriginZhengliStageView:_updateLines()
	self._hasPassRouteIdsMap = self._hasPassRouteIdsMap or {}

	if self._curRouteId == 0 then
		goutil.setActive(self._conShowLines, false)
		goutil.setActive(self._conSelectLines, true)

		for i, line in ipairs(self._selectlines) do
			goutil.setActive(line, self._hasPassRouteIdsMap[i] ~= true)
		end
	else
		goutil.setActive(self._conShowLines, true)
		goutil.setActive(self._conSelectLines, false)

		for i, line in ipairs(self._showlines) do
			goutil.setActive(line, i == self._curRouteId)
		end
	end
end

function OriginZhengliStageView:_updatePlayerMark()
	local posId = self:getCurPosId()

	if posId <= 0 then
		goutil.setActive(self._markPlayer, false)
	else
		goutil.setActive(self._markPlayer, true)

		local child = self._gotopposlist.transform:GetChild(posId - 1)

		if child then
			local posParent = goutil.findChild(child.gameObject, "pos")

			if posParent then
				self._markPlayer.transform:SetParent(posParent.transform)
				GameUtil.setLocalPos(self._markPlayer.transform, 0, 0, 0)
				self._markPlayer.transform:SetSiblingIndex(0)
				self._markPlayer.transform:SetParent(self.mainGO.transform)
			end
		end
	end
end

function OriginZhengliStageView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function OriginZhengliStageView:_onClickBtnReset()
	if not self._isExistOldInfo then
		TipsFacade.instance:openCommonTips(lang("当前无须重置"))

		return
	end

	local tips = lang("是否重置所有挑战数据?")

	TipsFacade.instance:openPopupWindow(lang("提示"), tips, function()
		OriginZhengliController.instance:reset(self._activityId)
	end)
end

function OriginZhengliStageView:_onClickSelectRoute(routeId)
	if self._curRouteId ~= 0 then
		TipsFacade.instance:openCommonTips(lang("已选择路线，不可更换"))

		return
	end

	local tips = lang("是否选择该路线进行挑战?")

	TipsFacade.instance:openPopupWindow(lang("提示"), tips, function()
		OriginZhengliController.instance:selectRoute(self._activityId, routeId)
	end)
end

function OriginZhengliStageView:_updateStageTopCell(cellGo, data, id)
	local stageId = checknumber(data.stageId)
	local info = OriginZhengliModel.instance:getStageInfoById(self._activityId, stageId)
	local isPass = false
	local isStartPos = stageId == self._startPosId
	local activateBuff = 0
	local gainPoints = 0
	local canSelect = false

	if info then
		if not info.banRaceId then
			local banRaceIds = {}

			isPass = #banRaceIds > 0
			activateBuff = info.activateBuff or 0
			gainPoints = info.gainPoints or 0
		end
	end

	canSelect = not isStartPos and activateBuff == 0

	local markStartpos = goutil.findChild(cellGo, "markStartpos")

	goutil.setActive(markStartpos, isStartPos)
	GameUtil.SetGray(cellGo, not isPass and not isStartPos)

	local conPass = goutil.findChild(cellGo, "pass")

	goutil.setActive(conPass, isPass and not isStartPos)

	local txtPoint = goutil.findChildTextComponent(conPass, "point/txt")

	txtPoint.text = langPara("获得点数：%s", gainPoints)

	local btnEnter = goutil.findChild(cellGo, "btnEnter")

	if self._curRouteId == 0 then
		self:_clearCellEffect(btnEnter)
	elseif stageId == self:getNextPosId() then
		self:_playCellEffect(btnEnter)
	else
		self:_clearCellEffect(btnEnter)
	end

	GameUtil.rmClickHandler(btnEnter)
	GameUtil.addClickHandler(btnEnter, function()
		if self._allPassed then
			if self._isGained then
				TipsFacade.instance:openCommonTips(lang("已完成所有关卡并领取奖励"))

				return
			else
				TipsFacade.instance:openCommonTips(lang("已完成所有关卡，请重置挑战"))

				return
			end

			return
		end

		if self._curRouteId == 0 then
			TipsFacade.instance:openCommonTips(lang("请先选择挑战路线"))

			return
		end

		if stageId == self:getNextPosId() then
			if canSelect then
				UIStateManager.instance:push(ViewName.OriginZhengliBuffView, self._activityId, stageId, true, 0)
			else
				OriginZhengliController.instance:showMissionView(self._activityId, stageId, 0)
			end
		else
			TipsFacade.instance:openCommonTips(lang("请按照顺序挑战关卡"))
		end
	end)

	local showType = 0

	if activateBuff > 0 then
		goutil.setActive(buffMark, true)

		local buffCfg = OriginZhengliConfig.instance:getBuffCfgById(self._activityId, activateBuff)

		if buffCfg then
			showType = buffCfg.buffType
		end
	end

	for i = 0, 2 do
		local type = goutil.findChild(conPass, "showType/type" .. i)

		goutil.setActive(type, showType == i)
	end
end

function OriginZhengliStageView:_clearStageTopCell(cellGo)
	local btnEnter = goutil.findChild(cellGo, "btnEnter")

	GameUtil.rmClickHandler(btnEnter)
	self:_clearCellEffect(btnEnter)
end

function OriginZhengliStageView:_updateStageBottomCell(cellGo, data, id)
	local stageId = checknumber(data.stageId)
	local info = OriginZhengliModel.instance:getStageInfoById(self._activityId, stageId)
	local isPass = false

	if info then
		if not info.banRaceId then
			isPass = #info.banRaceId > 0
		end
	end

	GameUtil.SetGray(cellGo, not isPass)
end

function OriginZhengliStageView:_clearStageBottomCell(cellGo)
	return
end

function OriginZhengliStageView:_onClickBtnEnter(stageId)
	OriginZhengliController.instance:showMissionView(self._activityId, stageId)
end

function OriginZhengliStageView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_tujianshouji/fx_ui_tujianshouji_tubiao.prefab"

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(effGo.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScaleXYZ(1, 1, 1)
	end)
end

function OriginZhengliStageView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function OriginZhengliStageView:_updateBuffDesc()
	self._actBuffIds = self._actBuffIds or {}

	local showStr = ""

	for _, buffId in ipairs(self._actBuffIds) do
		local buffCfg = OriginZhengliConfig.instance:getBuffCfgById(self._activityId, buffId)

		if buffCfg then
			if not buffCfg.buffType then
				local addTypeStr = buffCfg.buffType == 1 and lang("已激活觉醒印记:\n") or buffCfg.buffType == 2 and lang("已激活成长印记:\n") or ""

				if not buffCfg.buffDesc then
					local desc = ""

					if showStr ~= "" then
						showStr = showStr .. "\n\n"
					end

					showStr = showStr .. addTypeStr .. desc
				end
			end
		end
	end

	self._txtBuffDesc.text = showStr

	goutil.setActive(self._bgBuffDesc, #self._actBuffIds > 0)
	settimer(0.1, self._updateBuffDescBg, self, false)
end

function OriginZhengliStageView:_updateBuffDescBg()
	local txtHeight = GameUtil.getHeight(self._txtBuffDesc)

	GameUtil.setHeight(self._bgBuffDesc, Mathf.Min(txtHeight + 60, 600))
end

return OriginZhengliStageView
