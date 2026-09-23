-- 閃電戰術
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer750100203 = oo.class(BuffBase)
function Buffer750100203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer750100203:OnBefourHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8262
	if SkillJudger:IsCallSkill(self, self.caster, target, true) then
	else
		return
	end
	-- 750100213
	self:AddTempAttr(BufferEffect[750100213], self.caster, self.card, nil, "damage",0.15)
end
-- 创建时
function Buffer750100203:OnCreate(caster, target)
	-- 750100201
	self:AddProgress(BufferEffect[750100201], self.caster, self.card, nil, 100)
end
