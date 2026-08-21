local AssetBarView = require("ui.asset_bar.asset_bar")
local TagList = require("uimodule.ui_draw_card.drawcard_tag_list")
local group_cfg = require("config").UI_GROUPS
local type_cfg = require("config").UI_VIEW_LEVEL
local order_cfg = require("config").UI_SORT_ORDER
local UnityFind = _ENV.UnityFind
local TypeSceneContainer = typeof(CS.Game.SceneContainer)
local _tinsert = table.insert
local _tsort = table.sort
local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_tag_content = {
    "TagContent",
    BIND_TYPE.OBJECT
  },
  v_tag_scroll = {
    "TagScroll",
    BIND_TYPE.SCROLL
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnNextPage", function()
    local after_index, len = self.v_tag_list:last_or_next_index(true)
    self:_set_scroll_value(after_index, len)
  end)
  self:set_button("BtnLastPage", function()
    local after_index, len = self.v_tag_list:last_or_next_index(false)
    self:_set_scroll_value(after_index, len)
  end)
  self.v_tag_list = TagList:ui_wrap(self, self.v_tag_content)
  self.v_last_view_name = nil
  self.v_tag_list:set_select_cb(function(pool_id)
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.uidrawcard_switch_UI_SOUND)
    self:_refresh_detail(pool_id)
  end)
  self.v_mask = self:get_child_gameobj("ImageMask")
end

function ui:ui_on_show(cache_pool_id)
  self.v_uimain = UIMgr:try_get_visible_ui("uimain")
  if self.v_uimain then
    self.v_uimain:set_model_view_visible(true)
  end
  self.v_is_cache = nil ~= cache_pool_id
  self:_refresh_tag_list()
  self.v_tag_list:try_select(cache_pool_id)
  self.v_tag_scroll.horizontalNormalizedPosition = 0
  self:bind_auto_mq(Const.MSG_DRAW_GROUP_LIST_UPDATE, self._handle_group_list_update, self)
  self:init_container()
  SignBoardGirlMgr:set_clock_update(true)
  self:enable_mask(false)
end

function ui:init_container()
  local root_gameobj = UnityFind("Root")
  if not root_gameobj or root_gameobj:IsNull() then
    return
  end
  self.v_container = root_gameobj:GetComponent(TypeSceneContainer)
  self.v_video_player = self.v_container:Get("Video")
  self.v_vcamera_control = self.v_container:Get("VirtualCamera_Control")
  local draw_card_pd_name = FashionMgr:get_curr_fashion_draw_card_pd_name()
  FashionMgr:show_fashion_draw_card_pd(draw_card_pd_name, self.v_vcamera_control)
  local draw_card_pd_go = Util.get_child_gameobj(draw_card_pd_name, self.v_vcamera_control)
  self.v_drawcard_focus_on_clock_pd = Util.get_playabledirector("FocusOnClock", draw_card_pd_go)
  self.v_drawcard_close_to_clock_pd = Util.get_playabledirector("CloseToClock", draw_card_pd_go)
  local shuttle_pd = Util.get_playabledirector("Shuttle", draw_card_pd_go)
  shuttle_pd.time = 0
  shuttle_pd:Evaluate()
  self.v_drawcard_close_to_clock_pd:Stop()
  self.v_drawcard_focus_on_clock_pd.time = 0
  self.v_drawcard_focus_on_clock_pd:Evaluate()
  if self.v_is_cache then
    self.v_vcamera_control:SetActive(false)
    self.v_vcamera_control:SetActive(true)
    self.v_drawcard_focus_on_clock_pd:Play()
    self.v_drawcard_focus_on_clock_pd:Stop()
  end
  self.v_ani_step_clock = self.v_container:Get("Clock"):GetComponent(TypeUnityAnimator)
  self.v_ani_step_clock:Play("FocusOnClock_Empty", -1, 0)
  self.v_ui_out_pd = Util.get_playabledirector("Animation/Ani_UIDrawCard_All_Out", self.v_object)
end

function ui:focus_on_clock(stopped_func)
  self.v_uimain:get_model_view():set_vcamera_brain_enabled(true)
  self.v_drawcard_focus_on_clock_pd:Play()
  self.v_ui_out_pd.time = 0
  self.v_ui_out_pd:Play()
  self.v_drawcard_focus_on_clock_pd.transform:SetTimelineSeqEndCB(stopped_func)
  self.v_video_player:SetActive(false)
end

function ui:enable_mask(enable)
  self.v_mask:SetActive(enable)
end

function ui:ui_on_hide()
  self.v_last_view_name = nil
end

function ui:ui_on_destroy()
end

function ui:_handle_group_red_change()
  self.v_tag_list:refresh_red()
end

function ui:_handle_group_list_update()
  if not self.v_mask.activeSelf then
    self:_refresh_tag_list()
  end
end

local function _tag_sorter(a, b)
  if a.sort_value ~= b.sort_value then
    return a.sort_value > b.sort_value
  end
  return a.tag_id > b.tag_id
end

local function _sub_tag_sorter(a, b)
  if a.sort_value ~= b.sort_value then
    return a.sort_value > b.sort_value
  end
  return a.pool_id > b.pool_id
end

function ui:_build_tag_data()
  local group_list = DrawCardMgr:get_group_list()
  local sub_list = {}
  local pool_config
  for _, group_vo in ipairs(group_list) do
    local pool_dic = group_vo:get_all_pool_vo()
    for _, pool_vo in pairs(pool_dic) do
      pool_config = pool_vo:get_config()
      _tinsert(sub_list, {
        group_id = group_vo.id,
        pool_id = pool_vo.id,
        sort_value = pool_config.Sort
      })
    end
  end
  _tsort(sub_list, _sub_tag_sorter)
  return sub_list
end

function ui:_refresh_tag_list()
  self.v_tag_list:set_data(self:_build_tag_data())
end

function ui:_refresh_asset_bar(item_id)
  local config = {
    self.v_asset_bar:get_default_config_by_id(Config.DIAMOND_ITEMID),
    {
      item_id = item_id,
      func = "_on_click_draw_item",
      const_event = Const.MSG_ROLE_RES_CHANGE,
      bg_click = true
    }
  }
  self.v_asset_bar:reset_config(config)
  self.v_asset_bar:on_create()
end

local type2_sup_part = {
  [0] = "uidrawcard_detail_sub_part_character",
  [4] = "uidrawcard_detail_sub_part_selectable"
}

function ui:_check_add_ui_config(ui_name, pool_type)
  local ui_config = Global.uiconfig.ui
  if nil == ui_config[ui_name] then
    local path = string.format("prefab/drawcards/%s.prefab", ui_name)
    ui_config[ui_name] = {
      resource = path,
      class = "ui_draw_card.uidrawcard_detail",
      sort_order = order_cfg.MainView,
      group = group_cfg.GROUP_NORMAL,
      sync_load = true,
      parent_ui = "uidrawcard",
      view_level = type_cfg.MAIN_VIEW,
      normal_update = true
    }
    local sub_panel_name = type2_sup_part[pool_type] or type2_sup_part[0]
    if sub_panel_name then
      ui_config[ui_name].panels = {
        {
          name = "sub_panel",
          root = "Region",
          class = string.format("ui_draw_card/%s", sub_panel_name),
          initshow = true
        }
      }
    end
  end
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_showing_pool_id
end

function ui:_refresh_detail(pool_id)
  if self.v_last_view_name ~= nil then
    UIMgr:get_ui(self.v_last_view_name):ui_hide()
    self.v_last_view_name = nil
  end
  self.v_showing_pool_id = pool_id
  local config = ShareRes.get_drawcard_pool(pool_id)
  self.v_last_view_name = config.UI
  self:_check_add_ui_config(config.UI, config.Type)
  UIMgr:get_ui(self.v_last_view_name):ui_show(pool_id)
end

function ui:_set_scroll_value(after_index, len)
  if 1 == after_index then
    self.v_tag_scroll.horizontalNormalizedPosition = 0
  elseif after_index == len then
    self.v_tag_scroll.horizontalNormalizedPosition = 1
  else
    self.v_tag_scroll.horizontalNormalizedPosition = after_index / len
  end
end

return ui
