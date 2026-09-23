-- 逆流
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302305 = oo.class(SkillBase)
function Skill302305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill302305:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8617
	local count617 = SkillApi:GetBeDamagePhysics(self, caster, target,3)
	-- 8617
	local count617 = SkillApi:GetBeDamagePhysics(self, caster, target,3)
	-- 8817
	if SkillJudger:Greater(self, caster, target, true,count617,0) then
	else
		return
	end
	-- 302305
	self:AddBuff(SkillEffect[302305], caster, caster, data, 302301)
	-- 302325
	self:AddHp(SkillEffect[302325], self.card, caster, data, math.floor(-count617*0.8))
	-- 302315
	self:AddHp(SkillEffect[302315], caster, self.card, data, math.floor(count617*0.4))
end
