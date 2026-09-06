-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhuociyuan/view/OriginhuociyuanchallengeView.lua

module("logic.extensions.originhuociyuan.view.OriginhuociyuanchallengeView", package.seeall)

local OriginhuociyuanchallengeView = class("OriginhuociyuanchallengeView", ViewComponent)

function OriginhuociyuanchallengeView:unbindEvents()
	OriginhuociyuanchallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnReset)

	for i, cell in ipairs(self._stageCellList) do
		GameUtil.rmClickHandler(cell.btnSelect)
	end
end

function OriginhuociyuanchallengeView:bindEvents()
	OriginhuociyuanchallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)

	for i, cell in ipairs(self._stageCellList) do
		GameUtil.addClickHandler(cell.btnSelect, GameUtil.handler(self._onClickSelect, self, i))
	end
end

function OriginhuociyuanchallengeView:buildUI()
	OriginhuociyuanchallengeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnEnter = self:getGo("right/btnEnter")
	self._btnReset = self:getGo("right/btnReset")
	self._txtBuff = self:getTxt("right/txtBuff")
	self._txtTarget = self:getTxt("right/txtTarget")
	self._emptyTips = self:getGo("right/emptyTips")
	self._txtDesc = self:getTxt("right/txtDesc")
	self._tableview = self:getGo("right/tableview")
	self._tablecell = self:getGo("right/tableview/tablecell")
	self._tableviewPet = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._tableviewPet:setCenterMode(true)

	local descTabGo = self:getGo("right/desc/buffTableview")
	local descItemGo = self:getGo("right/desc/cell")

	self._tableviewDesc = ScrollerList.create(descTabGo, descItemGo, GameUtil.handler(self._updateDescCell, self), GameUtil.handler(self._clearDescCell, self))
	self._stageList = self:getGo("stageList")

	local childCount = self._stageList.transform.childCount

	self._stageCellList = {}

	for i = 1, childCount do
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

function OriginhuociyuanchallengeView:onExit()
	OriginhuociyuanchallengeView.super.onExit(self)
	self._tableviewPet:dispose()
	self._tableviewDesc:dispose()

	for i, cell in ipairs(self._stageCellList) do
		MaterialMgr.resetAll(cell.icon)
	end
end

function OriginhuociyuanchallengeView:onEnter()
	OriginhuociyuanchallengeView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 560001
	end

	self.addGEvent(self, GlobalNotify.ORIGIN_HUOCIYUAN_INFO_UPDATE, self._refreshUI, self)
	OriginHuociyuanController.instance:sendGetInfo(self._activityId)
	self:_refreshUI()
	OriginHuociyuanController.instance:showCI()
end

function OriginhuociyuanchallengeView:_refreshUI()
	self._actCfg = OriginHuociyuanConfig.instance:getActCfgById(self._activityId)

	self:_updateUIByExtremeInfo()
end

function OriginhuociyuanchallengeView:_updateUIByExtremeInfo()
	local info = OriginHuociyuanModel.instance:getInfo(self._activityId) or {}

	if not info.stageInfos then
		local stageInfos = {}

		self._curStageDataMap = {}
		self._lockRaceIdList = {}

		for i, v in ipairs(stageInfos) do
			self._curStageDataMap[v.stageId] = v

			if not v.lockRaceIds then
				for j, raceId in ipairs(v.lockRaceIds) do
					table.insert(self._lockRaceIdList, raceId)
				end
			end
		end

		self._totalAlivePetIds = #self._lockRaceIdList

		local stageList = OriginHuociyuanConfig.instance:getStageListCfgById(self._activityId) or {}
		local idx = OriginHuociyuanController.instance:getLastIdx()
		local notPassIdx = -1

		for i, cell in ipairs(self._stageCellList) do
			local cfg = stageList[i]

			GameUtil.SetActive(cell.go, cfg ~= nil)

			if cfg then
				local data = self._curStageDataMap[cfg.stageId]

				if data == nil and notPassIdx < 0 then
					notPassIdx = i
				end

				local creeps = OriginHuociyuanConfig.instance:getCreepsById(cfg.creepsMasterId) or {}
				local raceId = 0

				if creeps[1] then
					raceId = creeps[1].raceId
				else
					for _, cc in pairs(creeps) do
						raceId = cc.raceId

						break
					end
				end

				MaterialMgr.setIcon(cell.icon, MatType.PET_SKIN, raceId)

				cell.txt.text = langPara("存活目标：%s", cfg.alivePetNum)

				GameUtil.SetActive(cell.pass, data ~= nil)
				GameUtil.SetActive(cell.select, false)
				GameUtil.addClickHandler(cell.btnSelect, GameUtil.handler(self._onClickSelect, self, i))
			end
		end

		if idx > 0 then
			if self._curStageDataMap[idx] then
				if notPassIdx < 0 then
					notPassIdx = idx
				end
			else
				notPassIdx = idx
			end
		elseif notPassIdx < 0 then
			notPassIdx = 1
		end

		self._curSelectIdx = notPassIdx

		OriginHuociyuanController.instance:setLastIdx(notPassIdx)
		self:_updateRight()
	end
end

function OriginhuociyuanchallengeView:_updateRight()
	for i, cell in ipairs(self._stageCellList) do
		goutil.setActive(cell.select, i == self._curSelectIdx)
	end

	local stageList = OriginHuociyuanConfig.instance:getStageListCfgById(self._activityId) or {}

	if not stageList[self._curSelectIdx] then
		local cfg = {}

		self._txtTarget.text = cfg.targetDesc
		self._txtBuff.text = langPara(cfg.enemyBuffDesc or "", self._totalAlivePetIds)
		self._buffCellIdx = 0

		local curBuffDescCfgs = OriginHuociyuanConfig.instance:getEnemyBuffCfgById(self._activityId) or {}
		local buffList = {}

		for k, v in pairs(curBuffDescCfgs) do
			table.insert(buffList, v)
		end

		ArraySort.sortOn(buffList, "range", ArraySort.NUMERIC)

		for i, v in ipairs(buffList) do
			if self._totalAlivePetIds >= v.range then
				self._buffCellIdx = i - 1
			end
		end

		self._tableviewDesc:reloadData(buffList)
		self._tableviewDesc:MoveCellToBegin(self._buffCellIdx)

		local info = self._curStageDataMap[cfg.stageId]
		local lockPetRaceIds = {}

		if info then
			lockPetRaceIds = info.lockRaceIds or {}
		end

		self._tableviewPet:reloadData(lockPetRaceIds)
		self._tableviewPet:MoveCellToBegin(0)
		goutil.setActive(self._emptyTips, #lockPetRaceIds <= 0)
		goutil.setActive(self._btnEnter, not info)
		goutil.setActive(self._btnReset, info)
	end
end

function OriginhuociyuanchallengeView:_onClickEnter()
	local stageList = OriginHuociyuanConfig.instance:getStageListCfgById(self._activityId) or {}
	local cfg = stageList[self._curSelectIdx]

	if cfg then
		OriginHuociyuanController.instance:openFmtView(self._activityId, cfg.stageId, ViewName.OriginhuociyuanextView, ViewName.OriginhuociyuanresultView)
	end
end

function OriginhuociyuanchallengeView:_onClickReset()
	TipsFacade.instance:openPopupWindow("提示", "是否重置该关卡?", function()
		local stageList = OriginHuociyuanConfig.instance:getStageListCfgById(self._activityId) or {}
		local cfg = stageList[self._curSelectIdx]

		if cfg then
			OriginHuociyuanController.instance:sendResetFight(self._activityId, cfg.stageId)
		end
	end)
end

function OriginhuociyuanchallengeView:_onClickSelect(scId)
	self._curSelectIdx = scId

	OriginHuociyuanController.instance:setLastIdx(self._curSelectIdx)
	self:_updateRight()
end

function OriginhuociyuanchallengeView:_updatePetCell(view, cell, raceId)
	MaterialMgr.setCell(MatType.Pet, raceId, cell.gameObject)
end

function OriginhuociyuanchallengeView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function OriginhuociyuanchallengeView:_updateDescCell(view, cell, data)
	local bg = goutil.findChild(cell.gameObject, "bg")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtdesc")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")
	local imgCur = goutil.findChild(cell.gameObject, "imgCur")

	txtNum.text = data.zoneDesc
	txtDesc.text = data.showDesc

	goutil.setActive(bg, cell.index % 2 == 1)

	local list = self._tableviewDesc:getData()
	local r1 = list[cell.data].range

	if list[cell.data + 1] then
		local r2 = list[cell.data + 1].range

		GameUtil.SetActive(imgCur, r1 <= self._totalAlivePetIds and r2 > self._totalAlivePetIds)
	else
		GameUtil.SetActive(imgCur, r1 <= self._totalAlivePetIds)
	end
end

function OriginhuociyuanchallengeView:_clearDescCell(cell)
	return
end

return OriginhuociyuanchallengeView
