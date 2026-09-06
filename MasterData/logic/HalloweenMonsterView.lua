-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/view/HalloweenMonsterView.lua

module("logic.extensions.halloweenguest.view.HalloweenMonsterView", package.seeall)

local HalloweenMonsterView = class("HalloweenMonsterView", ViewComponent)
local TOTAL_COUNT = 7

function HalloweenMonsterView:ctor()
	HalloweenMonsterView.super.ctor(self)

	self._mapsItemList = nil
	self._killItemList = nil
	self._isActivityEnd = nil
end

function HalloweenMonsterView:bindEvents()
	HalloweenMonsterView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipTxtBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "halloweenmonster")
	end, self)
	self._tipImaBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.HalloweenMonsterRule)
	end, self)
	self._scenesBtn:AddClickListener(function()
		if self._isActivityEnd then
			FloatWordMgr.instance:show(lang("text_activity_end"))

			return
		end

		UIStateManager.instance:push(ViewName.HalloweenMonsterTask)
	end, self)
end

function HalloweenMonsterView:unbindEvents()
	HalloweenMonsterView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipTxtBtn:RemoveClickListener()
	self._tipImaBtn:RemoveClickListener()
	self._scenesBtn:RemoveClickListener()
end

function HalloweenMonsterView:onExit()
	HalloweenMonsterView.super.onExit(self)
	removetimer(self._calculationSurplusTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.HalloweenMonsterInfo, self._updataMonsterView, self)
	GlobalDispatcher:removeListener(GlobalNotify.HalloweenMonsterPrize, self._updataViewInfo, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil

	if self._bossEff then
		UIEffectManager.instance:stopEffect(self._bossEff)
	end

	self._bossEff = nil

	for _, item in pairs(self._killItemList or {}) do
		if item and item.itemEff then
			UIEffectManager.instance:stopEffect(item.itemEff)

			item.itemEff = nil
		end
	end

	self._isActivityEnd = nil

	self._tableview:dispose()
end

function HalloweenMonsterView:destroyUI()
	HalloweenMonsterView.super.destroyUI(self)

	for _, item in pairs(self._mapsItemList or {}) do
		if item and item.iconIma then
			local bigBg = item.iconIma:GetComponent("ImageBigBG")

			if bigBg then
				bigBg:ClearImage()
			end
		end
	end

	self._mapsItemList = nil
	self._killItemList = nil

	if self._photoEff1 then
		self._photoEff1:clear()
	end

	if self._photoEff2 then
		self._photoEff2:clear()
	end
end

function HalloweenMonsterView:buildUI()
	HalloweenMonsterView.super.buildUI(self)

	local spriteRaw1 = self:getGo("spriteRaw1")

	self._photoEff1 = PhotoEffect.Get(spriteRaw1)
	self._roleImg1 = spriteRaw1:GetComponent("RawImage")
	self._roleImg1.material = nil

	local spriteRaw2 = self:getGo("spriteRaw2")

	self._photoEff2 = PhotoEffect.Get(spriteRaw2)
	self._roleImg2 = spriteRaw2:GetComponent("RawImage")
	self._roleImg2.material = nil
	self._closeBtn = self:getBtn("closeBtn")
	self._tipTxtBtn = self:getBtn("tipTxtBtn")
	self._tipImaBtn = self:getBtn("tipImaBtn")
	self._scenesBtn = self:getBtn("scenesBtn")
	self._mapCountTxt = goutil.findChildTextComponent(self.mainGO, "scenesBtn/mapCountTxt")
	self._mapFinishGo = self:getGo("scenesBtn/mapFinishGo")

	local allMapsGo = self:getGo("scenesBtn/allMapsGo")

	self._mapsItemList = {}

	for i = 1, 3 do
		local subGo = goutil.findChild(allMapsGo, "mapGo_" .. i)

		if subGo then
			self._mapsItemList[i] = {
				itemGo = subGo,
				iconIma = goutil.findChild(subGo, "mapIma"),
				nameTxt = goutil.findChildTextComponent(subGo, "mapTxt"),
				mapRedGo = goutil.findChild(subGo, "mapRedGo")
			}
		end
	end

	self._timeTxt = goutil.findChildTextComponent(self.mainGO, "timeGo/timeTxt")

	local allKillsGo = self:getGo("allKillsGo")

	self._killItemList = {}

	for i = 1, TOTAL_COUNT do
		local subGo = goutil.findChild(allKillsGo, "killItem_" .. i)

		if subGo then
			table.insert(self._killItemList, {
				itemGo = subGo,
				goodsPos = goutil.findChild(subGo, "goodsPos"),
				finishGo = goutil.findChild(subGo, "finishGo"),
				btnGo = goutil.findChild(subGo, "btnGo"),
				countTxt = goutil.findChildTextComponent(subGo, "countTxt")
			})
		end
	end

	self._killCountTxt = self:getTxt("progressReward/killCountTxt")
	self._progSli = goutil.findChild(allKillsGo, "progSli"):GetComponent("Slider")
	self._progSliAd = self:getSlider("allKillsGo/progSli")
	self._mapCountTxt.text = ""

	self._mapFinishGo:SetActive(false)

	self._timeTxt.text = ""
	self._killCountTxt.text = ""
	self._progSli.value = 0
	self._tableviewGo = self:getGo("progressReward/tableview")
	self._rewardCell = self:getGo("progressReward/rewardCell")
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._tableview = ScrollerList.create(self._tableviewGo, self._rewardCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function HalloweenMonsterView:onEnter()
	HalloweenMonsterView.super.onEnter(self)
	HalloweenGuestConfig.instance:getOpenMonsterActivityId()
	GlobalDispatcher:addListener(GlobalNotify.HalloweenMonsterInfo, self._updataMonsterView, self)
	GlobalDispatcher:addListener(GlobalNotify.HalloweenMonsterPrize, self._updataViewInfo, self)

	self._isActivityEnd = false
	self._bossEff = nil

	if self._photoEff1 then
		self._photoEff1:clear()
	end

	if self._photoEff2 then
		self._photoEff2:clear()
	end

	self:_updataMonsterView()

	local effPath = "20211028/wanshenjie_xuanshang/fx_ui_wanshengjie_xuanshang.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)

	local value = GameUtil.getUserData("HalloweenMonsterRuleView")

	if checknumber(value) ~= 1 then
		GameUtil.saveUserData("HalloweenMonsterRuleView", 1)
		UIStateManager.instance:push(ViewName.HalloweenMonsterRule)
	end
end

function HalloweenMonsterView:_showViewSpriteRaw()
	self._photoEff1:setEffectLoadedCallback(function(go)
		GoUtil.PlaySpineAnim(go, "idle", true, true)
		Framework.TransformUtil.SetLocalScale(go.transform, -0.5, 0.5, 0.5)
		Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
	end)

	local resCfg = CharacterConfig.instance:getModelCo(checknumber(self._actCfg.modelId))

	if resCfg then
		self._photoEff1:showEffectsFullScreen({
			GameUrl.getSpineUrl(resCfg.resName)
		})
		self._photoEff1:setCameraPosition(-1, 2.9, -1)

		local camera = self._photoEff1._photo.producer.rtCamera

		camera.orthographic = true

		Game.ImageUtil.SetRawImageAlpha(self._roleImg1, 1)
	end

	GameUtil.SetActive(self._roleImg2, false)
end

function HalloweenMonsterView:_updataMonsterView()
	removetimer(self._calculationSurplusTime, self)

	self._monsterInfo = HalloweenGuestModel.instance:getHalloweenMonsterInfo()

	local openCfg = ActivityDefineConfig.instance:getCfgById(HalloweenGuestModel.instance.monsterActType, HalloweenGuestModel.instance.monsterActId)

	self._endTime = 0

	if openCfg and not string.nilorempty(openCfg.endTime) then
		self._endTime = GameUtil.string2time(openCfg.endTime)
	end

	if self._endTime <= 0 or self._endTime <= ServerTime.now() then
		self._timeTxt.text = lang("text_activity_end")
		self._isActivityEnd = true
	else
		self:_calculationSurplusTime()
		settimer(1, self._calculationSurplusTime, self, true)
	end

	self._actCfg = HalloweenGuestConfig.instance:getActMonsterCfg(HalloweenGuestModel.instance.monsterActId)

	local sceneInfos = self._monsterInfo.sceneInfos

	if sceneInfos == nil or #sceneInfos ~= self._actCfg.dailyRefreshSceneNum then
		printError("sr---捣蛋鬼  HalloweenMonsterView:_updataMonsterView()   场景数量下发错误！！")
	end

	local cfg

	for i = 1, #self._mapsItemList do
		if sceneInfos[i] and checknumber(sceneInfos[i].sceneConfigId) > 0 then
			if self._mapsItemList[i].itemGo and not self._mapsItemList[i].itemGo.activeSelf then
				GameUtil.SetActive(self._mapsItemList[i].itemGo, true)
			end

			cfg = HalloweenGuestConfig.instance:getHalloweenSceneCfg(self._actCfg.scenePlanId, sceneInfos[i].sceneConfigId)

			if cfg then
				self._mapsItemList[i].nameTxt.text = cfg.sceneName or "场景"
			end

			local isShow = HalloweenGuestModel.instance:getSceneNpcRedpoint(cfg.id, self._actCfg.sceneRefreshPositionNum)

			self._mapsItemList[i].mapRedGo:SetActive(isShow)

			cfg = SceneConfig.instance:getSceneCo((cfg or nil) and (cfg.sceneId or 1001))

			if cfg then
				if not cfg.showImage then
					local iconName = "aoqicheng"

					uGuiUtil.setSpriteToImage(self._mapsItemList[i].iconIma, uGuiUtil.SpriteType.BigBg, GameUrl.getSceneIconUrl(iconName))
				end
			end
		elseif self._mapsItemList[i].itemGo and self._mapsItemList[i].itemGo.activeSelf then
			GameUtil.SetActive(self._mapsItemList[i].itemGo, false)
		end
	end

	self:_updataViewInfo()
	self:_showViewSpriteRaw()
end

function HalloweenMonsterView:_calculationSurplusTime()
	local supTime = self._endTime - ServerTime.now()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timeTxt.text = lang("text_activity_end")
		self._isActivityEnd = true

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timeTxt.text = day > 0 and langPara("text_suo_timer_1", day, hour, min) or langPara("text_suo_timer_2", hour, min, sec)
end

function HalloweenMonsterView:_updataViewInfo()
	self._monsterInfo = HalloweenGuestModel.instance:getHalloweenMonsterInfo()

	local allCount = self._actCfg.dailyRefreshSceneNum * self._actCfg.sceneRefreshPositionNum

	self._mapCountTxt.text = string.format("今日已驱赶捣蛋鬼：<color=#20b376>%s</color>/%s次", self._monsterInfo.dailyChallengedNum, allCount)

	if allCount <= self._monsterInfo.dailyChallengedNum then
		self._mapFinishGo:SetActive(true)
	else
		self._mapFinishGo:SetActive(false)
	end

	self._killCountTxt.text = langPara("text_halloween_desc_10", self._monsterInfo.totalChallengedNum)

	local cfgs = HalloweenGuestConfig.instance:getHalloweenPrizesCfg(self._actCfg.prizePlanId)

	self._prizeGainedBitIdList = self._monsterInfo.gainedPrizeIds or {}

	local scoreArr = {}
	local idx = -1

	for k, v in ipairs(cfgs) do
		table.insert(scoreArr, v.num)

		local isCanGet = self._monsterInfo.totalChallengedNum >= v.num
		local isGainPrize = table.indexof(self._prizeGainedBitIdList, v.id) ~= false

		if isCanGet and not isGainPrize and idx == -1 then
			idx = k - 1
		end
	end

	self._tableview:reloadData(cfgs)
	self._tableview:updateUnderSlider(self._progressBar, self._monsterInfo.totalChallengedNum, scoreArr)
	self._tableview:MoveCellToCenter(idx == -1 and 0 or idx)
end

function HalloweenMonsterView:_updataViewRedpoint()
	local isShow = HalloweenGuestModel.instance:getHalloweenRedpoint(true)

	self._bossRedGo:SetActive(isShow)

	if isShow then
		if self._bossEff == nil then
			local effPath = "20211028/wanshenjie_xuanshang/fx_ui_wanshengjie_xianshiboss.prefab"

			self._bossEff = UIEffectManager.instance:playEffect(self, effPath, self._bossBtn.gameObject, 0, 0, true, nil, nil, nil, self)

			self._bossEff:setParent(self._bossBtn.gameObject.transform)
			self._bossEff:setLocalPos(0, -12, 0)
			self._bossEff:setScale(1)
		end
	else
		if self._bossEff then
			UIEffectManager.instance:stopEffect(self._bossEff)
		end

		self._bossEff = nil
	end
end

function HalloweenMonsterView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.num

	local isCanGet = self._monsterInfo.totalChallengedNum >= data.num
	local isGainPrize = table.indexof(self._prizeGainedBitIdList, data.id) ~= false

	GameUtil.SetActive(canGet, isCanGet)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data.id), self)
end

function HalloweenMonsterView:_onClickGetPrize(id)
	HalloweenGuestController.instance:csGetHalloweenSceneMonsterGainPrizeReq(id)
end

function HalloweenMonsterView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function HalloweenMonsterView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progressReward/tableview/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function HalloweenMonsterView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

return HalloweenMonsterView
