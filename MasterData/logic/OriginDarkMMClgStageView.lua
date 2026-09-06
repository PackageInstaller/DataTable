-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmmclg/view/OriginDarkMMClgStageView.lua

module("logic.extensions.origindarkmmclg.view.OriginDarkMMClgStageView", package.seeall)

local OriginDarkMMClgStageView = class("OriginDarkMMClgStageView", ViewComponent)

function OriginDarkMMClgStageView:ctor()
	OriginDarkMMClgStageView.super.ctor(self)
end

function OriginDarkMMClgStageView:unbindEvents()
	OriginDarkMMClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function OriginDarkMMClgStageView:bindEvents()
	OriginDarkMMClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
end

function OriginDarkMMClgStageView:buildUI()
	OriginDarkMMClgStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._stageTableView = self:getGo("fmtCol/scrView")
	self._stageTableCell = self:getGo("fmtCol/scrCell")
	self._stageTableList = ScrollerList.create(self._stageTableView, self._stageTableCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._petCell = self:getGo("petCell")
	self._prizeCon = self:getGo("tips/levelClearPrize/con")
	self._receivedGo = self:getGo("tips/levelClearPrize/received")
	self._receivedTxt = self:getGo("tips/levelClearPrize/received/txt")
	self._content = self:getTxt("tips/scrView/Viewport/Content")
end

function OriginDarkMMClgStageView:onExit()
	OriginDarkMMClgStageView.super.onExit(self)
	self._stageTableList:dispose()

	for k, v in pairs(self._petTableListDic) do
		v:dispose()
	end

	self._petTableListDic = nil

	MaterialMgr.resetAll(self._prizeCon)
end

function OriginDarkMMClgStageView:onEnter()
	OriginDarkMMClgStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginDarkMMClgGetInfoRes, self._refreshStageProgress, self)
	self.addGEvent(self, GlobalNotify.PM_OriginDarkMMClgResetRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_Notify_OriginDarkMMClgChallengeResultRes, self._refreshStageProgress, self)

	self._activityId = checknumber(self:getFirstParam())
	self._petTableListDic = {}
	self._activityCfg = OriginDarkMMClgConfig.instance:getActivity(self._activityId)
	self._content.text = self._activityCfg.stageDetailDesc or ""

	MaterialMgr.resetAll(self._prizeCon)
	MaterialMgr.setCellByCfg(self._activityCfg.passPrize, self._prizeCon)
	OriginDarkMMClgController.instance:sendInfoReq(self._activityId)
	self:_refreshView()
end

function OriginDarkMMClgStageView:_refreshView()
	local stageConfig = OriginDarkMMClgConfig.instance:getStages(self._activityId)

	self._stageTableList:reloadData(stageConfig)

	local isGain = OriginDarkMMClgModel.instance:isGainPrize(self._activityId)

	GameUtil.SetActive(self._receivedGo, isGain)
	self:_refreshStagePosition()
end

function OriginDarkMMClgStageView:_refreshStageProgress()
	self:_refreshView()

	if OriginDarkMMClgController.instance:isAllStagePassed(self._activityId) then
		UIStateManager.instance:popByName(ViewName.OriginDarkMMClgStageView)
	end
end

function OriginDarkMMClgStageView:_refreshStagePosition()
	local stageConfig = OriginDarkMMClgConfig.instance:getStages(self._activityId)
	local notPassStageId = 0

	for i, v in ipairs(stageConfig) do
		local stageInfo = OriginDarkMMClgModel.instance:getStageInfo(self._activityId, v.stageId)

		if not stageInfo then
			notPassStageId = i

			break
		end
	end

	if notPassStageId > 0 then
		self._stageTableList:MoveCellToCenter(notPassStageId - 1)
	end
end

function OriginDarkMMClgStageView:_updateStageCell(view, cell, data, tag)
	local go = cell.gameObject
	local petTableView = goutil.findChild(go, "petTableView")
	local emptyPetGo = goutil.findChild(go, "emptyPet")
	local teamEnemy = goutil.findChild(go, "teamEnemy")
	local enemyCellMap = {}

	for i = 1, 9 do
		local enemyCell = {}

		enemyCell.cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		enemyCell.con = goutil.findChild(enemyCell.cellGo, "con")
		enemyCellMap[i] = enemyCell

		GameUtil.SetActive(enemyCell.cellGo, false)
	end

	local btnChallenge = goutil.findChild(go, "btn")
	local imgChangeBtn = btnChallenge:GetComponent(ComponentType.UIImageSpriteChange)
	local txtChallenge = goutil.findChildTextComponent(btnChallenge, "txt")
	local maskGo = goutil.findChild(teamEnemy, "mask")
	local passGo = goutil.findChild(maskGo, "pass")
	local petTableList = self._petTableListDic[go]

	if not petTableList then
		petTableList = ScrollerList.create(petTableView, self._petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

		petTableList:setCenterMode(true)

		self._petTableListDic[go] = petTableList
	end

	local stageInfo = OriginDarkMMClgModel.instance:getStageInfo(self._activityId, data.stageId)

	if stageInfo then
		if not stageInfo.lockRaceIds then
			local petIds = {}

			petTableList:reloadData(petIds)
			GameUtil.SetActive(emptyPetGo, not petIds or #petIds == 0)

			local creepsCfg = OriginDarkMMClgConfig.instance:getCreeps(data.creepsMasterId)

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
				txtChallenge.color = Framework.ColorUtil.ParseColor("#264E73")

				imgChangeBtn:SetState(1)
			else
				txtChallenge.text = lang("进入挑战")
				txtChallenge.color = Framework.ColorUtil.ParseColor("#682D09")

				imgChangeBtn:SetState(0)
			end

			GameUtil.rmClickHandler(btnChallenge)
			GameUtil.addClickHandler(btnChallenge, function()
				self:_onClickStage(data.stageId)
			end, self)

			local isPass = stageInfo ~= nil

			GameUtil.SetActive(passGo, isPass)
			GameUtil.SetActive(maskGo, isPass)
		end
	end
end

function OriginDarkMMClgStageView:_clearStageCell(cell)
	local go = cell.gameObject
	local teamEnemy = goutil.findChild(go, "teamEnemy")

	for i = 1, 9 do
		local cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		local con = goutil.findChild(cellGo, "con")

		GameUtil.SetActive(cellGo, false)
		MaterialMgr.resetAll(con)
	end

	local petTableList = self._petTableListDic[go]

	if petTableList then
		petTableList:dispose()

		self._petTableListDic[go] = nil
	end
end

function OriginDarkMMClgStageView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCell(MatType.Pet, data, go)
end

function OriginDarkMMClgStageView:_clearPetCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function OriginDarkMMClgStageView:_onClickStage(stageId)
	local stageInfo = OriginDarkMMClgModel.instance:getStageInfo(self._activityId, stageId)

	if stageInfo then
		TipsFacade.instance:openPopupWindow(lang("确认弹窗"), lang("是否重置本关，解除精灵封印？"), function()
			OriginDarkMMClgController.instance:sendResetReq(self._activityId, stageId)
		end)
	else
		OriginDarkMMClgController.instance:openMissionView(self._activityId, stageId)
	end
end

function OriginDarkMMClgStageView:_onClickBtnTips()
	local key = self._activityCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

return OriginDarkMMClgStageView
