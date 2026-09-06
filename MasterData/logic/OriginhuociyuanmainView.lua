-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhuociyuan/view/OriginhuociyuanmainView.lua

module("logic.extensions.originhuociyuan.view.OriginhuociyuanmainView", package.seeall)

local OriginhuociyuanmainView = class("OriginhuociyuanmainView", ViewComponent)

function OriginhuociyuanmainView:unbindEvents()
	OriginhuociyuanmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnExtreme)
end

function OriginhuociyuanmainView:bindEvents()
	OriginhuociyuanmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "junpStr1"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "junpStr2"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "junpStr3"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, "junpStr4"))
	GameUtil.addClickHandler(self._btnExtreme, self._onClickChallenge, self)
end

function OriginhuociyuanmainView:buildUI()
	OriginhuociyuanmainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._passExtreme = self:getGo("extreme/pass")
	self._btnExtreme = self:getGo("extreme/btn")
	self._bubble = self:getGo("extreme/bubble")
	self._showConBubble = self:getGo("extreme/bubble/showCon")
	self._txtBubble = self:getTxt("extreme/bubble/txt")
	self._passBubble = self:getGo("extreme/bubble/pass")
	self._txtOpenTimeExt = self:getTxt("extreme/openTime/txt")
	self._openTimeExt = self:getGo("extreme/openTime")
end

function OriginhuociyuanmainView:onExit()
	OriginhuociyuanmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._showConBubble)
	RedPointController.instance:unregRedPoint(self._redPointNormal)
end

function OriginhuociyuanmainView:onEnter()
	OriginhuociyuanmainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 560001
	end

	self.addGEvent(self, GlobalNotify.ORIGIN_HUOCIYUAN_INFO_UPDATE, self._refreshUI, self)
	OriginHuociyuanController.instance:sendGetInfo(self._activityId)
	self:_refreshUI()
	OriginHuociyuanController.instance:showCI()
end

function OriginhuociyuanmainView:_refreshUI()
	self._actCfg = OriginHuociyuanConfig.instance:getActCfgById(self._activityId) or {}
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._curSkinId = self._actCfg.skinId or 10016

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSkinId)

	self._curRaceId = petSkinCfg and petSkinCfg.raceId
	self._txtPetNameInInfo.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._curSkinId)

	MaterialMgr.setCell(MatType.Rare, self._curSkinId, self._pointRare)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, nil, nil, true, nil, nil)
	self._txtBubble.text = self._actCfg.showPrizeDesc

	MaterialMgr.setCellByCfg(self._actCfg.passPrize, self._showConBubble)

	self._info = OriginHuociyuanModel.instance:getInfo(self._activityId) or {}

	local hasGainPrize = checkbool(self._info.hasGainPrize)

	if not self._info.stageInfos then
		local tempMap = {}

		for i, v in ipairs(self._info.stageInfos) do
			tempMap[v.stageId] = v
		end

		local stageList = OriginHuociyuanConfig.instance:getStageListCfgById(self._activityId) or {}

		self._isPass = hasGainPrize

		GameUtil.SetActive(self._passExtreme, self._isPass)
		GameUtil.SetActive(self._passBubble, self._isPass)
	end
end

function OriginhuociyuanmainView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	GotoMgr.gotoByString(jumpToStr)
end

function OriginhuociyuanmainView:_onClickBtnTip()
	local key = self._actCfg.ruleTip

	TipsFacade.instance:openRulesView(key)
end

function OriginhuociyuanmainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.OriginhuociyuanchallengeView, self._activityId)
end

function OriginhuociyuanmainView:_onClickBtnSkill()
	if self._curRaceId ~= 0 then
		if self._curRaceId == self._curSkinId then
			PetbookController.instance:previewBattle(self._curRaceId)
		else
			PetbookController.instance:previewBattle(self._curRaceId, self._curSkinId)
		end
	end
end

function OriginhuociyuanmainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._curRaceId)
end

return OriginhuociyuanmainView
