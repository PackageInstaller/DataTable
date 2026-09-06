-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/view/DivineWeiLeiTaClgExtremeView.lua

module("logic.extensions.divineweileitaclg.view.DivineWeiLeiTaClgExtremeView", package.seeall)

local DivineWeiLeiTaClgExtremeView = class("DivineWeiLeiTaClgExtremeView", ViewComponent)

function DivineWeiLeiTaClgExtremeView:ctor()
	DivineWeiLeiTaClgExtremeView.super.ctor(self)
end

function DivineWeiLeiTaClgExtremeView:unbindEvents()
	DivineWeiLeiTaClgExtremeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
end

function DivineWeiLeiTaClgExtremeView:bindEvents()
	DivineWeiLeiTaClgExtremeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
end

function DivineWeiLeiTaClgExtremeView:buildUI()
	DivineWeiLeiTaClgExtremeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._stageTableCell = self:getGo("stageTableCell")
	self._stageTableView = self:getGo("stageTableView")
	self._stageTableList = ScrollerList.create(self._stageTableView, self._stageTableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._stageTableList:setCenterMode(false)

	self._petCell = self:getGo("petCell")
	self._btnReset = self:getGo("btnReset")
end

function DivineWeiLeiTaClgExtremeView:onExit()
	DivineWeiLeiTaClgExtremeView.super.onExit(self)
	self._stageTableList:dispose()

	for k, v in pairs(self._petTableListDic) do
		v:dispose()
	end

	self._petTableListDic = nil
end

function DivineWeiLeiTaClgExtremeView:onEnter()
	DivineWeiLeiTaClgExtremeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineWeiLeiTaClgExtremeRefresh, self._refreshView, self)

	self._activityId = self:getFirstParam()
	self._stageCfgs = DivineWeiLeiTaClgConfig.instance:getExtremeStageCfgs(self._activityId)
	self._petTableListDic = {}
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_refreshView()

	if DivineWeiLeiTaClgModel.instance:getExtBattleTempData(self._activityId) then
		UIStateManager.instance:push(ViewName.DivineWeiLeiTaClgResultView, self._activityId)
	end
end

function DivineWeiLeiTaClgExtremeView:_refreshView()
	local extMaxStageId = DivineWeiLeiTaClgModel.instance:getExtMaxStageId(self._activityId)

	if extMaxStageId >= #self._stageCfgs then
		self:close()

		return
	end

	local moveTarget = DivineWeiLeiTaClgModel.instance:getExtCurStageId(self._activityId) + 1

	if moveTarget >= #self._stageCfgs then
		moveTarget = #self._stageCfgs
	end

	self._stageTableList:reloadData(self._stageCfgs)
	self._stageTableList:MoveCellToCenter(moveTarget - 1)
end

function DivineWeiLeiTaClgExtremeView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local petTableView = goutil.findChild(go, "petTableView")
	local emptyPetGo = goutil.findChild(go, "emptyPet")
	local teamEnemy = goutil.findChild(go, "teamEnemy")
	local enemyCellMap = {}

	for i = 1, 9 do
		local enemyCell = {}

		enemyCell.cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		enemyCell.con = goutil.findChild(enemyCell.cellGo, "icon")
		enemyCellMap[i] = enemyCell

		GameUtil.SetActive(enemyCell.cellGo, false)
	end

	local btnChallenge = goutil.findChild(go, "teamEnemy")
	local maskGo = goutil.findChild(teamEnemy, "mask")
	local passGo = goutil.findChild(maskGo, "pass")
	local nextGo = goutil.findChild(maskGo, "next")
	local prize = goutil.findChild(go, "prize")
	local prizeCon = goutil.findChild(prize, "con")
	local gainGo = goutil.findChild(prize, "gain")
	local petTableList = self._petTableListDic[go]

	if not petTableList then
		petTableList = ScrollerList.create(petTableView, self._petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

		petTableList:setCenterMode(true)

		self._petTableListDic[go] = petTableList
	end

	local stageInfo = DivineWeiLeiTaClgModel.instance:getExtStageInfo(self._activityId, data.stageId)

	if stageInfo then
		if not stageInfo.lockRaceIds then
			local petIds = {}

			petTableList:reloadData(petIds)
			GameUtil.SetActive(emptyPetGo, not petIds or #petIds == 0)

			local creepsCfg = DivineWeiLeiTaClgConfig.instance:getCreepsCfg(data.creepsMasterId)

			for i, v in ipairs(creepsCfg) do
				local enemyCell = enemyCellMap[v.posId]

				if enemyCell then
					MaterialMgr.resetAll(enemyCell.con)
					MaterialMgr.setIcon(enemyCell.con, MatType.Pet, v.raceId)
					GameUtil.SetActive(enemyCell.cellGo, true)
				end
			end

			MaterialMgr.resetAll(prizeCon)
			MaterialMgr.setCellByCfg(data.prize, prizeCon)
			GameUtil.rmClickHandler(btnChallenge)
			GameUtil.addClickHandler(btnChallenge, function()
				self:_onClickChallenge(data.stageId)
			end, self)

			local curStageId = DivineWeiLeiTaClgModel.instance:getExtCurStageId(self._activityId) + 1

			GameUtil.SetActive(maskGo, curStageId ~= data.stageId)
			GameUtil.SetActive(passGo, curStageId > data.stageId)
			GameUtil.SetActive(nextGo, curStageId < data.stageId)

			local maxStageId = DivineWeiLeiTaClgModel.instance:getExtMaxStageId(self._activityId)

			GameUtil.SetActive(gainGo, maxStageId >= data.stageId)
			GameUtil.SetActive(prize, not self._isAoqiGodProcessType)
		end
	end
end

function DivineWeiLeiTaClgExtremeView:_clearCell(cell)
	local go = cell.gameObject
	local teamEnemy = goutil.findChild(go, "teamEnemy")

	for i = 1, 9 do
		local cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		local con = goutil.findChild(cellGo, "icon")

		GameUtil.SetActive(cellGo, false)
		MaterialMgr.resetAll(con)
	end

	local petTableList = self._petTableListDic[go]

	if petTableList then
		petTableList:dispose()

		self._petTableListDic[go] = nil
	end
end

function DivineWeiLeiTaClgExtremeView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCell(MatType.Pet, data, go)
end

function DivineWeiLeiTaClgExtremeView:_clearPetCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function DivineWeiLeiTaClgExtremeView:_onClickChallenge(stageId)
	local curStageId = DivineWeiLeiTaClgModel.instance:getExtCurStageId(self._activityId) + 1

	if curStageId < stageId then
		FloatWordMgr.instance:show(lang("请先通关上一关"))
	elseif stageId < curStageId then
		FloatWordMgr.instance:show(lang("已通关"))
	else
		local fmtMo = DivineWeiLeiTaClgModel.instance:getExtFmtMo()

		fmtMo:initParams(self._activityId, stageId)
		CustomFmtController.instance:showMissionView(fmtMo)
	end
end

function DivineWeiLeiTaClgExtremeView:_onClickReset()
	local curStageId = DivineWeiLeiTaClgModel.instance:getExtCurStageId(self._activityId) + 1

	if curStageId <= 1 then
		FloatWordMgr.instance:show(lang("未通关任何关卡"))
	else
		local content = lang("是否将所有关卡重置为未挑战，解除所有精灵封印，但奖励不重置")

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			DivineWeiLeiTaClgAgent.instance:sendPM_DivineWeiLeiTaClgExtremeResetReq(self._activityId)
		end)
	end
end

return DivineWeiLeiTaClgExtremeView
