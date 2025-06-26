-- chunkname: @IQIGame\\UI\\RoleDevelopmentPanel\\RoleDevelopmentPersonalityPanel.lua

local RoleDevelopmentPanelBase = require("IQIGame/UI/RoleDevelopmentPanel/RoleDevelopmentPanelBase")
local Panel = Clone(RoleDevelopmentPanelBase)

Panel.personalityIdList = {}
Panel.currentEnabledIndex = 0

local activeItemClass = require("IQIGame/UI/RoleDevelopmentPanel/PersonalityPanel/PersonalityActiveItem")
local maxPersonalityLevel = 5

function Panel:__OnInit()
	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
end

function Panel:InitMembers()
	self.itemCellArray = {}
	self.isRightPanelShow = false
end

function Panel:InitComponent()
	self.view = require("IQIGame/UI/RoleDevelopmentPanel/PersonalityPanel/RoleDevelopmentPersonalityPanelView"):New(self.gameObject)
	self.activeItemList = {}
	self.activeItemList[Constant.ElementType.ELEMENT_TYPE_WIND] = {}

	for i = 1, maxPersonalityLevel do
		local trans = LuaUtility.GetChild(self.view.activeList_wind.transform, i - 1)
		local item = activeItemClass.New(trans.gameObject, self, i)

		item:SetSelectState(false)

		self.activeItemList[Constant.ElementType.ELEMENT_TYPE_WIND][i] = item
	end

	self.activeItemList[Constant.ElementType.ELEMENT_TYPE_FIRE] = {}

	for i = 1, maxPersonalityLevel do
		local trans = LuaUtility.GetChild(self.view.activeList_fire.transform, i - 1)
		local item = activeItemClass.New(trans.gameObject, self, i)

		item:SetSelectState(false)

		self.activeItemList[Constant.ElementType.ELEMENT_TYPE_FIRE][i] = item
	end

	self.activeItemList[Constant.ElementType.ELEMENT_TYPE_THUNDER] = {}

	for i = 1, maxPersonalityLevel do
		local trans = LuaUtility.GetChild(self.view.activeList_thunder.transform, i - 1)
		local item = activeItemClass.New(trans.gameObject, self, i)

		item:SetSelectState(false)

		self.activeItemList[Constant.ElementType.ELEMENT_TYPE_THUNDER][i] = item
	end

	self.activeItemList[Constant.ElementType.ELEMENT_TYPE_WATER] = {}

	for i = 1, maxPersonalityLevel do
		local trans = LuaUtility.GetChild(self.view.activeList_water.transform, i - 1)
		local item = activeItemClass.New(trans.gameObject, self, i)

		item:SetSelectState(false)

		self.activeItemList[Constant.ElementType.ELEMENT_TYPE_WATER][i] = item
	end

	LuaUtility.SetGameObjectShow(self.view.rightPanelRoot, false)

	self.outLineMat_wind = self.outLinePrefab_wind:GetComponent("Image").material
	self.outLineMat_fire = self.outLinePrefab_fire:GetComponent("Image").material
	self.outLineMat_thunder = self.outLinePrefab_thunder:GetComponent("Image").material
	self.outLineMat_water = self.outLinePrefab_water:GetComponent("Image").material
	self.effect_canActiveTrans = self.view.effect_canActive.transform
end

function Panel:InitDelegate()
	function self.delegateOnClickReturnBtn()
		self:OnClickReturnBtn()
	end

	function self.delegateOnClickCanActive()
		self:OnClickCanActive()
	end

	function self.onActiveSucceedEvent()
		self:ActiveSuccessCallBack()
	end

	function self.onPlayActiveAnimationEvent(personalityId)
		self:PlayActiveAnimation(personalityId)
	end
end

function Panel:__OnAddListeners()
	self.returnBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickReturnBtn)
	self.CanActive:GetComponent("Button").onClick:AddListener(self.delegateOnClickCanActive)
	EventDispatcher.AddEventListener(EventID.UnlockPersonalityRefresh, self.onActiveSucceedEvent)
	EventDispatcher.AddEventListener(EventID.PlayActivePersonalityEvent, self.onPlayActiveAnimationEvent)
end

function Panel:__OnRemoveListeners()
	self.returnBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickReturnBtn)
	self.CanActive:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCanActive)
	EventDispatcher.RemoveEventListener(EventID.UnlockPersonalityRefresh, self.onActiveSucceedEvent)
	EventDispatcher.RemoveEventListener(EventID.PlayActivePersonalityEvent, self.onPlayActiveAnimationEvent)
end

function Panel:OnClickReturnBtn()
	if self.isRightPanelShow then
		self:SetRightPanelShow(false)

		if self.currentEnabledItem then
			self.currentEnabledItem:UnEnabledOutLine()

			self.currentEnabledItem = nil
		end

		self.currentEnabledIndex = 0
	else
		UIModule.Close(Constant.UIControllerName.RoleDevelopmentPanel)
	end
end

function Panel:OnClickCanActive()
	if not self.isCanActive then
		NoticeModule.ShowNotice(20003)

		return
	end

	self:PlayActiveAnimation(self.currentPersonalityData.id)
	LuaUtility.SetGameObjectShow(self.notClickMask, true)
	LuaUtility.SetGameObjectShow(self.CanActive, false)

	self.activeCor = coroutine.start(function()
		local t = CfgUtil.GetCfgDiscreteFirstDataWithID(116) / 1000

		coroutine.wait(t)
		WarlockModule.UnlockPersonality(self.roleCid, self.currentPersonalityData.id)
		LuaUtility.SetGameObjectShow(self.notClickMask, false)
		self:StopCoroutine()
	end)
end

function Panel:StopCoroutine()
	if self.activeCor then
		coroutine.stop(self.activeCor)

		self.activeCor = nil
	end
end

function Panel:__OnShow()
	if self.isShow then
		return
	end

	LuaUtility.SetGameObjectShow(self.gameObject, true)

	self.isShow = true
	self.currentEnabledIndex = 0

	self:_Refresh(self.roleCid)
	self:PlayInAnimation()
	EventDispatcher.Dispatch(EventID.SetRoleDevelopmentPanelLeftContentSiblingIndex, LuaUtility.GetGameObjectSiblingIndex(self.SubContent))
	LuaUtility.SetGameObjectShow(self.notClickMask, false)
end

function Panel:__OnHide()
	if not self.isShow then
		return
	end

	LuaUtility.SetGameObjectShow(self.gameObject, false)
	self:StopCoroutine()

	self.isShow = false

	EventDispatcher.Dispatch(EventID.SetRoleDevelopmentPanelLeftContentSiblingIndex, LuaUtility.GetGameObjectSiblingIndex(self.SubContent))
end

function Panel:__OnRefresh()
	self:_Refresh(self.roleCid)
	self:PlayInAnimation()
end

function Panel:__OnDispose()
	for k, v in pairs(self.itemCellArray) do
		v:Dispose()
	end

	self.itemCellArray = nil

	self:StopCoroutine()
	self.view:OnDestroy()
end

function Panel:Refresh(roleCid)
	self:_Refresh(roleCid)
	self:PlayInAnimation()

	if self.currentEnabledItem then
		self.currentEnabledItem:UnEnabledOutLine()

		self.currentEnabledItem = nil
	end
end

function Panel:__ChangeDataRefresh()
	self:__RefreshActiveItem()
end

function Panel:_Refresh(roleCid)
	self.roleCid = roleCid

	self:SetRoleImage()

	local cfgHero = CfgUtil.GetCfgHeroDataWithID(self.roleCid)

	LuaUtility.SetGameObjectShow(self.view.windRoot, false)
	LuaUtility.SetGameObjectShow(self.view.fireRoot, false)
	LuaUtility.SetGameObjectShow(self.view.thunderRoot, false)
	LuaUtility.SetGameObjectShow(self.view.waterRoot, false)

	if cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WIND then
		LuaUtility.SetGameObjectShow(self.view.windRoot, true)
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_FIRE then
		LuaUtility.SetGameObjectShow(self.view.fireRoot, true)
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_THUNDER then
		LuaUtility.SetGameObjectShow(self.view.thunderRoot, true)
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WATER then
		LuaUtility.SetGameObjectShow(self.view.waterRoot, true)
	end

	self:__RefreshActiveItem()
end

function Panel:__RefreshActiveItem()
	LuaUtility.SetGameObjectShow(self.view.effect_canActive, false)

	local cfgHero = CfgUtil.GetCfgHeroDataWithID(self.roleCid)
	local warlockData = WarlockModule.WarlockDataDic[self.roleCid]
	local personalityDataList = warlockData:GetPersonalityDataList()
	local isNextActive = false

	for i = 1, maxPersonalityLevel do
		if i == 1 then
			isNextActive = personalityDataList[i].isOpen == false
		else
			isNextActive = personalityDataList[i].isOpen == false and personalityDataList[i - 1].isOpen == true
		end

		self.activeItemList[cfgHero.Elements][i]:Refresh(personalityDataList[i], isNextActive)
	end

	if self.isRightPanelShow then
		self:RefreshRightPanelShow(self.currentPersonalityData)
	end
end

function Panel:RefreshRightPanelShow(personalityData)
	self.isCanActive = false
	self.currentPersonalityData = personalityData

	local cfgPersonality = personalityData.config

	LuaUtility.SetText(self.view.Num, BattleUIApi:GetBattleActionOrderText(personalityData.index))
	LuaUtility.SetText(self.view.Name, cfgPersonality.Name)
	LuaUtility.SetText(self.view.DescribeText, cfgPersonality.PersonalityTips)
	LuaUtility.SetGameObjectShow(self.view.activeMatRoot, false)
	LuaUtility.SetGameObjectShow(self.view.isActive, false)
	LuaUtility.SetGameObjectShow(self.view.NeedActive, false)
	LuaUtility.SetGameObjectShow(self.view.CanActive, false)

	if personalityData.isOpen then
		LuaUtility.SetGameObjectShow(self.view.isActive, true)
	else
		if personalityData.isLock then
			LuaUtility.SetGameObjectShow(self.view.NeedActive, true)
			LuaUtility.SetText(self.view.NeedActiveText, WarlockModule.WarlockDataDic[self.roleCid]:GetPersonalityDataList()[personalityData.index - 1].config.Name)
		else
			LuaUtility.SetGameObjectShow(self.view.CanActive, true)
		end

		LuaUtility.SetGameObjectShow(self.view.activeMatRoot, true)

		local len = #cfgPersonality.NeedItem
		local index = 1

		for i = 1, len, 2 do
			local cell = self:_GetItemCell(index)

			cell:SetItemByCid(cfgPersonality.NeedItem[i], 0)

			local haveNum = WarehouseModule.GetItemNumByCfgID(cfgPersonality.NeedItem[i])

			cell:SetCostAllNumberShow(haveNum, cfgPersonality.NeedItem[i + 1])
			cell:Show()

			self.isCanActive = haveNum >= cfgPersonality.NeedItem[i + 1]
			index = index + 1
		end

		for i = index, #self.itemCellArray do
			self.itemCellArray[i]:Hide()
		end
	end
end

function Panel:_GetItemCell(index)
	if not self.itemCellArray[index] then
		local o = GameObject.Instantiate(self.view.ItemCellPrefab, self.view.activeMatRoot.transform)

		self.itemCellArray[index] = ItemCell.New(o)
	end

	return self.itemCellArray[index]
end

function Panel:SetRightPanelShow(show)
	if self.isRightPanelShow == show then
		return
	end

	LuaUtility.SetGameObjectShow(self.view.rightPanelRoot, show)
	self:PlayClickItemAnimation(show)

	self.isRightPanelShow = show

	EventDispatcher.Dispatch(EventID.SetRoleDevelopmentPanelLeftContentShow, not show)
end

function Panel:PlayClickItemAnimation(isEnter)
	local cfgHero = CfgUtil.GetCfgHeroDataWithID(self.roleCid)

	if not cfgHero then
		return
	end

	if isEnter then
		if cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WIND then
			LuaUtility.PlayAnimation(self.view.windRoot, "PersonalityPanel_Enter_1")
		elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_FIRE then
			LuaUtility.PlayAnimation(self.view.fireRoot, "PersonalityPanel_Enter_2")
		elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_THUNDER then
			LuaUtility.PlayAnimation(self.view.thunderRoot, "PersonalityPanel_Enter")
		elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WATER then
			LuaUtility.PlayAnimation(self.view.waterRoot, "PersonalityPanel_Enter_3")
		end
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WIND then
		LuaUtility.PlayAnimation(self.view.windRoot, "PersonalityPanel_Out_1")
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_FIRE then
		LuaUtility.PlayAnimation(self.view.fireRoot, "PersonalityPanel_Out_2")
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_THUNDER then
		LuaUtility.PlayAnimation(self.view.thunderRoot, "PersonalityPanel_Out")
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WATER then
		LuaUtility.PlayAnimation(self.view.waterRoot, "PersonalityPanel_Out_3")
	end
end

function Panel:PlayActiveAnimation(personalityId)
	for type, itemList in pairs(self.activeItemList) do
		for i, v in pairs(itemList) do
			if v.data and v.data.id == personalityId then
				v:PlayActiveAnimation()
			end
		end
	end
end

function Panel:PlayInAnimation()
	local cfgHero = CfgUtil.GetCfgHeroDataWithID(self.roleCid)

	if not cfgHero then
		return
	end

	if cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WIND then
		LuaUtility.PlayAnimation(self.view.windRoot, "PersonalityPanel_In_1", function()
			self:InAnimationCallback(true)
		end, function()
			self:InAnimationCallback(false)
		end)
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_FIRE then
		LuaUtility.PlayAnimation(self.view.fireRoot, "PersonalityPanel_In_2", function()
			self:InAnimationCallback(true)
		end, function()
			self:InAnimationCallback(false)
		end)
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_THUNDER then
		LuaUtility.PlayAnimation(self.view.thunderRoot, "PersonalityPanel_In", function()
			self:InAnimationCallback(true)
		end, function()
			self:InAnimationCallback(false)
		end)
	elseif cfgHero.Elements == Constant.ElementType.ELEMENT_TYPE_WATER then
		LuaUtility.PlayAnimation(self.view.waterRoot, "PersonalityPanel_In_3", function()
			self:InAnimationCallback(true)
		end, function()
			self:InAnimationCallback(false)
		end)
	end
end

function Panel:InAnimationCallback(isStart)
	local cfgHero = CfgUtil.GetCfgHeroDataWithID(self.roleCid)

	for i = 1, maxPersonalityLevel do
		self.activeItemList[cfgHero.Elements][i]:SetButtonState(not isStart)
	end
end

function Panel:GetOutLineMat()
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

function Panel:SetRoleImage()
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

function Panel:OnLoadImageSucess(assetName, asset, duration, userData)
	userData.gameObject:SetActive(true)

	local img = userData:GetComponent("Image")

	img:SetNativeSize()
	LuaUtility.SetImageRectTransformPivot(userData:GetComponent("RectTransform"), img)
	LuaUtility.SetAnchoredPositionWithRectTransform(userData:GetComponent("RectTransform"), 0, 0)
end

function Panel:OnItemClick(item, index)
	if self.currentEnabledItem then
		self.currentEnabledItem:UnEnabledOutLine()

		self.currentEnabledItem = nil
	end

	item:EnabledOutLine()

	self.currentEnabledItem = item
	self.currentEnabledIndex = index + 1
end

function Panel:SetCanActiveEffectShow(transParent)
	self.effect_canActiveTrans:SetParent(transParent)
	LuaUtility.SetAnchoredPositionWithRectTransform(self.effect_canActiveTrans:GetComponent("RectTransform"), 0, 0)
	LuaUtility.SetGameObjectShow(self.view.effect_canActive, true)
end

function Panel:ActiveSuccessCallBack()
	self:__ChangeDataRefresh()

	if self.currentEnabledIndex > 0 and self.currentEnabledIndex <= maxPersonalityLevel then
		local cfgHero = CfgUtil.GetCfgHeroDataWithID(self.roleCid)

		self.activeItemList[cfgHero.Elements][self.currentEnabledIndex]:OnClickButton()
	end

	if self.currentEnabledItem then
		self.currentEnabledItem:EnabledOutLine()
	end
end

return Panel
