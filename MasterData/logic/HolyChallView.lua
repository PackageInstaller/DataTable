-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/HolyChallView.lua

module("logic.extensions.kingway.view.HolyChallView", package.seeall)

local HolyChallView = class("HolyChallView", TableViewComponent)
local baoEffPaths = {
	{
		"fx_ui_shengguangfeilong_kai/fx_shengguangfeilong_lv.prefab",
		-118,
		-126,
		1
	},
	{
		"fx_ui_shengguangfeilong_kai/fx_shengguangfeilong_hong.prefab",
		-173,
		-55,
		1
	},
	{
		"fx_ui_shengguangfeilong_kai/fx_shengguangfeilong_lan.prefab",
		-103,
		35,
		0.5
	},
	{
		"fx_ui_shengguangfeilong_kai/fx_shengguangfeilong_huang.prefab",
		90,
		40,
		0.7
	},
	{
		"fx_ui_shengguangfeilong_kai/fx_shengguangfeilong_tu.prefab",
		164,
		-60,
		1
	},
	{
		"fx_ui_shengguangfeilong_kai/fx_shengguangfeilong_zi.prefab",
		107,
		-132,
		1
	}
}
local jiechufengyinEff = {
	"fx_ui_shengguangfeilong_kai/fx_shengguangfeilong_jiechufengying.prefab",
	0,
	-33,
	1.5
}
local posArr = {
	{
		-543,
		-151,
		-74,
		23,
		8,
		-53,
		0.4
	},
	{
		-448,
		61,
		-76,
		14,
		10,
		-28,
		0.3
	},
	{
		-274,
		111,
		-55,
		2,
		12,
		-62,
		0.3
	},
	{
		257,
		106,
		75,
		6,
		-23,
		-46,
		-0.7
	},
	{
		456,
		42,
		84,
		30,
		0,
		-36,
		-0.3
	},
	{
		542,
		-147,
		75,
		23,
		-15,
		-47,
		-0.4
	}
}

function HolyChallView:ctor()
	HolyChallView.super.ctor(self)

	self.allPetItemList = nil
	self.petModelList = nil
	self.isGetFeilong = false
	self.currClickIndex = nil
end

function HolyChallView:bindEvents()
	HolyChallView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(self.close, self)
	self.viewTipBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "holychall")
	end, self)
	self.rankBtn:AddClickListener(function()
		local stage = self.isGetFeilong and 4 or self.viewStage

		UIStateManager.instance:push(ViewName.HolyChallRank, stage)
	end, self)
	self.dailyBtn:AddClickListener(function()
		if self.viewStage >= 3 then
			FloatWordMgr.instance:show("能量已经收集完成！")

			return
		end

		if self.baseInfo.isDailyEnergy then
			FloatWordMgr.instance:show("今日已领取！")

			return
		end

		HolyChallController.instance:CSRequestGainDailyEnergyReq()
	end, self)
	self.dragonBtn:AddClickListener(function()
		if self.trialCfg == nil then
			FloatWordMgr.instance:show("今日没有挑战次数了！")

			return
		end

		self:EnterMission(self.trialCfg.challengeId, self.trialCfg.stageId, true)
	end, self)
	self.rateBgBtn:AddClickListener(function()
		if self.viewStage <= 2 then
			FloatWordMgr.instance:show("能量未收集满，不可领取！")

			return
		end

		if self.isGetFeilong then
			FloatWordMgr.instance:show("已领取过圣光飞龙！")

			return
		end

		self.isGetFeilong = true

		if self._fingerEff then
			UIEffectManager.instance:stopEffect(self._fingerEff)

			self._fingerEff = nil
		end

		GameUtil.SetActive(self._finger, false)
		HolyChallController.instance:CSRequestGainFinalPrizeReq()
	end, self)
	self.skillBtn:AddClickListener(function()
		if self.isGetFeilong then
			FloatWordMgr.instance:show("圣光飞龙挑战已结束！")

			return
		end

		UIJumper.instance:pushOneStack(self._viewPresentor.viewName, true)
		PetbookController.instance:previewBattle(10027)
	end, self)
	self.explainBtn:AddClickListener(function()
		if self.isGetFeilong then
			FloatWordMgr.instance:show("圣光飞龙挑战已结束！")

			return
		end

		UIJumper.instance:pushOneStack(self._viewPresentor.viewName, true)
		PetbookController.instance:openPetinfoView(10027)
	end, self)
	self.commentBtn:AddClickListener(function()
		GotoMgr.gotoByString("func#149#10027")
	end, self)
	self.playBtn:AddClickListener(function()
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, 5010007)
	end, self)
end

function HolyChallView:unbindEvents()
	HolyChallView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()
	self.viewTipBtn:RemoveClickListener()
	self.rankBtn:RemoveClickListener()
	self.dailyBtn:RemoveClickListener()
	self.dragonBtn:RemoveClickListener()
	self.rateBgBtn:RemoveClickListener()
	self.skillBtn:RemoveClickListener()
	self.explainBtn:RemoveClickListener()
	self.commentBtn:RemoveClickListener()
	self.playBtn:RemoveClickListener()

	for _, item in pairs(self.allPetItemList or {}) do
		GameUtil.asBtn(item.itemGo):RemoveClickListener()
	end
end

function HolyChallView:onExit()
	HolyChallView.super.onExit(self)
	GlobalDispatcher:removeListener("UpdataFeilongInfo", self.UpdataAllViewShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self.OnEndStory, self)

	for k, obj in pairs(self.petModelList or {}) do
		if checknumber(k) > 0 and obj and obj.loader and obj.asset then
			RoleObjectPool.instance:removeRole(obj)
		end
	end

	self.petModelList = nil

	removetimer(self.DelayShowRoleModel, self)

	if self.playingList then
		for i, eff in ipairs(self.playingList) do
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self.playingList = nil

	if self._fingerEff then
		UIEffectManager.instance:stopEffect(self._fingerEff)

		self._fingerEff = nil
	end

	if self.animPlay then
		self.animPlay:Stop()

		self.animPlay = nil
	end
end

function HolyChallView:destroyUI()
	HolyChallView.super.destroyUI(self)

	for _, item in pairs(self.allPetItemList or {}) do
		if item then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.allPetItemList = nil
end

function HolyChallView:buildUI()
	HolyChallView.super.buildUI(self)

	self.dragonRawGo = self:getGo("dragonRawGo")
	self.viewCloseBtn = self:getBtn("viewCloseBtn")
	self.rateBgBtn = self:getBtn("rateBgBtn")
	self.rateBgBtnGo = self:getGo("rateBgBtn")
	self._finger = self:getGo("rateBgBtn/finger")
	self.rateIma = self:getGo("rateBgBtn/rateIma"):GetComponent("Image")
	self.rateTxt = self:getGo("rateTxt"):GetComponent("Text")
	self.kaiqiImaImg = self:getGo("kaiqiGo/kaiqiIma"):GetComponent("Image")
	self.kaiqiIma = self:getGo("kaiqiGo/kaiqiIma"):GetComponent("UIImageSpriteChange")
	self.viewTipBtn = self:getBtn("viewTipBtn")
	self.playBtn = self:getBtn("playBtn")
	self.rankBtn = self:getBtn("rankBtn")
	self.dailyBtn = self:getBtn("dailyBtn")
	self.dailyRedGo = self:getGo("dailyBtn/dailyRedGo")
	self.dailyTxt = self:getGo("dailyBtn/dailyTxt"):GetComponent("Text")
	self.lingquGo = self:getGo("dailyBtn/lingquGo")
	self.skillBtn = self:getBtn("skillBtn")
	self.explainBtn = self:getBtn("explainBtn")
	self.commentBtn = self:getBtn("commentBtn")
	self.petParentTran = self:getGo("petParentTran").transform
	self.petItemGo = self:getGo("petItemGo")
	self.ring = self:getGo("ring")
	self.bgring = self:getGo("bgring")
	self.baoList = {}

	for i = 1, 6 do
		self.baoList[i] = self:getGo("ring/bao" .. i)
	end

	self.ysBagGo = self:getGo("ysBagGo")
	self.ycHitTxt = goutil.findChildTextComponent(self.ysBagGo, "ycHitTxt")
	self.dragonBtn = self:getBtn("ysBagGo/dragonBtn")
	self.dragonRedGo = self:getGo("ysBagGo/dragonBtn/dragonRedGo")
	self.dragonCountTxt = goutil.findChildTextComponent(self.ysBagGo, "dragonBtn/dragonCountTxt")

	self.dragonRawGo:SetActive(false)

	self.rateIma.fillAmount = 0
	self.rateTxt.text = ""

	self.petItemGo:SetActive(false)
	self.dailyRedGo:SetActive(false)

	self.dailyTxt.text = ""

	self.lingquGo:SetActive(false)
	self.dragonRedGo:SetActive(false)

	self.dragonCountTxt.text = ""
	self.ycHitTxt.text = ""

	self.ysBagGo:SetActive(false)
	GameUtil.SetActive(self._finger, false)
end

function HolyChallView:onEnter()
	HolyChallView.super.onEnter(self)
	GlobalDispatcher:addListener("UpdataFeilongInfo", self.UpdataAllViewShow, self)
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self.OnEndStory, self)
	HolyChallController.instance:CSRequestGetInfoReq()

	self.isGetFeilong = false

	self:UpdataAllViewShow()
end

function HolyChallView:playBao(chillId)
	local arr = baoEffPaths[chillId]

	if arr then
		GameUtil.doCallbackWhenFirst("HolyChallView_b" .. chillId, GameUtil.handler(self.playEffect, self, arr))
	end
end

function HolyChallView:addClickEff()
	GameUtil.SetActive(self._finger, true)

	local light = UIEffectManager.instance:playEffect(self, "common/fx_ui_zhiyin_quan_03.prefab", self._finger, 0, 0, true, nil, function()
		return
	end, function(ta, eff)
		return
	end)

	light:setParent(self.mainGO.transform)
	light:setScale(1)

	self._fingerEff = light
end

function HolyChallView:playEffect(arr, callBack)
	local path = arr[1]
	local x = arr[2]
	local y = arr[3]
	local scale = arr[4]
	local eff = UIEffectManager.instance:playEffect(self, path, self.mainGO, x, y, false, false, function()
		GameUtil.callBack(callBack)
	end)

	eff:setParent(self.mainGO.transform)
	eff:setLocalPos(x, y, 0)
	eff:setScale(scale)

	self.playingList = self.playingList or {}

	table.insert(self.playingList, eff)
end

function HolyChallView:UpdataAllViewShow()
	if self.animPlay then
		self.animPlay:Stop()

		self.animPlay = nil
	end

	self.baseInfo = HolyChallModel.instance:GetFeilongData()

	if not self.baseInfo.isInit then
		return
	end

	GameUtil.SetActive(self.ring, false)
	GameUtil.SetActive(self.bgring, false)
	HolyChallController.instance:showRingBaoGo(self.baseInfo, self.ring, self.baoList, GameUtil.handler(self.playBao, self))

	self.viewStage = HolyChallModel.instance:GetCurrentFunctionStage()

	if self.viewStage <= 1 then
		if not self.baseInfo.isOpenFunc then
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, 5010007)
			HolyChallController.instance:CSRequestFirstOpenFuncReq()
			HolyChallModel.instance:UpdataPlayOpenFunc(1)
		end

		GameUtil.SetActive(self.bgring, true)
		GameUtil.SetActive(self.rateBgBtnGo, true)

		if self.dragonRawGo.activeSelf then
			self.dragonRawGo:SetActive(false)
		end

		self.allPetItemList = self.allPetItemList or {}
		self.ycHitTxt.text = ""

		self.ysBagGo:SetActive(false)
		self.dragonBtn.gameObject:SetActive(false)
		self.kaiqiIma:SetState(0)
		self.kaiqiImaImg:SetNativeSize()
		self:UpdataPetItemData()
		self:DailyCollectionStatus()
	elseif self.viewStage == 2 then
		for k, obj in pairs(self.petModelList or {}) do
			if checknumber(k) > 0 and obj and obj.loader and obj.asset then
				RoleObjectPool.instance:removeRole(obj)

				self.petModelList[k] = nil
			end
		end

		GameUtil.SetActive(self.rateBgBtnGo, false)
		GameUtil.SetActive(self.dragonRawGo, false)

		if self.baseInfo.isPlayTwo then
			HolyChallModel.instance:UpdataPlayOpenFunc(2)
			self:playEffect(jiechufengyinEff, function()
				GameUtil.SetActive(self.rateBgBtnGo, true)
				GameUtil.SetActive(self.dragonRawGo, true)
			end)
		else
			GameUtil.SetActive(self.rateBgBtnGo, true)
			GameUtil.SetActive(self.dragonRawGo, true)
		end

		self:DestroyAllPetItem()
		self.kaiqiIma:SetState(1)
		self.kaiqiImaImg:SetNativeSize()
		self:UpdataChallFeilongInfo()
		self:DailyCollectionStatus()
		self:CumulativeDamageList()
	else
		for k, obj in pairs((not self.petModelList or nil) and {}) do
			if checknumber(k) > 0 and obj and obj.loader and obj.asset then
				RoleObjectPool.instance:removeRole(obj)

				self.petModelList[k] = nil
			end
		end

		GameUtil.SetActive(self.rateBgBtnGo, true)
		GameUtil.SetActive(self.dragonRawGo, true)
		self:DestroyAllPetItem()

		self.allPetItemList = nil
		self.ycHitTxt.text = ""

		self.ysBagGo:SetActive(false)
		self.dailyBtn.gameObject:SetActive(false)
		self.dragonBtn.gameObject:SetActive(false)
		self.kaiqiIma:SetState(2)
		self.kaiqiImaImg:SetNativeSize()
		self:addClickEff()
	end

	local have = checknumber(self.baseInfo.totalEnergy)

	self.rateIma.fillAmount = have / self.baseInfo.allEnergy
	self.rateTxt.text = have .. "/" .. self.baseInfo.allEnergy
end

function HolyChallView:UpdataPetItemData()
	local myPower = RoleModel.instance:getMaxPower() or 0
	local infoList = self.baseInfo.challList

	for i = 1, 6 do
		self.allPetItemList[i] = self.allPetItemList[i] or {}

		if self.allPetItemList[i].itemGo == nil then
			local go = goutil.cloneAndSetParent(self.petItemGo, self.petParentTran)

			go:SetActive(true)

			self.allPetItemList[i].itemGo = go
			self.allPetItemList[i].roleModel = goutil.findChild(go, "roleModel")
			self.allPetItemList[i].petNameGo = goutil.findChild(go, "petNameGo")
			self.allPetItemList[i].petNameTxt = goutil.findChildTextComponent(go, "petNameGo/petNameTxt")
			self.allPetItemList[i].petRedGo = goutil.findChild(go, "petNameGo/petRedGo")
			self.allPetItemList[i].winIconGo = goutil.findChild(go, "winIconGo")
			self.allPetItemList[i].petPowerTxt = goutil.findChild(go, "petPowerGo/powerTxt"):GetComponent(ComponentType.UIImgNumeralText)
		end

		local guardCfg = HolyChallConfig.instance:GetChallGuardCfg(i)
		local arr = posArr[i]

		uGuiUtil.setLocalPosition(self.allPetItemList[i].itemGo, Vector3.New(checknumber(arr[1]), checknumber(arr[2]), 0))
		uGuiUtil.setLocalPosition(self.allPetItemList[i].petNameGo, Vector3.New(checknumber(arr[3]), checknumber(arr[4]), 0))
		uGuiUtil.setLocalPosition(self.allPetItemList[i].roleModel, Vector3.New(arr[5] or 0, arr[6] or 0, 0))
		uGuiUtil.setLocalScale(self.allPetItemList[i].roleModel, Vector3.New(arr[7] or 1, math.abs(arr[7]) or 1, 1))

		local stageCfg = HolyChallConfig.instance:GetChallStageCfg(i, 1)

		if stageCfg then
			self.allPetItemList[i].petNameTxt.text = stageCfg.name or "守卫"
		end

		self.allPetItemList[i].petPowerTxt:SetNum(guardCfg.recommendZdl)

		local isOpen = not (infoList[i] and infoList[i].passedStageId <= 0 and not infoList[i].everOpen)
		local isPass = not not (infoList[i] and infoList[i].passedStageId >= 1)

		self.allPetItemList[i].winIconGo:SetActive(isPass)
		self.allPetItemList[i].petRedGo:SetActive(not isOpen)

		local num = i

		GameUtil.asBtn(self.allPetItemList[num].itemGo):AddClickListener(function()
			if isPass then
				FloatWordMgr.instance:show("该挑战已成功通关！")

				return
			end

			if not isOpen then
				self.currClickIndex = num

				GlobalDispatcher:dispatch(GlobalNotify.PushStory, guardCfg.storyId, true)
				HolyChallController.instance:CSRequestFirstOpenGuardReq(num)
				HolyChallModel.instance:UpdataFirstOpenGuard(num)

				return
			end

			self:EnterMission(num, 1, false)
		end)
	end

	self.petModelList = self.petModelList or {}
	self.modelIndex = 1

	settimer(0.1, self.DelayShowRoleModel, self, true)
end

function HolyChallView:DelayShowRoleModel()
	local guardCfg = HolyChallConfig.instance:GetChallGuardCfg(self.modelIndex)

	if guardCfg and guardCfg.petId then
		self.petModelList[self.modelIndex] = self:ShowRoleModel(guardCfg.petId, self.modelIndex, self.allPetItemList[self.modelIndex].roleModel, 1)
	end

	if self.modelIndex >= 6 then
		removetimer(self.DelayShowRoleModel, self)
	end

	self.modelIndex = self.modelIndex + 1
end

function HolyChallView:ShowRoleModel(petId, index, modelGo, flipx)
	flipx = flipx or 1

	if checknumber(petId) <= 0 or checknumber(index) <= 0 or modelGo == nil then
		return
	end

	local petCfg = CharacterConfig.instance:getPetCo(petId)

	if petCfg == nil then
		printError("sr_圣光飞龙     HolyChallView:ShowRoleModel()    精灵配置为空 = ", index)

		return
	end

	local loader

	if self.petModelList and self.petModelList[index] then
		loader = self.petModelList[index]
	end

	local offset = CharactorFacade.instance:getLegendModelUIPosAndScale(petId)
	local x, y, scale = 0, 0, 1
	local scaleY

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scaleY = offset[3] or 1
	end

	scale = {
		scaleY * flipx,
		scaleY * math.abs(flipx),
		scaleY * math.abs(flipx)
	}
	loader = loader and RoleObjectPool.instance:removeRole(loader)
	loader = RoleObjectPool.instance:addRoleToParent(loader, petCfg.faceIds, modelGo, scale, nil, nil, x, y)

	return loader
end

function HolyChallView:UpdataChallFeilongInfo()
	self.dragonBtn.gameObject:SetActive(true)

	local openDays = GameUtil.getOpenAreaDaysForFive()
	local feilongCfgs = HolyChallConfig.instance:GetChallTrialCfg(openDays - 1)
	local use = 0

	for id, boo in pairs(self.baseInfo.trialBits or {}) do
		if checknumber(id) > 0 and boo then
			use = use + 1
		end
	end

	local have = #feilongCfgs

	self.dragonRedGo:SetActive(use < have)

	self.dragonCountTxt.text = string.format("今日剩余：%s/%s", have - use, have)
	self.trialCfg = nil
	self.challNum = nil

	if use < have and feilongCfgs[use + 1] then
		self.trialCfg = HolyChallConfig.instance:GetChallStageCfg(feilongCfgs[use + 1].challengeId, 1)
		self.challNum = use + 1
	end
end

function HolyChallView:DailyCollectionStatus()
	self.dailyBtn.gameObject:SetActive(true)
	self.dailyRedGo:SetActive(not self.baseInfo.isDailyEnergy)

	local commCfgs = HolyChallConfig.instance:GetCommonCfgs()

	self.dailyTxt.text = string.format("每日可领\n%s能量", commCfgs.dailyEnergy)

	self.lingquGo:SetActive(self.baseInfo.isDailyEnergy)
end

function HolyChallView:CumulativeDamageList()
	self.ysBagGo:SetActive(true)

	local value = tostring(self.baseInfo.accDamage)

	self.ycHitTxt.text = string.format("今日累计伤害\n%s", (self.baseInfo.accDamage > 9999 or nil) and string.format("%.1f", math.floor(self.baseInfo.accDamage / 1000) / 10) .. "万")
	self._curViewDatas = HolyChallConfig.instance:GetChallDamageCfgs()

	self._tableview:ReloadData()
end

function HolyChallView:DestroyAllPetItem()
	if self.petModelList then
		for k, obj in pairs(self.petModelList) do
			if checknumber(k) > 0 and obj and obj.loader and obj.asset then
				RoleObjectPool.instance:removeRole(obj)
			end
		end

		self.petModelList = nil
	end

	if self.allPetItemList then
		for _, item in pairs(self.allPetItemList) do
			if item then
				UnityEngine.GameObject.Destroy(item.itemGo)
			end
		end

		self.allPetItemList = nil
	end
end

function HolyChallView:_getPath()
	return {
		cellPath = "ysBagGo/ycItem",
		viewPath = "ysBagGo/ycShowSR"
	}
end

function HolyChallView:_cellSize()
	return 220, 36
end

function HolyChallView:_updateCell(view, cell, data)
	local itemBgIma = goutil.findChild(cell, "itemBgIma"):GetComponent("UIImageColorChange")
	local hitTxt = goutil.findChildTextComponent(cell, "hitTxt")
	local energyTxt = goutil.findChildTextComponent(cell, "energyTxt")
	local chooseGo = goutil.findChild(cell, "chooseGo")
	local num = cell.data - math.floor(cell.data / 2) * 2

	itemBgIma:SetState(num)

	local value = tostring(data.accDamage)

	if data.accDamage >= 1000 then
		local str = string.format("%.1f", data.accDamage / 10000)

		value = str .. "万"
	end

	hitTxt.text = value
	energyTxt.text = tostring(data.prize)

	chooseGo:SetActive(self.baseInfo.accDamage >= data.accDamage)
end

function HolyChallView:OnEndStory(storyId)
	if storyId == 5010007 then
		self:playEffect({
			"fx_ui_shengguangfeilong_kai/fx_shengguangfeilong_jian.prefab",
			0,
			0,
			1
		})

		return
	end

	if self.currClickIndex ~= nil and self.currClickIndex > 0 then
		self:EnterMission(self.currClickIndex, 1, false)
	end
end

function HolyChallView:EnterMission(challengeId, stageId, isTrial)
	self.currClickIndex = nil

	local obj = {}

	obj.challengeId = challengeId
	obj.stageId = stageId
	obj.isTrial = isTrial

	if isTrial and checknumber(self.challNum) > 0 then
		obj.challNum = self.challNum
	end

	if not obj.isTrial then
		obj.supportPetId = HolyChallConfig.instance:GetChallGuardCfg(challengeId).supportPetId

		HolyChallModel.instance:setCreepsId(obj.supportPetId)
	else
		HolyChallModel.instance:setCreepsId(nil)
	end

	HolyChallModel.instance:setCurChallengeId(challengeId)

	if isTrial then
		UIStateManager.instance:push(ViewName.HCDragonMission, obj)
	else
		UIStateManager.instance:push(ViewName.HCGuardMission, obj)
	end
end

return HolyChallView
