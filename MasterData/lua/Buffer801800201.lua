-- 純白壁壘
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer801800201 = oo.class(BuffBase)
function Buffer801800201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer801800201:OnCreate(caster, target)
	-- 8789
	local c789 = SkillApi:GetAttr(self, self.caster, target or self.owner,1,"sMech")
	-- 8791
	local c791 = SkillApi:ClassCount(self, self.caster, target or self.owner,1,c789)
	-- 801800201
	self:AddShield(BufferEffect[801800201], self.caster, target or self.owner, nil,1,0.15+0.03*c791)
end
