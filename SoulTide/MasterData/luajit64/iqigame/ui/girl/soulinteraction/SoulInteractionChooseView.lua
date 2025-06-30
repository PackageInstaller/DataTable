-- chunkname: @IQIGame\\UI\\Girl\\SoulInteraction\\SoulInteractionChooseView.lua

local m = {
	showList = true,
	girlChooseCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tweenPosition = self.scrollView:GetComponent("TweenPosition")
	self.tweenStart = self.tweenPosition.from
	self.tweenEnd = self.tweenPosition.to
	self.tweenSpeed = self.tweenPosition.duration

	self.ChooseSoulMould:SetActive(false)

	self.girlChoosePool = UIObjectPool.New(150, function()
		local cell = GirlChooseCell.New(UnityEngine.Object.Instantiate(self.ChooseSoulMould))

		cell.headCell.goView:GetComponent("Button").enabled = true

		function cell.headCell.clickCallBack(soulHeadCell)
			self:OnClickCell(soulHeadCell)
		end

		return cell
	end, function(cell)
		cell:OnDestroy()
	end)

	function self.DelegateBtnHideList()
		self:OnHideList()
	end

	function self.DelegateBtnShowList()
		self:OnShowList()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.BtnHideList:GetComponent("Button").onClick:AddListener(self.DelegateBtnHideList)
	self.BtnShowList:GetComponent("Button").onClick:AddListener(self.DelegateBtnShowList)
end

function m:RemoveListeners()
	self.BtnHideList:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnHideList)
	self.BtnShowList:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnShowList)
end

function m:UpdateView(soulData)
	self.selectSoulCid = soulData.soulCid

	self:UpdateList()
end

function m:UpdateList()
	self.soulDataList = SoulModule.GetSortedUnlockSoulDataListOnNewGuide()

	table.sort(self.soulDataList, function(a, b)
		local res = false

		if a.favorLv == b.favorLv then
			if a.favor == b.favor then
				res = a.soulCid < b.soulCid
			else
				res = a.favor > b.favor
			end
		else
			res = a.favorLv > b.favorLv
		end

		return res
	end)

	for i, v in pairs(self.girlChooseCells) do
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.girlChoosePool:Release(v)
	end

	self.girlChooseCells = {}

	for i = 1, #self.soulDataList do
		local soulData = self.soulDataList[i]
		local cell = self.girlChoosePool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.goList.transform, false)
		cell:OnRenderCell(soulData)

		if self.selectSoulCid == soulData.soulCid then
			cell:OnSelected()
		else
			cell:OnUnselected()
		end

		table.insert(self.girlChooseCells, cell)
	end

	self.BtnHideList:SetActive(self.showList)
	self.BtnShowList:SetActive(not self.showList)
end

function m:OnClickCell(soulHeadCell)
	self.selectSoulCid = soulHeadCell.soulData.soulCid

	for i, v in pairs(self.girlChooseCells) do
		if v.soulData.soulCid == self.selectSoulCid then
			v:OnSelected()
		else
			v:OnUnselected()
		end
	end

	if self.selectCallBack then
		self.selectCallBack(self.selectSoulCid)
	end
end

function m:OnHideList()
	self.tweenPosition = TweenPosition.Begin(self.scrollView, self.tweenSpeed, self.tweenEnd)
	self.showList = false

	self.BtnHideList:SetActive(self.showList)
	self.BtnShowList:SetActive(not self.showList)
end

function m:OnShowList()
	self.tweenPosition = TweenPosition.Begin(self.scrollView, self.tweenSpeed, self.tweenStart)
	self.showList = true

	self.BtnHideList:SetActive(self.showList)
	self.BtnShowList:SetActive(not self.showList)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()

	self.selectCallBack = nil

	for i, v in pairs(self.girlChooseCells) do
		self.girlChoosePool:Release(v)
	end

	self.girlChooseCells = {}

	self.girlChoosePool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
