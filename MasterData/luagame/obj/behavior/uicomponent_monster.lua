local Base = require("obj.behavior.uicomponent_char")
local MONSTER_TYPE = Config.MONSTER_TYPE
local M = Util.create_child_mt(Base)

function M:setup_headbar()
  if self.v_char:get_config()["显示头顶名字"] then
    self:add_headbar(self.v_char.attr_mgr.name)
  end
end

local function need_boss_type(monster_type)
  if monster_type >= MONSTER_TYPE.BOSS and monster_type <= MONSTER_TYPE.CITY_HOST then
    return true
  end
end

function M:show_hp_bar(...)
  local type = Config.HPBAR_TYPE.COMMON
  if need_boss_type(self.v_char:get_config().monster_type) then
    type = Config.HPBAR_TYPE.BOSS
  end
  if self.v_char:get_config()["显示头顶血条"] then
    Base.show_hp_bar(self, type, ...)
  end
end

function M:update_headbar_text(text)
  if not self.v_headbar then
    return
  end
  self:reset_line_count()
  local color = self:get_name_color()
  self.v_name_text.text = Util.format_ngui_color(text, color)
  self:inc_line_count()
  self:update_title()
  self:update_top_name()
end

return M
