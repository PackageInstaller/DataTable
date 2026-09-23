-- 暴傷永久增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5800050 = oo.class(BuffBase)
function Buffer5800050:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5800050:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 5800050
	self:AddAttr(BufferEffect[5800050], self.caster, self.card, nil, "crit",0.01*self.nCount)
end
