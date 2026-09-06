-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekunlun/view/DivinekunlunchallengemainView.lua

module("logic.extensions.divinekunlun.view.DivinekunlunchallengemainView", package.seeall)

local DivinekunlunchallengemainView = class("DivinekunlunchallengemainView", ViewComponent)

function DivinekunlunchallengemainView:unbindEvents()
	DivinekunlunchallengemainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnClg1)
	GameUtil.rmClickHandler(self._btnClg2)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnGet)
end

function DivinekunlunchallengemainView:bindEvents()
	DivinekunlunchallengemainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnClg1, self._onClickLimited, self)
	GameUtil.addClickHandler(self._btnClg2, self._onClickNormal, self)
	GameUtil.addClickHandler(self._btnJump1, self._onClickJump1, self)
	GameUtil.addClickHandler(self._btnJump2, self._onClickJump2, self)
	GameUtil.addClickHandler(self._btnJump3, self._onClickJump3, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickGetExtPrize, self)
end

function DivinekunlunchallengemainView:buildUI()
	DivinekunlunchallengemainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("leftTop/btnRule")
	self._btnClg1 = self:getGo("clgBtnCol/btnClg1/btn")
	self._btnClg2 = self:getGo("clgBtnCol/btnClg2/btn")
	self._bubble = self:getGo("clgBtnCol/bubble")
	self._geted = self:getGo("clgBtnCol/bubble/geted")
	self._item = self:getGo("clgBtnCol/bubble/item")
	self._pass = self:getGo("clgBtnCol/btnClg1/pass")
	self._btnGet = self:getGo("clgBtnCol/bubble/btnGet")
	self._eff = self:getGo("clgBtnCol/bubble/eff")
	self._redPoint = self:getGo("clgBtnCol/bubble/redPoint")
	self._redPointClg2 = self:getGo("clgBtnCol/btnClg2/btn/redPoint")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._con = self:getGo("con")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._imgRare = self:getGo("petInfo/name/imgRare")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._txtTime = self:getTxt("time/txtTime")
end

function DivinekunlunchallengemainView:onExit()
	DivinekunlunchallengemainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._imgRare)
	MaterialMgr.resetAll(self._item)
	RedPointController.instance:unregRedPoint(self._redPointClg2)
end

function DivinekunlunchallengemainView:onEnter()
	DivinekunlunchallengemainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = DivineKunlunController.instance:getDefaultActivityId()
	end

	self._activityCfg = DivineKunlunConfig.instance:getActivityCfgById(self._activityId)

	self:_updateSuperBubble()
	self:_setRole()
	self.addGEvent(self, GlobalNotify.DIVINE_KUNLUN_INFO_UPDATE, self._onRefreshUI, self)
	DivineKunlunController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	RedPointController.instance:regRedPoint(self._redPointClg2, self._activityCfg.redPointId)
end

local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function DivinekunlunchallengemainView:_onRefreshUI()
	self._info = DivineKunlunModel.instance:getInfo(self._activityId) or {}

	GameUtil.SetActive(self._geted, checkbool(self._info.gainExtremePrize))
	GameUtil.SetActive(self._pass, self:_checkIsLimitSuccess())

	local boo = self:_checkCanGetExtPrize()

	GameUtil.SetActive(self._redPoint, boo)
	GameUtil.SetActive(self._btnGet, boo)

	if boo then
		self:playViewEffectUniGo(effPath, self._eff)
	else
		self:stopViewEffectUniGo(self._eff)
	end
end

function DivinekunlunchallengemainView:_onClickLimited()
	if self:_checkIsLimitSuccess() then
		TipsFacade.instance:openCommonTips("已通关")
	else
		UIStateManager.instance:push(ViewName.DivinekunlunmaxlevelView, self._activityId)
	end
end

function DivinekunlunchallengemainView:_onClickNormal()
	UIStateManager.instance:push(ViewName.DivinekunlunclgnorlevelView, self._activityId)
end

function DivinekunlunchallengemainView:_checkCanGetExtPrize()
	return (self._info and not checkbool(self._info.gainExtremePrize) or nil) and self:_checkIsLimitSuccess()
end

function DivinekunlunchallengemainView:_checkIsLimitSuccess()
	local isSuccess = false

	if self._info then
		if not self._info.extremeStageInfo then
			if #self._info.extremeStageInfo > 0 then
				isSuccess = true

				for i, v in ipairs(self._info.extremeStageInfo) do
					if i == 1 then
						if v.right == 0 then
							isSuccess = false

							break
						end
					elseif v.right == 0 or v.right <= self._info.extremeStageInfo[i - 1].right then
						isSuccess = false

						break
					end
				end
			end
		end
	end

	return isSuccess
end

function DivinekunlunchallengemainView:_onClickGetExtPrize()
	if self:_checkCanGetExtPrize() then
		DivineKunlunController.instance:sendGetExtPrize(self._activityId)
	end
end

function DivinekunlunchallengemainView:_onClickJump1()
	GotoMgr.gotoByString(self._activityCfg.jumpStr1)
end

function DivinekunlunchallengemainView:_onClickJump2()
	GotoMgr.gotoByString(self._activityCfg.jumpStr2)
end

function DivinekunlunchallengemainView:_onClickJump3()
	GotoMgr.gotoByString(self._activityCfg.jumpStr3)
end

function DivinekunlunchallengemainView:_onClickRule()
	TipsFacade.instance:openRulesView("divinekunlunchallengemainview_rule")
end

function DivinekunlunchallengemainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.skinId)
end

function DivinekunlunchallengemainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.skinId)
end

function DivinekunlunchallengemainView:_setRole()
	local skinId = checknumber(self._activityCfg.skinId)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._imgRare)
	end

	self._txtName.text = PetSkinConfig.instance:getPetSkinName(skinId)
end

function DivinekunlunchallengemainView:_updateSuperBubble()
	MaterialMgr.resetAll(self._item)

	if self._activityCfg then
		MaterialMgr.setCellByCfg(self._activityCfg.extremeClgPrize, self._item)
	end
end

return DivinekunlunchallengemainView
