-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/MoonKingMainView.lua

module("logic.extensions.moonking.view.MoonKingMainView", package.seeall)

local MoonKingMainView = class("MoonKingMainView", ViewComponent)

function MoonKingMainView:ctor()
	MoonKingMainView.super.ctor(self)
end

function MoonKingMainView:bindEvents()
	MoonKingMainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "moonkingmain")
	end, self)
	self._gotoBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.MoonKingBattle, self._challCfg.challengeId)
	end, self)
	self._rankBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.MoonKingRank, true)
	end, self)
	self._tryBtn:AddClickListener(function()
		FuncOpenController.instance:openFunc(149, self._challCfg.skinId)
	end, self)
	self._shopBtn:AddClickListener(function()
		if checknumber(self._challCfg.GOODS_ID) > 0 then
			PayShopController.instance:buyShopItemWithTips(self._challCfg.GOODS_ID)
		end
	end, self)
	self._contractBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.ContractEnterView)
	end, self)
	self._skillBtn:AddClickListener(function()
		PetbookController.instance:previewBattle(self._challCfg.skinId)
	end, self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(self._challCfg.skinId)
	end, self)
end

function MoonKingMainView:unbindEvents()
	MoonKingMainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._gotoBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._tryBtn:RemoveClickListener()
	self._shopBtn:RemoveClickListener()
	self._contractBtn:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._introduceBtn:RemoveClickListener()
end

function MoonKingMainView:onExit()
	MoonKingMainView.super.onExit(self)
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

function MoonKingMainView:destroyUI()
	MoonKingMainView.super.destroyUI(self)
end

function MoonKingMainView:buildUI()
	MoonKingMainView.super.buildUI(self)

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
end

function MoonKingMainView:onEnter()
	MoonKingMainView.super.onEnter(self)

	self._challCfg = MoonKingConfig.instance:getBattleBaseCfg(MoonKingModel.instance.challengeId)

	self:_showActivityTimer()
	self:_showSpriteRawInfo()
	self:_showPetTryGoodsInfo()

	local effPath = "fx_ui_tongtiaozhan/fx_ui_mianban_tongtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function MoonKingMainView:_showActivityTimer()
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

function MoonKingMainView:_calculationSurplusTime()
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

function MoonKingMainView:_showSpriteRawInfo()
	MaterialMgr.setCell(MatType.Rare, self._challCfg.skinId, self._sprintRareGo)

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, self._challCfg.skinId, self._sprintGo, self._challCfg.modelScale, nil, true, 0, 0)
end

function MoonKingMainView:_showPetTryGoodsInfo()
	local isShow = MoonKingModel.instance:getMoonkingRedpoint(true)

	self._gotoRedGo:SetActive(isShow)

	if checknumber(self._challCfg.GOODS_ID) > 0 then
		local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._challCfg.GOODS_ID)
		local arr = string.split(goodsCfg.content, "#")

		MaterialMgr.setCellByCfg(arr[1], self._shopGoods)
	end

	local passId = PetCollegeModel.instance:getCurrPassStageId(self._challCfg.challengeId)
	local stageCfgs = PetCollegeConfig.instance:getStageCfg(self._challCfg.challengeId)
	local prizeDic = {}

	for _, cfg in ipairs(stageCfgs or {}) do
		if cfg and passId < checknumber(cfg.stageId) then
			local matType, matId, matNum = unpack(string.splitToNumber(cfg.firstPassPrize, ":"))
			local key = matType .. ":" .. matId

			prizeDic[key] = checknumber(prizeDic[key]) + matNum
		end
	end

	local matStr = ""

	for str, num in pairs(prizeDic) do
		matStr = str .. ": " .. num
	end

	if string.nilorempty(matStr) then
		self._tryGo:SetActive(false)

		return
	end

	self._tryGo:SetActive(true)
	MaterialMgr.setCellByCfg(matStr, self._tryGoods)
end

return MoonKingMainView
