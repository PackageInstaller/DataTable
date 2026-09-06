-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/view/KingjichallengemainView.lua

module("logic.extensions.kingjichallenge.view.KingjichallengemainView", package.seeall)

local KingjichallengemainView = class("KingjichallengemainView", ViewComponent)

function KingjichallengemainView:ctor()
	KingjichallengemainView.super.ctor(self)
end

function KingjichallengemainView:unbindEvents()
	KingjichallengemainView.super.unbindEvents(self)
	self._btnRank:RemoveClickListener()
	self._btnLottery:RemoveClickListener()
	self._btnAttr:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)

	for i, v in ipairs(self._btnChallengeItems) do
		GameUtil.rmClickHandler(v.go)
	end
end

function KingjichallengemainView:bindEvents()
	KingjichallengemainView.super.bindEvents(self)
	self._btnRank:AddClickListener(self._onClickbtnRank, self)
	self._btnLottery:AddClickListener(self._onClickbtnLottery, self)
	self._btnAttr:AddClickListener(self._onClickbtnAttr, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickPetInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)

	for i, v in ipairs(self._btnChallengeItems) do
		GameUtil.addClickHandler(v.go, GameUtil.handler(self._onClickbtnChallenge, self, i))
	end
end

function KingjichallengemainView:buildUI()
	KingjichallengemainView.super.buildUI(self)

	self._btnRank = self:getBtn("btnRank")
	self._btnLottery = self:getBtn("btnLottery")
	self._btnAttr = self:getBtn("btnAttr")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtTime = self:getTxt("time/txt")
	self._time = self:getGo("time")
	self._roleGo = self:getGo("role")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._petRareCon = self:getGo("petInfo/name/imgRare")
	self._txtName = self:getTxt("petInfo/name/txtName")

	self:_buildChallenge()
end

function KingjichallengemainView:_buildChallenge()
	self._btnChallengeItems = {}

	for i = 1, 3 do
		local go = self:getGo("btnChallenge" .. i)

		self._btnChallengeItems[i] = {
			go = go,
			goPass = goutil.findChild(go, "pass"),
			txtCost = goutil.findChildTextComponent(go, "txtCost"),
			txtOpen = goutil.findChildTextComponent(go, "txtOpen"),
			goRedpoint = goutil.findChild(go, "redpoint"),
			imgCostGo = goutil.findChild(go, "icon")
		}
	end
end

function KingjichallengemainView:onExit()
	KingjichallengemainView.super.onExit(self)
	MaterialMgr.resetAll(self._petRareCon)
end

function KingjichallengemainView:onEnter()
	KingjichallengemainView.super.onEnter(self)
	self.addGEvent(self, KingJiChallengeAgent.KingJiChallengeGetInfoRes, self._updateUI, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = self:_getActivityId()
	end

	self:_checkAoqiGodFinish()
	KingjichallengeModel.instance:setActivityId(self._activityId)

	self._activityCfg = KingjichallengeConfig.instance:getActivityCfg(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_updateUI()
	self:_setActTime()
	self:_setRole()
	KingJiChallengeAgent.instance:sendPM_KingJiChallengeGetInfoReq(self._activityId)
end

function KingjichallengemainView:_checkAoqiGodFinish()
	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	if isAoqiGodProcessType then
		local ronghePass = KingjichallengeController.instance:isChallengePass(GameEnum.KingjiChallengeType.Ronghe)

		if ronghePass then
			AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.KingJiChallenge, self._activityId)
		end
	end
end

function KingjichallengemainView:_updateUI()
	self._info = KingjichallengeModel.instance:getInfo()

	if not self._info then
		return
	end

	self:_updateBtnChallengeState()
	self:_aoqiGodTypeSetUI()
end

function KingjichallengemainView:_onClickbtnChallenge(challengeType)
	if not self._info then
		return
	end

	local item = self._btnChallengeItems[challengeType]

	if not string.nilorempty(item.txtOpen.text) then
		FloatWordMgr.instance:show(item.txtOpen.text)

		return
	end

	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.KingJiChallenge, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	if challengeType == GameEnum.KingjiChallengeType.Shizhe then
		UIStateManager.instance:push(ViewName.KingjichallengecourierView)
	elseif challengeType == GameEnum.KingjiChallengeType.Hun then
		UIStateManager.instance:push(ViewName.KingjichallengesoulView)
	elseif challengeType == GameEnum.KingjiChallengeType.Ronghe then
		UIStateManager.instance:push(ViewName.KingjimixView)
	end
end

function KingjichallengemainView:_onClickbtnRank()
	local str = KingjichallengeConfig.instance:getRankJumpTo(self._activityId)

	GotoMgr.gotoByString(str)
end

function KingjichallengemainView:_onClickbtnLottery()
	local str = KingjichallengeConfig.instance:getLotterJumpTo(self._activityId)

	GotoMgr.gotoByString(str)
end

function KingjichallengemainView:_onClickbtnAttr()
	local str = KingjichallengeConfig.instance:getAttrJumpTo(self._activityId)

	GotoMgr.gotoByString(str)
end

function KingjichallengemainView:_onClickbtnClose()
	self:close()
end

function KingjichallengemainView:_onClickbtnTip()
	local key = self._activityCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function KingjichallengemainView:_getActivityId()
	local activityType = GameEnum.ActivityType.KingJiChallenge
	local activityId = KingjichallengeModel.instance:getActivityId()

	if checknumber(activityId) <= 0 then
		return ActivityDefineController.instance:getActivityIdByType(activityType)
	end

	return activityId
end

function KingjichallengemainView:_updateBtnChallengeState()
	self:_updateBtnStateByType(GameEnum.KingjiChallengeType.Shizhe)
	self:_updateBtnStateByType(GameEnum.KingjiChallengeType.Hun)
	self:_updateBtnStateByType(GameEnum.KingjiChallengeType.Ronghe)
end

function KingjichallengemainView:_updateBtnStateByType(ctype)
	local item = self._btnChallengeItems[ctype]
	local costStr = ""
	local nowTime = ServerTime.now()
	local opentimeStr = ""
	local finalOpentimeStr = ""
	local redpointGo = item.goRedpoint
	local redpointId = 0

	if not self._isAoqiGodProcessType then
		if ctype == GameEnum.KingjiChallengeType.Shizhe then
			local prizeCfgs = KingjichallengeConfig.instance:getCourierPrizeCfgs(self._activityId)
			local count = 0

			for i, v in ipairs(prizeCfgs) do
				local _, _, num = MaterialMgr.getMatParams(v.prize)

				count = count + num
			end

			costStr = count
			opentimeStr = self._activityCfg.courierOpenTime
			redpointId = -367
		elseif ctype == GameEnum.KingjiChallengeType.Hun then
			local prizeCfgs = KingjichallengeConfig.instance:getSoulPrizeCfgs(self._activityId)
			local count = 0

			for i, v in ipairs(prizeCfgs) do
				local _, _, num = MaterialMgr.getMatParams(v.prize)

				count = count + num
			end

			costStr = count
			opentimeStr = self._activityCfg.soulOpenTime
			redpointId = -368
		elseif ctype == GameEnum.KingjiChallengeType.Ronghe then
			local prizeCfgs = KingjichallengeConfig.instance:getMixStageCfgs(self._activityId)
			local count = 0

			for i, v in ipairs(prizeCfgs) do
				local _, _, num = MaterialMgr.getMatParams(v.stagePrize)

				count = count + num
			end

			costStr = count
			opentimeStr = self._activityCfg.mixOpenTime
			redpointId = -369
		end
	end

	local time = GameUtil.string2time(opentimeStr)

	if nowTime < time then
		local date = GameUtil.time2date(time)

		finalOpentimeStr = string.format("%s月%s日开启", date.month, date.day)
	end

	item.txtCost.text = costStr
	item.txtOpen.text = finalOpentimeStr

	goutil.setActive(item.goPass, false)
	goutil.setActive(item.imgCostGo, not self._isAoqiGodProcessType)
	goutil.setActive(item.txtCost.gameObject, not self._isAoqiGodProcessType)

	if self._isAoqiGodProcessType and ctype ~= GameEnum.KingjiChallengeType.Ronghe then
		goutil.setActive(item.go, false)
	else
		goutil.setActive(item.go, true)
	end

	GameUtil.SetGray(item.go, not string.nilorempty(finalOpentimeStr))
	RedPointController.instance:regRedPoint(redpointGo, redpointId)
end

function KingjichallengemainView:_setActTime()
	if self._isAoqiGodProcessType then
		return
	end

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function KingjichallengemainView:_setRole()
	self._raceId = KingjichallengeConfig.instance:getActShowRaceId(self._activityId)

	local cfg = KingjichallengeConfig.instance:getActivityCfg(self._activityId)

	if not cfg.posAndScale then
		if not cfg.posAndScale[3] then
			local x, y, scale = cfg.posAndScale[1] or 0, cfg.posAndScale[2] or 0, 1

			self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._raceId, self._roleGo, scale, nil, true, x, y)

			MaterialMgr.setCell(MatType.Rare, self._raceId, self._petRareCon)

			self._txtName.text = PetSkinConfig.instance:getPetSkinName(self._raceId)
		end
	end
end

function KingjichallengemainView:_onClickPetInfo()
	local raceId = self._raceId

	if checknumber(raceId) > 0 then
		PetbookController.instance:openPetinfoView(raceId)
	end
end

function KingjichallengemainView:_onClickSkill()
	local raceId = self._raceId

	if checknumber(raceId) > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function KingjichallengemainView:_aoqiGodTypeSetUI()
	GameUtil.SetActive(self._btnLottery.gameObject, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._btnRank.gameObject, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._time, not self._isAoqiGodProcessType)
end

return KingjichallengemainView
