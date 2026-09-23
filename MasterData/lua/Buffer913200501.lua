-- 堅壘形態
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913200501 = oo.class(BuffBase)
function Buffer913200501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer913200501:OnCreate(caster, target)
	-- 913200501
	self:AddAttrPercent(BufferEffect[913200501], self.caster, self.card, nil, "bedamage",0.5)
end
