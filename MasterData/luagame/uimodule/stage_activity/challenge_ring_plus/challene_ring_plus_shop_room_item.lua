local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local CommonDefine = require("cs_share.common_define")
local CURSE_CARD_TYPE = CommonDefine.CURSE_CARD_TYPE
local RUNE2_SOURCE = CommonDefine.RUNE2_SOURCE
local bagConfig = require("gamelogic.character.fight_bag_configs")
local Item_Helper = require("utils.item_helper")
local ITEM_TYPE_PATH = "Icon/BattleItem/%s"
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_item_quality = {
    "ItemQuality",
    BIND_TYPE.IMAGE
  },
  v_item_icon = {
    "ItemIcon",
    BIND_TYPE.IMAGE
  },
  v_item_amount = {
    "ItemAmount",
    BIND_TYPE.OBJECT
  },
  v_item_num = {
    "ItemNum",
    BIND_TYPE.TEXT
  },
  v_item_name = {
    "ItemName",
    BIND_TYPE.TEXT
  },
  v_item_desc = {
    "ItemDesc",
    BIND_TYPE.TEXT
  },
  v_gold_icon = {
    "GoldIcon",
    BIND_TYPE.IMAGE
  },
  v_gold_num = {
    "GoldNum",
    BIND_TYPE.TEXT
  },
  v_curse_icon = {
    "CurseIcon",
    BIND_TYPE.IMAGE
  },
  v_curse_num = {
    "CurseNum",
    BIND_TYPE.TEXT
  },
  v_have_item = {
    "HaveItem",
    BIND_TYPE.OBJECT
  },
  v_none_item = {
    "NoneItem",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button_listener(Util.get_button(nil, self.v_object), function()
    self:on_click_item()
  end)
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
  self.v_npc_data = nil
end

function ui:ui_on_destroy()
end

function ui:set_data(good_data, type, index, npc_data)
  self.v_good_data = good_data
  self.v_type = type
  self.v_index = index
  self.v_npc_data = npc_data
  self.v_item_sold_out = self.v_good_data and self.v_good_data.buy or false
  self:set_info_by_type()
end

function ui:set_info_by_type()
  local item_cfg = Item_Helper.get_item_cfg(self.v_good_data.id)
  ResMgr:load_set_icon(self.v_item_quality, bagConfig.Quality_Img[item_cfg.Quality])
  ResMgr:load_set_icon(self.v_item_icon, item_cfg.Icon)
  self.v_item_name.text = item_cfg.Name
  self.v_item_desc.text = item_cfg.Desc
  if self.v_type == CURSE_CARD_TYPE.SHOP_RUNE then
    self.v_uiobjects.OrnObj:SetActive(false)
    if self.v_npc_data then
      local sold_out = Util.get_child("SoldOut_", self.v_uiobjects.ItemObj)
      sold_out:SetActive(self.v_item_sold_out)
    end
    self.v_uiobjects.ItemObj:SetActive(true)
    self.v_item_amount:SetActive(false)
    local rune_cfg = ShareRes.get_battle_item_cfg(self.v_good_data.id)
    self.v_gold_num.text = ChallengeRingPlusMgr:get_after_discount_price(rune_cfg.BuyCostCnt)
    local currency_cfg = Item_Helper.get_item_cfg(rune_cfg.BuyCostId)
    ResMgr:load_set_icon(self.v_gold_icon, string.format(ITEM_TYPE_PATH, currency_cfg.Icon))
    self.v_curse_num.text = ChallengeRingPlusMgr:get_after_discount_curse_price(rune_cfg.CurseCostCnt)
  elseif self.v_type == CURSE_CARD_TYPE.SHOP_ORNAMENTS then
    local orn_obj = self.v_uiobjects.OrnObj
    self.v_uiobjects.ItemObj:SetActive(false)
    self.v_item_amount:SetActive(false)
    self.v_gold_num.text = ChallengeRingPlusMgr:get_after_discount_price(item_cfg.BuyCostCnt)
    self.v_curse_num.text = ChallengeRingPlusMgr:get_after_discount_curse_price(item_cfg.CurseCostCnt)
    local bg2 = Util.get_image("Bg2_", orn_obj)
    local orn_icon = Util.get_image("OrnIcon_", orn_obj)
    if self.v_npc_data then
      local sold_out = Util.get_child("SoldOut_", orn_obj)
      sold_out:SetActive(self.v_item_sold_out)
    end
    local ornament_cfg = ShareRes.create("item.ornaments", self.v_good_data.id)
    if not ornament_cfg and self.v_good_data.id then
      Log.Error("饰品表中没有ID为：", self.v_good_data.id, "的配置信息")
    end
    ResMgr:load_set_icon(bg2, BattleOrnamentMgr:get_ornament_bg_icon(ornament_cfg.Quality))
    ResMgr:load_set_icon(orn_icon, ornament_cfg.Icon)
    orn_obj:SetActive(true)
  end
  self.v_uiobjects.PriceCurse:SetActive(self.v_npc_data == nil)
end

function ui:on_click_item()
  if self.v_npc_data and self.v_item_sold_out then
    Util.show_message_tip(1103)
    return
  end
  if self.v_type == CURSE_CARD_TYPE.SHOP_RUNE then
    local rune_item_data = {
      item_id = self.v_good_data.id,
      uuid = self.v_index,
      ran_ans_uuid = self.v_good_data.ran_ans_uuid,
      count = self.v_good_data.count,
      index = self.v_good_data.index
    }
    UIMgr:get_ui("ui_rune_set"):ui_show(rune_item_data, RUNE2_SOURCE.CURSE_SHOP_RUNE, self.v_npc_data)
  elseif self.v_type == CURSE_CARD_TYPE.SHOP_ORNAMENTS then
    local function confirm_cb()
      self.v_parent_ui:click_btn_ornament_pay(true, self.v_good_data.id, self.v_index)
    end
    
    UIMgr:get_ui("uinotice_tips"):ui_show(confirm_cb, nil, "是否购买该商品")
  end
end

return ui
