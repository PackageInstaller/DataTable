local M = Util.create_class()

function M:_init(npc)
  self.timer = 10
  self.trigger_time = get_time() + 3
  self.trigger = false
end

function M:on_frame()
  local nowtime = get_time()
  if nowtime > self.trigger_time and not self.trigger then
    local i = 1
    local magic_num = 6 - get_magic_num(self.npc, 6040061)
    while i < magic_num do
      self.trigger = true
      cast_magic(self.npc, self.npc, 6040061, 0)
      if not check_magic(self.npc, 6040063) then
        cast_magic(self.npc, self.npc, 6040063, 0)
      else
        play_effect_anim(self.npc, "Fx_MonsterEntry_Forcefield", "Fx_MonsterEntry_Forcefield_1")
      end
      i = i + 1
    end
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if target == self.npc then
    local magic_num = get_magic_num(self.npc, 6040061)
    if 1 == damage_sign then
      abort_magic_by_id(self.npc, 6040061, 1)
      if check_magic(self.npc, 6040063) then
        if magic_num > 1 then
          play_effect_anim(self.npc, "Fx_MonsterEntry_Forcefield", "Fx_MonsterEntry_Forcefield_2_2")
        else
          play_effect_anim(self.npc, "Fx_MonsterEntry_Forcefield", "Fx_MonsterEntry_Forcefield_4")
          self.trigger_time = get_time() + self.timer
          self.trigger = false
        end
      end
    end
    if magic_num > 0 then
      cast_magic(self.npc, self.npc, 6040062, 0)
    end
  end
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    play_effect_anim(self.npc, "Fx_MonsterEntry_Forcefield", "Fx_MonsterEntry_Forcefield_4")
  end
end

return M
