-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/view/HalloweenBossView.lua

module("logic.extensions.halloweenguest.view.HalloweenBossView", package.seeall)

local HalloweenBossView = class("HalloweenBossView", TableViewComponent)

function HalloweenBossView:ctor()
	HalloweenBossView.super.ctor(self)

	self._addElvesItemList = nil
	self._commBtnItemList = nil
end

function HalloweenBossView:bindEvents()
	HalloweenBossView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "halloweenboss")
	end, self)
	self._challBtn:AddClickListener(function()
		local openInfo = HalloweenGuestModel.instance:getBossOpenInfo()
		local data = {
			isBoss = true,
			actId = self._actCfg.activityId,
			baseId = openInfo.openId,
			planId = openInfo.planId
		}

		UIStateManager.instance:push(ViewName.HalloweenMission, data)
	end, self)
	self._rankBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.HalloweenBossRank, self._actCfg.rankPrizePlanId)
	end, self)
	self._damageBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.HalloweenBossPrize, self._actCfg.damagePrizePlanId)
	end, self)
	self._rewardBtn:AddClickListener(function()
		if self._bossInfo then
			if self._bossInfo.isGainDailyPrize then
				FloatWordMgr.instance:show(lang("text_halloween_desc_3"))

				return
			end

			if checknumber(self._bossInfo.dailyMaxDamage) <= 0 then
				FloatWordMgr.instance:show(lang("text_halloween_desc_4"))

				return
			end
		end

		HalloweenGuestController.instance:csGetHalloweenBossChallengeGainDailyPrizeReq()
	end, self)
	GameUtil.asBtn(self._commBtnItemList[1].btnGo):AddClickListener(function()
		self:_onClickCommBtn(1)
	end, self)
	GameUtil.asBtn(self._commBtnItemList[2].btnGo):AddClickListener(function()
		self:_onClickCommBtn(2)
	end, self)
	GameUtil.asBtn(self._commBtnItemList[3].btnGo):AddClickListener(function()
		self:_onClickCommBtn(3)
	end, self)
end

function HalloweenBossView:unbindEvents()
	HalloweenBossView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._challBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._damageBtn:RemoveClickListener()
	self._rewardBtn:RemoveClickListener()
	GameUtil.asBtn(self._commBtnItemList[1].btnGo):RemoveClickListener()
	GameUtil.asBtn(self._commBtnItemList[2].btnGo):RemoveClickListener()
	GameUtil.asBtn(self._commBtnItemList[3].btnGo):RemoveClickListener()
end

function HalloweenBossView:onExit()
	HalloweenBossView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HalloweenBossInfo, self._updataMonsterView, self)
	GlobalDispatcher:removeListener(GlobalNotify.HalloweenDailyPrize, self._updataRewardDailyPrize, self)
	GlobalDispatcher:removeListener(GlobalNotify.HalloweenDamagePrize, self._updataDamagePrizeRed, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil
end

function HalloweenBossView:destroyUI()
	HalloweenBossView.super.destroyUI(self)

	for _, item in pairs(self._addElvesItemList or {}) do
		if item and item.iconIma then
			local bigBg = item.iconIma:GetComponent("ImageBigBG")

			if bigBg then
				bigBg:ClearImage()
			end
		end
	end

	self._addElvesItemList = nil
	self._commBtnItemList = nil

	if self.photoEff then
		self.photoEff:clear()
	end
end

function HalloweenBossView:buildUI()
	HalloweenBossView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._descTxt = goutil.findChildTextComponent(self.mainGO, "descGo/descTxt")
	self._challBtn = self:getBtn("challBtn")
	self._rankBtn = self:getBtn("rankBtn")
	self._damageBtn = self:getBtn("damageBtn")
	self._damageRedGo = self:getGo("damageBtn/damageRedGo")
	self._damageGo = self:getGo("damageGo")
	self._damagePos = goutil.findChild(self._damageGo, "damagePos")
	self._damageTxt = goutil.findChildTextComponent(self._damageGo, "damageTxt")
	self._rewardBtn = self:getBtn("rewardBtn")
	self._rewardRedGo = self:getGo("rewardBtn/rewardRedGo")
	self._addElvesItemList = {}

	local addElvesGo = self:getGo("addElvesGo_1")

	self._addElvesItemList[1] = {
		headIconGo = goutil.findChild(addElvesGo, "headIcon"),
		clickGo = goutil.findChild(addElvesGo, "clickGo"),
		showTxt = goutil.findChildTextComponent(addElvesGo, "showTxt")
	}
	addElvesGo = self:getGo("addElvesGo_2")
	self._addElvesItemList[2] = {
		headIconGo = goutil.findChild(addElvesGo, "headIcon"),
		clickGo = goutil.findChild(addElvesGo, "clickGo"),
		showTxt = goutil.findChildTextComponent(addElvesGo, "showTxt")
	}

	local commElvesGo = self:getGo("commElvesGo")

	self._commBtnItemList = {}
	self._commBtnItemList[1] = {
		btnGo = goutil.findChild(commElvesGo, "commBtn_1"),
		selectGo = goutil.findChild(commElvesGo, "commBtn_1/selectGo"),
		tagGo = goutil.findChild(commElvesGo, "commBtn_1/tagGo")
	}
	self._commBtnItemList[2] = {
		btnGo = goutil.findChild(commElvesGo, "commBtn_2"),
		selectGo = goutil.findChild(commElvesGo, "commBtn_2/selectGo"),
		tagGo = goutil.findChild(commElvesGo, "commBtn_2/tagGo")
	}
	self._commBtnItemList[3] = {
		btnGo = goutil.findChild(commElvesGo, "commBtn_3"),
		selectGo = goutil.findChild(commElvesGo, "commBtn_3/selectGo"),
		tagGo = goutil.findChild(commElvesGo, "commBtn_3/tagGo")
	}
	self._scoreTxt = self:getGo("scoreGo/scoreTxt"):GetComponent("Text")

	local spriteRawIma = self:getGo("spriteRawIma")

	self.photoEff = PhotoEffect.Get(spriteRawIma)
	self.roleImg = spriteRawIma:GetComponent("RawImage")
	self.roleImg.material = nil
	self._descTxt.text = ""
	self._damageTxt.text = ""

	self._damageGo:SetActive(false)
	self._damageRedGo:SetActive(false)
	self._rewardRedGo:SetActive(false)

	self._scoreTxt.text = ""
end

function HalloweenBossView:onEnter()
	HalloweenBossView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.HalloweenBossInfo, self._updataMonsterView, self)
	GlobalDispatcher:addListener(GlobalNotify.HalloweenDailyPrize, self._updataRewardDailyPrize, self)
	GlobalDispatcher:addListener(GlobalNotify.HalloweenDamagePrize, self._updataDamagePrizeRed, self)

	if not HalloweenGuestConfig.instance:isSetBossOpenInfo() then
		self:close()
		FloatWordMgr.instance:show("不在活动时间内")

		if Framework.OSDef.isEditor then
			printError("检查一下 export_敌阵配置  in  w万圣节-boss挑战.xlsx里面的时间，tips：每个id只开一天")
		end

		return
	end

	HalloweenGuestController.instance:csGetHalloweenBossChallengeGetInfoReq()
	self:_updataMonsterView()

	local effPath = "20211028/wanshenjie_xuanshang/fx_ui_wanshengjie_xuanshang.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)

	local value = GameUtil.getUserData("HalloweenBossRuleView")

	if checknumber(value) ~= 1 then
		GameUtil.saveUserData("HalloweenBossRuleView", 1)
		UIStateManager.instance:push(ViewName.RulesView, "halloweenboss")
	end
end

function HalloweenBossView:_updataMonsterView()
	self._bossInfo = HalloweenGuestModel.instance:getHalloweenBossInfo()

	local openInfo = HalloweenGuestModel.instance:getBossOpenInfo()
	local cfg = HalloweenGuestConfig.instance:getBossTeamCfg(openInfo.planId, openInfo.openId)

	self._actCfg = HalloweenGuestConfig.instance:getActBossCfg(openInfo.actId)
	self._descTxt.text = self._actCfg.viewDesc

	self.photoEff:setEffectLoadedCallback(function(go)
		GoUtil.PlaySpineAnim(go, "idle", true, true)
		Framework.TransformUtil.SetLocalScale(go.transform, 0.4, 0.4, 0.4)
		Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
	end)

	local resCfg = CharacterConfig.instance:getModelCo(cfg.bossRaceId)

	self.photoEff:showEffectsFullScreen({
		GameUrl.getSpineUrl(resCfg.resName)
	})
	self.photoEff:setCameraPosition(0.8, 2.6, -1)

	local camera = self.photoEff._photo.producer.rtCamera

	camera.orthographic = true

	Game.ImageUtil.SetRawImageAlpha(self.roleImg, 1)

	self._scoreTxt.text = langPara("text_halloween_desc_13", self._bossInfo.totalDamage, self._bossInfo.dailyMaxDamage)

	MaterialMgr.resetAll(self._damagePos)

	local rewardCfg = HalloweenGuestModel.instance:getCurrentBossDamagePrize(self._actCfg.damagePrizePlanId)

	if rewardCfg and not string.nilorempty(rewardCfg.prize) then
		self._damageGo:SetActive(true)

		self._damageTxt.text = langPara("text_halloween_desc_5", rewardCfg.damage)

		local list = string.split(rewardCfg.prize, "#")

		MaterialMgr.setCellByCfg(list[1], self._damagePos)
	else
		self._damageTxt.text = ""

		self._damageGo:SetActive(false)
	end

	local isShow = HalloweenGuestModel.instance:getDailyPrizeRedpoint()

	self._rewardRedGo:SetActive(isShow)

	isShow = HalloweenGuestModel.instance:getDamagePrizeRedpoint(self._actCfg.damagePrizePlanId)

	self._damageRedGo:SetActive(isShow)
	MaterialMgr.clearIcon(self._addElvesItemList[1].headIconGo)
	MaterialMgr.clearIcon(self._addElvesItemList[2].headIconGo)
	GameUtil.asBtn(self._addElvesItemList[1].clickGo):RemoveClickListener()
	GameUtil.asBtn(self._addElvesItemList[2].clickGo):RemoveClickListener()

	local addPetCfgs = HalloweenGuestConfig.instance:getBossBuffCfg(self._actCfg.buffPlanId)

	if addPetCfgs and addPetCfgs[1] then
		self._addElvesItemList[1].showTxt.text = addPetCfgs[1].des

		MaterialMgr.setIcon(self._addElvesItemList[1].headIconGo, MatType.Pet, addPetCfgs[1].raceId)

		local petCfg = MaterialMgr.getMatCfg(MatType.Pet, addPetCfgs[1].raceId)

		if petCfg then
			if not petCfg.name then
				local petName = "精灵"

				GameUtil.asBtn(self._addElvesItemList[1].clickGo):AddClickListener(function()
					FloatWordMgr.instance:show(langPara("text_halloween_desc_6", petName, addPetCfgs[1].des))
				end, self)
			end
		end
	else
		self._addElvesItemList[1].showTxt.text = ""
	end

	if addPetCfgs and addPetCfgs[2] then
		self._addElvesItemList[2].showTxt.text = addPetCfgs[2].des

		MaterialMgr.setIcon(self._addElvesItemList[2].headIconGo, MatType.Pet, addPetCfgs[2].raceId)

		local petCfg = MaterialMgr.getMatCfg(MatType.Pet, addPetCfgs[2].raceId)

		if petCfg then
			if not petCfg.name then
				local petName = "精灵"

				GameUtil.asBtn(self._addElvesItemList[2].clickGo):AddClickListener(function()
					FloatWordMgr.instance:show(langPara("text_halloween_desc_6", petName, addPetCfgs[2].des))
				end, self)
			end
		end
	else
		self._addElvesItemList[2].showTxt.text = ""
	end

	for i = 1, #self._commBtnItemList do
		self._commBtnItemList[i].tagGo:SetActive(i == cfg.id)
	end

	self:_onClickCommBtn(cfg.id, true)
end

function HalloweenBossView:_updataRewardDailyPrize()
	self._bossInfo = HalloweenGuestModel.instance:getHalloweenBossInfo()

	local isShow = HalloweenGuestModel.instance:getDailyPrizeRedpoint()

	self._rewardRedGo:SetActive(isShow)
end

function HalloweenBossView:_updataDamagePrizeRed()
	local isShow = HalloweenGuestModel.instance:getDamagePrizeRedpoint(self._actCfg.damagePrizePlanId)

	self._damageRedGo:SetActive(isShow)
end

function HalloweenBossView:_onClickCommBtn(index, isForce)
	if (self._commBtnItemList[index] and self._commBtnItemList[index].selectGo.activeSelf or nil) and true and not isForce then
		return
	end

	for i = 1, #self._commBtnItemList do
		self._commBtnItemList[i].selectGo:SetActive(i == index)
	end

	local openInfo = HalloweenGuestModel.instance:getBossOpenInfo()
	local cfg = HalloweenGuestConfig.instance:getBossTeamCfg(openInfo.planId, index)

	self._curViewDatas = cfg and HalloweenGuestConfig.instance:getBossBuffCfg(cfg.buffPlanId) or {}

	self._tableview:ReloadData()
end

function HalloweenBossView:_getPath()
	return {
		cellPath = "commElvesGo/commItem",
		viewPath = "commElvesGo/commItemSR"
	}
end

function HalloweenBossView:_cellSize()
	return 80, 80
end

function HalloweenBossView:_updateCell(view, cell, data)
	MaterialMgr.resetAll(cell)
	MaterialMgr.setCell(MatType.Pet, data.raceId, cell)
end

return HalloweenBossView
