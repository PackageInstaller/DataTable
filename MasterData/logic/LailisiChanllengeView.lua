-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/LailisiChanllengeView.lua

module("logic.extensions.lailisi.view.LailisiChanllengeView", package.seeall)

local LailisiChanllengeView = class("LailisiChanllengeView", ViewComponent)

function LailisiChanllengeView:ctor()
	LailisiChanllengeView.super.ctor(self)
end

function LailisiChanllengeView:unbindEvents()
	LailisiChanllengeView.super.unbindEvents(self)
	self._rankBtn:RemoveClickListener()
	self._taskBtn:RemoveClickListener()
	self._tipBtn:RemoveClickListener()
	self._closeBtn:RemoveClickListener()
end

function LailisiChanllengeView:bindEvents()
	LailisiChanllengeView.super.bindEvents(self)
	self._rankBtn:AddClickListener(self._onClickRank, self)
	self._taskBtn:AddClickListener(self._onClickTask, self)
	self._tipBtn:AddClickListener(self._onClickTip, self)
	self._closeBtn:AddClickListener(function()
		self:close()
	end, self)
end

function LailisiChanllengeView:onExit()
	LailisiChanllengeView.super.onExit(self)

	for _, v in pairs(self._cellList) do
		MaterialMgr.clearIcon(v)
	end

	self._playerSliderMo:onExit()
	RoleObjectPool.instance:removeRole(self._roleObj)
	LailisiController.instance:stopEffect()
	GlobalDispatcher:removeListener(GlobalNotify.LailisiProgress, self._updateInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.LailisiChallengeTask, self.updateTaskRedPoint, self)
end

function LailisiChanllengeView:buildUI()
	LailisiChanllengeView.super.buildUI(self)

	local playerRoot = self:getGo("bottom/playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._fmoInfo = self:getGo("info")
	self._roleConGo = self:getGo("con")
	self._powerTable = self:getGo("powerDesc/tableview")
	self._powerCell = self:getGo("powerDesc/cell")
	self._taskBtnRedpoint = self:getGo("bottom/btnTask/redpoint")
	self._rankBtn = self:getBtn("bottom/btnRank")
	self._taskBtn = self:getBtn("bottom/btnTask")
	self._tipBtn = self:getBtn("txtTitle/btnTip")
	self._closeBtn = self:getBtn("btnClose")
	self._levelDesc = self:getTxt("desc/txt")
	self._titleTxt = self:getTxt("txtTitle")
	self._txtTotal = self:getTxt("bottom/txtTotal")
	self._bubbleTxt = self:getTxt("bubble/txtDesc")
	self._powerScroll = ScrollerList.create(self._powerTable, self._powerCell, GameUtil.handler(self._updateItem, self), GameUtil.handler(self._clearItemCell, self))
end

function LailisiChanllengeView:getFinalActivity()
	self._actInfo = LailisiModel.instance:getFinalActivity()
end

function LailisiChanllengeView:onEnter()
	LailisiChanllengeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.LailisiProgress, self._updateInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.LailisiChallengeTask, self.updateTaskRedPoint, self)

	self._cellList = {}

	self:getFinalActivity()

	self._activityId = self._actInfo.activityId
	self._challengeTimes = LailisiModel.instance:getPetProgress(self._activityId)
	self._actCfg = LailisiConfig.instance:getActivityCfgById(self._activityId)

	local cfg = LailisiModel.instance:getBuffcfgsBuyActId(self._activityId)

	self._powerScroll:reloadData(cfg)
	self:_initPlayerParams()
	self:_updateFormation()
	self:_setRole()
	self:_initViewInfo()
	self:updateTaskRedPoint()
end

function LailisiChanllengeView:_initViewInfo()
	self._titleTxt.text = self._actCfg.checkpointsName
	self._levelDesc.text = self._actCfg.ruleDescription
	self._txtTotal.text = self._challengeTimes.progress
	self._bubbleTxt.text = self._actCfg.content

	LailisiController.instance:setChanllengeRedPointState()
	self:_showEffect()
end

function LailisiChanllengeView:_showEffect()
	LailisiController.instance:showUIEff(self.mainGO, "fx_ui_xjs_lls.prefab", self)
end

function LailisiChanllengeView:_updateInfo()
	self._playerSliderMo:updatePlayerReward()
end

function LailisiChanllengeView:updateTaskRedPoint()
	local isOpen = LailisiController.instance:getTaskRedPointState()

	goutil.setActive(self._taskBtnRedpoint, isOpen)
end

function LailisiChanllengeView:_initPlayerParams()
	local param = {}

	param.view = self
	param.prizeCfgs = LailisiConfig.instance:getRewardPrize(self._actInfo.activityId)

	function param.getPlayerProgress()
		local progress = LailisiModel.instance:getPetProgress(self._actInfo.activityId)

		return progress.progress
	end

	function param.getNeedScoreByRewardCfg(cfg)
		return cfg.damage
	end

	function param.isPlayerRewardCanGet(cfg)
		return LailisiModel.instance:isPlayerRewardCanGet(self._actInfo.activityId, cfg.id, cfg.damage)
	end

	function param.isPlayerRewardGeted(cfg)
		return LailisiModel.instance:isPlayerRewardGetedWithId(self._actInfo.activityId, cfg.id)
	end

	function param.sendGainPlayerPrizeReq(cfg)
		LailisiController.instance:sendPM_ActorGainGetProgressAwardReq(self._actInfo.activityId, cfg.id)
	end

	function param.parseGetProgress(cfg)
		return StringUtil.numberToString(cfg.damage)
	end

	self._playerSliderMo:initParam(param, true)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function LailisiChanllengeView:_updateFormation()
	local formation = goutil.findChild(self._fmoInfo, "formation")
	local txtNum = goutil.findChildTextComponent(self._fmoInfo, "txtNum")
	local level = goutil.findChildTextComponent(self._fmoInfo, "level/txtLevel")
	local allChallengeTimes = self._actCfg.challengeDailyTimes

	txtNum.text = string.format("今日剩余<color=#eb4642>%s/%s</color>", allChallengeTimes - self._challengeTimes.challengeTimes, allChallengeTimes)
	self._cellList = {}

	for i = 1, 9 do
		local obj = goutil.findChild(formation, string.format("cell_%d/con", i))

		MaterialMgr.resetAll(obj)
		obj.transform.parent.gameObject:SetActive(false)

		self._cellList[i] = obj
	end

	local creepInfo = LailisiConfig.instance:getTeamInfo(self._actInfo.activityId, 1)
	local creepCfgs = LailisiConfig.instance:getPetCreeps(creepInfo.creepsMasterId)

	for i, v in ipairs(creepCfgs) do
		local raceId, posId = v.raceId, v.posId
		local obj = self._cellList[posId]

		obj.transform.parent.gameObject:SetActive(true)
		MaterialMgr.setIcon(obj, MatType.PET_SKIN, (checknumber(v.faceId) > 0 or nil) and checknumber(v.faceId))
	end

	GameUtil.asBtn(formation):RemoveClickListener()
	GameUtil.asBtn(formation):AddClickListener(function()
		LailisiModel.instance._curActId = self._actInfo.activityId

		CustomFmtController.instance:showMissionView(LailisiModel.instance:getCustomFmtMo(self._actInfo.activityId, 1))
	end)
end

function LailisiChanllengeView:_updateItem(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local txt = goutil.findChildTextComponent(cell, "txt")
	local cfg = LailisiConfig.instance:getActivityCfgById(data.activityId)
	local buffId = LailisiModel.instance:getBuffId(data.activityId)
	local buffcfg = LailisiConfig.instance:getBuffCfg(data.activityId, buffId)
	local pageTips = string.split(cfg.pageTips, "#")

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("challenge", cfg.petIcon))

	if buffcfg then
		txt.text = buffcfg.desc or "还未获得"
	end
end

function LailisiChanllengeView:_clearItemCell()
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
end

function LailisiChanllengeView:_setRole()
	local skinId = self._actCfg.challengePet

	uGuiUtil.clearImage(self._roleConGo)
	uGuiUtil.setSpriteToImage(self._roleConGo, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/challenge/%s.png", skinId))
end

function LailisiChanllengeView:_onClickRank()
	UIStateManager.instance:push(ViewName.LailisiScoreRankView, self._activityId)
end

function LailisiChanllengeView:_onClickTask()
	UIStateManager.instance:push(ViewName.LailisiTaskView, self._activityId)
end

function LailisiChanllengeView:_onClickTip()
	local ruleName = self._actCfg.ruleId

	TipsFacade.instance:openRulesView(ruleName)
end

return LailisiChanllengeView
