-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveTenItemView.lua

module("logic.extensions.retrieve.view.RetrieveTenItemView", package.seeall)

local M = class("RetrieveTenItemView")
local ButtonAdapter = Astral.ButtonAdapter
local mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
local uiCameraTarget = CameraTargetMgr.instance:getUICameraTarget()
local plane2D = SceneRoot2DMgr.instance:getSceneUIRoot().transform

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
end

function M:Awake()
	self._itemAnimation = self._go:GetComponent(ComponentType.Animation)
	self._qualityEffectTb = {}
	self._qualityEffectTb[GameEnum.QualityEnum.S] = goutil.findChild(self._go, "s")
	self._qualityEffectTb[GameEnum.QualityEnum.A] = goutil.findChild(self._go, "a")
	self._qualityEffectTb[GameEnum.QualityEnum.B] = goutil.findChild(self._go, "b")
	self._qualityTb = {}
	self._qualityTb[GameEnum.QualityEnum.S] = goutil.findChild(self._go, "imgQualityS")
	self._qualityTb[GameEnum.QualityEnum.A] = goutil.findChild(self._go, "imgQualityA")
	self._imgRoleGo = goutil.findChild(self._go, "mask/imgRole")
	self._imgRoleSR = SpriteDynIcon.Get(self._imgRoleGo)
	self._imgSuperRoleGo = goutil.findChild(self._go, "mask/imgRole_s")
	self._imgSuperRoleSR = SpriteDynIcon.Get(self._imgSuperRoleGo)

	local imgCareerGo = goutil.findChild(self._go, "imgCareer")

	self._imgCareerSR = SpriteDynIcon.Get(imgCareerGo)
	self._timeObjS = goutil.findChild(self._go, "objS")
	self._txtTimeS = goutil.findChild(self._timeObjS, "txtTimeS"):GetComponent(ComponentType.TextMeshPro)
	self._timeObjOther = goutil.findChild(self._go, "objABC")
	self._txtTimeOther = goutil.findChild(self._timeObjOther, "txtTime"):GetComponent(ComponentType.TextMeshPro)
	self._imgMaskGo = goutil.findChild(self._go, "imgMask2")
	self._newGo = goutil.findChild(self._go, "ck_new")
	self._uiFollow = self:_createUIFollow()

	self._uiFollow:SetFollowArgs(mainCameraTarget:getCamera(), uiCameraTarget:getCamera(), plane2D)
	self._uiFollow:SetPerspectiveArgs(10, 0.7, 1.5)
end

function M:_createUIFollow()
	local uiFollow = UIFollowUnit.Get(self._go)

	uiFollow:CreateFollowGroup(0, 1)
	uiFollow:CreateFollowGroup(0, 0.5)
	uiFollow:CreateFollowGroup(0, -0.05)

	return uiFollow
end

function M:onEnter()
	return
end

function M:setViewPresentor(viewPresentor)
	self._viewPresentor = viewPresentor
end

function M:updateData(data, xinMaoGo)
	self._data = data
	self._imgCareerSR.sprite.sprite = nil

	goutil.setActive(self._imgMaskGo, false)

	if xinMaoGo and not goutil.isNil(xinMaoGo) then
		local imgXinMaoIcon = goutil.findChildImageComponent(xinMaoGo, "imgIcon")
		local txtXinMao = goutil.findChildComponent(xinMaoGo, "txtNum", UIComponentType.TMPText)
		local converData = self:_getXinMaoData(data.conversion)

		if converData then
			local itemData = ItemData.New({
				itemId = converData.code,
				count = converData.num
			})

			IconLoader.setSprite(imgXinMaoIcon, IconType.ItemIcon, itemData:getIcon())

			txtXinMao.text = itemData:getCount()
		end

		self._tempXinMaoGo = xinMaoGo

		removetimer(self._delayShowConversion, self)
		settimer(1.3, self._delayShowConversion, self, false)
	end

	goutil.setActive(self._newGo, data.isNew == true)
	goutil.setActive(self._hasConvered, not data.isNew == true)
	self:_refreshCharacterView(data.characterCode)
end

function M:_delayShowConversion()
	if self._tempXinMaoGo and not goutil.isNil(self._tempXinMaoGo) and not goutil.isNil(self._go) then
		goutil.setActive(self._tempXinMaoGo, true)
		goutil.setActive(self._imgMaskGo, true)
		self._uiFollow:SetMainGameObject(self._go)
		self._uiFollow:AddFollowGameObject(UIFollowType.Bottom, self._tempXinMaoGo)
	end
end

function M:_getXinMaoData(conversion)
	for _, v in pairs(conversion) do
		local converData = v

		if converData.code ~= GameEnum.CurrencyCodeEnum.InspirationS and converData.code ~= GameEnum.CurrencyCodeEnum.InspirationA then
			return converData
		end
	end

	return false
end

function M:_refreshConversion()
	if self._data.conversion and #self._data.conversion ~= 0 then
		goutil.setActive(self._conversionGo, true)
		self:_initConversion(self._data.conversion)
	else
		goutil.setActive(self._conversionGo, false)
	end
end

function M:_refreshCharacterView(characterCode)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(characterCode)

	if not characterCO then
		return
	end

	local careerUrl = GameUrl.getRetrieveSceneRes(CommEnum.Career2IconRetrieveResult[characterCO.career])

	self._imgCareerSR:SetImage(careerUrl, self._onCareerLoaded, self)

	local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)
	local setting = IconType.getSetting(IconType.RoleHeadIcon)
	local url = setting.url
	local isSuperCard = characterCO.quality == GameEnum.QualityEnum.S

	if isSuperCard then
		self._imgSuperRoleSR:SetImage(string.format(url, modelCO.headIconName), self._onHeadLoadFinish, self)
	else
		self._imgRoleSR:SetImage(string.format(url, modelCO.headIconName), self._onHeadLoadFinish, self)
	end

	goutil.setActive(self._imgRoleGo, not isSuperCard)
	goutil.setActive(self._imgSuperRoleGo, isSuperCard)
	goutil.setActive(self._timeObjS, isSuperCard)
	goutil.setActive(self._timeObjOther, not isSuperCard)

	local randomText = self:getRadomTimeText(characterCO.quality)

	if isSuperCard then
		self._txtTimeS.text = randomText
	else
		self._txtTimeOther.text = randomText
	end

	for k, qualityGo in pairs(self._qualityTb) do
		goutil.setActive(qualityGo, k == characterCO.quality)
	end

	for k, qualityGo in pairs(self._qualityEffectTb) do
		goutil.setActive(qualityGo, k == characterCO.quality)
	end

	if self._itemAnimation then
		self._itemAnimation:Stop()
		self._itemAnimation:Play()
	end
end

function M:_onCareerLoaded()
	return
end

function M:_onHeadLoadFinish()
	return
end

function M:getRadomTimeText(quality)
	local hour = "00"
	local min = "00"
	local sec = StringUtil.getLess10With0(math.random(0, 59))

	if quality == GameEnum.QualityEnum.S then
		hour = StringUtil.getLess10With0(math.random(1, 24))
		min = StringUtil.getLess10With0(math.random(0, 59))
	elseif quality == GameEnum.QualityEnum.A then
		min = StringUtil.getLess10With0(math.random(0, 59))
	elseif quality == GameEnum.QualityEnum.B then
		-- block empty
	elseif characterCO.quality == GameEnum.QualityEnum.C then
		-- block empty
	end

	return string.format("%s:%s:%s", hour, min, sec)
end

function M:_initConversion(conversion)
	self._effectList = {}

	goutil.clearChildren(self._conversionLayout)

	for i, item in ipairs(conversion) do
		local obj = goutil.clone(self._cellGo)

		goutil.addChildToParent(obj, self._conversionLayout)
		goutil.setActive(obj, true)

		local backPackItemGo = goutil.findChild(obj, "backpack_item")
		local effectGo = goutil.findChild(obj, "effect1")
		local numberBg = goutil.findChild(backPackItemGo, "imgDown")

		table.insert(self._effectList, effectGo)

		local itemView = Astral.LuaComponentContainer.Add(backPackItemGo, ItemCell)
		local itemData = ItemData.New({
			itemId = item.code,
			count = item.num
		})

		itemView:Awake()
		itemView:updateData(itemData)
		goutil.setActive(numberBg.gameObject, false)
	end
end

function M:onClickElement()
	if GuideController.instance:isGuiding() then
		return
	end

	CharacterUtil.openCharacterPreviewView(self._data.characterCode)
end

function M:playAni(index)
	self._isPlayAni = false

	goutil.setActive(self._contentGo, false)
	goutil.setActive(self._conversionGo, false)

	local timeIndex = 0

	if index > 5 then
		timeIndex = index - 5
	else
		timeIndex = 6 - index
	end

	if self._hasPlayAnim then
		self:_playAni()
	else
		removetimer(self._playAni, self)
		settimer(0.1 * timeIndex, self._playAni, self, false)
	end
end

function M:playAniImmediate()
	if not self._isPlayAni then
		removetimer(self._playAni, self)
		self:_playAni()
	end
end

function M:updateAnimState(hasPlayAnim)
	return
end

function M:_pauseAni()
	return
end

function M:_playAni()
	self._isPlayAni = true

	goutil.setActive(self._contentGo, true)
	self:_excutePlayAniCallBack()
	self._guiAnimation:StopTimelineAni()

	local characterCO = CharacterConfig.instance:getCfgInfoByID(self._data.characterCode)

	if characterCO.quality == GameEnum.QualityEnum.S then
		self._guiAnimation:PlayAniByName("show_s")
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_chouka_results)
	elseif characterCO.quality == GameEnum.QualityEnum.A then
		self._guiAnimation:PlayAniByName("show_a")
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_chouka_resulta)
	elseif characterCO.quality == GameEnum.QualityEnum.B then
		self._guiAnimation:PlayAniByName("show_b")
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_chouka_resultb)
	elseif characterCO.quality == GameEnum.QualityEnum.C then
		self._guiAnimation:PlayAniByName("show_c")
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_chouka_resultb)
	end
end

function M:_playConversion()
	self:_refreshConversion()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("zhuanhua")

	for i, effectGo in ipairs(self._effectList or {}) do
		local animation = effectGo:GetComponent(ComponentType.Animation)

		animation:Play("summon_card_item_zhuanhua")
	end
end

function M:_dealTimelineListener(tagName)
	if LOTTERY_PAUSE == tagName then
		self:_pauseAni()
	end
end

function M:getGo()
	return self._go
end

function M:getQuality()
	local characterCO = CharacterConfig.instance:getCfgInfoByID(self._data.characterCode)

	return characterCO and characterCO.quality or GameEnum.QualityEnum.B
end

function M:setIndex(index)
	self._index = index
end

function M:getIndex()
	return self._index
end

function M:setPlayAniCallBack(callBackFunc, handler)
	self._playAniCallBackFunc = callBackFunc
	self._playAniCallBackHandler = handler
end

function M:_excutePlayAniCallBack()
	if self._playAniCallBackFunc then
		if self._playAniCallBackHandler then
			self._playAniCallBackFunc(self._playAniCallBackHandler, self:getIndex(), self:getGo(), self:getQuality())
		else
			self._playAniCallBackFunc(self:getIndex(), self:getGo(), self:getQuality())
		end
	end
end

function M:OnDestroy()
	removetimer(self._delayShowConversion, self)

	if self._uiFollow then
		self._uiFollow:Clear()

		self._uiFollow = nil
	end
end

return M
