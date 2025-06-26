-- chunkname: @IQIGame\\UI\\SpecialSpirit\\SpSkillActiveView.lua

local SpSkillActiveView = {
	itemCellPool = {}
}

function SpSkillActiveView.New(view)
	local obj = Clone(SpSkillActiveView)

	obj:Init(view)

	return obj
end

function SpSkillActiveView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfCostNum = self.goCostNum:GetComponent("Text")
	self.tfCondition = self.goCondition:GetComponent("Text")
	self.btnActive = self.goBtnActive:GetComponent("Button")

	function self.onClickBtnActiveDelegate()
		self:OnClickBtnActive()
	end

	self.itemCellPool[1] = ItemCell2.New(self.goItemCell)
	self.goBtnActive.transform:Find("Text"):GetComponent("Text").text = SpecialSpiritUIApi:GetString("skillActiveViewBtnActiveTxt")
end

function SpSkillActiveView:Open(cfgSpData, soulData)
	self.cfgSpData = cfgSpData
	self.soulData = soulData

	self.View:SetActive(true)
	self:OnAddListener()
	self:RefreshMisc()
	self:RefreshCostBlock()
end

function SpSkillActiveView:Close()
	self:OnHide()
	self.View:SetActive(false)
end

function SpSkillActiveView:OnHide()
	self:OnRemoveListener()
end

function SpSkillActiveView:OnDestroy()
	for i, v in pairs(self.itemCellPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SpSkillActiveView:OnAddListener()
	self:OnRemoveListener()
	self.btnActive.onClick:AddListener(self.onClickBtnActiveDelegate)
end

function SpSkillActiveView:OnRemoveListener()
	self.btnActive.onClick:RemoveListener(self.onClickBtnActiveDelegate)
end

function SpSkillActiveView:OnClickBtnActive()
	SoulModule.ReqActiveSpecialSpirit(self.soulData, self.cfgSpData)
end

function SpSkillActiveView:RefreshMisc()
	local isConditionOk = true
	local needGroup, needLv

	for i, v in ipairs(self.cfgSpData.PreSpirit) do
		if i % 2 == 1 then
			needGroup = v
			needLv = self.cfgSpData.PreSpirit[i + 1]

			if needGroup == 1 then
				if self.soulData.cfgSoulSpDataAtt == nil or needLv > self.soulData.cfgSoulSpDataAtt.Level then
					isConditionOk = false

					break
				end
			elseif SoulSpecialSpiritModule.IsSpSkillGroup(needGroup) then
				local skillIndex = SoulSpecialSpiritModule.GetSpSkillIndex(needGroup)

				if self.soulData.CfgSoulSpecialSpirits[skillIndex] == nil or needLv > self.soulData.CfgSoulSpecialSpirits[skillIndex].Level then
					isConditionOk = false

					break
				end
			end
		end
	end

	if not isConditionOk then
		self.tfCondition.text = SpecialSpiritUIApi:GetString("skillActiveViewConditionOnStar", needLv)
	end

	if isConditionOk and #self.cfgSpData.NeedSkillLv > 0 then
		local skillName = CfgSkillTable[self.cfgSpData.NeedSkillLv[1]].Name
		local targetLv = self.cfgSpData.NeedSkillLv[2]

		isConditionOk = targetLv <= SkillModule.GetSkillLv(self.cfgSpData.NeedSkillLv[1], self.soulData)

		if not isConditionOk then
			self.tfCondition.text = SpecialSpiritUIApi:GetString("skillActiveViewCondition", skillName, targetLv)
		end
	end

	self.goCondition.transform.parent.gameObject:SetActive(not isConditionOk)
	self.goBtnActive:SetActive(isConditionOk)
	self.CostItemGrid:SetActive(isConditionOk)
end

function SpSkillActiveView:RefreshCostBlock()
	for i, v in pairs(self.itemCellPool) do
		v:SetActive(false)
	end

	self.goCostNum.transform.parent.gameObject:SetActive(false)

	local cellIndex = 0

	for i, v in ipairs(self.cfgSpData.Cost) do
		if i % 2 ~= 0 then
			if v ~= Constant.ItemID.MONEY then
				cellIndex = cellIndex + 1

				local cell = self:GetItemCell(cellIndex)

				cell:Refresh(v, self.cfgSpData.Cost[i + 1])
			elseif self.cfgSpData.Cost[i + 1] ~= 0 then
				self.tfCostNum.text = SpecialSpiritUIApi:GetString("attActiveViewCost", self.cfgSpData.Cost[i + 1], WarehouseModule.GetItemNumByCfgID(v))

				self.goCostNum.transform.parent.gameObject:SetActive(true)
			end
		end
	end
end

function SpSkillActiveView:GetItemCell(index)
	local ret = self.itemCellPool[index]

	if ret == nil then
		local goClone = UnityEngine.Object.Instantiate(self.goItemCell)

		goClone.transform:SetParent(self.CostItemGrid.transform, false)

		ret = ItemCell2.New(goClone)
		self.itemCellPool[index] = ret
	end

	ret:SetActive(true)

	return ret
end

return SpSkillActiveView
