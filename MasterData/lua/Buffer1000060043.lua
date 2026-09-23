-- 對敵方造成傷害時，概率附加【降速】效果。（降速：降低目標的效果抵抗和速度，持續2回合，可疊層）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000060043 = oo.class(BuffBase)
function Buffer1000060043:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000060043:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 1000060043
	self:AddBuff(BufferEffect[1000060043], self.caster, target or self.owner, nil,1000060042)
end
