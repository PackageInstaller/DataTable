-- 山脈陣營蟲洞buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010361 = oo.class(BuffBase)
function Buffer1100010361:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100010361:OnCreate(caster, target)
	-- 8740
	local c136 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,1)
	-- 1100010361
	self:AddAttrPercent(BufferEffect[1100010361], self.caster, target or self.owner, nil,"defense",0.1*c136)
end
