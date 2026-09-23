-- 造成物理傷害時可附加降低防禦buff（可疊加）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000030060 = oo.class(BuffBase)
function Buffer1000030060:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 战斗开始
function Buffer1000030060:OnStart(caster, target)
	do
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
		-- 1000030060
		self:AddBuff(BufferEffect[1000030060], self.caster, target or self.owner, nil,1000030061)
	end
end
