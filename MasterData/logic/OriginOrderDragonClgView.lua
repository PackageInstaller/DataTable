-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originorderdragonclg/view/OriginOrderDragonClgView.lua

module("logic.extensions.originorderdragonclg.view.OriginOrderDragonClgView", package.seeall)

local OriginOrderDragonClgView = class("OriginOrderDragonClgView", ViewComponent)

function OriginOrderDragonClgView:ctor()
	OriginOrderDragonClgView.super.ctor(self)
end

function OriginOrderDragonClgView:unbindEvents()
	OriginOrderDragonClgView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump4)
	GameUtil.rmClickHandler(self._btnClg)
end

function OriginOrderDragonClgView:bindEvents()
	OriginOrderDragonClgView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, self._onClickBtnJump1, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, self._onClickBtnJump2, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, self._onClickBtnJump3, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump4, self._onClickBtnJump4, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function OriginOrderDragonClgView:buildUI()
	OriginOrderDragonClgView.super.buildUI(self)

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
	self._showCon = self:getGo("bubble/showCon")
	self._passBubble = self:getGo("bubble/pass")
	self._txtBubble = self:getTxt("bubble/txt")
	self._btnClg = self:getGo("btnClg")
	self._closeTips = self:getGo("closeTips")
	self._txtCloseTips = self:getTxt("closeTips/txt")
end

function OriginOrderDragonClgView:onExit()
	OriginOrderDragonClgView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
end

function OriginOrderDragonClgView:onEnter()
	OriginOrderDragonClgView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginOrderDragonClgGetInfoRes, self._updateUIByInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 568001
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
	OriginOrderDragonClgController.instance:getInfo(self._activityId)
end

function OriginOrderDragonClgView:_updateUIByCfg()
	self._actCfg = OriginOrderDragonClgConfig.instance:getActivityCfg(self._activityId)
	self._curSkinId = self._actCfg.skinId

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSkinId)

	self._curRaceId = petSkinCfg and petSkinCfg.raceId

	MaterialMgr.setCell(MatType.Rare, self._curSkinId, self._pointRare)

	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._txtPetNameInInfo.text = petSkinCfg and petSkinCfg.name

	local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("drawing", self._curSkinId)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])

	local startTimeStr, endTimeStr = GodDailyRankController.instance:getRankCloseTimeRange(self._activityId)
	local dateStart = GameUtil.string2date("0-0-0 " .. startTimeStr)
	local dateEnd = GameUtil.string2date("0-0-0 " .. endTimeStr)

	self._txtCloseTips.text = string.format("可挑战时间\n%02d:%02d-%02d:%02d", dateEnd.hour, dateEnd.min, dateStart.hour, dateStart.min)
end

function OriginOrderDragonClgView:_updateUIByInfo()
	return
end

function OriginOrderDragonClgView:_onClickBtnJump1()
	local jumpToStr = self._actCfg.gotoStr1

	GotoMgr.gotoByString(jumpToStr)
end

function OriginOrderDragonClgView:_onClickBtnJump2()
	local jumpToStr = self._actCfg.gotoStr2

	GotoMgr.gotoByString(jumpToStr)
end

function OriginOrderDragonClgView:_onClickBtnJump3()
	local jumpToStr = self._actCfg.gotoStr3

	GotoMgr.gotoByString(jumpToStr)
end

function OriginOrderDragonClgView:_onClickBtnJump4()
	local jumpToStr = self._actCfg.gotoStr4

	GotoMgr.gotoByString(jumpToStr)
end

function OriginOrderDragonClgView:_onClickBtnSkill()
	if self._curRaceId ~= 0 then
		if self._curRaceId == self._curSkinId then
			PetbookController.instance:previewBattle(self._curRaceId)
		else
			PetbookController.instance:previewBattle(self._curRaceId, self._curSkinId)
		end
	end
end

function OriginOrderDragonClgView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._curRaceId)
end

function OriginOrderDragonClgView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function OriginOrderDragonClgView:_onClickBtnClg()
	if GodDailyRankController.instance:isGodRankClosed(self._activityId) then
		FloatWordMgr.instance:show("暂未开启")

		return
	end

	UIStateManager.instance:push(ViewName.OriginOrderDragonClgStageView, self._activityId)
end

return OriginOrderDragonClgView
