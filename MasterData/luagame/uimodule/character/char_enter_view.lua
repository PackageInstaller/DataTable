local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CHAR_SELECT_CLASS = require("uimodule.character.char_select_item")
local Char_Helper = require("uimodule.character.char_helper")
local NewModelRtView = require("ui.model_rt_view.signboard_rt_view_new")
local MODEL_CONFIG = require("ui.model_rt_view.model_config")
local CharacterConfig = require("uimodule.character.character_config")
local PanelType = CharacterConfig.PANEL_TYPE
local TRIGGER_SOUND_TYPE = CharacterConfig.TRIGGER_SOUND_TYPE
local LAST_SELECT_BUDDY_IDX_TYPE = CharacterConfig.LAST_SELECT_BUDDY_IDX_TYPE
local ORDER_TYPE2_NAME = CharacterConfig.ORDER_TYPE2_NAME
local ORDER_TYPE = CharacterConfig.ORDER_TYPE
local SORT_RULE = CharacterConfig.SORT_RULE
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local DEFAULT_STARTING_POS = CHAPTER_CONFIG.DEFAULT_STARTING_POS
local BIND_TYPE = Config.BIND_TYPE
local GridLayoutGroup = UnityEngine.UI.GridLayoutGroup
local CommonDefine = require("cs_share.common_define")
local TEAM_BUDDY_TYPE = CommonDefine.TEAM_BUDDY_TYPE
local _insert = table.insert
local UnityShader = UnityEngine.Shader
local MAIN_SCENE_SHOW_ID = UnityShader.PropertyToID("_MAIN_SCENE_SHOW")
local effect_id = "Fx_UI_Switch_Hero"
local MODEL = {
  v_btn_cultivate = {
    "BtnCultivate",
    BIND_TYPE.BUTTON
  },
  v_btn_introduce = {
    "BtnIntroduce",
    BIND_TYPE.BUTTON
  },
  v_btn_lock_char = {
    "BtnLockChar",
    BIND_TYPE.BUTTON
  },
  v_btn_lock = {
    "BtnLock",
    BIND_TYPE.BUTTON
  },
  v_btn_main = {
    "BtnMain",
    BIND_TYPE.BUTTON
  },
  v_btn_teach = {
    "BtnTeach",
    BIND_TYPE.BUTTON
  },
  v_btn_re_move = {
    "Btn_ReMove",
    BIND_TYPE.BUTTON
  },
  v_btn_selcet = {
    "Btn_Selcet",
    BIND_TYPE.BUTTON
  },
  v_btn_screen = {
    "Btn_screen",
    BIND_TYPE.BUTTON
  },
  v_btndangan = {
    "Btndangan",
    BIND_TYPE.BUTTON
  },
  v_buddy_list = {
    "BuddyList",
    BIND_TYPE.IMAGE
  },
  v_cv_red_point = {
    "CVRedPoint",
    BIND_TYPE.IMAGE
  },
  v_char_content = {
    "CharContent",
    BIND_TYPE.OBJECT
  },
  v_char_main = {
    "CharMain",
    BIND_TYPE.OBJECT
  },
  v_char_name = {
    "CharName",
    BIND_TYPE.TEXT
  },
  v_char_tem = {
    "CharTem",
    BIND_TYPE.TOGGLE
  },
  v_favors_fill = {
    "FavorsFill",
    BIND_TYPE.IMAGE
  },
  v_favors_lv = {
    "FavorsLv",
    BIND_TYPE.TEXT
  },
  v_full_screen_background = {
    "FullScreenBackground",
    BIND_TYPE.IMAGE
  },
  v_hero_lable = {
    "HeroLable",
    BIND_TYPE.OBJECT
  },
  v_quality = {
    "Quality",
    BIND_TYPE.IMAGE
  },
  v_rb_team = {
    "RBTeam",
    BIND_TYPE.OBJECT
  },
  v_screen_text = {
    "ScreenText",
    BIND_TYPE.TEXT
  },
  v_screen_up_down = {
    "ScreenUpDown",
    BIND_TYPE.OBJECT
  },
  v_touch_area = {
    "TouchArea",
    BIND_TYPE.OBJECT
  },
  v_zhanli_num = {
    "ZhanliNum",
    BIND_TYPE.TEXT
  }
}
local MODEL_PARAM = MODEL_CONFIG.UI_CHARACTER_ENTER_MODEL_PARAM
local CHAR_SELECT_KEY = "CHAR_SELECT_KEY"

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_btn_cultivate_red = Util.get_child_gameobj("RedPoint", self.v_btn_cultivate.gameObject)
  CharacterMgr.v_is_drop = false
  self:init_template()
  self:set_button("BtnCharRet", function()
    FormationMgr:check_team_preset_show()
    CharacterMgr:reset_temp_data()
    self:set_team_rt_view(true)
    self.v_is_back_hide = true
    self:ui_hide()
  end)
  self:set_button("BtnTeach", function()
    if self:is_open_teaching() then
      UIMgr:get_ui("teach_chapter_point"):ui_show(nil, self.v_select_buddy_id, function()
      end)
      self:check_reset_filter()
    else
      Log.Error("教学未开放--", self.v_buddy_id)
    end
  end)
  self:set_button("BtnPIfu", function()
    local screen_list = self:get_own_buddy_list()
    UIMgr:get_ui("ui_fashionable_dress"):ui_show(self.v_select_buddy_id, screen_list, nil, nil, nil, nil, nil, true)
    self:check_reset_filter()
  end)
  self:set_button("Btndangan", function()
    local buddy_id = self.v_select_buddy_id
    UIMgr:get_ui("char_archive"):ui_show(buddy_id, true)
  end)
  self:set_button("BtnCultivate", function()
    UIMgr:get_ui("character"):ui_show(false, PanelType.ATTR_PANEL)
    self:check_reset_filter()
  end)
  self:set_button("Btn_Selcet", function()
    if self.v_select_idx_type == LAST_SELECT_BUDDY_IDX_TYPE.AID then
      self:change_aid_info()
    elseif self.v_select_idx_type == LAST_SELECT_BUDDY_IDX_TYPE.PLAYER_SHOW then
      self:change_card_show_info()
    else
      self.v_is_back_hide = true
      self:change_team_info(false)
      MsgGame:mq_publish2(Const.MSG_ON_CHOOSE_ROLE)
    end
    CharacterMgr:reset_temp_data()
    CharacterMgr:set_last_select_buddy_id()
    self:set_team_rt_view(true)
  end)
  self:set_button("Btn_ReMove", function()
    if self.v_select_idx_type == LAST_SELECT_BUDDY_IDX_TYPE.AID then
      self:change_aid_info(true)
    elseif self.v_select_idx_type == LAST_SELECT_BUDDY_IDX_TYPE.PLAYER_SHOW then
      self:change_card_show_info(true)
    else
      self.v_is_back_hide = true
      self:change_team_info(true)
    end
    CharacterMgr:reset_temp_data()
    CharacterMgr:set_last_select_buddy_id()
    self:set_team_rt_view(true)
  end)
  self:set_button("Btn_Assist", function()
    UIMgr:get_ui("char_assist"):ui_show(self.v_team_data, nil, nil, nil, nil, nil, nil, true)
  end)
  self:set_button("Btn_screen", function()
    UIMgr:get_ui("screen_buddy_tips"):ui_show()
  end)
  self:set_button("BtnSort", function()
    UIMgr:get_ui("sort_buddy_tips"):ui_show()
  end)
  self:set_button("ScreenUpDown", function()
    CharacterMgr.v_is_drop = not CharacterMgr.v_is_drop
    local rot_z = CharacterMgr.v_is_drop and 0 or 180
    self.v_screen_up_down.transform:SetEuler(0, 0, rot_z)
    self:force_refresh_char_select_list()
  end)
  self:set_button("EleIcon", function()
    if self.v_select_buddy_id then
      UIMgr:get_ui("element_job_tips"):ui_show(self.v_select_buddy_id, Config.CHAR_TIP_PAGE_TYPE.ELEMENT)
    end
  end)
  self:set_button("JobIcon", function()
    if self.v_select_buddy_id then
      UIMgr:get_ui("element_job_tips"):ui_show(self.v_select_buddy_id, Config.CHAR_TIP_PAGE_TYPE.JOB)
    end
  end)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.CVRedPoint, RedEnum.CHAR_CV)
  self:get_child_gameobj("SysOpen/RedPoint", self.v_uiobjects.BtnPIfu):SetActive(false)
  self.v_content_grid_layout_group = Util.get_component(nil, self.v_char_content, typeof(GridLayoutGroup))
end

function ui:check_reset_filter()
  if not self.v_is_in_show_list then
    CharacterMgr:set_screen_condtion(1)
  end
end

function ui:init_template()
  self:register_exist_auto_template(CHAR_SELECT_KEY, self.v_uiobjects.CharTem, self.v_char_content)
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_CHAR_SELECT, self.response_char_select, self)
  self:bind_auto_mq(Const.MSG_ON_BUDDY_CHANGE, self.force_refresh_char_select_list, self)
  self:bind_auto_mq(Const.MSG_ON_HERO_UPDATE_FASHION, self.change_fashion, self)
end

function ui:ui_on_show(team_data, load_done_cb, open_type)
  Global.sound_mgr:set_bgm_volume(nil, 0.5, 1)
  self.v_team_data = team_data
  self.v_load_done_cb = load_done_cb
  if team_data then
    self.v_ban_buddys = team_data.ban_buddys
    self.v_fixed_buddys = team_data.fixed_buddys
    self.v_offer_robot_list = team_data.offer_robot_list
    CharacterMgr:not_show_sys_red(true)
    self.v_rb_team:SetActive(true)
  else
    CharacterMgr:not_show_sys_red(false)
    self.v_rb_team:SetActive(false)
  end
  self.v_select_idx_type = team_data and LAST_SELECT_BUDDY_IDX_TYPE.TEAM or LAST_SELECT_BUDDY_IDX_TYPE.MAIN
  self:set_open_type_data(open_type)
  self.v_init = true
  self:refresh_char_select_list()
  self:register_event()
  self:set_team_rt_view(false)
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 1)
  local rot_z = CharacterMgr.v_is_drop and 0 or 180
  self.v_screen_up_down.transform:SetEuler(0, 0, rot_z)
end

function ui:set_open_type_data(open_type)
  self.v_open_type = open_type
  if not open_type then
    return
  end
  self.v_rb_team:SetActive(true)
  self.v_uiobjects.BtnLock:SetActive(false)
  CharacterMgr:not_show_sys_red(true)
  if open_type == LAST_SELECT_BUDDY_IDX_TYPE.AID then
    self.v_select_data = CharacterMgr:get_aid_data()
    self.v_select_idx_type = LAST_SELECT_BUDDY_IDX_TYPE.AID
  elseif open_type == LAST_SELECT_BUDDY_IDX_TYPE.PLAYER_SHOW then
    self.v_select_data = CharacterMgr:get_card_show_data()
    self.v_select_idx_type = LAST_SELECT_BUDDY_IDX_TYPE.PLAYER_SHOW
  end
end

function ui:ui_on_update()
  if self.v_model_view then
    self.v_model_view:update()
  end
end

function ui:clear_wrap_items()
  if self.v_all_buddy_item_list then
    for _, buddy_item in pairs(self.v_all_buddy_item_list) do
      buddy_item.obj:ui_hide()
      buddy_item.obj:ui_destroy()
    end
    self.v_all_buddy_item_list = nil
  end
end

function ui:ui_on_hide()
  FormationMgr:clear_cache_team_preset_show()
  if not UIMgr:try_get_visible_ui("team") then
    UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 0)
  end
  self.v_select_data = nil
  self.v_screen_list = nil
  self.v_select_buddy_idx = nil
  self.v_select_buddy_id = nil
  self.v_select_buddy_robot_id = nil
  self.v_offer_robot_list = nil
  self.v_fixed_buddys = nil
  self.v_ban_buddys = nil
  self:clear_wrap_items()
  self:release_model()
  self.v_load_done_cb = nil
  self:refresh_other_view_fight_value()
  self.v_is_back_hide = nil
end

function ui:set_team_rt_view(enable)
  if self.v_team_data and self.v_team_data.need_enable_rt_view then
    local team = UIMgr:try_get_ui("team")
    if team then
      if enable then
        team:set_model_enable()
      else
        team:set_model_disable()
      end
    end
  end
end

function ui:ui_on_destroy()
  self:release_model()
end

function ui:show_select_item_effect(new_select_idx)
  local old_select_idx = self:get_buddy_idx_by_id(self.v_select_buddy_id, self.v_select_buddy_robot_id ~= nil)
  self:set_select_item_effect(old_select_idx, false)
  self:set_select_item_effect(new_select_idx, true)
end

function ui:set_select_item_effect(idx, if_show)
  if idx and self.v_all_buddy_item_list[idx] then
    self.v_all_buddy_item_list[idx].obj:set_select_effect(if_show)
    if if_show then
      local red_status = self.v_all_buddy_item_list[idx].obj:get_red_status()
      self.v_btn_cultivate_red:SetActive(red_status)
    end
  end
end

function ui:force_refresh_char_select_list()
  self:refresh_char_select_list(true)
end

function ui:refresh_char_select_list(force_to_top)
  self.v_is_in_show_list = true
  self:set_screen_list()
  local screen_list_cp = self.v_screen_list
  local last_select_id, is_robot
  if self.v_should_select_char_id then
    last_select_id, is_robot = self.v_should_select_char_id, false
    self.v_should_select_char_id = nil
    local is_ban = self:is_buddy_ban(last_select_id)
    local is_fixed = self:is_buddy_fixed(last_select_id)
    if is_ban or is_fixed then
      if self.v_team_data then
        self.v_team_data.init_select = false
      end
      last_select_id, is_robot = self:get_select_id()
    end
  else
    last_select_id, is_robot = self:get_select_id()
  end
  local select_idx = last_select_id and self:get_buddy_idx_by_id(last_select_id, is_robot) or 1
  self:clear_wrap_items()
  self.v_all_buddy_item_list = {}
  self:give_back_auto_cache(CHAR_SELECT_KEY)
  for idx, screen_buddy_data in ipairs(screen_list_cp) do
    local item = self:get_auto_cache(CHAR_SELECT_KEY)
    local if_own = nil ~= screen_buddy_data.info
    local if_robot = nil ~= screen_buddy_data.robot_info
    local buddy_id = screen_buddy_data.id
    local select_obj = CHAR_SELECT_CLASS:ui_wrap_ex(self, item, true)
    select_obj.go = item
    select_obj:set_data(screen_buddy_data, self.v_team_data, self.v_select_data)
    select_obj:disable_tog()
    local insert_data = {
      own = if_own,
      robot = if_robot,
      id = buddy_id,
      obj = select_obj,
      buddy_info = screen_buddy_data
    }
    _insert(self.v_all_buddy_item_list, insert_data)
    if select_idx == idx then
      local succ = select_obj:enable_tog()
      if not succ then
        self.v_is_in_show_list = false
      end
    end
  end
  local move_row, offset = 0, 0
  if not force_to_top then
    move_row = math.ceil(select_idx / 3) - 1
    offset = self.v_content_grid_layout_group.spacing.y + self.v_content_grid_layout_group.cellSize.y
  end
  self.v_uicompents.CharContent_rect:SetAnchoredPositionA(0, move_row * offset)
end

function ui:is_table_empty(tbl)
  return not tbl or 0 == #tbl
end

function ui:set_screen_list()
  local v_order_type = CharacterMgr.v_screen_type or ORDER_TYPE.DEFAULT
  self.v_screen_text.text = ORDER_TYPE2_NAME[v_order_type]
  local element_list = CharacterMgr.v_attr_screen_list
  local job_list = CharacterMgr.v_job_screen_list
  local tag_list = CharacterMgr.v_tag_screen_list
  self.v_uiobjects.Screening:SetActiveEx(not self:is_table_empty(element_list) or not self:is_table_empty(job_list) or not self:is_table_empty(tag_list))
  self.v_screen_list = {}
  local buddy_config = ShareRes.create("buddy.buddy")
  local own_list = UtilTable.copy_table(CharacterMgr:get_buddy_map())
  for buddy_id, cfg in pairs(buddy_config) do
    if 1 ~= cfg.IsShow and CharacterMgr:check_buddy_release(buddy_id) then
      local element_cond = self:is_table_empty(element_list) or UtilTable.contains(element_list, cfg.Element)
      local job_cond = self:is_table_empty(job_list) or UtilTable.contains(job_list, cfg.Job)
      local tag_cond = not (not self:is_table_empty(tag_list) and cfg.Tag) or UtilTable.contains(tag_list, cfg.Tag[1]) or UtilTable.contains(tag_list, cfg.Tag[2])
      if element_cond and job_cond and tag_cond then
        local is_ban = self:is_buddy_ban(buddy_id)
        local is_fixed = self:is_buddy_fixed(buddy_id)
        local is_in_team = self:check_is_formation(buddy_id)
        local info = own_list[buddy_id]
        if info then
          info.element = cfg.Element
          info.fashion_id = FashionMgr:get_fashion_wearing_id(buddy_id)
        end
        local data = {
          id = buddy_id,
          element = cfg.Element,
          quality = cfg.Quality,
          info = info,
          is_ban = is_ban,
          is_fixed = is_fixed,
          is_in_team = is_in_team
        }
        _insert(self.v_screen_list, data)
      end
    end
  end
  if self.v_offer_robot_list then
    for _, robot_id in pairs(self.v_offer_robot_list) do
      local robot_cfg = ShareRes.get_fixed_buddy_config(robot_id)
      if not robot_cfg then
        Log.Error("机器人配置不存在，ID：", robot_id)
        break
      end
      local buddy_id = robot_cfg.BuddyId
      local cfg = buddy_config[buddy_id]
      local robot_info = {
        break_lv = robot_cfg.BreakLv,
        advance = robot_cfg.AdvanceLv,
        lv = robot_cfg.Lv,
        quality = cfg.Quality,
        power = robot_cfg.Power,
        fashion_id = robot_cfg.FashionId,
        equip_fashion = robot_cfg.WeaponFashionId
      }
      local element_cond = not element_list or 0 == #element_list or UtilTable.contains(element_list, cfg.Element)
      local job_cond = not job_list or 0 == #job_list or UtilTable.contains(job_list, cfg.Job)
      local tag_cond = not tag_list or 0 == #tag_list or cfg.Tag and (UtilTable.contains(tag_list, cfg.Tag[1]) or UtilTable.contains(tag_list, cfg.Tag[2]))
      if element_cond and job_cond and tag_cond then
        local is_ban = self:is_buddy_ban(buddy_id)
        local is_fixed = self:is_buddy_fixed(buddy_id)
        local is_in_team = self:check_is_formation(buddy_id, robot_id)
        local data = {
          id = buddy_id,
          element = cfg.Element,
          info = nil,
          is_ban = is_ban,
          is_fixed = is_fixed,
          is_in_team = is_in_team,
          robot_id = robot_id,
          robot_info = robot_info,
          fashion_id = robot_cfg.FashionId
        }
        _insert(self.v_screen_list, data)
      end
    end
  end
  if self.v_all_buddy_item_list then
    for _, item in ipairs(self.v_all_buddy_item_list) do
      item.obj:set_select_effect(false)
      item.obj:disable_tog()
    end
  end
  self:sort_type(v_order_type)
end

function ui:sort_type(v_order_type)
  local sort_rule = SORT_RULE[v_order_type]
  table.sort(self.v_screen_list, function(a, b)
    if a.is_in_team ~= b.is_in_team then
      return a.is_in_team
    end
    if a.robot_id ~= nil ~= (b.robot_id ~= nil) then
      return a.robot_id ~= nil
    end
    local info_a = a.info
    local info_b = b.info
    if nil ~= info_a ~= (nil ~= info_b) then
      return nil ~= info_a
    end
    if a.is_fixed ~= b.is_fixed then
      return b.is_fixed
    end
    if a.is_ban ~= b.is_ban then
      return b.is_ban
    end
    if nil ~= info_a then
      for _, type in ipairs(sort_rule) do
        if info_a[type] ~= info_b[type] then
          if CharacterMgr.v_is_drop then
            return info_a[type] < info_b[type]
          else
            return info_a[type] > info_b[type]
          end
        end
      end
    else
      if a.robot_id ~= nil ~= (b.robot_id ~= nil) then
        return a.robot_id ~= nil
      end
      if a.robot_id ~= nil then
        local robot_info_a = a.robot_info
        local robot_info_b = b.robot_info
        for _, type in ipairs(sort_rule) do
          if robot_info_a[type] ~= robot_info_b[type] then
            if CharacterMgr.v_is_drop then
              return robot_info_a[type] < robot_info_b[type]
            else
              return robot_info_a[type] > robot_info_b[type]
            end
          end
        end
      end
    end
    if a.quality ~= b.quality then
      if CharacterMgr.v_is_drop then
        return a.quality < b.quality
      else
        return a.quality > b.quality
      end
    end
    if CharacterMgr.v_is_drop then
      return a.id > b.id
    else
      return a.id < b.id
    end
  end)
end

function ui:get_own_buddy_list()
  local screen_list = self.v_screen_list
  local buddy_config = ShareRes.create("buddy.buddy")
  local buddy_list = {}
  for _, data in pairs(screen_list) do
    local cfg = buddy_config[data.id]
    if 1 ~= cfg.IsShow and CharacterMgr:check_buddy_release(data.id) then
      _insert(buddy_list, data.id)
    end
  end
  return buddy_list
end

function ui:get_buddy_idx_by_id(buddy_id, is_robot)
  for i, v in ipairs(self.v_screen_list) do
    if v.id == buddy_id and (not is_robot and v.robot_id == nil or is_robot and v.robot_id ~= nil) then
      return i
    end
  end
  return 1
end

function ui:get_select_id()
  local last_select_id, last_select_is_robot = CharacterMgr.v_last_select_buddy_id, false
  if self.v_team_data and not self.v_team_data.init_select then
    local team_pos_data = self.v_team_data.pos_data
    local select_pos = self.v_team_data.select_pos
    local select_data = team_pos_data[select_pos]
    if select_data and 0 ~= select_data.buddy_id then
      self.v_team_data.init_select = true
      last_select_id = select_data.buddy_id
      last_select_is_robot = select_data.robot_id ~= nil
    else
      last_select_id = self.v_screen_list[1].id
      last_select_is_robot = nil ~= self.v_screen_list[1].robot_id
      for _, data in ipairs(self.v_screen_list) do
        if not data.is_fixed and not data.is_ban and not data.is_in_team and (data.info or data.robot_info) then
          last_select_id = data.id
          last_select_is_robot = data.robot_id ~= nil
          self.v_team_data.init_select = true
          break
        end
      end
    end
  end
  if self.v_select_idx_type == LAST_SELECT_BUDDY_IDX_TYPE.PLAYER_SHOW or self.v_select_idx_type == LAST_SELECT_BUDDY_IDX_TYPE.AID then
    last_select_id = self.v_select_buddy_id and self.v_select_buddy_id or self.v_select_data and self.v_select_data.select_buddy_id
    if last_select_id and 0 ~= last_select_id then
      return last_select_id
    end
    last_select_id = self.v_screen_list[1].id
    local select_list = self.v_select_data and self.v_select_data.select_list
    local select_buddy_map = {}
    if select_list then
      for _, _id in ipairs(select_list) do
        if 0 ~= _id then
          select_buddy_map[_id] = true
        end
      end
    end
    for index, data in ipairs(self.v_screen_list) do
      if data.info and not select_buddy_map[data.id] then
        last_select_id = data.id
        break
      end
    end
  end
  return last_select_id, last_select_is_robot
end

function ui:refresh_char_info(buddy_id)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  self.v_char_name.text = buddy_cfg.Name
  Char_Helper.set_buddy_tag_txt(self.v_uicompents.Tag1_txt, self.v_uicompents.Tag2_txt, buddy_cfg)
  Char_Helper.set_buddy_quality_star(self.v_uiobjects, buddy_cfg.Quality)
  if self.v_uiobjects.Ani_UIChar_Enter3_Change then
    self.v_uiobjects.Ani_UIChar_Enter3_Change:SetActive(false)
    self.v_uiobjects.Ani_UIChar_Enter3_Change:SetActive(true)
  end
  local char_job_icon = Char_Helper.get_char_job_icon(buddy_id)
  ResMgr:load_set_icon(self.v_uicompents.JobIcon_img, char_job_icon)
  local element_icon_path = Char_Helper.get_char_element_icon(buddy_id)
  ResMgr:load_set_icon(self.v_uicompents.EleIcon_img, element_icon_path)
  self:refresh_power_val(buddy_id)
end

function ui:refresh_power_val(buddy_id)
  self.v_zhanli_num.text = CharacterMgr:get_buddy_combat_effectiveness(buddy_id, self.v_select_buddy_robot_id ~= nil, self.v_select_buddy_robot_id)
end

function ui:response_char_select(msg)
  if nil == msg or nil == msg.mm_x then
    return
  end
  local buddy_id = msg.mm_x
  local robot_id = msg.mm_y
  local buddy_idx = self:get_buddy_idx_by_id(buddy_id, nil ~= robot_id)
  self:show_select_item_effect(buddy_idx)
  CharacterMgr:update_buddy_red(buddy_id)
  self:refresh_power_val(buddy_id)
  local data = self.v_screen_list[buddy_idx]
  local equip_fashion = data.robot_info and data.robot_info.equip_fashion or nil
  self:update_model_view(buddy_id, data.fashion_id, equip_fashion)
  if buddy_id == self.v_select_buddy_id and robot_id == self.v_select_buddy_robot_id then
    return
  end
  self.v_select_buddy_id = buddy_id
  self.v_select_buddy_robot_id = robot_id
  self:refresh_char_info(buddy_id)
  if not robot_id then
    CharacterMgr:set_last_select_buddy_id(buddy_id)
    CharacterMgr:on_update_archive_info_red(buddy_id)
    CharacterMgr:on_update_archive_voice_red(buddy_id)
    self:refresh_favors(buddy_id)
  end
  self:refresh_team_btn_view()
  self:refresh_operation_btn_show()
  self:refresh_teach_btn_show()
  self:refresh_robot_btn_show()
  self.v_init = false
end

function ui:update_model_view(buddy_id, fashion_id, equip_fashion)
  if not buddy_id or buddy_id < 1 then
    return
  end
  self.v_cur_model = buddy_id
  local model_fashion_id
  if fashion_id then
    model_fashion_id = FashionMgr:get_fashion_model_id_by_fashion_id(fashion_id)
  end
  model_fashion_id = model_fashion_id or FashionMgr:get_fashion_model_id(buddy_id)
  local model_idx
  
  local function load_npc_cb()
    self:load_npc_cb()
    if self.v_model_view and self.v_model_view.set_npc_pos_rot_euler then
      self.v_model_view:set_npc_pos_rot_euler()
    end
    CharacterMgr:play_hero_approach_anim(buddy_id, 1, self.v_model_view)
  end
  
  local use_weapon_res
  if equip_fashion then
    local cfg = ShareRes.get_weapon_fashion_cfg(equip_fashion)
    use_weapon_res = cfg and cfg.WeaponRes or nil
  end
  local params = {
    model_id = model_fashion_id,
    npc_id = buddy_id,
    is_reload = self.v_model_view ~= nil,
    cb = load_npc_cb,
    do_preload_attach_model = true,
    use_weapon_res = use_weapon_res
  }
  if not self.v_model_view then
    self:change_bg_state(true)
    self.v_model_view = NewModelRtView:new(MODEL_PARAM.BG_NAME, nil, function()
      if self.v_load_done_cb then
        local cb = self.v_load_done_cb
        cb()
        if not SceneMgr:check_main_scene() and not Util.is_destroy(Global.hero) then
          Global.hero:set_obj_enable(false)
        end
        self.v_load_done_cb = nil
      end
      self:change_bg_state(false)
    end)
    self.v_model_view:is_play_show_effect(true, effect_id)
    model_idx = self.v_model_view:load_npc(params)
    local camera_param = MODEL_PARAM.INIT_CAMERA_PARAM
    self.v_model_view:set_camera_param(camera_param)
  else
    self.v_model_view:is_play_show_effect(true, effect_id)
    model_idx = self.v_model_view:load_npc(params)
  end
  fashion_id = fashion_id or FashionMgr:get_fashion_wearing_id(buddy_id)
  self.v_model_view:set_view_param(buddy_id, 1, true, true, model_idx, fashion_id)
  self.v_model_view:set_touch_area(nil)
end

function ui:load_npc_cb()
  if self.v_model_view then
    self.v_model_view:hide_model_node(false)
  end
end

function ui:get_model_view()
  return self.v_model_view
end

function ui:release_model()
  if self.v_model_view then
    self.v_model_view:on_destroy()
    self.v_model_view = nil
    self.v_cur_model = nil
  end
end

function ui:change_fashion(msg)
  local buddy_id = msg.mm_obj
  if buddy_id ~= self.last_buddy_id then
    return
  end
  self:update_model_view(buddy_id)
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_team_data, nil, nil, self.v_open_type
end

function ui:refresh_team_btn_view()
  self.v_uiobjects.Btn_Assist:SetActive(false)
  if not self.v_team_data then
    return
  end
  local formation_type = self.v_team_data.formation_type
  local point_id = self.v_team_data.point_id
  local buddy_id = self.v_select_buddy_id
  local robot_id = self.v_select_buddy_robot_id
  local is_formation = self:check_is_formation(buddy_id, robot_id)
  local is_remove = true == is_formation
  local is_lock = false
  if formation_type == CommonDefine.FORMATION_TYPE.WEEK_ACTY_PVP_TEAM and not is_remove then
    is_lock = WeeklyMgr:get_is_pvp_used(buddy_id)
  end
  local is_fixed = self:is_buddy_fixed(buddy_id)
  self.v_uiobjects.Btn_ReMove:SetActive(is_remove and not is_fixed)
  self.v_uiobjects.BtnLock:SetActive(is_lock)
  self.v_uiobjects.Btn_Selcet:SetActive(not is_remove)
end

function ui:check_is_weekly(formation_type)
  if formation_type == CommonDefine.FORMATION_TYPE.WEEK_ACTY_PREPARE_TEAM then
    return true
  elseif formation_type == CommonDefine.FORMATION_TYPE.WEEK_ACTY_PVP_TEAM then
    return true
  end
  return false
end

function ui:check_show_lock_btn(buddy_id)
  local team_data = self.v_team_data
  local use_fixed_char_pool = team_data.use_fixed_char_pool
  if not use_fixed_char_pool then
    return
  end
  local pos_data = team_data.pos_data
  for key, data in pairs(pos_data) do
    if data.buddy_id == buddy_id and data.pos == DEFAULT_STARTING_POS then
      return true
    end
  end
  local point_id = team_data.point_id
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  if not point_cfg then
    return
  end
  local fixed_pool_list = point_cfg.ReplaceFormation
  if not fixed_pool_list or #fixed_pool_list <= 0 then
    return
  end
  for _, fixed_pool_id in ipairs(fixed_pool_list) do
    local pool_cfg = ShareRes.get_fixed_char_pool(fixed_pool_id)
    Util.assert(pool_cfg, "缺少角色池子配置，id = " .. fixed_pool_id)
    for _, data in pairs(pool_cfg.RobotList) do
      if data.BuddyId == buddy_id then
        return true
      end
    end
  end
end

function ui:check_is_formation(buddy_id, robot_id)
  local team_data = self.v_team_data
  if not team_data then
    return false
  end
  local pos_data = team_data.pos_data
  if not pos_data then
    return false
  end
  for key, data in pairs(pos_data) do
    if data.buddy_type ~= TEAM_BUDDY_TYPE.HELP_FIGHT and data.buddy_id == buddy_id and (not (data.robot_id or robot_id) or data.robot_id and data.robot_id == robot_id) then
      return true
    end
  end
  return false
end

function ui:change_team_info(is_remove)
  local select_prefab_team_id = self.v_team_data.select_prefab_team_id
  if select_prefab_team_id then
    self:change_prefab_team(is_remove)
  else
    local team = UIMgr:try_get_visible_ui("team")
    if team then
      local target_pos = self.v_team_data.select_pos
      local select_buddy_id = self.v_select_buddy_id
      local robot_id
      if is_remove then
        target_pos = 0
      else
        robot_id = self.v_select_buddy_robot_id
        CharacterMgr:trigger_buddy_sound(TRIGGER_SOUND_TYPE.GOTO_TEAM, select_buddy_id)
      end
      team:update_pos_hero(target_pos, select_buddy_id, robot_id)
    end
  end
  self:ui_hide()
end

function ui:change_prefab_team(is_remove)
  local target_pos = self.v_team_data.select_pos
  local select_buddy_id = self.v_select_buddy_id
  local select_prefab_team_id = self.v_team_data.select_prefab_team_id
  local old_buddys = self.v_team_data.pos_data or {}
  if is_remove then
    for key, old_buddy_data in pairs(old_buddys) do
      if old_buddy_data.buddy_id == select_buddy_id then
        old_buddy_data.buddy_id = 0
      end
    end
  else
    old_buddys[target_pos] = {
      buddy_type = TEAM_BUDDY_TYPE.PLAYER,
      buddy_id = select_buddy_id,
      pos = target_pos
    }
  end
  local save_data = {}
  for pos, old_buddy_data in pairs(old_buddys) do
    if 0 ~= old_buddy_data.buddy_id then
      save_data[pos] = old_buddy_data
    end
  end
  FormationMgr:save_prefab_team(select_prefab_team_id, nil, save_data)
  FormationMgr:check_team_preset_show()
end

function ui:refresh_other_view_fight_value()
  local team = UIMgr:try_get_visible_ui("team")
  if team and self.v_is_back_hide then
    team:refresh_view_with_char_enter_view_hide()
  end
  if not team and not SceneMgr:check_main_scene() and not Util.is_destroy(Global.hero) then
    Global.hero:set_obj_enable(true)
  end
end

function ui:change_bg_state(is_on)
  self.v_full_screen_background:SetActive(is_on)
end

function ui:refresh_operation_btn_show()
  if not self.v_select_data then
    return
  end
  self.v_select_data.select_buddy_id = self.v_select_buddy_id
  local in_select_list = false
  for key, buddy_id in pairs(self.v_select_data.select_list) do
    if buddy_id == self.v_select_buddy_id then
      in_select_list = true
      break
    end
  end
  self.v_uiobjects.Btn_Selcet:SetActive(not in_select_list)
  self.v_uiobjects.Btn_ReMove:SetActive(in_select_list)
end

function ui:change_aid_info(is_remove)
  local pos = self.v_select_data.select_pos
  local buddy_id = self.v_select_buddy_id
  if is_remove then
    for index, id in ipairs(self.v_select_data.select_list) do
      if id == buddy_id then
        pos = index
      end
    end
    buddy_id = 0
  end
  
  local function cb()
    self:ui_hide()
  end
  
  CharacterMgr:req_set_assist_buddy(pos, buddy_id, cb)
end

function ui:change_card_show_info(is_remove)
  local pos = self.v_select_data.select_pos
  local buddy_id = self.v_select_buddy_id
  if is_remove then
    for index, id in ipairs(self.v_select_data.select_list) do
      if id == buddy_id then
        pos = index
      end
    end
    buddy_id = 0
  end
  CharacterMgr:set_card_show_list_info(pos, buddy_id)
  self:ui_hide()
end

function ui:select_char(char_id)
  self.v_should_select_char_id = char_id
end

function ui:refresh_teach_btn_show()
  local is_robot = self.v_select_buddy_robot_id ~= nil
  local is_open = self:is_open_teaching() and not is_robot
  self.v_uiobjects.BtnTeach:SetActive(is_open)
  if not self.v_btn_teach_red then
    self.v_btn_teach_red = self:get_child_gameobj("SysOpen/RedPoint", self.v_uiobjects.BtnTeach)
  end
  if is_open then
    local progress = ActivityMgr:invoke(CommonDefine.ACTY_TYPE.BUDDY_TEACH, "get_teach_progress", self.v_select_buddy_id)
    self.v_btn_teach_red:SetActive(100 ~= progress)
  end
end

function ui:refresh_robot_btn_show()
  local is_robot = self.v_select_buddy_robot_id ~= nil
  self.v_uiobjects.BtnPIfu:SetActive(not is_robot)
  self.v_uiobjects.BtnCultivate:SetActive(not is_robot)
  Util.get_canvas_group(nil, self.v_uiobjects.BtnCultivate).alpha = 1
end

function ui:refresh_favors(buddy_id)
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  self.v_uicompents.FavorsLv_txt.text = buddy_info.favor_lv
  local max_lv = ShareRes.get_max_favor_lv()
  if max_lv <= buddy_info.favor_lv then
    self.v_uicompents.FavorsFill_img.fillAmount = 1
  else
    local cfg = ShareRes.get_favor_lv_cfg(buddy_id, buddy_info.favor_lv)
    self.v_uicompents.FavorsFill_img.fillAmount = buddy_info.favor_exp / cfg.Exp
  end
  local max_exp = ShareRes.get_comm_value("DayGrantFavorMaxCount")
  self.v_uiobjects.GetFavorsMax:SetActive(max_exp <= (buddy_info.favor_already_exp or 0))
end

function ui:is_open_teaching()
  return CharacterMgr:is_open_teaching_entry(self.v_select_buddy_id)
end

function ui:is_buddy_ban(buddy_id)
  if self.v_team_data and self.v_team_data.formation_type == CommonDefine.FORMATION_TYPE.WEEK_ACTY_PVP_TEAM then
    return WeeklyMgr:get_is_pvp_used(buddy_id)
  end
  if self.v_ban_buddys and self.v_ban_buddys[buddy_id] then
    return true
  end
end

function ui:is_buddy_fixed(buddy_id)
  if self.v_fixed_buddys and self.v_fixed_buddys[buddy_id] then
    return true
  end
end

return ui
