local M = Util.create_class()

function M:_init()
  self.magic_set = nil
  self.settlementTime = 0
  self.strengthTime = 0
  self.god = get_god_npc()
  self.strength = nil
  self.strengthMax = nil
  self.levle = nil
  self.levlemax = nil
  self.levelD = nil
end

function M:on_frame()
  if self.god then
    self.strength = get_npc_attr(self.god, 105)
    self.strengthMax = get_npc_attr(self.god, 107)
  end
  if self.magic_set == nil then
    self.magic_set = 0
    set_ui_object_visible("fight", "Btn_skill6", true)
    set_skill_btn_icon(61, "UI_H1001005_exskill")
    self:set_charging()
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
  end
  if self.god and 0 == self.magic_set and self.strength < 30 then
    set_skill_btn_icon(61, "TPS_gray")
  elseif self.god and 0 == self.magic_set and self.strength > 30 then
    set_skill_btn_icon(61, "UI_H1001005_exskill")
  elseif self.god and 1 == self.magic_set then
    set_skill_btn_icon(61, "UI_H1001005_exskill")
  end
  if self.god and 0 == self.magic_set and self.strength < self.strengthMax and get_npc_time(self.npc) > self.strengthTime + 0.3 then
    cast_magic(self.npc, self.god, 399995, 1)
    self.strengthTime = get_npc_time(self.npc)
    self:set_charging()
  end
  if self.god and 1 == self.magic_set and self.strength > 0 and get_npc_time(self.npc) > self.strengthTime + 0.3 then
    cast_magic(self.npc, self.god, 399994, 1)
    self.strengthTime = get_npc_time(self.npc)
  end
  if self.god and 1 == self.magic_set and 0 == self.strength then
    self:cast_skill2()
  end
end

function M:set_charging()
  if 0 == self.magic_set and self.god and self.strength > 0 then
    self.level = math.ceil(self.strength / 5)
    self.levlemax = math.ceil(self.strengthMax / 5)
    self.levelD = self.levlemax - self.level
    cast_magic(self.npc, self.npc, 399999, self.levlemax)
    cast_magic(self.npc, self.npc, 399998, self.level)
    set_skill_btn_charging(61, 1, {
      param_type = 1,
      param1 = 105,
      param2 = 107
    })
  else
    clear_skill_btn_charging(61)
  end
end

function M:cast_skill1()
  if 0 == self.magic_set then
    self.magic_set = 1
  end
  if check_magic(self.npc, 399963) then
    abort_magic_by_id(self.npc, 399963, 1)
  end
  cast_magic(self.npc, self.npc, 399962, 1)
  self.settlementTime = get_npc_time(self.npc)
  self:set_charging()
  clear_input(self, 60)
end

function M:cast_skill2()
  if 1 == self.magic_set then
    self.magic_set = 0
  end
  cast_magic(self.npc, self.npc, 399963, 1)
  self.settlementTime = get_npc_time(self.npc)
  clear_input(self, 60)
end

function M:on_input(input_id)
  if 61 == input_id and 0 == self.magic_set and not check_npc_status(self.npc, 1) and get_npc_time(self.npc) > self.settlementTime + 1.1 and self.strength > 30 then
    self:cast_skill1()
  elseif 61 == input_id and 1 == self.magic_set and get_npc_time(self.npc) > self.settlementTime + 1.1 then
    self:cast_skill2()
  elseif 61 == input_id and 0 == self.magic_set then
    cast_magic(self.npc, self.npc, 399997, 1)
  end
end

function M:on_room_change(npc)
  if check_magic(npc, 4010178) then
    cast_magic(self.npc, self.npc, 399982, 1)
  end
end

function M:on_npc_hp_zero(npc)
  if check_magic(npc, 4010178) then
    cast_magic(self.npc, self.npc, 399982, 1)
  end
end

return M
