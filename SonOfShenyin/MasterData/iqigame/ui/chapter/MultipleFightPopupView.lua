-- chunkname: @IQIGame\\UI\\Chapter\\MultipleFightPopupView.lua

local MultipleFightPopupView = {
	maxFightCount = 0,
	fightCount = 0,
	chapterType = 0,
	unitCostPower = 0
}

function MultipleFightPopupView.New(view)
	local obj = Clone(MultipleFightPopupView)

	obj:__Init(view)

	return obj
end

function MultipleFightPopupView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__OnInitDelegateFunc()
	self:__OnAddListeners()
end

function MultipleFightPopupView:Dispose()
	self:__OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function MultipleFightPopupView:Show(chapterType, chapterCfg, dupPOD)
	self.gameObject:SetActive(true)

	self.chapterType = chapterType
	self.chapterConfig = chapterCfg

	local stageCost = 0
	local enterCost = 0

	stageCost = self.chapterConfig.PassCost ~= nil and self.chapterConfig.PassCost[2] or 0
	enterCost = self.chapterConfig.EnterCost ~= nil and self.chapterConfig.EnterCost[2] or 0
	self.unitCostPower = stageCost + enterCost
	self.freeCount = 0

	if dupPOD and dupPOD.costFree then
		self.freeCount = dupPOD.costFree
	end

	local playerPower = WarehouseModule.GetPlayerStrengthNum()

	self.fightCount = 1
	self.maxFightCount, _ = math.modf(playerPower / self.unitCostPower) + self.freeCount

	local cfgMaxCount = CfgDiscreteDataTable[115].Data[1]

	if cfgMaxCount < self.maxFightCount then
		self.maxFightCount = cfgMaxCount
	end

	if self.maxFightCount <= self.fightCount then
		self.maxFightCount = self.fightCount
	end

	self:__UpdateFightCount(self.fightCount)
end

function MultipleFightPopupView:Hide()
	self.gameObject:SetActive(false)
end

function MultipleFightPopupView:__OnInitDelegateFunc()
	function self.__delegateOnMinusButtonClick()
		self:__OnMinusButtonClick()
	end

	function self.__delegateOnPlusButtonClick()
		self:__OnPlusButtonClick()
	end

	function self.__delegateOnMinButtonClick()
		self:__OnMinButtonClick()
	end

	function self.__delegateOnMaxButtonClick()
		self:__OnMaxButtonClick()
	end

	function self.__delegateOnFightButtonClick()
		self:__OnFightButtonClick()
	end

	function self.__delegateOnCloseButtonClick()
		self:Hide()
	end
end

function MultipleFightPopupView:__OnAddListeners()
	self.minusButton:GetComponent("Button").onClick:AddListener(self.__delegateOnMinusButtonClick)
	self.plusButton:GetComponent("Button").onClick:AddListener(self.__delegateOnPlusButtonClick)
	self.minBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnMinButtonClick)
	self.maxBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnMaxButtonClick)
	self.fightButton:GetComponent("Button").onClick:AddListener(self.__delegateOnFightButtonClick)
	self.closeButton:GetComponent("Button").onClick:AddListener(self.__delegateOnCloseButtonClick)
end

function MultipleFightPopupView:__OnRemoveListeners()
	self.minusButton:GetComponent("Button").onClick:RemoveListener(self.__delegateOnMinusButtonClick)
	self.plusButton:GetComponent("Button").onClick:RemoveListener(self.__delegateOnPlusButtonClick)
	self.minBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnMinButtonClick)
	self.maxBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnMaxButtonClick)
	self.fightButton:GetComponent("Button").onClick:RemoveListener(self.__delegateOnFightButtonClick)
	self.closeButton:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCloseButtonClick)
end

function MultipleFightPopupView:__OnMinusButtonClick()
	self:__UpdateFightCount(self.fightCount - 1)
end

function MultipleFightPopupView:__OnMinButtonClick()
	self:__UpdateFightCount(1)
end

function MultipleFightPopupView:__OnPlusButtonClick()
	self:__UpdateFightCount(self.fightCount + 1)
end

function MultipleFightPopupView:__OnMaxButtonClick()
	self:__UpdateFightCount(self.maxFightCount)
end

function MultipleFightPopupView:__OnFightButtonClick()
	local userData = {}

	userData.OpenType = 2
	userData.ChapterType = self.chapterType
	userData.StageId = self.chapterConfig.Id
	userData.FightCount = self.fightCount

	if userData.ChapterType == Constant.ChapterPassType.TYPE_RESOURCES then
		ResourceChapterModule.SweepDup(userData.StageId, userData.FightCount)
	elseif userData.ChapterType == Constant.ChapterPassType.TYPE_EQUIP then
		EquipChapterModule.SweepDup(userData.StageId, userData.FightCount)
	elseif userData.ChapterType == Constant.ChapterPassType.TYPE_SummerActivity then
		UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
	end

	self:Hide()
end

function MultipleFightPopupView:__UpdateFightCount(fightCount)
	if fightCount <= 0 then
		fightCount = 1
	end

	if fightCount > self.maxFightCount then
		fightCount = self.maxFightCount
	end

	self.fightCount = fightCount
	self.countText:GetComponent("Text").text = self.fightCount

	local totalCostPower = (self.fightCount - self.freeCount) * self.unitCostPower

	if totalCostPower < 0 then
		totalCostPower = 0
	end

	self.costText:GetComponent("Text").text = totalCostPower
	self.haveText:GetComponent("Text").text = WarehouseModule.GetPlayerStrengthNum()

	local canFight = totalCostPower <= WarehouseModule.GetPlayerStrengthNum()

	self.fightButton:GetComponent("Button").interactable = canFight
end

return MultipleFightPopupView
