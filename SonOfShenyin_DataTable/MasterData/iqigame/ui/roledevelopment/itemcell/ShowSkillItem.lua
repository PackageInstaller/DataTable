-- chunkname: @IQIGame\\UI\\RoleDevelopment\\ItemCell\\ShowSkillItem.lua

local m = {
	isDiySkill = false,
	LimitLv = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSill()
		self:OnSkillClick()
	end

	LuaUtility.SetGameObjectShow(self.LockLevelText, false)
	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSill)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSill)
end

function m:SetData(skillData, skillType)
	self:OnCancelSelect()

	self.SkillData = skillData
	self.SelectIndex = skillType
	self.LimitLv = 0

	if skillType == Constant.DIYSkillEquipPos.POS_1 then
		self.LimitLv = CfgDiscreteDataTable[28].Data[1]
	elseif skillType == Constant.DIYSkillEquipPos.POS_2 then
		self.LimitLv = CfgDiscreteDataTable[29].Data[1]
	end

	self.isDiySkill = skillType == Constant.SkillType.TYPE_LORE

	local isReachLv = WarlockModule.WarlockDataDic[RoleDevelopmentModule.CurSelectHeroCid].lv >= self.LimitLv

	if self.SkillData ~= nil then
		UGUIUtil.SetText(self.SkillTypeText, self.SkillData:GetSkillType())
	end

	UGUIUtil.SetText(self.LockLevelText, self.LimitLv)
	UGUIUtil.SetText(self.LockInfo, RoleDevelopmentApi:GetSkillOpenConditionText(self.LimitLv))
	self.BaseSkill:SetActive(not self.isDiySkill)
	self.DiySkill:SetActive(self.isDiySkill and self.SkillData ~= nil)
	self.Equip:SetActive(self.SkillData ~= nil)
	self.Image_Element:SetActive(self.isDiySkill)
	self.Image_Type:SetActive(self.isDiySkill)

	self.IsOpen = isReachLv

	if self.isDiySkill then
		self.Lock:SetActive(not isReachLv and self.SkillData == nil)
		self.UnEquip:SetActive(self.SkillData == nil)

		if self.SkillData ~= nil then
			self:LoadImage(string.format(BaseLangApi:GetResUrl(1100041), CfgSkillDetailTable[self.SkillData.skillCid].Element), self.Image_Element)
			self:LoadImage(UIGlobalApi.GetIconPath(CfgItemTable[self.SkillData.itemCid].Icon), self.Image_Icon)
			self:LoadImage(CommonSlotUIApi:GetSkillTypeImg(self.SkillData:GetCfg().ManualSkill), self.Image_Type)
			self:RefreshSkillBreachStar()
		end
	else
		self.Lock:SetActive(false)
		self.UnEquip:SetActive(false)
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.SkillData:GetCfg().Icon), self.SkillIcon:GetComponent("Image"))
	end

	if self.SelectIndex == RoleDevelopmentModule.CurSelectSkillPos then
		self:OnSelect()
	end
end

function m:RefreshSkillBreachStar()
	LuaUtility.SetGameObjectShow(self.BreachStar, true)

	local starComp = self.BreachStar:GetComponent("SimpleStarComponent")
	local cells = starComp.cells.Count

	for i = 1, cells do
		local simpleStarCell = starComp.cells[i - 1]

		self:LoadImage(CommonSlotUIApi:GetSkillBreachStarImg(CfgItemTable[self.SkillData.itemCid].Quality), simpleStarCell.lightPart)
	end

	starComp:UpdateView(CfgItemTable[self.SkillData.itemCid].Quality, CfgItemTable[self.SkillData.itemCid].Quality)
end

function m:LoadImage(path, obj)
	AssetUtil.LoadImage(self, path, obj:GetComponent("Image"), nil, nil, nil, true)
end

function m:OnSetMaskState(state)
	if state then
		LuaUtility.SetGameObjectShow(self.GreyImg, not self.isDiySkill)
	else
		LuaUtility.SetGameObjectShow(self.GreyImg, self.isDiySkill)
	end
end

function m:OnSelect()
	self.Select:SetActive(true)
end

function m:OnCancelSelect()
	self.Select:SetActive(false)
end

function m:OnSkillClick()
	if self.IsOpen then
		self:OnSelect()
		EventDispatcher.Dispatch(EventID.ClickSkillShowItemEvent, self.SkillData, self.SelectIndex)
	else
		NoticeModule.ShowNoticeByType(1, RoleDevelopmentApi:GetLvIsNoReachTitle(self.LimitLv))
	end
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
