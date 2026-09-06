-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yuhuichallenge/view/YuHuiChallengeMainView.lua

module("logic.extensions.yuhuichallenge.view.YuHuiChallengeMainView", package.seeall)

local YuHuiChallengeMainView = class("YuHuiChallengeMainView", ViewComponent)

function YuHuiChallengeMainView:buildUI()
	YuHuiChallengeMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnShop = self:getGo("leftBottom/btnShop")
	self._btnRank = self:getGo("leftBottom/btnRank")
	self._btnCall = self:getGo("leftBottom/btnCall")
	self._btnEnter = self:getGo("btnEnter")
	self._petCon = self:getGo("petCon")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._txtTime = self:getTxt("time/txt")
	self._curChallengeId = 107
end

function YuHuiChallengeMainView:bindEvents()
	YuHuiChallengeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
end

function YuHuiChallengeMainView:unbindEvents()
	YuHuiChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnCall)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
end

function YuHuiChallengeMainView:onEnter()
	YuHuiChallengeMainView.super.onEnter(self)
	self:getConfigs()
	self:refreshViewByCfg()
end

function YuHuiChallengeMainView:onExit()
	YuHuiChallengeMainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	MaterialMgr.resetAll(self._pointRare)
end

function YuHuiChallengeMainView:_onClickTip()
	if self._actCfg then
		UIStateManager.instance:push(ViewName.RulesView, self._actCfg.ruleKey)
	end
end

function YuHuiChallengeMainView:_onClickShop()
	GotoMgr.gotoByString(self._challengeCfg.gotoShop)
end

function YuHuiChallengeMainView:_onClickRank()
	GotoMgr.gotoByString(self._challengeCfg.gotoRank)
end

function YuHuiChallengeMainView:_onClickCall()
	GotoMgr.gotoByString(self._challengeCfg.gotoCall)
end

function YuHuiChallengeMainView:_onClickEnter()
	UIStateManager.instance:push(ViewName.YuHuiChallengeLevelView, self._curChallengeId)
end

function YuHuiChallengeMainView:_onClickSkill()
	if self._skinCfg then
		PetbookController.instance:previewBattle(self._skinCfg.raceId, self._skinCfg.skinId)
	end
end

function YuHuiChallengeMainView:_onClickInfo()
	if self._skinCfg then
		PetbookController.instance:openPetinfoView(self._skinCfg.raceId)
	end
end

function YuHuiChallengeMainView:getConfigs()
	self._actCfg = TimeLimitedConfig.instance:getCfgById(self._curChallengeId)

	if self._actCfg then
		self._skinCfg = PetSkinConfig.instance:getPetSkinCfg(self._actCfg.raceId)
		self._challengeCfg = YuHuiChallengeConfig.instance:getChallengeCfgById(self._curChallengeId)
	else
		printError("余灰挑战配置为空：" .. self._curChallengeId)
	end

	if TLChallengeController.instance:isInOpenTime(self._curChallengeId) then
		YuHuiChallengeController.instance:getInfo(self._curChallengeId)
	else
		self._txtTime.text = ""

		local text = lang("活动已经结束")

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
	end
end

function YuHuiChallengeMainView:refreshViewByCfg()
	if self._challengeCfg then
		goutil.setActive(self._btnShop, false)
		goutil.setActive(self._btnCall, not string.nilorempty(self._challengeCfg.gotoCall))
		goutil.setActive(self._btnRank, not string.nilorempty(self._challengeCfg.gotoRank))
		self:setPetInfo()
		self:setActTime()
	end
end

function YuHuiChallengeMainView:setPetInfo()
	if self._skinCfg then
		MaterialMgr.setCell(MatType.Rare, self._skinCfg.skinId, self._pointRare)

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._skinCfg.skinId, self._petCon, 1)
	end
end

function YuHuiChallengeMainView:setActTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShowByChallengeId(self._curChallengeId)
end

return YuHuiChallengeMainView
