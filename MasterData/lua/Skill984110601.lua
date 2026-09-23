-- 巨蟹座普通形态著天赋被动1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984110601 = oo.class(SkillBase)
function Skill984110601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill984110601:OnBefourHurt(caster, target, data)
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
	-- 8222
	if SkillJudger:IsDamageType(self, caster, target, true,1) then
	else
		return
	end
	-- 984110601
	if self:Rand(3000) then
		self:AddBuffCount(SkillEffect[984110601], caster, self.card, data, 984100601,1,20)
	end
end
-- 回合结束时
function Skill984110601:OnRoundOver(caster, target, data)
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 984110603
	if SkillJudger:Equal(self, caster, target, true,(playerturn%2),0) then
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
	-- 984110602
	self:AddProgress(SkillEffect[984110602], caster, self.card, data, 100)
end
