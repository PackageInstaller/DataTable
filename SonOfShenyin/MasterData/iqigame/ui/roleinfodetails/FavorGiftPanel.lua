-- chunkname: @IQIGame\\UI\\RoleInfoDetails\\FavorGiftPanel.lua

local FavorGiftPanel = {}
local FavorGiftItemView = require("IQIGame.UI.RoleInfoDetails.FavorGiftItemView")

function FavorGiftPanel.New(go, mainView)
	local o = Clone(FavorGiftPanel)

	o:Initialize(go, mainView)

	return o
end

function FavorGiftPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function FavorGiftPanel:InitMembers()
	self.giftViewArray = {}
	self.giftDataArray = {}
	self.selectList = {}
end

function FavorGiftPanel:InitComponent()
	self.giftItemScroll = self.giftItemScroll:GetComponent("OptimizedGridRect")

	self.giftItemScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:OnGiftScrollRefresh(OptimizedParams, OptimizedViewsHolder)
	end)

	self.returnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	self.returnBtn:RegisterReturnEvent(function()
		self:Close()
	end)
end

function FavorGiftPanel:InitDelegate()
	function self.delegateOnClickGiveBtn()
		self:OnClickGiveBtn()
	end

	function self.FavorPrepareResetEvent()
		self:ResetFavorPrepare()
	end

	function self.prepareAddFavorEvent(value)
		self:PrepareAddFavor(value)
	end

	function self.prepareReduceFavorEvent(value)
		self:PrepareReduceFavor(value)
	end

	function self.delegateOnClickButtonClear()
		self:OnClickButtonClear()
	end
end

function FavorGiftPanel:AddListener()
	self.giveBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickGiveBtn)
	self.buttonClear:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClear)
	EventDispatcher.AddEventListener(EventID.FavorPrepareResetEvent, self.FavorPrepareResetEvent)
	EventDispatcher.AddEventListener(EventID.FavorPrepareAddEvent, self.prepareAddFavorEvent)
	EventDispatcher.AddEventListener(EventID.FavorPrepareReduceEvent, self.prepareReduceFavorEvent)
end

function FavorGiftPanel:RemoveListener()
	self.giveBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickGiveBtn)
	self.buttonClear:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClear)
	EventDispatcher.RemoveEventListener(EventID.FavorPrepareResetEvent, self.FavorPrepareResetEvent)
	EventDispatcher.RemoveEventListener(EventID.FavorPrepareAddEvent, self.prepareAddFavorEvent)
	EventDispatcher.RemoveEventListener(EventID.FavorPrepareReduceEvent, self.prepareReduceFavorEvent)
end

function FavorGiftPanel:OnClickButtonClear()
	self:ResetFavorItemSelect()
end

function FavorGiftPanel:PrepareReduceFavor(value)
	self.prepareAddFavorValue = self.prepareAddFavorValue - value

	self:RefreshProgress()
end

function FavorGiftPanel:PrepareAddFavor(value)
	self.prepareAddFavorValue = self.prepareAddFavorValue + value

	self:RefreshProgress()
end

function FavorGiftPanel:ResetFavorPrepare()
	self.selectList = {}
	self.prepareAddFavorValue = 0

	self:RefreshProgress()
	self:Refresh(self.data)
end

function FavorGiftPanel:OnClickGiveBtn()
	local items = {}

	for itemID, count in pairs(self.selectList) do
		items[itemID] = count
	end

	if table.len(items) == 0 then
		NoticeModule.ShowNotice(20034)

		return
	end

	RoleExtendModule.FavorabilityExpItem(self.data, items)
end

function FavorGiftPanel:Open()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function FavorGiftPanel:Close()
	LuaUtility.SetGameObjectShow(self.gameObject, false)

	self.selectList = {}
end

function FavorGiftPanel:RefreshProgress()
	if not self.heroData then
		return
	end

	local cfgFavorLv = RoleInfoDetailsModule.GetHeroFavorLevelCfg(self.heroData.cid, self.heroData.favorabilityLevel)

	self.dAddLv = 0
	self.dFavorExp = cfgFavorLv.FavorExp
	self.dAddValue = self.prepareAddFavorValue

	local value = self:FavorLvRecur((self.heroData.favorabilityExp + self.dAddValue) / self.dFavorExp)

	if self.dAddLv > 0 then
		local targetLv = self.heroData.favorabilityLevel + self.dAddLv

		if targetLv >= self.heroData:GetMaxFavorLv() then
			targetLv = self.heroData:GetMaxFavorLv()
		end

		local cfgTargetFavor = RoleInfoDetailsModule.GetHeroFavorLevelCfg(self.heroData.cid, targetLv)

		LuaUtility.SetGameObjectShow(self.upRoot, true)
		LuaUtility.SetText(self.targetFavorLv, self.heroData.favorabilityLevel + self.dAddLv)
		LuaUtility.SetText(self.textTargetFavorName, cfgTargetFavor.FavorName)
	else
		LuaUtility.SetGameObjectShow(self.upRoot, false)
	end

	LuaUtility.SetText(self.currentFavorLv, self.heroData.favorabilityLevel)
	LuaUtility.SetText(self.currentExp, self.heroData.favorabilityExp + self.prepareAddFavorValue)
	LuaUtility.SetText(self.textMaxExp, cfgFavorLv.FavorExp)
	LuaUtility.SetText(self.textAdd, string.format("+%s", self.prepareAddFavorValue))
	LuaUtility.SetText(self.textCurFavorName, cfgFavorLv.FavorName)
	self:SetFavorProgress(self.heroData.favorabilityExp / cfgFavorLv.FavorExp)
	LuaUtility.SetImageFillAmount(self.favoriteImgpreview, (self.heroData.favorabilityExp + self.prepareAddFavorValue) / cfgFavorLv.FavorExp)
end

function FavorGiftPanel:FavorLvRecur(value)
	if value < 1 then
		return value
	end

	self.dAddLv = self.dAddLv + 1

	if self.heroData.favorabilityLevel + self.dAddLv == self.heroData:GetMaxFavorLv() then
		return value
	end

	local cfgFavorLv = RoleInfoDetailsModule.GetHeroFavorLevelCfg(self.heroData.cid, self.heroData.favorabilityLevel + self.dAddLv)

	if not cfgFavorLv then
		return 1
	end

	self.dAddValue = self.dAddValue - self.dFavorExp
	self.dFavorExp = cfgFavorLv.FavorExp

	return self:FavorLvRecur((self.heroData.favorabilityExp + self.dAddValue) / self.dFavorExp)
end

function FavorGiftPanel:SetFavorProgress(value)
	LuaUtility.SetImageFillAmount(self.favoriteImg, value)
end

function FavorGiftPanel:OnGiftScrollRefresh(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.rootGameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.giftDataArray[index + 1]

	if not self.giftViewArray[instanceID] then
		self.giftViewArray[instanceID] = FavorGiftItemView.New(viewGameObject, self)
	end

	self.giftViewArray[instanceID]:Refresh(data)
end

function FavorGiftPanel:RefreshGiftScroll()
	self.giftItemScroll:RefreshByItemCount(#self.giftDataArray)
end

function FavorGiftPanel:Refresh(Data)
	self.data = Data
	self.giftDataArray = RoleInfoDetailsModule.GetHeroFavorGiftList()
	self.heroData = WarlockModule.GetHeroData(self.data)
	self.prepareAddFavorValue = 0

	self:RefreshGiftScroll()
	LuaUtility.SetGameObjectShow(self.nameText, false)
	LuaUtility.SetGameObjectShow(self.descText, false)
	self:RefreshProgress()
end

function FavorGiftPanel:SetGiftDescShow(name, desc, value)
	LuaUtility.SetText(self.nameText, name)
	LuaUtility.SetText(self.descText, desc)

	local str = CfgUtil.GetCfgTipsTextWithID(210010)

	LuaUtility.SetText(self.numText, string.format(str, CfgUtil.GetCfgHeroDataWithID(self.data).Name, value))
	LuaUtility.SetGameObjectShow(self.nameText, true)
	LuaUtility.SetGameObjectShow(self.descText, true)
end

function FavorGiftPanel:AddFavorItemSelect(itemID)
	if not self.selectList[itemID] then
		self.selectList[itemID] = 0
	end

	self.selectList[itemID] = self.selectList[itemID] + 1
end

function FavorGiftPanel:ReduceFavorItemSelect(itemID)
	if not self.selectList[itemID] then
		return
	end

	self.selectList[itemID] = self.selectList[itemID] - 1

	if self.selectList[itemID] == 0 then
		self.selectList[itemID] = nil
	end
end

function FavorGiftPanel:ResetFavorItemSelect()
	self.selectList = {}

	self:ResetFavorPrepare()
	self:Refresh(self.data)
end

function FavorGiftPanel:GiveSuccess()
	self.selectList = {}

	self:Refresh(self.data)
end

function FavorGiftPanel:ValidatePrepareLvIsMax()
	return self.heroData.favorabilityLevel + self.dAddLv >= self.heroData:GetMaxFavorLv()
end

function FavorGiftPanel:Dispose()
	for _, v in pairs(self.giftViewArray) do
		v:OnDestroy()
	end

	self.giftViewArray = {}

	self.returnBtn:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
	self.giftItemScroll = nil
end

return FavorGiftPanel
