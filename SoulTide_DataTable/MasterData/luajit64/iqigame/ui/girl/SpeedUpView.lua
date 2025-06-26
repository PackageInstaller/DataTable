-- chunkname: @IQIGame\\UI\\Girl\\SpeedUpView.lua

local SpeedUpView = {}
local ItemBuff = require("IQIGame.UI.Girl.ItemBuff")

function SpeedUpView.__New(ui)
	local o = Clone(SpeedUpView)

	o:InitView(ui)

	return o
end

function SpeedUpView:InitView(ui)
	self.goView = ui
	self.View = self.goView.transform:GetChild(0).gameObject

	LuaCodeInterface.BindOutlet(self.View, self)
	self.goView.gameObject:SetActive(false)

	function self.delegateBuffChange()
		self:OnBuffChange()
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end
end

function SpeedUpView:AddEventListener()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	EventDispatcher.AddEventListener(EventID.PlayerGlobalBuffChange, self.delegateBuffChange)
end

function SpeedUpView:RemoveEventListener()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	EventDispatcher.RemoveEventListener(EventID.PlayerGlobalBuffChange, self.delegateBuffChange)
end

function SpeedUpView:LoadPrefab(asset)
	self.itemBuffPrefab = asset

	self:CreateBuffItem()
end

function SpeedUpView:CreateBuffItem()
	if self.itemBuffPrefab == nil then
		return
	end

	self.itemList = {}

	local parentTransform = self.ItemBuffList.transform

	for i = 0, parentTransform.childCount - 1 do
		local obj = parentTransform:GetChild(0).gameObject

		UnityEngine.GameObject.DestroyImmediate(obj)
	end

	local tab = CfgDiscreteDataTable[6506023].Data
	local len = math.ceil(#tab / 3)

	for i = 1, len do
		local index = 3 * (i - 1)
		local obj = UnityEngine.Object.Instantiate(self.itemBuffPrefab)

		obj.transform:SetParent(parentTransform, false)

		local itemID = tab[1 + index]
		local buffID = tab[2 + index]
		local percent = tab[3 + index]
		local buff = ItemBuff.__New(obj, itemID, buffID, percent)

		self.itemList[#self.itemList + 1] = buff
	end

	self:OnBuffChange()
end

function SpeedUpView:OnBuffChange()
	local addSpeed = 0

	for i, v in pairs(self.itemList) do
		if v:GetBuffEndTime() > 0 then
			addSpeed = addSpeed + v.percent
		end

		v:UpDateView()
	end

	local soulNum = #SoulModule.GetSortedUnlockSoulDataList()
	local A = CfgDiscreteDataTable[6506020].Data[1]
	local B = CfgDiscreteDataTable[6506021].Data[1]
	local topLimit = A + B * soulNum

	self.TexTopLimit:GetComponent("Text").text = "当前收集上限：" .. topLimit .. "点"

	local baseSpeed = Mathf.Floor(topLimit / CfgDiscreteDataTable[6506022].Data[1])
	local addValue = math.floor(baseSpeed * (addSpeed / 100))

	self.TextSpeed:GetComponent("Text").text = "当前收集速度：" .. baseSpeed .. "（+" .. addValue .. "）点/每小时"
end

function SpeedUpView:OnBtnClose()
	if self.callBackCloseFun ~= nil then
		self.callBackCloseFun()
	end
end

function SpeedUpView:Open()
	self.goView.gameObject:SetActive(true)
	self:AddEventListener()
	self:OnBuffChange()
end

function SpeedUpView:Close()
	self.goView.gameObject:SetActive(false)
	self:RemoveEventListener()
end

function SpeedUpView:Dispose()
	self:RemoveEventListener()

	self.callBackCloseFun = nil

	for i, v in pairs(self.itemList) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.goView = nil
end

return SpeedUpView
