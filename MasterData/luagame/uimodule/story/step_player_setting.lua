local Base = require("uimodule.story.step_base")
local M = Util.create_child_mt(Base)
local STORY_CONFIG = require("uimodule.story.story_config")

function M:_init(...)
  Base._init(self, ...)
end

function M:on_destroy()
  Base.on_destroy(self)
  self.v_uiobjects.Branch_List:SetActive(false)
end

function M:start()
  self:init_ui()
  self:open_pnl()
end

function M:init_ui()
  self.v_uiobjects.Up:SetActive(false)
end

function M:open_pnl()
  local function cb()
    self:on_complete()
  end
  
  if self.v_step_type == "WriteName" then
    local change_name_num = PlayerMgr:get_player_rename_num()
    if change_name_num and change_name_num > 0 then
      cb()
      return
    end
  end
  local uistory_player_setting = UIMgr:get_ui("uistory_player_setting")
  if uistory_player_setting:visible() then
    uistory_player_setting:ui_on_show(cb, self.v_step_type)
  else
    uistory_player_setting:ui_show(cb, self.v_step_type)
  end
end

function M:on_complete()
  self:complete()
end

return M
