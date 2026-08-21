local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CURSE_RING_CONTRIBUTION_POINT = 28
local CURSE_RING_CURRENCY = 541000
local CURSE_SETTLEMENT_ITEM_KEY = "CURSE_SETTLEMENT_ITEM_KEY"
local CURSE_BLESS_ITEM_KEY = "CURSE_BLESS_ITEM_KEY"
local Item_Helper = require("utils.item_helper")

function ui:ui_finish_load()
  self:set_button("BtnDirectQuit", function()
    self:exit()
  end)
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button("BtnSaveQuit", function()
    self:save_and_exit()
  end)
  self.v_content_local_pos = self.v_uiobjects.RewardContent.transform.localPosition
  self:register_exist_auto_template(CURSE_SETTLEMENT_ITEM_KEY, self.v_uiobjects.RewardTem, self.v_uiobjects.RewardContent)
  self:register_exist_auto_template(CURSE_BLESS_ITEM_KEY, self.v_uiobjects.BlessingTem, self.v_uiobjects.BlessingContent)
  self.v_show_item_list = {}
  self.v_show_bless_list = {}
end

function ui:ui_on_show(is_fight)
  self.v_uiobjects.NoClickBg:SetActive(false)
  self.v_uiobjects.fight:SetActive(is_fight)
  self.v_tower_info = TowerMgr:get_tower_progress()
  local fight_info = TowerMgr:get_fight_info()
  if not fight_info and self.v_tower_info then
    fight_info = {
      type = self.v_tower_info.challenge_type,
      point_id = self.v_tower_info.episode_id,
      param = self.v_tower_info.param
    }
  end
  self.v_uiobjects.RewardContent.transform.localPosition = self.v_content_local_pos
  self.v_fight_info = fight_info
  self:update_pnl_info()
end

function ui:update_pnl_info()
  local ring_cfg = ShareRes.create("activity.rings_of_curse_ring_by_tower", self.v_tower_info.tower_id)
  self.v_uicompents.RingFinish_txt.text = self.v_tower_info.floor_id - 1
  self.v_uicompents.RingMax_txt.text = #ring_cfg
  self.v_uicompents.RoundNum_txt.text = ChallengeRingPlusMgr:get_round_cnt()
  self.v_uicompents.TimeNum_txt.text = math.floor(ChallengeRingPlusMgr:get_fight_time()) .. "s"
  self.v_uicompents.ContriNow_txt.text = ChallengeRingPlusMgr:get_weekly_contribute_point() or 0
  self.v_uicompents.ContriMax_txt.text = ChallengeRingPlusMgr:get_weekly_contribute_point_limit()
  local point_id = self.v_fight_info.point_id
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  self.v_uicompents.Hard_txt.text = point_cfg.PointName
  local award_list = UtilTable.copy_table(self.v_tower_info.award_list)
  self:update_award_show(award_list)
  self:update_bless_show()
end

function ui:update_award_show(award_list)
  local bless_coin = FightBagMgr:get_item_num_by_id(CURSE_RING_CURRENCY)
  self.v_uicompents.BlessingCoinNum_txt.text = "+" .. bless_coin
  self.v_uicompents.ContriPointNum_txt.text = "+" .. 0
  if award_list[CURSE_RING_CONTRIBUTION_POINT] then
    self.v_uicompents.ContriPointNum_txt.text = "+" .. award_list[CURSE_RING_CONTRIBUTION_POINT].count
    award_list[CURSE_RING_CONTRIBUTION_POINT] = nil
  end
  local new_award_list = {}
  for key, award_data in pairs(award_list) do
    local item_cfg = Item_Helper.get_item_cfg(award_data.id)
    award_data.qulity = item_cfg.Quality
    award_data.priority = item_cfg.Priority
    table.insert(new_award_list, award_data)
  end
  table.sort(new_award_list, function(a, b)
    local x = 0
    local y = 0
    if a.priority then
      x = x + a.priority * 10000000
    end
    if b.priority then
      y = y + b.priority * 10000000
    end
    x = x + a.qulity * 100000000 - a.id
    y = y + b.qulity * 100000000 - b.id
    if x == y then
      return false
    else
      return x > y
    end
  end)
  self:remove_item_wrap_list()
  self:give_back_auto_cache(CURSE_SETTLEMENT_ITEM_KEY)
  for _, data in pairs(new_award_list) do
    local item = self:get_auto_cache(CURSE_SETTLEMENT_ITEM_KEY)
    self:set_item_data(item, data)
    table.insert(self.v_show_item_list, item)
  end
  self.v_uiobjects.TextRewardNone:SetActive(0 == UtilTable.hash_lenth(award_list))
end

function ui:set_item_data(item, data)
  local com_item = Util.get_child_gameobj("ItemObjCom", item)
  
  local function click_cb()
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = data.id
    })
  end
  
  self:create_item_obj(nil, com_item.gameObject, nil, {
    item_id = data.id,
    click_cb = click_cb
  })
  local item_cfg = Item_Helper.get_item_cfg(data.id)
  local item_count_txt = Util.get_text("AmountLayout/RewardNum_", item)
  item_count_txt.text = "+" .. data.count
  local item_name_txt = Util.get_text("RewardName_", item)
  item_name_txt.text = item_cfg.Name
end

function ui:remove_item_wrap_list()
  for _, obj in pairs(self.v_show_item_list) do
    self:remove_wrap_ui(obj)
  end
  self.v_show_item_list = {}
end

function ui:remove_bless_wrap_list()
  for _, obj in pairs(self.v_show_bless_list) do
    self:remove_wrap_ui(obj)
  end
  self.v_show_bless_list = {}
end

function ui:update_bless_show()
  local bless_list = ChallengeRingPlusMgr:get_bless_pos_list()
  self:remove_bless_wrap_list()
  self:give_back_auto_cache(CURSE_BLESS_ITEM_KEY)
  for _, bless_data in ipairs(bless_list) do
    local item = self:get_auto_cache(CURSE_BLESS_ITEM_KEY)
    self:set_bless_data(item, bless_data)
    table.insert(self.v_show_bless_list, item)
  end
end

function ui:set_bless_data(item, bless_data)
  local is_show_icon = bless_data.bless_id ~= nil and not bless_data.is_lock
  local is_lock = bless_data.is_lock
  local bless_icon = Util.get_image("BlessingIcon", item)
  local bless_lock = Util.get_image("Lock", item)
  bless_icon.gameObject:SetActive(is_show_icon)
  bless_lock.gameObject:SetActive(is_lock)
  if not is_show_icon then
    return
  end
  local icon_path = ShareRes.get_curse_ring_bless_icon(bless_data.bless_id)
  ResMgr:load_set_icon(bless_icon, icon_path)
end

function ui:ui_on_hide()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
  self.v_uiobjects.NoClickBg:SetActive(false)
  self:remove_bless_wrap_list()
  self:remove_item_wrap_list()
end

function ui:ui_on_destroy()
end

function ui:save_and_exit()
  self:ui_hide()
  
  local function cb()
    Global.scene_mgr:on_enter_main_scene()
    UIMgr:revert_cache_ui()
  end
  
  if TowerMgr then
    TowerMgr:on_exit_tower(cb)
  end
  if ChallengeRingPlusMgr then
    ChallengeRingPlusMgr:exit_tower()
  end
end

function ui:exit()
  local hero_list = SceneMgr:get_hero_list()
  for key, hero in pairs(hero_list) do
    for k, _ in pairs(hero.magic_mgr.v_magic_id_map) do
      hero.magic_mgr:remove_magic_by_id(k)
    end
  end
  
  local function clear_fun()
    TowerMgr:entry_choose_reward(true, ChallengeRingPlusMgr:is_end_ring(), false)
    self.v_timer = nil
  end
  
  self.v_uiobjects.NoClickBg:SetActive(true)
  self.v_timer = Timer:add_timer(nil, 0.3, clear_fun)
end

function ui:settlement()
  local function callback()
    Global.scene_mgr:on_enter_main_scene()
    
    UIMgr:revert_cache_ui()
  end
  
  if TowerMgr then
    TowerMgr:get_fight_reward(callback)
  end
  if SceneMgr:check_main_scene() then
    self:ui_hide()
  end
end

return ui
