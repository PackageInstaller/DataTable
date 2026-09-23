-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4303101 = oo.class(BuffBase)
function Buffer4303101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer4303101:OnActionOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 4303101
	self:DelBufferForce(BufferEffect[4303101], self.caster, self.card, nil, 4303101,3)
end
-- 创建时
function Buffer4303101:OnCreate(caster, target)
	-- 4802
	self:AddAttr(BufferEffect[4802], self.caster, target or self.owner, nil,"damage",0.1)
end
