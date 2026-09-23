-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer110008033 = oo.class(BuffBase)
function Buffer110008033:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer110008033:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 110008033
	self:LimitDamage(BufferEffect[110008033], self.caster, target or self.owner, nil,0.3,1.2)
end
