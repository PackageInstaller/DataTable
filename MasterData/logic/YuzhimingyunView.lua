-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/planetarium/view/YuzhimingyunView.lua

module("logic.extensions.planetarium.view.YuzhimingyunView", package.seeall)

local YuzhimingyunView = class("YuzhimingyunView", PlanetariumGame)

function YuzhimingyunView:ctor()
	YuzhimingyunView.super.ctor(self)
end

function YuzhimingyunView:unbindEvents()
	YuzhimingyunView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReward)
end

function YuzhimingyunView:bindEvents()
	YuzhimingyunView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickReward, self)
end

function YuzhimingyunView:buildUI()
	YuzhimingyunView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txt")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnReward = self:getBtn("btnReward")
	self._rewardRd = self:getGo("btnReward/redpoint")
	self._success = self:getGo("success")
	self._btnSuccessClose = self:getBtn("success/btnClose")
	self._lock = self:getGo("lock")
	self._info = self:getGo("info")
	self._imgCard = self:getGo("info/imgCard")
	self._petIcon = self:getGo("info/petHead/icon")
	self._txtBubbleDesc = self:getTxt("info/bubble/txtDesc")
end

function YuzhimingyunView:onExit()
	YuzhimingyunView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._rewardRd)
	UIEffectManager.instance:stopEffect(self._effect)
	UIEffectManager.instance:stopEffect(self._passEffect)
	MaterialMgr.resetAll(self._petIcon)
	uGuiUtil.clearImage(self._imgCard.gameObject)
end

function YuzhimingyunView:onEnter()
	YuzhimingyunView.super.onEnter(self)

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	RedPointController.instance:regRedPoint(self._rewardRd, RedPointModel.ID_PLANETARIUM_REWARD)
	GameUtil.SetActive(self._success, false)
	self:_initUI()
	self:_showMainEffect()
	self:_refresh()
end

function YuzhimingyunView:_initData()
	self._activityId = 280003
	self._rulePlanId = PlanetariumConfig.instance:getRulePlanId(self._activityId)

	if not GameUtil.getUserDayData(ViewName.YuzhimingyunView .. "_" .. self._activityId) then
		self:_onClickTip()
		GameUtil.saveUserDayData(ViewName.YuzhimingyunView .. "_" .. self._activityId, true)
	end

	self._stageCfg = PlanetariumConfig.instance:getStageCfgById(self._activityId)
	self._stageId = PlanetariumModel.instance:getStageId()

	if self._stageId <= 0 then
		local id = checknumber(GameUtil.getUserDayData(ViewName.YuzhimingyunView))

		if id <= 0 then
			local randomNum = math.random(1, #self._stageCfg)

			self._stageId = self._stageCfg[randomNum].stageId

			GameUtil.saveUserDayData(ViewName.YuzhimingyunView, self._stageId)
		end
	end
end

function YuzhimingyunView:_initUI()
	GameUtil.SetActive(self._lock, not self._isSuccess)
	GameUtil.SetActive(self._info, self._isSuccess)

	local isHasPrize = PlanetariumController.instance:isHasPrizeCanReceive(self._activityId)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PLANETARIUM_REWARD, isHasPrize)
end

function YuzhimingyunView:_showMainEffect()
	local effectPath = "20230630/tianwenguanyouxi/fx_ui_tianwenguanyouxi_fw.prefab"

	self._effect = UIEffectManager.instance:playEffect(self, effectPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._effect:setParent(self.mainGO.transform)
	self._effect:setLocalPos(0, 0, 0)
	self._effect:setScale(1)
end

function YuzhimingyunView:_refresh()
	YuzhimingyunView.super._refresh(self)
	self:_initUI()

	if not self._isSuccess then
		self:_refreshStarMap()
		self:_startGame()
	else
		self:_initStarRingUI()
		self:_initStarRingAngle()
		self:_showDailyLuckInfo()
	end

	RedPointController.instance:unregRedPoint(self._rotateRd)
	GameUtil.SetActive(self._rotateRd, false)
end

function YuzhimingyunView:_passGameUI()
	YuzhimingyunView.super._passGameUI(self)

	local effectPath = "20230630/tianwenguanyouxi/fx_ui_tianwenguanyouxi_yuanpan.prefab"

	self._passEffect = UIEffectManager.instance:playEffect(self, effectPath, self.mainGO, 0, 0, false, nil, nil, nil, self)

	self._passEffect:setParent(self.mainGO.transform)
	self._passEffect:setLocalPos(0, 0, 0)
	self._passEffect:setScale(1)
	self:_showDailyLuckInfo()
end

function YuzhimingyunView:_showDailyLuckInfo()
	self._stageId = PlanetariumModel.instance:getStageId()

	local gameCfg = PlanetariumConfig.instance:getGameCfgByStageId(self._activityId, self._stageId)

	self._txtBubbleDesc.text = gameCfg.bubbleDesc

	MaterialMgr.setIcon(self._petIcon, MatType.Pet, gameCfg.raceId)
	uGuiUtil.setSpriteToImage(self._imgCard.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("views/game/guanxingzhanbu", gameCfg.luckyImg))
end

function YuzhimingyunView:_onClickClose()
	self:_endGame(self._isSuccess)
	self:close()
end

function YuzhimingyunView:_onClickTip()
	local list = {}
	local cfgs = PlanetariumConfig.instance:getGameRuleCfg(self._rulePlanId)

	for i, v in ipairs(cfgs) do
		local info = {}

		info.url = string.format("ui/bigbg/planetarium/%s.png", v.picturePath)
		info.desc = v.txtRule

		table.insert(list, info)
	end

	TipsFacade.instance:openImageRuleView(list)
end

function YuzhimingyunView:_onClickReward()
	UIStateManager.instance:push(ViewName.PlanetariumprizeView)
end

function YuzhimingyunView:_onClickCloseTip()
	GameUtil.SetActive(self._success, false)
	self:_showDailyLuckInfo()
end

return YuzhimingyunView
