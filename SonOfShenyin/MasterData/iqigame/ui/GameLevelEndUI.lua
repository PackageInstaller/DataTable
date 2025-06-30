-- chunkname: @IQIGame\\UI\\GameLevelEndUI.lua

local UnitRewardPopupItem = {
	awardItems = {}
}

function UnitRewardPopupItem.New(view)
	local obj = Clone(UnitRewardPopupItem)

	obj:__Init(view)

	return obj
end

function UnitRewardPopupItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.awardItems = {}

	local childCount = self.itemsRoot.transform.childCount

	for i = 1, childCount do
		local child = self.itemsRoot.transform:GetChild(i - 1)
		local itemCell = ItemCell.New(child.gameObject, true, true, true)

		table.insert(self.awardItems, itemCell)
	end
end

function UnitRewardPopupItem:Show(index, data)
	local expNum = 0
	local itemIndex = 1

	ForPairs(data.awards, function(_, awardItem)
		if awardItem.cid == Constant.ItemCid.Exp then
			expNum = expNum + awardItem.num

			return
		end

		local itemCell = self.awardItems[itemIndex]

		if itemCell == nil then
			return true
		end

		itemIndex = itemIndex + 1

		local itemData = WarehouseModule.GetItemDataById(awardItem.id)

		if itemData == nil then
			itemCell:Hide()
		else
			itemCell:SetItem(itemData)
			itemCell:SetTag(awardItem.tag)
			itemCell:SetNum(awardItem.num)
		end
	end)

	for i = itemIndex, #self.awardItems do
		self.awardItems[i]:Hide()
	end

	self.titleText.gameObject:GetComponent("Text").text = GameLevelEndUIApi:GetUnitAwardTitle(index)
	self.expText.gameObject:GetComponent("Text").text = GameLevelEndUIApi:GetUnitAwardExpText(expNum)
end

function UnitRewardPopupItem:Hide()
	self.gameObject:SetActive(false)
end

function UnitRewardPopupItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil

	for i = 1, #awardItems do
		self.awardItems[i]:Dispose()
	end
end

local UnitRewardPopupView = {}

function UnitRewardPopupView.New(view)
	local obj = Clone(UnitRewardPopupView)

	obj:__Init(view)

	return obj
end

function UnitRewardPopupView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.delegateOnRenderCell(cell)
		self:__OnRenderCell(cell)
	end

	function self.delegateOnClose()
		self:Hide()
	end

	local scrollAreaList = self.scrollArea:GetComponent("ScrollAreaList")

	scrollAreaList.onRenderCell = self.delegateOnRenderCell
end

function UnitRewardPopupView:InitData(everyTimeAwards)
	self.awardsList = {}

	for _fightIndex, _awards in pairs(everyTimeAwards) do
		table.insert(self.awardsList, _awards)
	end

	return #self.awardsList > 1
end

function UnitRewardPopupView:Show()
	self.bgButton:GetComponent("Button").onClick:AddListener(self.delegateOnClose)
	self.gameObject:SetActive(true)

	self.itemCells = {}

	local wrapContent = self.scrollArea:GetComponent("ScrollAreaList")

	wrapContent:Refresh(#self.awardsList)
end

function UnitRewardPopupView:Hide()
	self.bgButton:GetComponent("Button").onClick:RemoveListener(self.delegateOnClose)
	self.gameObject:SetActive(false)
end

function UnitRewardPopupView:__OnRenderCell(cell)
	local insID = cell.gameObject:GetInstanceID()
	local item = self.itemCells[insID]

	if item == nil then
		item = UnitRewardPopupItem.New(cell.gameObject)
		self.itemCells[insID] = item
	end

	local index = cell.index + 1
	local itemData = self.awardsList[index]

	if itemData == nil then
		item:Hide()
	else
		item:Show(index, itemData)
	end
end

function UnitRewardPopupView:Dispose()
	self.bgButton:GetComponent("Button").onClick:RemoveListener(self.delegateOnClose)

	if self.itemCells ~= nil then
		for i = 1, #self.itemCells do
			self.itemCells[i]:Dispose()
		end
	end

	self.itemCells = nil
	self.awardsList = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local GameLevelEndUI = Base:Extend("GameLevelEndUI", "IQIGame.Onigao.UI.GameLevelEndUI", {
	itemList = {},
	failedJumpItems = {}
})

function GameLevelEndUI:OnInit()
	LuaCodeInterface.BindOutlet(self.ConfirmBtn, self)

	function self.DelegateUpdateItem(cell)
		self:UpdateItem(cell)
	end

	function self.DelegateGetUserInfoResult(baseInfo)
		self:GetUserInfoResult(baseInfo)
	end

	function self.DelegateOnClickCancelBtn()
		self:OnClickCancelBtn()
	end

	function self.DelegateOnClickAddFriendBtn()
		self:OnClickAddFriendBtn()
	end

	function self.DelegateConfrimBtn()
		self:OnClickConfrimBtn()
	end

	function self.delegateOnUnitRewardButtonClick()
		self:OnUnitRewardButtonClick()
	end

	local wrapContent = self.ItemContainer:GetComponent("ScrollAreaList")

	wrapContent.onRenderCell = self.DelegateUpdateItem
	self.AddFriendPanelTween = self.AddFriendPanel:GetComponent("TweenPosition")

	UGUIUtil.SetTextsInChildren(self.CancelBtn, GameLevelEndUIApi:GetCancelText())
	UGUIUtil.SetText(self.AddFriendTitle, GameLevelEndUIApi:GetAddFriendTitle())
	UGUIUtil.SetText(self.ReturnTitle, GameLevelEndUIApi:GetReturnTitle())
	UGUIUtil.SetText(self.PlayerLvTitle, GameLevelEndUIApi:GetPlayerLvTitle())
	self:CreateTipsItem()

	self.unitRewardPopupView = UnitRewardPopupView.New(self.unitRewardPopup)

	self.unitRewardPopupView:Hide()
end

function GameLevelEndUI:GetPreloadAssetPaths()
	return nil
end

function GameLevelEndUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GameLevelEndUI:IsManualShowOnOpen(userData)
	return false
end

function GameLevelEndUI:GetBGM(userData)
	return nil
end

function GameLevelEndUI:OnOpen(userData)
	self.fightInfo = userData.fightOverPOD
	self.callBack = userData.func
	self.getExpNum = 0

	local showAward = {}

	for _, v in pairs(self.fightInfo.awards) do
		if CfgItemTable[v.cid].IsHide ~= 1 then
			table.insert(showAward, v)
		end
	end

	self.RawItemDatas = self:ScreenAndPickExpItem(showAward)

	self.RewardPanel:SetActive(table.len(self.RawItemDatas) > 0 or self.getExpNum > 0)

	if self.fightInfo.fightResult == Constant.FightResult.ATTACKER_WIN then
		self:FightSucess()
	else
		self:FightFailed()
	end

	local needShow = self.unitRewardPopupView:InitData(userData.fightOverPOD.everyTimeAwards)

	self.unitAwardButton:SetActive(needShow)
	self.unitRewardPopupView:Hide()
end

function GameLevelEndUI:OnClose(userData)
	self.AddFriendPanelTween:ResetToBeginning()
end

function GameLevelEndUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateConfrimBtn)
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCancelBtn)
	self.AddFriendBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAddFriendBtn)
	EventDispatcher.AddEventListener(EventID.GetPlayerInfoResult, self.DelegateGetUserInfoResult)
	self.unitAwardButton:GetComponent("Button").onClick:AddListener(self.delegateOnUnitRewardButtonClick)
end

function GameLevelEndUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateConfrimBtn)
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCancelBtn)
	self.AddFriendBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAddFriendBtn)
	EventDispatcher.RemoveEventListener(EventID.GetPlayerInfoResult, self.DelegateGetUserInfoResult)
	self.unitAwardButton:GetComponent("Button").onClick:RemoveListener(self.delegateOnUnitRewardButtonClick)
end

function GameLevelEndUI:OnPause()
	return
end

function GameLevelEndUI:OnResume()
	return
end

function GameLevelEndUI:OnCover()
	return
end

function GameLevelEndUI:OnReveal()
	return
end

function GameLevelEndUI:OnRefocus(userData)
	return
end

function GameLevelEndUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GameLevelEndUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GameLevelEndUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GameLevelEndUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GameLevelEndUI:OnDestroy()
	self.unitRewardPopupView:Dispose()

	if self.ReturnItemCell ~= nil then
		self.ReturnItemCell:Dispose()
	end

	for k, v in pairs(self.itemList) do
		v:Dispose()
	end

	for k, v in pairs(self.failedJumpItems) do
		UnityEngine.Object.Destroy(v.View)

		v = nil
	end
end

function GameLevelEndUI:FightSucess()
	local wrapContent = self.ItemContainer:GetComponent("ScrollAreaList")

	wrapContent:Refresh(#self.RawItemDatas)
	self.SucessPanel:SetActive(true)
	self.FailedPanel:SetActive(false)
	LuaUtility.SetGameObjectShow(self.FailedBg, false)
	LuaUtility.SetGameObjectShow(self.SucessBg, true)
	self:RefreshPlayerInfo()
	self:RefreshHeroInfo()
	self:RefreshHelpHeroInfo()

	if self:HasHeroItem() then
		local heroItems = {}

		for k, v in pairs(self.RawItemDatas) do
			if CfgItemTable[v.cid].ItemTypes == Constant.ItemType.Hero or CfgItemTable[v.cid].ItemTypes == Constant.ItemType.Item and CfgItemTable[v.cid].ItemSubTypes == Constant.ItemSubType[Constant.ItemType.Item].LifeCore then
				table.insert(heroItems, v)
			end
		end

		UIModule.Open(Constant.UIControllerName.GetPanelUI, Constant.UILayer.UI, {
			items = heroItems
		})
	end
end

function GameLevelEndUI:FightFailed()
	self.RewardPanel:SetActive(false)
	self.SucessPanel:SetActive(false)
	self.FailedPanel:SetActive(true)
	LuaUtility.SetGameObjectShow(self.FailedBg, true)
	LuaUtility.SetGameObjectShow(self.SucessBg, false)
	self:RefreshFigthFailedInfo()
end

function GameLevelEndUI:HasHeroItem()
	for k, v in pairs(self.RawItemDatas) do
		if CfgItemTable[v.cid].ItemTypes == Constant.ItemType.Hero or CfgItemTable[v.cid].ItemTypes == Constant.ItemType.Item and CfgItemTable[v.cid].ItemSubTypes == Constant.ItemSubType[Constant.ItemType.Item].LifeCore then
			return true
		end
	end

	return false
end

function GameLevelEndUI:UpdateItem(cell)
	local itemGo = cell.gameObject
	local singleItemData = self.RawItemDatas[cell.index + 1]
	local instanceID = itemGo:GetInstanceID()
	local itemData
	local itemCell = self.itemList[instanceID]

	if itemCell == nil then
		itemCell = ItemCell.New(itemGo, true, true, true)
		self.itemList[instanceID] = itemCell
	end

	itemData = ItemData.CreateItemShowDataByItemShowPOD(singleItemData)

	if itemData ~= nil then
		itemCell:SetItem(itemData)
		itemCell:SetTag(singleItemData.tag)
		itemCell:SetNum(singleItemData.num)
	end
end

function GameLevelEndUI:RefreshPlayerInfo()
	local curLvExp = 0
	local config = CfgPlayerLevelTable[PlayerModule.PlayerInfo.baseInfo.pLv]

	curLvExp = PlayerModule.PlayerInfo.baseInfo.exp - config.Experience
	curLvExp = curLvExp < 0 and 0 or curLvExp

	local Next_exp = config.Exp

	LuaUtility.SetGameObjectShow(self.MAXState, false)
	LuaUtility.SetGameObjectShow(self.NormalState, false)
	UGUIUtil.SetText(self.PlayerLvText, PlayerModule.PlayerInfo.baseInfo.pLv)

	if PlayerModule.PlayerInfo.baseInfo.pLv >= getCfgTableLength(CfgPlayerLevelTable) then
		LuaUtility.SetGameObjectShow(self.MAXState, true)
	else
		LuaUtility.SetGameObjectShow(self.NormalState, true)
		UGUIUtil.SetText(self.CurExpText, curLvExp)
		UGUIUtil.SetText(self.NextExpText, "/" .. Next_exp)
	end

	LuaUtility.SetGameObjectShow(self.ExpParent, self.getExpNum > 0)

	if self.getExpNum > 0 then
		UGUIUtil.SetText(self.ExpText, self.getExpNum)
	end
end

function GameLevelEndUI:RefreshHeroInfo()
	local heroCid = GameLevelEndUIApi:GetDefaultHeroCid()
	local units = GameChapterModule.fightOverUnits

	if table.len(units or {}) > 0 then
		self.RoleImage:SetActive(true)
		table.sort(units, function(a, b)
			return a.record > b.record
		end)

		if units[1].type == 1 or units[1].type == 3 then
			heroCid = units[1].val
		elseif units[1].type == 2 then
			heroCid = CfgMonsterTable[units[1].val].EntityID
		end
	end

	local heroData = WarlockModule.WarlockDataDic[heroCid]

	if heroData == nil then
		heroData = WarlockModule.WarlockDataDic[9001]
	end

	local _skinPath = heroData ~= nil and heroData:GetCurStaticSkinImagePath(Constant.SkinType.StaticImage) or SkinModule.GetHeroCurrentSkinImgPath(heroCid, Constant.SkinImageType.HeroResourcesVerticalDraw)
	local RoleImageCom = self.RoleImage:GetComponent("Image")

	AssetUtil.LoadImage(self, _skinPath, RoleImageCom, function()
		LuaUtility.SetGameObjectShow(self.RoleImage, true)
		RoleImageCom:SetNativeSize()
		LuaUtility.SetImageRectTransformPivot(self.RoleImage:GetComponent(typeof(UnityEngine.RectTransform)), RoleImageCom)
	end, nil)

	GameChapterModule.fightOverUnits = {}
end

function GameLevelEndUI:RefreshHelpHeroInfo()
	local heroData

	for k, v in pairs(GameChapterModule.fightOverUnits) do
		if v.type == 3 then
			heroData = v

			break
		end
	end

	if heroData ~= nil then
		UserInfoModule.GetSeverPlayerInfo(heroData.pid, heroData.serverId)
	end
end

function GameLevelEndUI:GetUserInfoResult(baseInfo)
	self.helpHeroData = baseInfo

	local heroHeadPath = SkinModule.GetHeroCurrentSkinImgPath(baseInfo.showHeroCid, Constant.SkinImageType.HeroResourcesHead)

	AssetUtil.LoadImage(self, heroHeadPath, self.PlayerHeadImg:GetComponent("Image"))
	UGUIUtil.SetText(self.PlayerNameText, baseInfo.pName)
	UGUIUtil.SetText(self.PlayerUIDText, "UID:" .. baseInfo.guid)
	UGUIUtil.SetText(self.HelpPlayerLvText, "Lv." .. baseInfo.pLv)

	local isFriend = FriendModule.GetFriendByPId(self.helpHeroData.pid) ~= nil

	self.AddFriendBtn:GetComponent("Button").interactable = not isFriend

	if isFriend then
		UGUIUtil.SetTextsInChildren(self.AddFriendBtn, GameLevelEndUIApi:GetIsFriendText())
	else
		UGUIUtil.SetTextsInChildren(self.AddFriendBtn, GameLevelEndUIApi:GetAppalyFriendText())
	end

	self.AddFriendPanelTween:PlayForward()
end

function GameLevelEndUI:OnClickCancelBtn()
	self.AddFriendPanelTween:PlayReverse()
end

function GameLevelEndUI:OnClickConfrimBtn()
	if self.callBack ~= nil then
		self.callBack()

		self.callBack = nil
	else
		UIModule.CloseSelf(self)
	end
end

function GameLevelEndUI:OnClickAddFriendBtn()
	FriendModule.SendApplyFriend(self.helpHeroData.pid)
	UGUIUtil.SetTextsInChildren(self.AddFriendBtn, GameLevelEndUIApi:GetAppalyedFriendText())

	self.AddFriendBtn:GetComponent("Button").interactable = false
end

function GameLevelEndUI:LoadImageSucess(assetName, asset, duration, userData)
	self.RoleImage:GetComponent("Image"):SetNativeSize()
	self.RoleImage:SetActive(true)
end

function GameLevelEndUI:ScreenAndPickExpItem(podItems)
	local items = {}

	for k, v in pairs(podItems) do
		if v.cid == Constant.ItemCid.Exp then
			self.getExpNum = self.getExpNum + v.num
		else
			table.insert(items, v)
		end
	end

	table.sort(items, function(a, b)
		if a.tag == b.tag then
			if CfgItemTable[a.cid].Quality == CfgItemTable[b.cid].Quality then
				return CfgItemTable[a.cid].ItemTypes > CfgItemTable[b.cid].ItemTypes
			end

			return CfgItemTable[a.cid].Quality > CfgItemTable[b.cid].Quality
		end

		return a.tag > b.tag
	end)

	return items
end

function GameLevelEndUI:OnUnitRewardButtonClick()
	self.unitRewardPopupView:Show()
end

function GameLevelEndUI:InitUpgradeInfo()
	local titles = GameLevelEndUIApi:GetUpgradeTitles()

	for i = 1, self.JumpInfoParent.transform.childCount do
		local titleItem = self.JumpInfoParent.transform:GetChild(i - 1).gameObject

		if i > #titles then
			titleItem:SetActive(false)
		else
			titleItem:SetActive(true)
			UGUIUtil.SetTextsInChildren(titleItem, titles[i])
		end
	end
end

function GameLevelEndUI:RefreshFigthFailedInfo()
	if not GameChapterModule.CurSelectChapterCfg then
		LuaUtility.SetGameObjectShow(self.ReturnPersonality, false)

		return
	end

	local returnValue = 0

	if GameChapterModule.CurSelectChapterCfg.PassCost and GameChapterModule.CurSelectChapterCfg.PassCost[2] then
		returnValue = GameChapterModule.CurSelectChapterCfg.PassCost[2]
	end

	self.ReturnPersonality:SetActive(returnValue > 0)

	if returnValue <= 0 then
		return
	end

	UGUIUtil.SetText(self.ReturnValue, returnValue)

	self.ReturnItemCell = ItemCell.New(self.ReturnImg, false)

	self.ReturnItemCell:SetItem(ItemData.CreateByCIDAndNumber(GameChapterModule.CurSelectChapterCfg.PassCost[1], 0))
end

function GameLevelEndUI:CreateTipsItem()
	local titles = GameLevelEndUIApi:GetUpgradeTitles()
	local numCount = table.len(titles) * 0.5

	for i = 1, numCount do
		local obj = UnityEngine.Object.Instantiate(self.ItemPrefab)

		obj.transform:SetParent(self.JumpInfoParent.transform, false)

		local binTable = {}

		LuaCodeInterface.BindOutlet(obj, binTable)
		table.insert(self.failedJumpItems, binTable)
	end

	for i = 2, #titles, 2 do
		local itemTable = self.failedJumpItems[i / 2]

		UGUIUtil.SetText(itemTable.HelpTitle, titles[i - 1])
		UGUIUtil.SetText(itemTable.HelpContent, titles[i])
	end
end

return GameLevelEndUI
