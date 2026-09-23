-- 隱匿
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6210 = oo.class(BuffBase)
function Buffer6210:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer6210:OnActionOver(caster, target)
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
	-- 8201
	if SkillJudger:IsSingle(self, self.caster, target, true) then
	else
		return
	end
	-- 6204
	self:DelBuff(BufferEffect[6204], self.caster, self.card, nil, 6101,1)
end
-- 创建时
function Buffer6210:OnCreate(caster, target)
	-- 6101
	self:IgnoreSingleAttack(BufferEffect[6101], self.caster, target or self.owner, nil,true)
end
