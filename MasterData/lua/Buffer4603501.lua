-- 愛的魔法
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4603501 = oo.class(BuffBase)
function Buffer4603501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4603501:OnCreate(caster, target)
	-- 4603502
	local c6035 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,46035)
	-- 4603501
	self:AddAttr(BufferEffect[4603501], self.caster, self.card, nil, "hit",0.01*self.nCount*math.floor((c6035+1)/2))
end
