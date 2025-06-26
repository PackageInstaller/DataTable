-- chunkname: @IQIGame\\UI\\Maze\\MazeSoulHeadCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.ClickHandler()
		self:OnClick()
	end

	self.DefaultClickHandler = self.ClickHandler

	function self.DelegateOnClick()
		self.ClickHandler()
	end

	function self.DelegateOnUpdateDollAttr(dollId, attrId, attrValue)
		self:OnUpdateDollAttr(dollId, attrId, attrValue)
	end

	self.GrayComponent = self.View:GetComponent("ImageGroupGrayComponent")

	self:AddEventListeners()
end

function m:AddEventListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
	EventDispatcher.AddEventListener(EventID.MazeUpdateDollAttr, self.DelegateOnUpdateDollAttr)
end

function m:RemoveEventListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateDollAttr, self.DelegateOnUpdateDollAttr)
end

function m:SetData(dollData, soulAvatarData, changedProp)
	self.DollData = dollData

	self.View:SetActive(dollData ~= nil)

	if dollData == nil then
		return
	end

	local headIcon02

	if soulAvatarData == nil then
		local cfgDressData = CfgDressTable[dollData.dress2DCid]
		local cfgSoulResData = CfgSoulResTable[cfgDressData.SoulResID]

		headIcon02 = cfgSoulResData.HeadIcon02
	else
		headIcon02 = soulAvatarData.headIcon02
	end

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(headIcon02), self.Icon:GetComponent("Image"))
	self:SetHp(dollData.finalAttributes[Constant.Attribute.TYPE_HP])
	self:SetSkillEnergy(dollData.finalAttributes[Constant.Attribute.TYPE_SKILL_ENERGY])
	UGUIUtil.SetText(self.LevelText, MazeMainUIApi:GetString("DollLevelText", dollData.lv, MazeDataModule.ChapterType))

	if changedProp ~= nil and changedProp.lv > 0 then
		GameEntry.Effect:PlayUIMountPointEffect(9000518, 50000, 0, self.View, Constant.Unity.SortingOrderMaxValue)
	end
end

function m:OnClick()
	return
end

function m:SetClickHandler(handler, owner)
	function self.ClickHandler()
		if handler ~= nil then
			handler(owner, self)
		end
	end
end

function m:ResetClickHandler()
	self.ClickHandler = self.DefaultClickHandler
end

function m:SetHp(value)
	self.HpBar:GetComponent("Image").fillAmount = value / self.DollData.finalAttributes[Constant.Attribute.TYPE_HP_MAX]

	self.GrayComponent:EnableGray(value == 0)
end

function m:SetSkillEnergy(value)
	self.SkillEnergyBar:GetComponent("Image").fillAmount = value / CfgDiscreteDataTable[6506027].Data[1]
end

function m:OnUpdateDollAttr(dollId, attrId, attrValue)
	if self.DollData ~= nil and self.DollData.id == dollId then
		if attrId == Constant.Attribute.TYPE_HP then
			self:SetHp(attrValue)
		end

		if attrId == Constant.Attribute.TYPE_SKILL_ENERGY then
			self:SetSkillEnergy(attrValue)
		end
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveEventListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.ClickHandler = nil
	self.GrayComponent = nil
end

return m
