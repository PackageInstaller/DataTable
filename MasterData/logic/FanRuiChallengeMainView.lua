-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/view/FanRuiChallengeMainView.lua

module("logic.extensions.fanruichallenge.view.FanRuiChallengeMainView", package.seeall)

local FanRuiChallengeMainView = class("FanRuiChallengeMainView", ViewComponent)

function FanRuiChallengeMainView:buildUI()
	FanRuiChallengeMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._con = self:getGo("con")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rare = self:getGo("petInfo/pointRare")
	self._txtName = self:getTxt("petInfo/txtName")
	self._txtTime = self:getTxt("time/txt")
	self._btnSummon = self:getBtn("btnSummon")
	self._btnRank = self:getBtn("btnRank")
	self._btnCultivate = self:getBtn("btnCultivate")
	self._levelList = {}

	for i = 1, 3 do
		local go = self:getGo("btn" .. i)
		local item = {}

		item.btn = Framework.ButtonAdapter.Get(go)
		item.txtNum = MaterialMgr.findGraphicText(go, "txtNum")
		item.lock = goutil.findChild(go, "lock")
		item.txtLock = goutil.findChildTextComponent(item.lock, "txt")
		item.pass = goutil.findChild(go, "pass")

		table.insert(self._levelList, item)
	end
end

function FanRuiChallengeMainView:bindEvents()
	FanRuiChallengeMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnSummon:AddClickListener(self._onClickSummon, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnCultivate:AddClickListener(self._onClickCultivate, self)

	for i = 1, 3 do
		self._levelList[i].btn:AddClickListener(function()
			self:_onClickLevel(i)
		end)
	end
end

function FanRuiChallengeMainView:unbindEvents()
	FanRuiChallengeMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnSummon:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnCultivate:RemoveClickListener()

	for i = 1, 3 do
		self._levelList[i].btn:RemoveClickListener()
	end
end

function FanRuiChallengeMainView:onEnter()
	FanRuiChallengeMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FanRuiClgGetInfoRes, self._onGetInfoRes, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = FanRuiChallengeModel.instance:getActivityId()
	end

	self._activityType = FanRuiChallengeModel.instance:getActivityType()
	self._cfgActivity = FanRuiChallengeConfig.instance:getActivityCfg(self._activityId)

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(self._activityType, self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	self._challengeId = self._cfgActivity.challengeId
	self._cfgChallenge = TimeLimitedConfig.instance:getCfgById(self._challengeId) or {}
	self._raceId = self._cfgChallenge.raceId
	self._isRecieveRes = false

	self:_showRoleModel()
	self:_initPetInfo()
	self:_initActivityTime()
	self:_initBtns()
	self:_updateBtnStates()
	FanRuiChallengeAgent.instance:sendPM_FanRuiClgGetInfoReq(self._activityId)
end

function FanRuiChallengeMainView:onExit()
	FanRuiChallengeMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FanRuiClgGetInfoRes, self._onGetInfoRes, self)
	self:_resetRoleModel()
end

function FanRuiChallengeMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "fanruichallengemaiview_rule")
end

function FanRuiChallengeMainView:_onClickInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function FanRuiChallengeMainView:_onClickSkill()
	if self._raceId then
		PetbookController.instance:previewBattle(self._raceId, self._skinId)
	end
end

function FanRuiChallengeMainView:_onClickSummon()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo1)
end

function FanRuiChallengeMainView:_onClickRank()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo2)
end

function FanRuiChallengeMainView:_onClickCultivate()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo3)
end

function FanRuiChallengeMainView:_onClickLevel(index)
	if not self._isRecieveRes then
		return
	end

	if not FanRuiChallengeModel.instance:isBigLevelUnlock(self._activityId, index) then
		FloatWordMgr.instance:show("未解锁")

		return
	end

	if FanRuiChallengeModel.instance:isPassBigLevel(self._activityId, index) then
		FloatWordMgr.instance:show("已通关")

		return
	end

	if index == FanRuiChallengeModel.StageLife then
		UIStateManager.instance:push(ViewName.FanRuiChallengeLifeView, self._activityId)
	elseif index == FanRuiChallengeModel.StageDestiny then
		UIStateManager.instance:push(ViewName.FanRuiChallengeDestinyView, self._activityId)
	elseif index == FanRuiChallengeModel.StageControl then
		UIStateManager.instance:push(ViewName.FanRuiChallengeControlView, self._activityId)
	end
end

function FanRuiChallengeMainView:_onGetInfoRes()
	self._isRecieveRes = true

	self:_updateBtnStates()
end

function FanRuiChallengeMainView:_showRoleModel()
	local curFaceId = self._raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, true, x, y)
end

function FanRuiChallengeMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function FanRuiChallengeMainView:_initPetInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._raceId, self._rare)
end

function FanRuiChallengeMainView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function FanRuiChallengeMainView:_initBtns()
	for i, v in ipairs(self._levelList) do
		local matType, id, matNum = MaterialMgr.getMatParams(self._cfgActivity["reward" .. i])

		v.txtNum.text = string.format("<quad name=%d:%d|icon size=40 width=1 offsetY=-13/>%d", matType, id, matNum)
	end
end

function FanRuiChallengeMainView:_updateBtnStates()
	for i, v in ipairs(self._levelList) do
		local isUnlock = FanRuiChallengeModel.instance:isBigLevelUnlock(self._activityId, i)

		goutil.setActive(v.lock, not isUnlock)
		goutil.setActive(v.pass, FanRuiChallengeModel.instance:isPassBigLevel(self._activityId, i))

		if not isUnlock then
			local curTimestamp = ServerTime.now()
			local startTimestamp = ServerTime.now()
			local date

			if i == 2 then
				startTimestamp = GameUtil.string2time(self._cfgActivity.themeDestinyOpenTime)
				date = GameUtil.string2date(self._cfgActivity.themeDestinyOpenTime)
			elseif i == 3 then
				startTimestamp = GameUtil.string2time(self._cfgActivity.themeControlOpenTime)
				date = GameUtil.string2date(self._cfgActivity.themeControlOpenTime)
			end

			v.txtLock.text = date and string.format("%02d月%02d日 5:00 解锁", date.month, date.day) or "--"
		end
	end
end

return FanRuiChallengeMainView
