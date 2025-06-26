-- chunkname: @IQIGame\\UI\\MazeFightPanel\\PowerUpItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickJumpBtn()
		self:OnClickJumpBtn()
	end

	self.JumpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickJumpBtn)
end

function m:SetData(labelText, buttonText, curValue, recommendValue, formationIndex, jumpId)
	self.formationIndex = formationIndex
	self.JumpId = jumpId

	local cfgFunctionData = CfgFunctionTable[self.JumpId]
	local isUnlock = cfgFunctionData.FunctionOpen == nil or cfgFunctionData.FunctionOpen == 0 or UnlockFunctionModule.IsUnlock(cfgFunctionData.FunctionOpen)

	self.View:SetActive(isUnlock)

	if not isUnlock then
		return
	end

	UGUIUtil.SetText(self.LabelText, labelText)
	UGUIUtil.SetText(self.ProgressText, MazeFightPanelUIApi:GetString("ProgressText", curValue, recommendValue))
	UGUIUtil.SetTextInChildren(self.JumpBtn, buttonText)

	local progress = curValue / recommendValue

	if progress > 1 then
		progress = 1
	end

	self.ProgressBar:GetComponent("Image").fillAmount = progress
end

function m:OnClickJumpBtn()
	local formationPOD = PlayerModule.PlayerInfo.formations[self.formationIndex]

	if formationPOD == nil then
		return
	end

	local functionType = CfgFunctionTable[self.JumpId].FunctionType

	if functionType == Constant.Function.openSoulLevelUpUI then
		self:JumpToSoulLevelUp(formationPOD)
	elseif functionType == Constant.Function.openSoulEvolutionUI then
		self:JumpToSoulStarUp(formationPOD)
	elseif functionType == Constant.Function.openSoulUI then
		self:JumpToSoulTalentUp(formationPOD)
	elseif functionType == Constant.Function.openSoulUI then
		self:JumpToSoulSkillUp(formationPOD)
	elseif functionType == Constant.Function.openGirlUI then
		JumpModule.Jump(self.JumpId)
	end
end

function m:JumpToSoulLevelUp(formationPOD)
	local lastSoulData, lastPrefabData

	for i, v in pairs(formationPOD.formation) do
		local prefabData = SoulPrefabModule.GetPrefab(i)
		local soulData = SoulModule.GetSoulData(prefabData.soulCid)

		if lastSoulData == nil then
			lastSoulData = soulData
			lastPrefabData = prefabData
		elseif soulData.lv < lastSoulData.lv then
			lastSoulData = soulData
			lastPrefabData = prefabData
		end
	end

	if lastSoulData == nil or lastPrefabData == nil then
		return
	end

	local jumpData = {
		lastSoulData,
		lastPrefabData,
		self.formationIndex
	}

	JumpModule.Jump(self.JumpId, jumpData)
end

function m:JumpToSoulStarUp(formationPOD)
	local lastSoulData, lastPrefabData

	for i, v in pairs(formationPOD.formation) do
		local prefabData = SoulPrefabModule.GetPrefab(i)
		local soulData = SoulModule.GetSoulData(prefabData.soulCid)

		if lastSoulData == nil then
			lastSoulData = soulData
			lastPrefabData = prefabData
		else
			local cfgQualityData = soulData:GetCfgSoulQuality()
			local lastCfgQualityData = lastSoulData:GetCfgSoulQuality()

			if cfgQualityData.Quality < lastCfgQualityData.Quality then
				lastSoulData = soulData
				lastPrefabData = prefabData
			elseif cfgQualityData.Quality == lastCfgQualityData.Quality and cfgQualityData.QualityLevel < lastCfgQualityData.QualityLevel then
				lastSoulData = soulData
				lastPrefabData = prefabData
			end
		end
	end

	if lastSoulData == nil or lastPrefabData == nil then
		return
	end

	local jumpData = {
		lastSoulData,
		lastPrefabData,
		self.formationIndex
	}

	JumpModule.Jump(self.JumpId, jumpData)
end

function m:JumpToSoulTalentUp(formationPOD)
	local lastSoulData

	for i, v in pairs(formationPOD.formation) do
		local prefabData = SoulPrefabModule.GetPrefab(i)
		local soulData = SoulModule.GetSoulData(prefabData.soulCid)

		if lastSoulData == nil then
			lastSoulData = soulData
		elseif #soulData.talentCids < #lastSoulData.talentCids then
			lastSoulData = soulData
		end
	end

	if lastSoulData == nil then
		return
	end

	JumpModule.Jump(self.JumpId, lastSoulData.soulCid)
end

function m:JumpToSoulSkillUp(formationPOD)
	local lastSoulData, lastPrefabData

	for i, v in pairs(formationPOD.formation) do
		local prefabData = SoulPrefabModule.GetPrefab(i)
		local soulData = SoulModule.GetSoulData(prefabData.soulCid)

		if lastSoulData == nil then
			lastSoulData = soulData
			lastPrefabData = prefabData
		else
			local skillLvTotal = 0
			local curSkills = prefabData:GetSkills()

			if curSkills ~= nil then
				for index, skillCid in pairs(curSkills) do
					skillLvTotal = skillLvTotal + SkillModule.GetSkillLv(skillCid, soulData)
				end
			end

			local lastSkillLvTotal = 0
			local lastSkills = lastPrefabData:GetSkills()

			if lastSkills ~= nil then
				for index, skillCid in pairs(lastSkills) do
					lastSkillLvTotal = lastSkillLvTotal + SkillModule.GetSkillLv(skillCid, soulData)
				end
			end

			if skillLvTotal < lastSkillLvTotal then
				lastSoulData = soulData
				lastPrefabData = prefabData
			end
		end
	end

	if lastSoulData == nil then
		return
	end

	JumpModule.Jump(self.JumpId, lastSoulData.soulCid)
end

function m:GetJumpSoulCid_1(formationPOD)
	local soulCid

	for i, v in pairs(formationPOD.formation) do
		local prefabData = SoulPrefabModule.GetPrefab(i)
		local count = 0

		for i, v in pairs(prefabData.equipItemDatum) do
			count = count + 1
		end

		if count == 0 then
			local equips = WarehouseModule.GetItemsByType(Constant.ItemType.Equip)

			for m, n in pairs(equips) do
				if n.equipData ~= nil and n.equipData.isWore == false then
					soulCid = prefabData.soulCid

					return soulCid
				end
			end
		end
	end

	return soulCid
end

function m:GetJumpSoulCid_2(formationPOD)
	local lastEquipData

	for i, v in pairs(formationPOD.formation) do
		local prefabData = SoulPrefabModule.GetPrefab(i)

		for m, n in pairs(prefabData.equipItemDatum) do
			if lastEquipData == nil then
				lastEquipData = n
			elseif self:GetEquipScore(n) < self:GetEquipScore(lastEquipData) then
				lastEquipData = n
			end
		end
	end

	return lastEquipData
end

function m:GetJumpSoulCid_3(formationPOD)
	for i, v in pairs(formationPOD.formation) do
		local prefabData = SoulPrefabModule.GetPrefab(i)

		return prefabData.soulCid
	end

	return nil
end

function m:GetEquipScore(equipData)
	local cfgItemData = equipData:GetCfg()

	return cfgItemData.Quality * 100 + equipData.equipData.lv * 10 + equipData.equipData.star
end

function m:Dispose()
	self.JumpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickJumpBtn)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
