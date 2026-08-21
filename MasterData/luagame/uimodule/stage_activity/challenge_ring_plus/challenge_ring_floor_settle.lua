local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local AssetBarView = require("ui.asset_bar.asset_bar")
local CardTemItem = require("uimodule.card_pack.card_item")
local CURSE_RING_CONTRIBUTION_POINT = 28
local Item_Helper = require("utils.item_helper")
local CARD_IMG_NAME = Config.CARD_IMG_NAME
local FILE_PATH = "UIEvent03/Settle/"
local ITEM_ICON_PATH = "Icon/Item/"
local CARD_ITEM_KEY = "CHALLENGE_RING_CARD_ITEM_KEY"
local CARD_AWARD_KEY = "CHALLENGE_RING_CARD_AWARD_KEY"
local TreasureChestCfg = require("uimodule.treasure_chest.treasure_chest_configs")
local bagConfig = require("gamelogic.character.fight_bag_configs")
local commonDef = require("cs_share.common_define")
local AnimaCard = require("uimodule.card_pack.anima_card")
local type_playable_director = typeof(UnityEngine.Playables.PlayableDirector)
local MODEL = {}

function ui:get_click_end_area()
  local award_box_rect = Util.get_rect_transform(nil, self.v_uiobjects.CardBox)
  self.v_card_box_area = Util.get_screen_area(award_box_rect)
end

function ui:add_linster()
  self.v_listener = self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self._on_item_update, self)
end

function ui:_on_item_update(msg)
  if msg and msg.mm_x == TreasureChestCfg.TREASURE_CHEST_TYPE then
    self:refresh()
  end
end

function ui:ui_finish_load()
  self.v_anima_card_list = {}
  self.v_on_show_card_list = {}
  self.v_drag_card_go_list = {}
  for index = 1, 5 do
    local obj = self.v_uiobjects["AnimaCard" .. index]
    local anima_card = AnimaCard:ui_wrap(self, obj)
    anima_card.v_index = index
    self.v_anima_card_list[index] = anima_card
  end
  self.v_drag_start_pd = self.v_uiobjects.DragStart:GetComponent(type_playable_director)
  self.v_loop_pd = self.v_uiobjects.Loop:GetComponent(type_playable_director)
  self:init_model(MODEL)
  self:_init_view()
end

function ui:ui_before_show(is_fight, is_end_ring, choose_reward_list, tower_progress, fight_info)
  self:add_linster()
  self.v_is_fight = is_fight
  self.v_tower_progress = tower_progress
  self.v_fight_info = fight_info
  self.v_episode_id = tower_progress.episode_id
  self.is_end_ring = is_end_ring
  self.v_tower_info = tower_progress
  self.v_fight_info = fight_info
  self.v_asset_bar:reset_by_id_list({
    Config.PLAYER_SP_ITEMID
  })
  self.v_asset_bar:on_create()
  self:refresh_choose_list(choose_reward_list)
end

function ui:ui_on_show()
  self.v_is_in_anima = false
  self:set_no_click(false)
end

function ui:ui_on_hide()
  for key, show_card in pairs(self.v_on_show_card_list) do
    self.v_anima_card_list[key] = show_card
  end
  for key, anima_card in pairs(self.v_anima_card_list) do
    anima_card:ui_hide()
  end
  for key, rag_card_go in pairs(self.v_drag_card_go_list) do
    if not rag_card_go:IsNull() then
      UnityDestroy(rag_card_go)
    end
  end
  self.v_drag_card_go_list = {}
  self.total_page = 1
  self.v_asset_bar:on_hide()
  self:remove_card_item_list()
  TreasureChestMgr:recore_award_tf(nil)
  TreasureChestMgr:reset_crad_drag_state()
end

function ui:ui_on_destroy()
  self.v_is_clear = false
  self.v_asset_bar:on_destory()
end

function ui:_init_view()
  self:recore_award_tf()
  self.v_cur_page = 1
  self.v_card_item_list = {}
  self.v_no_award_box = Util.get_child("NoAward", self.v_uiobjects.AwardBox)
  self.v_have_award_box = Util.get_child("HaveAward", self.v_uiobjects.AwardBox)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
  self:register_exist_auto_template(CARD_ITEM_KEY, self.v_uiobjects.CardPileTem, self.v_uiobjects.CardPile)
  self:_init_button()
  self:get_click_end_area()
end

function ui:_init_button()
  self:set_button("BtnNext", function()
    self:_page_turning(true)
  end)
  self:set_button("BtnLast", function()
    self:_page_turning(false)
  end)
  self:set_button("BtnConfirm", function()
    self:_confirm()
  end)
  self:set_button("AwardBox", function()
    self:show_award(true)
  end)
  self:set_button("CardBoxBtn", function()
    self:_click_card_pack_button(true)
  end)
end

function ui:refresh()
  TreasureChestMgr:sort_award_list()
  self:_refresh_data()
  self:refresh_page_count()
  self:_refresh_page_turning_btn()
  self:_set_bottom()
  self:_refresh_card_pack_tips()
end

function ui:refresh_choose_list(choose_reward_list)
  TreasureChestMgr:build_choose_award_list(choose_reward_list, self.v_tower_progress)
  self:refresh()
end

function ui:_refresh_card_pack_tips()
  local card_pack_tips = UIMgr:try_get_visible_ui("card_pack_tips")
  if card_pack_tips then
    self:_click_card_pack_button()
  end
end

function ui:_refresh_data()
  local new_award_list = TreasureChestMgr:get_choose_award_list()
  self:give_back_auto_cache(CARD_ITEM_KEY)
  self:remove_card_item_list()
  local empty_count = 0
  if new_award_list and next(new_award_list) ~= nil and TreasureChestMgr:get_card_total_count() > 0 then
    self.v_cur_page_is_empty = false
    self.v_uiobjects.PackEmpty:SetActive(false)
    for i = 1, 3 do
      local index = (self.v_cur_page - 1) * 3 + i
      local obj = self:get_auto_cache(CARD_ITEM_KEY)
      self.v_card_item_list[index] = CardTemItem:ui_wrap(self, obj)
      local empty = self.v_card_item_list[index]:set_data(new_award_list[index], index)
      if empty then
        empty_count = empty_count + 1
      end
    end
    if 3 == empty_count then
      self:_page_turning(false)
    end
  else
    self:set_pack_empty()
  end
end

function ui:set_pack_empty()
  self.v_uiobjects.PackEmpty:SetActive(true)
  for key, rag_card_go in pairs(self.v_drag_card_go_list) do
    if not rag_card_go:IsNull() then
      UnityDestroy(rag_card_go)
    end
  end
  self.v_drag_card_go_list = {}
end

function ui:_page_turning(is_next)
  local new_award_list = TreasureChestMgr:get_choose_award_list()
  if not new_award_list or #new_award_list < 1 then
    return
  end
  local cur_page = self.v_cur_page
  local total_page = self.total_page
  cur_page = is_next and cur_page + 1 or cur_page - 1
  if cur_page < 1 then
    Util.show_message_tip(2138)
  elseif total_page < cur_page then
    Util.show_message_tip(2139)
  else
    self.v_cur_page = cur_page
    self:_refresh_data()
    self:_refresh_page_turning_btn()
  end
end

local function _get_draw_award_list(award_list, history_choose_reward)
  for index, data in pairs(award_list) do
    data.history_action = {
      {
        status = 3,
        count = data.count
      }
    }
    table.insert(history_choose_reward, data)
  end
end

local function _exit_func(self)
  local function cb()
    local history_choose_award = TreasureChestMgr:get_history_choose_award()
    
    if not history_choose_award or next(history_choose_award) == nil then
      history_choose_award = history_choose_award or {}
      self.flag_reward_list = TowerMgr:get_flag_reward_list() or {}
    end
    if self.v_is_clear and self.flag_reward_list then
      _get_draw_award_list(self.flag_reward_list, history_choose_award)
    end
    TowerMgr:destroy_flag_reward_list()
    if self.v_tower_info.challenge_type == commonDef.CHALLENGE_TYPE.CUT_GRASS then
      UIMgr:get_ui("gecao_settle"):ui_show(self.v_tower_progress, self.v_fight_info, history_choose_award, self.v_is_fight)
    else
      UIMgr:get_ui("fate_book_settle"):ui_show(self.v_is_fight, self.is_end_ring, self.v_tower_info, self.v_fight_info, history_choose_award, self.v_episode_id)
    end
  end
  
  if TowerMgr then
    TowerMgr:get_fight_reward(nil, false, cb)
  end
end

function ui:_confirm()
  local history_choose_award = TreasureChestMgr:get_history_choose_award()
  local new_award_list = TreasureChestMgr:get_choose_award_list()
  if new_award_list and next(new_award_list) ~= nil and TreasureChestMgr:get_card_total_count() > 0 and not self.v_is_clear then
    local tip = Util.format_str("尚未开启或存储的卡牌将自动销毁，是否确认")
    local cancel_btn = Util.format_str("取消")
    local sure_btn = Util.format_str("确认")
    
    local function srue_cb()
      _get_draw_award_list(new_award_list, history_choose_award)
      _exit_func(self)
    end
    
    UIMgr:get_ui("uinotice_tips"):ui_show(srue_cb, nil, tip, sure_btn, cancel_btn)
  else
    if self.v_is_clear then
      _get_draw_award_list(new_award_list, history_choose_award)
    end
    _exit_func(self)
  end
end

function ui:_refresh_pack_num()
  self.v_uicompents.CardNumMax_txt.text = ShareRes.create("item.award_type", TreasureChestCfg.TREASURE_CHEST_TYPE).MaxGrid
  self.v_uicompents.CardNumNow_txt.text = TreasureChestMgr:get_treasure_chest_count()
end

function ui:_refresh_page_turning_btn()
  local cur_page = self.v_cur_page
  local total_page = self.total_page
  self.v_uiobjects.BtnNext:SetActive(total_page >= cur_page + 1)
  self.v_uiobjects.BtnLast:SetActive(cur_page - 1 > 0)
end

function ui:insert_reward_list(data)
  TreasureChestMgr:record_flip_card_award(data)
  self:_set_bottom()
end

function ui:_set_bottom()
  self:_refresh_pack_num()
  local is_have = next(TreasureChestMgr:get_flip_card_award_dict()) ~= nil
  self.v_no_award_box:SetActive(not is_have)
  self.v_have_award_box:SetActive(is_have)
end

function ui:remove_card_item_list()
  for _, obj in pairs(self.v_card_item_list) do
    obj:ui_hide()
    self:remove_wrap_ui(obj)
  end
  self.v_card_item_list = {}
end

local function _after_fun(self, id)
  if not UIMgr:try_get_visible_ui("card_pack_tips") then
    TreasureChestMgr:on_oper_card(id)
  end
end

function ui:on_flip_card_start()
  TreasureChestMgr:add_card_total_count(-1)
end

function ui:on_save_card_start(id)
  TreasureChestMgr:add_card_total_count(-1)
end

function ui:on_flip_card_end(id)
  self:refresh()
end

function ui:on_save_card_end(id)
  self:refresh()
end

function ui:on_discarde_card_end()
  self:refresh()
end

function ui:_click_card_pack_button()
  self:open_card_box_tips_view()
end

function ui:open_card_box_tips_view()
  TreasureChestMgr:recore_award_tf(nil)
  local cur_card_count = TreasureChestMgr:get_treasure_chest_count()
  local card_pack_tips = UIMgr:try_get_visible_ui("card_pack_tips")
  local list = TreasureChestMgr:get_treasure_chest_list_ex()
  local all_card_count = ShareRes.create("item.award_type", TreasureChestCfg.TREASURE_CHEST_TYPE).MaxGrid
  if card_pack_tips and card_pack_tips.v_visible then
    card_pack_tips:refresh(list, cur_card_count, all_card_count)
  else
    UIMgr:get_ui("card_pack_tips"):ui_show(list, cur_card_count, all_card_count)
    self.v_uiobjects.CardBox:SetActive(false)
  end
end

function ui:show_award()
  local award_dict = TreasureChestMgr:get_flip_card_award_dict()
  if award_dict and next(award_dict) ~= nil then
    local list = {}
    for key, data in pairs(award_dict) do
      table.insert(list, data)
    end
    UIMgr:get_ui("award_show_panel"):ui_show(list, true, true, true)
  else
    UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("暂未获取任意奖励"))
    return
  end
end

function ui:get_history_choose_reward()
  return TreasureChestMgr:get_history_choose_award()
end

function ui:on_card_up()
  self.v_uiobjects.AwardBoxGlow:SetActive(true)
  self.v_drag_start_pd:Play()
  self.v_loop_pd:Play()
end

function ui:on_card_down()
  self.v_loop_pd:Stop()
  self.v_drag_start_pd:Stop()
  self.v_uiobjects.CardBoxBtn.transform:SetLocalScaleA(1, 1, 1)
  self.v_uiobjects.AwardBoxGlow:SetActive(false)
end

function ui:refresh_page_count()
  local count = 0
  local new_award_list = TreasureChestMgr:get_choose_award_list()
  for key, award in pairs(new_award_list) do
    if award.count > 0 then
      count = count + 1
    end
  end
  self.total_page = count / 3
  local temp = math.floor(self.total_page)
  if self.total_page - temp > 0 then
    self.total_page = temp + 1
  end
end

function ui:set_no_click(is_no_click)
  self.v_uiobjects.NoClick:SetActive(is_no_click)
end

function ui:set_anima_state(is_in_anima)
  self.v_is_in_anima = is_in_anima
end

function ui:recore_award_tf()
  TreasureChestMgr:recore_award_tf(self.v_uiobjects.AwardBox.transform)
end

function ui:get_award_tf()
  return self.v_uiobjects.AwardBox.transform
end

function ui:get_anima_card()
  local index, anima_card = next(self.v_anima_card_list)
  if not anima_card then
    anima_card = self.v_on_show_card_list[1]
    anima_card:stop_anima()
  end
  return anima_card
end

function ui:set_anima_card(is_delete, card_pos, img_name, quality, drag_card_z, play_anima_cb, anima_end_cb)
  local temp_pos = card_pos
  temp_pos.z = drag_card_z
  local click_pos = UIMgr.root_camera:ScreenToWorldPoint(temp_pos)
  local anima_card = self:get_anima_card()
  anima_card:set_data(img_name, quality, click_pos)
  anima_card:set_activate(true)
  local index = anima_card.v_index
  self.v_on_show_card_list[index] = anima_card
  self.v_anima_card_list[index] = nil
  
  local function cb()
    anima_card:set_activate(false)
    self.v_on_show_card_list[anima_card.v_index] = nil
    self.v_anima_card_list[anima_card.v_index] = anima_card
    if play_anima_cb then
      play_anima_cb()
    end
    if anima_end_cb then
      anima_end_cb()
    end
  end
  
  if is_delete then
    anima_card:play_delete_anima(cb)
  else
    anima_card:play_pull_anima(cb)
  end
end

function ui:on_drag_card_start(drag_card_go)
  if drag_card_go:IsNull() then
    return
  end
  drag_card_go.transform:SetParent(self:get_object_transform())
  drag_card_go:SetActive(true)
  table.insert(self.v_drag_card_go_list, drag_card_go)
end

function ui:on_drag_card_end(drag_card_go, card_item)
  if drag_card_go:IsNull() then
    return
  end
  drag_card_go:SetActive(false)
  drag_card_go.transform:SetParent(card_item:get_object_transform())
  drag_card_go.transform.position = card_item.v_click_btn_pos
  for key, card_go in pairs(self.v_drag_card_go_list) do
    if not card_go:IsNull() and card_go.gameObject:Equals(drag_card_go) then
      table.remove(self.v_drag_card_go_list, key)
      break
    end
  end
end

return ui
