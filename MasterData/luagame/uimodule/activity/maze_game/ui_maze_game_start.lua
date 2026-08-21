local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CLUETYPECONTENT_CLUETYPETEM_TEMP_KEY = "CLUETYPECONTENT_CLUETYPETEM_TEMP_KEY"

function ui:on_click_BtnRet1()
  self:ui_hide()
end

function ui:on_click_BtnStart()
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_maze_game_start_click_UI_SOUND)
  NoviceMgr:start_ponder_maze_game(self.v_activity_id, self.v_point_id)
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:on_click_BtnRet1()
  end)
  self:set_button("BtnStart", function()
    self:on_click_BtnStart()
  end)
  self:register_exist_auto_template(CLUETYPECONTENT_CLUETYPETEM_TEMP_KEY, self.v_uiobjects.ClueTypeTem, self.v_uiobjects.ClueTypeContent)
end

function ui:ui_on_show(activity_id, point_id)
  self.v_activity_id = activity_id
  self.v_point_id = point_id
  self.v_point_cfg = ShareRes.get_ponder_maze_point_cfg(self.v_point_id)
  self.v_map_id = self.v_point_cfg.MapID
  self:refresh_view()
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh_view()
  self.v_uicompents.Dialog_txt.text = self.v_point_cfg.EnterDesc
  self:give_back_auto_cache(CLUETYPECONTENT_CLUETYPETEM_TEMP_KEY)
  local map_cfg = ShareRes.get_ponder_maze_map_cfg(self.v_map_id)
  for _, clue_id in pairs(map_cfg.TargetClue) do
    local obj = self:get_auto_cache(CLUETYPECONTENT_CLUETYPETEM_TEMP_KEY)
    local clue_cfg = ShareRes.get_ponder_maze_clue_cfg(clue_id)
    local txt = self:get_text("Text", obj)
    if txt then
      txt.text = clue_cfg.Name
    end
  end
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_activity_id, self.v_point_id
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name, false, true)
end

return ui
