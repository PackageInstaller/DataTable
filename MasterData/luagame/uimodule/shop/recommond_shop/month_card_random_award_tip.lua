local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local AWARD_ITEM_KEY = "AWARD_ITEM_KEY"

function ui:ui_finish_load()
  self:set_button("BgClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:register_exist_auto_template(AWARD_ITEM_KEY, self.v_uiobjects.ItemObjCom1, self.v_uiobjects.Content)
end

function ui:ui_on_show()
  self:refresh()
end

function ui:ui_on_hide()
end

function ui:refresh()
  local monthly_card_tips_cfg = ShareRes:get_monthly_card_tips_cfg()
  self:give_back_auto_cache(AWARD_ITEM_KEY)
  for _, cfg in ipairs(monthly_card_tips_cfg) do
    local item = self:get_auto_cache(AWARD_ITEM_KEY)
    self:set_data(item, cfg)
  end
end

function ui:set_data(item, cfg)
  local item_quality = Util.get_image("ItemQuality_", item)
  local item_icon = Util.get_image("ItemIcon_", item)
  local capsule_toys_icon = Util.get_image("RandomQuality_", item)
  local item_name_txt = Util.get_text("ItemName_", item)
  local item_amount_txt = Util.get_text("ItemAmount_/Bg/ItemNum_", item)
  local btn = Util.get_button(nil, item)
  local item_id = cfg.ItemId
  local item_count = cfg.ItemCount
  local toy_quality = cfg.Quality
  local toy_cfg = ShareRes.get_capsule_toys_cfg()
  local toy_icon_path = toy_cfg[toy_quality].IconPath
  local item_name = ShareRes.get_item_name(item_id)
  local item_icon_path = ShareRes.get_item_icon_path(item_id)
  local item_quality_path = ShareRes.get_item_quality_path(item_id)
  ResMgr:load_set_icon(item_icon, item_icon_path)
  ResMgr:load_set_icon(item_quality, item_quality_path)
  item_name_txt.text = item_name
  item_amount_txt.text = item_count
  ResMgr:load_set_icon(capsule_toys_icon, toy_icon_path)
  self:set_button_listener(btn, function()
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = item_id,
      jump_cb = function()
        self:ui_hide()
      end
    })
  end)
end

return ui
