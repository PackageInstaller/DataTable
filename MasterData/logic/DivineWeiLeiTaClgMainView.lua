-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/view/DivineWeiLeiTaClgMainView.lua

module("logic.extensions.divineweileitaclg.view.DivineWeiLeiTaClgMainView", package.seeall)

local DivineWeiLeiTaClgMainView = class("DivineWeiLeiTaClgMainView", ViewComponent)

function DivineWeiLeiTaClgMainView:ctor()
	DivineWeiLeiTaClgMainView.super.ctor(self)
end

function DivineWeiLeiTaClgMainView:unbindEvents()
	DivineWeiLeiTaClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnNormal)
	GameUtil.rmClickHandler(self._btnExtreme)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCall)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
end

function DivineWeiLeiTaClgMainView:bindEvents()
	DivineWeiLeiTaClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnNormal, self._onClickNormal, self)
	GameUtil.addClickHandler(self._btnExtreme, self._onClickExtreme, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
end

function DivineWeiLeiTaClgMainView:buildUI()
	DivineWeiLeiTaClgMainView.super.buildUI(self)

	self._btnRule = self:getGo("btnRule")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnCall = self:getGo("btnCall")
	self._btnRank = self:getGo("btnRank")
	self._btnPrize = self:getGo("btnPrize")
	self._btnNormal = self:getGo("btnNormal")
	self._normalPass = self:getGo("btnNormal/pass")
	self._btnExtreme = self:getGo("btnExtreme")
	self._extPass = self:getGo("btnExtreme/pass")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._petCon = self:getGo("petCon")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._petRareCon = self:getGo("petInfo/name/imgRare")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._txtTime = self:getTxt("time/txtTime")
	self._bubbleCon = self:getGo("bubble/con")
	self._bubbleGeted = self:getGo("bubble/geted")
	self._imgExtBtn = self:getGo("btnExtreme/imgBtn")
	self._imgExtName = self:getGo("btnExtreme/imgName")
	self._imgNormalBtn = self:getGo("btnNormal/imgBtn")
	self._imgNormalName = self:getGo("btnNormal/imgName")
	self._bubble = self:getGo("bubble")
	self._timeGo = self:getGo("time")
end

function DivineWeiLeiTaClgMainView:onExit()
	DivineWeiLeiTaClgMainView.super.onExit(self)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	MaterialMgr.resetAll(self._petRareCon)
	MaterialMgr.resetAll(self._bubbleCon)
end

function DivineWeiLeiTaClgMainView:onEnter()
	DivineWeiLeiTaClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineWeiLeiTaClgExtremeRefresh, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.DivineWeiLeiTaClgNormalRefresh, self._refreshView, self)

	self._activityId = self:getFirstParam() or DivineWeiLeiTaClgModel.instance:getCurrActId()
	self._activityCfg = DivineWeiLeiTaClgConfig.instance:getActivityCfg(self._activityId)

	MaterialMgr.resetAll(self._petRareCon)
	MaterialMgr.setCell(MatType.Rare, self._activityCfg.raceId, self._petRareCon)

	local petCfg = CharacterConfig.instance:getPetCo(self._activityCfg.raceId)

	self._txtName.text = petCfg.name
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._activityCfg.raceId, self._petCon)
	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.DivineWeiLeiTaClg, self._activityId)

	MaterialMgr.setCellByCfg(self._activityCfg.bubbleItem, self._bubbleCon)

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_initAoqiGodUI()

	if not self._isAoqiGodProcessType then
		DivineWeiLeiTaClgAgent.instance:sendPM_DivineWeiLeiTaClgNormalInfoReq(self._activityId)
	end

	DivineWeiLeiTaClgAgent.instance:sendPM_DivineWeiLeiTaClgExtremeInfoReq(self._activityId)
end

function DivineWeiLeiTaClgMainView:_initAoqiGodUI()
	GameUtil.SetActive(self._bubble, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._timeGo, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._btnCall, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._btnRank, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._btnPrize, not self._isAoqiGodProcessType)
end

function DivineWeiLeiTaClgMainView:_refreshView()
	local normalGainPrizeIds = DivineWeiLeiTaClgModel.instance:getGainPrizeIds(self._activityId)
	local normalPrizeCfgs = DivineWeiLeiTaClgConfig.instance:getRewardProgressListCfgs(self._activityId)
	local normalClgPass = #normalGainPrizeIds >= #normalPrizeCfgs

	GameUtil.SetActive(self._normalPass, normalClgPass)
	GameUtil.SetGray(self._imgNormalBtn, normalClgPass)
	GameUtil.SetGray(self._imgNormalName, normalClgPass)

	local extMaxStageId = DivineWeiLeiTaClgModel.instance:getExtMaxStageId(self._activityId)
	local extStageCfgs = DivineWeiLeiTaClgConfig.instance:getExtremeStageCfgs(self._activityId)
	local extClgPass = extMaxStageId >= #extStageCfgs

	GameUtil.SetActive(self._extPass, extClgPass)
	GameUtil.SetGray(self._imgExtBtn, extClgPass)
	GameUtil.SetGray(self._imgExtName, extClgPass)
	GameUtil.SetActive(self._bubbleGeted, extClgPass)
end

function DivineWeiLeiTaClgMainView:_onClickRule()
	TipsFacade.instance:openRulesView("divine_wei_lei_ta_clg_rule")
end

function DivineWeiLeiTaClgMainView:_onClickNormal()
	local normalGainPrizeIds = DivineWeiLeiTaClgModel.instance:getGainPrizeIds(self._activityId)
	local normalPrizeCfgs = DivineWeiLeiTaClgConfig.instance:getRewardProgressListCfgs(self._activityId)

	if #normalGainPrizeIds >= #normalPrizeCfgs then
		FloatWordMgr.instance:show(lang("已通关"))
	else
		UIStateManager.instance:push(ViewName.DivineWeiLeiTaClgNormalView, self._activityId)
	end
end

function DivineWeiLeiTaClgMainView:_onClickExtreme()
	local extMaxStageId = DivineWeiLeiTaClgModel.instance:getExtMaxStageId(self._activityId)
	local extStageCfgs = DivineWeiLeiTaClgConfig.instance:getExtremeStageCfgs(self._activityId)

	if extMaxStageId >= #extStageCfgs then
		FloatWordMgr.instance:show(lang("已通关"))
	else
		UIStateManager.instance:push(ViewName.DivineWeiLeiTaClgExtremeView, self._activityId)
	end
end

function DivineWeiLeiTaClgMainView:_onClickPrize()
	GotoMgr.gotoByString(self._activityCfg.jumpTo[1])
end

function DivineWeiLeiTaClgMainView:_onClickCall()
	GotoMgr.gotoByString(self._activityCfg.jumpTo[3])
end

function DivineWeiLeiTaClgMainView:_onClickRank()
	GotoMgr.gotoByString(self._activityCfg.jumpTo[2])
end

function DivineWeiLeiTaClgMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.raceId)
end

function DivineWeiLeiTaClgMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.raceId)
end

return DivineWeiLeiTaClgMainView
