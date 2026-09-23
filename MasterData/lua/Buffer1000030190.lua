-- 戰鬥開始時，全體獲得增傷100%buff。持續一回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000030190 = oo.class(BuffBase)
function Buffer1000030190:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 战斗开始
function Buffer1000030190:OnStart(caster, target)
	do
		-- 1000030190
		self:AddAttrPercent(BufferEffect[1000030190], self.caster, self.card, nil, "damage",1)
	end
end
