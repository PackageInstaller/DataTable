-- 忘我攻勢-等級1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10930 = oo.class(BuffBase)
function Buffer10930:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10930:OnCreate(caster, target)
	-- 4930
	self:AddAttrPercent(BufferEffect[4930], self.caster, target or self.owner, nil,"defense",-0.05)
	-- 4001
	self:AddAttrPercent(BufferEffect[4001], self.caster, target or self.owner, nil,"attack",0.05)
end
