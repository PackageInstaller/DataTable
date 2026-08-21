local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local MONTHTASK_AWARD_CHOICE_ITEM_KEY = "MONTHTASK_AWARD_CHOICE_ITEM_KEY"
local QUALITY_IMG = {
  [0] = "UIDraw/Draw_db_ckxq_js_n03",
  [3] = "UIDraw/Draw_db_ckxq_js_n03",
  [4] = "UIDraw/Draw_db_ckxq_js_n02",
  [5] = "UIDraw/Draw_db_ckxq_js_n01"
}
local QUALITY_IMG_MASK = {
  [0] = "UIDraw/Draw_db_ckxq_js_n03zz",
  [3] = "UIDraw/Draw_db_ckxq_js_n03zz",
  [4] = "UIDraw/Draw_db_ckxq_js_n02zz",
  [5] = "UIDraw/Draw_db_ckxq_js_n01zz"
}
local TIPS = "是否选择【%s】做为奖励"

function ui:ui_finish_load()
  self:set_button("BgClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnConfirm", function()
    self:on_click_confirm()
  end)
  self:register_exist_auto_template(MONTHTASK_AWARD_CHOICE_ITEM_KEY, self.v_uiobjects.EquipTem, self.v_uiobjects.AwardContent)
  self.v_select_obj = nil
  self.v_select_award_id = nil
  self.v_select_item_name = nil
end

function ui:ui_on_show(only_show, award_group_id, lv, is_senior)
  self.v_only_show = only_show
  self.v_award_group_id = award_group_id
  self.v_lv = lv
  self.v_is_senior = is_senior
  self.v_uicompents.BtnConfirm_btn.interactable = false
  self.v_uiobjects.BtnConfirm:SetActive(not only_show)
  self.v_uiobjects.TipsChoose:SetActive(not only_show)
  self.v_uiobjects.TipsOnlyShow:SetActive(only_show)
  self.v_select_lv = lv
  self.v_is_senior = is_senior
  local award_list = ShareRes.get_awards(award_group_id)
  self:give_back_auto_cache(MONTHTASK_AWARD_CHOICE_ITEM_KEY)
  
  local function reshow_cb()
    UIMgr:get_ui("ui_monthtask_award_choice"):ui_show(only_show, award_group_id, lv, is_senior)
  end
  
  for index, award_cfg in ipairs(award_list) do
    local item = self:get_auto_cache(MONTHTASK_AWARD_CHOICE_ITEM_KEY)
    local weapon_id = award_cfg.ItemId
    local buddy_id = ShareRes.get_equip_user(weapon_id)
    local name_txt = self:get_text("Name_", item)
    local equip_icon = self:get_image("EquipIcon_", item)
    local quality_bg = self:get_image("Bg1_", item)
    local quality_bg_mask = self:get_image("Bg2_", item)
    local head_icon = Util.get_image("Char/Mask/CharIcon_", item)
    local select_obj = Util.get_child_gameobj("Select_", item)
    local detail_btn = Util.get_button("Detail", item)
    local item_btn = Util.get_button(nil, item)
    name_txt.text = UtilUI.get_item_name(weapon_id)
    local quality = UtilUI.get_item_qulity(weapon_id)
    ResMgr:load_set_icon(quality_bg, QUALITY_IMG[quality] or QUALITY_IMG[0])
    ResMgr:load_set_icon(quality_bg_mask, QUALITY_IMG_MASK[quality] or QUALITY_IMG_MASK[0])
    ResMgr:load_set_icon(head_icon, CharacterMgr:get_buddy_icon_path(buddy_id))
    ResMgr:load_set_icon(equip_icon, UtilUI.get_item_icon(weapon_id))
    select_obj:SetActive(false)
    if not only_show then
      self:set_button_listener(item_btn, function()
        if self.v_select_obj then
          self.v_select_obj:SetActive(false)
        end
        select_obj:SetActive(true)
        self.v_select_obj = select_obj
        self.v_select_award_id = award_cfg.Id
        self.v_select_item_name = UtilUI.get_item_name(award_cfg.ItemId)
        self.v_uicompents.BtnConfirm_btn.interactable = true
      end)
    end
    self:set_button_listener(detail_btn, function()
      local weapon_ui = UIMgr:get_ui("char_weapon", true)
      weapon_ui:ui_show(nil, nil, nil, weapon_id)
      weapon_ui:set_return_cb(reshow_cb)
      PassPortMgr:clear_select_award_list()
      self:ui_hide()
    end)
  end
  UIMgr:set_cache_ui_custom_data("ORDER_SELECT", 2)
end

function ui:ui_on_hide()
  UIMgr:set_cache_ui_custom_data("ORDER_SELECT", nil)
  NextFrameMgr:add_next_update(function()
    PassPortMgr:show_select_award_ui()
  end)
end

function ui:ui_on_destroy()
end

function ui:on_click_confirm()
  UIMgr:get_ui("uinotice_tips"):ui_show(function()
    PassPortMgr:request_get_battle_pass_select_award(self.v_select_lv, self.v_select_award_id, self.v_is_senior, function()
      self:ui_hide()
      local ui_monthtask = UIMgr:get_ui("ui_monthtask")
      if ui_monthtask then
        ui_monthtask:update_user_data()
      end
    end)
  end, nil, string.format(TIPS, self.v_select_item_name), nil, nil, nil, nil, nil, nil, nil, nil, true)
end

return ui
