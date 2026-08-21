local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local FATE_BOOK_INITIAL_OPTION_ITEM = require("uimodule.stage_activity.fate_book.fate_book_initial_option_item")
local INITIAL_OPTION_ITEM_KEY = "INITIAL_OPTION_ITEM_KEY"
local AssetBarView = require("ui.asset_bar.asset_bar")
local ASSET_BAR_CONFIG = {
  {
    item_id = Config.CURSE_GOLD,
    const_event = Const.MSG_ON_FIGHT_DIAMOND_UPDATE,
    is_fight_bag = true,
    not_show_max = true,
    bg_click = false
  }
}

function ui:on_click_option_btn(option_id)
  if self.v_select_option_id == option_id then
    return
  end
  self.v_select_option_id = option_id
  for _, item in pairs(self.v_option_item_map) do
    item:set_select(self.v_select_option_id)
  end
end

function ui:on_click_confirm_btn()
  local function cb()
    self:ui_hide()
  end
  
  FateBookMgr:request_set_options_id(self.v_select_option_id, cb)
end

function ui:on_click_pause_btn()
  UIMgr:get_ui("battle_bag4"):ui_show()
end

function ui:ui_finish_load()
  self:set_button("BtnConfirm", function()
    self:on_click_confirm_btn()
  end)
  self:set_button("Button_rune", function()
    self:on_click_pause_btn()
  end)
  self.v_option_item_map = {}
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, ASSET_BAR_CONFIG)
  self:register_exist_auto_template(INITIAL_OPTION_ITEM_KEY, self.v_uiobjects.AwardTem, self.v_uiobjects.Content)
end

function ui:ui_on_show()
  self.v_asset_bar:on_create()
  self:refresh_option()
end

function ui:ui_on_hide()
  self.v_asset_bar:on_hide()
  self:clear_option_item()
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:refresh_option()
  self:clear_option_item()
  local group_id = FateBookMgr:get_curse_options_group_id()
  if not Util.is_more_than_zero(group_id) then
    return
  end
  local obj
  local option_ids = ShareRes.get_curse_option_cfgs_by_group_id(group_id)
  local fight_option
  for option_id in pairs(option_ids) do
    obj = self:get_auto_cache(INITIAL_OPTION_ITEM_KEY)
    self.v_option_item_map[option_id] = FATE_BOOK_INITIAL_OPTION_ITEM:ui_wrap_ex(self, obj, true)
    self.v_option_item_map[option_id]:set_data(option_id)
    fight_option = fight_option or self.v_option_item_map[option_id]
  end
  if fight_option then
    fight_option:on_click_btn()
  end
end

function ui:clear_option_item()
  self:give_back_auto_cache(INITIAL_OPTION_ITEM_KEY)
  for k, item in pairs(self.v_option_item_map) do
    item:ui_hide()
    item:ui_destroy()
    self.v_option_item_map[k] = nil
  end
end

function ui:cache_ui()
  return true
end

return ui
