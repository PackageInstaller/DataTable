-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/view/OriginPowersClgExtremeView.lua

module("logic.extensions.originpowersclg.view.OriginPowersClgExtremeView", package.seeall)

local OriginPowersClgExtremeView = class("OriginPowersClgExtremeView", ViewComponent)

function OriginPowersClgExtremeView:ctor()
	OriginPowersClgExtremeView.super.ctor(self)
end

function OriginPowersClgExtremeView:unbindEvents()
	OriginPowersClgExtremeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function OriginPowersClgExtremeView:bindEvents()
	OriginPowersClgExtremeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function OriginPowersClgExtremeView:buildUI()
	OriginPowersClgExtremeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._stageTableCell = self:getGo("stageTableCell")
	self._stageTableView = self:getGo("stageTableView")
	self._stageTableList = ScrollerList.create(self._stageTableView, self._stageTableCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._petCell = self:getGo("petCell")
	self._scoreTableview = self:getGo("scoreTableview")
	self._scoreTablecell = self:getGo("scoreTableview/scoreTablecell")
	self._scoreTableList = ScrollerList.create(self._scoreTableview, self._scoreTablecell, GameUtil.handler(self._updateScoreCell, self), GameUtil.handler(self._clearScoreCell, self))
	self._prizeCon = self:getGo("prize/con")
	self._receivedGo = self:getGo("prize/received")
	self._txtTotalScore = self:getTxt("txtTotalScore")
end

function OriginPowersClgExtremeView:onExit()
	OriginPowersClgExtremeView.super.onExit(self)
	self._stageTableList:dispose()

	for k, v in pairs(self._petTableListDic) do
		v:dispose()
	end

	self._petTableListDic = nil

	MaterialMgr.resetAll(self._prizeCon)
end

function OriginPowersClgExtremeView:onEnter()
	OriginPowersClgExtremeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginPowersInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._petTableListDic = {}

	local activityCfg = OriginPowersClgConfig.instance:getActivityCfg(self._activityId)

	MaterialMgr.resetAll(self._prizeCon)
	MaterialMgr.setCellByCfg(activityCfg.extremePrize, self._prizeCon)
	self:_refreshView()

	local cfgs = OriginPowersClgConfig.instance:getExtremeStageCfgs(self._activityId)
	local notPassStageId = 0

	for i, v in ipairs(cfgs) do
		local stageInfo = OriginPowersClgModel.instance:getExtStageInfo(self._activityId, v.stageId)

		if not stageInfo then
			notPassStageId = i

			break
		end
	end

	if notPassStageId > 0 then
		self._stageTableList:MoveCellToCenter(notPassStageId - 1)
	end
end

function OriginPowersClgExtremeView:_refreshView()
	local cfgs = OriginPowersClgConfig.instance:getExtremeStageCfgs(self._activityId)

	self._stageTableList:reloadData(cfgs)

	local isGain = OriginPowersClgModel.instance:isGainExtremePrize(self._activityId)

	GameUtil.SetActive(self._receivedGo, isGain)

	self._totalScore = 0

	for i, v in ipairs(cfgs) do
		local stageInfo = OriginPowersClgModel.instance:getExtStageInfo(self._activityId, v.stageId)

		if stageInfo then
			self._totalScore = self._totalScore + checknumber(stageInfo.buffNum)
		end
	end

	self._txtTotalScore.text = langPara("当前累计击杀数量：%d", self._totalScore)

	local buffCfgs = OriginPowersClgConfig.instance:getExtremeBuffCfgs(self._activityId)
	local buffCfgsList = {}

	for i, v in pairs(buffCfgs) do
		table.insert(buffCfgsList, v)
	end

	table.sort(buffCfgsList, function(a, b)
		return a.buffNum < b.buffNum
	end)

	local buffList = {}
	local activeIndex = 1

	for i = 1, #buffCfgsList do
		local info = {
			cfg = buffCfgsList[i],
			index = i
		}

		if self._totalScore >= buffCfgsList[i].buffNum then
			activeIndex = i
		end

		if buffCfgsList[i + 1] then
			info.maxValue = buffCfgsList[i + 1].buffNum
		end

		table.insert(buffList, info)
	end

	self._scoreTableList:reloadData(buffList)
	self._scoreTableList:MoveCellToCenter(activeIndex - 1)
end

function OriginPowersClgExtremeView:_updateStageCell(view, cell, data, tag)
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

	local btnChallenge = goutil.findChild(go, "btn")
	local imgChangeBtn = btnChallenge:GetComponent(ComponentType.UIImageSpriteChange)
	local txtChallenge = goutil.findChildTextComponent(btnChallenge, "txt")
	local maskGo = goutil.findChild(teamEnemy, "mask")
	local passGo = goutil.findChild(maskGo, "pass")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local petTableList = self._petTableListDic[go]

	if not petTableList then
		petTableList = ScrollerList.create(petTableView, self._petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

		petTableList:setCenterMode(true)

		self._petTableListDic[go] = petTableList
	end

	local stageInfo = OriginPowersClgModel.instance:getExtStageInfo(self._activityId, data.stageId)

	if stageInfo then
		if not stageInfo.lockPetRaceIds then
			local petIds = {}

			petTableList:reloadData(petIds)
			GameUtil.SetActive(emptyPetGo, not petIds or #petIds == 0)

			local creepsCfg = OriginPowersClgConfig.instance:getCreepsCfg(data.creepsMasterId)

			for i, v in ipairs(creepsCfg) do
				local enemyCell = enemyCellMap[v.posId]

				if enemyCell then
					MaterialMgr.resetAll(enemyCell.con)
					MaterialMgr.setCell(MatType.Pet, v.raceId, enemyCell.con)
					GameUtil.SetActive(enemyCell.cellGo, true)
				end
			end

			if stageInfo then
				txtChallenge.text = lang("重置关卡")
				txtScore.text = langPara("克制击杀目标：%d（%d/%d）", data.buffNum, stageInfo.buffNum, data.buffNum)

				imgChangeBtn:SetState(1)
			else
				txtChallenge.text = lang("进入挑战")
				txtScore.text = langPara("克制击杀目标：%d（%d/%d）", data.buffNum, 0, data.buffNum)

				imgChangeBtn:SetState(0)
			end

			GameUtil.rmClickHandler(btnChallenge)
			GameUtil.addClickHandler(btnChallenge, function()
				self:_onClickStage(data.stageId)
			end, self)

			local isPass = stageInfo ~= nil

			GameUtil.SetActive(maskGo, isPass)
			GameUtil.SetActive(passGo, isPass)
		end
	end
end

function OriginPowersClgExtremeView:_clearStageCell(cell)
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

function OriginPowersClgExtremeView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCell(MatType.Pet, data, go)
end

function OriginPowersClgExtremeView:_clearPetCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function OriginPowersClgExtremeView:_updateScoreCell(view, cell, data, tag)
	local go = cell.gameObject
	local bg = goutil.findChild(go, "bg")
	local activeGo = goutil.findChild(go, "active")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtBuff = goutil.findChildTextComponent(go, "txtBuff")
	local curNum = self._totalScore

	if data.maxValue then
		txtScore.text = langPara("%d-%d", data.cfg.buffNum, data.maxValue - 1)

		GameUtil.SetActive(activeGo, curNum < data.maxValue and curNum >= data.cfg.buffNum)
	else
		txtScore.text = langPara("%d以上", data.cfg.buffNum)

		GameUtil.SetActive(activeGo, curNum >= data.cfg.buffNum)
	end

	txtBuff.text = data.cfg.desc

	GameUtil.SetActive(bg, data.index % 2 == 1)
end

function OriginPowersClgExtremeView:_clearScoreCell(cell)
	return
end

function OriginPowersClgExtremeView:_onClickStage(stageId)
	local stageInfo = OriginPowersClgModel.instance:getExtStageInfo(self._activityId, stageId)

	if not stageInfo then
		OriginPowersClgController.instance:openExtermeMissionView(self._activityId, stageId)
	else
		local content = lang("是否将本关重置为未挑战，解除精灵封印")

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			OriginPowersClgAgent.instance:sendPM_OriginPowersExtremeResetReq(self._activityId, stageId)
		end)
	end
end

function OriginPowersClgExtremeView:_onClickTip()
	TipsFacade.instance:openRulesView("origin_powers_clg_rule")
end

return OriginPowersClgExtremeView
