-- chunkname: @IQIGame\\UI\\Formation\\ItemCell\\FormationHeroHeadCell.lua

local m = {
	cumulativeTime = 0,
	IsGoIntoBattle = false,
	iterationTime = 0.1,
	limitTime = 0.1
}
local commonRoleStar = require("IQIGame.UI.Common.RoleStar.CommonRoleStar")

function m.New(view, mainUIController, fatherView)
	local obj = Clone(m)

	obj:Init(view, mainUIController, fatherView)

	return obj
end

function m:Init(view, mainUIController, fatherView)
	self.View = view
	self.MainUIController = mainUIController
	self.FatherView = fatherView

	LuaCodeInterface.BindOutlet(self.View, self)

	local dragButton = self.View:GetComponent("IQIGame.Onigao.Game.UIScrollAreaDragButton")

	function dragButton.onBeginDrag(eventData)
		self:OnBeginDrag(nil, eventData, nil)
	end

	function dragButton.onDrag(eventData)
		self:OnDrag(nil, eventData, LuaCodeInterface.GetPointerCurrentRaycast(eventData))
	end

	function dragButton.onEndDrag(eventData)
		self:OnEndDrag(nil, eventData, LuaCodeInterface.GetPointerCurrentRaycast(eventData))
	end

	function self.DelegateDragButtonClickProxy()
		FormationModule.ClickFormationHeroHeadInitRedDot(self.heroData.cid)
		self:RefreshRedDot()
		self.FatherView:RefreshTabRedDot()

		if FormationModule.FormationTypeIsMaze or StoryModule.IsStoring then
			NoticeModule.ShowNotice(12027)

			return
		end

		UIModule.Open(Constant.UIControllerName.RoleDevelopmentPanel, Constant.UILayer.UI, {
			hideHomeButton = true,
			roleCid = self.heroData.cid
		})
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

	function self.DelegateOnPointerDown(go, eventData)
		self:OnPointerDown(go, eventData)
	end

	function self.DelegateOnPointerUp(go, eventData)
		self:OnPointerUp(go, eventData)
	end

	function self.DelegateOnGoDownBattleSuccessEvent(heroCid)
		self:OnGoDownBattleSuccessEvent(heroCid)
	end

	function self.DelegateFormationDragStateChageEvent(state)
		self:FormationDragStateChageEvent(state)
	end

	function self.DelegateOnHeroAttrChangeEvent(heros)
		self:OnHeroAttrChangeEvent()
	end

	self.DragRootRectTransform = self.DragRoot:GetComponent("RectTransform")
	self.LastPosition = self.DragRoot.transform.localPosition
	self.grayComponent = self.View:GetComponent("GrayComponent")
	self.DragImgCom = self.DragRoot:GetComponent("Image")
	self.commonRoleStar = commonRoleStar.New(self.CommonRoleStar)

	self:AddListeners()
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.GoDownBattleSuccessEvent, self.DelegateOnGoDownBattleSuccessEvent)
	EventDispatcher.AddEventListener(EventID.FormationDragStateChageEvent, self.DelegateFormationDragStateChageEvent)
	EventDispatcher.AddEventListener(EventID.RoleUpdateData, self.DelegateOnHeroAttrChangeEvent)
	self.View:GetComponent("IQIGame.Onigao.Game.UIScrollAreaDragButton").onClick:AddListener(self.DelegateDragButtonClickProxy)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.GoDownBattleSuccessEvent, self.DelegateOnGoDownBattleSuccessEvent)
	EventDispatcher.RemoveEventListener(EventID.FormationDragStateChageEvent, self.DelegateFormationDragStateChageEvent)
	EventDispatcher.RemoveEventListener(EventID.RoleUpdateData, self.DelegateOnHeroAttrChangeEvent)
	self.View:GetComponent("IQIGame.Onigao.Game.UIScrollAreaDragButton").onClick:RemoveListener(self.DelegateDragButtonClickProxy)
end

function m:SetData(heroData)
	self.heroData = heroData

	self:RefreshHeroInfo()
	self:InitCellState()
	self:RefreshRedDot()
end

function m:RefreshHeroInfo()
	self.commonRoleStar:RefreshStar(self.heroData)

	local heroTable = CfgHeroTable[self.heroData.cid]

	AssetUtil.LoadImage(self, self.heroData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesHead), self.RoleImage:GetComponent("Image"))
	AssetUtil.LoadImage(self, WarlockApi:GetBoxHeroKuangImagePath(heroTable.Quality), self.QualityFarmImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, WarlockApi:GetElementIconPath(heroTable.Elements), self.ElementImage:GetComponent("Image"))
	AssetUtil.LoadImage(self, WarlockApi:GetProfessionIconPath(heroTable.Profession), self.ProfessionImage:GetComponent("Image"))
	UGUIUtil.SetText(self.LvText, "Lv." .. self.heroData.lv)
	UGUIUtil.SetText(self.NameText, heroTable.Name)
	self.grayComponent:SetGray(self.heroData:HeroIsDead())
end

function m:InitCellState()
	local isGoInto, index = FormationModule.CheckIsHasSameCid(self.heroData.cid)
	local isOhterHero = false

	if index ~= -1 then
		isOhterHero = FormationModule.CurFormationDataList[index].isHelpHeroData or FormationModule.CurFormationDataList[index].isTempHeroData
	end

	if isGoInto and isOhterHero == false then
		self:OnSelect()

		self.IsGoIntoBattle = true
	else
		self:OnCancelSelect()
	end

	self.DragRoot.transform.localPosition = self.LastPosition

	if self.heroEntity ~= nil then
		GameEntry.Entity:HideEntity(self.heroEntity)

		self.heroEntity = nil
	end
end

function m:ShowDragHero()
	self:LoadHeroEntity()
end

function m:OnBeginDrag(go, eventData, eventData_go)
	EventDispatcher.Dispatch(EventID.ShowFormationBoxCellCanDragEffect, -999, false)
	EventDispatcher.Dispatch(EventID.ExChangeBoxDataEvent, true, -999)

	if self.IsGoIntoBattle then
		return
	end

	if self.heroData:HeroIsDead() then
		return
	end

	self:ShowDragHero()
	EventDispatcher.Dispatch(EventID.FormationHeroOnLongClickEvent, false)
	EventDispatcher.Dispatch(EventID.FormationDragStateChageEvent, true)
end

function m:OnDrag(go, eventData, eventData_go)
	if self.IsGoIntoBattle then
		return
	end

	if self.heroData:HeroIsDead() then
		return
	end

	UGUIUtil.ScreenPointToWorldPointInRectangle(self.DragRootRectTransform, eventData)

	local index = FormationModule.CheckEndDragGridIndex(eventData_go)

	if index < 0 then
		EventDispatcher.Dispatch(EventID.ExChangeBoxDataEvent, true, -999)
		EventDispatcher.Dispatch(EventID.ShowFormationBoxCellCanDragEffect, -999, false)

		return
	end

	local intoHeroData = FormationModule.CurFormationDataList[index]

	if intoHeroData == nil then
		EventDispatcher.Dispatch(EventID.ExChangeBoxDataEvent, true, -999)

		if table.len(FormationModule.CurFormationDataList) >= FormationModule.MaxFormationCount then
			EventDispatcher.Dispatch(EventID.ShowFormationBoxCellCanDragEffect, index, false)
		else
			EventDispatcher.Dispatch(EventID.ShowFormationBoxCellCanDragEffect, index, true)
		end

		return
	end

	if intoHeroData.isTempHeroData then
		EventDispatcher.Dispatch(EventID.ExChangeBoxDataEvent, true, -999)
		EventDispatcher.Dispatch(EventID.ShowFormationBoxCellCanDragEffect, index, false)

		return
	end

	EventDispatcher.Dispatch(EventID.ExChangeBoxDataEvent, true, index)
	EventDispatcher.Dispatch(EventID.ShowFormationBoxCellCanDragEffect, index, true)
end

function m:OnEndDrag(go, eventData, eventData_go)
	EventDispatcher.Dispatch(EventID.ExChangeBoxDataEvent, true, -999)
	EventDispatcher.Dispatch(EventID.ShowFormationBoxCellCanDragEffect, -999, false)

	if self.IsGoIntoBattle then
		return
	end

	if self.heroData:HeroIsDead() then
		return
	end

	EventDispatcher.Dispatch(EventID.FormationDragStateChageEvent, false)

	local index = FormationModule.CheckEndDragGridIndex(eventData_go)

	self.DragRoot.transform.localPosition = self.LastPosition

	if index == -1 then
		self:OnCancelSelect()

		self.IsGoIntoBattle = false
	else
		if table.len(FormationModule.CurFormationDataList) >= FormationModule.MaxFormationCount and FormationModule.CurFormationDataList[index] == nil then
			NoticeModule.ShowNotice(20008)

			goto label_23_0
		elseif FormationModule.CheckIsHasSameCid(self.heroData.cid) == true then
			NoticeModule.ShowNotice(49010)

			goto label_23_0
		end

		if FormationModule.GetTerrainIsCanGointo(index, true).Used == Constant.FormationGointoBattleType.BAN then
			-- block empty
		else
			self:OnSelect()

			self.IsGoIntoBattle = true

			FormationModule.UpdateCurFormationData(index, self.heroData)
			FormationModule.NotifyFormationChange()
		end
	end

	::label_23_0::

	EntityUtility.SetEntityVisibleByEntityID(self.uniqueEntityID, false)
end

function m:OnPointerDown(go, eventData)
	self.cumulativeTime = 0
	self.timer = Timer.New(function()
		self.cumulativeTime = self.cumulativeTime + self.iterationTime
	end, self.iterationTime, -1)

	self.timer:Start()
end

function m:OnPointerUp(go, eventData)
	if self.cumulativeTime <= self.limitTime then
		-- block empty
	end

	if self.timer ~= nil then
		self.timer:Stop()
	end
end

function m:LoadHeroEntity()
	CoroutineUtility.StartCoroutine(function()
		if self.heroEntity ~= nil then
			self.HeroSpineGo = self.heroEntity.gameObject

			EntityUtility.SetEntityVisibleByEntityID(self.uniqueEntityID, true)
		else
			self.uniqueEntityID = GameEntry.Entity:GenerateEntityID()

			GameEntry.Entity:ShowBattleElement(self.uniqueEntityID, self.heroData.EntityID, 0, self.DragPoint.transform, Vector3.zero)

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
	end)
end

function m:RefreshSkeleton()
	local sortingOrder = self.MainUIController:GetComponent("Canvas").sortingOrder + 10

	EntityUtility.BattleSpineToUIShow(self.HeroSpineGo, sortingOrder, false, 0, "idle")

	self.HeroSpineGo.transform.localScale = Vector3.New(100, 100, 1)
	self.HeroSpineGo.transform.localPosition = Vector3.zero
end

function m:OnGoDownBattleSuccessEvent(heroCid)
	if self.heroData.cid == heroCid then
		self:OnCancelSelect()
	end
end

function m:FormationDragStateChageEvent(state)
	self.DragImgCom.enabled = not state
end

function m:OnHeroAttrChangeEvent()
	self.heroData = WarlockModule.WarlockDataDic[self.heroData.cid]

	self:RefreshHeroInfo()
end

function m:OnSelect()
	self.SelectParent:SetActive(true)
end

function m:OnCancelSelect()
	self.SelectParent:SetActive(false)

	self.IsGoIntoBattle = false
end

function m:Dispose()
	self:RemoveListeners()
	self.commonRoleStar:Dispose()

	if self.heroEntity ~= nil and self.uniqueEntityID ~= nil then
		EntityUtility.HideEntitySafelyByEntityID(self.uniqueEntityID)

		self.heroEntity = nil
	end

	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:RefreshRedDot()
	LuaUtility.SetGameObjectShow(self.RedDot_91000, RedDotModule.CheckRedDot_GameFormationView_Item(self.heroData.cid))
end

return m
