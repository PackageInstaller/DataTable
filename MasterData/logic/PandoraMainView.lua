-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pandoracopy/view/PandoraMainView.lua

module("logic.extensions.pandoracopy.view.PandoraMainView", package.seeall)

local PandoraMainView = class("PandoraMainView", ViewComponent)

function PandoraMainView:ctor()
	PandoraMainView.super.ctor(self)
end

function PandoraMainView:bindEvents()
	PandoraMainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(self._onClickBtnShowTip, self)
	self._gotoBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.PandoraBattleView, self._challCfg.challengeId)
	end, self)
	self._rankBtn:AddClickListener(self._onClickBtnJumpRank, self)
	self._skillBtn:AddClickListener(function()
		PetbookController.instance:previewBattle(self._challCfg.skinId)
	end, self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(self._challCfg.skinId)
	end, self)
	self._btnH5:AddClickListener(self._onClickBtnJumpH5, self)
	self._btnStoreOne:AddClickListener(self._onClickBtnJumpStoreOne, self)
	self._btnStoreTwo:AddClickListener(self._onClickBtnJumpStoreTwo, self)
end

function PandoraMainView:unbindEvents()
	PandoraMainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._gotoBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._introduceBtn:RemoveClickListener()
	self._btnH5:RemoveClickListener()
	self._btnStoreOne:RemoveClickListener()
	self._btnStoreTwo:RemoveClickListener()
end

function PandoraMainView:onExit()
	PandoraMainView.super.onExit(self)
	removetimer(self._calculationSurplusTime, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil
	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)

	MaterialMgr.resetAll(self._sprintRareGo)
	MaterialMgr.resetAll(self._tryGoods)
	MaterialMgr.resetAll(self._shopGoods)
end

function PandoraMainView:destroyUI()
	PandoraMainView.super.destroyUI(self)
end

function PandoraMainView:buildUI()
	PandoraMainView.super.buildUI(self)

	self._sprintGo = self:getGo("sprintGo")

	local sprintInfoGo = self:getGo("sprintInfoGo")

	self._sprintRareGo = goutil.findChild(sprintInfoGo, "rareGo")
	self._skillBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "skillBtn")
	self._introduceBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "introduceBtn")

	local shopItemGo = self:getGo("shopItemGo")

	self._shopGoods = goutil.findChild(shopItemGo, "shopGoods")
	self._shopBtn = Framework.ButtonAdapter.GetFrom(shopItemGo, "shopBtn")
	self._contractBtn = Framework.ButtonAdapter.GetFrom(shopItemGo, "contractBtn")
	self._tryBtn = self:getBtn("tryBtn")
	self._tryGo = self:getGo("tryGo")
	self._tryGoods = goutil.findChild(self._tryGo, "tryGoods")
	self._rankBtn = self:getBtn("rankBtn")
	self._gotoBtn = self:getBtn("gotoBtn")
	self._gotoRedGo = self:getGo("gotoBtn/gotoRedGo")
	self._gotoEffGo = self:getGo("gotoBtn/gotoEffGo")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._closeBtn = self:getBtn("closeBtn")
	self._timerTxt = self:getGo("timerTxt"):GetComponent("Text")

	self._gotoRedGo:SetActive(false)
	self._tryGo:SetActive(false)

	self._timerTxt.text = ""
	self._btnH5 = self:getBtn("btnH5")
	self._btnStoreOne = self:getBtn("btnStore(1)")
	self._btnStoreTwo = self:getBtn("btnStore(2)")
end

function PandoraMainView:onEnter()
	PandoraMainView.super.onEnter(self)

	self._challCfg = MoonKingConfig.instance:getBattleBaseCfg(MoonKingModel.instance.pandoraChanllengeId)

	self:_showActivityTimer()
	self:_showSpriteRawInfo()
	self:_showPetTryGoodsInfo()

	local effPath = "fx_ui_tongtiaozhan/fx_ui_mianban_tongtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function PandoraMainView:_showActivityTimer()
	self._isActivityEnd = false

	removetimer(self._calculationSurplusTime, self)

	if not TLChallengeController.instance:isInOpenTime(self._challCfg.challengeId) then
		self._isActivityEnd = true
		self._timerTxt.text = ""

		return
	end

	local actCfg = TimeLimitedConfig.instance:getCfgById(self._challCfg.challengeId)
	local start, timer = TLChallengeController.instance:getStartAndEndTime(actCfg)

	if start == nil or checknumber(timer) <= ServerTime.now() then
		self._timerTxt.text = lang("text_tong_desc_12")
		self._isActivityEnd = true
	end

	self._endTime = timer

	self:_calculationSurplusTime()
	settimer(1, self._calculationSurplusTime, self, true)
end

function PandoraMainView:_calculationSurplusTime()
	local supTime = self._endTime - ServerTime.now()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timerTxt.text = lang("text_tong_desc_12")
		self._isActivityEnd = true

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timerTxt.text = day > 0 and langPara("text_suo_timer_1", day, hour, min) or langPara("text_suo_timer_2", hour, min, sec)
end

function PandoraMainView:_showSpriteRawInfo()
	MaterialMgr.setCell(MatType.Rare, self._challCfg.skinId, self._sprintRareGo)

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, self._challCfg.skinId, self._sprintGo, self._challCfg.modelScale, nil, true, 0, 0)
end

function PandoraMainView:_showPetTryGoodsInfo()
	local isShow = MoonKingModel.instance:getPandoraRedpoint(true)

	self._gotoRedGo:SetActive(isShow)

	if checknumber(self._challCfg.GOODS_ID) > 0 then
		local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._challCfg.GOODS_ID)
		local arr = string.split(goodsCfg.content, "#")

		MaterialMgr.setCellByCfg(arr[1], self._shopGoods)
	end
end

function PandoraMainView:_onClickBtnJumpH5()
	if self._challCfg == nil or string.nilorempty(self._challCfg.jumpTo1) then
		return
	end

	GotoMgr.gotoByString(self._challCfg.jumpTo1)
end

function PandoraMainView:_onClickBtnJumpStoreOne()
	if self._challCfg == nil or string.nilorempty(self._challCfg.jumpTo2) then
		return
	end

	GotoMgr.gotoByString(self._challCfg.jumpTo2)
end

function PandoraMainView:_onClickBtnJumpStoreTwo()
	if self._challCfg == nil or string.nilorempty(self._challCfg.jumpTo3) then
		return
	end

	GotoMgr.gotoByString(self._challCfg.jumpTo3)
end

function PandoraMainView:_onClickBtnJumpRank()
	if self._challCfg == nil or string.nilorempty(self._challCfg.jumpTo4) then
		return
	end

	GotoMgr.gotoByString(self._challCfg.jumpTo4)
end

function PandoraMainView:_onClickBtnShowTip()
	if self._challCfg == nil or string.nilorempty(self._challCfg.tipsStr) then
		return
	end

	UIStateManager.instance:push(ViewName.RulesView, self._challCfg.tipsStr)
end

return PandoraMainView
