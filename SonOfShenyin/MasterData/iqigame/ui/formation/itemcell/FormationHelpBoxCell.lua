-- chunkname: @IQIGame\\UI\\Formation\\ItemCell\\FormationHelpBoxCell.lua

local m = {
	IsSelectHelpHero = false
}

function m.New(view, mainUIController)
	local obj = Clone(m)

	obj:Init(view, mainUIController)

	return obj
end

function m:Init(view, mainUIController)
	self.View = view
	self.MainUIController = mainUIController

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickOpenHelpUI()
		self:OnClickOpenHelpUI()
	end

	function self.DelegateOnClickChangeHeroBtn()
		self:OnClickChangeHeroBtn()
	end

	function self.DelegateOnBeginDrag(go, eventData, eventData_go)
		self:OnBeginDrag(go, eventData, eventData_go)
	end

	function self.DelegateOnDrag(go, eventData, eventData_go)
		self:OnDrag(go, eventData, eventData_go)
	end

	function self.DelegateOnEndDrag(go, eventData, eventData_go)
		self:OnEndDrag(go, eventData, eventData_go)
	end

	function self.DelegateOnHelpHeroGoDownEvent()
		self:OnHelpHeroGoDownEvent()
	end

	function self.DelegateOnHelpHeroGoIntoEvent()
		self:OnHelpHeroGoIntoEvent()
	end

	self.eventTrigger = UGUIUtil.GetEventTriggerListener(self.HeroRoot)
	self.eventTrigger._onBeginDrag = self.eventTrigger._onBeginDrag + self.DelegateOnBeginDrag
	self.eventTrigger._onDrag = self.eventTrigger._onDrag + self.DelegateOnDrag
	self.eventTrigger._onEndDrag = self.eventTrigger._onEndDrag + self.DelegateOnEndDrag
	self.HeroRootRectTransform = self.HeroRoot:GetComponent("RectTransform")
	self.LastPosition = self.HeroRoot.transform.localPosition

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickOpenHelpUI)
	self.ChangeHeroBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChangeHeroBtn)
	EventDispatcher.AddEventListener(EventID.HelpHeroGoDownEvent, self.DelegateOnHelpHeroGoDownEvent)
	EventDispatcher.AddEventListener(EventID.HelpHeroGoIntoEvent, self.DelegateOnHelpHeroGoIntoEvent)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickOpenHelpUI)
	self.ChangeHeroBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChangeHeroBtn)
	EventDispatcher.RemoveEventListener(EventID.HelpHeroGoDownEvent, self.DelegateOnHelpHeroGoDownEvent)
	EventDispatcher.RemoveEventListener(EventID.HelpHeroGoIntoEvent, self.DelegateOnHelpHeroGoIntoEvent)
end

function m:SetData(helpHeroData)
	if self.heroEntity ~= nil then
		GameEntry.Entity:HideEntity(self.heroEntity)

		self.heroEntity = nil
	end

	self.IsGoIntoBattle, self.index = FormationModule.GetCurFormationIsHasHelpHero()

	if self.heroData ~= nil and self.IsGoIntoBattle then
		self.IsReplaceHelpHero = true

		if FormationModule.CheckIsHasSameCid(helpHeroData.hero.cid) then
			NoticeModule.ShowNotice(49010)

			return
		end

		FormationModule.ClearCacheHelpHero()
		FormationModule.UpdateCurFormationData(FormationModule.HelpHeroIndex, helpHeroData)
		FormationModule.NotifyFormationChange()
	end

	self.heroData = helpHeroData

	self.HeroInfoParent:SetActive(true)
	self.CanHelpImg:SetActive(false)
	self.ChangeHeroBtn:SetActive(true)

	self.heroCid = self.heroData.hero.cid

	AssetUtil.LoadImage(self, self.heroData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesHead), self.HeroImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, WarlockApi:GetProfessionIconPath(self.heroData:GetCfg().Profession), self.ProfessionImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, WarlockApi:GetElementIconPath(self.heroData:GetCfg().Elements), self.ElementImg:GetComponent("Image"))
	UGUIUtil.SetText(self.LvTitle, "Lv.")
	UGUIUtil.SetText(self.LvText, self.heroData.lv)
	self:SetHeroGoIntoInfoState()
end

function m:OnBeginDrag(go, eventData, eventData_go)
	if self.IsGoIntoBattle or self.heroData == nil then
		return
	end

	EventDispatcher.Dispatch(EventID.FormationDragStateChageEvent, true)

	self.HeroRoot:GetComponent("Image").enabled = false

	CoroutineUtility.StartCoroutine(function()
		self:LoadHeroEntity()
	end)
end

function m:OnDrag(go, eventData, eventData_go)
	if self.IsGoIntoBattle or self.heroData == nil then
		return
	end

	UGUIUtil.ScreenPointToWorldPointInRectangle(self.HeroRootRectTransform, eventData)
end

function m:OnEndDrag(go, eventData, eventData_go)
	self.HeroRoot.transform.localPosition = self.LastPosition

	if self.IsGoIntoBattle or self.heroData == nil then
		return
	end

	EventDispatcher.Dispatch(EventID.FormationDragStateChageEvent, false)

	local index = FormationModule.CheckEndDragGridIndex(eventData_go)

	if index == -1 then
		-- block empty
	elseif FormationModule.CheckIsHasSameCid(self.heroData.cid) then
		NoticeModule.ShowNotice(49010)
	elseif FormationModule.GetIsMaxGointo() then
		NoticeModule.ShowNotice(20008)
	elseif FormationModule.CurFormationDataList[index] ~= nil and FormationModule.CurFormationDataList[index].isTempHeroData then
		NoticeModule.ShowNotice(49011)
	elseif FormationModule.GetTerrainIsCanGointo(index, true).Used == Constant.FormationGointoBattleType.BAN then
		-- block empty
	else
		FormationModule.ClearCacheHelpHero()
		FormationModule.UpdateCurFormationData(index, self.heroData)
		FormationModule.NotifyFormationChange()
	end

	EntityUtility.SetEntityVisibleByEntityID(self.uniqueEntityID, false)

	self.HeroRoot:GetComponent("Image").enabled = true
end

function m:OnPointerDown(go, eventData)
	return
end

function m:LoadHeroEntity()
	if self.heroEntity ~= nil then
		EntityUtility.SetEntityVisibleByEntityID(self.uniqueEntityID, true)

		self.HeroSpineGo = self.heroEntity.gameObject
	else
		self.uniqueEntityID = GameEntry.Entity:GenerateEntityID()

		local elementEntityCid = self.heroData:GetCurSpineElementEntityID()

		GameEntry.Entity:ShowBattleElement(self.uniqueEntityID, elementEntityCid, 0, self.HeroParent.transform, Vector3.zero)

		self.heroEntity = nil

		CoroutineUtility.Yield(function()
			while self.heroEntity == nil do
				self.heroEntity = GameEntry.Entity:GetEntity(self.uniqueEntityID)

				CoroutineUtility.Yield()
			end

			self.HeroSpineGo = self.heroEntity.gameObject

			self:RefreshSkeleton()
		end)
	end
end

function m:RefreshSkeleton()
	local sortingOrder = self.MainUIController:GetComponent("Canvas").sortingOrder + 5

	EntityUtility.BattleSpineToUIShow(self.HeroSpineGo, sortingOrder, false, 0, "idle")

	self.HeroSpineGo.transform.localScale = Vector3.New(100, 100, 1)
	self.HeroSpineGo.transform.localPosition = Vector3.zero
end

function m:InitHelpHeroInfo(isCanHelp)
	self.HeroInfoParent:SetActive(false)
	self.CanHelpImg:SetActive(isCanHelp)
	self.BanHelpParent:SetActive(not isCanHelp)

	self.heroCid = nil
	self.HeroRoot.transform.localPosition = self.LastPosition
	self.HeroRoot:GetComponent("Image").enabled = true

	self.GoDownInfo:SetActive(false)
	self.GoIntoInfo:SetActive(false)
	self.ChangeHeroBtn:SetActive(false)

	self.View:GetComponent("Button").enabled = isCanHelp
end

function m:OnClickOpenHelpUI()
	local maxLv = FormationModule.GetGointoListMaxLv()

	UIModule.Open(Constant.UIControllerName.AssistInFigChooseUI, Constant.UILayer.UI, maxLv)
end

function m:OnClickChangeHeroBtn()
	local maxLv = FormationModule.GetGointoListMaxLv()

	UIModule.Open(Constant.UIControllerName.AssistInFigChooseUI, Constant.UILayer.UI, maxLv)
end

function m:OnHelpHeroGoDownEvent()
	self:SetHeroGoIntoInfoState()
end

function m:OnHelpHeroGoIntoEvent()
	self:SetHeroGoIntoInfoState()
end

function m:SetHeroGoIntoInfoState()
	self.IsGoIntoBattle, self.index = FormationModule.GetCurFormationIsHasHelpHero()

	if self.IsGoIntoBattle == false then
		self.GoDownInfo:SetActive(false)
		self.GoIntoInfo:SetActive(false)
	else
		self.GoDownInfo:SetActive(not self.IsGoIntoBattle)
		self.GoIntoInfo:SetActive(self.IsGoIntoBattle)
	end
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	if self.heroEntity ~= nil and self.uniqueEntityID ~= nil then
		EntityUtility.HideEntitySafelyByEntityID(self.uniqueEntityID)

		self.heroEntity = nil
	end

	self:RemoveListeners()

	self.heroCid = nil
	self.IsSelectHelpHero = false
	self.heroData = nil
	self.IsReplaceHelpHero = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
