-- 對【易傷】目標造成額外30%傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000030121 = oo.class(BuffBase)
function Buffer1000030121:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000030121:OnCreate(caster, target)
	-- 1000030121
	if SkillJudger:HasBuff(self, self.caster, target, true,2,1000030101) then
	else
		return
	end
end
