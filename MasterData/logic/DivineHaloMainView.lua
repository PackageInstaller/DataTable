-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehalogame/view/DivineHaloMainView.lua

module("logic.extensions.divinehalogame.view.DivineHaloMainView", package.seeall)

local DivineHaloMainView = class("DivineHaloMainView", ViewComponent)

function DivineHaloMainView:ctor()
	DivineHaloMainView.super.ctor(self)
end

function DivineHaloMainView:unbindEvents()
	DivineHaloMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump5)
end

function DivineHaloMainView:bindEvents()
	DivineHaloMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnJump5, GameUtil.handler(self._onClickBtnJump, self, 5))
	GameUtil.addClickHandler(self._btnJump4, self._showPlayRule, self)
end

function DivineHaloMainView:buildUI()
	DivineHaloMainView.super.buildUI(self)

	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txt")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump5 = self:getGo("jumpBtnCol/btnJump5")
	self._btnStart = self:getGo("btnStart")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._txtLeftPlayTime = self:getTxt("playTimes/txt")
	self._txtDayLoginTip = self:getTxt("dayLoginTip/txt")
	self._redpoint = self:getGo("btnStart/redpoint")
end

function DivineHaloMainView:onExit()
	DivineHaloMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
end

function DivineHaloMainView:onEnter()
	DivineHaloMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineHaloGameInfoRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 476001
	end

	self._activityType = GameEnum.ActivityType.DivineHaloGame
	self._actCfg = DivineHaloGameConfig.instance:getActData(self._activityId)
	self._stageCfg = DivineHaloGameConfig.instance:getStageDatas(self._activityId)

	self:_onSetUI()

	local key = string.format("DivineHaloMainView%s", self._activityId)

	local function firstCallback()
		self:_showPlayRule()
	end

	GameUtil.doCallbackWhenFirst(key, firstCallback)
	DivineHaloGameController.instance:sendPM_DivineHaloGameInfoReq(self._activityId)
end

function DivineHaloMainView:_onSetUI()
	if self._txtTime then
		self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	local skinId = self._actCfg.skinId
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	self._curRaceId = petSkinCfg and petSkinCfg.raceId
	self._curSkinId = self._actCfg.skinId
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)

	self._txtPetNameInInfo.text = petSkinCfg and petSkinCfg.name
	self._txtDayLoginTip.text = string.format("每日登录可获得%d次闯关次数", self._actCfg.dailyRegisterGainTimes)
end

function DivineHaloMainView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function DivineHaloMainView:_updateData()
	self._info = DivineHaloGameModel.instance:getInfo(self._activityId)
end

function DivineHaloMainView:_updateUI()
	self._txtLeftPlayTime.text = string.format("剩余闯关次数: <color=#E84642>%d/%d</color>", self._info.existingTimes, self._actCfg.storeTimesLimit)

	if self._stageCfg and self._info.passStageIds then
		local passAllLevel = #self._info.passStageIds >= #self._stageCfg
		local hasGameTime = self._info.existingTimes > 0

		GameUtil.SetActive(self._redpoint, not passAllLevel and hasGameTime)
	else
		GameUtil.SetActive(self._redpoint, false)
	end
end

function DivineHaloMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function DivineHaloMainView:_onClickBtnJump(jumpIdx)
	local btnStr = self._actCfg.jumpTo[jumpIdx]

	GotoMgr.gotoByString(btnStr)
end

function DivineHaloMainView:_showPlayRule()
	local ruleCfg = DivineHaloGameConfig.instance:getRuleDataById(self._actCfg.ruleId)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.resPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade.instance:openImageRuleView(ruleList, "游戏规则")
end

function DivineHaloMainView:_onClickBtnStart()
	UIStateManager.instance:push(ViewName.DivineHaloLevelView, self._activityId)
end

function DivineHaloMainView:_onClickBtnSkill()
	if self._curRaceId ~= 0 then
		if self._curRaceId == self._curSkinId then
			PetbookController.instance:previewBattle(self._curRaceId)
		else
			PetbookController.instance:previewBattle(self._curRaceId, self._curSkinId)
		end
	end
end

function DivineHaloMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._curRaceId)
end

return DivineHaloMainView
