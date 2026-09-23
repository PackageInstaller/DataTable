-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100020146 = oo.class(BuffBase)
function Buffer1100020146:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始处理完成后
function Buffer1100020146:OnAfterRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1100020146
	if self:Rand(3000) then
		self:AddBuff(BufferEffect[1100020146], self.caster, self.card, nil, 3005)
	end
end
