-- chunkname: @IQIGame\\UI\\SoulSkill\\SoulSkillGroupCell.lua

local SoulSkillGroupCell = {
	classTypeCellPool = {},
	tagTypeCellPool = {}
}

function SoulSkillGroupCell.New(view, mainView, groupIndex)
	local obj = Clone(SoulSkillGroupCell)

	obj:Init(view, mainView, groupIndex)

	return obj
end

function SoulSkillGroupCell:Init(view, mainView, groupIndex)
	self.View = view
	self.mainView = mainView
	self.groupIndex = groupIndex

	LuaCodeInterface.BindOutlet(self.View, self)

	self.icon = self.goIcon:GetComponent("Image")
	self.tfGroupName = self.goName:GetComponent("Text")
	self.tfCondition = self.goCondition:GetComponent("Text")

	self.goSignSelect:SetActive(false)

	for i = 1, 4 do
		if i <= 2 then
			self.classTypeCellPool[#self.classTypeCellPool + 1] = self.goTypeParent.transform:Find("type_" .. i).gameObject
		else
			self.tagTypeCellPool[#self.tagTypeCellPool + 1] = self.goTypeParent.transform:Find("type_" .. i).gameObject
		end
	end

	self.btnSelf = self.goBtnSelf:GetComponent("Button")

	function self.onClickBtnSelfDelegate()
		self:OnClickBtnSelf()
	end

	if self.goUnlockDesc ~= nil then
		self.goUnlockDesc:GetComponent("Text").text = SoulUIApi:GetString("skillViewUnlockDescGroup3")
	end
end

function SoulSkillGroupCell:Refresh(soulData, cfgGroupData)
	self.soulData = soulData
	self.cfgGroupData = cfgGroupData
	self.isUnlock = SkillModule.CheckSkillGroupUnlock(self.soulData, self.cfgGroupData.Id)

	if self.groupIndex ~= 3 then
		self.skillIds = self.cfgGroupData.GroupSkills
	else
		self.skillIds = self.soulData.customSkills or {}

		if #self.skillIds == 0 then
			local groupId = CfgSoulTable[self.soulData.soulCid].DefaultSkill[1]
			local cfgGroupData = CfgSkillGroupTable[groupId]

			self.skillIds = cfgGroupData.GroupSkills
		end
	end

	self:RefreshMisc()
	self:RefreshTypeCells()
end

function SoulSkillGroupCell:OnHide()
	return
end

function SoulSkillGroupCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.mainView = nil
	self.View = nil
end

function SoulSkillGroupCell:OnAddListeners()
	self.btnSelf.onClick:AddListener(self.onClickBtnSelfDelegate)
end

function SoulSkillGroupCell:OnRemoveListeners()
	self.btnSelf.onClick:RemoveListener(self.onClickBtnSelfDelegate)
end

function SoulSkillGroupCell:OnClickBtnSelf()
	self.mainView:OnClickGroupCell(self)
end

function SoulSkillGroupCell:RefreshMisc()
	self.tfCondition.text = SoulUIApi:GetString("skillViewGroupUnlockCondition", self.cfgGroupData.UnlockLv)
	self.tfGroupName.text = SoulUIApi:GetString("skillVieGroupName", self.cfgGroupData.GroupName)

	self.icon.gameObject:GetComponent("GrayComponent"):SetGray(not self.isUnlock)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.cfgGroupData.Icon), self.icon)
	self.goLockBlock:SetActive(not self.isUnlock)
	self.goUnlockBlock:SetActive(self.isUnlock)

	local showRedPoint = false

	if self.isUnlock and self.groupIndex ~= 3 then
		for i, v in pairs(self.skillIds) do
			if SkillModule.CheckSkillCanUp(self.soulData, CfgSkillTable[v]) then
				showRedPoint = true

				break
			end
		end
	end

	self.goRedPoint:SetActive(showRedPoint)
end

function SoulSkillGroupCell:RefreshTypeCells()
	for i = 1, 2 do
		local typeCell = self.classTypeCellPool[i]

		if i <= #self.cfgGroupData.SoulClass then
			typeCell.transform:Find("Text"):GetComponent("Text").text = MiscApi:GetString("SoulClass", self.cfgGroupData.SoulClass[i])

			local bg = typeCell.transform:Find("Image"):GetComponent("Image")

			AssetUtil.LoadImage(self, MiscApi:GetString("SoulClassBgImage", self.cfgGroupData.SoulClass[i]), bg)
			typeCell:SetActive(true)
		else
			typeCell:SetActive(false)
		end
	end

	for i = 1, 2 do
		local typeCell = self.tagTypeCellPool[i]

		if i <= #self.cfgGroupData.SkillTag then
			typeCell.transform:Find("Text"):GetComponent("Text").text = MiscApi:GetString("SkillTag", self.cfgGroupData.SkillTag[i])

			typeCell:SetActive(true)
		else
			typeCell:SetActive(false)
		end
	end
end

return SoulSkillGroupCell
