-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedakinosclg/view/DivineDakinosClgMainView.lua

module("logic.extensions.divinedakinosclg.view.DivineDakinosClgMainView", package.seeall)

local DivineDakinosClgMainView = class("DivineDakinosClgMainView", ViewComponent)

function DivineDakinosClgMainView:ctor()
	DivineDakinosClgMainView.super.ctor(self)
end

function DivineDakinosClgMainView:unbindEvents()
	DivineDakinosClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump4)

	for i, v in ipairs(self._stageList) do
		GameUtil.rmClickHandler(v.btnChallenge)
	end
end

function DivineDakinosClgMainView:bindEvents()
	DivineDakinosClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFour"))

	for i, v in ipairs(self._stageList) do
		GameUtil.addClickHandler(v.btnChallenge, GameUtil.handler(self._onClickbtnChallenge, self, i))
	end
end

function DivineDakinosClgMainView:buildUI()
	DivineDakinosClgMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnCol_btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._jumpBtnCol_btnJump4 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4")
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._jumpBtnCol_btnJump4_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4/redPoint")
	self._buffRoot = self:getGo("buffRoot")
	self._stageList = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("stages/stage_" .. i)
		cell.saveNum = goutil.findChild(cell.go, "saveNum")
		cell.txtSaveNum = goutil.findChildTextComponent(cell.go, "saveNum/txt")
		cell.pass = goutil.findChild(cell.go, "pass")
		cell.openTip = goutil.findChild(cell.go, "openTip")
		cell.txtOpenTip = goutil.findChildTextComponent(cell.go, "openTip/txtTime")
		cell.btnChallenge = goutil.findChild(cell.go, "btnChallenge")
		self._stageList[i] = cell
	end
end

function DivineDakinosClgMainView:onExit()
	DivineDakinosClgMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._clgBtnCol_btnClg1_bubble_itemcell)
end

function DivineDakinosClgMainView:onEnter()
	DivineDakinosClgMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_updateUIByCfg()
	SignInBuffController.instance:addCommonSignInBuffView(self._buffRoot, self._viewPresentor, self._activityId)
	self.addGEvent(self, GlobalNotify.DivineDakinosClgGetInfo, self._updateUIByInfo, self)
	DivineDakinosClgController.instance:sendPM_DivineDakinosClgGetInfoReq(self._activityId)
end

function DivineDakinosClgMainView:_updateUIByCfg()
	self._actCfg = DivineDakinosClgConfig.instance:getActCfg(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
	self._txtPetNameInInfo.text = ""

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)

		self._txtPetNameInInfo.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, skinId)
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.DivineDakinosClg, self._activityId)
	local timeNow = ServerTime.now()

	for i, v in ipairs(self._stageList) do
		local cfg = DivineDakinosClgConfig.instance:getPhaseCfg(self._activityId, i)
		local stageStartTime = startTime + (cfg.openDays - 1) * 24 * 60 * 60
		local startDate = GameUtil.time2date(stageStartTime)

		v.txtOpenTip.text = string.format("%s.%02d.%02d后开启", startDate.year, startDate.month, startDate.day)

		goutil.setActive(v.openTip, timeNow < stageStartTime)
		goutil.setActive(v.saveNum, stageStartTime <= timeNow)
	end
end

function DivineDakinosClgMainView:_updateUIByInfo()
	local pb = DivineDakinosClgModel.instance:getInfo(self._activityId) or {}
	local phaseInfoMap = {}

	for i, info in ipairs(pb.phaseList or {}) do
		phaseInfoMap[info.phaseId] = info
	end

	local cfg = DivineDakinosClgConfig.instance:getActCfg(self._activityId) or {}

	if not cfg.lockDesc then
		local lockDesc = ""

		for i, v in ipairs(self._stageList) do
			local info = phaseInfoMap[i]

			goutil.setActive(v.pass, false)

			local saveNum = 0

			if info then
				goutil.setActive(v.pass, info.gainPrize)

				for k, saveInfo in ipairs(info.stageIdAndSaveCount) do
					saveNum = saveNum + saveInfo.right
				end
			end

			v.txtSaveNum.text = string.format("已拯救%s名%s", saveNum, lockDesc)
		end
	end
end

function DivineDakinosClgMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId ~= 0 then
		if raceId == skinId then
			PetbookController.instance:previewBattle(raceId)
		else
			PetbookController.instance:previewBattle(raceId, skinId)
		end
	end
end

function DivineDakinosClgMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineDakinosClgMainView:_getRaceId()
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self:_getSkinId())

	return petSkinCfg and petSkinCfg.raceId
end

function DivineDakinosClgMainView:_getSkinId()
	return self._actCfg.skinId
end

function DivineDakinosClgMainView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	if not GameUtil.isEmptyString(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function DivineDakinosClgMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DivineDakinosClgMainView:_onClickbtnChallenge(stageId)
	local info = DivineDakinosClgModel.instance:getPhaseInfo(self._activityId, stageId)

	if info then
		if info.gainPrize then
			FloatWordMgr.instance:show("已通关")

			return
		end

		local cellStage = self._stageList[stageId]

		if GameUtil.GetActive(cellStage.openTip) then
			FloatWordMgr.instance:show(cellStage.txtOpenTip.text)

			return
		end

		self:_onOpenClgStageView(stageId)
	end
end

function DivineDakinosClgMainView:_onOpenClgStageView(stageId)
	UIStateManager.instance:push(ViewName.DivineDakinosClgStageView, self._activityId, stageId)
end

return DivineDakinosClgMainView
