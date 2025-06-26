-- chunkname: @IQIGame\\UI\\Tips\\TipSkillUpView.lua

local TipSkillUpView = {
	itemCellPool = {}
}

function TipSkillUpView.New(view)
	local obj = Clone(TipSkillUpView)

	obj:Init(view)

	return obj
end

function TipSkillUpView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tw = self.View:GetComponent("TweenPosition")
	self.tfMoney = self.goMoneyBlock.transform:Find("Text_Number"):GetComponent("Text")
	self.tfStrength = self.goStrength:GetComponent("Text")
	self.tfCondition = self.goConditionBlock.transform:Find("Sort/Text_01"):GetComponent("Text")
	self.tfCurLv = self.goCurLv:GetComponent("Text")
	self.tfNextLv = self.goNextLv:GetComponent("Text")
	self.itemCellPool[1] = ItemCell.PackageOrReuseView(self, self.goItemCell)
	self.btnUp = self.goBtnUp:GetComponent("Button")

	function self.onClickBtnUpDelegate()
		self:OnClickBtnUp()
	end

	self.goBtnUp.transform:Find("Text"):GetComponent("Text").text = SoulSkillUIApi:GetString("goBtnUp")
	self.goTitle:GetComponent("Text").text = SoulSkillUIApi:GetString("goTitle")
	self.goTitle2:GetComponent("Text").text = SoulSkillUIApi:GetString("goTitle2")
end

function TipSkillUpView:Open(userData)
	self:RefreshDatum(userData)
	self.View:SetActive(true)
	self:PlayTween()
	self:RefreshUpBlock()
	self:RefreshMaxBlock()
	self:StopEffectLv()
	self:StopEffectText()
end

function TipSkillUpView:Refresh(cfgSkillData)
	self:RefreshDatum(cfgSkillData)
	self:RefreshUpBlock()
	self:RefreshMaxBlock()
end

function TipSkillUpView:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function TipSkillUpView:OnHide()
	return
end

function TipSkillUpView:OnDestroy()
	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function TipSkillUpView:OnAddListeners()
	self.btnUp.onClick:AddListener(self.onClickBtnUpDelegate)
end

function TipSkillUpView:OnRemoveListeners()
	self.btnUp.onClick:RemoveListener(self.onClickBtnUpDelegate)
end

function TipSkillUpView:OnClickBtnUp()
	if self.isCostEnough == false then
		NoticeModule.ShowNotice(21041006)

		return
	end

	SoulModule.ActivationSkillStrengthen(self.soulData.soulCid, self.cfgSkillData.Id, self.cfgStrengthenDataTarget.Id)
end

function TipSkillUpView:OnStrengthenUpSuccess(id)
	if self.cfgSkillData.Id ~= id then
		return
	end

	self:Refresh(self.cfgSkillData)
	self:PlayEffectLv()
	self:PlayEffectText()
end

function TipSkillUpView:RefreshDatum(cfgSkillData)
	self.cfgSkillData = cfgSkillData
	self.soulData = SoulModule.GetSoulData(self.cfgSkillData.UnLockSoul)
	self.cfgStrengthenDataTarget = nil
	self.cfgStrengthenDatum = SkillModule.GetStrengthen(self.cfgSkillData.Id)

	for i, v in ipairs(self.cfgStrengthenDatum) do
		if table.indexOf(self.soulData.activationSkillStrengthen, v.Id) == -1 then
			self.cfgStrengthenDataTarget = v

			break
		end
	end

	self.isMax = self.cfgStrengthenDataTarget == nil
end

function TipSkillUpView:RefreshUpBlock()
	self.goUpBlock:SetActive(not self.isMax)

	if self.isMax then
		return
	end

	self:RefreshInfoBlock()
	self:RefreshCostBlock()
end

function TipSkillUpView:RefreshInfoBlock()
	local isConditionOk = self.soulData.lv >= self.cfgStrengthenDataTarget.UnLockLv

	self.goBtnUp:SetActive(isConditionOk)
	self.goConditionBlock:SetActive(not isConditionOk)

	self.tfCondition.text = SoulSkillUIApi:GetString("goCondition", self.cfgStrengthenDataTarget.UnLockLv)
	self.tfStrength.text = SoulSkillUIApi:GetString("goEffect", self.cfgStrengthenDataTarget.EffectText)
	self.tfCurLv.text = SoulSkillUIApi:GetString("lv", self.cfgStrengthenDataTarget.StrengthenType - 1, false)
	self.tfNextLv.text = SoulSkillUIApi:GetString("lv", self.cfgStrengthenDataTarget.StrengthenType, true)
end

function TipSkillUpView:RefreshCostBlock()
	for i, v in pairs(self.itemCellPool) do
		v:Clear(false)
	end

	self.goMoneyBlock:SetActive(false)

	self.isCostEnough = true

	for i, v in ipairs(self.cfgStrengthenDataTarget.UnLockCost) do
		if i % 2 ~= 0 then
			local id = v
			local count = self.cfgStrengthenDataTarget.UnLockCost[i + 1]
			local ownCount = WarehouseModule.GetItemNumByCfgID(id)

			if id ~= 1 then
				local cell = self:GetItemCell(i)

				cell:SetItemByCID(id, ownCount)
				cell:SetCustomNum(ownCount, count)
			else
				self.tfMoney.text = SoulSkillUIApi:GetString("moneyCount", count, ownCount)

				self.goMoneyBlock:SetActive(true)
			end

			if ownCount < count then
				self.isCostEnough = false
			end
		end
	end
end

function TipSkillUpView:RefreshMaxBlock()
	self.goMaxBlock:SetActive(self.isMax)

	if not self.isMax then
		return
	end

	self.goMaxBlock.transform:Find("Level/Next/Text_Max"):GetComponent("Text").text = SoulSkillUIApi:GetString("maxLv", self.cfgStrengthenDatum[#self.cfgStrengthenDatum].StrengthenType)
	self.goMaxBlock.transform:Find("Level/Text_Desc"):GetComponent("Text").text = SoulSkillUIApi:GetString("goMax")
end

function TipSkillUpView:PlayTween()
	self.tw.enabled = true

	self.tw:ResetToBeginning()
	self.tw:PlayForward()
end

function TipSkillUpView:GetItemCell(index)
	local cell = self.itemCellPool[index]

	if cell == nil then
		local go = UnityEngine.Object.Instantiate(self.goItemCell)

		go.transform:SetParent(self.goItemCell.transform.parent, false)

		cell = ItemCell.PackageOrReuseView(self, go)
		self.itemCellPool[index] = cell
	end

	return cell
end

function TipSkillUpView:PlayEffectLv()
	self.goEffectLv:SetActive(true)
end

function TipSkillUpView:StopEffectLv()
	self.goEffectLv:SetActive(false)
end

function TipSkillUpView:PlayEffectText()
	self.goEffectText:SetActive(true)
end

function TipSkillUpView:StopEffectText()
	self.goEffectText:SetActive(false)
end

return TipSkillUpView
