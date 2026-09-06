-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinechenclg/view/DivineChenClgExtremeView.lua

module("logic.extensions.divinechenclg.view.DivineChenClgExtremeView", package.seeall)

local DivineChenClgExtremeView = class("DivineChenClgExtremeView", ViewComponent)

function DivineChenClgExtremeView:ctor()
	DivineChenClgExtremeView.super.ctor(self)
end

function DivineChenClgExtremeView:unbindEvents()
	DivineChenClgExtremeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnReset)

	for i, cell in ipairs(self._stageCellList) do
		GameUtil.rmClickHandler(cell.btnSelect)
	end
end

function DivineChenClgExtremeView:bindEvents()
	DivineChenClgExtremeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)

	for i, cell in ipairs(self._stageCellList) do
		GameUtil.addClickHandler(cell.btnSelect, GameUtil.handler(self._onClickSelect, self, i))
	end
end

function DivineChenClgExtremeView:buildUI()
	DivineChenClgExtremeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnEnter = self:getGo("right/btnEnter")
	self._btnReset = self:getGo("right/btnReset")
	self._txtBuff = self:getTxt("right/txtBuff")
	self._txtTarget = self:getTxt("right/txtTarget")
	self._emptyTips = self:getGo("right/emptyTips")

	local petTabGo = self:getGo("right/Scrollerview")
	local petItemGo = self:getGo("right/petItem")

	self._tableviewPet = ScrollerList.create(petTabGo, petItemGo, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._tableviewPet:setCenterMode(true)

	local descTabGo = self:getGo("right/desc/buffTableview")
	local descItemGo = self:getGo("right/desc/cell")

	self._tableviewDesc = ScrollerList.create(descTabGo, descItemGo, GameUtil.handler(self._updateDescCell, self), GameUtil.handler(self._clearDescCell, self))
	self._stageCellList = {}

	for i = 1, 6 do
		local cell = {}

		cell.go = self:getGo("stageList/stage_" .. i)
		cell.select = goutil.findChild(cell.go, "select")
		cell.icon = goutil.findChild(cell.go, "icon")
		cell.pass = goutil.findChild(cell.go, "pass")
		cell.btnSelect = goutil.findChild(cell.go, "btnSelect")
		cell.txt = goutil.findChildTextComponent(cell.go, "txt")
		self._stageCellList[i] = cell
	end
end

function DivineChenClgExtremeView:onExit()
	DivineChenClgExtremeView.super.onExit(self)
	self._tableviewPet:dispose()
	self._tableviewDesc:dispose()

	for i, cell in ipairs(self._stageCellList) do
		MaterialMgr.resetAll(cell.icon)
	end
end

function DivineChenClgExtremeView:onEnter()
	DivineChenClgExtremeView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self.curScId = 0

	self:_updateUIByCfg()
	self.addGEvent(self, GlobalNotify.DivineChenClgGetExtremeInfoRes, self._updateUIByExtremeInfo, self)
	self.addGEvent(self, GlobalNotify.DivineChenClgExtremeResetStageRes, self._updateUIByExtremeInfo, self)
	DivineChenClgController.instance:getExtremeInfo(self._activityId)
	DivineChenClgController.instance:showCI()
end

function DivineChenClgExtremeView:_updateUIByCfg()
	self._actCfg = DivineChenClgConfig.instance:getActCfg(self._activityId)
	self._extremeStageCfgs = DivineChenClgConfig.instance:getExtremeStageCfgs(self._activityId)

	for i, cell in ipairs(self._stageCellList) do
		local cfg = self._extremeStageCfgs[i]

		if cfg then
			goutil.setActive(cell.go, true)
			MaterialMgr.setIcon(cell.icon, MatType.PET_SKIN, cfg.showRoleId)

			cell.txt.text = string.format("超杀：%s", cfg.passLimit)
		else
			goutil.setActive(cell.go, false)
		end
	end
end

function DivineChenClgExtremeView:_updateUIByExtremeInfo()
	local extremeInfo = DivineChenClgModel.instance:getExtremeInfoByActId(self._activityId)

	self._curStageDataList = {}

	for i, cfg in ipairs(self._extremeStageCfgs) do
		local data = {}

		data.info = nil
		data.stageId = i
		self._curStageDataList[i] = data
	end

	if extremeInfo then
		if not extremeInfo.passStages then
			for i, info in ipairs(extremeInfo.passStages) do
				local data = self._curStageDataList[info.stageId]

				if data then
					data.info = info
				else
					printError("关卡数据空配置：" .. info.stageId)
				end
			end
		end
	end

	for i, cell in ipairs(self._stageCellList) do
		local data = self._curStageDataList[i]
		local info = data.info

		if not data.info and self.curScId == 0 then
			self.curScId = i
		end

		goutil.setActive(cell.pass, info)
	end

	if self.curScId == 0 then
		self.curScId = 1
	end

	self:_updateRight()
end

function DivineChenClgExtremeView:_updateRight()
	for i, cell in ipairs(self._stageCellList) do
		goutil.setActive(cell.select, i == self.curScId)
	end

	local data = self._curStageDataList[self.curScId]
	local cfg = self._extremeStageCfgs[self.curScId]
	local info = data.info

	self._txtBuff.text = cfg.enemyBuffDesc
	self._txtTarget.text = cfg.targetDesc

	local curBuffDescCfgs = DivineChenClgConfig.instance:getBuffDescCfgs(cfg.selfBuffDesc)

	if info then
		if not info.lockedPetIds then
			local lockPetRaceIds = {}
			local showPetIds = {}

			for i, petId in ipairs(lockPetRaceIds) do
				if petId > 0 then
					table.insert(showPetIds, petId)
				end
			end

			self._tableviewPet:reloadData(lockPetRaceIds)
			self._tableviewPet:MoveCellToBegin(0)
			goutil.setActive(self._emptyTips, #lockPetRaceIds <= 0)
			goutil.setActive(self._btnEnter, not info)
			goutil.setActive(self._btnReset, info)
			self._tableviewDesc:reloadData(curBuffDescCfgs)
			self._tableviewDesc:MoveCellToBegin(0)
		end
	end
end

function DivineChenClgExtremeView:_onClickEnter()
	local cfg = self._extremeStageCfgs[self.curScId]

	DivineChenClgController.instance:openExtremeMissionView(self._activityId, cfg.stageId, cfg.creepsMasterId)
end

function DivineChenClgExtremeView:_onClickReset()
	TipsFacade.instance:openPopupWindow("提示", "是否重置该关卡?", function()
		DivineChenClgController.instance:extremerResetStage(self._activityId, self.curScId)
	end)
end

function DivineChenClgExtremeView:_onClickSelect(scId)
	self.curScId = scId

	self:_updateRight()
end

function DivineChenClgExtremeView:_updatePetCell(view, cell, data)
	local mo = BagPetsController.instance:getPet(data)

	MaterialMgr.setCell(MatType.Pet, mo.raceId, cell.gameObject)
end

function DivineChenClgExtremeView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function DivineChenClgExtremeView:_updateDescCell(view, cell, data)
	local bg = goutil.findChild(cell.gameObject, "bg")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtdesc")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")

	txtDesc.text = data.showDesc
	txtNum.text = data.zoneDesc

	goutil.setActive(bg, data.sortId % 2 == 1)
end

function DivineChenClgExtremeView:_clearDescCell(cell)
	return
end

return DivineChenClgExtremeView
