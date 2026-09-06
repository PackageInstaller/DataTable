-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/view/KingKaYaMainView.lua

module("logic.extensions.kingkaya.view.KingKaYaMainView", package.seeall)

local KingKaYaMainView = class("KingKaYaMainView", ViewComponent)

KingKaYaMainView.BtnExtPosXList = {
	313,
	465
}
KingKaYaMainView.BtnExtPosY = -249

function KingKaYaMainView:ctor()
	KingKaYaMainView.super.ctor(self)
end

function KingKaYaMainView:buildUI()
	KingKaYaMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._txtOpenTimeGo = self:getGo("txtOpenTime")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._redJum3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._redJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._redJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._btnClg1Go = goutil.findChild(self.mainGO, "btnClg1")
	self._btnBtnClg1 = goutil.findChild(self.mainGO, "btnClg1/btn")
	self._redClg1 = goutil.findChild(self.mainGO, "btnClg1/btn/redPoint")
	self._imgPassClg1 = goutil.findChild(self.mainGO, "btnClg1/btn/imgPass")
	self._bubbleClg1 = self:getGo("btnClg1/bubble")
	self._itemcellClg1 = goutil.findChild(self.mainGO, "btnClg1/bubble/itemcell")
	self._imgHasGainClg1 = goutil.findChild(self.mainGO, "btnClg1/bubble/imgHasGain")
	self._txtBubbleClg1 = goutil.findChildTextComponent(self.mainGO, "btnClg1/bubble/txt")
	self._btnBtnClg2 = goutil.findChild(self.mainGO, "btnClg2/btn")
	self._redClg2 = goutil.findChild(self.mainGO, "btnClg2/btn/redPoint")
	self._imgPassClg2 = goutil.findChild(self.mainGO, "btnClg2/btn/imgPass")
	self._rewardTip = self:getGo("desc/rewardTip")
end

function KingKaYaMainView:bindEvents()
	KingKaYaMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnBtnClg1, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._btnBtnClg2, self._onClickBtnClg2, self)
end

function KingKaYaMainView:unbindEvents()
	KingKaYaMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnBtnClg1)
	GameUtil.rmClickHandler(self._btnBtnClg2)
end

function KingKaYaMainView:onEnter()
	KingKaYaMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = KingKaYaController.instance:getActivityId()
	end

	self._activityType = KingKaYaController.instance:getActivityType()

	local isInTime = KingKaYaController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = KingKaYaConfig.instance:getActData(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_checkAoqiGodFinish()
	self:_onSetUI()
	self:_initAoqiGodUI()
	self.addGEvent(self, GlobalNotify.HandlePM_KingKaYaGetInfoRes, self._onUpdate, self)
	KingKaYaController.instance:sendPM_KingKaYaGetInfoReq(self._activityId)
end

function KingKaYaMainView:onExit()
	KingKaYaMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcellClg1)
	self:_unRegAllRedPoint()
end

function KingKaYaMainView:_checkAoqiGodFinish()
	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	if isAoqiGodProcessType then
		local pass = self:_checkIsAllDone()

		if pass then
			AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.KingKaYa, self._activityId)
		end
	end
end

function KingKaYaMainView:_initAoqiGodUI()
	GameUtil.setLocalPos(self._btnClg1Go, (self._isAoqiGodProcessType or nil) and KingKaYaMainView.BtnExtPosXList[2], KingKaYaMainView.BtnExtPosY, 0)
	GameUtil.SetActive(self._btnBtnClg2, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._txtOpenTimeGo, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._bubbleClg1, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._jumpBtnCol, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._rewardTip, not self._isAoqiGodProcessType)
end

function KingKaYaMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	local redInfoList = {}

	table.insert(redInfoList, {
		{
			KingKaYaConfig.instance:getCommonValue(self._activityId, "jumpRedIdOne")
		},
		self._redJum3
	})
	table.insert(redInfoList, {
		{
			KingKaYaConfig.instance:getCommonValue(self._activityId, "jumpRedIdTwo")
		},
		self._redJump2
	})
	table.insert(redInfoList, {
		{
			KingKaYaConfig.instance:getCommonValue(self._activityId, "jumpRedIdThree")
		},
		self._redJump3
	})

	for _, redInfo in ipairs(redInfoList) do
		local list = redInfo[1]
		local redGo = redInfo[2]
		local redIdList = {}

		for _, redId in ipairs(list) do
			if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
				table.insert(redIdList, redId)
			end
		end

		self:_regRedPoint(redGo, redIdList)
	end

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())

	MaterialMgr.setCellByCfg(self._actData.extremePassPrize, self._itemcellClg1)

	local matName = MaterialMgr.getMaterialsNameByCfg(self._actData.extremePassPrize)

	self._txtBubbleClg1.text = string.format("通关获得%s", matName)
end

function KingKaYaMainView:_onUpdate()
	local mo = KingKaYaController.instance:getKingKaYaMo(self._activityId)

	GameUtil.SetActive(self._imgHasGainClg1, mo:isPassAllStageInExt())

	local isNeedRed = false
	local cfg = KingKaYaConfig.instance:getNorProgressCfg(self._activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if mo:_isCanGetPrizeInNor(data.prizeId) then
				isNeedRed = true

				break
			end
		end
	end

	GameUtil.SetActive(self._redClg2, isNeedRed)
end

function KingKaYaMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function KingKaYaMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function KingKaYaMainView:_getRaceId()
	return KingKaYaController.instance:getRaceId(self._activityId)
end

function KingKaYaMainView:_getSkinId()
	return KingKaYaController.instance:getSkinId(self._activityId)
end

function KingKaYaMainView:_regRedPoint(redGo, redIdList)
	if #redIdList > 0 and not goutil.isNil(redGo) then
		RedPointController.instance:regRedPoint(redGo, unpack(redIdList))

		if self._redGoPool == nil then
			self._redGoPool = {}
		end

		self._redGoPool[redGo] = redGo
	end
end

function KingKaYaMainView:_unRegAllRedPoint()
	if self._redGoPool then
		for k, v in pairs(self._redGoPool) do
			RedPointController.instance:unregRedPoint(v)
		end

		table.clear(self._redGoPool)
	end
end

function KingKaYaMainView:_onClickBtnJump(key)
	local jumpToStr = KingKaYaConfig.instance:getCommonValue(self._activityId, key)

	GotoMgr.gotoByString(jumpToStr)
end

function KingKaYaMainView:_onClickBtnClg1()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.KingKaYa, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	UIStateManager.instance:push(ViewName.KingKaYaExtView, self._activityId)
end

function KingKaYaMainView:_onClickBtnClg2()
	UIStateManager.instance:push(ViewName.KingKaYaNorView, self._activityId)
end

function KingKaYaMainView:_onClickBtnTip()
	local key = KingKaYaConfig.instance:getCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

function KingKaYaMainView:_checkIsAllDone()
	local kayaMo = KingKaYaModel.instance:getKingKaYaMo(self._activityId)
	local extremeStageInfos = kayaMo.extremeStages
	local extStageCfgs = KingKaYaConfig.instance:getExtStageCfg(self._activityId)

	if extremeStageInfos then
		return #extremeStageInfos >= #extStageCfgs
	end

	return false
end

return KingKaYaMainView
