local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local RUNE_HELPER = require("gamelogic.activity.rune2_helper")
local RUNE_DETAIL_SKILL_ITEM_CLASS = require("uimodule.battle_rune.rune_detail_item")
local RUNE_CAST_BUDDY_ITEM_KEY = "RUNE_CAST_BUDDY_ITEM_KEY"
local RUNE_BAG_HERO_ITEM_CLASS = require("uimodule.battle_bag.rune_hero_item")
local ITEM_ICON_PATH = "Icon/BattleItem/%s"
local commonDef = require("cs_share.common_define")
local RUNE2_CAST_TYPE = commonDef.RUNE2_CAST_TYPE
local bagConfig = require("gamelogic.character.fight_bag_configs")
local BTN_ICON_PATH = "UICommon2/Btn/%s"
local ACTIVE_SET_ICON_NAME = "Common_button_Forward"
local NOT_ACTIVE_SET_ICON_NAME = "Common_button_negative01"
local TEXT_COLOR = {
  NORMAL = Util.get_unity_color_by_hex(tonumber("FFFFFF", 16)),
  CHANGE = Util.get_unity_color_by_hex(tonumber("FFD07B", 16))
}

function ui:ui_finish_load()
  self:set_button("BtnResive", function()
    local _, reborn_cost_num, reborn_cost_id = TowerMgr:get_reborn_cost(true)
    if not reborn_cost_id or 0 == reborn_cost_id then
      Util.show_message_tip(2114)
      return
    end
    local desc = Util.format_str("是否花费{1}钻石立即复活该角色", reborn_cost_num)
    
    local function cb()
      local cur_num = BagMgr:get_item_num(reborn_cost_id)
      if cur_num < reborn_cost_num then
        Util.show_message_tip(2115)
        return
      end
      local uuid = self.v_hero.uuid
      ChapterMgr:request_reborn(uuid, function()
        self:refresh_hero_ui()
        local tog_idx = self.v_hero_item_map[uuid]
        self.v_hero_item_list[tog_idx]:reborn()
      end)
    end
    
    Util.show_conform_tip(desc, nil, nil, nil, cb)
  end)
  self:set_button("BtnRet1", function()
    self:ui_hide()
    ChallengeRingMgr:on_ring_card_end()
  end)
  self:set_button("BtnRollEntry", function()
    self:_click_action_btn(RUNE2_CAST_TYPE.RANDOM_ENTRY)
  end)
  self:set_button("BtnStrengthen", function()
    self:_click_action_btn(RUNE2_CAST_TYPE.UPGRADE)
  end)
  self:register_template()
end

function ui:register_template()
  self:register_exist_auto_template(RUNE_CAST_BUDDY_ITEM_KEY, self.v_uiobjects.CharTem, self.v_uiobjects.CharList)
end

function ui:ui_on_show(cast_id)
  if not cast_id then
    Log.Error("cast id is not exist")
    return
  end
  self.v_cast_id = cast_id
  self.v_hero = Global.hero
  self.v_cast_cfg = ShareRes.get_rune_cast_cfg(self.v_cast_id)
  self:refresh_hero_list()
  self:register_event()
  self:_refresh_currency()
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_SELECT_RUNE_HERO_ITEM, self.response_click_hero_item, self)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_DIAMOND_UPDATE, self._refresh_currency, self)
end

function ui:ui_on_hide()
  self.v_cast_id = nil
  self.v_cast_cfg = nil
  self:clear_hero_item_list()
  self:clear_skill_item_list()
  self.v_hero_is_change = nil
end

function ui:ui_on_destroy()
end

function ui:refresh_rune_info()
  local buddy_cfg = self.v_hero.buddy_cfg
  local hero_uuid = self.v_hero.uuid
  local buddy_id = buddy_cfg.Id
  local buddy_rune_info = Rune2Mgr:get_rune_buddy_info(buddy_id)
  local uobj = self.v_uiobjects
  local ucom = self.v_uicompents
  uobj.NoRune:SetActive(true)
  uobj.RuneInfo:SetActive(false)
  if buddy_rune_info then
    local info_is_change = self.v_hero_is_change[hero_uuid] and self.v_hero_is_change[hero_uuid].lv
    uobj.RuneInfo:SetActive(true)
    uobj.NoRune:SetActive(false)
    local pos = buddy_rune_info.pos
    local rune_name = buddy_cfg.RuneName[pos]
    local rune_lv = buddy_rune_info.level or 0
    local rune_lv_content = Util.format_str("等级：{1}", rune_lv)
    local rune_lv_txt = ucom.RuneLevel_txt
    rune_lv_txt.text = rune_lv_content
    local change_color = info_is_change and TEXT_COLOR.CHANGE or TEXT_COLOR.NORMAL
    rune_lv_txt.color = change_color
    local rune_name_txt = ucom.RuneName_txt
    rune_name_txt.text = rune_name
    local rune_icon_img = ucom.RuneIcon_img
    local icon_name = buddy_cfg.RuneIcon[pos]
    local icon_path = RUNE_HELPER.get_rune_icon(icon_name)
    ResMgr:load_set_icon(rune_icon_img, icon_path)
    self:refresh_rune_skill_list(self.v_hero, pos)
  end
end

function ui:refresh_rune_skill_list(hero, pos)
  local buddy_id = hero.buddy_cfg.Id
  local hero_uuid = hero.uuid
  self:clear_skill_item_list()
  self.v_rune_skill_item = RUNE_DETAIL_SKILL_ITEM_CLASS:ui_wrap_ex(self, self.v_uiobjects.RuneDetail, true)
  local info_is_change = self.v_hero_is_change[hero_uuid] and self.v_hero_is_change[hero_uuid].entry
  local entry_list
  local now_rune_lv = 0
  local rune_type = ShareRes.get_buddy_rune_type(buddy_id, pos)
  local buddy_rune_info = Rune2Mgr:get_rune_buddy_info(buddy_id)
  local buddy_now_pos
  if buddy_rune_info then
    buddy_now_pos = buddy_rune_info.pos
    if buddy_now_pos == pos then
      entry_list = buddy_rune_info.entry_list
    end
    local rune_lv = buddy_rune_info.level
    now_rune_lv = rune_lv
  end
  local skill_param = {
    buddy_id = buddy_id,
    rune_type = rune_type,
    buddy_rune_lv = now_rune_lv,
    entry_list = entry_list,
    is_now_pos = true,
    change_entry_color = {
      is_change = info_is_change,
      change_color = TEXT_COLOR.CHANGE,
      not_change_color = TEXT_COLOR.NORMAL
    }
  }
  self.v_rune_skill_item:set_data(skill_param, RUNE_HELPER.DETAIL_ITEM_SHOW_TYPE.BAG_VIEW)
end

function ui:clear_skill_item_list()
  if self.v_rune_skill_item then
    self.v_rune_skill_item:ui_hide()
    self:remove_wrap_ui(self.v_rune_skill_item)
    self.v_rune_skill_item = nil
  end
end

function ui:clear_hero_item_list()
  if self.v_hero_item_list then
    self:remove_wrap_ui_list(self.v_hero_item_list)
    self.v_hero_item_list = nil
    self.v_hero_item_map = nil
  end
end

function ui:refresh_hero_list()
  local hero_list = SceneMgr:get_hero_list()
  self:give_back_auto_cache(RUNE_CAST_BUDDY_ITEM_KEY)
  self:clear_hero_item_list()
  self.v_hero_item_list = {}
  self.v_hero_item_map = {}
  self.v_hero_is_change = {}
  local idx = 1
  local now_uuid = self.v_hero.uuid
  local select_idx = 1
  for uuid, hero in pairs(hero_list) do
    local hero_item_go = self:get_auto_cache(RUNE_CAST_BUDDY_ITEM_KEY)
    local lua_obj = RUNE_BAG_HERO_ITEM_CLASS:ui_wrap_ex(self, hero_item_go, true)
    if now_uuid == uuid then
      select_idx = idx
    end
    lua_obj:set_data(hero, idx)
    self.v_hero_item_list[idx] = lua_obj
    self.v_hero_item_map[uuid] = idx
    self.v_hero_is_change[uuid] = {lv = false, entry = false}
    idx = idx + 1
  end
  for i = idx, 3 do
    local hero_item_go = self:get_auto_cache(RUNE_CAST_BUDDY_ITEM_KEY)
    local lua_obj = RUNE_BAG_HERO_ITEM_CLASS:ui_wrap_ex(self, hero_item_go, true)
    lua_obj:set_data(nil)
    self.v_hero_item_list[i] = lua_obj
  end
  self.v_hero_item_list[select_idx]:on_select(select_idx)
end

function ui:response_click_hero_item(msg)
  if not msg then
    return
  end
  local select_hero = msg.mm_obj
  self.v_hero = select_hero
  self:refresh_hero_ui()
end

function ui:refresh_hero_ui()
  self:refresh_hero_image(self.v_hero)
  self:refresh_rune_info()
  self:refresh_hero_item()
  self:refresh_action_ui()
end

function ui:refresh_hero_image(hero)
  local hero_id = hero.buddy_cfg.Id
  local char_image = self.v_uicompents.ShowChar_img
  local mask_image = self.v_uicompents.CharMask_img
  local hero_icon = UtilUI.get_hero_images(hero_id, Config.HERO_ICON_LV.HD_FULL_IMG)
  if not hero_icon then
    return
  end
  ResMgr:load_set_icon(char_image, hero_icon, nil, true, self)
  ResMgr:load_set_icon(mask_image, hero_icon, nil, true, self)
  mask_image.gameObject:SetActive(hero and hero:is_anim_die_end())
end

function ui:refresh_action_ui()
  self:refresh_lv_up_ui()
  self:refresh_change_entry_ui()
end

function ui:refresh_lv_up_ui()
  local ucom = self.v_uicompents
  local currency_icon = ucom.LvUpCurrIcon_img
  local lv_up_item_id = self.v_cast_cfg.UpGradeItemID
  local lv_up_cost_num = self.v_cast_cfg.UpGradeItemCount
  local lv_up_num = self.v_cast_cfg.UpGrade
  local cfg = FightBagMgr:get_cfg_by_id(lv_up_item_id)
  ResMgr:load_set_icon(currency_icon, string.format(ITEM_ICON_PATH, cfg.Icon))
  ucom.LvUpCurrNum_txt.text = lv_up_cost_num
  ucom.LVupNum_txt.text = lv_up_num
  local lv_up_btn = ucom.BtnStrengthen_btn
  local btn_img = ucom.BtnStrengthen_img
  self:change_action_btn_state(btn_img, lv_up_btn)
end

function ui:refresh_change_entry_ui()
  local ucom = self.v_uicompents
  local currency_icon = ucom.EntryCurrIcon_img
  local change_entry_item_id = self.v_cast_cfg.RandomEntryItemID
  local change_cost_num = self.v_cast_cfg.RandomEntryItemCount
  local cfg = FightBagMgr:get_cfg_by_id(change_entry_item_id)
  ResMgr:load_set_icon(currency_icon, string.format(ITEM_ICON_PATH, cfg.Icon))
  ucom.EntryCurrNum_txt.text = change_cost_num
  local btn_img = ucom.BtnRollEntry_img
  local change_entry_btn = ucom.BtnRollEntry_btn
  self:change_action_btn_state(btn_img, change_entry_btn)
end

function ui:change_action_btn_state(img, btn)
  local buddy_id = self.v_hero.buddy_cfg.Id
  local buddy_rune_info = Rune2Mgr:get_rune_buddy_info(buddy_id)
  local is_can_cast = buddy_rune_info and true or false
  local icon_name = is_can_cast and ACTIVE_SET_ICON_NAME or NOT_ACTIVE_SET_ICON_NAME
  local btn_img = img
  local icon_path = string.format(BTN_ICON_PATH, icon_name)
  ResMgr:load_set_icon(btn_img, icon_path)
  btn.interactable = is_can_cast
end

function ui:_click_action_btn(cast_type)
  if not self.v_hero then
    Util.show_message_tip(1086)
    return
  end
  local uuid = self.v_hero.uuid
  Rune2Mgr:request_cast_rune(uuid, cast_type, function()
    if cast_type == RUNE2_CAST_TYPE.UPGRADE then
      self.v_hero_is_change[uuid].lv = true
    elseif cast_type == RUNE2_CAST_TYPE.RANDOM_ENTRY then
      self.v_hero_is_change[uuid].entry = true
    end
    self:refresh_hero_ui()
  end)
end

function ui:_refresh_currency()
  local currency_obj = self.v_uiobjects.Asset_Item
  local moneyId = bagConfig.SHOW_CURRENCY[1]
  local cfg = FightBagMgr:get_cfg_by_id(moneyId)
  local moneyIcon = Util.get_image("Label", currency_obj)
  ResMgr:load_set_icon(moneyIcon, string.format(ITEM_ICON_PATH, cfg.Icon))
  local moneyTxt = Util.get_text("Aomunt", currency_obj)
  moneyTxt.text = CharacterMgr:get_res_val(moneyId)
end

function ui:refresh_hero_item()
  for _, lua_obj in pairs(self.v_hero_item_list) do
    lua_obj:refresh_ui()
  end
end

function ui:refresh_reborn_ui()
  if not self.v_hero then
    Log.Error("no hero reborn")
    self.v_uiobjects.BtnResive:SetActive(false)
    return
  end
  local is_die = self.v_hero:is_anim_die_end()
  local is_show_reborn_btn = TowerMgr:is_show_reborn_btn()
  self.v_uiobjects.BtnResive:SetActive(is_die and is_show_reborn_btn)
  local icon_path, reborn_cost_num, _ = TowerMgr:get_reborn_cost(true)
  if not icon_path then
    self.v_uiobjects.BtnResive:SetActive(false)
    return
  end
  local ucom = self.v_uicompents
  local expend_item_img = ucom.ExpendItem_img
  local expend_cost_txt = ucom.ExpendCost_txt
  ResMgr:load_set_icon(expend_item_img, icon_path)
  expend_cost_txt.text = reborn_cost_num
end

return ui
