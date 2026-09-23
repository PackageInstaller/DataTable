-- 猛襲：易傷Ⅰ
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000030101 = oo.class(BuffBase)
function Buffer1000030101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000030101:OnCreate(caster, target)
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsDamageType(self, self.caster, target, true,1) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 1000030101
	self:AddAttr(BufferEffect[1000030101], self.caster, target or self.owner, nil,"bedamage",0.2)
end
