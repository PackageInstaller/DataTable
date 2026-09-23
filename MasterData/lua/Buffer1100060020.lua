-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100060020 = oo.class(BuffBase)
function Buffer1100060020:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer1100060020:OnActionOver(caster, target)
	-- 1100060020
	self:AddProgress(BufferEffect[1100060020], self.caster, self.card, nil, 200*self.nCount)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1100060021
	self:DelBufferForce(BufferEffect[1100060021], self.caster, self.card, nil, 1100060020)
end
