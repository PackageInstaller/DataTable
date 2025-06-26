-- chunkname: @IQIGame\\UI\\Tips\\SkillTipContent.lua

local SkillTipContent = {
	txtPool = {}
}

function SkillTipContent.New(go)
	local o = Clone(SkillTipContent)

	o:Initialize(go)

	return o
end

function SkillTipContent:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.tfDesc = self.goDesc:GetComponent("Text")
	self.tfEffect = self.goEffect:GetComponent("Text")
	self.txtPool[1] = self.goStrengthDesc:GetComponent("Text")
	self.goStrengthenTitle:GetComponent("Text").text = SkillTipApi:GetString("goStrengthenTitle")
end

function SkillTipContent:RefreshView(cfgSkillData)
	self.cfgSkillData = cfgSkillData

	self:RefreshMisc()
	self:RefreshStrengthBlock()
end

function SkillTipContent:RefreshMisc()
	self.tfDesc.text = SkillTipApi:GetString("goEffect", self.cfgSkillData.Describe)
end

function SkillTipContent:RefreshStrengthBlock()
	local soulData = SoulModule.soulDataDic[CfgSkillTable[self.cfgSkillData.Id].UnLockSoul]
	local cfgStrengthenDatum = SkillModule.GetStrengthen(self.cfgSkillData.Id)

	self.goStrengthenTitle.transform.parent.gameObject:SetActive(#cfgStrengthenDatum ~= 0)
	self.goStrengthDesc.transform.parent.parent.gameObject:SetActive(#cfgStrengthenDatum ~= 0)
	self.goDesc.transform.gameObject:SetActive(#cfgStrengthenDatum ~= 0)

	for i, v in pairs(self.txtPool) do
		v.gameObject:SetActive(false)
	end

	for i, v in ipairs(cfgStrengthenDatum) do
		local comTxt = self:GetStrengthCell(i)

		if soulData ~= nil then
			comTxt.text = SkillTipApi:GetString("goStrengthenTypeDesc", v.Name, v.EffectText, table.indexOf(soulData.activationSkillStrengthen, v.Id) ~= -1)
		else
			comTxt.text = SkillTipApi:GetString("goStrengthenTypeDesc", v.Name, v.EffectText, false)
		end
	end

	self.tfEffect.text = SkillTipApi:GetString("goDesc", self.cfgSkillData.EffectText)

	if soulData ~= nil then
		for i, v in ipairs(cfgStrengthenDatum) do
			if table.indexOf(soulData.activationSkillStrengthen, v.Id) ~= -1 then
				self.tfEffect.text = SkillTipApi:GetString("goDesc", v.Describe)
			end
		end
	end
end

function SkillTipContent:GetStrengthCell(index)
	local ret = self.txtPool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.goStrengthDesc):GetComponent("Text")

		ret.transform:SetParent(self.goStrengthDesc.transform.parent, false)

		self.txtPool[index] = ret
	end

	ret.gameObject:SetActive(true)

	return ret
end

function SkillTipContent:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.txtPool = nil
end

return SkillTipContent
