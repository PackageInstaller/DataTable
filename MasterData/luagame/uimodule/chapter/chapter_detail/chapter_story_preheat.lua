local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local PREHEAT_ITEM_TEMP_KEY = "PREHEAT_ITEM_TEMP_KEY"
local PREHEAT_ITEM_CLASS = require("uimodule.chapter.chapter_detail.chapter_story_preheat_item")

function ui:on_select_preheat(preheat_id, index)
  self.v_select_preheat_id = preheat_id
  self.v_select_index = index
  self.v_select_preheat_cfg = ShareRes.get_story_preheat_cfg(self.v_select_preheat_id)
  self:refresh_select_info()
  for key, item in pairs(self.v_preheat_item_map) do
    item:set_select(self.v_select_preheat_id)
  end
end

function ui:on_click_play_story_btn()
  if not self.v_select_preheat_id or not ChapterMgr:get_preheat_is_unlock(self.v_select_preheat_id) then
    return
  end
  local count_down_time = ChapterMgr:get_story_preheat_count_down_time(self.v_select_preheat_id)
  if count_down_time > 0 then
    Util.show_message_tip(2322, Date.get_time_desc2(count_down_time))
    return
  end
  local preheat_id_list = ShareRes.get_story_preheat_list_by_group_id(self.v_group_id)
  local unlock_index = self.v_select_index + 1
  local unlock_id = preheat_id_list[unlock_index]
  local need_request_unlock = Util.is_more_than_zero(unlock_id) and not ChapterMgr:get_preheat_is_unlock(unlock_id)
  
  local function request_cb()
    if self.v_select_preheat_cfg and Util.is_more_than_zero(self.v_select_preheat_cfg.PoltId) then
      if need_request_unlock then
        StoryMgr:set_story_end_cb(self.v_select_preheat_cfg.PoltId, function()
          if self:visible() then
            self:refresh_group()
          end
        end)
      end
      StoryMgr:on_start(self.v_select_preheat_cfg.PoltId)
    end
  end
  
  if need_request_unlock then
    ChapterMgr:request_preheat_unlock(unlock_id, request_cb)
  else
    request_cb()
  end
end

function ui:ui_finish_load()
  self:set_button("BtnStart", function()
    self:on_click_play_story_btn()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self.v_preheat_item_map = {}
  self:register_exist_auto_template(PREHEAT_ITEM_TEMP_KEY, self.v_uiobjects.StageTem, self.v_uiobjects.StageContent)
end

function ui:ui_on_show(chapter_id)
  function self.v_in_pd_cb()
    self:check_unlock_pd()
  end
  
  self.v_uicompents.Ani_UIPreviewStory_In_pd:stopped("+", self.v_in_pd_cb)
  self.v_chapter_id = chapter_id
  self.v_group_id = ShareRes.get_story_preheat_group_id_by_chapter_id(chapter_id)
  if not self.v_group_id then
    Log.Error("获取剧情预热配置失败，章节：", chapter_id, "不存在对应剧情预热配置")
    return
  end
  self.v_group_cfg = ShareRes.get_story_preheat_group_cfg(self.v_group_id)
  self:refresh_group(true)
end

function ui:ui_on_hide()
  if self.v_in_pd_cb then
    self.v_uicompents.Ani_UIPreviewStory_In_pd:stopped("-", self.v_in_pd_cb)
    self.v_in_pd_cb = nil
  end
  self.v_select_preheat_id = nil
  self.v_select_index = nil
  Util.change_component_alpha2(self.v_uicompents.StageImage_img, 1)
  if self.v_hide_tween then
    self.v_hide_tween:Kill(false)
    self.v_hide_tween = nil
  end
  self:clear_preheat_item()
end

function ui:ui_on_destroy()
end

function ui:refresh_group(is_first)
  self:clear_preheat_item()
  local preheat_id_list = ShareRes.get_story_preheat_list_by_group_id(self.v_group_id)
  local preheat_id, is_unlock, preheat_item, new_preheat_item, obj
  for index = 1, #preheat_id_list do
    preheat_id = preheat_id_list[index]
    is_unlock = ChapterMgr:get_preheat_is_unlock(preheat_id)
    if is_unlock then
      obj = self:get_auto_cache(PREHEAT_ITEM_TEMP_KEY)
      preheat_item = PREHEAT_ITEM_CLASS:ui_wrap_ex(self, obj, true)
      preheat_item:set_data(preheat_id, index, is_first)
      local count_down_time = ChapterMgr:get_story_preheat_count_down_time(preheat_id)
      if count_down_time <= 0 then
        local is_record = ChapterMgr:preheat_is_recorded(preheat_id)
        if is_record then
          preheat_item:set_lock_state(false)
          if not is_first then
            preheat_item:play_unlock_pd()
            ChapterMgr:remove_lock_preheat(preheat_id)
            ChapterMgr:save_lock_preheat()
          end
        else
          new_preheat_item = preheat_item
        end
      end
      self.v_preheat_item_map[preheat_id] = preheat_item
    end
  end
  if new_preheat_item then
    new_preheat_item:on_click_button()
  else
    Log.Error("获取首个解锁节点失败，请检查配置")
  end
  self:refresh_group_info()
end

function ui:refresh_group_info()
  self.v_uicompents.ChapteNum_txt.text = self.v_group_cfg.Num
  self.v_uicompents.ChapteName_txt.text = self.v_group_cfg.GroupName
end

function ui:refresh_select_info()
  self.v_uicompents.StageName_txt.text = self.v_select_preheat_cfg.Name
  self.v_uicompents.StageDesc_txt.text = self.v_select_preheat_cfg.Desc
  if self.v_cur_bg_path ~= self.v_select_preheat_cfg.DetailBg then
    self.v_cur_bg_path = self.v_select_preheat_cfg.DetailBg
    if self.v_cur_bg_path then
      if self.v_sequence then
        self.v_sequence:Kill(false)
        self.v_sequence = nil
      end
      self.v_sequence = Util.create_sequence()
      
      local function set_bg_cb1()
        Util.change_component_alpha2(self.v_uicompents.StageImage_img, 1)
        if self.v_hide_tween then
          self.v_hide_tween:Kill(false)
          self.v_hide_tween = nil
        end
        self.v_sequence:Join(self.v_uicompents.StageImage_img:DOFade(0, 0.2))
        self.v_sequence:Join(self.v_uicompents.StageImage1_img:DOFade(1, 0.2))
        self.v_sequence:OnComplete(function()
          local function set_bg_cb2()
            Util.change_component_alpha2(self.v_uicompents.StageImage_img, 1)
            
            Util.change_component_alpha2(self.v_uicompents.StageImage1_img, 0)
          end
          
          ResMgr:load_set_icon(self.v_uicompents.StageImage_img, self.v_cur_bg_path, set_bg_cb2, true, self)
          if self.v_sequence then
            self.v_sequence:Kill(false)
            self.v_sequence = nil
          end
        end)
      end
      
      Util.change_component_alpha2(self.v_uicompents.StageImage1_img, 0)
      ResMgr:load_set_icon(self.v_uicompents.StageImage1_img, self.v_cur_bg_path, set_bg_cb1, true, self)
    else
      ResMgr:load_set_icon(self.v_uicompents.StageImage_img, self.v_cur_bg_path, nil, true, self)
      Util.change_component_alpha2(self.v_uicompents.StageImage1_img, 0)
    end
  end
end

function ui:clear_preheat_item()
  for key, item in pairs(self.v_preheat_item_map) do
    item:ui_hide()
    item:ui_destroy()
    self.v_preheat_item_map[key] = nil
  end
  self:give_back_auto_cache(PREHEAT_ITEM_TEMP_KEY)
end

function ui:check_unlock_pd()
  for preheat_id, preheat_item in pairs(self.v_preheat_item_map) do
    local is_record = ChapterMgr:preheat_is_recorded(preheat_id)
    local count_down_time = ChapterMgr:get_story_preheat_count_down_time(preheat_id)
    if is_record and count_down_time <= 0 then
      preheat_item:play_unlock_pd()
      ChapterMgr:remove_lock_preheat(preheat_id)
      ChapterMgr:save_lock_preheat()
    end
  end
end

return ui
