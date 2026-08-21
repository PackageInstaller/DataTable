-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/propertycompare/BattlePropertyCompareUnitInfo.lua

module("logic.extensions.battle.viewmain.propertycompare.BattlePropertyCompareUnitInfo", package.seeall)

local BattlePropertyCompareUnitInfo = class("BattlePropertyCompareUnitInfo")
local kBlendFactor = UnityEngine.Shader.PropertyToID("_BlendFactor")
local kColorCured = "<color=#7cc588>%s</color>"
local kColorDamaged = "<color=#ffffff>%s</color>"

function BattlePropertyCompareUnitInfo:ctor(mainGO, isLeft)
	self.mainGO = mainGO
	self._isLeft = isLeft

	self:buildUI()
end

function BattlePropertyCompareUnitInfo:destroy()
	self:destroyUI()

	self.mainGO = nil
end

function BattlePropertyCompareUnitInfo:buildUI()
	self._goTipsHolder = goutil.findChild(self.mainGO, "buffTipsHolder")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "nameHint/txtName")
	self._txtHpFrom = goutil.findChildTextComponent(self.mainGO, "progress/txtBlood")
	self._bloodSlider = UIComponentType.SliderAdapter(goutil.findChild(self.mainGO, "progress/hpSlider"))
	self._txtHpTo = goutil.findChildTextComponent(self.mainGO, "progress/hpSlider/Handle Slide Area/Handle/hp/txtTo")
	self._hpRedSignGo = goutil.findChild(self.mainGO, "progress/hpSlider/Handle Slide Area/Handle/hp/txtTo/imgSign2")
	self._hpGreenSignGo = goutil.findChild(self.mainGO, "progress/hpSlider/Handle Slide Area/Handle/hp/txtTo/imgSign1")
	self._career = UIBattleCareer.New(goutil.findChild(self.mainGO, "nameHint/career"))
	self._sanity = UIBattleSanity.New(goutil.findChild(self.mainGO, "sanity/sanity_copy"))
	self._bloodComp = BattleBloodHintComponent.New(goutil.findChild(self.mainGO, "progress"))

	self._bloodComp:setDirection(self._isLeft)

	self._goBuffRoot = goutil.findChild(self.mainGO, "buffList")
	self._buffTipsBtn = Astral.ButtonAdapter.Get(self._goBuffRoot)
	self._buffCollection = BattleReusableCollection.New(BattleBuffIcon)
	self._entityId = false

	self._buffTipsBtn:AddClickListener(self._onClickBuffIcon, self)

	if self._isLeft then
		local x, y = Astral.TransformUtil.GetAnchoredPos(self._goTipsHolder.transform, 0, 0)

		self._initTipsPosX = x
		self._initTipsPosY = y
	end

	self._scrollData = {}
end

function BattlePropertyCompareUnitInfo:setDeadSign(deadSign, sanityDeadSign)
	self._imgDeadGo = deadSign
	self._imgSanityDeadGo = sanityDeadSign
end

function BattlePropertyCompareUnitInfo:destroyUI()
	self._sanity:destroy()

	self._sanity = nil

	self._career:destroy()
	self._buffCollection:clear()
	self._buffTipsBtn:RemoveClickListener()

	self._buffCollection = nil
	self._career = nil
	self._txtName = nil
	self._txtHpFrom = nil
	self._txtHpTo = nil
	self._goBuffRoot = nil
	self._goRestrainSign = nil
	self._goBeRestrainSign = nil
	self._goTipsHolder = nil

	table.clear(self._scrollData)

	self._scrollData = false
end

function BattlePropertyCompareUnitInfo:setIsLeft(status)
	self._isLeft = status
end

function BattlePropertyCompareUnitInfo:setTipsHolder(goTipsHolder)
	self._goTipsHolder = goTipsHolder
end

function BattlePropertyCompareUnitInfo:_preparePlayScrollAnimation(fp, tp, isDouble, maxHp, toHp)
	self._bloodComp:preparePlayScrollForecast(fp)
	self._bloodSlider:SetValue(fp)

	self._scrollData.fp = fp
	self._scrollData.tp = tp
	self._scrollData.isDouble = isDouble
	self._scrollData.currentp = fp
	self._scrollData.vectice = tp - fp
	self._scrollData.maxHp = maxHp
	self._scrollData.toHp = toHp
end

function BattlePropertyCompareUnitInfo:startPlayScroll()
	self._bloodComp:startPlayScrollForecast(self._scrollData.fp, self._scrollData.tp, self._scrollData.isDouble)
end

function BattlePropertyCompareUnitInfo:onPlayScroll(dp)
	self._scrollData.currentp = self._scrollData.currentp + dp * self._scrollData.vectice

	self:_updateBloodValue(math.ceil(self._scrollData.maxHp * self._scrollData.currentp))
	self._bloodComp:playScrollForecast(self._scrollData.currentp)
	self._bloodSlider:SetValue(self._scrollData.currentp)
end

function BattlePropertyCompareUnitInfo:onScrollComplete()
	self._bloodComp:forecastByValue(self._scrollData.fp, self._scrollData.tp, self._scrollData.isDouble)
	self:_updateBloodValue(self._scrollData.toHp)
end

function BattlePropertyCompareUnitInfo:_updateBloodValue(value)
	local bloodValue = math.abs(value)
	local color = self._isCured and kColorCured or kColorDamaged

	self._txtHpTo.text = string.format(color, bloodValue)
end

function BattlePropertyCompareUnitInfo:updateView(entityInfo, isDamage, playAnimation)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entityInfo.entityId)
	local sanity = unit.property:getAttribute(BattleExtension_pb.Attribute.CURRENT_SAN)
	local fromHp = unit.property:getAttribute(BattleExtension_pb.Attribute.CURRENT_HP)
	local fromMaxHp = unit.property:getAttribute(BattleExtension_pb.Attribute.MAX_HP)
	local toHp = entityInfo:getAttribute(BattleExtension_pb.Attribute.CURRENT_HP)
	local toMaxHp = entityInfo:getAttribute(BattleExtension_pb.Attribute.MAX_HP)
	local toSanity = entityInfo:getAttribute(BattleExtension_pb.Attribute.CURRENT_SAN)
	local isDouble = unit.property:isWeakPointBroken()
	local fp = fromHp / fromMaxHp
	local tp = toHp / toMaxHp

	self._isCured = fromHp < toHp

	if not playAnimation then
		self:_updateBloodValue(toHp)
		self._bloodComp:forecastByValue(fp, tp, isDouble)
		self._bloodSlider:SetValue(tp)
	else
		self:_updateBloodValue(fromHp)
		self:_preparePlayScrollAnimation(fp, tp, isDouble, fromMaxHp, toHp)
	end

	self._txtHpFrom.text = fromHp

	local dHp = toHp - fromHp

	if dHp > 0 then
		goutil.setActive(self._hpGreenSignGo, true)
		goutil.setActive(self._hpRedSignGo, false)
	elseif dHp <= 0 then
		goutil.setActive(self._hpGreenSignGo, false)
		goutil.setActive(self._hpRedSignGo, true)
	end

	if self._isLeft then
		local isInStrengthen = BattleUnitUtil.isUnitStrengthening(unit)

		self._sanity:setSanity(sanity, isInStrengthen)
	else
		self._sanity:setSanity(sanity, false)
	end

	local modelCO = ModelConfig.instance:getModelConfig(unit.property:getModelCode())

	self._entityId = unit.property:getEntityId()
	self._txtName.text = unit.property:getName()

	self._career:setCareerAndColorType(unit.property:getCareer(), unit.property:getColorType())
	self._buffCollection:clear()

	local buffGoList = BattleTableUtil.getTempList()
	local buffTable = unit.buff:getAllBuff()
	local count = 0

	for _, buffMO in pairs(buffTable) do
		count = count + 1

		if count <= 4 then
			local buffIcon = self._buffCollection:createInstance()

			buffIcon:setBuffMO(buffMO)
			buffIcon:setClickListener(self._onClickBuffIcon, self)
			table.insert(buffGoList, buffIcon.mainGO)
		else
			local buffIcon = self._buffCollection:createInstance()

			buffIcon:setMoreSign(true)
			buffIcon:setClickListener(self._onClickBuffIcon, self)
			table.insert(buffGoList, buffIcon.mainGO)

			break
		end
	end

	if self._isLeft then
		for i = 1, #buffGoList do
			goutil.addChildToParent(buffGoList[i], self._goBuffRoot)
		end

		Astral.TransformUtil.SetAnchoredPos(self._goTipsHolder.transform, self._initTipsPosX + 27 * (count - 1), self._initTipsPosY)
	else
		for i = #buffGoList, 1, -1 do
			goutil.addChildToParent(buffGoList[i], self._goBuffRoot)
		end
	end

	BattleTableUtil.releaseTempList(buffGoList)

	if toHp <= 0 or toSanity and toSanity < BattleConst.MIN_SANITY then
		if toHp <= 0 then
			goutil.setActive(self._imgDeadGo, true)
			goutil.setActive(self._imgSanityDeadGo, false)
		else
			goutil.setActive(self._imgDeadGo, false)
			goutil.setActive(self._imgSanityDeadGo, true)
		end
	else
		goutil.setActive(self._imgDeadGo, false)
		goutil.setActive(self._imgSanityDeadGo, false)
	end

	self:_updateSanitySystemOpen()
end

function BattlePropertyCompareUnitInfo:_updateSanitySystemOpen()
	local unit = self:_getBindingUnit()

	self._sanity:setVisible(BattleUnitUtil.isSanityVisibleBySystemOpen(unit), BattleConst.SystemOpenKey)
end

function BattlePropertyCompareUnitInfo:onSanitySystemOpen()
	self:_updateSanitySystemOpen()
end

function BattlePropertyCompareUnitInfo:setPlaySpeed(playSpeed)
	return
end

function BattlePropertyCompareUnitInfo:getEntityId()
	return self._entityId
end

function BattlePropertyCompareUnitInfo:doSanityPreview(sanityValue)
	local unit = self:_getBindingUnit()
	local isInStrengthen = BattleUnitUtil.isUnitStrengthening(unit)

	self._sanity:doPreview(unit.property:getSanity(), isInStrengthen, sanityValue)
end

function BattlePropertyCompareUnitInfo:stopSanityPreview()
	local unit = self:_getBindingUnit()

	if unit then
		unit.uiProxy:stopSanityPreview()
	end

	self._sanity:stopPreview()
end

function BattlePropertyCompareUnitInfo:clearSanityView()
	self._sanity:clearSanityView()
end

function BattlePropertyCompareUnitInfo:_getBindingUnit()
	local unitMgr = BattleMgr.instance:getUnitMgr()

	return unitMgr:getUnit(self._entityId)
end

function BattlePropertyCompareUnitInfo:_onClickBuffIcon()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)
	local buffTable = unit.buff:getAllBuff()

	if #buffTable > 0 then
		local forceAlign = UnityEngine.TextAnchor.LowerLeft
		local forceTipsAlignVer = CommEnum.TipsAlignType.Up

		ToolTipsMgr.showBattleBuffTips(unit, self._goTipsHolder, forceAlign, forceTipsAlignVer)
	end
end

return BattlePropertyCompareUnitInfo
