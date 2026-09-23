-- 能級：易傷Ⅰ
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040101 = oo.class(BuffBase)
function Buffer1000040101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000040101:OnCreate(caster, target)
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8221
	if SkillJudger:IsDamageType(self, self.caster, target, true,2) then
	else
		return
	end
	-- 1000040101
	self:AddAttr(BufferEffect[1000040101], self.caster, target or self.owner, nil,"bedamage",0.2)
end
