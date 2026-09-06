-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindishitian/view/OriginDiShiTianStageView.lua

module("logic.extensions.origindishitian.view.OriginDiShiTianStageView", package.seeall)

local OriginDiShiTianStageView = class("OriginDiShiTianStageView", ViewComponent)

function OriginDiShiTianStageView:ctor()
	OriginDiShiTianStageView.super.ctor(self)
end

function OriginDiShiTianStageView:unbindEvents()
	OriginDiShiTianStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
end

function OriginDiShiTianStageView:bindEvents()
	OriginDiShiTianStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
end

function OriginDiShiTianStageView:buildUI()
	OriginDiShiTianStageView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnReset = self:getGo("btnReset")
	self._stageTableView = self:getGo("stageTableView")
	self._stageTableCell = self:getGo("stageTableCell")
	self._stageTableList = ScrollerList.create(self._stageTableView, self._stageTableCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._prizeTablecell = self:getGo("prizeTableview/prizeTablecell")
	self._prizeTableview = self:getGo("prizeTableview")
	self._prizeTableList = ScrollerList.create(self._prizeTableview, self._prizeTablecell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._petTableview = self:getGo("petTableview")
	self._petTablecell = self:getGo("petTableview/petTablecell")
	self._petTableList = ScrollerList.create(self._petTableview, self._petTablecell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function OriginDiShiTianStageView:onExit()
	OriginDiShiTianStageView.super.onExit(self)
end

function OriginDiShiTianStageView:onEnter()
	OriginDiShiTianStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginDiShiTianInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	self:_refreshView()

	local moveStageId = math.max(self._curStageId - 1, 0)

	self._stageTableList:MoveCellToCenter(moveStageId)

	if OriginDiShiTianModel.instance:getTempPrizeChangeSet() then
		MaterialController.instance:showChangeSetInTemp(OriginDiShiTianModel.instance:getTempPrizeChangeSet())
		OriginDiShiTianModel.instance:saveTempPrizeChangeSet(nil)
	end
end

function OriginDiShiTianStageView:_refreshView()
	self._curStageId = OriginDiShiTianModel.instance:getCurStageId(self._activityId)

	local stageList = OriginDiShiTianConfig.instance:getStageCfgs(self._activityId)

	self._stageTableList:reloadData(stageList)

	local prizeList = {}

	for i, v in ipairs(stageList) do
		table.insert(prizeList, v.prize)
	end

	local prizeArray = MaterialMgr.combineItemsToList(prizeList)

	self._prizeTableList:reloadData(prizeArray)

	local lockPetList = OriginDiShiTianModel.instance:getLockPetList(self._activityId)

	self._petTableList:reloadData(lockPetList)
end

function OriginDiShiTianStageView:_updateStageCell(view, cell, data, tag)
	local go = cell.gameObject
	local teamEnemy = goutil.findChild(go, "teamEnemy")
	local enemyCellMap = {}

	for i = 1, 9 do
		local enemyCell = {}

		enemyCell.cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		enemyCell.con = goutil.findChild(enemyCell.cellGo, "icon")
		enemyCell.blueBuff = goutil.findChild(enemyCell.cellGo, "layout/blueBuff")
		enemyCell.txtBlueBuff = goutil.findChild(enemyCell.cellGo, "layout/blueBuff/txtCount")
		enemyCell.redBuff = goutil.findChild(enemyCell.cellGo, "layout/redBuff")
		enemyCell.txtRedBuff = goutil.findChild(enemyCell.cellGo, "layout/redBuff/txtCount")

		local buffCell = {}

		for j = 1, 3 do
			local buff = goutil.findChildComponent(enemyCell.cellGo, "layout/buff" .. j, ComponentType.UIImageSpriteChange)

			buffCell[j] = buff

			GameUtil.SetActive(buff, false)
		end

		enemyCell.buffCell = buffCell
		enemyCellMap[i] = enemyCell

		GameUtil.SetActive(enemyCell.cellGo, false)
		GameUtil.SetActive(enemyCell.redBuff, false)
		GameUtil.SetActive(enemyCell.blueBuff, false)
	end

	local btnChallenge = goutil.findChild(teamEnemy, "btn")
	local maskGo = goutil.findChild(teamEnemy, "mask")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local passGo = goutil.findChild(maskGo, "pass")
	local openTimeGo = goutil.findChild(maskGo, "open")
	local txtTime = goutil.findChildTextComponent(openTimeGo, "txtTime")
	local creepsCfg = OriginDiShiTianConfig.instance:getCreepsCfg(data.creepsMasterId)

	for i, v in ipairs(creepsCfg) do
		local enemyCell = enemyCellMap[v.posId]

		if enemyCell then
			MaterialMgr.resetAll(enemyCell.con)
			MaterialMgr.setCell(MatType.Pet, v.raceId, enemyCell.con)
			GameUtil.SetActive(enemyCell.cellGo, true)
		end
	end

	txtScore.text = self:getScoreDesc(data.buffNum)
	txtName.text = langPara("关卡%s", data.stageId)

	local buffList = {}
	local redBuffPlanCfgs = OriginDiShiTianConfig.instance:getBuffPlan(data.buffPlanId, 1)

	for i, v in ipairs(redBuffPlanCfgs) do
		local enemyCell = enemyCellMap[v.pos]

		if enemyCell then
			buffList[v.pos] = buffList[v.pos] or {}

			for j = 1, v.count do
				table.insert(buffList[v.pos], 1)
			end
		end
	end

	local blueBuffPlanCfg = OriginDiShiTianConfig.instance:getBuffPlan(data.buffPlanId, 2)

	for i, v in ipairs(blueBuffPlanCfg) do
		local enemyCell = enemyCellMap[v.pos]

		if enemyCell then
			buffList[v.pos] = buffList[v.pos] or {}

			for j = 1, v.count do
				table.insert(buffList[v.pos], 2)
			end
		end
	end

	for pos, list in pairs(buffList) do
		for i, v in ipairs(list) do
			GameUtil.SetActive(enemyCellMap[pos].buffCell[i], true)

			if enemyCellMap[pos].buffCell[i] then
				enemyCellMap[pos].buffCell[i]:SetState(v - 1)
			end
		end
	end

	GameUtil.rmClickHandler(btnChallenge)
	GameUtil.addClickHandler(btnChallenge, function()
		self:_onClickStage(data.stageId)
	end, self)

	local isPass = self._curStageId >= data.stageId
	local isOnTime = true

	if not string.nilorempty(data.openTime) then
		local unLockTime = GameUtil.string2time(data.openTime)

		isOnTime = unLockTime < ServerTime.now()

		local date = GameUtil.string2date(data.openTime)

		txtTime.text = langPara("%d.%d开启", date.month, date.day)
	else
		isOnTime = true
	end

	GameUtil.SetActive(maskGo, isPass or not isOnTime)
	GameUtil.SetActive(passGo, isPass)
	GameUtil.SetActive(openTimeGo, not isOnTime)
end

function OriginDiShiTianStageView:_clearStageCell(cell)
	local go = cell.gameObject
	local teamEnemy = goutil.findChild(go, "teamEnemy")

	for i = 1, 9 do
		local cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		local con = goutil.findChild(cellGo, "icon")

		GameUtil.SetActive(cellGo, false)
		MaterialMgr.resetAll(con)
	end
end

function OriginDiShiTianStageView:getScoreDesc(score)
	return langPara("至少触发%d次箭羽效果", score)
end

function OriginDiShiTianStageView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local gain = goutil.findChild(go, "gain")
	local maxStageId = OriginDiShiTianModel.instance:getMaxStageId(self._activityId)
	local stageCfgs = OriginDiShiTianConfig.instance:getStageCfgs(self._activityId)

	GameUtil.SetActive(gain, maxStageId >= #stageCfgs)
	MaterialMgr.setCellByCfg(data, con)
end

function OriginDiShiTianStageView:_clearPrizeCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function OriginDiShiTianStageView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCell(MatType.Pet, data, go)
end

function OriginDiShiTianStageView:_clearPetCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function OriginDiShiTianStageView:_onClickStage(stageId)
	local stageCfg = OriginDiShiTianConfig.instance:getStageCfg(self._activityId, stageId)

	if not string.nilorempty(stageCfg.openTime) then
		local unLockTime = GameUtil.string2time(stageCfg.openTime)

		if unLockTime > ServerTime.now() then
			local date = GameUtil.string2date(stageCfg.openTime)

			FloatWordMgr.instance:show(langPara("%d.%d开启", date.month, date.day))

			return
		end
	end

	if stageId > self._curStageId + 1 then
		FloatWordMgr.instance:show(lang("未通关前置关卡"))
	elseif stageId <= self._curStageId then
		FloatWordMgr.instance:show(lang("已通关"))
	else
		OriginDiShiTianController.instance:openMissionView(self._activityId, stageId)
	end
end

function OriginDiShiTianStageView:_onClickReset()
	if self._curStageId > 0 then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否重置所有关卡"), function()
			OriginDiShiTianClgAgent.instance:sendPM_OriginDiShiTianClgResetReq(self._activityId)
		end)
	else
		FloatWordMgr.instance:show(lang("未通关任意关卡"))
	end
end

return OriginDiShiTianStageView
