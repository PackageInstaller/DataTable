-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicedtower/view/PsychicedTowerLevelView.lua

module("logic.extensions.psychicedtower.view.PsychicedTowerLevelView", package.seeall)

local PsychicedTowerLevelView = class("PsychicedTowerLevelView", ViewComponent)
local stageBgUrl = {
	[1] = "ui/bigbg/tonglingshihuanta/board_tonglinghuanta_05.png",
	[2] = "ui/bigbg/tonglingshihuanta/board_tonglinghuanta_06.png"
}

function PsychicedTowerLevelView:ctor()
	PsychicedTowerLevelView.super.ctor(self)
end

function PsychicedTowerLevelView:unbindEvents()
	PsychicedTowerLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBuffTips)
	GameUtil.rmClickHandler(self._btnGainBuff)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnRank)
end

function PsychicedTowerLevelView:bindEvents()
	PsychicedTowerLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBuffTips, self._onClickBuffTips, self)
	GameUtil.addClickHandler(self._btnGainBuff, self._onClickGainBuff, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
end

function PsychicedTowerLevelView:buildUI()
	PsychicedTowerLevelView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnShop = self:getGo("btnShop")
	self._btnTask = self:getGo("btnTask")
	self._btnRank = self:getGo("btnRank")
	self._btnBuffTips = self:getGo("buffInfo/buffLevel/btnBuffTips")
	self._btnGainBuff = self:getGo("buffInfo/btnGainBuff")
	self._txtGainBuff = self:getTxt("buffInfo/btnGainBuff/txt")
	self._tableView = self:getGo("tableView")
	self._tableCell = self:getGo("tableView/tableCell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtBuffLevel = self:getTxt("buffInfo/buffLevel/txtBuffLevel")
	self._imgBuffLevelArrow = self:getGo("buffInfo/buffLevel/imgArrow")
	self._txtNextLevel = self:getTxt("buffInfo/buffLevel/txtNextLevel")
	self._txtSingleBuff = self:getTxt("buffInfo/buffDesc/txtSingleBuff")
	self._levelUpBuff = self:getGo("buffInfo/buffDesc/levelUpBuff")
	self._txtNextBuff = self:getTxt("buffInfo/buffDesc/levelUpBuff/txtNextBuff")
	self._txtCurBuff = self:getTxt("buffInfo/buffDesc/levelUpBuff/txtBuff")
	self._buffIconGo = self:getGo("buffInfo/buffIcon")
	self._buffIcon = self:getGo("buffInfo/buffIcon/icon")
	self._assistTableView = self:getGo("buffInfo/asssistPet/tableView")
	self._assistTableCell = self:getGo("buffInfo/asssistPet/tableCell")
	self._assistTableList = ScrollerList.create(self._assistTableView, self._assistTableCell, GameUtil.handler(self._updateAssistCell, self), GameUtil.handler(self._clearAssistCell, self))

	self._assistTableList:setCenterMode(true)

	self._txtTime = self:getTxt("time/txtTime")
	self._redPointTask = self:getGo("btnTask/redPoint")
end

function PsychicedTowerLevelView:destroyUI()
	self._assistTableList:dispose()
	self._tableList:dispose()
end

function PsychicedTowerLevelView:onExit()
	PsychicedTowerLevelView.super.onExit(self)
	removetimer(self._onClock, self)
	uGuiUtil.clearImage(self._buffIcon)
	self._assistTableList:dispose()
	self._tableList:dispose()
	RedPointController.instance:unregRedPoint(self._redPointTask)
end

function PsychicedTowerLevelView:onEnter()
	PsychicedTowerLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PsychicedTowerInfoRes, self._PM_PsychicedTowerInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_PsychicedTowerGainBuffRes, self.refreshView, self)

	local param = self:getOpenParam()

	if param then
		self._activityId = param[1]
		self._towerId = param[2]
	end

	self._activityId = self._activityId or PsychicedTowerModel.instance:getCurrActId()
	self._activityCfg = PsychicedTowerConfig.instance:getActivityCfg(self._activityId)
	self._towerId = self._towerId or 1
	self._towerCfg = PsychicedTowerConfig.instance:getTowerCfg(self._activityId, self._towerId)
	self._stageCfgs = PsychicedTowerConfig.instance:getStageCfgs(self._activityId, self._towerId)
	self._notFullStageList = {}
	self._jumpStageIndex = nil

	self._assistTableList:reloadData(self._towerCfg.supportPetIds)
	PsychicedTowerAgent.instance:sendPM_PsychicedTowerInfoReq(self._activityId)

	self.targetTime = GameUtil.string2time(self._towerCfg.endDateTime)

	self:_onClock()
	settimer(1, self._onClock, self, true)

	local taskCfg = EventTaskSummaryConfig.instance:getPlanCfg(self._activityId)

	if taskCfg and checknumber(taskCfg.redPointId) > 0 then
		RedPointController.instance:regRedPoint(self._redPointTask, taskCfg.redPointId)
	end
end

function PsychicedTowerLevelView:refreshView()
	local isGainBuff = PsychicedTowerModel.instance:getIsTodayGainedBuff(self._activityId, self._towerId)
	local buffLevel = PsychicedTowerModel.instance:getBuffLevel(self._activityId, self._towerId)
	local nextLevel = buffLevel + 1
	local curBuffCfg = PsychicedTowerConfig.instance:getDailyBuff(self._activityId, self._towerId, buffLevel)
	local nextBuffCfg = PsychicedTowerConfig.instance:getDailyBuff(self._activityId, self._towerId, nextLevel)
	local isShowNextBuffInfo = nextBuffCfg ~= nil and not isGainBuff

	GameUtil.SetActive(self._imgBuffLevelArrow, isShowNextBuffInfo)
	GameUtil.SetActive(self._txtNextLevel, isShowNextBuffInfo)
	GameUtil.SetActive(self._levelUpBuff, isShowNextBuffInfo)
	GameUtil.SetActive(self._txtSingleBuff, not isShowNextBuffInfo)

	if isShowNextBuffInfo == true then
		self._txtGainBuff.text = lang("领 取")

		GameUtil.SetGray(self._btnGainBuff, false)
	elseif nextBuffCfg == nil then
		self._txtGainBuff.text = lang("已达上限")

		GameUtil.SetGray(self._btnGainBuff, true)
	else
		self._txtGainBuff.text = lang("明日再来")

		GameUtil.SetGray(self._btnGainBuff, true)
	end

	GameUtil.SetActive(self._buffIconGo, true)

	self._txtBuffLevel.text = langPara("战斗鼓舞%d级", buffLevel)

	if isShowNextBuffInfo == true then
		self._txtNextLevel.text = langPara("%d级", nextLevel)

		if curBuffCfg then
			self._txtCurBuff.text = curBuffCfg.buffDesc

			uGuiUtil.clearImage(self._buffIcon)
			uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(curBuffCfg.icon))
		else
			self._txtCurBuff.text = lang("无加成")

			uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(nextBuffCfg.icon))
		end

		self._txtNextBuff.text = nextBuffCfg.buffDesc
	elseif curBuffCfg then
		self._txtSingleBuff.text = curBuffCfg.buffDesc

		uGuiUtil.clearImage(self._buffIcon)
		uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(curBuffCfg.icon))
	else
		self._txtCurBuff.text = lang("无加成")

		uGuiUtil.clearImage(self._buffIcon)
		GameUtil.SetActive(self._buffIconGo, false)
	end

	self._tableList:reloadData(self._stageCfgs)
end

function PsychicedTowerLevelView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgBg = goutil.findChild(go, "img")
	local btnChallenge = goutil.findChild(go, "btnChallenge")
	local btnReChallenge = goutil.findChild(go, "btnReChallenge")
	local imgLock = goutil.findChild(go, "imgLock")
	local txtStage = goutil.findChild(go, "txtStage")
	local btnJump = goutil.findChild(go, "btnJump")
	local txtJump = goutil.findChildTextComponent(btnJump, "txt")
	local txtPass = goutil.findChildTextComponent(go, "btnReChallenge/txtPass")
	local imgPassGo = goutil.findChild(go, "imgPass")
	local txtStage = goutil.findChildTextComponent(go, "txtStage")
	local assistPetGo = goutil.findChild(go, "assistPet")
	local assistPetCon = goutil.findChild(assistPetGo, "con")
	local txtAssistPet = goutil.findChildTextComponent(assistPetGo, "txt")
	local starList = goutil.findChild(go, "star")
	local txtChallenge = goutil.findChildTextComponent(go, "btnChallenge/txtChallenge")

	txtStage.text = langPara("楼层%02d", data.stageId)

	local stageInfo = PsychicedTowerModel.instance:getStageInfo(self._activityId, self._towerId, data.stageId)
	local star = checknumber(stageInfo)
	local isPass = stageInfo ~= nil
	local isLatestStage = data.stageId == PsychicedTowerModel.instance:getPassStage(self._activityId, self._towerId) + 1
	local hasSupport = checknumber(data.openSupportPetId) > 0

	GameUtil.SetActive(assistPetGo, hasSupport)
	GameUtil.SetActive(imgPassGo, isPass)
	GameUtil.SetActive(btnJump, self._jumpStageIndex and data.stageId == self._notFullStageList[self._jumpStageIndex])
	GameUtil.SetActive(imgLock, not isPass and not isLatestStage)
	GameUtil.SetActive(btnChallenge, isLatestStage)
	GameUtil.SetActive(btnReChallenge, not isLatestStage)

	txtJump.text = #self._notFullStageList > 1 and lang("点击跳到\n下一个未满星关卡") or lang("当前仅有一关未满星")

	if hasSupport then
		local supportPetCfg = PsychicedTowerConfig.instance:getSupportPetCfg(data.openSupportPetId)

		MaterialMgr.resetAll(assistPetCon)

		local proxy = MaterialMgr.setCell(MatType.Pet, supportPetCfg.raceId, assistPetCon)
	else
		MaterialMgr.resetAll(assistPetCon)
	end

	if not isPass then
		txtAssistPet.text = lang("通关后获得")
		txtPass.text = lang("未解锁")

		GameUtil.setAnchoredPos(assistPetGo, 343, 22, 0)
	else
		txtAssistPet.text = lang("已加入")
		txtPass.text = lang("挑战完成")

		GameUtil.setAnchoredPos(assistPetGo, 343, 62, 0)
	end

	local fullStar = math.floor(star / 2)
	local halfStar = math.ceil(star / 2)
	local hasHalfStar = star % 2 == 1
	local maxHalfStar = PsychicedTowerConfig.instance:getMaxStar(data.buffPlanId)
	local maxStar = math.ceil(maxHalfStar / 2)

	for i = 1, starList.transform.childCount do
		local star = goutil.findChild(starList, "star_" .. i)
		local imgChangeStar = star:GetComponent(ComponentType.UIImageSpriteChange)

		GameUtil.SetActive(star, i <= maxStar and isPass)

		if halfStar < i then
			imgChangeStar:SetState(1)
		elseif i == halfStar and hasHalfStar then
			imgChangeStar:SetState(2)
		else
			imgChangeStar:SetState(0)
		end
	end

	GameUtil.addClickHandler(btnChallenge, function()
		self:_onClickStage(data.stageId)
	end)
	GameUtil.addClickHandler(btnReChallenge, function()
		self:_onClickStage(data.stageId)
	end)
	GameUtil.addClickHandler(btnJump, function()
		self:_onClickJump()
	end)
	uGuiUtil.clearImage(imgBg)
	uGuiUtil.setSpriteToImage(imgBg, uGuiUtil.SpriteType.BigBg, stageBgUrl[data.stageId % 2 == 0 and 1 or 2])
end

function PsychicedTowerLevelView:_clearCell(cell)
	local go = cell.gameObject
	local imgBg = goutil.findChild(go, "img")
	local btnChallenge = goutil.findChild(go, "btnChallenge")
	local btnReChallenge = goutil.findChild(go, "btnReChallenge")

	GameUtil.rmClickHandler(btnChallenge)
	GameUtil.rmClickHandler(btnReChallenge)
	uGuiUtil.clearImage(imgBg)
end

function PsychicedTowerLevelView:_updateAssistCell(view, cell, data, tag)
	local go = cell.gameObject
	local cfg = PsychicedTowerConfig.instance:getSupportPetCfg(data)

	MaterialMgr.setCell(MatType.Pet, cfg.raceId, go)
end

function PsychicedTowerLevelView:_clearAssistCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function PsychicedTowerLevelView:_onClickStage(stageId)
	local cfg = PsychicedTowerConfig.instance:getStageCfg(self._activityId, self._towerId, stageId)
	local stageInfo = PsychicedTowerModel.instance:getStageInfo(self._activityId, self._towerId, stageId)
	local star = checknumber(stageInfo)

	if stageId > PsychicedTowerModel.instance:getPassStage(self._activityId, self._towerId) + 1 then
		FloatWordMgr.instance:show(lang("关卡未解锁"))
	elseif star >= PsychicedTowerConfig.instance:getMaxStar(cfg.buffPlanId) then
		FloatWordMgr.instance:show(lang("关卡已满星无需重复挑战"))
	else
		local fmtMo = PsychicedTowerModel.instance:getFmtMo()

		fmtMo:initParams(self._activityId, self._towerId, stageId)
		CustomFmtController.instance:showMissionView(fmtMo)
	end
end

function PsychicedTowerLevelView:_onClickShop()
	GotoMgr.gotoByString(self._activityCfg.jumpTo)
end

function PsychicedTowerLevelView:_onClickGainBuff()
	local buffLevel = PsychicedTowerModel.instance:getBuffLevel(self._activityId, self._towerId)
	local nextLevel = buffLevel + 1
	local nextBuffCfg = PsychicedTowerConfig.instance:getDailyBuff(self._activityId, self._towerId, nextLevel)

	if PsychicedTowerModel.instance:getIsTodayGainedBuff(self._activityId, self._towerId) == true then
		FloatWordMgr.instance:show(lang("已领取"))
	elseif not nextBuffCfg then
		FloatWordMgr.instance:show(lang("已达等级上限"))
	else
		PsychicedTowerAgent.instance:sendPM_PsychicedTowerGainBuffReq(self._activityId, self._towerId)
	end
end

function PsychicedTowerLevelView:_onClickTask()
	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId)
end

function PsychicedTowerLevelView:_onClickRank()
	UIStateManager.instance:push(ViewName.PsychicedTowerRankView, self._activityId)
end

function PsychicedTowerLevelView:_onClickBuffTips()
	UIStateManager.instance:push(ViewName.PsychicedTowerBuffView, self._activityId, self._towerId)
end

function PsychicedTowerLevelView:_onClickJump()
	self._jumpStageIndex = self._jumpStageIndex + 1

	if self._jumpStageIndex > #self._notFullStageList then
		self._jumpStageIndex = 1
	end

	local targetStage = self._notFullStageList[self._jumpStageIndex]

	if targetStage and targetStage > 0 then
		self:refreshView()
		self._tableList:MoveCellToCenter(targetStage - 1)
	end
end

function PsychicedTowerLevelView:_onClock()
	if self.targetTime > ServerTime.now() then
		if self._txtTime then
			self._txtTime.text = langPara("剩余：%s", GameUtil.FormatTimeWords(self.targetTime - ServerTime.now()))
		end
	else
		FloatWordMgr.instance:show(lang("已结束"))
		self:close()
	end
end

function PsychicedTowerLevelView:_PM_PsychicedTowerInfoRes()
	self._jumpStageIndex = nil

	table.clear(self._notFullStageList)

	for i, v in ipairs(self._stageCfgs) do
		local stageInfo = PsychicedTowerModel.instance:getStageInfo(self._activityId, self._towerId, v.stageId)
		local star = checknumber(stageInfo)
		local isPass = stageInfo ~= nil
		local maxStar = PsychicedTowerConfig.instance:getMaxStar(v.buffPlanId)

		if isPass and star < maxStar then
			table.insert(self._notFullStageList, v.stageId)

			self._jumpStageIndex = #self._notFullStageList
		end
	end

	self:refreshView()

	local latestStage = PsychicedTowerModel.instance:getPassStage(self._activityId, self._towerId) + 1

	if latestStage > #self._stageCfgs then
		latestStage = #self._stageCfgs
	end

	self._tableList:MoveCellToCenter(latestStage - 1)
end

return PsychicedTowerLevelView
