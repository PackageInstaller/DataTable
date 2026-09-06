-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishihud/view/SkillMatchMainView.lua

module("logic.extensions.dragonkingaruishihud.view.SkillMatchMainView", package.seeall)

local SkillMatchMainView = class("SkillMatchMainView", ViewComponent)

function SkillMatchMainView:ctor()
	SkillMatchMainView.super.ctor(self)
end

function SkillMatchMainView:unbindEvents()
	SkillMatchMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnStartGame)
end

function SkillMatchMainView:bindEvents()
	SkillMatchMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnStartGame, self._onClickBtnStartGame, self)
end

function SkillMatchMainView:buildUI()
	SkillMatchMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnInfo")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._showConBubble = self:getGo("startGame/bubble/showCon")
	self._passBubble = self:getGo("startGame/bubble/pass")
	self._btnStartGame = self:getGo("startGame/btn")
end

function SkillMatchMainView:onExit()
	SkillMatchMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._showConBubble)
end

function SkillMatchMainView:onEnter()
	SkillMatchMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 506001
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self.addGEvent(self, GlobalNotify.DragonKingARuiShiHUDUpdateInfo, self._updateUIByInfo, self)
	self:_updateUIByCfg()
	self:_updateUIByInfo()
	DragonKingARuiShiHUDController.instance:getInfo(self._activityId)
end

function SkillMatchMainView:_updateUIByCfg()
	self._actCfg = DragonKingARuiShiHUDConfig.instance:getActviityCfg(self._activityId)
	self._curSkinId = self._actCfg.skinId

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSkinId)

	self._curRaceId = petSkinCfg and petSkinCfg.raceId

	MaterialMgr.setCell(MatType.Rare, self._curSkinId, self._pointRare)

	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._txtPetNameInInfo.text = petSkinCfg and petSkinCfg.name

	MaterialMgr.setCellByCfg(self._actCfg.prize, self._showConBubble)

	local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("display", self._curSkinId)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])

	goutil.setActive(self._bubble, not GameUtil.isEmptyString(self._actCfg.prize))
end

function SkillMatchMainView:_updateUIByInfo()
	self._isPass = true

	local info = DragonKingARuiShiHUDModel.instance:getBaseInfo(self._activityId)

	if info then
		self._isPass = info.gainedPrize
	end

	goutil.setActive(self._passBubble, self._isPass)
end

function SkillMatchMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function SkillMatchMainView:_onClickBtnStartGame()
	if self._isPass then
		TipsFacade.instance:openCommonTips("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.SkillMatchGameView, self._activityId)
end

function SkillMatchMainView:_onClickBtnSkill()
	if self._curRaceId ~= 0 then
		if self._curRaceId == self._curSkinId then
			PetbookController.instance:previewBattle(self._curRaceId)
		else
			PetbookController.instance:previewBattle(self._curRaceId, self._curSkinId)
		end
	end
end

function SkillMatchMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._curRaceId)
end

return SkillMatchMainView
