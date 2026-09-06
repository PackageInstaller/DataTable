-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyWarMainView.lua

module("logic.extensions.newfamily.view.war.FamilyWarMainView", package.seeall)

local FamilyWarMainView = class("FamilyWarMainView", ViewComponent)

function FamilyWarMainView:ctor()
	FamilyWarMainView.super.ctor(self)

	self._nestItemList = nil
	self._pillarItemList = nil
	self._clickTimer = nil
	self._pillarEffList = nil
end

function FamilyWarMainView:bindEvents()
	FamilyWarMainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.FamilyWarRule)
	end, self)
	self._rankBtn:AddClickListener(function()
		if self:_onClickBtnShowTips() then
			return
		end

		UIStateManager.instance:push(ViewName.FamilyPillarRank, self._periodCfg.rankPrizePlanId)
	end, self)
	self._reportBtn:AddClickListener(function()
		if self:_onClickBtnShowTips() then
			return
		end

		UIStateManager.instance:push(ViewName.FamilyWarReport)
	end, self)
	self._formationBtn:AddClickListener(self._onClickFormationBtn, self)
	self._seasonBtn:AddClickListener(self._onClickSeasonBtn, self)
	self._signBtn:AddClickListener(function()
		if not self._isChief then
			return
		end

		if self:_onClickBtnShowTips() then
			return
		end

		UIStateManager.instance:push(ViewName.FamilyPillarSign)
	end, self)

	if self._nestItemList and #self._nestItemList > 0 then
		for i = 1, #self._nestItemList do
			if self._nestItemList[i] and self._nestItemList[i].itemGo then
				GameUtil.asBtn(self._nestItemList[i].itemGo):AddClickListener(function()
					self:_onClickNestItemBtn(i)
				end, self)
			end
		end
	end

	if self._pillarItemList and #self._pillarItemList > 0 then
		for i = 1, #self._pillarItemList do
			if self._pillarItemList[i] and self._pillarItemList[i].clickGo then
				GameUtil.asBtn(self._pillarItemList[i].clickGo):AddClickListener(function()
					self:_onClickPillarItemBtn(i)
				end, self)
			end
		end
	end
end

function FamilyWarMainView:unbindEvents()
	FamilyWarMainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._reportBtn:RemoveClickListener()
	self._formationBtn:RemoveClickListener()
	self._seasonBtn:RemoveClickListener()
	self._signBtn:RemoveClickListener()

	for _, item in pairs(self._nestItemList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end

	for _, item in pairs(self._pillarItemList or {}) do
		if item and item.clickGo then
			GameUtil.asBtn(item.clickGo):RemoveClickListener()
		end
	end
end

function FamilyWarMainView:onExit()
	FamilyWarMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataFamilyWarBaseInfo, self._updataFamilyWarMainShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataFamilyWarPillarSign, self._updataAllPillarSignShow, self)

	for _, effGo in pairs(self._pillarEffList or {}) do
		if effGo then
			UIEffectManager.instance:stopEffect(effGo)
		end
	end

	self._pillarEffList = nil
	self._viewIndex = nil
	self._clickTimer = nil
end

function FamilyWarMainView:destroyUI()
	FamilyWarMainView.super.destroyUI(self)

	for _, item in pairs(self._nestItemList or {}) do
		if item and item.iconGo then
			uGuiUtil.clearImage(item.iconGo)
		end
	end

	self._nestItemList = nil

	for _, item in pairs(self._pillarItemList or {}) do
		if item and item.itemGo then
			uGuiUtil.clearImage(item.itemGo)
		end
	end

	self._pillarItemList = nil
	self._wornStateList = nil
end

function FamilyWarMainView:buildUI()
	FamilyWarMainView.super.buildUI(self)

	self._nestItemList = {}

	local allItemsGo = self:getGo("allItemsGo")

	for i = 1, 4 do
		local itemGo = goutil.findChild(allItemsGo, "nestItem_" .. i)

		self._nestItemList[i] = {
			itemGo = itemGo,
			iconGo = goutil.findChild(itemGo, "iconGo"),
			nameTxt = goutil.findChildTextComponent(itemGo, "nameTxt"),
			countTxt = goutil.findChildTextComponent(itemGo, "countTxt")
		}
	end

	self._pillarItemList = {}

	for i = 1, 5 do
		local itemGo = goutil.findChild(allItemsGo, "pillarItem_" .. i)
		local var_12_0 = {
			itemGo = itemGo,
			nameTxt = goutil.findChildTextComponent(itemGo, "nameTxt"),
			countTxt = goutil.findChildTextComponent(itemGo, "countTxt")
		}

		var_12_0.signIma = goutil.findChild(itemGo, "signIma"):GetComponent("UIImageSpriteChange")
		var_12_0.effGo = goutil.findChild(itemGo, "effGo")
		var_12_0.clickGo = goutil.findChild(itemGo, "clickGo")
		self._pillarItemList[i] = var_12_0
	end

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._rankBtn = self:getBtn("rankBtn")
	self._reportBtn = self:getBtn("reportBtn")
	self._formationBtn = self:getBtn("formationBtn")
	self._seasonBtn = self:getBtn("seasonBtn")
	self._signBtn = self:getBtn("signBtn")
	self._pillarTxt = goutil.findChildTextComponent(self.mainGO, "pillarGo/pillarTxt")
	self._nestTxt = goutil.findChildTextComponent(self.mainGO, "nestGo/nestTxt")
end

function FamilyWarMainView:onEnter()
	FamilyWarMainView.super.onEnter(self)

	local periodId = checknumber(FamilyWarModel.instance:getFamilyWarPeriodId())

	if periodId <= 0 then
		printError("sr---家族战 FamilyWarMainView:onEnter()  家族战期数不对！")

		return
	end

	self._periodCfg = FamilyWarConfig.instance:getFamilyWarPeriodCfg(periodId)

	if self._periodCfg == nil then
		printError("sr---家族战 FamilyWarMainView:onEnter()  没找到期数配置！")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdataFamilyWarBaseInfo, self._updataFamilyWarMainShow, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataFamilyWarPillarSign, self._updataAllPillarSignShow, self)

	self._isChief = FamilyModel.instance:isFamilyChief()

	GameUtil.SetActive(self._seasonBtn, self._isChief)
	GameUtil.SetActive(self._signBtn, self._isChief)
	self:_initAllNestItemShow()
	self:_updataFamilyWarMainShow()
	FamilyWarController.instance:csRequestFamilyBattleGetInfoReq()
end

function FamilyWarMainView:_initAllNestItemShow()
	local str = FamilyWarConfig.instance:getFamilyWarCommonParam("PILLAR_WORN_STATE")

	self._wornStateList = string.nilorempty(str) and {} or string.split(str, ",")

	local cfgs = FamilyWarConfig.instance:getFamilyBattleNestCfgs(self._periodCfg.nestPlanId)

	if cfgs == nil or #cfgs ~= #self._nestItemList then
		printError("sr---家族战 FamilyWarMainView:_initAllNestItemShow()   获取的巢穴数量不对？")

		return
	end

	for i = 1, #self._nestItemList do
		if cfgs[i] and self._nestItemList[i] and self._nestItemList[i].itemGo then
			uGuiUtil.setSpriteToImage(self._nestItemList[i].iconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getTaskUrl(cfgs[i].icon))

			self._nestItemList[i].nameTxt.text = cfgs[i].name
			self._nestItemList[i].countTxt.text = "能量获取：" .. cfgs[i].energy
		end
	end
end

function FamilyWarMainView:_updataFamilyWarMainShow()
	self._pillarEffList = self._pillarEffList or {}
	self._baseInfo = FamilyWarModel.instance:getFamilyWarBaseInfo()

	local pCount = checknumber(FamilyWarConfig.instance:getFamilyWarCommonParam("DIVINE_PILLAR_ATTACK_TIMES_LIMIT"))
	local haveCount = math.max(pCount - self._baseInfo.pillarAttackTimes, 0)

	self._pillarTxt.text = "神柱次数：" .. haveCount .. "/" .. pCount

	local nCount = checknumber(FamilyWarConfig.instance:getFamilyWarCommonParam("NEST_ATTACK_TIMES_LIMIT"))

	haveCount = math.max(nCount - self._baseInfo.nestAttackTimes, 0)
	self._nestTxt.text = "巢穴次数：" .. haveCount .. "/" .. nCount

	local cfg

	for i = 1, #self._pillarItemList do
		if self._pillarItemList[i] and self._pillarItemList[i].itemGo then
			if self._baseInfo.pillarInfos and self._baseInfo.pillarInfos[i] then
				GameUtil.SetActive(self._pillarItemList[i].itemGo, true)

				self._pillarItemList[i].nameTxt.text = self._baseInfo.myFamilyId == self._baseInfo.pillarInfos[i].familyId and "我的家族" or self._baseInfo.pillarInfos[i].familyName

				local power = self._baseInfo.pillarInfos[i].totalEnergy

				self._pillarItemList[i].countTxt.text = "神柱能量：" .. power

				self:_showPillarWornState(i, power)

				if self._baseInfo.pillarInfos[i].familyId == self._baseInfo.flagFamilyId then
					GameUtil.SetActive(self._pillarItemList[i].signIma, true)
					self._pillarItemList[i].signIma:SetState(1)
				elseif self._baseInfo.pillarInfos[i].familyId == self._baseInfo.noFlagFamilyId then
					GameUtil.SetActive(self._pillarItemList[i].signIma, true)
					self._pillarItemList[i].signIma:SetState(0)
				else
					GameUtil.SetActive(self._pillarItemList[i].signIma, false)
				end

				cfg = FamilyWarConfig.instance:getFamilyPillarInfoCfgs(i)

				if cfg then
					local path = string.format("ui/bigbg/familynesttower/%s.png", cfg.smallIcon or "board_llzz_03")

					uGuiUtil.setSpriteToImage(self._pillarItemList[i].itemGo, uGuiUtil.SpriteType.BigBg, path)
				end
			else
				self._pillarItemList[i].nameTxt.text = "无"
				self._pillarItemList[i].countTxt.text = "神柱能量：0"

				GameUtil.SetActive(self._pillarItemList[i].signIma, false)
				GameUtil.SetActive(self._pillarItemList[i].itemGo, false)
			end
		end
	end
end

function FamilyWarMainView:_showPillarWornState(i, power)
	if self._pillarEffList and self._pillarEffList[i] then
		UIEffectManager.instance:stopEffect(self._pillarEffList[i])

		self._pillarEffList[i] = nil
	end

	if self._pillarItemList[i] == nil or self._pillarItemList[i].effGo == nil then
		return
	end

	local effName = ""
	local posy = 0

	if checknumber(power) <= checknumber(self._wornStateList[1]) then
		effName = "fx_ui_jiazuzhan_yan.prefab"
		posy = 30
	elseif checknumber(power) >= checknumber(self._wornStateList[2]) then
		posy = 50

		if i == 1 then
			effName = "fx_ui_jiazuzhan_glow_white.prefab"
		elseif i == 2 then
			effName = "fx_ui_jiazuzhan_glow_green.prefab"
		elseif i == 3 then
			effName = "fx_ui_jiazuzhan_glow_red.prefab"
		elseif i == 4 then
			effName = "fx_ui_jiazuzhan_glow_purple.prefab"
		elseif i == 5 then
			effName = "fx_ui_jiazuzhan_glow_blue.prefab"
		end
	end

	if string.nilorempty(effName) then
		return
	end

	effName = "20220602/jiazuzhan/" .. effName
	self._pillarEffList[i] = UIEffectManager.instance:playEffect(self, effName, self._pillarItemList[i].effGo, 0, 0, true, nil, nil, nil, self)

	self._pillarEffList[i]:setParent(self._pillarItemList[i].effGo.transform)
	self._pillarEffList[i]:setLocalPos(0, posy, 0)
	self._pillarEffList[i]:setScale(1)
end

function FamilyWarMainView:_updataAllPillarSignShow()
	self._baseInfo = FamilyWarModel.instance:getFamilyWarBaseInfo()

	for i = 1, #self._pillarItemList do
		if self._pillarItemList[i] and self._pillarItemList[i].itemGo then
			if self._baseInfo.pillarInfos and self._baseInfo.pillarInfos[i] then
				if self._baseInfo.pillarInfos[i].familyId == self._baseInfo.flagFamilyId then
					GameUtil.SetActive(self._pillarItemList[i].signIma, true)
					self._pillarItemList[i].signIma:SetState(1)
				elseif self._baseInfo.pillarInfos[i].familyId == self._baseInfo.noFlagFamilyId then
					GameUtil.SetActive(self._pillarItemList[i].signIma, true)
					self._pillarItemList[i].signIma:SetState(0)
				else
					GameUtil.SetActive(self._pillarItemList[i].signIma, false)
				end
			else
				GameUtil.SetActive(self._pillarItemList[i].signIma, false)
			end
		end
	end
end

function FamilyWarMainView:_onClickFormationBtn()
	if not self:_clickCoolDownTips(true) then
		return
	end

	local fsType, cfg = FamilyWarModel.instance:getFamilyWarFuncStage()

	if fsType == FamilyWarController.FuncStageType.None or fsType == FamilyWarController.FuncStageType.Apply or fsType == FamilyWarController.FuncStageType.ApplyEnd then
		FloatWordMgr.instance:show("未到布阵调整阶段！")

		return
	end

	if fsType == FamilyWarController.FuncStageType.Adjustment or fsType == FamilyWarController.FuncStageType.Battle or fsType == FamilyWarController.FuncStageType.FormationEnd or fsType == FamilyWarController.FuncStageType.AdjustmentEnd then
		FloatWordMgr.instance:show("已过了布阵阶段，不可在调整！")

		return
	end

	if fsType == FamilyWarController.FuncStageType.Formation then
		FamilyWarController.instance:csRequestFamilyBattleGetFormationReq()

		return
	end

	FloatWordMgr.instance:show("未到布阵调整阶段！")
end

function FamilyWarMainView:_onClickNestItemBtn(index)
	if self:_onClickBtnShowTips() then
		return
	end

	index = checknumber(index)

	if index <= 0 or index > #self._nestItemList then
		return
	end

	UIStateManager.instance:push(ViewName.FamilyNestTower, {
		planId = self._periodCfg.nestPlanId,
		nestId = index
	})
end

function FamilyWarMainView:_onClickPillarItemBtn(index)
	if self:_onClickBtnShowTips() then
		return
	end

	index = checknumber(index)

	if index <= 0 or index > #self._pillarItemList then
		return
	end

	if self._baseInfo.pillarInfos == nil or self._baseInfo.pillarInfos[index] == nil then
		return
	end

	UIStateManager.instance:push(ViewName.FamilyPillarTower, {
		planId = self._periodCfg.divinePillarPlanId,
		curIndex = index,
		familyId = self._baseInfo.pillarInfos[index].familyId
	})
end

function FamilyWarMainView:_onClickSeasonBtn()
	if not self._isChief then
		return
	end

	local cfg = FamilyWarModel.instance:getFamilySeasonByType()

	if cfg == nil then
		return
	end

	UIStateManager.instance:push(ViewName.FamilyWarSeason, cfg)
end

function FamilyWarMainView:_onClickBtnShowTips()
	local fsType, cfg = FamilyWarModel.instance:getFamilyWarFuncStage()

	if fsType ~= FamilyWarController.FuncStageType.Battle then
		FloatWordMgr.instance:show("对抗阶段即将开始，敬请期待！")

		return true
	end

	return false
end

function FamilyWarMainView:_clickCoolDownTips(isTips)
	local nowTime = ServerTime.now()

	if checknumber(self._clickTimer) <= 0 then
		self._clickTimer = nowTime
	else
		if nowTime - self._clickTimer < 0.5 then
			if isTips then
				FloatWordMgr.instance:show("点击过于频繁")
			end

			return false
		end

		self._clickTimer = now
	end

	return true
end

return FamilyWarMainView
