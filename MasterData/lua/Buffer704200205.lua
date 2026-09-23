-- 增幅吸收
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer704200205 = oo.class(BuffBase)
function Buffer704200205:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer704200205:OnCreate(caster, target)
	-- 8720
	local c116 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"hp")
	-- 704200205
	self:AddHp(BufferEffect[704200205], self.caster, self.card, nil, -math.floor(c116*0.15))
end
