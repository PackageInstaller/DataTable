-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/view/DivineMiMengLiClgMainView.lua

module("logic.extensions.divinemimengliclg.view.DivineMiMengLiClgMainView", package.seeall)

local DivineMiMengLiClgMainView = class("DivineMiMengLiClgMainView", ViewComponent)

function DivineMiMengLiClgMainView:buildUI()
	DivineMiMengLiClgMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTimeRoot = self:getGo("txtOpenTime")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._redBtnJump1 = self:getGo("jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._redBtnJump2 = self:getGo("jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._redBtnJump3 = self:getGo("jumpBtnCol/btnJump3/redPoint")
	self._btnStartGo = self:getGo("btnStart")
	self._btnStart = self:getGo("btnStart/btn")
	self._redBtnStart = self:getGo("btnStart/btn/redPoint")
	self._imgPassStart = self:getGo("btnStart/btn/imgPass")
end

function DivineMiMengLiClgMainView:bindEvents()
	DivineMiMengLiClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
end

function DivineMiMengLiClgMainView:unbindEvents()
	DivineMiMengLiClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg1_btn)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg2_btn)
end

function DivineMiMengLiClgMainView:onEnter()
	DivineMiMengLiClgMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DivineMiMengLiClgController.instance:getActivityId()
	end

	self._activityType = DivineMiMengLiClgController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local isInTime = DivineMiMengLiClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._divineMmlClgMo = DivineMiMengLiClgController.instance:getDivineMmlClgMo(self._activityId)
	self._actData = DivineMiMengLiClgConfig.instance:getActData(self._activityId)

	self:_onSetUI()
	self:_initAoqiGodUI()
	self.addGEvent(self, GlobalNotify.HandlePM_DivineMiMengLiClgGetInfoRes, self._onUpdate, self)
	DivineMiMengLiClgController.instance:sendPM_DivineMiMengLiClgGetInfoReq(self._activityId)

	local changeSetId = self._divineMmlClgMo:popChangeSetId()

	while changeSetId do
		MaterialController.instance:showChangeSetInTemp(changeSetId)

		changeSetId = self._divineMmlClgMo:popChangeSetId()
	end
end

function DivineMiMengLiClgMainView:onExit()
	DivineMiMengLiClgMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	RedPointController.instance:unregRedPoint(self._redBtnJump1)
	RedPointController.instance:unregRedPoint(self._redBtnJump2)
	RedPointController.instance:unregRedPoint(self._redBtnJump3)
end

function DivineMiMengLiClgMainView:_onSetUI()
	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local redInfoList = {
		{
			not string.nilorempty(self._actData.jumpRedIdOne) and string.split(self._actData.jumpRedIdOne, "#"),
			self._redBtnJump1
		},
		{
			not string.nilorempty(self._actData.jumpRedIdTwo) and string.split(self._actData.jumpRedIdTwo, "#"),
			self._redBtnJump2
		},
		{
			not string.nilorempty(self._actData.jumpRedIdThree) and string.split(self._actData.jumpRedIdThree, "#"),
			self._redBtnJump3
		}
	}

	for _, redInfo in ipairs(redInfoList) do
		local list = redInfo[1]
		local redGo = redInfo[2]

		if list then
			local redIdList = {}

			for _, redId in ipairs(list) do
				if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
					table.insert(redIdList, redId)
				end
			end

			if #redIdList > 0 and not goutil.isNil(redGo) then
				RedPointController.instance:regRedPoint(redGo, unpack(redIdList))
			end
		end
	end

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())
end

function DivineMiMengLiClgMainView:_initAoqiGodUI()
	local showNormalUI = not self._isAoqiGodProcessType

	GameUtil.SetActive(self._jumpBtnCol, showNormalUI)
	GameUtil.SetActive(self._txtOpenTimeRoot, showNormalUI)
end

function DivineMiMengLiClgMainView:_onUpdate()
	GameUtil.SetActive(self._imgPassStart, self._divineMmlClgMo:isPassChallenge())
end

function DivineMiMengLiClgMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function DivineMiMengLiClgMainView:_getSkinId()
	local data = DivineMiMengLiClgConfig.instance:getActData(self._activityId)

	return (data or nil) and (data.skinId or 0)
end

function DivineMiMengLiClgMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DivineMiMengLiClgMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineMiMengLiClgMainView:_onClickBtnJump(key)
	local jumpToStr = self._actData[key]

	GotoMgr.gotoByString(jumpToStr)
end

function DivineMiMengLiClgMainView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DivineMiMengLiClgMainView:_onClickBtnStart()
	if self._divineMmlClgMo:isPassChallenge() then
		if self._isAoqiGodProcessType then
			AoqiGodController.instance:doHandleChallengeFinishReady(DivineMiMengLiClgController.instance:getActivityType(), self._activityId)
		end

		FloatWordMgr.instance:show("挑战已完成")

		return
	end

	if not DivineMiMengLiClgController.instance:checkPassAoqiGodProcessResult(self._activityId) then
		return
	end

	UIStateManager.instance:push(ViewName.DivineMiMengLiClgStageView, self._activityId)
end

return DivineMiMengLiClgMainView
