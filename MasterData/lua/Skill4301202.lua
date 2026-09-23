-- 预热
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4301202 = oo.class(SkillBase)
function Skill4301202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4301202:OnActionOver(caster, target, data)
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
	-- 8616
	local count616 = SkillApi:GetBeDamage(self, caster, target,3)
	-- 8816
	if SkillJudger:Greater(self, caster, target, true,count616,0) then
	else
		return
	end
	-- 4301202
	self:OwnerAddBuffCount(SkillEffect[4301202], caster, self.card, data, 4301202,1,5)
	-- 4301206
	self:AddNp(SkillEffect[4301206], caster, self.card, data, 10)
	-- 4301207
	self:ShowTips(SkillEffect[4301207], caster, self.card, data, 2,"预热",true,4301207)
end
