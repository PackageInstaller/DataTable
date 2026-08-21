local M = Util.create_class()

function M:_init()
end

function M:on_start()
  set_ui_object_visible("fight", "Btn_skill3", false)
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break)
  if npc == self.npc then
    set_ui_object_visible("fight", "Btn_skill3", false)
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc then
    set_ui_object_visible("fight", "Btn_skill3", false)
  end
end

return M
