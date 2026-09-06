-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/SctrialView.lua

module("logic.extensions.scenariocopy.view.SctrialView", package.seeall)

local SctrialView = class("SctrialView", ViewComponent)
local CELL_POS = {
	[0] = {
		x = 120,
		scaleX = 1
	},
	{
		x = 370,
		scaleX = -1
	},
	{
		x = 620,
		scaleX = -1
	},
	{
		x = 370,
		scaleX = 1
	}
}

function SctrialView:ctor()
	SctrialView.super.ctor(self)
end

function SctrialView:buildUI()
	SctrialView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txt")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")

	local bgCanvas = self:getGo("Canvas")

	GameUtil.expandRectTransform(bgCanvas.transform)

	local ScrollerGo = goutil.findChild(self.mainGO, "Canvas/tableview")
	local cellGo = goutil.findChild(self.mainGO, "Canvas/btnCell")
	local updateCellCallBack = GameUtil.handler(self._updateChaptersCell, self)
	local clearCellCallBack = GameUtil.handler(self._clearChaptersCell, self)

	self._chaptersScrollList = ScrollerList.create(ScrollerGo, cellGo, updateCellCallBack, clearCellCallBack)
	self._tableStage = self:getGo("left/tableview")
	self._itemStage = self:getGo("left/tablecell")
	self._tableviewStage = ScrollerList.create(self._tableStage, self._itemStage, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))

	self._tableviewStage:regGetCellSize(GameUtil.handler(self._stageCellSizeForindex, self))

	self._uiTableStage = self._tableStage:GetComponent("UITableview")

	self._uiTableStage:RegisterReloadFinishCallback(self._onReloadFinish, self)

	self._btnBuff = self:getBtn("buff/btnClick")
	self._txtBuff = goutil.findChildTextComponent(self.mainGO, "buff/txtIcon")
	self._buffIcon = self:getGo("buff/icon")
	self._buffGo = self:getGo("buff")
	self._buffEff = nil
	self._tableGoNormalPrize = self:getGo("right/normalPrize/tableview")
	self._itemGoNormalPrize = self:getGo("right/normalPrize/tablecell")
	self._tableviewNormalPrize = ScrollerList.create(self._tableGoNormalPrize, self._itemGoNormalPrize, GameUtil.handler(self._updateNormalPrizeCell, self), GameUtil.handler(self._clearNormalPrizeCell, self))
	self._btnChallenge = self:getBtn("right/btnChallenge")
	self._btnSweep = self:getBtn("right/btnSweep")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "right/title/txt")
	self._txtDes = goutil.findChildTextComponent(self.mainGO, "right/des/txt")
	self._txtRecZDL = goutil.findChildTextComponent(self.mainGO, "right/recZDL/txt")
	self._txtPassDes = goutil.findChildTextComponent(self.mainGO, "right/condition/txt2")
	self._txtPerfetPassDes = goutil.findChildTextComponent(self.mainGO, "right/condition2/txt2")
	self._txtTili = goutil.findChildTextComponent(self.mainGO, "right/btnChallenge/NodePower/Power")
	self._iconTili = self:getGo("right/btnChallenge/NodePower/Icon")
	self._effectList = {}
	self._goldBarCon = self:getGo("goldBarCon")
end

function SctrialView:bindEvents()
	SctrialView.super.bindEvents(self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
	self._btnSweep:AddClickListener(self._onClickSweep, self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._clickTip, self)
	self._btnBuff:AddClickListener(self._clickBuff, self)
end

function SctrialView:unbindEvents()
	SctrialView.super.unbindEvents(self)
	self._btnChallenge:RemoveClickListener()
	self._btnSweep:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
end

function SctrialView:destroyUI()
	SctrialView.super.destroyUI(self)
end

function SctrialView:onEnter()
	SctrialView.super.onEnter(self)

	local params = self:getOpenParam()

	self._trialId = checknumber(params[1])

	if self._trialId == 0 then
		printError("试炼id错误，请检查，关闭界面。")
		self:close()

		return
	end

	local cfg = ScenariocopyConfig.instance:getTrialCfg(self._trialId)

	ScenariocopyModel.instance:setTypeId(cfg.typeId, true)

	self._spineMgr = TableviewSpineMgr.get(self._viewPresentor)
	self._selectTab = ScenariocopyModel.instance:getSelectTab()

	local actId = ScenariocopyModel.instance:getActivityId()
	local scCfg = ScenariocopyConfig.instance:getActCfg(actId)
	local energyMat = scCfg.energy
	local energyList = {}

	if not string.nilorempty(energyMat) then
		local energyMatArr = string.splitToNumber(energyMat, ":")
		local energyId = energyMatArr[2]
		local energyCfg = EnergyConfig.instance:getEnergyCfg(energyId)
		local isNeedShowAdd = not string.nilorempty(energyCfg.source)

		local function callBack()
			EnergyController.instance:openBuyView(energyId)
		end

		energyList = {
			id = energyMat,
			showAdd = isNeedShowAdd,
			showAddCallBack = callBack
		}
	end

	local propList = {
		id = "10:12002",
		showAdd = false
	}

	if self._goldBarCon then
		local list = {
			energyList,
			propList
		}

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end

	local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.OperationPlot, actId)
	local curStamp = ServerTime.now()
	local diff = GameUtil.string2time(actCfg.endTime) - curStamp
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(diff)
	local endDate = os.date("*t", GameUtil.string2time(actCfg.endTime))
	local endStr = langPara("%s天%d小时%d分", day, hour, min)

	if not string.nilorempty(energyMat) and self._txtTime then
		local matCfg = MaterialMgr.getMatCfgByStr(energyMat)

		self._txtTime.text = langPara("能量每5分钟恢复1点，将于%02d月%02d日5:00后过期", endDate.month, endDate.day)
	end

	self:_prepareData()
	self:_updateSelectToMax()
	self:_refresh()
	settimer(0, self._updateOrder, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.dailyRefresh, self)
	GlobalDispatcher:addListener(OperationPlotAgent.PM_OperationPlotInfoRes, self._refresh, self)
	GlobalDispatcher:addListener(OperationPlotAgent.PM_OperationPlotGainBuffPrizeRes, self._handleBuffPrizeRes, self)
end

function SctrialView:onEnterFinished()
	SctrialView.super.onEnterFinished(self)
end

function SctrialView:onExit()
	SctrialView.super.onExit(self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self.dailyRefresh, self)
	GlobalDispatcher:removeListener(OperationPlotAgent.PM_OperationPlotInfoRes, self._refresh, self)
	GlobalDispatcher:removeListener(OperationPlotAgent.PM_OperationPlotGainBuffPrizeRes, self._handleBuffPrizeRes, self)
	removetimer(self._updateOrder, self)
	self._tableviewStage:dispose()
	self._tableviewNormalPrize:dispose()
	self._chaptersScrollList:dispose()
	uGuiUtil.clearImage(self._buffIcon)
	uGuiUtil.clearImage(self._iconTili)
	UIEffectManager.instance:stopEffect(self._buffEff)

	for k, v in pairs(self._effectList) do
		UIEffectManager.instance:stopEffect(v)

		v = nil
	end

	table.clear(self._effectList)
end

function SctrialView:onExitFinished()
	SctrialView.super.onExitFinished(self)
	self._spineMgr:clear()
end

function SctrialView:_updateSelectToMax()
	self:_updateStagesLockMap()
	self:_updateSelectTabToMax()
	self:_updateSelectStageToMax()
end

function SctrialView:_updateStagesLockMap()
	self._stagesLockMap = {}

	for chapterIndex, chapterData in ipairs(self._chapterList) do
		self._stagesLockMap[chapterIndex] = {}

		for stageIndex, stageData in ipairs(chapterData) do
			local isPassStage, isPerfertPassStage = ScenariocopyModel.instance:getStagePass(stageData.chapterId, 1)
			local isPassPreStage = true
			local tip1 = ""

			if stageIndex > 1 then
				local preStageIndex = stageIndex - 1
				local preStageData = chapterData[preStageIndex]

				tip1 = langPara("通过前面关卡后解锁")
				isPassPreStage = ScenariocopyModel.instance:getStagePass(preStageData.chapterId, 1)
			end

			local isTimeUnLock = true
			local tip2 = ""

			if not string.nilorempty(stageData.openDay) then
				isTimeUnLock = ScenariocopyController.instance:getIfOpenByStartDay(stageData.openDay)

				local openMon, openDay = ScenariocopyController.instance:parseOpenTime(stageData.openDay)

				tip2 = langPara("%s月%s日 5:00 解锁", openMon, openDay)
			end

			local isPassConditionStage = true
			local tip3 = ""
			local unlockCondition = stageData.unlockCondition
			local conditionChapter = unlockCondition[2]

			if not string.nilorempty(conditionChapter) then
				local data = ScenariocopyConfig.instance:getChapterCfg(unlockCondition[1], unlockCondition[2])

				tip3 = langPara("通关 %s %s 后解锁", data.orderNumber, data.chapterName)
				isPassConditionStage = ScenariocopyModel.instance:getStagePass(conditionChapter, 1)
			end

			local data = {}

			data.state = 1
			data.tips = ""

			if not isPassPreStage then
				data.state = -1
				data.tips = tip1
			elseif not isTimeUnLock then
				data.state = -2
				data.tips = tip2
			elseif not isPassConditionStage then
				data.state = -3
				data.tips = tip3
			else
				data.state = isPerfertPassStage and 2 or isPassStage and 1 or 0
			end

			self._stagesLockMap[chapterIndex][stageIndex] = data
		end
	end
end

function SctrialView:_updateSelectTabToMax()
	local maxUnLoackChapter = 0

	for chapterIndex, chapterMap in ipairs(self._stagesLockMap) do
		local isHaveLock = false

		for stageIndex, data in ipairs(chapterMap) do
			if data.state < 0 then
				isHaveLock = true

				break
			end
		end

		local firstStateData = chapterMap[1]

		if not isHaveLock then
			maxUnLoackChapter = maxUnLoackChapter + 1
		else
			if firstStateData.state >= 0 then
				maxUnLoackChapter = maxUnLoackChapter + 1
			end

			break
		end
	end

	self._selectTab = maxUnLoackChapter

	self:_updateCurSelectTab(self._selectTab)
end

function SctrialView:_updateSelectStageToMax()
	local maxUnLoackStage = 0
	local chapterMap = self._stagesLockMap[self._selectTab]

	for stageIndex, data in ipairs(chapterMap) do
		if data.state < 0 then
			break
		end

		maxUnLoackStage = maxUnLoackStage + 1
	end

	self._selectStage = maxUnLoackStage
end

function SctrialView:_updateCurSelectTab(index)
	self._selectTab = index

	ScenariocopyModel.instance:setSelectTab(self._selectTab)
end

function SctrialView:_prepareData()
	self._selectStage = 1
	self._trialCfg = ScenariocopyConfig.instance:getTrialCfg(self._trialId)
	self._trialPageCfg = ScenariocopyConfig.instance:getTrialPageCfgs(self._trialId)

	if self._trialCfg == nil then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("缺试炼配置"), GameUtil.handler(self.close, self))

		return
	end

	self._typeId = self._trialCfg.typeId

	local chapterCfgs = ScenariocopyConfig.instance:getChapterCfgs(self._typeId)

	self._chapterList = {}

	for _, data in pairs(chapterCfgs) do
		local index = data.chapterType - 1

		if index < 1 then
			printError("chapterType错误，试炼难度类型在试炼中是由2开始，1是普通剧情，不在试炼")
		end

		self._chapterList[index] = self._chapterList[index] or {}

		table.insert(self._chapterList[index], data)
	end

	for i = 1, #self._chapterList do
		table.sort(self._chapterList[i], function(a, b)
			return a.chapterId < b.chapterId
		end)
	end
end

function SctrialView:_getCurStageCfg()
	local chapterCfg = self._chapterList[self._selectTab][self._selectStage]

	if chapterCfg == nil then
		return
	end

	local curStageCfg = ScenariocopyConfig.instance:getStageCfg(chapterCfg.chapterId, 1)

	if curStageCfg == nil then
		return
	end

	ScenariocopyModel.instance:setStageCfg(curStageCfg)

	return curStageCfg
end

function SctrialView:_refresh()
	self:_updateStagesLockMap()
	self:_updateSelectStageToMax()
	self:_updateRightPlaneUI()
	self:_updateStageReloadData()
	self:_updateChaptersScroll()
	self:_updateBuffUI()
end

function SctrialView:_updateRightPlaneUI()
	local curStageCfg = self:_getCurStageCfg()

	if curStageCfg == nil then
		printError("curStageCfg == nil")

		return
	end

	local chapterCfg = self._chapterList[self._selectTab][self._selectStage]

	if chapterCfg == nil then
		printError("chapterCfg == nil")

		return
	end

	local pass, perfectPass = ScenariocopyModel.instance:getStagePass(curStageCfg.chapterId, 1)

	self._txtTitle.text = ScenariocopyController.instance:getTrialName(chapterCfg)
	self._txtDes.text = curStageCfg.desc
	self._txtPassDes.text = curStageCfg.passDesc
	self._txtRecZDL.text = langPara("推荐战力%s", curStageCfg.recommendZdl)
	self._txtPerfetPassDes.text = curStageCfg.perfetPassDesc

	local matType, id, matNum = MaterialMgr.getMatParams(curStageCfg.energyConsume)

	self._txtTili.text = checknumber(matNum)

	local matCfg = MaterialMgr.getMatCfgByStr(curStageCfg.energyConsume)

	uGuiUtil.setSpriteToImage(self._iconTili, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(matCfg.icon))
	self._btnSweep.gameObject:SetActive(pass)

	if self._btnSweep.gameObject.activeSelf then
		Framework.TransformUtil.SetLocalPos(self._btnChallenge.transform, 476, -272.8, 0)
	else
		Framework.TransformUtil.SetLocalPos(self._btnChallenge.transform, 426, -272.8, 0)
	end

	self:_updateNormalPrizeScroll()
end

function SctrialView:_updateNormalPrizeScroll()
	local curStageCfg = self:_getCurStageCfg()

	if curStageCfg == nil then
		return
	end

	local rewardList = {}
	local pass, perfectPass = ScenariocopyModel.instance:getStagePass(curStageCfg.chapterId, 1)
	local rewardStr = MaterialMgr.changeItemStr(curStageCfg.firstReward)

	if not pass and not string.nilorempty(rewardStr) then
		local strArr = string.split(rewardStr, "#")

		for k, v in ipairs(strArr) do
			local single = {}

			single.reward = v
			single.rewardType = 0

			table.insert(rewardList, single)
		end
	end

	rewardStr = MaterialMgr.changeItemStr(curStageCfg.perfectReward)

	if not perfectPass and not string.nilorempty(rewardStr) then
		local strArr = string.split(rewardStr, "#")

		for k, v in ipairs(strArr) do
			local single = {}

			single.reward = v
			single.rewardType = 1

			table.insert(rewardList, single)
		end
	end

	rewardStr = MaterialMgr.changeItemStr(curStageCfg.comReward)

	if not string.nilorempty(rewardStr) then
		local strArr = string.split(rewardStr, "#")

		for k, v in ipairs(strArr) do
			local single = {}

			single.reward = v
			single.rewardType = 2

			table.insert(rewardList, single)
		end
	end

	self._tableviewNormalPrize:reloadData(rewardList)
	self._tableviewNormalPrize:refresh()
end

function SctrialView:_updateNormalPrizeCell(view, cell, data, tag)
	local icon = goutil.findChild(cell, "icon")
	local iconTag = goutil.findChild(cell, "tag")
	local ImageChange = iconTag:GetComponent(ComponentType.UIImageSpriteChange)

	MaterialMgr.setCellByCfg(data.reward, icon)
	ImageChange:SetState(data.rewardType)
	GameUtil.SetActive(iconTag, data.rewardType ~= 2)
end

function SctrialView:_clearNormalPrizeCell(cell)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.resetAll(icon)
end

function SctrialView:_updateChaptersScroll()
	self._chaptersScrollList:reloadData(self._trialPageCfg)
	self._chaptersScrollList:refresh()

	local maxIndex = self._chaptersScrollList:_numInView()

	index = math.min(self._selectTab, maxIndex)

	self._chaptersScrollList:MoveCellToCenter(index)
end

function SctrialView:_updateChaptersCell(view, cell, data, tag)
	local mainGo = cell
	local UIChangeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)
	local lockGo = goutil.findChild(mainGo, "lock")
	local txtLock = goutil.findChildTextComponent(mainGo, "lock/txtLock")
	local txt = goutil.findChildTextComponent(mainGo, "txt")
	local isSelected = data.id == self._selectTab

	UIChangeGroup:SetState(isSelected and 1 or 0)

	if txt then
		txt.text = data.examName
	end

	local stageData = self._stagesLockMap[data.id][1]
	local isLocked = stageData.state == -2

	GameUtil.SetActive(lockGo, isLocked)

	if isLocked then
		txtLock.text = stageData.tips
	end

	local handler = GameUtil.handler(self._onClickSwitch, self, data.id)

	GameUtil.addClickHandler(mainGo, handler)
end

function SctrialView:_clearChaptersCell(cell)
	local mainGo = cell

	GameUtil.rmClickHandler(mainGo)
end

function SctrialView:_updateStageReloadData()
	self._tableviewStage:reloadData(self._chapterList[self._selectTab])
	self._tableviewStage:refresh()
end

function SctrialView:_refreshCell()
	self._tableviewStage:refresh(self._chapterList[self._selectTab])
end

function SctrialView:_updateStageCell(view, cell, data, tag)
	local node = goutil.findChild(cell, "posNode/node")
	local btnClick = goutil.findChild(cell, "posNode/node/btnClick")
	local effectGo = goutil.findChild(cell, "posNode/node/effect")
	local sprtieChange = goutil.findChild(cell, "posNode/node/icons/connect"):GetComponent("UIImageSpriteChange")
	local connect = goutil.findChild(cell, "posNode/node/icons/connect")
	local iconChange = goutil.findChild(cell, "posNode/node/icons"):GetComponent("UIImageSpriteChange")
	local imgPerfect = goutil.findChild(cell, "posNode/imgPerfect")
	local index = cell.index
	local pos_index = index % 4
	local pos_x = CELL_POS[pos_index].x

	GameUtil.setAnchoredPos(node, pos_x, 0)
	GameUtil.setLocalScale(node, CELL_POS[pos_index].scaleX, 1, 1)

	local faceId = checknumber(data.stageCardRaceId)

	self._spineMgr:loadSpine(cell, faceId, false, self._onSpineLoadedFinish, self)

	local stageData = self._stagesLockMap[self._selectTab][index + 1]
	local curPass, curPerpass = ScenariocopyModel.instance:getStagePass(data.chapterId, 1)

	imgPerfect:SetActive(stageData.state == 1 or stageData.state == 2)
	GameUtil.setAnchoredPos(imgPerfect, pos_x + 100, 50)

	local function handler()
		if stageData.state < 0 then
			FloatWordMgr.instance:show(stageData.tips)
		else
			self._selectStage = index + 1

			self:_updateRightPlaneUI()
			self:_updateStageReloadData()
		end
	end

	GameUtil.addClickHandler(btnClick, handler)

	local isPassPreState = true

	if index > 0 then
		local preStageData = self._stagesLockMap[self._selectTab][index]

		isPassPreState = preStageData.state >= 0
	end

	if index == 0 then
		goutil.setActive(connect, false)
	else
		local isConnect = stageData.state >= 0

		sprtieChange:SetState(isConnect == true and 1 or 0)
		goutil.setActive(connect, true)
	end

	local chapterType = checknumber(data.chapterType)

	iconChange:SetState(chapterType % 3)

	if self._effectList[cell] then
		UIEffectManager.instance:stopEffect(self._effectList[cell])

		self._effectList[cell] = nil
	end

	if index + 1 == self._selectStage then
		self._effectList[cell] = UIEffectManager.instance:playEffect(self, "fx_ui_fuben/fx_ui_fuben_jiaozhan_clip.prefab", nil, 0, 0, true, nil, nil, function(self, uiEffect)
			uiEffect.hideEffWhileNotOnTop = false

			uiEffect:setScrollRectClipping(self._tableviewStage:getView():GetScrollRect())
		end, self)

		self._effectList[cell]:setParent(effectGo.transform)
		self._effectList[cell]:setLocalPos(0, 0, 0)
		self._effectList[cell]:setScale(0.8)
	end
end

function SctrialView:_clearStageCell(cell)
	local btnClick = goutil.findChildButtonComponent(cell, "posNode/node/btnClick")

	GameUtil.asBtn(btnClick):RemoveClickListener()
end

function SctrialView:_onSpineLoadedFinish(item)
	local cell = item.key
	local icon = goutil.findChild(cell.transform, "posNode/node/icons/icon")
	local goTf = item.go.transform

	goTf:SetParent(icon.transform)
	Framework.TransformUtil.SetLocalPos(goTf, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(goTf, 1, 1, 1)

	local shaderName = "Spine/SkeletonGraphic (Premultiply Alpha)"
	local r = goutil.findChildComponent(item.go, "skeleton", "SkeletonGraphic")

	if not goutil.isNil(r) and r.material ~= nil and r.material.shader ~= nil and r.material.shader.name ~= shaderName then
		local tempMat = UnityEngine.Material.New(Framework.ShaderCache.Find(shaderName))

		tempMat.mainTexture = r.material.mainTexture
		r.material = tempMat
	end
end

function SctrialView:_updateOrder()
	local cnt = self._uiTableStage:GetVisibleCount() - 1
	local maxIdx = -99999

	for i = 0, cnt do
		local cell = self._uiTableStage:GetCellByIndex(i)
		local index = cell.index

		if maxIdx < index then
			maxIdx = index
		end
	end

	for i = 0, cnt do
		local cell = self._uiTableStage:GetCellByIndex(i)
		local index = cell.index

		cell.transform:SetSiblingIndex(maxIdx - index)
	end
end

function SctrialView:_onReloadFinish()
	self._uiTableStage:MoveCellToCebter(self._selectStage)
end

function SctrialView:_stageCellSizeForindex(view, idx)
	if #self._chapterList[self._selectTab] == idx + 1 then
		return 100, 320
	end

	return 100, 100
end

function SctrialView:_updateBuffUI()
	local cfgs = ScenariocopyConfig.instance:getBuffCfg(self._trialCfg.buffPlanId)
	local level = ScenariocopyModel.instance:getBuffLevel()
	local buffCfg = cfgs[level]
	local des

	if buffCfg == nil then
		des = "未获得buff"
		buffCfg = cfgs[1]
	end

	if buffCfg and not string.nilorempty(buffCfg.selfBuff) then
		self._txtBuff.text = des or buffCfg.des

		if string.nilorempty(des) then
			-- block empty
		else
			self._txtBuff.text = des
		end

		local tempStr = string.split(buffCfg.selfBuff, ":")
		local buffId = tempStr[1]
		local buffIcon = BattleConfig.instance:getBuffCo(checknumber(buffId))

		uGuiUtil.setSpriteToImage(self._buffIcon, GameUrl.getExpEventUrl(buffIcon.icon))
		UIEffectManager.instance:stopEffect(self._buffEff)

		local hasGain = ScenariocopyModel.instance:getHasGainBuffPrize()

		if not hasGain and self._buffIcon then
			local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

			local function func(_, eff)
				eff:setClipping(self._buffIcon:GetComponent(goutil.Type_RectTransform))
				eff:setParent(self._buffIcon.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(0.65, 0.65, 0.65)
			end

			self._buffEff = UIEffectManager.instance:playEffect(self, effPath, self._buffIcon, 0, 0, true, false, nil, func, nil)
		end

		goutil.setActive(self._buffGo, true)
	else
		goutil.setActive(self._buffGo, false)
	end
end

function SctrialView:_handleBuffPrizeRes(status, msg)
	MaterialFacade.instance:popAndShowChangeSetItems(msg.changeSetId)
	ScenariocopyModel.instance:setHasGainBuffPrize(true)

	local trialId = ScenariocopyModel.instance:getTrialId()
	local trialCfg = ScenariocopyConfig.instance:getTrialCfg(trialId)
	local curLevel = ScenariocopyModel.instance:getBuffLevel()
	local cfgs = ScenariocopyConfig.instance:getBuffCfg(trialCfg.buffPlanId)
	local maxLevel = table.nums(cfgs)

	if curLevel < maxLevel then
		ScenariocopyModel.instance:setBuffLevel(curLevel + 1)
	end

	FloatWordMgr.instance:show(lang("成功领取每日BUFF~"))
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_SCENARIOCOPY_SCTRIAL_BUFF, false)
	self:_refresh()
end

function SctrialView:dailyRefresh()
	if not ScenariocopyModel.instance:refreshActIdandPlotId() then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动已结束"), GameUtil.handler(self.close, self))
	end
end

function SctrialView:_onClickSwitch(tabIndex)
	if self._selectTab == tabIndex then
		return
	end

	local stageData = self._stagesLockMap[tabIndex][1]

	if stageData.state < 0 then
		FloatWordMgr.instance:show(stageData.tips)

		return
	end

	self._selectTab = tabIndex

	self:_updateCurSelectTab(self._selectTab)
	self:_refresh()
end

function SctrialView:_onClickChallenge()
	local chapterCfg = self._chapterList[self._selectTab][self._selectStage]

	ScenariocopyModel.instance:setStageId(1)
	ScenariocopyModel.instance:setChapterCfg(chapterCfg)
	ScenariocopyModel.instance:setChapterId(chapterCfg.chapterId)

	local curStageCfg = ScenariocopyConfig.instance:getStageCfg(chapterCfg.chapterId, 1)

	if chapterCfg and curStageCfg then
		local params = self:getOpenParam()
		local viewname

		ScenariocopyController.instance:enterMissionOrStory(curStageCfg, (not string.nilorempty(params[2]) or nil) and params[2])
	end
end

function SctrialView:_clickBuff()
	local hasGain = ScenariocopyModel.instance:getHasGainBuffPrize()

	if hasGain then
		if self._trialCfg and self._trialCfg.buffPlanId then
			local buffPlanId = self._trialCfg.buffPlanId

			UIStateManager.instance:open(ViewName.ScbonusawardView, buffPlanId)
		else
			FloatWordMgr.instance:show("未配置buffPlanId！")
		end
	else
		local actId = ScenariocopyModel.instance:getActivityId()

		OperationPlotAgent.instance:sendPM_OperationPlotGainBuffPrizeReq(actId)
	end
end

function SctrialView:_clickTip()
	UIStateManager.instance:push(ViewName.RulesView, "trialofoperationscenario")
end

function SctrialView:_onClickSweep()
	local chapterCfg = self._chapterList[self._selectTab][self._selectStage]

	MopupModel.instance:cliclkOperationPlotSweep(chapterCfg.chapterId, 1)
end

return SctrialView
