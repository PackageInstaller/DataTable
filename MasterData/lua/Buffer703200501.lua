-- 災禍護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer703200501 = oo.class(BuffBase)
function Buffer703200501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer703200501:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 703200502
	self:AutoFight(BufferEffect[703200502], self.caster, self.card, nil, 703200901)
end
-- 创建时
function Buffer703200501:OnCreate(caster, target)
	-- 703200501
	self:AddShield(BufferEffect[703200501], self.caster, target or self.owner, nil,1,0.30)
end
