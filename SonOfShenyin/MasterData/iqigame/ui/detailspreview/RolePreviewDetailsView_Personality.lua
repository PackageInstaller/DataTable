-- chunkname: @IQIGame\\UI\\DetailsPreview\\RolePreviewDetailsView_Personality.lua

local activeItemClass = require("IQIGame/UI/DetailsPreview/RolePreviewDetailsView_PersonalityActiveItem")
local m = {}
local maxPersonalityLevel = 5

function m.New(view, mainView)
	local obj = Clone(m)

	obj:Init(view, mainView)

	return obj
end

function m:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)
	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
	self:AddListeners()
end

function m:AddListeners()
	self.returnBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickReturnBtn)
end

function m:RemoveListeners()
	self.returnBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickReturnBtn)
end

function m:SetData(heroData)
	self.heroData = heroData.Max

	self:_Refresh(self.heroData.cid)
	self:PlayInAnimation()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:InitMembers()
	self.isRightPanelShow = false
end

function m:InitComponent()
	self.activeItemList = {}
	self.activeItemList[Constant.ElementType.ELEMENT_TYPE_WIND] = {}

	for i = 1, maxPersonalityLevel do
		local trans = LuaUtility.GetChild(self.activeList_wind.transform, i - 1)
		local item = activeItemClass.New(trans.gameObject, self)

		self.activeItemList[Constant.ElementType.ELEMENT_TYPE_WIND][i] = item
	end

	self.activeItemList[Constant.ElementType.ELEMENT_TYPE_FIRE] = {}

	for i = 1, maxPersonalityLevel do
		local trans = LuaUtility.GetChild(self.activeList_fire.transform, i - 1)
		local item = activeItemClass.New(trans.gameObject, self)

		self.activeItemList[Constant.ElementType.ELEMENT_TYPE_FIRE][i] = item
	end

	self.activeItemList[Constant.ElementType.ELEMENT_TYPE_THUNDER] = {}

	for i = 1, maxPersonalityLevel do
		local trans = LuaUtility.GetChild(self.activeList_thunder.transform, i - 1)
		local item = activeItemClass.New(trans.gameObject, self)

		self.activeItemList[Constant.ElementType.ELEMENT_TYPE_THUNDER][i] = item
	end

	self.activeItemList[Constant.ElementType.ELEMENT_TYPE_WATER] = {}

	for i = 1, maxPersonalityLevel do
		local trans = LuaUtility.GetChild(self.activeList_water.transform, i - 1)
		local item = activeItemClass.New(trans.gameObject, self)

		self.activeItemList[Constant.ElementType.ELEMENT_TYPE_WATER][i] = item
	end

	LuaUtility.SetGameObjectShow(self.rightPanelRoot, false)

	self.outLineMat_wind = self.outLinePrefab_wind:GetComponent("Image").material
	self.outLineMat_fire = self.outLinePrefab_fire:GetComponent("Image").material
	self.outLineMat_thunder = self.outLinePrefab_thunder:GetComponent("Image").material
	self.outLineMat_water = self.outLinePrefab_water:GetComponent("Image").material
end

function m:InitDelegate()
	function self.delegateOnClickReturnBtn()
		self:OnClickReturnBtn()
	end
end

function m:OnClickReturnBtn()
	self:SetRightPanelShow(false)

	if self.currentEnabledItem then
		self.currentEnabledItem:UnEnabledOutLine()

		self.currentEnabledItem = nil
	end

	LuaUtility.SetGameObjectShow(self.returnBtn, false)
	self.mainView:PersonalityClick(false)
end

function m:Refresh(roleCid)
	self:_Refresh(roleCid)
	self:PlayInAnimation()

	if self.currentEnabledItem then
		self.currentEnabledItem:UnEnabledOutLine()

		self.currentEnabledItem = nil
	end
end

function m:_Refresh(roleCid)
	self.roleCid = roleCid

	self:SetRoleImage()

	local cfgHero = CfgUtil.GetCfgHeroDataWithID(self.roleCid)

	LuaUtility.SetGameObjectShow(self.windRoot, false)
	LuaUtility.SetGameObjectShow(self.fireRoot, false)
	LuaUtility.SetGameObjectShow(self.thunderRoot, false)
	LuaUtility.SetGameObjectShow(self.waterRoot, false)

	if cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WIND then
		LuaUtility.SetGameObjectShow(self.windRoot, true)
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_FIRE then
		LuaUtility.SetGameObjectShow(self.fireRoot, true)
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_THUNDER then
		LuaUtility.SetGameObjectShow(self.thunderRoot, true)
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WATER then
		LuaUtility.SetGameObjectShow(self.waterRoot, true)
	end

	local personalityDataList = self.heroData:GetPersonalityDataList()

	for i = 1, maxPersonalityLevel do
		local data = personalityDataList[i]

		data.isOpen = true

		self.activeItemList[cfgHero.Elements][i]:Refresh(data)
	end

	if self.isRightPanelShow then
		self:RefreshRightPanelShow(self.currentPersonalityData)
	end
end

function m:RefreshRightPanelShow(personalityData)
	self.currentPersonalityData = personalityData

	local cfgPersonality = personalityData.config

	LuaUtility.SetText(self.Num, BattleUIApi:GetBattleActionOrderText(personalityData.index))
	LuaUtility.SetText(self.Name, cfgPersonality.Name)
	LuaUtility.SetText(self.DescribeText, cfgPersonality.PersonalityTips)
end

function m:SetRightPanelShow(show)
	if self.isRightPanelShow == show then
		return
	end

	LuaUtility.SetGameObjectShow(self.rightPanelRoot, show)
	self:PlayClickItemAnimation(show)

	self.isRightPanelShow = show

	EventDispatcher.Dispatch(EventID.SetRoleDevelopmentPanelLeftContentShow, not show)
end

function m:PlayClickItemAnimation(isEnter)
	local cfgHero = CfgUtil.GetCfgHeroDataWithID(self.roleCid)

	if not cfgHero then
		return
	end

	if isEnter then
		if cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WIND then
			LuaUtility.PlayAnimation(self.windRoot, "PersonalityPanel_Enter_1")
		elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_FIRE then
			LuaUtility.PlayAnimation(self.fireRoot, "PersonalityPanel_Enter_2")
		elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_THUNDER then
			LuaUtility.PlayAnimation(self.thunderRoot, "PersonalityPanel_Enter")
		elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WATER then
			LuaUtility.PlayAnimation(self.waterRoot, "PersonalityPanel_Enter_3")
		end
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WIND then
		LuaUtility.PlayAnimation(self.windRoot, "PersonalityPanel_Out_1")
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_FIRE then
		LuaUtility.PlayAnimation(self.fireRoot, "PersonalityPanel_Out_2")
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_THUNDER then
		LuaUtility.PlayAnimation(self.thunderRoot, "PersonalityPanel_Out")
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WATER then
		LuaUtility.PlayAnimation(self.waterRoot, "PersonalityPanel_Out_3")
	end
end

function m:PlayActiveAnimation(personalityId)
	for type, itemList in pairs(self.activeItemList) do
		for i, v in pairs(itemList) do
			if v.data and v.data.id == personalityId then
				v:PlayActiveAnimation()
			end
		end
	end
end

function m:PlayInAnimation()
	local cfgHero = CfgUtil.GetCfgHeroDataWithID(self.roleCid)

	if not cfgHero then
		return
	end

	if cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WIND then
		LuaUtility.PlayAnimation(self.windRoot, "PersonalityPanel_In_1")
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_FIRE then
		LuaUtility.PlayAnimation(self.fireRoot, "PersonalityPanel_In_2")
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_THUNDER then
		LuaUtility.PlayAnimation(self.thunderRoot, "PersonalityPanel_In")
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WATER then
		LuaUtility.PlayAnimation(self.waterRoot, "PersonalityPanel_In_3")
	end
end

function m:GetOutLineMat()
	local cfgHero = CfgUtil.GetCfgHeroDataWithID(self.roleCid)

	if not cfgHero then
		return
	end

	local mat

	if cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WIND then
		mat = self.outLineMat_wind
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_FIRE then
		mat = self.outLineMat_fire
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_THUNDER then
		mat = self.outLineMat_thunder
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WATER then
		mat = self.outLineMat_water
	end

	return mat
end

function m:SetRoleImage()
	local cfgHero = CfgUtil.GetCfgHeroDataWithID(self.roleCid)
	local imgObj

	if cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WIND then
		imgObj = self.windHeroImage
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_FIRE then
		imgObj = self.fireHeroImage
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_THUNDER then
		imgObj = self.thunderHeroImage
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WATER then
		imgObj = self.waterHeroImage
	end

	if imgObj ~= nil then
		AssetUtil.LoadImage(self, cfgHero.PersonalityHero, imgObj:GetComponent("Image"), self.OnLoadImageSucess, nil, imgObj)
	end
end

function m:OnLoadImageSucess(assetName, asset, duration, userData)
	userData.gameObject:SetActive(true)

	local img = userData:GetComponent("Image")

	img:SetNativeSize()
	LuaUtility.SetImageRectTransformPivot(userData:GetComponent("RectTransform"), img)
	LuaUtility.SetAnchoredPositionWithRectTransform(userData:GetComponent("RectTransform"), 0, 0)
end

function m:OnItemClick(item)
	if self.currentEnabledItem then
		self.currentEnabledItem:UnEnabledOutLine()

		self.currentEnabledItem = nil
	end

	item:EnabledOutLine()

	self.currentEnabledItem = item

	self.mainView:PersonalityClick(true)
	LuaUtility.SetGameObjectShow(self.returnBtn, true)
end

return m
