-- 獨奏
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4201501 = oo.class(BuffBase)
function Buffer4201501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4201501:OnCreate(caster, target)
	-- 8448
	local c48 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,42015)
	-- 4201501
	self:AddAttr(BufferEffect[4201501], self.caster, self.card, nil, "hit",(3+c48)/100*self.nCount)
end
