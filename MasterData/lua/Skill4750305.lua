-- 超级索尼子
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4750305 = oo.class(SkillBase)
function Skill4750305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4750305:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4750305
	self:AddBuff(SkillEffect[4750305], caster, self.card, data, 4750305)
end
-- 治疗时
function Skill4750305:OnCure(caster, target, data)
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
	-- 4750310
	self:AddBuffCount(SkillEffect[4750310], caster, target, data, 4750310,1,10)
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
	-- 4750315
	self:AddBuffCount(SkillEffect[4750315], caster, target, data, 4750310,math.min(count16,math.floor(count757/2+0.5)),10)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4750305:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4750305
	self:AddBuff(SkillEffect[4750305], caster, self.card, data, 4750305)
end
