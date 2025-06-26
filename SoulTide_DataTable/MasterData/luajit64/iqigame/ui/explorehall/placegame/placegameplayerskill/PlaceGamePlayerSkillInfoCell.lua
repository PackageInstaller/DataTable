-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGamePlayerSkill\\PlaceGamePlayerSkillInfoCell.lua

local m = {
	attCellPool = {},
	strengthCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local PlaceGamePlayerSkillStrengthenCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGamePlayerSkill.PlaceGamePlayerSkillStrengthenCell")

function m.New(view, index)
	local obj = Clone(m)

	obj:Init(view, index)

	return obj
end

function m:Init(view, index)
	self.View = view
	self.index = index

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnDesc()
		self:OnBtnDesc()
	end

	function self.DelegateToggle(isOn)
		self:OnToggle(isOn)
	end

	for i = 1, 3 do
		local go = self.goAttCellParent.transform:Find("Mould_" .. i).gameObject

		self.attCellPool[i] = go
	end

	self.goStrengthCell:SetActive(false)

	self.strengthCellPool = UIObjectPool.New(6, function()
		local cell = PlaceGamePlayerSkillStrengthenCell.New(UnityEngine.Object.Instantiate(self.goStrengthCell))

		function cell.clickEffectTxt(str)
			self:OnStrengthenEffectTxt(str)
		end

		return cell
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	self.goBtnDesc:GetComponent("Button").onClick:AddListener(self.DelegateBtnDesc)
	self.goToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateToggle)
end

function m:RemoveListener()
	self.goBtnDesc:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnDesc)
	self.goToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateToggle)
end

function m:OnBtnDesc()
	if UIGlobalApi.CheckExistKeywordTag(self.sourceDescTxt) then
		UIModule.Open(Constant.UIControllerName.LinkTipUI, Constant.UILayer.UI, {
			self.sourceDescTxt,
			self.goLinkTipPos
		})
	end
end

function m:OnStrengthenEffectTxt(str)
	if UIGlobalApi.CheckExistKeywordTag(str) then
		UIModule.Open(Constant.UIControllerName.LinkTipUI, Constant.UILayer.UI, {
			str,
			self.goLinkTipPos
		})
	end
end

function m:OnToggle(isOn)
	local newSize = self.View.transform.sizeDelta

	if isOn then
		newSize.x = 585
	else
		newSize.x = 145
	end

	self.View.transform.sizeDelta = newSize
end

function m:SetData(placeGameSoulData)
	self.placeGameSoulData = placeGameSoulData

	local cfgSkillGroupData = CfgSkillGroupTable[self.placeGameSoulData:GetCfgPlaceGameSoulData().DefaultSkill]

	self.skillCid = cfgSkillGroupData.GroupSkills[self.index]

	self:UpdateView()
end

function m:UpdateView()
	if self.placeGameSoulData then
		local cfgSkillData = CfgSkillTable[self.skillCid]
		local skillStrengthens, skillLv = self.placeGameSoulData:GetSkillStrengthenLevel()

		self.goLvBG:SetActive(skillLv > 0)
		UGUIUtil.SetText(self.goLv, PlaceGamePlayerSkillUIApi:GetString("SkillStrengthenLv", skillLv))
		UGUIUtil.SetText(self.goName, cfgSkillData.Name)

		local cfgStrengthenDatum = SkillModule.GetStrengthen(cfgSkillData.Id)

		UGUIUtil.SetText(self.goDesc, PlaceGamePlayerSkillUIApi:GetString("SkillEffectText", cfgSkillData.EffectText))

		for i, v in ipairs(cfgStrengthenDatum) do
			if table.indexOf(skillStrengthens, v.Id) ~= -1 then
				UGUIUtil.SetText(self.goDesc, PlaceGamePlayerSkillUIApi:GetString("SkillEffectText", v.Describe))
			end
		end

		self.sourceDescTxt = self.goDesc:GetComponent("Text").text

		UGUIUtil.SetText(self.goDesc, UIGlobalApi.GetTextWithoutKeywordTag(self.sourceDescTxt))

		local value = 0

		for i, v in ipairs(cfgStrengthenDatum) do
			local isUnlock = table.indexOf(skillStrengthens, v.Id) ~= -1

			if isUnlock then
				for m, n in ipairs(v.SkillSlotEffect) do
					if n == 11 then
						value = value + v.SkillSlotEffectParam[m][1]
					end
				end
			end
		end

		local cfgSkillDetailData = CfgSkillDetailTable[cfgSkillData.SkillDetail]

		UGUIUtil.SetText(self.goSp, PlaceGamePlayerSkillUIApi:GetString("SkillViewSkillSp", cfgSkillDetailData.CostEnergy + value))

		local skillTypeDesc = ""
		local isShow = PlaceGamePlayerSkillUIApi:GetString("ShowSkillType", cfgSkillData.ShowType)

		if isShow then
			skillTypeDesc = PlaceGamePlayerSkillUIApi:GetString("SkillTypeTxtInCellInfo", cfgSkillData.ShowType, true)
		end

		UGUIUtil.SetText(self.goType, skillTypeDesc)
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgSkillData.Icon), self.goIcon:GetComponent("Image"))
		self:RefreshStrengthBlock(cfgStrengthenDatum, skillStrengthens)
		self:RefreshAttBlock(cfgSkillData)
	end
end

function m:RefreshAttBlock(cfgSkillData)
	local existAtt = #cfgSkillData.AttrChangeType ~= 0

	self.goAttCellParent.transform.parent.gameObject:SetActive(existAtt)

	if not existAtt then
		return
	end

	for i, v in ipairs(self.attCellPool) do
		v:SetActive(i <= #cfgSkillData.AttrChangeType)
	end

	local allZero = true

	for i, v in pairs(cfgSkillData.AttrChangeType) do
		local value = cfgSkillData.AttrChangeValue[i]
		local txt = self.attCellPool[i].transform:Find("Text_01"):GetComponent("Text")

		txt.text = PlaceGamePlayerSkillUIApi:GetString("SkillViewAttChangeDesc", AttributeModule.GetAttName(v), value, v)

		self.attCellPool[i]:SetActive(value ~= 0)

		if value ~= 0 then
			allZero = false
		end
	end

	self.goAttCellParent.transform.parent.gameObject:SetActive(not allZero)
end

function m:RefreshStrengthBlock(cfgStrengthenDatum, skillStrengthens)
	for i, v in pairs(self.strengthCells) do
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.strengthCellPool:Release(v)
	end

	self.strengthCells = {}

	for i, v in ipairs(cfgStrengthenDatum) do
		local isUnlock = table.indexOf(skillStrengthens, v.Id) ~= -1
		local str = PlaceGamePlayerSkillUIApi:GetString("StrengthenTypeDesc", v.Name, v.EffectText, isUnlock, v.UnLockLv)
		local cell = self.strengthCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.SkillStrengthenNode.transform, false)
		cell:SetData(str, isUnlock)
		table.insert(self.strengthCells, cell)
	end
end

function m:Dispose()
	for i, v in pairs(self.strengthCells) do
		self.strengthCellPool:Release(v)
	end

	self.strengthCells = {}

	self.strengthCellPool:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
