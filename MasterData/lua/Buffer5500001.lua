-- ex關卡buff1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5500001 = oo.class(BuffBase)
function Buffer5500001:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5500001:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 5500001
	self:AddSkill(BufferEffect[5500001], self.caster, self.card, nil, 5500001)
end
