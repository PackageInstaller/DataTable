-- 持有護盾的角色暴擊幾率提高50%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020180 = oo.class(BuffBase)
function Buffer1000020180:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000020180:OnCreate(caster, target)
	-- 8738
	local c134 = SkillApi:BuffCount(self, self.caster, target or self.owner,3,4,3)
	-- 1000020199
	if SkillJudger:Greater(self, self.caster, self.card, true,c134,0) then
	else
		return
	end
	-- 1000020180
	self:AddAttr(BufferEffect[1000020180], self.caster, self.card, nil, "crit_rate",1)
end
