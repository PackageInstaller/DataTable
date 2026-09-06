-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarTowerView.lua

module("logic.extensions.ultimatewar.view.UltimateWarTowerView", package.seeall)

local UltimateWarTowerView = class("UltimateWarTowerView", ViewComponent)

function UltimateWarTowerView:buildUI()
	UltimateWarTowerView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtOpenTime = self:getTxt("time/txt")
	self._btnRank = self:getGo("btnCol/btnRank")
	self._btnPrize = self:getGo("btnCol/btnPrize")
	self._towerView = self:getGo("towerCol/towerView")
	self._towerCell = self:getGo("towerCol/towerCell")
	self._bossCell = self:getGo("bossCell")
end

function UltimateWarTowerView:bindEvents()
	UltimateWarTowerView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickBtnPrize, self)
end

function UltimateWarTowerView:unbindEvents()
	UltimateWarTowerView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
end

function UltimateWarTowerView:onEnter()
	UltimateWarTowerView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = UltimateWarController.instance:getActivityType()

	local isInTime = UltimateWarController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._ultimateWarMo = UltimateWarController.instance:getUltimateWarMo(self._activityId)
	self._actData = UltimateWarConfig.instance:getActData(self._activityId)
	self._isPlayingPlot = false

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarGetMainInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarSecondStepInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarGainTowerBossPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarFinishPlotRes, self._handlePM_UltimateWarFinishPlotRes, self)
	UltimateWarController.instance:sendPM_UltimateWarSecondStepInfoReq(self._activityId)
end

function UltimateWarTowerView:onExit()
	UltimateWarTowerView.super.onExit(self)
	self:_onClear()
end

function UltimateWarTowerView:_handlePM_UltimateWarFinishPlotRes(status, msg)
	self._isPlayingPlot = false

	if status ~= 0 then
		return
	end

	local storyId = UltimateWarConfig.instance:getPlotStoryId(msg.activityId, msg.plotId)

	GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
end

function UltimateWarTowerView:_onSetUI()
	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
end

function UltimateWarTowerView:_onUpdate()
	if not self._isPlayingPlot and not self._ultimateWarMo:isFinishPlotId(UltimateWarEnum.Story_Plot_2) then
		self._isPlayingPlot = true

		UltimateWarController.instance:sendPM_UltimateWarFinishPlotReq(self._activityId, UltimateWarEnum.Story_Plot_2)
	end

	local cfg = UltimateWarConfig.instance:getTowerCfg(self._activityId) or {}

	GameUtil.updateCellsList(self._towerView, self._towerCell, cfg, self._updateTowerCell, self)
	self:_updateBossCell(self._bossCell)
end

function UltimateWarTowerView:_onClear()
	GameUtil.clearCells(self._towerView, self._clearTowerCell, self)
	self:_clearBossCell(self._bossCell)
end

function UltimateWarTowerView:_updateTowerCell(mainGo, data, index)
	local towerId = data.towerId
	local towerInfo = self._ultimateWarMo:getTowerInfo(towerId)
	local imgTower = goutil.findChild(mainGo, "imgTower")
	local infoRoot = goutil.findChild(mainGo, "info")
	local txtProgress = goutil.findChildTextComponent(mainGo, "info/progress/txt")
	local imgPass = goutil.findChild(mainGo, "info/imgPass")
	local redpoint = goutil.findChild(mainGo, "info/progress/redpoint")

	if not data.pos then
		if not data.pos[3] then
			local x, y, scale = checknumber(data.pos[1]), checknumber(data.pos[2]), 1

			GameUtil.setLocalPos(mainGo, x, y, 0)
			GameUtil.setLocalScale(mainGo, data.pos[3], data.pos[3], data.pos[3])

			local cur = towerInfo:getMaxPassStageId()
			local max = towerInfo:getMaxStageCount()

			txtProgress.text = string.format("挑战进度：%s/%s", cur, max)

			GameUtil.SetActive(imgPass, towerInfo:isPassTower())
			GameUtil.SetActive(redpoint, towerInfo:isCanGetPrizeInTower())

			local spriteName = string.format("ui/bigbg/%s.png", data.icon)

			uGuiUtil.setSpriteToImage(imgTower, uGuiUtil.SpriteType.BigBg, spriteName, function()
				imgTower:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end)
			GameUtil.addClickHandler(imgTower, function()
				UIStateManager.instance:push(ViewName.UltimateWarTowerStageView, self._activityId, towerId)
			end)
		end
	end
end

function UltimateWarTowerView:_clearTowerCell(mainGo)
	local imgTower = goutil.findChild(mainGo, "imgTower")

	uGuiUtil.clearImage(imgTower)
	GameUtil.rmClickHandler(imgTower)
end

function UltimateWarTowerView:_updateBossCell(mainGo)
	local btn = goutil.findChild(mainGo, "btn")
	local con = goutil.findChild(mainGo, "btn/mask/con")
	local damage = goutil.findChild(mainGo, "damage")
	local txtDamage = goutil.findChildTextComponent(mainGo, "damage/txt")
	local imgPass = goutil.findChild(mainGo, "imgPass")
	local lock = goutil.findChild(mainGo, "btn/lock")
	local redpoint = goutil.findChild(mainGo, "btn/redpoint")
	local lockTips = goutil.findChild(mainGo, "lockTips")
	local creepsMasterId = UltimateWarConfig.instance:getTowerBossCreepsMasterId(self._activityId)
	local creepsCfg = UltimateWarConfig.instance:getCreepsData(creepsMasterId)
	local raceId = checknumber(creepsCfg[1].faceId)

	if raceId <= 0 then
		raceId = checknumber(creepsCfg[1].raceId)
	end

	MaterialMgr.setIcon(con, MatType.Pet, raceId, nil, nil)

	txtDamage.text = self._ultimateWarMo:getBossMaxDamageInSecond()

	local result = UltimateWarController.instance:getTryEnterSecondBossTowerResultAndTips(false, self._activityId)

	GameUtil.SetActive(lock, result ~= GameEnum.ResultCode.Success)
	GameUtil.SetActive(lockTips, result ~= GameEnum.ResultCode.Success)
	GameUtil.SetActive(damage, result == GameEnum.ResultCode.Success)
	RedPointController.instance:regRedPoint(redpoint, RedPointModel.ID_ULTIMATEWAR_SECONDSTEP_BOSSPRIZE)
	GameUtil.addClickHandler(btn, function()
		local result = UltimateWarController.instance:getTryEnterSecondBossTowerResultAndTips(true, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		UIStateManager.instance:push(ViewName.UltimateWarTowerBossView, self._activityId)
	end)
end

function UltimateWarTowerView:_clearBossCell(mainGo)
	local btn = goutil.findChild(mainGo, "btn")
	local con = goutil.findChild(mainGo, "btn/mask/con")
	local redpoint = goutil.findChild(mainGo, "btn/redpoint")

	RedPointController.instance:unregRedPoint(redpoint)
	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(btn)
end

function UltimateWarTowerView:_onClickBtnTip()
	local key = self._actData.secondStepRule

	TipsFacade.instance:openRulesView(key)
end

function UltimateWarTowerView:_onClickBtnRank()
	UltimateWarController.instance:openCommonTabRank(self._activityId, ViewName.UltimateWarTowerStageRankChildView)
end

function UltimateWarTowerView:_onClickBtnPrize()
	UIStateManager.instance:push(ViewName.UltimateWarTowerRankPrizeView, self._activityId)
end

return UltimateWarTowerView
