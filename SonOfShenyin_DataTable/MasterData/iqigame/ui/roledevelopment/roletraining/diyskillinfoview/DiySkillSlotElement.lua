-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleTraining\\DiySkillInfoView\\DiySkillSlotElement.lua

local SkillItemComponent = {
	isLock = false,
	skillPos = 0
}

function SkillItemComponent.New(view, clickCallback)
	local obj = Clone(SkillItemComponent)

	obj:__Init(view, clickCallback)

	return obj
end

function SkillItemComponent:__Init(view, clickCallback)
	self.gameObject = view
	self.onClickEvent = clickCallback

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__itemClickEventProxy()
		if self.onClickEvent ~= nil then
			self.onClickEvent(self.isLock, self.skillPos)
		end
	end

	self.gameObject:GetComponent("Button").onClick:AddListener(self.__itemClickEventProxy)
end

function SkillItemComponent:SetData(heroCid, skillPos)
	self.heroCid = heroCid
	self.skillPos = skillPos

	self:Refresh()
end

function SkillItemComponent:Refresh()
	self.isLock = WarlockModule.WarlockDataDic[self.heroCid].lv < WarlockModule.WarlockDataDic[self.heroCid]:GetCfg().DiyField[self.skillPos - Constant.DIYSkillEquipPos.POS_1 + 1]

	if self.isLock then
		self:__ShowLockState()
	else
		self:__ShowUnLockState()
	end
end

function SkillItemComponent:__ShowLockState()
	self.lockState:SetActive(true)
	self.selectState:SetActive(false)
	self.normalState:SetActive(false)
	self.equipedState:SetActive(false)
end

function SkillItemComponent:__ShowUnLockState()
	self.lockState:SetActive(false)

	local skillData = RoleDevelopmentModule.GetCurHeroSkill(self.heroCid)[self.skillPos]
	local isEmpty = skillData == nil

	self.equipedState:SetActive(not isEmpty)
	self.normalState:SetActive(isEmpty)

	if isEmpty then
		return
	end

	local itemCfg = DiySkillModule.GetItemCfgWithDiySkill(skillData)
	local path = string.format(BaseLangApi:GetResUrl(2200), itemCfg.Quality)

	AssetUtil.LoadImage(self, path, self.qualityImg:GetComponent("Image"))

	local iconPath = UIGlobalApi.GetIconPath(CfgItemTable[skillData.itemCid].Icon)

	AssetUtil.LoadImage(self, iconPath, self.skillImg:GetComponent("Image"))

	self.costNumText:GetComponent("Text").text = skillData:GetCfg().NeedCost
end

function SkillItemComponent:ChangeSelect(isSelect)
	if self.isLock then
		-- block empty
	end

	local active = isSelect

	self.selectState:SetActive(active)
end

function SkillItemComponent:Show()
	self.gameObject:SetActive(true)
end

function SkillItemComponent:Hide()
	self.gameObject:SetActive(false)
end

function SkillItemComponent:Dispose()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.__itemClickEventProxy)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local DiySkillSlotElement = {}

function DiySkillSlotElement.New(view, skillChangeCallback)
	local obj = Clone(DiySkillSlotElement)

	obj:__Init(view, skillChangeCallback)

	return obj
end

function DiySkillSlotElement:__Init(view, skillChangeCallback)
	self.gameObject = view
	self.onSkillChangeEvent = skillChangeCallback

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.skillItem1 = SkillItemComponent.New(self.skillSlot1, function(isLock, skillPos)
		self:__OnSkillItemClickEventHandler(isLock, skillPos)
	end)
	self.skillItem2 = SkillItemComponent.New(self.skillSlot2, function(isLock, skillPos)
		self:__OnSkillItemClickEventHandler(isLock, skillPos)
	end)

	self:__AddListeners()
end

function DiySkillSlotElement:__AddListeners()
	return
end

function DiySkillSlotElement:__RemoveListeners()
	return
end

function DiySkillSlotElement:Dispose()
	self:__RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function DiySkillSlotElement:SetData(heroCid, selectSkillPos)
	self.heroCid = heroCid

	self.skillItem1:SetData(heroCid, Constant.DIYSkillEquipPos.POS_1)
	self.skillItem2:SetData(heroCid, Constant.DIYSkillEquipPos.POS_2)

	self.curSkillPos = nil

	self:__ChangeSelectSkill(selectSkillPos)
end

function DiySkillSlotElement:Refresh()
	self.skillItem1:Refresh()
	self.skillItem2:Refresh()
end

function DiySkillSlotElement:__ChangeSelectSkill(skillPos)
	self.curSkillPos = skillPos

	if skillPos == Constant.DIYSkillEquipPos.POS_1 then
		self.skillItem1:ChangeSelect(true)
		self.skillItem2:ChangeSelect(false)
	elseif skillPos == Constant.DIYSkillEquipPos.POS_2 then
		self.skillItem2:ChangeSelect(true)
		self.skillItem1:ChangeSelect(false)
	end

	if self.onSkillChangeEvent ~= nil then
		self.onSkillChangeEvent(self.heroCid, skillPos)
	end
end

function DiySkillSlotElement:__OnSkillItemClickEventHandler(isLock, skillPos)
	if isLock then
		local limitLV = skillPos == Constant.DIYSkillEquipPos.POS_1 and CfgDiscreteDataTable[28].Data[1] or CfgDiscreteDataTable[29].Data[1]

		NoticeModule.ShowNoticeByType(Constant.NoticeType.FloatTips, RoleDevelopmentApi:GetDIYSkillLockedTips(limitLV))

		return
	end

	self:__ChangeSelectSkill(skillPos)
end

return DiySkillSlotElement
