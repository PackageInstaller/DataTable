local CommonRole = import("common.role")
local Base = import("character.base.base_role")
local Xu = Util.create_child_mt(Base)

function Xu:_init(npc)
  self.Xu = Xu
  self:addInst()
  cast_magic(npc, npc, 102410, 1)
  cast_magic(npc, npc, 102411, 1)
  cast_magic(npc, npc, 101122, 1)
  cast_magic(npc, npc, 399930, 1)
  set_npc_status(npc, 4, true)
end

function Xu:on_start()
end

function Xu:cast_counter()
end

function Xu:cast_atk()
end

function Xu:do_cast_atk()
end

function Xu:cast_skill2()
end

function Xu:cast_skill3()
end

function Xu:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
end

function Xu:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
end

function Xu:on_magic_begin(npc, target, magic_id)
  Base.on_magic_begin(self, npc, target, magic_id)
end

function Xu.on_remove(monster)
  local Xu = monster.Xu
  if Xu.inst == monster then
    Xu.inst = nil
  end
end

function Xu.addInst(monster)
  local Xu = monster.Xu
  local oldInst = Xu.inst
  Xu.inst = monster
  Xu.Yuli = monster
  if oldInst and oldInst.npc ~= monster.npc and oldInst.npc then
    oldInst:removeInst()
    return
  end
end

function Xu.removeInst(monster)
  local Xu = monster.Xu
  if Xu.inst == monster then
    Xu.inst = nil
  end
  remove_npc(monster.npc)
end

return Xu
