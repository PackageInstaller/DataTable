-- 攻擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4601611 = oo.class(BuffBase)
function Buffer4601611:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4601611:OnCreate(caster, target)
	-- 8739
	local c135 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,46016)
	-- 4601601
	self:AddAttr(BufferEffect[4601601], self.caster, self.card, nil, "attack",150*c135*self.nCount)
end
