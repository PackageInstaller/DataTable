-- 超级索尼子
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4750302 = oo.class(SkillBase)
function Skill4750302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4750302:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4750302
	self:AddBuff(SkillEffect[4750302], caster, self.card, data, 4750302)
end
-- 治疗时
function Skill4750302:OnCure(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 4750307
	self:AddBuffCount(SkillEffect[4750307], caster, target, data, 4750307,1,10)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8416
	local count16 = SkillApi:BuffCount(self, caster, target,2,2,2)
	-- 8108
	if SkillJudger:Greater(self, caster, self.card, true,count16,0) then
	else
		return
	end
	-- 8757
	local count757 = SkillApi:SkillLevel(self, caster, target,3,7503003)
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 4750312
	self:AddBuffCount(SkillEffect[4750312], caster, target, data, 4750307,math.min(count16,math.floor(count757/2+0.5)),10)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4750302:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4750302
	self:AddBuff(SkillEffect[4750302], caster, self.card, data, 4750302)
end
