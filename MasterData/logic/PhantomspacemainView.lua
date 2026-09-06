-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/view/PhantomspacemainView.lua

module("logic.extensions.phantomspace.view.PhantomspacemainView", package.seeall)

local PhantomspacemainView = class("PhantomspacemainView", ViewComponent)

function PhantomspacemainView:unbindEvents()
	PhantomspacemainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnClg1)
	GameUtil.rmClickHandler(self._btnClg2)
	GameUtil.rmClickHandler(self._btnClg3)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnGet)
end

function PhantomspacemainView:bindEvents()
	PhantomspacemainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnClg3, self._onClickEndless, self)
	GameUtil.addClickHandler(self._btnClg2, self._onClickLimited, self)
	GameUtil.addClickHandler(self._btnClg1, self._onClickNormal, self)
	GameUtil.addClickHandler(self._btnJump1, self._onClickJump1, self)
	GameUtil.addClickHandler(self._btnJump2, self._onClickJump2, self)
	GameUtil.addClickHandler(self._btnJump3, self._onClickJump3, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickGetExtPrize, self)
end

function PhantomspacemainView:buildUI()
	PhantomspacemainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("leftTop/btnRule")
	self._btnClg1 = self:getGo("clgBtnCol/btnClg1/btn")
	self._btnClg2 = self:getGo("clgBtnCol/btnClg2/btn")
	self._btnClg3 = self:getGo("clgBtnCol/btnClg3/btn")
	self._bubble = self:getGo("clgBtnCol/bubble")
	self._geted = self:getGo("clgBtnCol/bubble/geted")
	self._item = self:getGo("clgBtnCol/bubble/item")
	self._pass = self:getGo("clgBtnCol/btnClg1/pass")
	self._btnGet = self:getGo("clgBtnCol/bubble/btnGet")
	self._eff = self:getGo("clgBtnCol/bubble/eff")
	self._redPoint = self:getGo("clgBtnCol/bubble/redPoint")
	self._redPointClg2 = self:getGo("clgBtnCol/btnClg2/btn/redPoint")
	self._lock = self:getGo("clgBtnCol/btnClg2/lock")
	self._lockEndless = self:getGo("clgBtnCol/btnClg3/lock")
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
	self._imgPrize = self:getGo("imgPrize")
	self._txtPrize = self:getTxt("imgPrize/txtPrize")
end

function PhantomspacemainView:onExit()
	PhantomspacemainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = nil

	MaterialMgr.resetAll(self._imgRare)
	MaterialMgr.resetAll(self._item)
	RedPointController.instance:unregRedPoint(self._redPointClg2)
end

function PhantomspacemainView:onEnter()
	PhantomspacemainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(516)
	end

	self._activityCfg = PhantomSpaceConfig.instance:getActivityCfgById(self._activityId)

	self:_updateSuperBubble()
	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.PHANTOM_SPACE_INFO_UPDATE, self._onRefreshUI, self)
	PhantomSpaceController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	RedPointController.instance:regRedPoint(self._redPointClg2, self._activityCfg.redPointId)
end

function PhantomspacemainView:_onSetUI()
	local modeMap = PhantomSpaceConfig.instance:getOpenModeMap(self._activityId)

	for k, modeId in pairs(PhantomSpaceController.clg_mode) do
		local mode = modeMap[modeId]
		local btnClg = self:getGo("clgBtnCol/btnClg" .. modeId + 1)

		GameUtil.SetActive(btnClg, mode)
	end

	local desc = PhantomSpaceConfig.instance:getCommonValue("MAIN_PRIZE_DESC")
	local hasDesc = not string.nilorempty(desc)

	self._txtPrize.text = desc

	GameUtil.SetActive(self._imgPrize, hasDesc)
end

function PhantomspacemainView:_onRefreshUI()
	self._info = PhantomSpaceModel.instance:getInfo(self._activityId) or {}
	self._stageKey = self._info.stageKey or {}
	self._isOnpenMax = false

	local list = PhantomSpaceConfig.instance:getStageListCfgById(self._activityId, 0) or {}

	if self._stageKey.mode == 0 and checknumber(self._stageKey.stageId) >= #list then
		self._isOnpenMax = true
	end

	if self._stageKey.mode == 1 then
		self._isOnpenMax = true
	end

	GameUtil.SetActive(self._pass, self._isOnpenMax)
	GameUtil.SetActive(self._lock, not self._isOnpenMax)
	GameUtil.SetActive(self._lockEndless, not self._isOnpenMax)
end

function PhantomspacemainView:_onClickEndless()
	if self._isOnpenMax then
		UIStateManager.instance:push(ViewName.PhantomspaceinfiniteView, self._activityId)
	else
		TipsFacade.instance:openCommonTips("通关普通难度后开启")
	end
end

function PhantomspacemainView:_onClickLimited()
	if self._isOnpenMax then
		UIStateManager.instance:push(ViewName.PhantomspaceextView, self._activityId)
	else
		TipsFacade.instance:openCommonTips("通关普通难度后开启")
	end
end

function PhantomspacemainView:_onClickNormal()
	if not self._isOnpenMax then
		UIStateManager.instance:push(ViewName.PhantomspacenorView, self._activityId)
	else
		local modeMap = PhantomSpaceConfig.instance:getOpenModeMap(self._activityId)
		local mode = modeMap[PhantomSpaceController.clg_mode.Endless]

		if mode then
			TipsFacade.instance:openCommonTips("已全部通关，可以前往挑战【永恒镜】")
		else
			TipsFacade.instance:openCommonTips("已全部通关，可以前往挑战【噩梦难度】")
		end
	end
end

function PhantomspacemainView:_onClickJump1()
	local modeMap = PhantomSpaceConfig.instance:getOpenModeMap(self._activityId)
	local mode = modeMap[PhantomSpaceController.clg_mode.Endless]

	if mode then
		if not PhantomSpaceController.clg_mode.Endless then
			local curMode = PhantomSpaceController.clg_mode.Nightmare

			UIStateManager.instance:push(ViewName.PhantomspacerankView, self._activityId, curMode)
		end
	end
end

function PhantomspacemainView:_onClickJump2()
	GotoMgr.gotoByString(self._activityCfg.jumpStr2)
end

function PhantomspacemainView:_onClickJump3()
	GotoMgr.gotoByString(self._activityCfg.jumpStr3)
end

function PhantomspacemainView:_onClickRule()
	TipsFacade.instance:openRulesView("PhantomspacemainView_rule")
end

function PhantomspacemainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.skinId)
end

function PhantomspacemainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.skinId)
end

function PhantomspacemainView:_setRole()
	local skinId = checknumber(self._activityCfg.skinId)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._imgRare)
	end

	self._txtName.text = PetSkinConfig.instance:getPetSkinName(skinId)
end

function PhantomspacemainView:_updateSuperBubble()
	MaterialMgr.resetAll(self._item)

	if self._activityCfg then
		MaterialMgr.setCellByCfg(self._activityCfg.extremeClgPrize, self._item)
	end
end

return PhantomspacemainView
