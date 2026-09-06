-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterji/view/SummonMasterJiMainView.lua

module("logic.extensions.summonmasterji.view.SummonMasterJiMainView", package.seeall)

local SummonMasterJiMainView = class("SummonMasterJiMainView", ViewComponent)

function SummonMasterJiMainView:ctor()
	SummonMasterJiMainView.super.ctor(self)
end

function SummonMasterJiMainView:buildUI()
	SummonMasterJiMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnRank = self:getBtn("btnRank")
	self._btnSummon = self:getBtn("btnSummon")
	self._btnCultivate = self:getBtn("btnCultivate")
	self._btnChallenge1 = self:getBtn("btnChallenge1")
	self._btnChallenge2 = self:getBtn("btnChallenge2")
	self._passChallenge1 = self:getGo("btnChallenge1/pass")
	self._passChallenge2 = self:getGo("btnChallenge2/pass")
	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txt")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rare = self:getGo("petInfo/pointRare")
	self._txtName = self:getTxt("petInfo/txtName")
	self._item1 = self:getGo("bubble1/item")
	self._item2 = self:getGo("bubble2/item")
	self._normalRedPoint = self:getGo("btnChallenge1/redPoint")
end

function SummonMasterJiMainView:bindEvents()
	SummonMasterJiMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnSummon:AddClickListener(self._onClickSummon, self)
	self._btnCultivate:AddClickListener(self._onClickCultivate, self)
	self._btnChallenge1:AddClickListener(self._onClickChallenge1, self)
	self._btnChallenge2:AddClickListener(self._onClickChallenge2, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
end

function SummonMasterJiMainView:unbindEvents()
	SummonMasterJiMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnSummon:RemoveClickListener()
	self._btnCultivate:RemoveClickListener()
	self._btnChallenge1:RemoveClickListener()
	self._btnChallenge2:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
end

function SummonMasterJiMainView:onEnter()
	SummonMasterJiMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SummonMasterJiGetInfoRes, self._onGetInfoRes, self)

	self._activityId = SummonMasterJiModel.instance:getActivityId()

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	self._cfgActivity = SummonMasterJiConfig.instance:getActivityCfg(self._activityId)

	local cfgChallenge = TimeLimitedConfig.instance:getCfgById(self._cfgActivity.challengeId)

	if cfgChallenge then
		self._raceId = cfgChallenge.raceId or 0
	end

	self:_initActivityTime()
	self:_initRewards()
	self:_initPetInfo()
	self:_showRoleModel()
	self:_updatePassState()
	SummonMasterJiAgent.instance:sendPM_SummonMasterJiGetInfoReq(self._activityId)
	RedPointController.instance:regRedPoint(self._normalRedPoint, SummonMasterJiController.instance:getRedPointIds(self._activityId))
end

function SummonMasterJiMainView:onExit()
	SummonMasterJiMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._normalRedPoint)
	self:_resetRoleModel()
	self:_clearPetInfo()
	self:_clearRewards()
end

function SummonMasterJiMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "summonmasterjimainview_rule")
end

function SummonMasterJiMainView:_onClickSummon()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo1)
end

function SummonMasterJiMainView:_onClickCultivate()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo2)
end

function SummonMasterJiMainView:_onClickRank()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo3)
end

function SummonMasterJiMainView:_onClickChallenge1()
	local isPassNormal = SummonMasterJiModel.instance:isPassNormalChallenge(self._activityId)

	if not isPassNormal then
		UIStateManager.instance:push(ViewName.SummonMasterJiNormalView, self._activityId)
	else
		FloatWordMgr.instance:show("您已通关无需重复挑战")
	end
end

function SummonMasterJiMainView:_onClickChallenge2()
	local isPassExtreme = SummonMasterJiModel.instance:isPassExtremeChallenge(self._activityId)

	if not isPassExtreme then
		UIStateManager.instance:push(ViewName.SummonMasterJiExtremeView, self._activityId)
	else
		FloatWordMgr.instance:show("您已通关无需重复挑战")
	end
end

function SummonMasterJiMainView:_onClickInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function SummonMasterJiMainView:_onClickSkill()
	if self._raceId then
		PetbookController.instance:previewBattle(self._raceId)
	end
end

function SummonMasterJiMainView:_onGetInfoRes()
	self:_updatePassState()
end

function SummonMasterJiMainView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function SummonMasterJiMainView:_showRoleModel()
	local curFaceId = self._raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, true, x, y)
end

function SummonMasterJiMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function SummonMasterJiMainView:_initPetInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._raceId, self._rare)
end

function SummonMasterJiMainView:_clearPetInfo()
	MaterialMgr.resetAll(self._rare)
end

function SummonMasterJiMainView:_updatePassState()
	local isPassNormal = SummonMasterJiModel.instance:isPassNormalChallenge(self._activityId)
	local isPassExtreme = SummonMasterJiModel.instance:isPassExtremeChallenge(self._activityId)

	goutil.setActive(self._passChallenge1, isPassNormal)
	goutil.setActive(self._passChallenge2, isPassExtreme)
end

function SummonMasterJiMainView:_initRewards()
	MaterialMgr.setCellByCfg(self._cfgActivity.normalPrize, self._item1)
	MaterialMgr.setCellByCfg(self._cfgActivity.extremePrize, self._item2)
end

function SummonMasterJiMainView:_clearRewards()
	MaterialMgr.resetAll(self._item1)
	MaterialMgr.resetAll(self._item2)
end

return SummonMasterJiMainView
