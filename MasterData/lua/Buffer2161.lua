-- 輝石護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2161 = oo.class(BuffBase)
function Buffer2161:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer2161:OnRemoveBuff(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 4102404
	self:CreaterAddBuff(BufferEffect[4102404], self.caster, self.caster, nil, 4102405)
	-- 8218
	if SkillJudger:IsShieldDestroy(self, self.caster, target, true) then
	else
		return
	end
	-- 2003
	self:Cure(BufferEffect[2003], self.caster, self.card, nil, 8,0.15)
	-- 8472
	local c72 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3214)
	-- 8624
	if SkillJudger:Greater(self, self.caster, self.card, true,c72,0) then
	else
		return
	end
	-- 321406
	self:AddProgress(BufferEffect[321406], self.caster, self.card, nil, c72*50)
end
-- 创建时
function Buffer2161:OnCreate(caster, target)
	-- 2115
	self:AddShield(BufferEffect[2115], self.caster, target or self.owner, nil,1,0.16)
end
