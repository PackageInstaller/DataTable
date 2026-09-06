-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmimengli/view/OriginMiMengLiMainView.lua

module("logic.extensions.originmimengli.view.OriginMiMengLiMainView", package.seeall)

local OriginMiMengLiMainView = class("OriginMiMengLiMainView", ViewComponent)

function OriginMiMengLiMainView:ctor()
	OriginMiMengLiMainView.super.ctor(self)
end

function OriginMiMengLiMainView:unbindEvents()
	OriginMiMengLiMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnClg)
end

function OriginMiMengLiMainView:bindEvents()
	OriginMiMengLiMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, 4))
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function OriginMiMengLiMainView:buildUI()
	OriginMiMengLiMainView.super.buildUI(self)

	self._txtNamePetInfo = self:getTxt("petInfo/txtName")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._con = self:getGo("con")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._passTips = self:getGo("passTips")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnClg = self:getGo("btnClg")
	self._showConBubble = self:getGo("bubble/showCon")
	self._passBubble = self:getGo("bubble/pass")
end

function OriginMiMengLiMainView:onExit()
	OriginMiMengLiMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._showConBubble)
end

function OriginMiMengLiMainView:onEnter()
	OriginMiMengLiMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginMiMengLiInfoRes, self._updateUIByInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = OriginMiMengLiController.instance:getDefaultActivityId() or 0
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
	OriginMiMengLiController.instance:getInfo(self._activityId)
end

function OriginMiMengLiMainView:_updateUIByCfg()
	self._actCfg = OriginMiMengLiConfig.instance:getActCfgByActId(self._activityId) or {}
	self._gotoStrs = self._actCfg.gotoStrs or {}
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._passPrize = self._actCfg.passPrize or ""

	MaterialMgr.setCellByCfg(self._passPrize, self._showConBubble)
	self:_updatePetInfo()
end

function OriginMiMengLiMainView:_updatePetInfo()
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

function OriginMiMengLiMainView:_updateUIByInfo()
	self._isPass = false

	local info = OriginMiMengLiModel.instance:getInfo(self._activityId) or {}

	if info then
		self._isPass = info.hasGainPrize or false
	end

	goutil.setActive(self._passTips, self._isPass)
	goutil.setActive(self._passBubble, self._isPass)
end

function OriginMiMengLiMainView:_onClickBtnClg()
	UIStateManager.instance:push(ViewName.OriginMiMengLiStageView, self._activityId)
end

function OriginMiMengLiMainView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function OriginMiMengLiMainView:_onClickBtnJump(index)
	if not self._gotoStrs[index] then
		if not GameUtil.isEmptyString(self._gotoStrs[index]) then
			GotoMgr.gotoByString(self._gotoStrs[index])
		end
	end
end

function OriginMiMengLiMainView:_onClickBtnSkill()
	if self._curRaceId ~= 0 then
		if self._curRaceId == self._curSkinId then
			PetbookController.instance:previewBattle(self._curRaceId)
		else
			PetbookController.instance:previewBattle(self._curRaceId, self._curSkinId)
		end
	end
end

function OriginMiMengLiMainView:_onClickBtnIntroduce()
	if self._curRaceId ~= 0 then
		PetbookController.instance:openPetinfoView(self._curRaceId)
	end
end

return OriginMiMengLiMainView
