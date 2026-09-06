-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiumumchallenge/view/XiuMumMainView.lua

module("logic.extensions.xiumumchallenge.view.XiuMumMainView", package.seeall)

local XiuMumMainView = class("XiuMumMainView", ViewComponent)

function XiuMumMainView:buildUI()
	XiuMumMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnRank = self:getGo("btnRank")
	self._btnChange = self:getGo("btnChange")
	self._btnCultivate = self:getGo("btnCultivate")
	self._btnChallenge = self:getGo("btnChallenge")
	self._btnShop = self:getGo("btnShop")
	self._redPoint = goutil.findChild(self._btnChallenge, "redPoint")
	self._txtLeftTime = self:getTxt("time/txt")
	self._con = self:getGo("con")
	self._rare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._txtName = self:getTxt("petInfo/txtName")
end

function XiuMumMainView:bindEvents()
	XiuMumMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnCultivate, self._onClickCultivate, self)
	GameUtil.addClickHandler(self._btnChange, self._onClickChange, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
end

function XiuMumMainView:unbindEvents()
	XiuMumMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnCultivate)
	GameUtil.rmClickHandler(self._btnChange)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnShop)
end

function XiuMumMainView:onEnter()
	XiuMumMainView.super.onEnter(self)

	self._actId = self:_getActivityId()

	if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.XIU_MUM_CHALLENGE, self._actId) then
		self:_refreshViewByCfg()
		XiuMumChallengeController.instance:getInfo(self._actId)
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动不在时间内"), GameUtil.handler(self.close, self))
	end

	GlobalDispatcher:addListener(GlobalNotify.XiuMumChallengeUpdateInfo, self._refreshViewByInfo, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onRefreshDaily, self)
	XiuMumChallengeModel.instance:ShowCI()
end

function XiuMumMainView:onExit()
	XiuMumMainView.super.onExit(self)
	MaterialMgr.resetAll(self._rare)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	GlobalDispatcher:removeListener(GlobalNotify.XiuMumChallengeUpdateInfo, self._refreshViewByInfo, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._onRefreshDaily, self)
	RedPointController.instance:unregRedPoint(self._redPoint)
	removetimer(self._onTick, self)
end

function XiuMumMainView:_getActivityId()
	self._openParam = self:getOpenParam()

	return checkint(self._openParam[1])
end

function XiuMumMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, self._challengeCfg.ruleKey)
end

function XiuMumMainView:_onClickRank()
	if self._actCfg then
		if string.nilorempty(self._actCfg) then
			printError("通知策划配置gotoRank")
		else
			GotoMgr.gotoByString(self._actCfg)
		end
	end
end

function XiuMumMainView:_onClickCultivate()
	if self._actCfg then
		if string.nilorempty(self._actCfg) then
			printError("通知策划配置gotoShop")
		else
			GotoMgr.gotoByString(self._actCfg)
		end
	end
end

function XiuMumMainView:_onClickChange()
	if self._actCfg then
		if string.nilorempty(self._actCfg) then
			printError("通知策划配置gotoExchangeShop")
		else
			GotoMgr.gotoByString(self._actCfg)
		end
	end
end

function XiuMumMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.XiuMumLevelView)
end

function XiuMumMainView:_onClickSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self._skinId)
	end
end

function XiuMumMainView:_refreshViewByCfg()
	self._actCfg = XiuMumChallengeConfig.instance:getActCfgByActId(self._actId)
	self._challengeId = self._actCfg.challengeId
	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)
	self._skinId = checkint(self._challengeCfg.raceId)

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

	self._txtName.text = skinCfg.name
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._skinId, self._con, 1)

	MaterialMgr.setCell(MatType.Rare, self._skinId, self._rare)

	self._txtLeftTime.text = TimeGateController.instance:getActTimeShow(self._actId)
end

function XiuMumMainView:_refreshViewByInfo()
	return
end

function XiuMumMainView:_onTick()
	if self._challengeId == nil or not TLChallengeController.instance:isInOpenTime(self._challengeId) then
		if self._txtLeftTime then
			self._txtLeftTime.text = ""
		end

		local text = "活动已经结束"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
		removetimer(self._onTick, self)
	else
		local leftTimeFormat = TLChallengeController.instance:getLeftTimeFormat(self._challengeId)

		if self._txtLeftTime then
			self._txtLeftTime.text = string.format("距离活动结束：%s", leftTimeFormat)
		end
	end
end

function XiuMumMainView:_onRefreshDaily()
	XiuMumChallengeController.instance:getInfo(self._actId)
end

function XiuMumMainView:_onClickShop()
	GotoMgr.gotoByString("mibao#Skin1")
end

return XiuMumMainView
