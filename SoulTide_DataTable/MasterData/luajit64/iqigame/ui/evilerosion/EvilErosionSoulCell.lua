-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionSoulCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.SoulListCell = SoulListCell.New(self.SoulCellGO)

	function self.DelegateOnClickView()
		self:OnClickView()
	end

	function self.DelegateOnLongPressView()
		self:OnLongPressView()
	end

	local longBtn = self.View:GetComponent("LongButton")

	longBtn.repeatCall = false

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("LongButton").onClick:AddListener(self.DelegateOnClickView)
	self.View:GetComponent("LongButton").onLongDownClick:AddListener(self.DelegateOnLongPressView)
end

function m:RemoveListeners()
	self.View:GetComponent("LongButton").onClick:RemoveListener(self.DelegateOnClickView)
	self.View:GetComponent("LongButton").onLongDownClick:RemoveListener(self.DelegateOnLongPressView)
end

function m:SetData(soulPrefabPOD, curFormationPos)
	self.SoulPrefabPOD = soulPrefabPOD
	self.CurFormationPos = curFormationPos
	self.SoulData = SoulModule.CreateCustomSoulData(soulPrefabPOD.soulCid, {
		cid = soulPrefabPOD.soulCid,
		lv = soulPrefabPOD.lv,
		dress2DCid = soulPrefabPOD.dress2DCid,
		dress3DCid = soulPrefabPOD.dress3DCid,
		qualityId = soulPrefabPOD.qualityId,
		soulAttr = soulPrefabPOD.attr,
		activationSkillStrengthen = soulPrefabPOD.allSkillStrengths
	})

	self.SoulListCell:Refresh(self.SoulData, true)
	self.CheckMarkParent:SetActive(curFormationPos ~= nil)
	self:RefreshFormationFlag()
end

function m:RefreshFormationFlag()
	local isCurFormationPos = self.CurFormationPos ~= nil and self.SoulPrefabPOD.formationPos == self.CurFormationPos

	self.CurFormationPosFlag:SetActive(isCurFormationPos)
	self.InFormationFlag:SetActive(self.SoulPrefabPOD.formationPos ~= 0 and not isCurFormationPos)
end

function m:OnLongPressView()
	if self.CurFormationPos ~= nil then
		self:ShowSoulInfo()
	end
end

function m:OnClickView()
	if self.CurFormationPos == nil then
		self:ShowSoulInfo()
	end
end

function m:ShowSoulInfo()
	UIModule.Open(Constant.UIControllerName.EvilErosionSoulInfoUI, Constant.UILayer.UI, {
		soulData = self.SoulData,
		customFeatureSkills = self.SoulPrefabPOD.allSkills
	})
end

function m:SetSelected(value)
	self.CheckMark:SetActive(value)
end

function m:Dispose()
	self:RemoveListeners()
	self.SoulListCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
