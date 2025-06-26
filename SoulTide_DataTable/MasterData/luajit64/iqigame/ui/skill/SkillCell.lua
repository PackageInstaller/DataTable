-- chunkname: @IQIGame\\UI\\Skill\\SkillCell.lua

SkillCell = {
	Interactive = true,
	enableClick = true
}

function SkillCell.PackageOrReuseView(ui, cellGo, interactive)
	if ui == nil or cellGo == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_SkillCell == nil then
		ui.__SUB_UI_MAP_SkillCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_SkillCell
	local skillCell

	if subUIMap[cellGo:GetInstanceID()] == nil then
		skillCell = SkillCell:__New(cellGo, interactive)
		subUIMap[cellGo:GetInstanceID()] = skillCell
	else
		skillCell = subUIMap[cellGo:GetInstanceID()]
	end

	return skillCell
end

function SkillCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_SkillCell == nil then
		return
	end

	for i, skillCell in pairs(ui.__SUB_UI_MAP_SkillCell) do
		skillCell:Dispose()
	end

	ui.__SUB_UI_MAP_SkillCell = nil
end

function SkillCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.ViewGo, self.View)

	self.ViewGo = nil
	self.View = nil
	self.ClickHandler = nil
end

function SkillCell.New(viewGo, interactive)
	return SkillCell:__New(viewGo, interactive)
end

function SkillCell:__New(viewGo, interactive)
	local o = Clone(self)

	o.View = {}
	o.ViewGo = viewGo

	LuaCodeInterface.BindOutlet(viewGo, o.View)

	function o.ClickHandler()
		o:OnClick()
	end

	o.DefaultClickHandler = o.ClickHandler

	function o.DelegateOnClick()
		o.ClickHandler()
	end

	if interactive ~= nil then
		o.Interactive = interactive
	end

	if o.Interactive then
		local button = o.ViewGo:GetComponent("Button")

		if button ~= nil then
			button.onClick:AddListener(o.DelegateOnClick)
		end
	end

	o:SetMouseEnabled(o.Interactive)

	function o.onSkillStrengthenUpSuccessDelegate(id)
		o:OnStrengthenUpSuccess(id)
	end

	o:AddListeners()

	return o
end

function SkillCell:SetMouseEnabled(value)
	local button = self.ViewGo:GetComponent("Button")

	if button == nil then
		return
	end

	button.enabled = value

	local image, childTrans

	for i = 0, self.ViewGo.transform.childCount - 1 do
		childTrans = self.ViewGo.transform:GetChild(i)
		image = childTrans:GetComponent("Image")

		if image ~= nil then
			image.raycastTarget = value
		end
	end
end

function SkillCell:SetClickHandler(handler, owner)
	function self.ClickHandler()
		handler(owner, self)
	end
end

function SkillCell:ResetClickHandler()
	self.ClickHandler = self.DefaultClickHandler
end

function SkillCell:OnClick()
	if self.CfgSkillsData ~= nil and self.enableClick then
		UIModule.Open(Constant.UIControllerName.SkillTipsUI, Constant.UILayer.Tooltip, {
			cfgSkillData = self.CfgSkillsData,
			soulData = self.soulData,
			allSkillStrengths = self.extraSkillStrengthens
		})
	end
end

function SkillCell:EnableClick(enable)
	self.enableClick = enable
end

function SkillCell:SetSkill(skillCid, soulData, extraSkillStrengthens)
	if skillCid == 0 then
		self:Clear()
	else
		self.CfgSkillsData = CfgSkillTable[skillCid]
		self.soulData = soulData
		self.extraSkillStrengthens = extraSkillStrengthens

		self:Update(self.CfgSkillsData)
	end
end

function SkillCell:SetIconVisible(vs)
	self.View.Icon:SetActive(vs)
end

function SkillCell:SetSpTagVisible(vs)
	self.View.goSpTag:SetActive(vs)
end

function SkillCell:SetSkillLevelVisible(vs)
	self.View.SkillLevelText:SetActive(vs)
	self.View.LevelBg:SetActive(vs)
end

function SkillCell:SetSkillLevelDesc(desc)
	self.View.SkillLevelText:GetComponent("Text").text = desc

	self.View.SkillLevelText:SetActive(true)
	self.View.LevelBg:SetActive(true)
end

function SkillCell:SetTopMaskVisible(vs)
	self.View.goTopMask:SetActive(vs)
end

function SkillCell:Clear()
	self.ViewGo:SetActive(false)
end

function SkillCell:IsLock(vs)
	self.isLock = vs

	self.View.LockImg:SetActive(vs)
	self.View.LockImg:GetComponent("ImageGroupGrayComponent"):EnableGray(vs)
end

function SkillCell:SetUnlockLevelDesc(desc)
	self.View.LockImg.transform:Find("Text_Unlock"):GetComponent("Text").text = desc
end

function SkillCell:Update(cfgSkillsData)
	self.enableClick = true

	self.ViewGo:SetActive(true)
	self:SetIconVisible(true)
	self:SetTopMaskVisible(false)
	self:SetSpTagVisible(SoulSpecialSpiritModule.CheckSpAllActive(cfgSkillsData.Id))
	self:SetCheckVisible(false)
	self.View.SkillTag:SetActive(false)

	self.isLock = false

	self.View.LockImg:SetActive(self.isLock)
	AssetUtil.LoadImage(self, UIGlobalApi.GetSkillQualityBottomPath(cfgSkillsData.Level + 1), self.View.QualityImg:GetComponent("Image"))

	if cfgSkillsData.Icon ~= "" and cfgSkillsData.Icon ~= nil then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgSkillsData.Icon), self.View.Icon:GetComponent("Image"))
	else
		self.View.Icon:GetComponent("Image").sprite = nil
	end

	self:UpdateLv(cfgSkillsData)
end

function SkillCell:UpdateLv(cfgSkillsData)
	local skillStrengthens = self.extraSkillStrengthens ~= nil and self.extraSkillStrengthens or self.soulData ~= nil and self.soulData.activationSkillStrengthen or nil

	if skillStrengthens ~= nil then
		local cfgDatum = SkillModule.GetStrengthen(cfgSkillsData.Id)
		local lv = 0

		for i, v in pairs(cfgDatum) do
			if table.indexOf(skillStrengthens, v.Id) ~= -1 then
				lv = lv + 1
			end
		end

		self.View.SkillLevelText:GetComponent("Text").text = SkillTipApi:GetString("goSkillLv", lv, lv >= #cfgDatum)

		self:SetSkillLevelVisible(lv > 0)
	else
		self:SetSkillLevelVisible(false)
	end
end

function SkillCell:SetCheckVisible(vs)
	self.View.goCheck:SetActive(vs)
end

function SkillCell:AddListeners()
	self:RemoveListeners()
	EventDispatcher.AddEventListener(EventID.SoulSkillStrengthenUpSuccess, self.onSkillStrengthenUpSuccessDelegate)
end

function SkillCell:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.SoulSkillStrengthenUpSuccess, self.onSkillStrengthenUpSuccessDelegate)
end

function SkillCell:OnStrengthenUpSuccess(id)
	if self.CfgSkillsData ~= nil and id == self.CfgSkillsData.Id then
		self:UpdateLv(self.CfgSkillsData)
	end
end
