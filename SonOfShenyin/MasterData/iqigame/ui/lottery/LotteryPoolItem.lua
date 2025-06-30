-- chunkname: @IQIGame\\UI\\Lottery\\LotteryPoolItem.lua

local LotteryPoolItem = {}
local lotteryShowClickController = require("IQIGame.UI.Lottery.LotteryShowClickController")

function LotteryPoolItem.New(go, mainView)
	local o = Clone(LotteryPoolItem)

	o:Initialize(go, mainView)

	return o
end

function LotteryPoolItem:Initialize(go, mainView)
	self.gameObject = go

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.mainView = mainView
	self.UIController = mainView.UIController

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function LotteryPoolItem:InitComponent()
	return
end

function LotteryPoolItem:InitDelegate()
	return
end

function LotteryPoolItem:AddListener()
	return
end

function LotteryPoolItem:RemoveListener()
	return
end

function LotteryPoolItem:Destroy()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	GameObject.Destroy(self.gameObject)

	self.gameObject = nil
end

function LotteryPoolItem:Refresh(Data)
	self.Data = Data
	self.cfgCardPool = CfgUtil.GetCardJackpotWithID(self.Data.id)

	AssetUtil.LoadAsset(self, UIGlobalApi.GetUIPrefab(self.cfgCardPool.ShowPrefab), self.OnLoadSucceed)
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function LotteryPoolItem:OnLoadSucceed(assetName, asset, duration, userData)
	local object = GameObject.Instantiate(asset, self.gameObject.transform)

	UIUtil.InitSortedComponents(self.UIController:GetComponent("Canvas"), object)

	if self.cfgCardPool then
		LuaUtility.SetAnchoredPositionWithRectTransform(object:GetComponent("RectTransform"), self.cfgCardPool.Skewing[1], self.cfgCardPool.Skewing[2])
	end
end

return LotteryPoolItem
