-- 角色受到攻擊後，獲得等同於本次攻擊傷害50%的護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020100 = oo.class(BuffBase)
function Buffer1000020100:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000020100:OnCreate(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000020100
	self:AddShield(BufferEffect[1000020100], self.caster, self.card, nil, 4,0.5)
end
