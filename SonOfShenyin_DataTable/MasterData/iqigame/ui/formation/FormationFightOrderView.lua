-- chunkname: @IQIGame\\UI\\Formation\\FormationFightOrderView.lua

local OrderCell = {}

function OrderCell.New(view, battleActionOrderFollower)
	local obj = Clone(OrderCell)

	obj:__Init(view, battleActionOrderFollower)

	return obj
end

function OrderCell:__Init(view, battleActionOrderFollower)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__InitEventDelegate()

	self.battleActionOrderFollower = battleActionOrderFollower
	self.rectTransform = self.gameObject:GetComponent(typeof(UnityEngine.RectTransform))

	self:__AddListener()
end

function OrderCell:__InitEventDelegate()
	function self.delegateOnLongDown()
		if self.OnDragBeginEvent == nil then
			return
		end

		self.OnDragBeginEvent(self)
	end

	function self.delegateOnLongDownClick()
		if self.OnDragEvent ~= nil then
			self.OnDragEvent(self)
		end
	end

	function self.delegateOnLongDownEnd()
		if self.OnDragEndEvent == nil then
			return
		end

		self.OnDragEndEvent(self)
	end

	function self.delegateOnClick()
		if FormationModule.FormationTypeIsMaze or StoryModule.IsStoring then
			NoticeModule.ShowNotice(12027)

			return
		end

		UIModule.Open(Constant.UIControllerName.RoleDevelopmentPanel, Constant.UILayer.UI, {
			hideHomeButton = true,
			roleCid = self.heroCid
		})
	end
end

function OrderCell:__AddListener()
	local longButton = self.gameObject:GetComponent(typeof(LongButton))

	longButton.delay = 0.3
	longButton.clickInterval = 0.03

	longButton.onClick:AddListener(self.delegateOnClick)
	longButton.onLongDown:AddListener(self.delegateOnLongDown)
	longButton.onLongDownClick:AddListener(self.delegateOnLongDownClick)

	longButton.onLongDownEnd = self.delegateOnLongDownEnd
end

function OrderCell:__RemoveListener()
	local longButton = self.gameObject:GetComponent(typeof(LongButton))

	longButton.onClick:RemoveListener(self.delegateOnClick)
	longButton.onLongDown:RemoveListener(self.delegateOnLongDown)
	longButton.onLongDownClick:RemoveListener(self.delegateOnLongDownClick)

	longButton.onLongDownEnd = nil
end

function OrderCell:Show(heroData, order)
	self.gameObject:SetActive(true)

	self.heroCid = heroData.heroCid

	self:SetOrder(order)
	self:__RefreshHeadShow()
end

function OrderCell:__RefreshHeadShow()
	local warlockData = FormationModule.GetCurFormationHeroData(self.heroCid)

	if warlockData == nil then
		logError("布阵角色数据查询错误 HeroCid ---->> {0}", self.heroCid)
	else
		local skinPath = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(warlockData.heroSkin.skinCid, Constant.SkinImageType.HeroResourcesHead)

		AssetUtil.LoadImage(self, skinPath, self.RoleImage:GetComponent("Image"))
		UGUIUtil.SetText(self.LvText, "Lv." .. warlockData.lv)
	end

	local heroTable = CfgHeroTable[self.heroCid]

	AssetUtil.LoadImage(self, WarlockApi:GetBoxHeroKuangImagePath(heroTable.Quality), self.QualityFarmImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, WarlockApi:GetElementIconPath(heroTable.Elements), self.ElementImage:GetComponent("Image"))
	AssetUtil.LoadImage(self, WarlockApi:GetProfessionIconPath(heroTable.Profession), self.ProfessionImage:GetComponent("Image"))
	UGUIUtil.SetText(self.NameText, heroTable.Name)
end

function OrderCell:Hide()
	self.gameObject:SetActive(false)
end

function OrderCell:SetOrder(order)
	self.order = order

	self.battleActionOrderFollower:SetOrder(order)
end

function OrderCell:ResetOrderBySiblingIndex()
	local index = self.gameObject.transform:GetSiblingIndex()

	self.order = index + 1
end

function OrderCell:SetPosition(position)
	self.gameObject.transform.position = position
end

function OrderCell:Dispose()
	self:__RemoveListener()

	self.rectTransform = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	UnityEngine.Object.Destroy(self.battleActionOrderFollower)
	UnityEngine.Object.Destroy(self.gameObject)

	self.gameObject = nil
end

local FormationFightOrderView = {
	orderCellTable = {}
}

function FormationFightOrderView.New(view)
	local obj = Clone(FormationFightOrderView)

	obj:__Init(view)

	return obj
end

function FormationFightOrderView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.followerMonoGameObject = UnityEngine.GameObject.New("BattleTeamActionsFollower")

	self.positionPanel.gameObject:SetActive(false)

	self.teamActionParentRectTransform = self.teamActionParent:GetComponent(typeof(UnityEngine.RectTransform))

	self.fightOrderPrefab.gameObject:SetActive(false)
end

function FormationFightOrderView:Show()
	self.gameObject:SetActive(true)
	self:__RefreshShow()
end

function FormationFightOrderView:Refresh()
	if not self.gameObject.activeSelf then
		return
	end

	self:__RefreshShow()
end

function FormationFightOrderView:__RefreshShow()
	local cellIndex = 1

	for order, heroData in pairs(FormationModule.GetAllAttackOrderList()) do
		local cell = self.orderCellTable[cellIndex]

		if cell == nil then
			cell = self:__CreateBattleUnitActionItem()
			self.orderCellTable[cellIndex] = cell
		end

		cell:Show(heroData, order)

		local target = self.positionPanel.transform:GetChild(order - 1)

		cell:SetPosition(target.transform.position)

		cellIndex = cellIndex + 1
	end

	self.orderCellCount = cellIndex - 1

	for i = cellIndex, #self.orderCellTable do
		self.orderCellTable[i]:Hide()
	end
end

function FormationFightOrderView:Hide()
	self.gameObject:SetActive(false)
end

function FormationFightOrderView:Dispose()
	if self.followerMonoGameObject ~= nil then
		GameObject.Destroy(self.followerMonoGameObject)
	end

	self.followerMonoGameObject = nil
	self.teamActionParentRectTransform = nil

	ForPairs(self.orderCellTable, function(_, _cell)
		_cell:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function FormationFightOrderView:__CreateBattleUnitActionItem()
	local heroObj = UnityEngine.Object.Instantiate(self.fightOrderPrefab)

	heroObj.transform:SetParent(self.teamActionParent.transform, false)

	local battleActionOrderFollower = self.followerMonoGameObject:AddComponent(typeof(BattleActionOrderFollower))

	battleActionOrderFollower:Init(heroObj.transform, self.positionPanel.transform)

	local orderCell = OrderCell.New(heroObj, battleActionOrderFollower)

	function orderCell.OnDragBeginEvent(item)
		self:__OnActionItemBeginDrag(item)
	end

	function orderCell.OnDragEvent(item)
		self:__OnActionItemDragging(item)
	end

	function orderCell.OnDragEndEvent(item)
		self:__OnActionItemDragEnd(item)
	end

	return orderCell
end

function FormationFightOrderView:__OnActionItemBeginDrag(viewItem)
	viewItem.battleActionOrderFollower.enabled = false
end

function FormationFightOrderView:__OnActionItemDragging(viewItem)
	local isInRect, localPoint = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.teamActionParentRectTransform, UnityEngine.Input.mousePosition, GameEntry.UICamera, nil)

	localPoint.x = localPoint.x + self.teamActionParentRectTransform.rect.w / 2
	localPoint.x = math.clamp(localPoint.x, 0, self.teamActionParentRectTransform.rect.w)
	localPoint.y = math.clamp(localPoint.y, -self.teamActionParentRectTransform.rect.h * 0.5, self.teamActionParentRectTransform.rect.h * 0.5)
	viewItem.rectTransform.anchoredPosition = localPoint

	local currentAreaOrder, _ = math.modf(localPoint.x / 100) + 1

	if currentAreaOrder > self.orderCellCount then
		currentAreaOrder = self.orderCellCount
	end

	if currentAreaOrder == viewItem.order then
		return
	end

	local moveRight = currentAreaOrder < viewItem.order

	viewItem:SetOrder(currentAreaOrder)
	ForPairs(self.orderCellTable, function(_, _orderCell)
		if _orderCell == viewItem then
			return
		end

		if _orderCell.order ~= currentAreaOrder then
			return
		end

		if moveRight then
			_orderCell:SetOrder(_orderCell.order + 1)
		else
			_orderCell:SetOrder(_orderCell.order - 1)
		end
	end)
end

function FormationFightOrderView:__OnActionItemDragEnd(viewItem)
	viewItem.battleActionOrderFollower.enabled = true

	local attackOrderList = {}

	ForPairs(self.orderCellTable, function(_, _orderCell)
		_orderCell:ResetOrderBySiblingIndex()

		attackOrderList[_orderCell.heroCid] = _orderCell.order
	end)

	FormationModule.AllAttackOrder = attackOrderList

	if not FormationModule.FormationTypeIsMaze then
		FormationModule.FormationDataList[FormationModule.TeamIndex].attackOrder = attackOrderList
	end

	FormationModule.NotifyFormationChange()
end

return FormationFightOrderView
