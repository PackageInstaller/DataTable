-- chunkname: @IQIGame\\UI\\Battle\\BattleHUD\\BattleHUDEnergyView.lua

local m = {
	spriteUVMapping = "_UVMapping",
	energyPowerKey = "_EnergyPower"
}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	local _material = self.energyImage.gameObject:GetComponent(typeof(UnityEngine.UI.Image)).material

	self.material = UnityEngine.Object.Instantiate(_material)
	self.energyImage.gameObject:GetComponent(typeof(UnityEngine.UI.Image)).material = self.material

	self.material:SetVector(self.spriteUVMapping, UGUIUtil.GetSpriteNormalizedUV(self.energyImage.gameObject:GetComponent(typeof(UnityEngine.UI.Image))))
end

function m:InitEnergyShow(battleUnitData)
	self.gameObject:SetActive(true)
end

function m:HideEnergy()
	self.gameObject:SetActive(false)
end

function m:UpdateEnergy(battleUnitData)
	local skillData = battleUnitData:GetSkillBySkillType(Constant.SkillType.TYPE_ULTIMATE)
	local maxValue = skillData == nil and 0 or skillData.energyCost

	if maxValue <= 0 then
		if skillData == nil then
			if battleUnitData.isFriendly then
				warning("当前战斗单位 {0} 未配置秘笈技能", battleUnitData.battleUnitID)
			end
		else
			warning("当前战斗单位 {0} 秘笈技能 {1} 消耗为 0 请检查", battleUnitData.battleUnitID, skillData.skillCid)
		end

		self.material:SetFloat("_EnergyPower", 0)

		return
	end

	local power = battleUnitData.energy / maxValue

	if power > 2 then
		power = 2
	end

	self.material:SetFloat("_EnergyPower", power)
end

function m:Dispose()
	self.material = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return m
