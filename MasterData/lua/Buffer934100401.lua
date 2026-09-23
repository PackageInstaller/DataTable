-- 尖塔守護
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer934100401 = oo.class(BuffBase)
function Buffer934100401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer934100401:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 934100403
	self:AutoFight(BufferEffect[934100403], self.caster, self.card, nil, 934100601)
end
-- 创建时
function Buffer934100401:OnCreate(caster, target)
	-- 934100401
	self:AddShieldWall(BufferEffect[934100401], self.caster, target or self.owner, nil,9,50)
end
