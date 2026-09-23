-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer603210401 = oo.class(BuffBase)
function Buffer603210401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer603210401:OnCreate(caster, target)
	-- 8774
	local c774 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,46032)
	-- 603210401
	self:OwnerAddBuffCount(BufferEffect[603210401], self.caster, self.card, nil, 4603201,c774,10)
end
