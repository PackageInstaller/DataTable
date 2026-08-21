local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Vector3 = UnityVector3
local AWARD_SHOW_SINGLE_ROW_ITEM_KEY = "AWARD_SHOW_SINGLE_ROW_ITEM_KEY"
local AWARD_SHOW_MULTI_ROW_ITEM_KEY = "AWARD_SHOW_MULTI_ROW_ITEM_KEY"
local Item_Helper = require("utils.item_helper")
local type_playable_director = typeof(UnityEngine.Playables.PlayableDirector)
local ITEM_TYPE = {
  TITLE = 19,
  HEAD_ICON = 11,
  CARD = 22
}
local player_icon_path_prefix = "Icon/Profile/%s"
local player_card_path_prefix = "CardBG/%s"
local QUALITY_IDX = {
  [0] = "UICommon/Common_pzk_01",
  [1] = "UICommon/Common_pzk_01",
  [2] = "UICommon/Common_pzk_02",
  [3] = "UICommon/Common_pzk_02",
  [4] = "UICommon/Common_pzk_03",
  [5] = "UICommon/Common_pzk_04"
}
local MODEL = {
  v_single_row_list = {
    "Single_Row_List",
    BIND_TYPE.OBJECT
  },
  v_single_row_content = {
    "Single_Row_Content",
    BIND_TYPE.OBJECT
  },
  v_single_row_item = {
    "Single_Row_Template",
    BIND_TYPE.OBJECT
  },
  v_multi_row_list = {
    "Multi_Row_List",
    BIND_TYPE.OBJECT
  },
  v_multi_row_content = {
    "Multi_Row_Content",
    BIND_TYPE.OBJECT
  },
  v_multi_row_item = {
    "Multi_Row_Template",
    BIND_TYPE.OBJECT
  },
  v_title_obj = {
    "Title",
    BIND_TYPE.OBJECT
  },
  v_title_name_obj = {
    "Title_Name",
    BIND_TYPE.OBJECT
  },
  v_close_text_obj = {
    "Close_Text",
    BIND_TYPE.OBJECT
  },
  v_return_btn = {
    "Return",
    BIND_TYPE.BUTTON
  },
  v_cannot_touch_item_btn = {
    "Cannot_Touch_Item",
    BIND_TYPE.BUTTON
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button_listener(self.v_return_btn, function()
    self:click_hide()
  end)
  self:set_button_listener(self.v_cannot_touch_item_btn, function()
    self:click_hide()
  end)
  self:register_exist_auto_template(AWARD_SHOW_SINGLE_ROW_ITEM_KEY, self.v_single_row_item, self.v_single_row_content)
  self:register_exist_auto_template(AWARD_SHOW_MULTI_ROW_ITEM_KEY, self.v_multi_row_item, self.v_multi_row_content)
  self.v_close_text_obj:SetActive(false)
  self.v_cannot_touch_item_btn.gameObject:SetActive(true)
end

function ui:ui_on_show(award_list, is_in_fight, is_cancel_interval, is_auto_slide_down)
  self:reset_sequences()
  self.v_is_in_fight = is_in_fight
  self.v_is_cancel_interval = is_cancel_interval
  self.v_is_auto_slide_down = is_auto_slide_down
  self.v_sequences = {}
  self.animation_is_end = {}
  self.award_length = #award_list
  self.row_count = math.ceil(self.award_length / 5)
  self.multi_row_list_scroll_rect = Util.get_scrollrect(nil, self.v_multi_row_list)
  local have_exp_item = false
  if award_list and next(award_list) ~= nil then
    local is_need_sort = true
    for i, v in pairs(award_list) do
      local item_cfg = Item_Helper.get_item_cfg(v.id)
      if nil == item_cfg or nil == item_cfg.Quality then
        is_need_sort = false
        break
      end
      v.Quality = item_cfg.Quality
      v.Priority = item_cfg.Priority or 0
      if v.id == Config.EXP_ITEMID then
        have_exp_item = true
      end
    end
    if have_exp_item then
      PlayerMgr:try_show_exp_up_tips()
    end
    if true == is_need_sort then
      table.sort(award_list, function(a, b)
        if a.Quality ~= b.Quality then
          return a.Quality > b.Quality
        end
        if a.Priority ~= b.Priority then
          return a.Priority > b.Priority
        end
        return a.id > b.id
      end)
    end
  end
  if self.award_length <= 5 then
    self.v_single_row_list.gameObject:SetActive(true)
    self.v_multi_row_list.gameObject:SetActive(false)
    self:set_item_effect(award_list, AWARD_SHOW_SINGLE_ROW_ITEM_KEY)
  else
    self.multi_row_list_scroll_rect.vertical = true
    self.v_single_row_list.gameObject:SetActive(false)
    self.v_multi_row_list.gameObject:SetActive(true)
    self:set_item_effect(award_list, AWARD_SHOW_MULTI_ROW_ITEM_KEY)
  end
  self.v_award_list = award_list
  TowerMgr:clear_long_chapter_award()
end

function ui:ui_on_hide()
  self.v_multi_row_content.transform:SetAnchoredPositionA(0, 0, 0)
  self.multi_row_list_scroll_rect.vertical = false
  self.v_close_text_obj:SetActive(false)
  self.v_cannot_touch_item_btn.gameObject:SetActive(true)
  self:reset_sequences()
  MsgGame:mq_publish2(Const.MSG_ON_AWARD_SHOW_PANEL_HIDE)
end

function ui:check_new_char()
  if not self.v_award_list or next(self.v_award_list) == nil then
    return
  end
  local new_char_list = {}
  for _, v in ipairs(self.v_award_list) do
    local type_config = Util.get_item_type_cfg(v.id)
    if type_config.AwardType == Config.AWARD_TYPE.CHARA and self:check_new(v.id) then
      local length = #new_char_list + 1
      new_char_list[length] = {
        item_id = v.id,
        is_new = true,
        get_index = length,
        has_extra = false
      }
    end
  end
  if not new_char_list or next(new_char_list) == nil then
    return
  end
  UIMgr:get_ui("uidrawcard_movie_panel"):ui_show(new_char_list)
  return true
end

function ui:check_new(item_id)
  local buddy_config = ShareRes.get_buddy_cfg(item_id) or {}
  local buddy_id = buddy_config.Id or 0
  return CharacterMgr:is_buddy_new(buddy_id)
end

function ui:click_hide()
  if UIMgr:try_get_visible_ui("ui_guide") then
    self:ui_hide()
    return
  end
  if self.award_length ~= UtilTable.hash_lenth(self.animation_is_end) then
    for k, sequence in pairs(self.v_sequences) do
      sequence:Kill(true)
    end
    self.v_close_text_obj:SetActive(true)
    self.v_cannot_touch_item_btn.gameObject:SetActive(false)
    return
  end
  local team = UIMgr:try_get_visible_ui("itemTip")
  if team then
    team:ui_hide()
  end
  self:ui_hide()
end

function ui:update_item_view(item_ui, item_id, item_num)
  local quality_img = Util.get_image("Main_Content/Bg", item_ui)
  
  local function callback()
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = item_id,
      is_exist_jump = false,
      from_award_show_panel = true,
      jump_cb = function()
        self:ui_hide()
      end
    })
  end
  
  local item = self:create_item_obj(nil, quality_img.gameObject, nil, {item_id = item_id, click_cb = callback})
  local num_bg = self:get_child_gameobj("Main_Content/amount", item_ui)
  num_bg:SetActive(item_num >= 1)
  if item_num >= 1 then
    local num_txt = Util.get_text("Main_Content/amount/Text", item_ui)
    num_txt.text = item_num
  end
  local name_txt = Util.get_text("Main_Content/icon_name", item_ui)
  name_txt.text = item:get_item_name()
end

function ui:reset_sequences()
  if self.v_sequences then
    for k, sequence in pairs(self.v_sequences) do
      sequence:Kill(false)
    end
  end
end

function ui:set_title_effect()
  local title_sequence = Util.create_sequence()
  local title_canvas = self.v_title_obj:GetComponent("CanvasGroup")
  local title_name_canvas = self.v_title_name_obj:GetComponent("CanvasGroup")
  title_canvas.alpha = 0
  title_name_canvas.alpha = 0
  title_sequence:Append(title_canvas:DOFade(1, 3))
  title_sequence:Join(title_name_canvas:DOFade(1, 6))
  table.insert(self.v_sequences, title_sequence)
end

function ui:set_title_content(item_ui, title_id)
  local title_cfg = ShareRes.get_title(title_id)
  local group_cfg = ShareRes.get_achievement_group_cfg(title_cfg.GroupId)
  local title_quality_path_cfg = ShareRes.get_title_quality_path(title_cfg.Quality)
  local member_title_obj = Util.get_child_gameobj("Main_Content/Bg/MemberTitle_", item_ui.gameObject)
  local course_title_obj = Util.get_child_gameobj("Main_Content/Bg/CourseTitle_", item_ui.gameObject)
  member_title_obj:SetActive(1 == group_cfg.Classify)
  course_title_obj:SetActive(2 == group_cfg.Classify)
  local point_fore, bg, icon, lv
  if 1 == group_cfg.Classify then
    point_fore = Util.get_image("QualityBg2_", member_title_obj)
    bg = Util.get_image(nil, member_title_obj)
    icon = Util.get_image("Member/MemberEyes_", member_title_obj)
    lv = Util.get_text("QualityBg2_/MemberLv_", member_title_obj)
  else
    point_fore = Util.get_image("QualityBg1_", course_title_obj)
    bg = Util.get_image(nil, course_title_obj)
    icon = Util.get_image("Mask/CourseIcon2_", course_title_obj)
    lv = Util.get_text("QualityBg1_/CourseLv_", course_title_obj)
  end
  lv.text = title_cfg.Level
  lv.gameObject:SetActive(1 == title_cfg.ShowLevel)
  ResMgr:load_set_icon(point_fore, title_quality_path_cfg.Qualitybox)
  ResMgr:load_set_icon(icon, title_cfg.BaseMapPreview)
  ResMgr:load_set_icon(bg, title_cfg.BaseMap)
  Util.get_text("Main_Content/icon_name", item_ui).text = title_cfg.Name
  Util.get_text("Main_Content/amount/Text", item_ui).text = 1
end

function ui:set_head_icon_content(item_ui, head_id, self_obj)
  self_obj:SetActive(true)
  local head_icon = Util.get_image("Bg/ProfileIcon_", self_obj)
  local quality_img = Util.get_image("Main_Content/Bg", item_ui)
  local cfg = ShareRes.get_player_head_cfg(head_id)
  local icon_path = string.format(player_icon_path_prefix, cfg.Icon)
  ResMgr:load_set_icon(head_icon, icon_path)
  ResMgr:load_set_icon(quality_img, QUALITY_IDX[cfg.Quality])
  Util.get_text("Main_Content/icon_name", item_ui).text = cfg.Name
  Util.get_text("Main_Content/amount/Text", item_ui).text = 1
end

function ui:set_card_content(item_ui, card_id, self_obj)
  self_obj:SetActive(true)
  local card_icon = Util.get_image("PlayerCardIcon_", self_obj)
  local quality_img = Util.get_image("Main_Content/Bg", item_ui)
  local cfg = ShareRes.get_visiting_card_cfg(card_id)
  local icon_path = string.format(player_card_path_prefix, cfg.Icon)
  ResMgr:load_set_icon(card_icon, icon_path, nil, true)
  ResMgr:load_set_icon(quality_img, QUALITY_IDX[cfg.Quality])
  Util.get_text("Main_Content/icon_name", item_ui).text = cfg.Name
  Util.get_text("Main_Content/amount/Text", item_ui).text = 1
end

function ui:set_puzzle_content(item_ui, data)
  local item_id = data.id
  local item_num = data.count
  local puzzle_uuid = data.uuid
  self:update_item_view(item_ui, item_id, item_num)
  self:set_button_listener(Util.get_button(nil, item_ui.transform), function()
    local puzzle_data = PuzzleMgr:get_puzzle_data(puzzle_uuid)
    if puzzle_data then
      Util.show_puzzle_tip(puzzle_uuid, {
        offset = Config.PUZZLE_TIPS_OFFSET.MIDDLE,
        show_close_mask = true
      })
    else
      UIMgr:get_ui("itemTip"):ui_show({
        item_id = item_id,
        is_in_fight = self.v_is_in_fight,
        from_award_show_panel = true,
        jump_cb = function()
          self:ui_hide()
        end
      })
    end
  end)
end

function ui:set_item_effect(award_list, template_key)
  local current_scroll_index = 11
  self:give_back_auto_cache(template_key)
  for index, data in ipairs(award_list) do
    local item_ui = self:get_auto_cache(template_key)
    self:set_button_listener(Util.get_button(nil, item_ui.transform), function()
    end)
    local member_title_obj = Util.get_child_gameobj("Main_Content/Bg/MemberTitle_", item_ui.gameObject)
    local course_title_obj = Util.get_child_gameobj("Main_Content/Bg/CourseTitle_", item_ui.gameObject)
    local player_profile = Util.get_child_gameobj("Main_Content/Bg/PlayerProfile_", item_ui.gameObject)
    member_title_obj:SetActive(false)
    course_title_obj:SetActive(false)
    player_profile:SetActive(false)
    local award_type = Util.get_item_type_cfg(data.id).AwardType
    if award_type == Config.AWARD_TYPE.TITTLE then
      self:set_title_content(item_ui, data.id)
    elseif award_type == Config.AWARD_TYPE.PUZZLE and data.uuid then
      self:set_puzzle_content(item_ui, data)
    elseif award_type == Config.AWARD_TYPE.AVATAR then
      self:set_head_icon_content(item_ui, data.id, player_profile)
      self:set_button_listener(Util.get_button(nil, item_ui.transform), function()
        UIMgr:get_ui("itemTip"):ui_show({
          item_id = data.id,
          is_in_fight = self.v_is_in_fight,
          from_award_show_panel = true,
          jump_cb = function()
            self:ui_hide()
          end
        })
      end)
    else
      local item_id = data.id
      local item_num = data.count
      self:update_item_view(item_ui, item_id, item_num)
      self:set_button_listener(Util.get_button(nil, item_ui.transform), function()
        UIMgr:get_ui("itemTip"):ui_show({
          item_id = item_id,
          is_in_fight = self.v_is_in_fight,
          from_award_show_panel = true,
          jump_cb = function()
            self:ui_hide()
          end
        })
      end)
    end
    local main_content_obj = item_ui.transform:FindChild("Main_Content")
    local main_content_canvas = main_content_obj.gameObject:GetComponent("CanvasGroup")
    local in_pd_go = Util.get_child_gameobj("Main_Content/Ani_Main_Content_In", item_ui.gameObject)
    local in_pd = in_pd_go:GetComponent(type_playable_director)
    main_content_canvas.alpha = 0
    local sequence = Util.create_sequence()
    if not self.v_is_cancel_interval then
      sequence:AppendInterval(index * 0.1)
    end
    sequence:AppendCallback(function()
      in_pd:Play()
      if index == current_scroll_index and current_scroll_index <= self.award_length then
        if not self.v_is_cancel_interval then
          self.v_multi_row_content.transform:DOBlendableLocalMoveBy(Vector3(0, 310, 0), 0.5)
        end
        current_scroll_index = current_scroll_index + 5
      end
    end)
    sequence:OnComplete(function()
      self.animation_is_end[index] = true
      if index == self.award_length then
        self.v_close_text_obj:SetActive(true)
        self.v_cannot_touch_item_btn.gameObject:SetActive(false)
      end
    end)
    sequence:OnKill(function()
      in_pd:Play()
      if index == current_scroll_index and current_scroll_index + 3 <= self.award_length then
        if not self.v_is_cancel_interval then
          self.v_multi_row_content.transform:DOBlendableLocalMoveBy(Vector3(0, 310, 0), 0.3)
        end
        current_scroll_index = current_scroll_index + 5
      end
    end)
    table.insert(self.v_sequences, sequence)
  end
end

return ui
