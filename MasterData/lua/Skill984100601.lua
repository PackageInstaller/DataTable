-- 巨蟹座普通形态著天赋被动1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984100601 = oo.class(SkillBase)
function Skill984100601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill984100601:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8223
	if SkillJudger:IsDamageType(self, caster, target, true,2) then
	else
		return
	end
	-- 984100601
	if self:Rand(3000) then
		self:AddBuffCount(SkillEffect[984100601], caster, self.card, data, 984100601,1,20)
	end
end
-- 回合结束时
function Skill984100601:OnRoundOver(caster, target, data)
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 984100603
	if SkillJudger:Equal(self, caster, target, true,(playerturn%2),1) then
	else
		return
	end
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 907800610
	if SkillJudger:Greater(self, caster, self.card, true,playerturn,0) then
	else
		return
	end
	-- 984100602
	self:AddProgress(SkillEffect[984100602], caster, self.card, data, 100)
end
