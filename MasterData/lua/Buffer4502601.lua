-- 攻擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4502601 = oo.class(BuffBase)
function Buffer4502601:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4502601:OnCreate(caster, target)
	-- 8494
	local c94 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3332)
	-- 4502601
	self:AddAttr(BufferEffect[4502601], self.caster, self.card, nil, "attack",(250+c94*50)*self.nCount)
end
