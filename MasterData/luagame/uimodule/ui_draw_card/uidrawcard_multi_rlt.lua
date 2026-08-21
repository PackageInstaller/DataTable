local RltItem = require("uimodule.ui_draw_card.drawcard_multi_rlt_item")
local Base = require("ui.uibase")
local _tsort = table.sort
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_item_list = {
    "ItemList",
    BIND_TYPE.OBJECT
  },
  v_item_tpl = {
    "ItemTpl",
    BIND_TYPE.OBJECT
  },
  v_btn_close = {
    "Btn_Close",
    BIND_TYPE.BUTTON
  }
}
local DRAWCARD_RLT_TEMPLATE_KEY = "DRAWCARD_RLT_TEMPLATE_KEY"

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("Btn_Close", function()
    if not self.v_is_lock then
      self:ui_hide()
      DrawCardMgr:try_show_extra_item_list(self.v_data_list)
    end
  end)
  self:register_exist_auto_template(DRAWCARD_RLT_TEMPLATE_KEY, self.v_item_tpl, self.v_item_list)
  self.v_ui_in_pd_trans = Util.get_rect_transform("SafeArea/Animation/Ani_VX_BG_IN", self.v_object)
end

local TYPE_SORT_DIC = {
  [Config.AWARD_TYPE.CHARA] = 10,
  [Config.AWARD_TYPE.EQUIP] = 5,
  [Config.AWARD_TYPE.ITEM] = 0
}

local function _type_value_of_item(item_id)
  local config = Util.get_item_type_cfg(item_id)
  if not config then
    return 0
  end
  return TYPE_SORT_DIC[config.AwardType] or 0
end

local function _item_sorter(a, b)
  local quality_a = UtilUI.get_item_qulity(a.item_id)
  local quality_b = UtilUI.get_item_qulity(b.item_id)
  if quality_a ~= quality_b then
    return quality_a > quality_b
  end
  local type_value_a = _type_value_of_item(a.item_id)
  local type_value_b = _type_value_of_item(b.item_id)
  if type_value_a ~= type_value_b then
    return type_value_a > type_value_b
  end
  return a.get_index < b.get_index
end

function ui:_on_anim_finish()
  self.v_is_lock = false
end

function ui:ui_after_show()
  UIMgr:try_hide_ui("uidrawcard_movie_panel")
  UIMgr:try_hide_ui("uidrawcard_movie")
  UIMgr:try_hide_ui("uidrawcard_movie2")
end

function ui:ui_on_show(data_list)
  self.v_data_list = data_list
  self.v_is_lock = true
  self:give_back_auto_cache(DRAWCARD_RLT_TEMPLATE_KEY)
  _tsort(data_list, _item_sorter)
  local max_quality = 0
  local obj, item, cb
  local len = #data_list
  for i, oneData in ipairs(data_list) do
    obj = self:get_auto_cache(DRAWCARD_RLT_TEMPLATE_KEY)
    item = RltItem:ui_wrap(nil, obj)
    cb = i == len and self._on_anim_finish or nil
    item:set_data(oneData, i, cb, self)
    local item_id = oneData.item_id
    local quality = UtilUI.get_item_qulity(item_id)
    if max_quality < quality then
      max_quality = quality
    end
  end
  local scale = 1 - UIMgr:get_safe_area_offset()
  local factor = Global.screen_width / (Global.screen_height / 1080) / 1920
  if factor > 1 then
    self.v_item_list.transform:SetLocalScaleA(factor * scale, factor * scale, 1)
  else
    self.v_item_list.transform:SetLocalScaleA(1 * scale, 1 * scale, 1)
  end
  
  local function stopped_func()
    MsgGame:mq_publish2(Const.MSG_RELEASE_COMMON_BATTLE_TIPS_HOLD_TASK)
  end
  
  self.v_ui_in_pd_trans:SetTimelineSeqEndCB(stopped_func)
  self.v_uiobjects.Gold:SetActive(max_quality > 4)
  self.v_uiobjects.Other:SetActive(max_quality <= 4)
end

return ui
