-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/view/DivinelongyanmainView.lua

module("logic.extensions.divinelongyan.view.DivinelongyanmainView", package.seeall)

local DivinelongyanmainView = class("DivinelongyanmainView", ViewComponent)

function DivinelongyanmainView:buildUI()
	DivinelongyanmainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTime = self:getTxt("txtTime/txt")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._redJump1 = self:getGo("jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._redJump2 = self:getGo("jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._redJump3 = self:getGo("jumpBtnCol/btnJump3/redPoint")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump5")
	self._btnClg1 = self:getGo("clgBtnCol/btnClg1/btn")
	self._redClg1 = self:getGo("clgBtnCol/btnClg1/btn/redPoint")
	self._passClg1 = self:getGo("clgBtnCol/btnClg1/btn/imgPass")
	self._btnClg2 = self:getGo("clgBtnCol/btnClg2/btn")
	self._redClg2 = self:getGo("clgBtnCol/btnClg2/btn/redPoint")
	self._passClg2 = self:getGo("clgBtnCol/btnClg2/btn/imgPass")
	self._itemcellGo = self:getGo("clgBtnCol/bubble/itemcell")
	self._imgHasGainGo = self:getGo("clgBtnCol/bubble/imgHasGain")
	self._btnAttr = self:getGo("btnAttr")
	self._imgAttr = self:getGo("btnAttr/img")
	self._redpointAttr = self:getGo("btnAttr/redPoint")
end

function DivinelongyanmainView:bindEvents()
	DivinelongyanmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFour"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFive"))
	GameUtil.addClickHandler(self._btnClg1, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._btnClg2, self._onClickBtnClg2, self)
	GameUtil.addClickHandler(self._btnAttr, self._onClickbtnAttr, self)
end

function DivinelongyanmainView:unbindEvents()
	DivinelongyanmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnClg1)
	GameUtil.rmClickHandler(self._btnClg2)
	GameUtil.rmClickHandler(self._btnAttr)
end

function DivinelongyanmainView:onEnter()
	DivinelongyanmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineLongYanChallengeInfoRes, self._updateUI, self)

	self._activityId = DivinelongyanController.instance:getActivityId()

	DivinelongyanModel.instance:setActivieyId(self._activityId)

	if self._activityId <= 0 then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actCfg = DivinelongyanConfig.instance:getActCfg(self._activityId)

	self:_setActTime()
	self:_setRole()
	self:_updateUI()
	DivineLongYanChallengeAgent.instance:sendPM_DivineLongYanChallengeInfoReq(self._activityId)
end

function DivinelongyanmainView:onExit()
	DivinelongyanmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcellGo)
	MaterialMgr.clearIcon(self._imgAttr)
end

function DivinelongyanmainView:_upateRed()
	self._matType, self._matId = DivinelongyanController.instance:getCostMatParams(self._activityId)

	local supportPet = DivinelongyanModel.instance:getSupportPet(self._activityId)
	local canLvlup = false
	local canSkillUp = false

	if supportPet then
		local hasNum = MaterialFacade.instance:getMatNumber(self._matType, self._matId)
		local nextCfg = DivinelongyanConfig.instance:getSupportPetLevelCfg(self._activityId, supportPet.level + 1)
		local isMax = not nextCfg

		if not isMax and nextCfg and hasNum >= nextCfg.cost then
			canLvlup = true
		end

		local serMap = {}

		for k, v in pairs(CharacterConfig.skillTypeMap) do
			serMap[v] = k
		end

		local mo = DivinelongyanModel.instance:getCurSuppopPetMo(self._activityId)
		local list = DivinelongyanConfig.instance:getAllSkillCfgList(self._activityId)

		for i, cfgList in ipairs(list) do
			if not mo[DivinelongyanpetskillView.SKILL_TYPE_LEVEL[serMap[i]]] then
				for j, cfg in ipairs(cfgList) do
					if mo[DivinelongyanpetskillView.SKILL_TYPE_LEVEL[serMap[i]]] < cfg.skillLevel and cfg.petLevelLimit <= checknumber(mo.level) and hasNum >= cfg.cost then
						canSkillUp = true

						break
					end
				end

				if canSkillUp then
					break
				end
			end
		end
	end

	GameUtil.SetActive(self._redpointAttr, canLvlup or canSkillUp)
end

function DivinelongyanmainView:_setActTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function DivinelongyanmainView:_setRole()
	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

	MaterialMgr.setIcon(self._imgAttr, MatType.PET_SKIN, skinId)
end

function DivinelongyanmainView:_updateUI()
	self:_updateSuperBubble()
	self:_upateRed()
end

function DivinelongyanmainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DivinelongyanmainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivinelongyanmainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function DivinelongyanmainView:_getSkinId()
	return DivinelongyanConfig.instance:getSkinId(self._activityId)
end

function DivinelongyanmainView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	GotoMgr.gotoByString(jumpToStr)
end

function DivinelongyanmainView:_onClickBtnClg1()
	UIStateManager.instance:push(ViewName.DivinelongyanlineView)
end

function DivinelongyanmainView:_onClickBtnClg2()
	UIStateManager.instance:push(ViewName.DivinelongyanpowerstageView)
end

function DivinelongyanmainView:_onClickBtnTip()
	local key = DivinelongyanConfig.instance:getRuleKey(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

function DivinelongyanmainView:_updateSuperBubble()
	MaterialMgr.resetAll(self._itemcellGo)
	goutil.setActive(self._imgHasGainGo, false)
	MaterialMgr.setCellByCfg("4:510259:100", self._itemcellGo)
end

function DivinelongyanmainView:_onClickbtnAttr()
	UIStateManager.instance:push(ViewName.DivinelongyanshowView, self._activityId)
end

return DivinelongyanmainView
