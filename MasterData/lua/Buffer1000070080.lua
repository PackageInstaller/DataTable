-- 角色回合結束時，行動概率提前12%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000070080 = oo.class(BuffBase)
function Buffer1000070080:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合结束时
function Buffer1000070080:OnRoundOver(caster, target)
	-- 1000070080
	if self:Rand(7500) then
		self:AddProgress(BufferEffect[1000070080], self.caster, target or self.owner, nil,8)
	end
end
