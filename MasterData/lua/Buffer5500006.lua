-- ex關卡buff6
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5500006 = oo.class(BuffBase)
function Buffer5500006:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5500006:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 5500006
	self:AddSkill(BufferEffect[5500006], self.caster, self.card, nil, 5500006)
end
