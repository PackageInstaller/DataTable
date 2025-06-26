-- chunkname: @IQIGame\\UI\\Activity\\LuckyTurnTable\\ActiveLuckyTurnTableView.lua

local m = {
	StartRotate = false,
	RotateSpeed = 0,
	EffectID = 0,
	passTime = 0,
	endPosZ = 0,
	PointerRotationZ = 0,
	PointerRotation = Quaternion.identity,
	tableCellRotationZ = {},
	luckyTurnTableCellPool = {}
}
local LuckyTurnTableCell = require("IQIGame.UI.Activity.LuckyTurnTable.LuckyTurnTableCell")

function m.New(view, root)
	local obj = Clone(m)

	obj:Init(view, root)

	return obj
end

function m:Init(view, root)
	self.View = view
	self.root = root

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.BtnLotteryPoolTitle, ActivityUIApi:GetString("LuckyBtnLotteryPoolTitle"))
	UGUIUtil.SetText(self.TextDes, ActivityUIApi:GetString("LuckyTextDes"))
	UGUIUtil.SetText(self.BtnProbabilityTitle, ActivityUIApi:GetString("LuckyBtnProbabilityTitle"))
	UGUIUtil.SetText(self.BtnLotteryRecordTitle, ActivityUIApi:GetString("LuckyBtnLotteryRecordTitle"))
	UGUIUtil.SetText(self.BtnBuyTitle1, ActivityUIApi:GetString("LuckyBtnBuyTitle1"))
	UGUIUtil.SetText(self.BtnBuyTitle2, ActivityUIApi:GetString("LuckyBtnBuyTitle2"))
	UGUIUtil.SetText(self.BtnBatchBuyTitle1, ActivityUIApi:GetString("LuckyBtnBatchBuyTitle1"))
	UGUIUtil.SetText(self.BtnBatchBuyTitle2, ActivityUIApi:GetString("LuckyBtnBatchBuyTitle2"))

	local path = UIGlobalApi.GetIconPath(CfgItemTable[ActiveLuckyTurnTableModule.LUCKY_TURNTABLE_MONEY].Icon)

	AssetUtil.LoadImage(self, path, self.ImgSpend1:GetComponent("Image"))
	AssetUtil.LoadImage(self, path, self.ImgSpend2:GetComponent("Image"))

	function self.delegateBtnLotteryPool()
		self:OnBtnLotteryPool()
	end

	function self.delegateBtnProbability()
		self:OnBtnProbability()
	end

	function self.delegateBtnLotteryRecord()
		self:OnBtnLotteryRecord()
	end

	function self.delegateBtnBuy()
		self:OnBtnBuy()
	end

	function self.delegateBtnBatchBuy()
		self:OnBtnBatchBuy()
	end

	function self.delegateOnEffectShow(sender, args)
		self:OnEffectShow(sender, args)
	end

	self.luckyTurnTableCellPool = {}

	local itemRotationZ6 = 0

	self.tableCellRotationZ = {}

	for i = 1, 8 do
		local cell = LuckyTurnTableCell.New(self["Item" .. i], i)

		self.luckyTurnTableCellPool[i] = cell

		local rotationZ = itemRotationZ6 - 45 * (i - 6)

		if rotationZ < 0 then
			rotationZ = rotationZ + 360
		end

		self.tableCellRotationZ[i] = rotationZ
	end

	self.showTable = ActiveLuckyTurnTableModule.GetCfgData()
	self.turnTimer = Timer.New(function()
		self:UpdateTimer()
	end, 0.01, -1)

	UIUtil.InitSortedComponents(self.root.UIController:GetComponent("Canvas"), self.View)
end

function m.GetPreloadAssetPaths()
	return
end

function m:Update(elapseSeconds, realElapseSeconds)
	return
end

function m:UpdateTimer()
	if self.StartRotate then
		self.passTime = self.passTime + 0.01

		if self.passTime < 0.5 then
			self.RotateSpeed = self.RotateSpeed + 0.5
		elseif self.passTime > 1 then
			self.RotateSpeed = self.RotateSpeed - 0.5

			if self.RotateSpeed < 2 then
				self.RotateSpeed = 2
			end
		end

		self.PointerRotationZ = self.PointerRotationZ - self.RotateSpeed

		if self.PointerRotationZ <= 0 then
			self.PointerRotationZ = self.PointerRotationZ + 360
		end

		self.PointerRotation:SetEuler(0, 0, self.PointerRotationZ)

		self.Pointer.transform.rotation = self.PointerRotation

		if self.RotateSpeed == 2 and self.passTime > 1 then
			local des = self.endPosZ - self.PointerRotationZ

			if math.abs(des) < 10 then
				self:RotateComplete()
			end
		end
	end
end

function m:AddListener()
	self.goBtnLotteryPool:GetComponent("Button").onClick:AddListener(self.delegateBtnLotteryPool)
	self.BtnProbability:GetComponent("Button").onClick:AddListener(self.delegateBtnProbability)
	self.BtnLotteryRecord:GetComponent("Button").onClick:AddListener(self.delegateBtnLotteryRecord)
	self.goBtnBuy:GetComponent("Button").onClick:AddListener(self.delegateBtnBuy)
	self.goBtnBatchBuy:GetComponent("Button").onClick:AddListener(self.delegateBtnBatchBuy)
end

function m:RemoveListener()
	self.goBtnLotteryPool:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLotteryPool)
	self.BtnProbability:GetComponent("Button").onClick:RemoveListener(self.delegateBtnProbability)
	self.BtnLotteryRecord:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLotteryRecord)
	self.goBtnBuy:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBuy)
	self.goBtnBatchBuy:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBatchBuy)
end

function m:UpDateView()
	for i = 1, #self.luckyTurnTableCellPool do
		local cfgData = self.showTable[i]
		local cell = self.luckyTurnTableCellPool[i]

		cell:SetData(cfgData)
	end
end

function m:DefaultSelect()
	for i, v in pairs(self.luckyTurnTableCellPool) do
		v:SetSelect(false)
	end
end

function m:OnBtnLotteryPool()
	JumpModule.Jump(10202031)
end

function m:OnBtnProbability()
	UIModule.Open(Constant.UIControllerName.DailyRewardListUI, Constant.UILayer.UI)
end

function m:OnBtnLotteryRecord()
	ActiveLuckyTurnTableModule.GetLuckDrawHistory(function(luckDrawHistorys)
		UIModule.Open(Constant.UIControllerName.DailyHistoryListUI, Constant.UILayer.UI, luckDrawHistorys)
	end)
end

function m:StartPlayRotation(showItems)
	self.showItems = showItems
	self.endIndex = nil

	local getItemPod

	self.endPosZ = 0
	self.passTime = 0

	for i = 1, #showItems do
		local itemShowPod = showItems[i]

		if itemShowPod.cid ~= Constant.ItemID.LUNAR_CALENDAR then
			getItemPod = itemShowPod

			break
		end
	end

	for i = 1, #self.luckyTurnTableCellPool do
		local cell = self.luckyTurnTableCellPool[i]

		if cell.cfgData.Reward[1] == getItemPod.cid then
			self.endPosZ = self.tableCellRotationZ[i]
			self.endIndex = i

			break
		end
	end

	self.turnTimer:Start()
end

function m:PlayEffect()
	GameEntry.LuaEvent:Subscribe(EffectShowEventArgs.EventId, self.delegateOnEffectShow)

	self.EffectID = GameEntry.Effect:PlayUIEffect(9007002, self.Pointer.transform.position, self.root.UIController:GetComponentInParent(typeof(UnityEngine.Canvas)).sortingOrder + 20)
end

function m:OnEffectShow(sender, args)
	if args.EffectPlayID == self.EffectID then
		GameEntry.LuaEvent:Unsubscribe(EffectShowEventArgs.EventId, self.delegateOnEffectShow)

		self.EffectID = 0
		self.rewardTimer = Timer.New(function()
			ActiveLuckyTurnTableModule.LuckDraw(2)
		end, 1.5)

		self.rewardTimer:Start()
	end
end

function m:OnBtnBuy()
	if self.StartRotate or self.EffectID ~= 0 then
		return
	end

	local haveNum = WarehouseModule.GetItemNumByCfgID(ActiveLuckyTurnTableModule.LUCKY_TURNTABLE_MONEY)

	if haveNum < 1 then
		NoticeModule.ShowNotice(21052002)

		return
	end

	self:DefaultSelect()
	self.turnTimer:Stop()

	self.StartRotate = true

	ActiveLuckyTurnTableModule.LuckDraw(1, function(showItems)
		self:StartPlayRotation(showItems)
	end)
end

function m:OnBtnBatchBuy()
	if self.EffectID ~= 0 or self.StartRotate then
		return
	end

	local haveNum = WarehouseModule.GetItemNumByCfgID(ActiveLuckyTurnTableModule.LUCKY_TURNTABLE_MONEY)

	if haveNum < 10 then
		NoticeModule.ShowNotice(21052002)

		return
	end

	self:DefaultSelect()
	self:PlayEffect()
end

function m:RotateComplete()
	self.StartRotate = false
	self.StartSlowdown = false

	if self.endIndex ~= nil then
		self.luckyTurnTableCellPool[self.endIndex]:SetSelect(true)

		self.endIndex = nil
	end

	self.RotateSpeed = 0

	self.PointerRotation:SetEuler(0, 0, self.endPosZ)

	self.Pointer.transform.rotation = self.PointerRotation

	self:ShowReward()
end

function m:ShowReward()
	if self.showItems and #self.showItems > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, self.showItems)

		self.showItems = nil
	end
end

function m:Open()
	self:AddListener()
	self.View:SetActive(true)
	self:DefaultSelect()

	self.PointerRotationZ = self.endPosZ
	ActiveLuckyTurnTableModule.showLandingTip = false

	EventDispatcher.Dispatch(EventID.UpdateLuckyTurnRedPoint)
	self:UpDateView()
end

function m:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function m:OnHide()
	self:RemoveListener()
	self:RotateComplete()
end

function m:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.turnTimer:Stop()

	self.turnTimer = nil

	for i, v in pairs(self.luckyTurnTableCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
