local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self.v_stars = {
    self.v_uiobjects.Star1,
    self.v_uiobjects.Star2,
    self.v_uiobjects.Star3,
    self.v_uiobjects.Star4
  }
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(chapter_id, cfg)
  self.v_chapter_id = chapter_id
  self.v_stage_id = cfg.Id
  self.v_stage_cfg = cfg
  local chapter_cfg = ShareRes.get_music_game_chapter_cfg(chapter_id)
  self.v_uicompents.Name_txt.text = cfg.Name
  ResMgr:load_set_icon(self.v_uicompents.NodeIcon_img, chapter_cfg.Icon)
  self:set_button_listener(self.v_uicompents.Button_btn, function()
    if self.v_is_unlock then
      self:on_click()
    else
      Util.show_message_tip("该关卡未解锁")
    end
  end)
  self:refresh_view()
  self.v_cache_time = 0
end

function ui:on_click()
  UIMgr:get_ui("music_game_battle_panel"):ui_show(self.v_chapter_id, self.v_stage_id)
end

function ui:refresh_view()
  local data = MusicGameMgr:get_stage_data(self.v_chapter_id, self.v_stage_id)
  local now_time = Date.server_time()
  local start_time = self.v_stage_cfg.StartTime and Date.get_time_stamp_by_scheme_id(self.v_stage_cfg.StartTime) or 0
  local time_open = now_time >= start_time
  local condition_open = nil ~= data
  local is_unlock = time_open and condition_open
  self.v_is_unlock = is_unlock
  self.v_is_time_open = time_open
  Util.apply_grey_ex(self.v_uiobjects.Icon, not is_unlock)
  self.v_uiobjects.Lock:SetActive(not is_unlock)
  self.v_uiobjects.UnLock:SetActive(is_unlock)
  if not time_open then
    local remain_time = start_time - now_time
    if remain_time > 86400 then
      self.v_uicompents.Time_txt.text = string.format("%s天后解锁", math.ceil(remain_time / 86400))
    else
      self.v_uicompents.Time_txt.text = string.format("%s小时后解锁", math.ceil(remain_time / 3600))
    end
  elseif not condition_open then
    self.v_uicompents.Time_txt.text = "通关前置关卡后解锁"
  else
    local star = data.star or 0
    for idx, star_obj in ipairs(self.v_stars) do
      star_obj:SetActive(idx <= star)
    end
  end
end

function ui:ui_on_update()
  if self.v_is_time_open then
    return
  end
  if not self.v_cache_time then
    self.v_cache_time = 0
    return
  end
  self.v_cache_time = self.v_cache_time + 1
  if self.v_cache_time > 1000 then
    self:refresh_view()
  end
end

return ui
