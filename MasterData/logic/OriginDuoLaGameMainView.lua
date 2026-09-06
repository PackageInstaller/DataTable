-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originduolagame/view/OriginDuoLaGameMainView.lua

module("logic.extensions.originduolagame.view.OriginDuoLaGameMainView", package.seeall)

local OriginDuoLaGameMainView = class("OriginDuoLaGameMainView", ViewComponent)

function OriginDuoLaGameMainView:ctor()
	OriginDuoLaGameMainView.super.ctor(self)
end

function OriginDuoLaGameMainView:unbindEvents()
	OriginDuoLaGameMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
end

function OriginDuoLaGameMainView:bindEvents()
	OriginDuoLaGameMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, 4))
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
end

function OriginDuoLaGameMainView:buildUI()
	OriginDuoLaGameMainView.super.buildUI(self)

	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnClg = self:getGo("btnClg")
	self._txtCurTimes = self:getTxt("curtimes/txt")
	self._txtNamePetInfo = self:getTxt("petInfo/txtName")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._con = self:getGo("con")
end

function OriginDuoLaGameMainView:onExit()
	OriginDuoLaGameMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
end

function OriginDuoLaGameMainView:onEnter()
	OriginDuoLaGameMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginDuoLaGameGetInfoRes, self._updateUIByInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = OriginDuoLaGameController.instance:getDefaultActivityId() or 0
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	OriginDuoLaGameController.instance:getInfo(self._activityId)
end

function OriginDuoLaGameMainView:_updateUIByCfg()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._actCfg = OriginDuoLaGameConfig.instance:getActivityCfg(self._activityId) or {}
	self._gotoStrs = {}
	self._dailyPassLimit = 0

	if self._actCfg then
		self._dailyPassLimit = self._actCfg.dailyPassLimit or 0
		self._gotoStrs = self._actCfg.jumpToStrs or {}
	end

	self:_updatePetInfo()
end

function OriginDuoLaGameMainView:_updateUIByInfo()
	local todayPassTimes = OriginDuoLaGameModel.instance:getTodayPassTimes(self._activityId)

	self._txtCurTimes.text = langPara("今日剩余：%s/%s", Mathf.Max(0, self._dailyPassLimit - todayPassTimes), self._dailyPassLimit)
end

function OriginDuoLaGameMainView:_updatePetInfo()
	self._curSkinId = self._actCfg.skinId or 0
	self._curRaceId = 0

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSkinId)

	if petSkinCfg then
		self._curRaceId = petSkinCfg.raceId or 0
		self._txtNamePetInfo.text = petSkinCfg.name or ""

		MaterialMgr.setCell(MatType.Rare, self._curSkinId, self._pointRare)

		local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("drawing", self._curSkinId)

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])
	end
end

function OriginDuoLaGameMainView:_onClickBtnClg()
	UIStateManager.instance:push(ViewName.OriginDuoLaGameStageView, self._activityId)
end

function OriginDuoLaGameMainView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function OriginDuoLaGameMainView:_onClickBtnJump(index)
	if not self._gotoStrs[index] then
		if not GameUtil.isEmptyString(self._gotoStrs[index]) then
			GotoMgr.gotoByString(self._gotoStrs[index])
		end
	end
end

function OriginDuoLaGameMainView:_onClickBtnSkill()
	if self._curRaceId ~= 0 then
		if self._curRaceId == self._curSkinId then
			PetbookController.instance:previewBattle(self._curRaceId)
		else
			PetbookController.instance:previewBattle(self._curRaceId, self._curSkinId)
		end
	end
end

function OriginDuoLaGameMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._curRaceId)
end

return OriginDuoLaGameMainView
