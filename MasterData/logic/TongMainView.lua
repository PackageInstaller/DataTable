-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/TongMainView.lua

module("logic.extensions.tongbattle.view.TongMainView", package.seeall)

local TongMainView = class("TongMainView", ViewComponent)

function TongMainView:ctor()
	TongMainView.super.ctor(self)
end

function TongMainView:bindEvents()
	TongMainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "tongmain")
	end, self)
	self._gotoBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.TongBattle)
	end, self)
	self._rankBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.TongRank, true)
	end, self)
	self._tryBtn:AddClickListener(function()
		FuncOpenController.instance:openFunc(149, self._petRaceId)
	end, self)
	self._shopBtn:AddClickListener(function()
		if not string.nilorempty(self._challCfg.GOODS_ID) then
			PayShopController.instance:buyShopItemWithTips(self._challCfg.GOODS_ID)
		end
	end, self)
	self._skillBtn:AddClickListener(function()
		PetbookController.instance:previewBattle(self._petRaceId)
	end, self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(self._petRaceId)
	end, self)
end

function TongMainView:unbindEvents()
	TongMainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._gotoBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._tryBtn:RemoveClickListener()
	self._shopBtn:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._introduceBtn:RemoveClickListener()
end

function TongMainView:onExit()
	TongMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateTongBaseInfo, self._updataMainViewInfo, self)
	removetimer(self._calculationSurplusTime, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil

	if self._ziEff then
		UIEffectManager.instance:stopEffect(self._ziEff)
	end

	self._ziEff = nil

	if self._gotoEff then
		UIEffectManager.instance:stopEffect(self._gotoEff)
	end

	self._gotoEff = nil
	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)

	MaterialMgr.resetAll(self._sprintRareGo)
	MaterialMgr.resetAll(self._tryGoods)
	MaterialMgr.resetAll(self._shopGoods)
end

function TongMainView:destroyUI()
	TongMainView.super.destroyUI(self)
	uGuiUtil.clearImage(self._prizeIconIma.gameObject)
end

function TongMainView:buildUI()
	TongMainView.super.buildUI(self)

	self._sprintGo = self:getGo("sprintGo")
	self._sloganImaGo = self:getGo("sloganImaGo")

	local sprintInfoGo = self:getGo("sprintInfoGo")

	self._sprintRareGo = goutil.findChild(sprintInfoGo, "rareGo")
	self._skillBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "skillBtn")
	self._introduceBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "introduceBtn")

	local shopItemGo = self:getGo("shopItemGo")

	self._shopGoods = goutil.findChild(shopItemGo, "shopGoods")
	self._shopBtn = Framework.ButtonAdapter.GetFrom(shopItemGo, "shopBtn")
	self._tryBtn = self:getBtn("tryBtn")
	self._tryGo = self:getGo("tryGo")
	self._tryGoods = goutil.findChild(self._tryGo, "tryGoods")
	self._rankBtn = self:getBtn("rankBtn")
	self._rankGo = self:getGo("rankGo")
	self._rankGoods = goutil.findChild(self._rankGo, "rankGoods")
	self._rankTxt = goutil.findChildTextComponent(self._rankGo, "rankTxt")
	self._gotoBtn = self:getBtn("gotoBtn")
	self._gotoRedGo = self:getGo("gotoBtn/gotoRedGo")
	self._gotoEffGo = self:getGo("gotoBtn/gotoEffGo")
	self._daySupTxt = self:getGo("daySupGo/daySupTxt"):GetComponent("Text")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._closeBtn = self:getBtn("closeBtn")
	self._timerTxt = self:getGo("timerTxt"):GetComponent("Text")

	local prizeLimitGo = self:getGo("prizeLimitGo")

	self._prizeDescTxt = goutil.findChildTextComponent(prizeLimitGo, "prizeDescTxt")
	self._prizeCountTxt = goutil.findChildTextComponent(prizeLimitGo, "prizeCountTxt")
	self._prizeIconIma = goutil.findChild(prizeLimitGo, "prizeCountTxt/prizeIconIma"):GetComponent("Image")
	self._rankTxt.text = ""

	self._gotoRedGo:SetActive(false)
	self._tryGo:SetActive(false)
	self._rankGo:SetActive(false)

	self._daySupTxt.text = ""
	self._timerTxt.text = ""
end

function TongMainView:onEnter()
	TongMainView.super.onEnter(self)

	self._petRaceId = TongBattleModel.instance.petRaceId
	self._challCfg = TongBattleConfig.instance:getBattleBaseCfg(TongBattleModel.instance.challengeId)

	self:_showActivityTimer()
	self:_showSpriteRawInfo()
	self:_showPetTryGoodsInfo()
	self:_updataMainViewInfo()

	local effPath = "fx_ui_tongtiaozhan/fx_ui_mianban_tongtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
	GlobalDispatcher:addListener(GlobalNotify.UpdateTongBaseInfo, self._updataMainViewInfo, self)
	TongBattleController.instance:csGetTongBaseInfoReq()
end

function TongMainView:_updataMainViewInfo()
	self._baseInfo = TongBattleModel.instance:getTongBaseInfo()

	local supCount = math.max(self._challCfg.freeChallengeTimes + self._baseInfo.buyCount - self._baseInfo.useCount, 0)

	self._daySupTxt.text = langPara("text_tong_desc_21", supCount, self._challCfg.freeChallengeTimes)

	local list = string.split(self._challCfg.prizeLimit, ":")

	if list and #list >= 3 then
		local prizeCfg = MaterialMgr.getMatCfg(list[1], list[2])

		if prizeCfg then
			self._prizeDescTxt.text = langPara("text_tong_desc_9", prizeCfg.name)
			self._prizeCountTxt.text = string.format("<color=#F84F89FF>%s</color>/%s", self._baseInfo.prizeCount, list[3])

			MaterialMgr.setIcon(self._prizeIconIma, tonumber(list[1]), tonumber(list[2]))
		end
	end

	self._gotoRedGo:SetActive(TongBattleModel.instance:getTongBattleRedpoint())
end

function TongMainView:_showActivityTimer()
	self._isActivityEnd = false

	removetimer(self._calculationSurplusTime, self)

	if not TLChallengeController.instance:isInOpenTime(TongBattleModel.instance.challengeId) then
		self._isActivityEnd = true
		self._timerTxt.text = ""

		return
	end

	local actCfg = TimeLimitedConfig.instance:getCfgById(TongBattleModel.instance.challengeId)
	local start, timer = TLChallengeController.instance:getStartAndEndTime(actCfg)

	if start == nil or checknumber(timer) <= ServerTime.now() then
		self._timerTxt.text = lang("text_tong_desc_12")
		self._isActivityEnd = true
	end

	self._endTime = timer

	self:_calculationSurplusTime()
	settimer(1, self._calculationSurplusTime, self, true)
end

function TongMainView:_calculationSurplusTime()
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

function TongMainView:_showSpriteRawInfo()
	local effPath = "fx_ui_tongtiaozhan/fx_ui_mianban_zi_tongtiaozhan.prefab"

	self._ziEff = UIEffectManager.instance:playEffect(self, effPath, self._sloganImaGo, 0, 0, true, nil, nil, nil, self)

	self._ziEff:setParent(self._sloganImaGo.transform)
	self._ziEff:setLocalPos(0, 0, 0)
	self._ziEff:setScale(1)

	effPath = "fx_ui_tongtiaozhan/fx_ui_anniu_putongtiaozhan_tongtiaozhan.prefab"
	self._gotoEff = UIEffectManager.instance:playEffect(self, "fx_ui_tongtiaozhan/fx_ui_anniu_putongtiaozhan_tongtiaozhan.prefab", self._gotoEffGo, 0, 0, true, nil, nil, nil, self)

	self._gotoEff:setParent(self._gotoEffGo.transform)
	self._gotoEff:setLocalPos(0, 0, 0)
	self._gotoEff:setScale(1)
	MaterialMgr.setCell(MatType.Rare, self._petRaceId, self._sprintRareGo)

	local x, y, scale = 0, 0, 0.7

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, self._petRaceId, self._sprintGo, scale, nil, true, x, y)
end

function TongMainView:_showPetTryGoodsInfo()
	MaterialMgr.setCellByCfg(self._challCfg.JUMP_ITEM, self._shopGoods)

	local passId = PetCollegeModel.instance:getCurrPassStageId(TongBattleModel.instance.challengeId)
	local stageCfgs = PetCollegeConfig.instance:getStageCfg(TongBattleModel.instance.challengeId)
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

return TongMainView
