-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yinzhiclg/view/YinZhiClgStageView.lua

module("logic.extensions.yinzhiclg.view.YinZhiClgStageView", package.seeall)

local YinZhiClgStageView = class("YinZhiClgStageView", ViewComponent)

function YinZhiClgStageView:ctor()
	YinZhiClgStageView.super.ctor(self)
end

function YinZhiClgStageView:unbindEvents()
	YinZhiClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function YinZhiClgStageView:bindEvents()
	YinZhiClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function YinZhiClgStageView:buildUI()
	YinZhiClgStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")

	local tableviewGo = self:getGo("stage/tableview")
	local cellGo = self:getGo("stage/cell")

	self._tableviewStage = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updatCellStage, self), GameUtil.handler(self._clearCellStage, self))

	local tableviewGoPhase = self:getGo("phase/tableview")
	local cellGoPhase = self:getGo("phase/cell")

	self._tableviewPhase = ScrollerList.create(tableviewGoPhase, cellGoPhase, GameUtil.handler(self._updatCellPhase, self), GameUtil.handler(self._clearCellPhase, self))
	self._powerPetMo = FightingPowerPetMo.New()
	self._subcell = self:getGo("stage/subcell")
	self._gain = self:getGo("tipsCol/gain")
	self._prizeItem = self:getGo("tipsCol/prizeItem")
	self._txtTipsTitle2 = self:getTxt("tipsCol/tipsTitle2/txt")
	self._showItemsCellList = {}

	for i = 1, 7 do
		local cell = {}

		cell.go = self:getGo("tipsCol/showItems/showItem_" .. i)
		cell.attr = goutil.findChildComponent(cell.go, "attr", "UIImageSpriteChange")
		cell.txt = goutil.findChildTextComponent(cell.go, "txt")
		self._showItemsCellList[i] = cell
	end
end

function YinZhiClgStageView:onExit()
	YinZhiClgStageView.super.onExit(self)
	self._tableviewStage:dispose()
	self._tableviewPhase:dispose()

	self._subTabs = {}

	MaterialMgr.resetAll(self._prizeItem)
end

function YinZhiClgStageView:onEnter()
	YinZhiClgStageView.super.onEnter(self)

	self._subTabs = {}
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 486001
	end

	self.addGEvent(self, GlobalNotify.YinZhiClgGetInfo, self._updateUIByInfo, self)
	self:_updateUIByCfg()
	YinZhiClgController.instance:getInfo(self._activityId)
	YinZhiClgController.instance:showCI()
end

function YinZhiClgStageView:_updateUIByCfg()
	self._actCfg = YinZhiClgConfig.instance:getActCfgById(self._activityId)
	self._phaseCfgs = YinZhiClgConfig.instance:getPhaseCfgsById(self._activityId)
end

function YinZhiClgStageView:_updateUIByInfo()
	local info = YinZhiClgModel.instance:getBaseInfo(self._activityId)

	self._stageInfoMap = {}
	self._showItemInfoMap = {}

	if not info.stages then
		local curNum = 0

		for i, stageInfo in ipairs(info.stages) do
			self._stageInfoMap[stageInfo.stageId] = stageInfo.attributes

			for k, attributeInfo in ipairs(stageInfo.attributes) do
				curNum = self._showItemInfoMap[attributeInfo.attributeId] or 0
				curNum = curNum + attributeInfo.num
				self._showItemInfoMap[attributeInfo.attributeId] = curNum
			end
		end

		self._curMinNum = nil

		for i = 1, #self._showItemsCellList do
			if not self._showItemInfoMap[i] then
				local num = 0

				self._curMinNum = self._curMinNum and Mathf.Min(self._curMinNum, num) or num
			end
		end

		goutil.setActive(self._gain, false)

		local curFirstPassPhaseId = YinZhiClgController.instance:getFirstPassPhaseId(self._activityId)

		self._isPassLastPhase = false

		if curFirstPassPhaseId >= #self._phaseCfgs then
			goutil.setActive(self._gain, true)

			self._isPassLastPhase = true
		end

		self._curPhaseId = info.phaseId + 1
		self._curPhaseId = Mathf.Min(self._curPhaseId, #self._phaseCfgs)

		self._tableviewPhase:reloadData(self._phaseCfgs)
		self._tableviewPhase:MoveCellToBegin(self._curPhaseId - 1)

		local stageCfgs = YinZhiClgConfig.instance:getStageCfgs(self._activityId, self._curPhaseId) or {}

		self._tableviewStage:reloadData(stageCfgs)
		self._tableviewPhase:MoveCellToBegin(0)

		local phaseCfg = self._phaseCfgs[self._curPhaseId]

		if phaseCfg then
			if not phaseCfg.targetValue then
				local targetValue = 0
				local colorGreen = "#73fca6ff"
				local colorRed = "#eb4642ff"

				self._txtTipsTitle2.text = string.format("共鸣目标：%s(<color=%s>%s</color>/%s)", targetValue, targetValue > self._curMinNum and colorRed or colorGreen, self._curMinNum, targetValue)

				for i, cell in ipairs(self._showItemsCellList) do
					cell.attr:SetState(i - 1)

					if not self._showItemInfoMap[i] then
						cell.txt.text = string.format("X %s", self._showItemInfoMap[i])
					end
				end

				MaterialMgr.setCellByCfg(phaseCfg.prize, self._prizeItem)
			end
		end
	end
end

function YinZhiClgStageView:_updatCellPhase(view, cell, data)
	local bg = goutil.findChild(cell.gameObject, "bg")
	local pass = goutil.findChild(cell.gameObject, "pass")
	local select = goutil.findChild(cell.gameObject, "select")
	local lock = goutil.findChild(cell.gameObject, "lock")
	local txtPhase = goutil.findChildTextComponent(cell.gameObject, "txt")
	local btn = goutil.findChild(cell.gameObject, "btn")

	goutil.setActive(pass, data.phaseId < self._curPhaseId)

	if self._isPassLastPhase then
		goutil.setActive(pass, true)
	end

	goutil.setActive(lock, data.phaseId > self._curPhaseId)
	goutil.setActive(select, data.phaseId == self._curPhaseId)
	goutil.setActive(bg, data.phaseId ~= self._curPhaseId)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickPhase, self, data))

	txtPhase.text = string.format("第<size=36>%s</size>层", data.phaseId)
end

function YinZhiClgStageView:_clearCellPhase(cell)
	local btn = goutil.findChild(cell.gameObject, "btn")

	GameUtil.rmClickHandler(btn)
end

function YinZhiClgStageView:_updatCellStage(view, cell, data)
	local btnEnter = goutil.findChild(cell.gameObject, "btnEnter")
	local emptyTips = goutil.findChild(cell.gameObject, "tips/emptyTips")
	local pass = goutil.findChild(cell.gameObject, "pass")
	local creepsMasterId = data.creepsMasterId
	local info = self._stageInfoMap[data.stageId]

	goutil.setActive(pass, info)

	local fmtView = goutil.findChild(cell.gameObject, "fmt/fmtView")

	for posId = 1, fmtView.transform.childCount do
		local fmtCellGo = fmtView.transform:GetChild(posId - 1)
		local fmtIcon = goutil.findChild(fmtCellGo, "icon")

		MaterialMgr.resetAll(fmtIcon)
	end

	local creepCfgs = YinZhiClgConfig.instance:getCreepCfgs(creepsMasterId) or {}

	for _, cfg in pairs(creepCfgs) do
		local posId = cfg.posId

		if posId < 1 or posId > 9 then
			-- block empty
		else
			local fmtCellGo = fmtView.transform:GetChild(posId - 1)

			if fmtCellGo then
				local fmtIcon = goutil.findChild(fmtCellGo, "icon")

				self._powerPetMo:fromChallengeCreepCo(cfg)

				local bagPetMo = self._powerPetMo:toBaseBagPetMo()
				local proxy = MaterialMgr.setCellByMo(bagPetMo, fmtIcon)

				if proxy then
					proxy.binder:setAutoTips(false)
					proxy:setCallBack(function()
						CommonTipsMgr.instance:showPetTips(bagPetMo)
					end)
				end
			end
		end
	end

	GameUtil.addClickHandler(btnEnter, GameUtil.handler(self._onClickEnter, self, data))

	local showItems = info or {}

	goutil.setActive(emptyTips, #showItems <= 0)

	local subTab = self._subTabs[cell.gameObject]

	if not subTab then
		local petCom = goutil.findChild(cell.gameObject, "tips/Scrollerview")

		subTab = ScrollerList.create(petCom, self._subcell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		subTab:setCenterMode(true)

		self._subTabs[cell.gameObject] = subTab
	end

	subTab:reloadData(showItems)
	subTab:MoveCellToBegin(0)
end

function YinZhiClgStageView:_clearCellStage(cell)
	local fmtView = goutil.findChild(cell.gameObject, "fmt/fmtView")

	for posId = 1, fmtView.transform.childCount do
		local fmtCellGo = fmtView.transform:GetChild(posId - 1)
		local fmtIcon = goutil.findChild(fmtCellGo, "icon")

		MaterialMgr.resetAll(fmtIcon)
	end

	local btnEnter = goutil.findChild(cell.gameObject, "btnEnter")

	GameUtil.rmClickHandler(btnEnter)

	local subTab = self._subTabs[cell.gameObject]

	if subTab then
		subTab:dispose()
	end
end

function YinZhiClgStageView:_updateItemCell(view, cell, data)
	local attr = goutil.findChildComponent(cell.gameObject, "attr", "UIImageSpriteChange")
	local txt = goutil.findChildTextComponent(cell.gameObject, "txt")

	attr:SetState(data.attributeId - 1)

	txt.text = string.format("X %s", data.num)
end

function YinZhiClgStageView:_clearItemCell(cell)
	return
end

function YinZhiClgStageView:_onClickEnter(cfg)
	YinZhiClgController.instance:openMissionview(self._activityId, cfg.phaseId, cfg.stageId, ViewName.YinZhiClgResultView)
end

function YinZhiClgStageView:_onClickPhase(cfg)
	if self._curPhaseId > cfg.phaseId then
		TipsFacade.instance:openCommonTips("已通关")

		return
	end

	if self._curPhaseId < cfg.phaseId then
		TipsFacade.instance:openCommonTips("请通关上一关")

		return
	end
end

return YinZhiClgStageView
