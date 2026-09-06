-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinecoronate/view/DivineCoronateGameView.lua

module("logic.extensions.divinecoronate.view.DivineCoronateGameView", package.seeall)

local DivineCoronateGameView = class("DivineCoronateGameView", PlanetariumView)

function DivineCoronateGameView:onEnter()
	DivineCoronateGameView.super.onEnter(self)

	self._params = self:getOpenParam()

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Planetarium, self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))

	RedPointController.instance:regRedPoint(self._rewardRd, RedPointModel.ID_PLANETARIUM_REWARD)
	GameUtil.SetActive(self._success, false)
	self:_initUI()
	self:_showMainEffect()
end

function DivineCoronateGameView:_initData()
	print("DivineCoronateGameView:_initData")

	local params = self:getOpenParam()

	if params and #params >= 3 then
		self._rootActId = params[1]
		self._activityId = params[2]
		self._stageId = params[3]
	end

	self._activityId = self._activityId or ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.Planetarium)
	self._rulePlanId = PlanetariumConfig.instance:getRulePlanId(self._activityId)

	if not GameUtil.getUserDayData(ViewName.PlanetariumView .. "_" .. self._activityId) then
		self:_onClickTip()
		GameUtil.saveUserDayData(ViewName.PlanetariumView .. "_" .. self._activityId, true)
	end

	self._stageCfg = PlanetariumConfig.instance:getStageCfgById(self._activityId)
	self._stageId = self._stageId or PlanetariumModel.instance:getStageId()

	if self._stageId <= 0 then
		local id = checknumber(GameUtil.getUserDayData(ViewName.PlanetariumView))

		if id <= 0 then
			math.randomseed(tostring(os.time()):reverse():sub(1, 7))

			local randomNum = math.random(1, #self._stageCfg)

			self._stageId = self._stageCfg[randomNum].stageId

			GameUtil.saveUserDayData(ViewName.PlanetariumView, self._stageId)
		end
	end

	self.addGEvent(self, GlobalNotify.DivineCoronateStartGameRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.DivineCoronateEndGameRes, self._endRefresh, self)
	print("self._rootActId", self._rootActId, "self._activityId", self._activityId, "self._stageId", self._stageId)
end

function DivineCoronateGameView:_sendGameStartReq()
	print("DivineCoronateGameView:_sendGameStartReq")
	DivineCoronateAgent.instance:sendPM_DivineCoronateStartGameReq(self._rootActId, self._clientKey)
end

function DivineCoronateGameView:_sendGameEndReq()
	print("DivineCoronateGameView:_sendGameEndReq")

	local severKey = DivineCoronateModel.instance:getMyServerKey(self._rootActId)
	local scoreNum = self._isSuccess and 1 or 0
	local encryptedKey = GameUtil.getClientEncryptedKey(self._clientKey, severKey, {
		scoreNum
	})

	DivineCoronateAgent.instance:sendPM_DivineCoronateEndGameReq(self._rootActId, self._isSuccess, encryptedKey)
end

function DivineCoronateGameView:_sendGetInfoReq()
	print("DivineCoronateGameView:_sendGetInfoReq")
	self:_refresh()
end

function DivineCoronateGameView:_initUI()
	GameUtil.SetActive(self._lock, not self._isSuccess)
	GameUtil.SetActive(self._info, self._isSuccess)
end

function DivineCoronateGameView:_refreshGameResult()
	self._isSuccess = DivineCoronateModel.instance:getGameResult(self._rootActId) or false

	print("self._isSuccess", self._isSuccess)
end

function DivineCoronateGameView:_setStarRingUI(id)
	local goStar = self._starMap[id].go

	if not goStar then
		return
	end

	local bgName = "board_shenyaojiamian_04"

	if id == 2 then
		bgName = "board_shenyaojiamian_03"
	elseif id == 3 then
		bgName = "board_shenyaojiamian_02"
	end

	local function setSizeFunc()
		local image = goStar:GetComponent(goutil.Type_UIImage)

		if image then
			image:SetNativeSize()
		end
	end

	uGuiUtil.setSpriteToImage(goStar, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("planetarium", bgName), setSizeFunc)
end

function DivineCoronateGameView:_passGameUI()
	self._isGameStart = false

	local effectPath = "20230630/tianwenguanyouxi/fx_ui_tianwenguanyouxi_yuanpan.prefab"

	self._passEffect = UIEffectManager.instance:playEffect(self, effectPath, self.mainGO, 0, 0, false, nil, nil, nil, self)

	self._passEffect:setParent(self.mainGO.transform)
	self._passEffect:setLocalPos(-46, -24, 0)
	self._passEffect:setScale(1)
	settimer(3, self._showSucessTip, self, false)
	self:_showDailyLuckInfo()
end

return DivineCoronateGameView
