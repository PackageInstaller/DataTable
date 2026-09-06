-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vrspace/view/VrspacemainView.lua

module("logic.extensions.vrspace.view.VrspacemainView", package.seeall)

local VrspacemainView = class("VrspacemainView", ViewComponent)

function VrspacemainView:unbindEvents()
	VrspacemainView.super.unbindEvents(self)
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

function VrspacemainView:bindEvents()
	VrspacemainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnClg2, self._onClickLimited, self)
	GameUtil.addClickHandler(self._btnClg1, self._onClickNormal, self)
	GameUtil.addClickHandler(self._btnJump1, self._onClickJump1, self)
	GameUtil.addClickHandler(self._btnJump2, self._onClickJump2, self)
	GameUtil.addClickHandler(self._btnJump3, self._onClickJump3, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickGetExtPrize, self)
end

function VrspacemainView:buildUI()
	VrspacemainView.super.buildUI(self)

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
	self._lock = self:getGo("clgBtnCol/btnClg2/lock")
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
	self._txtPrize = self:getTxt("imgPrize/txtPrize")
	self._txtDesc = self:getTxt("clgBtnCol/btnClg1/desc/txt")
end

function VrspacemainView:onExit()
	VrspacemainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = nil

	MaterialMgr.resetAll(self._imgRare)
	MaterialMgr.resetAll(self._item)
	RedPointController.instance:unregRedPoint(self._redPointClg2)
end

function VrspacemainView:onEnter()
	VrspacemainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = VRSpaceController.instance:getDefaultActivityId()
	end

	self._activityCfg = VRSpaceConfig.instance:getActivityCfgById(self._activityId)

	self:_updateSuperBubble()
	self:_setRole()
	self.addGEvent(self, GlobalNotify.VR_SPACE_INFO_UPDATE, self._onRefreshUI, self)
	VRSpaceController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	RedPointController.instance:regRedPoint(self._redPointClg2, self._activityCfg.redPointId)
end

function VrspacemainView:_onRefreshUI()
	self._info = VRSpaceModel.instance:getInfo(self._activityId) or {}

	if not self._info.modeInfos then
		local modeInfos = {}

		self._modeInfoMap = {}

		for i, v in ipairs(modeInfos) do
			self._modeInfoMap[v.mode] = v
		end

		self._isOnpenMax = false

		local mode = 0
		local vplanCfg = VRSpaceConfig.instance:getPlanCfgById(self._activityId, mode, 0) or {}
		local vstagePlanId = checknumber(vplanCfg.stagePlanId)
		local vlist = VRSpaceConfig.instance:getStageCfgListById(vstagePlanId) or {}
		local rplanCfg = VRSpaceConfig.instance:getPlanCfgById(self._activityId, mode, 1) or {}
		local rstagePlanId = checknumber(rplanCfg.stagePlanId)
		local rlist = VRSpaceConfig.instance:getStageCfgListById(rstagePlanId) or {}

		if not self._modeInfoMap[0] then
			local norInfo = {}

			if not norInfo.virtualStageInfos then
				local virtualStageInfos = {}
				local passedRealityStageId = checknumber(norInfo.passedRealityStageId)

				if #virtualStageInfos + passedRealityStageId >= #vlist + #rlist then
					self._isOnpenMax = true
				end

				self._txtDesc.text = langPara("已通关：%s/%s", #virtualStageInfos + passedRealityStageId, #vlist + #rlist)

				GameUtil.SetActive(self._pass, self._isOnpenMax)
				GameUtil.SetActive(self._lock, not self._isOnpenMax)
			end
		end
	end
end

function VrspacemainView:_onClickLimited()
	if self._isOnpenMax then
		UIStateManager.instance:push(ViewName.VrspacenorView, self._activityId, 1)
	else
		TipsFacade.instance:openCommonTips("通关普通难度后开启")
	end
end

function VrspacemainView:_onClickNormal()
	if not self._isOnpenMax then
		UIStateManager.instance:push(ViewName.VrspacenorView, self._activityId, 0)
	else
		TipsFacade.instance:openCommonTips("已全部通关，可以前往挑战【困难模式】")
	end
end

function VrspacemainView:_onClickJump1()
	UIStateManager.instance:push(ViewName.VrspacerankView, self._activityId)
end

function VrspacemainView:_onClickJump2()
	UIStateManager.instance:push(ViewName.VrspaceprizeView, self._activityId)
end

function VrspacemainView:_onClickJump3()
	GotoMgr.gotoByString(self._activityCfg.jumpStr3)
end

function VrspacemainView:_onClickRule()
	TipsFacade.instance:openRulesView("vrspacemainview_rule")
end

function VrspacemainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.skinId)
end

function VrspacemainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.skinId)
end

function VrspacemainView:_setRole()
	local skinId = checknumber(self._activityCfg.skinId)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._imgRare)
	end

	self._txtName.text = PetSkinConfig.instance:getPetSkinName(skinId)
end

function VrspacemainView:_updateSuperBubble()
	MaterialMgr.resetAll(self._item)

	if self._activityCfg then
		MaterialMgr.setCellByCfg(self._activityCfg.extremeClgPrize, self._item)
	end
end

return VrspacemainView
