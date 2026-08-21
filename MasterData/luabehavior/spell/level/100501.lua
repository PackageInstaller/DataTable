local Base = import("spell.base.teach_level_base")
local roleTool = import("common.role_tool")
local M = Util.create_child_mt(Base)

function M:_init()
  Base._init(self)
  set_ui_object_visible("fight", "Btn_skill5", false)
  set_ui_object_visible("fight", "JoystickContent", false)
  set_ui_object_visible("fight", "Btn_skill4", false)
  set_ui_object_visible("fight", "Btn_skill1", false)
  set_ui_object_visible("fight", "Btn_skill3", false)
  set_ui_object_visible("fight", "Btn_skill7", false)
  self.init_guide = false
  self.force_finish2 = false
end

function M:on_magic_begin(npc, target, magic_id, is_self, magic_level)
  if 2010290901 == magic_id and not self.init_guide then
    self.init_guide = true
    self:teach_guide1()
  end
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(100501)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100501 == guide_id then
      self:to_next_step()
    end
  end)
  g:add_step(function()
    enter_guide(100503)
  end):listen("on_finish_guide", function(guide_id)
    self:to_next_step(0.01)
  end)
  g:add_step(function()
    start_stroy(5000108)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    self:end_teach_guide()
  end)
  g:start()
end

function M:on_finish_guide(guide_id, is_skip)
  self:call_guide_listen_func("on_finish_guide", guide_id, is_skip)
end

return M
