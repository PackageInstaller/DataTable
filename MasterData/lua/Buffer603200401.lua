-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer603200401 = oo.class(BuffBase)
function Buffer603200401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer603200401:OnCreate(caster, target)
	-- 8775
	local c775 = SkillApi:GetCount(self, self.caster, target or self.owner,3,4603201)
	-- 603200401
	self:OwnerAddBuffCount(BufferEffect[603200401], self.caster, self.card, nil, 4603211,c775,60)
end
