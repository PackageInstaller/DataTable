-- chunkname: @IQIGame\\UI\\SpecialSpirit\\SpAttActiveView.lua

local SpAttActiveView = {
	itemCellPool = {},
	attCellPool = {}
}

function SpAttActiveView.New(view)
	local obj = Clone(SpAttActiveView)

	obj:Init(view)

	return obj
end

function SpAttActiveView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfCostNum = self.goCostNum:GetComponent("Text")
	self.tfCondition = self.goCondition:GetComponent("Text")
	self.btnActive = self.goBtnActive:GetComponent("Button")

	function self.onClickBtnActiveDelegate()
		self:OnClickBtnActive()
	end

	self.itemCellPool[1] = ItemCell2.New(self.goItemCell)
	self.attCellPool[1] = self.goAttCell
	self.goBtnActive.transform:Find("Text"):GetComponent("Text").text = SpecialSpiritUIApi:GetString("attActiveViewBtnActiveTxt")
end

function SpAttActiveView:Open(cfgSpData, soulData)
	self.cfgSpData = cfgSpData
	self.soulData = soulData

	self.View:SetActive(true)
	self:OnAddListener()
	self:RefreshMisc()
	self:RefreshAttBlock()
	self:RefreshCostBlock()
end

function SpAttActiveView:Close()
	self:OnHide()
	self.View:SetActive(false)
end

function SpAttActiveView:OnHide()
	self:OnRemoveListener()
end

function SpAttActiveView:OnDestroy()
	for i, v in pairs(self.itemCellPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SpAttActiveView:OnAddListener()
	self:OnRemoveListener()
	self.btnActive.onClick:AddListener(self.onClickBtnActiveDelegate)
end

function SpAttActiveView:OnRemoveListener()
	self.btnActive.onClick:RemoveListener(self.onClickBtnActiveDelegate)
end

function SpAttActiveView:OnClickBtnActive()
	SoulModule.ReqActiveSpecialSpirit(self.soulData, self.soulData.cfgSoulSpDataAttToActive)
end

function SpAttActiveView:RefreshMisc()
	self.tfCondition.text = SpecialSpiritUIApi:GetString("attActiveViewCondition", self.cfgSpData.NeedSoulLevel)

	local isConditionOk = self.soulData.lv >= self.cfgSpData.NeedSoulLevel

	self.goCondition.transform.parent.gameObject:SetActive(not isConditionOk)
	self.goBtnActive:SetActive(isConditionOk)
end

function SpAttActiveView:RefreshAttBlock()
	local cfgSpDataPre

	for i, v in pairs(CfgSoulSpecialSpiritTable) do
		if v.SoulId == self.cfgSpData.SoulId and v.Group == self.cfgSpData.PreSpirit[1] and v.Level == self.cfgSpData.PreSpirit[2] then
			cfgSpDataPre = v

			break
		end
	end

	for i, v in pairs(self.attCellPool) do
		v:SetActive(false)
	end

	local attDatum = {}

	for i, v in ipairs(self.cfgSpData.AttType) do
		attDatum[i] = {
			v,
			self.cfgSpData.AttValue[i]
		}

		if cfgSpDataPre ~= nil then
			for m, n in ipairs(cfgSpDataPre.AttType) do
				if v == n then
					attDatum[i][2] = attDatum[i][2] - cfgSpDataPre.AttValue[m]

					break
				end
			end
		end
	end

	for i, v in ipairs(attDatum) do
		local cell = self:GetAttCell(i)
		local tfName = cell.transform:Find("Text_01"):GetComponent("Text")
		local tfValue = cell.transform:Find("Text_02"):GetComponent("Text")

		tfName.text = SpecialSpiritUIApi:GetString("attActiveViewAttName", AttributeModule.GetAttName(v[1]))
		tfValue.text = SpecialSpiritUIApi:GetString("attActiveViewAttVale", AttributeModule.GetAttShowValue(v[1], v[2]))
	end
end

function SpAttActiveView:RefreshCostBlock()
	for i, v in pairs(self.itemCellPool) do
		v:SetActive(false)
	end

	self.tfCostNum.text = SpecialSpiritUIApi:GetString("attActiveViewCost", 0, WarehouseModule.GetItemNumByCfgID(Constant.ItemID.MONEY))

	local cellIndex = 0

	for i, v in ipairs(self.cfgSpData.Cost) do
		if i % 2 ~= 0 then
			if v ~= Constant.ItemID.MONEY then
				cellIndex = cellIndex + 1

				local cell = self:GetItemCell(cellIndex)

				cell:Refresh(v, self.cfgSpData.Cost[i + 1])
			else
				self.tfCostNum.text = SpecialSpiritUIApi:GetString("attActiveViewCost", self.cfgSpData.Cost[i + 1], WarehouseModule.GetItemNumByCfgID(v))
			end
		end
	end
end

function SpAttActiveView:GetItemCell(index)
	local ret = self.itemCellPool[index]

	if ret == nil then
		local goClone = UnityEngine.Object.Instantiate(self.goItemCell)

		goClone.transform:SetParent(self.goItemCell.transform.parent, false)

		ret = ItemCell2.New(goClone)
		self.itemCellPool[index] = ret
	end

	ret:SetActive(true)

	return ret
end

function SpAttActiveView:GetAttCell(index)
	local ret = self.attCellPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goAttCell)

		ret.transform:SetParent(self.goAttCell.transform.parent, false)

		self.attCellPool[index] = ret
	end

	ret:SetActive(true)

	return ret
end

return SpAttActiveView
