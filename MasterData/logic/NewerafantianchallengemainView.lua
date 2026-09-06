-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yuhuichallenge/view/copy/NewerafantianchallengemainView.lua

module("logic.extensions.yuhuichallenge.view.copy.NewerafantianchallengemainView", package.seeall)

local NewerafantianchallengemainView = class("NewerafantianchallengemainView", ViewComponent)

function NewerafantianchallengemainView:buildUI()
	NewerafantianchallengemainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnShop = self:getGo("leftBottom/btnShop")
	self._btnRank = self:getGo("leftBottom/btnRank")
	self._btnCall = self:getGo("leftBottom/btnCall")
	self._btnCultivation = self:getGo("leftBottom/btnCultivation")
	self._btnEnter = self:getGo("btnEnter")
	self._petCon = self:getGo("petCon")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._txtTime = self:getTxt("time/txt")
	self._txtName = self:getTxt("petInfo/txtName")
	self._curChallengeId = 270
	self._redPointGo = self:getGo("btnBuff/redPoint")
	self._btnBuffGo = self:getGo("btnBuff")
	self._buffText = self:getTxt("btnBuff/txtBuff")
end

function NewerafantianchallengemainView:bindEvents()
	NewerafantianchallengemainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnCultivation, self._onClickCultivation, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnBuffGo, self._onClickBuff, self)
end

function NewerafantianchallengemainView:unbindEvents()
	NewerafantianchallengemainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnCall)
	GameUtil.rmClickHandler(self._btnCultivation)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnBuffGo)
end

function NewerafantianchallengemainView:onEnter()
	NewerafantianchallengemainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.YuHuiCallengeGetInfo, self._updateBuffUI, self)
	self:getConfigs()
	self:refreshViewByCfg()
	self:_updateBuffUI()
end

function NewerafantianchallengemainView:onExit()
	NewerafantianchallengemainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	MaterialMgr.resetAll(self._pointRare)
end

function NewerafantianchallengemainView:_onClickTip()
	if self._actCfg then
		UIStateManager.instance:push(ViewName.RulesView, self._actCfg.ruleKey)
	end
end

function NewerafantianchallengemainView:_onClickShop()
	GotoMgr.gotoByString(self._challengeCfg.gotoShop)
end

function NewerafantianchallengemainView:_onClickRank()
	GotoMgr.gotoByString(self._challengeCfg.gotoRank)
end

function NewerafantianchallengemainView:_onClickCall()
	GotoMgr.gotoByString(self._challengeCfg.gotoCall)
end

function NewerafantianchallengemainView:_onClickCultivation()
	GotoMgr.gotoByString(self._challengeCfg.gotoCultivation)
end

function NewerafantianchallengemainView:_onClickEnter()
	UIStateManager.instance:push(ViewName.NewerafantianchallengelevelView, self._curChallengeId)
end

function NewerafantianchallengemainView:_onClickSkill()
	if self._skinCfg then
		PetbookController.instance:previewBattle(self._skinCfg.raceId, self._skinCfg.skinId)
	end
end

function NewerafantianchallengemainView:_onClickInfo()
	if self._skinCfg then
		PetbookController.instance:openPetinfoView(self._skinCfg.raceId)
	end
end

function NewerafantianchallengemainView:getConfigs()
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

function NewerafantianchallengemainView:refreshViewByCfg()
	if self._challengeCfg then
		goutil.setActive(self._btnShop, not string.nilorempty(self._challengeCfg.gotoShop))
		goutil.setActive(self._btnCall, not string.nilorempty(self._challengeCfg.gotoCall))
		goutil.setActive(self._btnRank, not string.nilorempty(self._challengeCfg.gotoRank))
		goutil.setActive(self._btnCultivation, not string.nilorempty(self._challengeCfg.gotoCultivation))
		self:setPetInfo()
		self:setActTime()
	end
end

function NewerafantianchallengemainView:setPetInfo()
	if self._skinCfg then
		MaterialMgr.setCell(MatType.Rare, self._skinCfg.skinId, self._pointRare)

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._skinCfg.skinId, self._petCon, 1)
		self._txtName.text = self._skinCfg.skinName
	end
end

function NewerafantianchallengemainView:setActTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShowByChallengeId(self._curChallengeId)
end

function NewerafantianchallengemainView:_updateBuffUI()
	local cfg = YuHuiChallengeConfig.instance:getChallengeCfgById(self._curChallengeId) or {}
	local signInBuffPlanId = cfg.signInBuffPlanId
	local info = YuHuiChallengeModel.instance:getInfo(self._curChallengeId) or {}
	local signInBuffLv = info.signInBuffLv
	local isSignIn = info.isSignIn
	local buffCfg = YuHuiChallengeConfig.instance:getSingBuffCfgs(signInBuffPlanId, signInBuffLv)

	self._buffText.text = buffCfg == nil and "未获得加成" or buffCfg.desc

	self._redPointGo:SetActive(not isSignIn)
end

function NewerafantianchallengemainView:_onClickBuff()
	local info = YuHuiChallengeModel.instance:getInfo(self._curChallengeId) or {}
	local isSignIn = info.isSignIn

	if isSignIn then
		FloatWordMgr.instance:show("今日加成已生效")

		return
	end

	local curLv = YuHuiChallengeModel.instance:getSignInBuffLv(self._curChallengeId)
	local actCfg = YuHuiChallengeConfig.instance:getChallengeCfgById(self._curChallengeId)
	local buffCfg = YuHuiChallengeConfig.instance:getSingBuffCfgs(actCfg.buffPlanId, curLv + 1)

	if not buffCfg then
		FloatWordMgr.instance:show("Buff已满级")

		return
	end

	YuHuiChallengeController.instance:sendSignBuff(self._curChallengeId)
end

return NewerafantianchallengemainView
