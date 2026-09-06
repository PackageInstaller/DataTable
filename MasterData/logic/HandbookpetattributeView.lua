-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/HandbookpetattributeView.lua

module("logic.extensions.handbook.view.HandbookpetattributeView", package.seeall)

local HandbookpetattributeView = class("HandbookpetattributeView", ViewComponent)

function HandbookpetattributeView:ctor()
	HandbookpetattributeView.super.ctor(self)
end

function HandbookpetattributeView:buildUI()
	HandbookpetattributeView.super.buildUI(self)

	self._btnTip = self:getBtn("title/tipBtn")
	self._btnActive = self:getBtn("btnActive")
	self._btnUpgrade = self:getBtn("btnUpgrade")
	self._tableGo = self:getGo("tableview")
	self._itemGo = self:getGo("tablecell")
	self._upgradeCell = self:getGo("tablecell/upgradeCell")
	self._upgradeView = self:getGo("tablecell/upgradeView")
	self._uiTableView = self._tableGo:GetComponent("UITableview")
	self._goActive = self:getGo("title/active")
	self._txtCur = goutil.findChildTextComponent(self.mainGO, "title/active/txtCur")
	self._txtAfter = goutil.findChildTextComponent(self.mainGO, "title/active/txtAfter")
	self._txtNotAcTip = goutil.findChildTextComponent(self.mainGO, "title/txtNotAcTip")
	self._goBubble = self:getGo("bubble")
	self._iconBubble = self:getGo("bubble/icon")
	self._txtBubble = goutil.findChildTextComponent(self.mainGO, "bubble/txtNum")
	self._redPoint = self:getGo("redPoint")
	self._viewEff = {}

	GameUtil.SetActive(self._itemGo, true)
	GameUtil.SetActive(self._upgradeCell, false)
end

function HandbookpetattributeView:bindEvents()
	HandbookpetattributeView.super.bindEvents(self)
	self._btnActive:AddClickListener(self._onClickActive, self)
	self._btnUpgrade:AddClickListener(self._onClickUpgrade, self)
	self._btnTip:AddClickListener(self._onClickTipRule, self)
end

function HandbookpetattributeView:unbindEvents()
	HandbookpetattributeView.super.unbindEvents(self)
	self._btnActive:RemoveClickListener()
	self._btnUpgrade:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function HandbookpetattributeView:destroyUI()
	HandbookpetattributeView.super.destroyUI(self)
end

function HandbookpetattributeView:onEnter()
	HandbookpetattributeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.HandBookPetSelect, self._refresh, self)
	self:_refresh()
end

function HandbookpetattributeView:onEnterFinished()
	HandbookpetattributeView.super.onEnterFinished(self)
end

function HandbookpetattributeView:onExit()
	HandbookpetattributeView.super.onExit(self)
	self:_stopEffect()
	MaterialMgr.resetAll(self._iconBubble)
	GlobalDispatcher:removeListener(GlobalNotify.HandBookPetSelect, self._refresh, self)
	self:_clearAllCell()
end

function HandbookpetattributeView:onExitFinished()
	HandbookpetattributeView.super.onExitFinished(self)
end

function HandbookpetattributeView:_refresh()
	self._goBubble.gameObject:SetActive(false)
	self._btnActive.gameObject:SetActive(false)
	self._btnUpgrade.gameObject:SetActive(false)

	local raceId = PetbookModel.instance:getSelectedPetRaceId()
	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local manualBenefitId = petCo.manualBenefitId

	if manualBenefitId >= 0 then
		local attLevel = HandbookModel.instance:getAttributeLevel(raceId)
		local maxLvl = CharacterConfig.instance:getMaxAwaken(raceId)

		attLevel = math.min(attLevel, maxLvl)

		local isLast = attLevel == maxLvl
		local isActive = attLevel >= 0

		self._isActive = isActive

		local dataList = {}

		if petCo.rare == 1 and isActive then
			isLast = true
		end

		self._isLast = isLast

		local ifCanUpgradeOrActive = HandbookController.instance:getIfCanActiveOrUpgrade(raceId)
		local maxCfg = HandbookConfig.instance:getBenefitCfg(manualBenefitId, maxLvl)

		maxCfg.formulaWanPercent1 = checknumber(string.split(maxCfg.formulaWanPercent, "#")[1])

		print("------------------  " .. attLevel)

		local cfg = HandbookConfig.instance:getBenefitCfg(manualBenefitId, attLevel)
		local idx = attLevel

		if cfg == nil then
			cfg = HandbookConfig.instance:getBenefitCfg(manualBenefitId, 0)
			idx = 0

			if cfg == nil then
				printError(">>>>>>>>>>  没找到 raceId = " .. raceId .. "的配置")
			end
		end

		if cfg then
			cfg.formulaWanPercent1 = checknumber(string.split(cfg.formulaWanPercent, "#")[1])
		end

		self._goBubble.gameObject:SetActive(not isActive)
		self._btnActive.gameObject:SetActive(attLevel == -1 and not isLast)
		self._btnUpgrade.gameObject:SetActive(attLevel ~= -1 and isActive and not isLast)

		local rare = CharacterConfig.instance:getPetCo(raceId).rare
		local types = {
			string.split(cfg.formulaPropertyType, "#")[1]
		}

		if isActive and not isLast then
			local nextcfg = HandbookConfig.instance:getBenefitCfg(manualBenefitId, idx + 1)

			nextcfg.formulaWanPercent1 = checknumber(string.split(nextcfg.formulaWanPercent, "#")[1])

			local nextVal = isLast and 0 or nextcfg.formulaWanPercent1

			for k, v in pairs(types) do
				local single = {}

				single.type = v
				single.curVal = "+" .. lang(cfg.formulaWanPercent1 / 100) .. "%"
				single.nextVal = "+" .. lang(nextVal / 100) .. "%"

				table.insert(dataList, single)
			end

			self._txtNotAcTip.gameObject:SetActive(true)
			self._goActive.gameObject:SetActive(true)

			local curLevelName = CharacterConfig.instance:getAwakenRareCfg(attLevel).upDesc
			local afterLevelName = CharacterConfig.instance:getAwakenRareCfg(attLevel + 1).upDesc

			self._txtCur.text = langPara("%s", curLevelName)
			self._txtAfter.text = langPara("%s", afterLevelName)

			GameUtil.SetGray(self._btnUpgrade, not ifCanUpgradeOrActive)
		elseif isLast then
			for k, v in pairs(types) do
				local single = {}

				single.type = v
				single.curVal = "+" .. lang(maxCfg.formulaWanPercent1 / 100) .. "%"
				single.nextVal = ""

				table.insert(dataList, single)
			end

			self._txtNotAcTip.text = "当前觉醒已达到最高"

			self._goActive.gameObject:SetActive(false)
			self._txtNotAcTip.gameObject:SetActive(true)
		else
			for k, v in pairs(types) do
				local single = {}

				single.type = v
				single.curVal = "+" .. lang(cfg.formulaWanPercent1 / 100) .. "%"
				single.nextVal = ""

				table.insert(dataList, single)
			end

			self._txtNotAcTip.text = "属性加成对全精灵有效"

			local reward = cfg.reward

			self._txtBubble.text = langPara("×%s", string.split(reward, ":")[3])

			self._goActive.gameObject:SetActive(false)
			self._txtNotAcTip.gameObject:SetActive(true)
			GameUtil.SetGray(self._btnActive, not ifCanUpgradeOrActive)
		end

		local function getAttrFunc(propertyStr)
			local tempArr = string.split(propertyStr, "+")
			local attrName = tempArr[1]
			local attrValue = checknumber(tempArr[2])

			return attrName, attrValue
		end

		local propertyArr = string.split(cfg.propertyParam, "#")

		for index, propertyStr in ipairs(propertyArr) do
			local attrName, attrValue = getAttrFunc(propertyStr)
			local single = {}

			single.type = attrName
			single.curVal = "+" .. attrValue
			single.nextVal = ""

			if isActive and not isLast then
				local nextcfg = HandbookConfig.instance:getBenefitCfg(manualBenefitId, idx + 1)
				local nextPropertyArr = string.split(nextcfg.propertyParam, "#")
				local nextAttrName = ""
				local nextAttrValue = ""

				for _, nextPropertyStr in ipairs(nextPropertyArr) do
					local nextName, nextValue = getAttrFunc(nextPropertyStr)

					if nextName == attrName then
						nextAttrName = nextName
						nextAttrValue = nextValue
					end
				end

				single.nextVal = nextAttrValue
			elseif isLast then
				-- block empty
			end

			if attrValue > 0 then
				table.insert(dataList, single)
			end
		end

		if #dataList > 0 then
			local spriteChange = goutil.findChild(self._itemGo, "Image/icon"):GetComponent("UIImageSpriteChange")

			spriteChange:SetState(checknumber(HandbookModel.ATTTYPE_MAP[dataList[1].type] - 1))
		end

		local childList = GameUtil.getChildren(self._upgradeView)

		for idx, go in ipairs(childList) do
			if idx > #dataList then
				GameUtil.SetActive(go, false)
			end
		end

		for idx, data in ipairs(dataList) do
			if not childList[idx] then
				local cell = goutil.cloneAndSetParent(self._upgradeCell, self._upgradeView.transform)

				self:_updateCell(nil, cell, data)
				GameUtil.SetActive(cell, true)
			end
		end

		goutil.setActive(self._redPoint, ifCanUpgradeOrActive)
	end
end

function HandbookpetattributeView:_updateCell(view, cell, data)
	local goUpgrade = goutil.findChild(cell, "upgrade")
	local goElse = goutil.findChild(cell, "else")

	if self._isActive and not self._isLast then
		goutil.setActive(goUpgrade, true)
		goutil.setActive(goElse, false)

		local txtCur = goutil.findChildTextComponent(cell, "upgrade/txtCur")
		local txtAfter = goutil.findChildTextComponent(cell, "upgrade/txtAfter")
		local txtAcTip = goutil.findChildTextComponent(cell, "upgrade/txtAcTip")

		txtCur.gameObject:SetActive(not string.nilorempty(data.curVal))

		txtCur.text = data.curVal

		txtAfter.gameObject:SetActive(not string.nilorempty(data.nextVal))

		txtAfter.text = data.nextVal
		txtAcTip.text = langPara("handbookpetattributeview__add", data.type)
	else
		goutil.setActive(goUpgrade, false)
		goutil.setActive(goElse, true)

		local txtCur = goutil.findChildTextComponent(cell, "else/txtCur")
		local txtAcTip = goutil.findChildTextComponent(cell, "else/txtAcTip")

		txtCur.text = data.curVal
		txtAcTip.text = langPara("handbookpetattributeview__add", data.type)
	end
end

function HandbookpetattributeView:_clearAllCell()
	local childList = GameUtil.getChildren(self._upgradeView)

	for idx, go in ipairs(childList) do
		self:_clearCell(go, idx)
	end
end

function HandbookpetattributeView:_clearCell(cell, idx)
	return
end

function HandbookpetattributeView:_onClickActive()
	local raceId = PetbookModel.instance:getSelectedPetRaceId()

	if HandbookController.instance:getIfCanActiveOrUpgrade(raceId) then
		HandbookController.instance:activatePetBenefit(raceId, function()
			self:_refresh()
			self._uiTableView:Travel(self._showEffect, self)
		end)
	else
		FloatWordMgr.instance:show(lang("Handbookpetattribute_tip_1"))
	end
end

function HandbookpetattributeView:_onClickUpgrade()
	local raceId = PetbookModel.instance:getSelectedPetRaceId()

	if HandbookController.instance:getIfCanActiveOrUpgrade(raceId) then
		HandbookController.instance:upgradePetBenefit(raceId, function()
			self:_refresh()
			self._uiTableView:Travel(self._showEffect, self)
		end)
	else
		FloatWordMgr.instance:show(lang("Handbookpetattribute_tip_2"))
	end
end

function HandbookpetattributeView:_onClickTipRule()
	local ruleCo = RulesConfig.instance:getRuleCo("petattributerule")
	local title = tostring((not ruleCo.title or nil) and 0)

	if not title or title == "0" or #title == 0 then
		title = lang("tip")
	end

	TipsFacade.instance:openTipWindowNoX(title, ruleCo.rules)
end

function HandbookpetattributeView:_showEffect(cell)
	local effectGo = goutil.findChild(cell, "effect")

	if self._viewEff[cell] then
		UIEffectManager.instance:stopEffect(self._viewEff[cell])
	end

	local effPath = "fx_ui_tujian/fx_ui_shengji_tujian_kuang.prefab"

	self._viewEff[cell] = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, false, nil, nil, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
	end)

	self._viewEff[cell]:setParent(effectGo.transform)
	self._viewEff[cell]:setScale(1)

	self._viewEff[cell].hideEffWhileNotOnTop = true
end

function HandbookpetattributeView:_stopEffect()
	for k, v in pairs(self._viewEff) do
		if v then
			UIEffectManager.instance:stopEffect(v)
		end
	end

	table.clear(self._viewEff)
end

return HandbookpetattributeView
