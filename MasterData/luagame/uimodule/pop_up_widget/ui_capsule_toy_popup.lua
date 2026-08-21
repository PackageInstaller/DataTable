local Base = require("uimodule.pop_up_widget.ui_popup_base")
local ShopCfg = require("uimodule.shop.shop_config")
local SpineHelper = require("ui.model_rt_view.spine_helper")
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local util_table = require("utils.util_table")
local ui = Util.create_child_mt(Base)
local AWARD_ITEM_KEY = "CAPSULE_TOY_AWARD_ITEM_KEY"

function ui:ui_finish_load()
  self:set_button("BgBtn", function()
    if not self.v_hav_click_bgbtn then
      self.v_hav_click_bgbtn = true
      Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.monthly_pass_UI_SOUND)
    end
    if self.v_play_award_anim and not self.v_trigger_show_award then
      self.v_trigger_show_award = true
      self:show_award()
      return
    end
    if self.v_trigger_show_award then
      if self.v_widget_cfg then
        Base:manual_close()
      else
        self:ui_hide()
      end
    end
    SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
    self.v_play_award_anim = true
  end)
  self:register_exist_auto_template(AWARD_ITEM_KEY, self.v_uiobjects.AwardTem, self.v_uiobjects.Content)
end

function ui:ui_on_show(widget_id, widget_arg, param)
  self.v_widget_id = widget_id
  self.v_widget_cfg = ShareRes.get_pop_widget_cfg(widget_id)
  self.v_fixed_award = param.fixed_award
  self.v_drop_award = param.drop_award
  self.v_hav_click_bgbtn = false
  self.v_play_award_anim = false
  self.v_trigger_show_award = false
  self.v_uiobjects.ReciveObj:SetActive(true)
  self.v_uiobjects.AwardShowObj:SetActive(false)
  self.v_anim_data = SpineHelper.get_init_anim_info()
  self.v_card_cfg = ShareRes.create("recharge.monthly_card", ShopCfg.DF_CARD_TYPE)
  local remain_days = RechargeMgr:get_month_card_remain_days(self.v_card_cfg.Type)
  self.v_uicompents.RemainDay1_txt.text = string.format("剩余%s天", remain_days)
  self.v_uicompents.RemainDay2_txt.text = string.format("剩余%s天", remain_days)
  self:clear_spine_rt()
  if self.v_drop_award and self.v_drop_award[1] then
    local capsule_toy_quality = ShareRes.get_capsule_toys_quality_cfg(self.v_drop_award[1].id)
    local toy_cfg = ShareRes.get_capsule_toys_cfg()
    self.v_spine_id = toy_cfg[capsule_toy_quality].SpineId
  end
  self.v_spine_id = self.v_spine_id or 50020
  if self.v_spine_id then
    self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.Spine)
    SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_uiobjects.Spine)
  end
end

function ui:ui_on_update()
  SpineHelper.check_play_anim(self.v_spine_rt, self.v_anim_data)
  if self.v_play_award_anim == true and true == self.v_anim_data.record_data.play_end and not self.v_trigger_show_award then
    self.v_trigger_show_award = true
    self:show_award()
  end
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh()
end

function ui:show_award()
  self.v_uiobjects.ReciveObj:SetActive(false)
  self.v_uiobjects.AwardShowObj:SetActive(true)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.monthly_pass_award_UI_SOUND)
  self:give_back_auto_cache(AWARD_ITEM_KEY)
  if not util_table.is_empty(self.v_fixed_award) then
    local fixed_item_id = self.v_fixed_award[1].id
    local fixed_item_count = self.v_fixed_award[1].count
    local item = self:get_auto_cache(AWARD_ITEM_KEY)
    self:set_data(item, fixed_item_id, fixed_item_count)
  end
  if not util_table.is_empty(self.v_drop_award) then
    local drop_item_id = self.v_drop_award[1].id
    local drop_item_count = self.v_drop_award[1].count
    local item = self:get_auto_cache(AWARD_ITEM_KEY)
    self:set_data(item, drop_item_id, drop_item_count)
  end
end

function ui:set_data(item, item_id, count)
  local item_icon_path = ShareRes.get_item_icon_path(item_id)
  local item_quality_path = ShareRes.get_item_quality_path(item_id)
  local item_name_txt = Util.get_text("ItemName_", item)
  local item_count_txt = Util.get_text("ItemObjCom1_/ItemAmount_/Bg/ItemNum_", item)
  local item_icon = Util.get_image("ItemObjCom1_/ItemIcon_", item)
  local item_quality = Util.get_image("ItemObjCom1_/ItemQuality_", item)
  local btn = Util.get_button("ItemObjCom1_", item)
  ResMgr:load_set_icon(item_icon, item_icon_path)
  ResMgr:load_set_icon(item_quality, item_quality_path)
  item_count_txt.text = count
  item_name_txt.text = ShareRes.get_item_name(item_id)
  self:set_button_listener(btn, function()
    UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
  end)
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

return ui
