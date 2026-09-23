-- 落日熔金：吸血（不顯示，行動結束，1回合buff觸發不了）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer330404 = oo.class(BuffBase)
function Buffer330404:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束2
function Buffer330404:OnActionOver2(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 330402
	self:AddProgress(BufferEffect[330402], self.caster, self.card, nil, 1010)
	-- 330403
	self:DelBufferForce(BufferEffect[330403], self.caster, self.card, nil, 330402)
end
