-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doloresclg/view/DoloresclgmainView.lua

module("logic.extensions.doloresclg.view.DoloresclgmainView", package.seeall)

local DoloresclgmainView = class("DoloresclgmainView", ViewComponent)

function DoloresclgmainView:ctor()
	DoloresclgmainView.super.ctor(self)
end

function DoloresclgmainView:unbindEvents()
	DoloresclgmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)

	if self._jumpBtnCol_btnJump4 then
		GameUtil.rmClickHandler(self._jumpBtnCol_btnJump4)
	end

	GameUtil.rmClickHandler(self._btnExtreme)
end

function DoloresclgmainView:bindEvents()
	DoloresclgmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "junpStr1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "junpStr2"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "junpStr3"))

	if self._jumpBtnCol_btnJump4 then
		GameUtil.addClickHandler(self._jumpBtnCol_btnJump4, GameUtil.handler(self._onClickBtnJump, self, "junpStr4"))
	end

	GameUtil.addClickHandler(self._btnExtreme, self._onClickBtnExtreme, self)
end

function DoloresclgmainView:buildUI()
	DoloresclgmainView.super.buildUI(self)

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
	self._passExtreme = self:getGo("extreme/pass")
	self._btnExtreme = self:getGo("extreme/btn")
	self._bubble = self:getGo("extreme/bubble")
	self._showConBubble = self:getGo("extreme/bubble/showCon")
	self._txtBubble = self:getTxt("extreme/bubble/txt")
	self._passBubble = self:getGo("extreme/bubble/pass")
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._redBuff = self:getGo("buffCol/cell/redPoint")
end

function DoloresclgmainView:onExit()
	DoloresclgmainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = nil

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._showConBubble)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function DoloresclgmainView:onEnter()
	DoloresclgmainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = DoloresController.instance:getDefaultActivity()
	end

	self:_updateUIByCfg()
	self.addGEvent(self, GlobalNotify.DOLORES_INFO_UPDATE, self._refreshUI, self)
	DoloresController.instance:sendGetInfo(self._activityId)
	self:_refreshUI()
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		GameUtil.SetActive(self._redBuff, param.isCanGain)

		local buffCfg = param.buffCfg

		if buffCfg then
			self._txtDescBuff.text = buffCfg.des or "点击激活Buff"
		end
	end)
end

function DoloresclgmainView:_updateUIByCfg()
	self._actCfg = DoloresConfig.instance:getActCfg(self._activityId) or {}
	self._curSkinId = self._actCfg.skinId

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSkinId)

	self._curRaceId = petSkinCfg and petSkinCfg.raceId

	MaterialMgr.setCell(MatType.Rare, self._curSkinId, self._pointRare)

	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._txtPetNameInInfo.text = petSkinCfg and petSkinCfg.name
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, nil, nil, true, nil, nil)
	self._txtBubble.text = self._actCfg.showPrizeDesc

	MaterialMgr.setCellByCfg(self._actCfg.showPrize, self._showConBubble)
end

function DoloresclgmainView:_refreshUI()
	self._isExtremePass = false

	local info = DoloresModel.instance:getInfo(self._activityId) or {}
	local passedPhaseId = checknumber(info.passedPhaseId)
	local phaseCfgList = DoloresConfig.instance:getPhaseListById(self._activityId) or {}
	local maxLvl = #phaseCfgList

	if maxLvl <= passedPhaseId then
		self._isExtremePass = true
	end

	goutil.setActive(self._passExtreme, self._isExtremePass)
	goutil.setActive(self._passBubble, self._isExtremePass)
end

function DoloresclgmainView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	GotoMgr.gotoByString(jumpToStr)
end

function DoloresclgmainView:_onClickBtnTip()
	local key = self._actCfg.ruleTip

	TipsFacade.instance:openRulesView(key)
end

function DoloresclgmainView:_onClickBtnExtreme()
	if self._isExtremePass then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(self:_getLevelView(), self._activityId)
end

function DoloresclgmainView:_onClickBtnNormal()
	return
end

function DoloresclgmainView:_onClickBtnSkill()
	if self._curRaceId ~= 0 then
		if self._curRaceId == self._curSkinId then
			PetbookController.instance:previewBattle(self._curRaceId)
		else
			PetbookController.instance:previewBattle(self._curRaceId, self._curSkinId)
		end
	end
end

function DoloresclgmainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._curRaceId)
end

function DoloresclgmainView:_getLevelView()
	return ViewName.DoloresclglevelView
end

return DoloresclgmainView
