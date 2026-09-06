-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarReportView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarReportView", package.seeall)

local GodStatuesWarReportView = class("GodStatuesWarReportView", ViewComponent)
local ViewState_Record = 1
local ViewState_Detail = 2

function GodStatuesWarReportView:ctor()
	GodStatuesWarReportView.super.ctor(self)
end

function GodStatuesWarReportView:buildUI()
	GodStatuesWarReportView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._recordCol = goutil.findChild(self.mainGO, "recordCol")
	self._recordCol_emptyGo = goutil.findChild(self.mainGO, "recordCol/emptyGo")

	local recordScrView = goutil.findChild(self.mainGO, "recordCol/recordScrView")
	local recordScrCell = goutil.findChild(self.mainGO, "recordCol/recordScrCell")

	self._recordScrollList = ScrollerList.create(recordScrView, recordScrCell, GameUtil.handler(self._updateRecordCell, self), GameUtil.handler(self._clearRecordCell, self))
	self._detailCol = goutil.findChild(self.mainGO, "detailCol")
	self._detailCol_btnBack = goutil.findChild(self.mainGO, "detailCol/btnBack")
	self._detailCol_txtProgress = goutil.findChildTextComponent(self.mainGO, "detailCol/bgplayer/txtProgress")
	self._detailCol_playerView = goutil.findChild(self.mainGO, "detailCol/playerView")

	local detailCol_stageScrView = goutil.findChild(self.mainGO, "detailCol/stageCol/stageScrView")
	local detailCol_stageScrCell = goutil.findChild(self.mainGO, "detailCol/stageCol/stageScrCell")

	self._stageScrollList = ScrollerList.create(detailCol_stageScrView, detailCol_stageScrCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "emptyGo")
end

function GodStatuesWarReportView:bindEvents()
	GodStatuesWarReportView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._detailCol_btnBack, self._onClickBack, self)
end

function GodStatuesWarReportView:unbindEvents()
	GodStatuesWarReportView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._detailCol_btnBack)
end

function GodStatuesWarReportView:onEnter()
	GodStatuesWarReportView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])

	local isInTime = GodStatuesWarController.instance:isInSeasonTime(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d )", self._seasonId))
		self:close()

		return
	end

	self._seasonData = GodStatuesWarConfig.instance:getNfbSeasonData(self._seasonId)
	self._stepMgr = GodStatuesWarController.instance:gswStepMgrOnEnter(self._seasonId)
	self._stepInterval = self._stepMgr:getStepInterval(self._stepMgr:getNewestStep())
	self._viewState = ViewState_Record

	self.addGEvent(self, GlobalNotify.GodStatuesWarStepChange, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleGetDivinePillarMapRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleReportRes, self._onUpdate, self)
	GodStatuesWarController.instance:sendPM_NewFamilyBattleReportReq(self._seasonId)
	self:_onUpdate()
end

function GodStatuesWarReportView:onExit()
	GodStatuesWarReportView.super.onExit(self)
	self:_onClear()

	if self._stepMgr then
		GodStatuesWarController.instance:gswStepMgrOnExit(self._seasonId)

		self._stepMgr = nil
	end
end

function GodStatuesWarReportView:_onUpdate()
	local stepInterval = self._stepMgr:getStepInterval(self._stepMgr:getNewestStep())

	if stepInterval ~= self._stepInterval then
		self:close()

		return
	end

	self:_onUpdateData()
	self:_onUpdateUI()
end

function GodStatuesWarReportView:_onUpdateData()
	return
end

function GodStatuesWarReportView:_onUpdateUI()
	self:_onUpdateRecordColUI()
	self:_onUpdateDetailColUI()
end

function GodStatuesWarReportView:_onClear()
	self:_onClearRecordCol()
	self:_onClearDetailCol()
end

function GodStatuesWarReportView:_onUpdateRecordColUI()
	if self._viewState == ViewState_Record then
		GameUtil.SetActive(self._recordCol, true)
	else
		GameUtil.SetActive(self._recordCol, false)

		return
	end

	local infoMoList = GodStatuesWarController.instance:getTierReportInfoMoList(self._seasonId)

	self._recordScrollList:reloadData(infoMoList)
	GameUtil.SetActive(self._recordCol_emptyGo, #infoMoList <= 0)
end

function GodStatuesWarReportView:_onClearRecordCol()
	self._recordScrollList:dispose()
end

function GodStatuesWarReportView:_updateRecordCell(view, cell, infoMo, tag)
	local tierId = infoMo:getTierId()
	local pillarId = infoMo:getPillarId()
	local pillarData = GodStatuesWarConfig.instance:getNfbPillarInfoData(self._seasonId, pillarId)
	local mainGo = cell.gameObject
	local imgResult = goutil.findChild(mainGo, "imgResult")
	local btnDetail = goutil.findChild(mainGo, "btnDetail")
	local time_txt = goutil.findChildTextComponent(mainGo, "time/txt")
	local leftHead = goutil.findChild(mainGo, "leftHead")
	local rightHead = goutil.findChild(mainGo, "rightHead")
	local headGoList = {
		leftHead,
		rightHead
	}

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		local headGo = headGoList[idx]
		local headRoot = goutil.findChild(headGo, "headRoot")
		local headIcon = goutil.findChild(headGo, "headIcon")
		local familyIcon = goutil.findChild(headGo, "familyIcon")
		local txtName = goutil.findChildTextComponent(headGo, "txtName")
		local txtFamily = goutil.findChildTextComponent(headGo, "txtFamily")
		local tag = goutil.findChild(headGo, "tag")
		local headInfo = infoMo:getHeadInfo(teamId)
		local iconId = infoMo:getFamilyIconId(teamId)
		local userName = infoMo:getUserName(teamId)
		local familyName = infoMo:getFamilyName(teamId)

		if headInfo then
			HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, true)
			GameUtil.SetActive(headRoot, true)
		else
			HeadItemController.instance:resetHeadCell(headRoot)
			GameUtil.SetActive(headRoot, false)
		end

		if headInfo == nil then
			self:_loadBigBg(headIcon, pillarData.headIcon)
			GameUtil.SetActive(headIcon, true)
		else
			self:_unLoadBigBg(headIcon)
			GameUtil.SetActive(headIcon, false)
		end

		txtName.text = not string.nilorempty(userName) and userName or string.format("%s-%s层", pillarData.name, tierId)
		txtFamily.text = infoMo:getFamilyName(teamId)
	end

	GameUtil.setUIImageSpriteIdx(imgResult, infoMo:isWin(GameEnum.BattleTeam.Left) and 0 or 1)

	local timeStamp = infoMo:getTime()

	if not string.nilorempty(timeStamp) then
		local date = GameUtil.time2date(checknumber(timeStamp) / 1000)

		time_txt.text = string.format("%02d月%02d日 %02d:%02d", date.month, date.day, date.hour, date.min)
	else
		time_txt.text = ""
	end

	GameUtil.addClickHandler(btnDetail, GameUtil.handler(self._onClickBtnDetail, self, infoMo))
end

function GodStatuesWarReportView:_clearRecordCell(cell)
	local mainGo = cell.gameObject
	local leftHead = goutil.findChild(mainGo, "leftHead")
	local rightHead = goutil.findChild(mainGo, "rightHead")
	local headGoList = {
		leftHead,
		rightHead
	}

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		local headGo = headGoList[idx]
		local headRoot = goutil.findChild(headGo, "headRoot")
		local headIcon = goutil.findChild(headGo, "headIcon")

		HeadItemController.instance:resetHeadCell(headRoot)
		self:_unLoadBigBg(headIcon)
	end
end

function GodStatuesWarReportView:_onClickBtnDetail(infoMo)
	self._viewState = ViewState_Detail
	self._curReportInfoMo = infoMo

	self:_onUpdateUI()
end

function GodStatuesWarReportView:_onUpdateDetailColUI()
	if self._viewState == ViewState_Detail then
		GameUtil.SetActive(self._detailCol, true)
	else
		GameUtil.SetActive(self._detailCol, false)

		return
	end

	local infoMo = self._curReportInfoMo

	if infoMo == nil then
		self:_onClickBack()
	end

	local tierId = infoMo:getTierId()
	local pillarId = infoMo:getPillarId()
	local pillarData = GodStatuesWarConfig.instance:getNfbPillarInfoData(self._seasonId, pillarId)
	local playerCell_1 = goutil.findChild(self._detailCol_playerView, "playerCell_1")
	local playerCell_2 = goutil.findChild(self._detailCol_playerView, "playerCell_2")
	local playerCellList = {
		playerCell_1,
		playerCell_2
	}

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		local headGo = playerCellList[idx]
		local headRoot = goutil.findChild(headGo, "headRoot")
		local headIcon = goutil.findChild(headGo, "headIcon")
		local familyIcon = goutil.findChild(headGo, "familyIcon")
		local txtName = goutil.findChildTextComponent(headGo, "txtName")
		local txtFamily = goutil.findChildTextComponent(headGo, "txtFamily")
		local headInfo = infoMo:getHeadInfo(teamId)
		local iconId = infoMo:getFamilyIconId(teamId)
		local userName = infoMo:getUserName(teamId)
		local familyName = infoMo:getFamilyName(teamId)

		if headInfo then
			HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, true)
			GameUtil.SetActive(headRoot, true)
		else
			HeadItemController.instance:resetHeadCell(headRoot)
			GameUtil.SetActive(headRoot, false)
		end

		if headInfo == nil then
			self:_loadBigBg(headIcon, pillarData.headIcon)
			GameUtil.SetActive(headIcon, true)
		else
			self:_unLoadBigBg(headIcon)
			GameUtil.SetActive(headIcon, false)
		end

		txtName.text = not string.nilorempty(userName) and userName or string.format("%s-%s层", pillarData.name, tierId)
		txtFamily.text = infoMo:getFamilyName(teamId)
	end

	local detailInfoMoList = infoMo:getReportDetailInfoMoList()

	self._stageScrollList:reloadData(detailInfoMoList)

	local progressStr = "无"
	local timeStamp = infoMo:getTime()

	if not string.nilorempty(timeStamp) then
		local otherTimeStamp = checknumber(timeStamp) / 1000
		local step = GodStatuesWarController.instance:getCurStepByTimeStampOfGsw(self._seasonId, otherTimeStamp)
		local stepData = GodStatuesWarConfig.instance:getNfbStepData(self._seasonId, step)

		progressStr = stepData.desc
	end

	self._detailCol_txtProgress.text = progressStr
end

function GodStatuesWarReportView:_onClearDetailCol()
	local playerCell_1 = goutil.findChild(self._detailCol_playerView, "playerCell_1")
	local playerCell_2 = goutil.findChild(self._detailCol_playerView, "playerCell_2")
	local playerCellList = {
		playerCell_1,
		playerCell_2
	}

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		local headGo = playerCellList[idx]
		local headRoot = goutil.findChild(headGo, "headRoot")
		local headIcon = goutil.findChild(headGo, "headIcon")

		HeadItemController.instance:resetHeadCell(headRoot)
		self:_unLoadBigBg(headIcon)
	end

	self._stageScrollList:dispose()
end

function GodStatuesWarReportView:_updateStageCell(view, cell, infoMo, tag)
	local detailIndex = cell.index + 1
	local mainGo = cell.gameObject
	local btnVideo = goutil.findChild(mainGo, "btnVideo")
	local leftForm = goutil.findChild(mainGo, "leftForm")
	local rightForm = goutil.findChild(mainGo, "rightForm")
	local formList = {
		leftForm,
		rightForm
	}

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		local formGo = formList[idx]
		local txtTotalForce = goutil.findChildTextComponent(formGo, "txtTotalForce")
		local txtTeam = goutil.findChildTextComponent(formGo, "txtTeam")
		local txtWin = goutil.findChild(formGo, "txtWin")
		local txtFail = goutil.findChild(formGo, "txtFail")
		local formations = goutil.findChild(formGo, "formations")

		txtTeam.text = string.format("队伍%s", detailIndex)
		txtTotalForce.text = infoMo:getZdl(teamId)

		local isWin = infoMo:isWin(teamId)

		GameUtil.SetActive(txtWin, isWin)
		GameUtil.SetActive(txtFail, not isWin)

		local skinIdList = {}

		for posId = 1, 9 do
			local skinId = infoMo:getSkinId(teamId, posId)

			if skinId > 0 then
				table.insert(skinIdList, skinId)
			end
		end

		for petCellIdx = 1, formations.transform.childCount do
			local petCell = formations.transform:GetChild(petCellIdx - 1)
			local pointPet = goutil.findChild(petCell, "pointPet")
			local skinId = skinIdList[petCellIdx]

			if skinId then
				local raceId = PetSkinConfig.instance:getPetSkinRaceId(skinId)
				local skinId = skinId
				local level = 1
				local awakenLv = 1
				local proxy = MaterialMgr.setCell(MatType.Pet, skinId, pointPet)

				if proxy then
					local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, level, awakenLv, skinId)

					proxy.binder:setClickCallBack(function()
						CommonTipsMgr.instance:showPetTips(tmpMo, true)
					end)
				end
			else
				MaterialMgr.resetAll(pointPet)
			end
		end
	end

	GameUtil.addClickHandler(btnVideo, GameUtil.handler(self._onClickDetailCellBtnVideo, self, infoMo:getBattleId(), GameEnum.BattleTeam.Left))
end

function GodStatuesWarReportView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local btnVideo = goutil.findChild(mainGo, "btnVideo")
	local leftForm = goutil.findChild(mainGo, "leftForm")
	local rightForm = goutil.findChild(mainGo, "rightForm")
	local formList = {
		leftForm,
		rightForm
	}

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		local formGo = formList[idx]
		local formations = goutil.findChild(formGo, "formations")

		for petCellIdx = 1, formations.transform.childCount do
			local petCell = formations.transform:GetChild(petCellIdx - 1)
			local pointPet = goutil.findChild(petCell, "pointPet")

			MaterialMgr.resetAll(pointPet)
		end
	end

	GameUtil.rmClickHandler(btnVideo)
end

function GodStatuesWarReportView:_onClickDetailCellBtnVideo(battleId, teamId)
	if checknumber(battleId) > 0 then
		UIJumper.instance:saveCurStack()
		self:close()
		GodStatuesWarController.instance:sendPM_NewFamilyBattleVideoReq(battleId, teamId)
	else
		FloatWordMgr.instance:show("没有可观看的战斗")
	end
end

function GodStatuesWarReportView:_onClickBack()
	self._viewState = ViewState_Record

	self:_onUpdateUI()
end

function GodStatuesWarReportView:_onClickClose()
	if self._viewState == ViewState_Record then
		self:close()
	else
		self:_onClickBack()
	end
end

function GodStatuesWarReportView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function GodStatuesWarReportView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

return GodStatuesWarReportView
