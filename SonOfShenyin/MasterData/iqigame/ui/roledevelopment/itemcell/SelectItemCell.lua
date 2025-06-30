-- chunkname: @IQIGame\\UI\\RoleDevelopment\\ItemCell\\SelectItemCell.lua

local m = {
	isSkillItem = false,
	ItemExp = 0,
	IsSelect = false,
	SelectCount = 0
}

function m.PackageOrReuseView(ui, view)
	if ui == nil or view == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_ItemCell == nil then
		ui.__SUB_UI_MAP_ItemCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_ItemCell
	local itemCell

	if subUIMap[view:GetInstanceID()] == nil then
		itemCell = m.New(view)
		subUIMap[view:GetInstanceID()] = itemCell
	else
		itemCell = subUIMap[view:GetInstanceID()]
	end

	return itemCell
end

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ReduceBtnComponent = self.ReduceBtn:GetComponent("Button")
	self.ItemCell = ItemCell.New(self.CommonSlotUI, false)

	function self.DelegateItemOnClick()
		self:SelectItemClick()
	end

	function self.DelegateItemOnLongClick()
		self:SelectItemLongClick()
	end

	function self.DelegateReduceBtnClick()
		self:ReduceItemClick()
	end

	function self.DelegateReduceBtnLongClick()
		self:ReduceItemLongClick()
	end

	self.SelectCount = 0

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("LongButton").onClick:AddListener(self.DelegateItemOnClick)
	self.View:GetComponent("LongButton").onLongDownClick:AddListener(self.DelegateItemOnLongClick)
	self.ReduceBtn:GetComponent("LongButton").onClick:AddListener(self.DelegateReduceBtnClick)
	self.ReduceBtn:GetComponent("LongButton").onLongDownClick:AddListener(self.DelegateReduceBtnLongClick)
end

function m:RemoveListeners()
	self.View:GetComponent("LongButton").onClick:RemoveListener(self.DelegateItemOnClick)
	self.View:GetComponent("LongButton").onLongDownClick:RemoveListener(self.DelegateItemOnClick)
	self.ReduceBtn:GetComponent("LongButton").onClick:RemoveListener(self.DelegateReduceBtnClick)
	self.ReduceBtn:GetComponent("LongButton").onLongDownClick:RemoveListener(self.DelegateReduceBtnClick)
end

function m:SetData()
	return
end

function m:SetItem(itemData, isSelected)
	self.ItemData = itemData
	self.SkillData = self.ItemData.skillData
	self.isSkillItem = self.ItemData:GetCfg().ItemTypes == Constant.ItemType.Skill
	self.Quality = self.ItemData:GetCfg().Quality
	self.ItemCount = self.isSkillItem and 1 or self.ItemData.num

	if self.isSkillItem then
		self.ItemExp = self.ItemData.skillData:GetSkillCfgByLevel().OfferExp

		self.TagHero:SetActive(self.SkillData.heroCid ~= 0)

		if self.SkillData.heroCid ~= 0 then
			AssetUtil.LoadImage(self, RoleDevelopmentApi:GetSmartIcon(self.SkillData.heroCid), self.TagHero:GetComponent("Image"))
		end

		self.ItemCell:SetItemLv(self.SkillData.lv)
	else
		self.TagHero:SetActive(false)

		self.ItemExp = self.ItemData:GetCfg().ActionParams[1]

		self.ItemCell:SetNum(self.ItemData.num)
	end

	self.ItemCell:SetItem(self.ItemData)

	self.IsSelect = isSelected

	if not isSelected then
		self.CommonSelect:SetActive(false)
		self.SkillSelect:SetActive(false)
		self.ItemSelect:SetActive(false)

		self.IsSelect = false
		self.SelectCount = 0
	else
		self.CommonSelect:SetActive(true)

		if self.isSkillItem then
			self.SkillSelect:SetActive(true)
		else
			self.ItemSelect:SetActive(true)
		end
	end
end

function m:SelectItemClick()
	if self.isSkillItem then
		self.SelectCount = self.IsSelect == false and 1 or 0

		if self.SelectCount == 1 and RoleDevelopmentModule.IsCanUpgradeSkill then
			NoticeModule.ShowNotice(45011)

			return
		end

		self.CommonSelect:SetActive(not self.IsSelect)
		self.SkillSelect:SetActive(not self.IsSelect)

		self.IsSelect = not self.IsSelect
	else
		if RoleDevelopmentModule.IsCanUpgradeSkill then
			NoticeModule.ShowNotice(20005)

			return
		end

		if self.ItemData.num <= 0 then
			return
		end

		if self.SelectCount == self.ItemData.num then
			return
		end

		self.ItemSelect:SetActive(true)
		self.CommonSelect:SetActive(true)

		self.SelectCount = self.SelectCount + 1

		UGUIUtil.SetText(self.SelectCountText, self.SelectCount)
	end

	self:ShowSelectInfo()
end

function m:SelectItemLongClick()
	for i = 1, 10 do
		if not RoleDevelopmentModule.IsCanUpgradeSkill then
			self:SelectItemClick()
		end
	end
end

function m:ReduceItemClick()
	if self.isSkillItem then
		self.SkillSelect:SetActive(false)
		self.CommonSelect:SetActive(false)

		self.SelectCount = 0
	else
		self.SelectCount = self.SelectCount - 1

		UGUIUtil.SetText(self.SelectCountText, self.SelectCount)

		if self.SelectCount <= 0 then
			self.ItemSelect:SetActive(false)
			self.CommonSelect:SetActive(false)
		end
	end

	self:ShowSelectInfo()
end

function m:ReduceItemLongClick()
	for i = 1, 10 do
		self:ReduceItemClick()
	end
end

function m:ClearSelect()
	self.SelectCount = 0
	self.IsSelect = false

	LuaUtility.SetGameObjectShow(self.CommonSelect, false)

	if self.isSkillItem then
		LuaUtility.SetGameObjectShow(self.SkillSelect, false)
	else
		LuaUtility.SetGameObjectShow(self.ItemSelect, false)
		UGUIUtil.SetText(self.SelectCountText, self.SelectCount)
	end
end

function m:IsMaxSelect()
	return self.SelectCount >= self.ItemCount
end

function m:ShowSelectInfo()
	EventDispatcher.Dispatch(EventID.SelectUpgradeMaterial, {
		[self.ItemData.id] = {
			self.SelectCount,
			self.SelectCount * self.ItemExp
		}
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
