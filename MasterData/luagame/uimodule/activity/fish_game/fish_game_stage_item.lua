local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local CT_Timer = Global.ct_timer

function ui:ui_finish_load()
  self:set_button("UnlockBtn", function()
    if not self.v_is_lock then
      UIMgr:get_ui("fish_game_battle"):ui_show(self.v_item_cfg, self.v_data_list, self.v_data_index)
    end
  end)
  self:set_button("LockBtn", function()
    if self.v_is_lock then
      Util.show_message_tip("关卡未解锁")
    end
  end)
  self.v_rect = self:get_rect_transform(nil, self.v_object)
  self.v_rect_x_up, self.v_rect_y_up = self.v_uicompents.UpPos_rect:GetAnchoredPositionA()
  self.v_rect_x_down, self.v_rect_y_down = self.v_uicompents.LowerPos_rect:GetAnchoredPositionA()
end

function ui:set_data(go, data_list, index)
  self.v_item_cfg = data_list[index]
  self.v_episode_cfg = NoviceMgr:get_fish_game_data(self.v_item_cfg.Id)
  self.v_data_list = data_list
  self.v_data_index = index
  if 1 == index % 2 then
    self.v_uiobjects.UpDot:SetActive(true)
    self.v_uiobjects.LowerDot:SetActive(false)
    self.v_rect:SetAnchoredPositionY(self.v_rect_y_up)
  else
    self.v_uiobjects.UpDot:SetActive(false)
    self.v_uiobjects.LowerDot:SetActive(true)
    self.v_rect:SetAnchoredPositionY(self.v_rect_y_down)
  end
  self:refresh_stage_info()
  self.v_uicompents.MaxStore_txt.text = self.v_episode_cfg.score
  local star_cnt = 0
  for _, temp in pairs(self.v_episode_cfg.star_map) do
    star_cnt = star_cnt + 1
  end
  self.v_uiobjects.MaxStoreCnt:SetActive(star_cnt > 0)
  for idx = 1, 3 do
    self.v_uiobjects["Star" .. idx]:SetActive(idx <= star_cnt)
  end
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_fish_game_stage_item_UI_SOUND)
end

function ui:refresh_stage_info()
  if not self:visible() then
    return
  end
  self.v_uiobjects.RedDot:SetActive(NoviceMgr:get_fish_game_red_state(self.v_item_cfg.Id))
  self.v_uicompents.Name_txt.text = self.v_item_cfg.Name
  self.v_uiobjects.LockBtn:SetActive(false)
  self.v_uiobjects.UnlockBtn:SetActive(false)
  self.v_uiobjects.Lock:SetActive(false)
  self.v_uiobjects.UnLock:SetActive(false)
  self.v_uiobjects.StarLayout:SetActive(false)
  local count_down_time = -1
  if self.v_item_cfg.StartTime then
    count_down_time = Date.get_time_stamp_by_scheme_id(self.v_item_cfg.StartTime) - Date.server_time()
  end
  local cfg = self.v_episode_cfg
  local time_end = self.v_parent_ui:is_time_end()
  local is_lock = time_end or count_down_time > 0
  local is_pre_pass = true
  if self.v_item_cfg.FrontEpisodeId then
    is_pre_pass = NoviceMgr:get_fish_game_data(self.v_item_cfg.FrontEpisodeId).is_pass
  end
  self.v_is_lock = false
  if is_lock or not is_pre_pass then
    self.v_uiobjects.LockBtn:SetActive(true)
    self.v_uiobjects.Lock:SetActive(true)
    if time_end then
      self.v_uicompents.Time_txt.text = ""
    elseif is_lock then
      self.v_uicompents.Time_txt.text = Date.get_time_desc2(count_down_time) .. "后解锁"
    elseif not is_pre_pass then
      self.v_uicompents.Time_txt.text = "通关上一个关卡"
    end
    self.v_is_lock = true
    return
  else
    self.v_uiobjects.UnlockBtn:SetActive(true)
    self.v_uiobjects.UnLock:SetActive(true)
    self.v_uiobjects.StarLayout:SetActive(true)
  end
end

function ui:set_linked_parent(parent_ui)
  self.v_parent_ui = parent_ui
end

return ui
