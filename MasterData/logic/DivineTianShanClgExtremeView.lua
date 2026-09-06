-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/view/DivineTianShanClgExtremeView.lua

module("logic.extensions.divinetianshanclg.view.DivineTianShanClgExtremeView", package.seeall)

local DivineTianShanClgExtremeView = class("DivineTianShanClgExtremeView", ViewComponent)

function DivineTianShanClgExtremeView:ctor()
	DivineTianShanClgExtremeView.super.ctor(self)
end

function DivineTianShanClgExtremeView:unbindEvents()
	DivineTianShanClgExtremeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i, cell in ipairs(self._zoneList) do
		GameUtil.rmClickHandler(cell.go)
	end
end

function DivineTianShanClgExtremeView:bindEvents()
	DivineTianShanClgExtremeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i, cell in ipairs(self._zoneList) do
		GameUtil.addClickHandler(cell.go, GameUtil.handler(self._switchZoneById, self, i))
	end
end

function DivineTianShanClgExtremeView:buildUI()
	DivineTianShanClgExtremeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")

	local tableviewGo = self:getGo("stage/tableview")
	local cellGo = self:getGo("stage/cell")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._zoneList = {}

	for i = 1, 4 do
		local cell = {}

		cell.go = self:getGo("zones/zone_" .. i)
		cell.txt = goutil.findChildTextComponent(cell.go, "txt")
		cell.select = goutil.findChild(cell.go, "select")
		self._zoneList[i] = cell
	end

	self._petItem = self:getGo("petItem")
	self._txtTipsCol = self:getTxt("tipsCol/txt")
	self._powerPetMo = FightingPowerPetMo.New()
end

function DivineTianShanClgExtremeView:onExit()
	DivineTianShanClgExtremeView.super.onExit(self)
	self._tableview:dispose()

	self._subTabs = {}

	self:_setLastSelectZoneId()
end

function DivineTianShanClgExtremeView:onEnter()
	DivineTianShanClgExtremeView.super.onEnter(self)

	self._subTabs = {}
	self._activityId = checknumber(self:getFirstParam())

	self:_updateUIByCfg()
	self.addGEvent(self, GlobalNotify.DivineTianShanClgResetExtremeFight, self._handleResetFight, self)
	self.addGEvent(self, GlobalNotify.DivineTianShanClgGetInfo, self._handleInitInfo, self)
	DivineTianShanClgController.instance:getInfo(self._activityId)
	DivineTianShanClgController.instance:showCI()
end

function DivineTianShanClgExtremeView:_handleResetFight()
	self:_updateUIByInfo()
	self:_switchZoneById(self._curShowZoneId)
end

function DivineTianShanClgExtremeView:_handleInitInfo()
	self:_updateUIByInfo()

	self._curShowZoneId = self._curShowZoneId or self:_getLastSelectZoneId()

	self:_switchZoneById(self._curShowZoneId)
end

function DivineTianShanClgExtremeView:_updateUIByCfg()
	self._actCfg = DivineTianShanClgConfig.instance:getActCfgById(self._activityId)
	self._stageDescCfgs = DivineTianShanClgConfig.instance:getExtremeStageDescCfgs(self._actCfg.stagePlanId)
end

function DivineTianShanClgExtremeView:_updateUIByInfo()
	self._stageInfoMap = DivineTianShanClgModel.instance:getExtremeStageMap(self._activityId)

	for i, cell in ipairs(self._zoneList) do
		local cfgs = DivineTianShanClgConfig.instance:getExtremeStageCfgsByPhaseId(self._actCfg.stagePlanId, i) or {}
		local curNum = 0

		for _, cfg in ipairs(cfgs) do
			local stageInfo = self._stageInfoMap[cfg.stageId]

			if stageInfo then
				curNum = curNum + stageInfo.effectTimes
			end
		end

		cell.txt.text = langPara("领域技能:%s", curNum)
	end
end

function DivineTianShanClgExtremeView:_switchZoneById(zoneId)
	self._curShowZoneId = zoneId

	for i, cell in ipairs(self._zoneList) do
		goutil.setActive(cell.select, i == self._curShowZoneId)
	end

	local cfgs = DivineTianShanClgConfig.instance:getExtremeStageCfgsByPhaseId(self._actCfg.stagePlanId, self._curShowZoneId) or {}

	self._tableview:reloadData(cfgs)

	self._txtTipsCol.text = self._stageDescCfgs[self._curShowZoneId].stageDesc
end

function DivineTianShanClgExtremeView:_updateCell(view, cell, data)
	local btnEnter = goutil.findChild(cell.gameObject, "btnEnter")
	local btnReset = goutil.findChild(cell.gameObject, "btnReset")
	local emptyTips = goutil.findChild(cell.gameObject, "tips/emptyTips")
	local pass = goutil.findChild(cell.gameObject, "pass")
	local info = self._stageInfoMap[data.stageId]
	local creepsMasterId = data.creepsMasterId
	local txtNumTips = goutil.findChildTextComponent(cell.gameObject, "numTips/txt")

	goutil.setActive(btnEnter, not info.isPass)
	goutil.setActive(btnReset, info.isPass)
	goutil.setActive(pass, info.isPass)

	local fmtView = goutil.findChild(cell.gameObject, "fmt/fmtView")

	for posId = 1, fmtView.transform.childCount do
		local fmtCellGo = fmtView.transform:GetChild(posId - 1)
		local fmtIcon = goutil.findChild(fmtCellGo, "icon")

		MaterialMgr.resetAll(fmtIcon)
	end

	local creepCfgs = DivineTianShanClgConfig.instance:getCreepCfgs(creepsMasterId) or {}

	for _, cfg in pairs(creepCfgs) do
		local posId = cfg.posId

		if posId < 1 or posId > 9 then
			-- block empty
		else
			local fmtCellGo = fmtView.transform:GetChild(posId - 1)

			if fmtCellGo then
				local fmtIcon = goutil.findChild(fmtCellGo, "icon")
				local skinId = checknumber(cfg.faceId)

				if skinId == 0 then
					skinId = cfg.raceId
				end

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
	GameUtil.addClickHandler(btnReset, GameUtil.handler(self._onClickReset, self, data))

	if info then
		if not info.effectTimes then
			local num = 0

			txtNumTips.text = langPara("领域技能:%s", num)

			if info then
				if not info.lockRaceIds then
					local lockedPetIds = {}

					goutil.setActive(emptyTips, #lockedPetIds <= 0)

					local subTab = self._subTabs[cell.gameObject]

					if not subTab then
						local petCom = goutil.findChild(cell.gameObject, "tips/Scrollerview")

						subTab = ScrollerList.create(petCom, self._petItem, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

						subTab:setCenterMode(true)

						self._subTabs[cell.gameObject] = subTab
					end

					subTab:reloadData(lockedPetIds)
					subTab:MoveCellToBegin(0)
				end
			end
		end
	end
end

function DivineTianShanClgExtremeView:_clearCell(cell)
	local fmtView = goutil.findChild(cell.gameObject, "fmt/fmtView")

	for posId = 1, fmtView.transform.childCount do
		local fmtCellGo = fmtView.transform:GetChild(posId - 1)
		local fmtIcon = goutil.findChild(fmtCellGo, "icon")

		MaterialMgr.resetAll(fmtIcon)
	end

	local btnEnter = goutil.findChild(cell.gameObject, "btnEnter")
	local btnReset = goutil.findChild(cell.gameObject, "btnReset")

	GameUtil.rmClickHandler(btnEnter)
	GameUtil.rmClickHandler(btnReset)

	local subTab = self._subTabs[cell.gameObject]

	if subTab then
		subTab:dispose()
	end
end

function DivineTianShanClgExtremeView:_updatePetCell(view, cell, data)
	local proxy = MaterialMgr.setCell(MatType.Pet, data, cell.gameObject)

	if proxy then
		proxy.binder:setAutoTips(false)

		local tmpMo = FightingPowerPetMo.createPetByLevel(data, 1, 0, data)

		proxy:setCallBack(function()
			CommonTipsMgr.instance:showPetTips(tmpMo, true)
		end)
	end
end

function DivineTianShanClgExtremeView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function DivineTianShanClgExtremeView:_onClickEnter(data)
	DivineTianShanClgController.instance:openExtremeMissionView(self._activityId, data.stageId)
end

function DivineTianShanClgExtremeView:_onClickReset(data)
	TipsFacade.instance:openPopupWindow("提示", "是否重置该关卡?", function()
		DivineTianShanClgController.instance:resetExtremeFight(self._activityId, data.stageId)
	end)
end

function DivineTianShanClgExtremeView:_getLastSelectZoneId()
	local userDataKey = string.format("%s_last_zoneId_%s", ViewName.DivineTianShanClgExtremeView, self._activityId)
	local keepValue = checknumber(GameUtil.getUserData(userDataKey))

	if keepValue <= 0 then
		return 1
	else
		return keepValue
	end
end

function DivineTianShanClgExtremeView:_setLastSelectZoneId()
	local userDataKey = string.format("%s_last_zoneId_%s", ViewName.DivineTianShanClgExtremeView, self._activityId)

	GameUtil.saveUserData(userDataKey, self._curShowZoneId)
end

return DivineTianShanClgExtremeView
