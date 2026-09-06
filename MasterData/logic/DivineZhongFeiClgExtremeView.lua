-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/view/DivineZhongFeiClgExtremeView.lua

module("logic.extensions.divinezhongfeiclg.view.DivineZhongFeiClgExtremeView", package.seeall)

local DivineZhongFeiClgExtremeView = class("DivineZhongFeiClgExtremeView", ViewComponent)

function DivineZhongFeiClgExtremeView:ctor()
	DivineZhongFeiClgExtremeView.super.ctor(self)
end

function DivineZhongFeiClgExtremeView:unbindEvents()
	DivineZhongFeiClgExtremeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnBlock)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineZhongFeiClgExtremeView:bindEvents()
	DivineZhongFeiClgExtremeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnBlock, self._onClickBlock, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineZhongFeiClgExtremeView:buildUI()
	DivineZhongFeiClgExtremeView.super.buildUI(self)

	self._btnBuff = self:getGo("btnBuff")
	self._btnReset = self:getGo("btnReset")
	self._btnBlock = self:getGo("btnBlock")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._stageTableView = self:getGo("stageTableView")
	self._stageTableCell = self:getGo("stageTableCell")
	self._stageTableList = ScrollerList.create(self._stageTableView, self._stageTableCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._passItemTableView = self:getGo("passItemTableView")
	self._passItemTableCell = self:getGo("passItemTableCell")
	self._passItemTableList = ScrollerList.create(self._passItemTableView, self._passItemTableCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	self._passItemTableList:setCenterMode(true)
end

function DivineZhongFeiClgExtremeView:onExit()
	DivineZhongFeiClgExtremeView.super.onExit(self)
end

function DivineZhongFeiClgExtremeView:onEnter()
	DivineZhongFeiClgExtremeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineZhongFeiClgGetInfo, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._initView = false

	if DivineZhongFeiClgModel.instance:getTempChengeSetId() ~= nil then
		local changeSetId = DivineZhongFeiClgModel.instance:getTempChengeSetId()

		MaterialController.instance:showChangeSetInTemp(changeSetId)
		DivineZhongFeiClgModel.instance:resetTempChengeSetId()
	end

	self:_refreshView()
end

function DivineZhongFeiClgExtremeView:_refreshView()
	local stageCfgs = DivineZhongFeiClgConfig.instance:getExtremeStageCfgs(self._activityId)

	self._stageTableList:reloadData(stageCfgs)

	local activityCfg = DivineZhongFeiClgConfig.instance:getActivityCfg(self._activityId)
	local prizeList = {
		activityCfg.extremePrize
	}

	self._passItemTableList:reloadData(prizeList)

	if self._initView == false then
		self._initView = true

		local jumpIndex

		for i, v in ipairs(stageCfgs) do
			if DivineZhongFeiClgModel.instance:isExtStagePass(self._activityId, v.stageId) then
				jumpIndex = i
			end
		end

		if jumpIndex then
			self._stageTableList:MoveCellToCenter(jumpIndex - 1)
		end
	end
end

function DivineZhongFeiClgExtremeView:_updateStageCell(view, cell, data, tag)
	local go = cell.gameObject
	local teamEnemy = goutil.findChild(go, "teamEnemy")
	local btnChallenge = goutil.findChild(go, "teamEnemy")
	local mask = goutil.findChild(teamEnemy, "mask")
	local passGo = goutil.findChild(mask, "pass")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local score = DivineZhongFeiClgModel.instance:getExtStageScore(self._activityId, data.stageId)

	txtScore.text = langPara("击杀庇护精灵：%d", score)

	local enemyCellMap = {}

	for i = 1, 9 do
		local enemyCell = {}

		enemyCell.cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		enemyCell.con = goutil.findChild(enemyCell.cellGo, "icon")
		enemyCellMap[i] = enemyCell

		GameUtil.SetActive(enemyCell.cellGo, false)
	end

	local creepsCfg = DivineZhongFeiClgConfig.instance:getCreepsCfg(data.creepsMasterId)

	for i, v in ipairs(creepsCfg) do
		local enemyCell = enemyCellMap[v.posId]

		if enemyCell then
			MaterialMgr.resetAll(enemyCell.con)
			MaterialMgr.setIcon(enemyCell.con, MatType.Pet, v.raceId)
			GameUtil.SetActive(enemyCell.cellGo, true)
		end
	end

	local isStagePass = DivineZhongFeiClgModel.instance:isExtStagePass(self._activityId, data.stageId)

	GameUtil.SetActive(mask, isStagePass)
	GameUtil.SetActive(passGo, isStagePass)
	GameUtil.rmClickHandler(btnChallenge)
	GameUtil.addClickHandler(btnChallenge, function()
		self:_onClickChallenge(data.stageId)
	end, self)
end

function DivineZhongFeiClgExtremeView:_clearStageCell(cell)
	local go = cell.gameObject
	local teamEnemy = goutil.findChild(go, "teamEnemy")
	local btnChallenge = goutil.findChild(go, "teamEnemy")

	for i = 1, 9 do
		local cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		local con = goutil.findChild(cellGo, "icon")

		GameUtil.SetActive(cellGo, false)
		MaterialMgr.resetAll(con)
	end

	GameUtil.rmClickHandler(btnChallenge)
end

function DivineZhongFeiClgExtremeView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local receive = goutil.findChild(go, "receive")

	GameUtil.SetActive(receive, DivineZhongFeiClgModel.instance:isGainExtPassPrize(self._activityId))
	MaterialMgr.resetAll(con)
	MaterialMgr.setCellByCfg(data, con)
end

function DivineZhongFeiClgExtremeView:_clearItemCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function DivineZhongFeiClgExtremeView:_onClickChallenge(stageId)
	if not DivineZhongFeiClgModel.instance:isExtStagePass(self._activityId, stageId) then
		DivineZhongFeiClgController.instance:openExtemeMissionView(self._activityId, stageId)
	else
		FloatWordMgr.instance:show(lang("已通关"))
	end
end

function DivineZhongFeiClgExtremeView:_onClickBuff()
	UIStateManager.instance:push(ViewName.DivineZhongFeiClgBuffView, self._activityId)
end

function DivineZhongFeiClgExtremeView:_onClickBlock()
	UIStateManager.instance:push(ViewName.DivineZhongFeiClgBlockView, self._activityId)
end

function DivineZhongFeiClgExtremeView:_onClickReset()
	TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否将所有关卡重置为未挑战，解锁封印精灵"), function()
		DivineZhongFeiClgAgent.instance:sendPM_DivineZhongFeiClgExtremeResetReq(self._activityId)
	end)
end

return DivineZhongFeiClgExtremeView
