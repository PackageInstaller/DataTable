-- 增幅吸收
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer704200204 = oo.class(BuffBase)
function Buffer704200204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer704200204:OnCreate(caster, target)
	-- 8720
	local c116 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"hp")
	-- 704200204
	self:AddHp(BufferEffect[704200204], self.caster, self.card, nil, -math.floor(c116*0.13))
end
