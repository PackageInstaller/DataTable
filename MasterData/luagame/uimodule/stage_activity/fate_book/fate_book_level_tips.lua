local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local FATE_BOOK_LEVEL_AWARD_TEMP = "FATE_BOOK_LEVEL_AWARD_TEMP"
local FATE_BOOK_LEVEL_UP_TEMP = "FATE_BOOK_LEVEL_UP_TEMP"
local Item_Helper = require("utils.item_helper")
local ITEM_OBJ_COM = require("uimodule.item.item_obj_com")
local ASSET_ITEM = {4}
local SHOP_HELPER = require("uimodule.shop.shop_helper")
local AssetBarView = require("ui.asset_bar.asset_bar")
local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local DESTINY_DROP_STATE = curse_com_def.DESTINY_DROP_STATE
local enough_color = Util.CommonColor_White
local not_enough_color = Util.CommonColor_RedWarm

function ui:on_click_detail_btn()
  local active = not self.v_uiobjects.FateLvUpTips.activeSelf
  self:set_detail_tips_enabled(active)
end

function ui:on_click_add_btn()
  self:operation_count(true)
end

function ui:on_click_reduce_btn()
  self:operation_count(false)
end

function ui:on_click_level_up_btn()
  if not self:check_can_release_level() then
    return
  end
  if PuzzleMgr:is_puzzle_bag_full() then
    Util.show_message_tip(2362)
    return
  end
  self:get_curse_desnity_level_award(self.v_release_level_count)
end

function ui:on_click_BtnPuzzleChoose()
  if self.v_progress then
    return
  end
  local fate_book_select_drop_tips = UIMgr:get_ui("fate_book_select_drop_tips")
  fate_book_select_drop_tips:ui_show(self.v_ring_id)
end

function ui:on_ring_data_update()
  self.v_get_new_ring_data_suc = true
  self:refresh_view()
end

function ui:on_jump_to_sys()
  self:ui_hide()
end

function ui:ui_finish_load()
  self:set_button("BtnAdd", function()
    self:on_click_add_btn()
  end)
  self:set_button("BtnBgClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnReduce", function()
    self:on_click_reduce_btn()
  end)
  self:set_button("FateLvUp", function()
    self:on_click_detail_btn()
  end)
  self:set_button("DetailBgClose", function()
    self:on_click_detail_btn()
  end)
  self:set_button("BtnConfirm", function()
    self:on_click_level_up_btn()
  end)
  self:set_button("BtnPuzzleChoose", function()
    self:on_click_BtnPuzzleChoose()
  end)
  self:set_slider_listener(self.v_uicompents.SetNumSlider_sld, function()
    local value = self.v_uicompents.SetNumSlider_sld.value
    self:refresh_count(value)
  end)
  self.v_release_level_count = 1
  self.v_item_list = {}
  local asset_config = SHOP_HELPER.get_asset_list(ASSET_ITEM)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, asset_config)
  self:register_exist_auto_template(FATE_BOOK_LEVEL_AWARD_TEMP, self.v_uiobjects.AwardTem, self.v_uiobjects.AwardContent)
  self:register_exist_auto_template(FATE_BOOK_LEVEL_UP_TEMP, self.v_uiobjects.LvUpTem, self.v_uiobjects.FateLvUpTips)
end

function ui:ui_on_show(ring_id, progress, get_new_ring_data_suc)
  self.v_ring_id = ring_id
  self.v_progress = progress
  self.v_get_new_ring_data_suc = get_new_ring_data_suc
  self:set_detail_tips_enabled(false)
  self:bind_auto_mq(Const.MSG_ON_RING_DATA_UPDATE, self.on_ring_data_update, self)
  self:bind_auto_mq(Const.MSG_ROLE_RES_CHANGE, self.refresh_view, self)
  self:bind_auto_mq(Const.MSG_ON_JUMP_TO_SYS, self.on_jump_to_sys, self)
  local y = self.v_uicompents.AwardContent_rect.anchoredPosition.y
  self.v_uicompents.AwardContent_rect:SetAnchoredPositionA(0, y)
  self:refresh_view()
end

function ui:ui_on_hide()
  self.v_asset_bar:on_hide()
  self.v_progress = nil
  self.v_release_level_count = 0
  self:clear_item_list()
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:refresh_view()
  self:refersh_desc_info()
  self:refersh_level_detail()
  self:refresh_award()
  self:refersh_detail_item()
  self:refresh_destiny_drop()
end

function ui:refresh_destiny_drop()
  local ring_cfg = ShareRes.get_curse_ring_config(self.v_ring_id)
  local show_drop_btn = false
  if ring_cfg.DestinyLevelDropType == Config.CommonDefine.CURSE_DROP_TYPE.SELECT_DROP then
    local destiny_group_cfg = ShareRes.get_curse_destiny_level_select_drop(ring_cfg.DestinyLevelDrop)
    show_drop_btn = destiny_group_cfg and not UtilTable.is_empty(destiny_group_cfg)
    if show_drop_btn then
      local has_choosed = false
      local select_index = ChallengeRingPlusMgr:get_destiny_drop_index(self.v_ring_id, self.v_progress ~= nil)
      if select_index and not self.v_progress and ChallengeRingPlusMgr:get_destiny_drop_state(self.v_ring_id, select_index) == DESTINY_DROP_STATE.END then
        select_index = nil
      end
      local destiny_cfg = select_index and destiny_group_cfg[select_index] or nil
      if destiny_cfg then
        has_choosed = true
        local result = {}
        ShareRes.get_item_obj_use_award_list(destiny_cfg.ShowAwardId, result, function(award_cfg, index)
          local data = {
            id = award_cfg.ItemId,
            count = award_cfg.Num,
            limit = award_cfg.Limit
          }
          return data
        end)
        local first_result = result[1]
        if first_result then
          local item = ITEM_OBJ_COM:ui_wrap_ex(self, self.v_uiobjects.PuzzleIcon, true)
          item:set_data(first_result)
          self.v_item_list[#self.v_item_list + 1] = item
        end
      end
      local show_red = ChallengeRingPlusMgr:get_destiny_drop_group_red(self.v_ring_id)
      self.v_uiobjects.RedPoint:SetActive(show_red)
      self.v_uiobjects.PuzzleChoosedBg:SetActive(self.v_progress == nil)
      self.v_uiobjects.PuzzleUnChoose:SetActive(not has_choosed and self.v_progress == nil)
      self.v_uiobjects.PuzzleChoosed:SetActive(has_choosed)
      self.v_uicompents.BtnPuzzleChoose_rect:SetAsLastSibling()
    end
  end
  self.v_uiobjects.BtnPuzzleChoose:SetActive(show_drop_btn)
end

function ui:refersh_desc_info()
  self.v_destiny_level = self:get_destiny_level()
  local ring_cfg = ShareRes.get_curse_ring_config(self.v_ring_id)
  local max_level = ring_cfg.MaxDestinyLevel
  self.v_uicompents.FateLvNum_txt.text = string.format("(%d/%d)", self.v_destiny_level, max_level)
  local is_in_battle = self.v_progress ~= nil
  self.v_uiobjects.FateLvUp:SetActive(is_in_battle)
  self.v_uiobjects.SetNum:SetActive(true)
  self.v_uiobjects.BtnConfirm:SetActive(true)
end

function ui:refersh_level_detail()
  local ring_cfg = ShareRes.get_curse_ring_config(self.v_ring_id)
  self.v_cost_id = ring_cfg.CostDestinyItemId
  self:refresh_asset_bar_config()
  self.v_cost_count = ring_cfg.CostDestinyItemCount
  local cfg = ShareRes.get_item_cfg(self.v_cost_id)
  self.v_max_release_level_count = math.min(self.v_destiny_level, cfg.MaxCount)
  self.v_release_level_count = 1
  local point_id = ring_cfg.EpisodeId
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  self.v_uicompents.StageName_txt.text = point_cfg.PointName
  self.v_uicompents.StageDifficulty_txt.text = ring_cfg.DifficultyText
  self:refresh_count()
end

function ui:refresh_asset_bar_config()
  ASSET_ITEM[2] = self.v_cost_id
  local asset_config = SHOP_HELPER.get_asset_list(ASSET_ITEM)
  asset_config[2].func = "_onclick_fate_book_tickets"
  self.v_asset_bar:reset_config(asset_config)
  self.v_asset_bar:on_create()
end

function ui:operation_count(is_add)
  local cur_count = self.v_release_level_count
  local target_count = is_add and cur_count + 1 or cur_count - 1
  if target_count < 1 or target_count > self.v_max_release_level_count then
    return
  end
  self.v_release_level_count = target_count
  self:refresh_count()
end

function ui:refresh_count(value)
  if value then
    self.v_release_level_count = math.floor(value)
  else
    self.v_uicompents.SetNumSlider_sld:SetValueWithoutNotify(self.v_release_level_count)
  end
  local max_value = math.max(1, self.v_max_release_level_count)
  if 1 ~= max_value then
    self.v_uicompents.SetNumSlider_sld.minValue = 1
    self.v_uicompents.SetNumSlider_sld.interactable = true
  else
    self.v_uicompents.SetNumSlider_sld.minValue = 0
    self.v_uicompents.SetNumSlider_sld.interactable = false
  end
  self.v_uicompents.SetNumSlider_sld.maxValue = max_value
  self.v_uicompents.LevelText_txt.text = self.v_release_level_count
  self:refresh_cost()
end

function ui:refresh_cost()
  local icon_path = UtilUI.get_item_icon(self.v_cost_id)
  ResMgr:load_set_icon(self.v_uicompents.BtnIcon_img, icon_path)
  local cost_num = self.v_cost_count * self.v_release_level_count
  local is_enough = BagMgr:get_cost_enough(self.v_cost_id, cost_num)
  self.v_uicompents.BtnText_txt.color = is_enough and enough_color or not_enough_color
  self.v_uicompents.BtnText_txt.text = cost_num * -1
end

function ui:refersh_detail_item()
  self:give_back_auto_cache(FATE_BOOK_LEVEL_UP_TEMP)
  local all_cfg = ShareRes.get_curse_destiny_level_cfg()
  local pass_floor_id = self.v_progress and self.v_progress.pass_floor_id or 0
  local obj, name_txt, num_txt, cfg
  local show_level = 0
  for floor_id = 1, pass_floor_id do
    cfg = all_cfg[floor_id]
    if cfg then
      obj = self:get_auto_cache(FATE_BOOK_LEVEL_UP_TEMP)
      name_txt = self:get_text("TermName", obj)
      name_txt.text = cfg.Desc
      num_txt = self:get_text("TermAdd", obj)
      num_txt.text = "+" .. cfg.Grade
      show_level = show_level + (cfg.Grade or 0)
    end
  end
  self.v_uicompents.LvUpNum_txt.text = show_level
  self.v_uiobjects.Detail:SetActive(show_level > 0)
  self.v_uicompents.FateLvUp_btn.enabled = show_level > 0
end

function ui:refresh_award()
  local ring_cfg = ShareRes.get_curse_ring_config(self.v_ring_id)
  self:clear_item_list()
  if ring_cfg.PreviewAwardGroupID then
    ResMgr:load_set_icon(self.v_uicompents.FateIcon_img, ring_cfg.IconPath)
    local award_list = self:get_award_item_list(ring_cfg.PreviewAwardGroupID)
    for index, data in ipairs(award_list) do
      local obj = self:get_auto_cache(FATE_BOOK_LEVEL_AWARD_TEMP)
      local item = ITEM_OBJ_COM:ui_wrap_ex(self, obj, true)
      item:set_data(data)
      self.v_item_list[index] = item
    end
  end
  local is_start, activity_id = NoviceMgr:is_double_challenge_start(Config.CommonDefine.DOUBLE_TYPE.FATEBOOK)
  local remaining_count, multiplier
  self.v_uiobjects.Muti:SetActive(is_start)
  if is_start then
    local cfg = ShareRes.get_double_challenge_cfg(activity_id)
    local use_count = NoviceMgr:get_double_challenge_count(activity_id)
    multiplier = cfg.Double
    remaining_count = cfg.Limit - use_count
    self.v_uicompents.MutiTimes_txt.text = multiplier .. "倍"
    self.v_uicompents.LessNum_txt.text = remaining_count
    self.v_uicompents.MaxNum_txt.text = cfg.Limit
  end
end

function ui:get_award_item_list(award_group_id)
  local a_item_cfg, b_item_cfg
  local award_list = {}
  
  local function jump_callback()
    self:ui_hide()
  end
  
  ShareRes.get_item_obj_use_award_list(award_group_id, award_list, function(award_cfg, index)
    local temp = {
      ItemId = award_cfg.ItemId,
      Num = award_cfg.Num,
      Name = Item_Helper.get_item_cfg(award_cfg.ItemId).Name,
      Limit = award_cfg.Limit,
      cb = function()
        UIMgr:get_ui("itemTip"):ui_show({
          item_id = award_cfg.ItemId,
          jump_cb = jump_callback
        })
      end
    }
    return temp
  end)
  table.sort(award_list, function(a, b)
    a_item_cfg, b_item_cfg = Item_Helper.get_item_cfg(a.ItemId), Item_Helper.get_item_cfg(b.ItemId)
    if a_item_cfg.Quality ~= b_item_cfg.Quality then
      return a_item_cfg.Quality > b_item_cfg.Quality
    elseif a.ItemId ~= b.ItemId then
      return a.ItemId < b.ItemId
    else
      return false
    end
  end)
  return award_list
end

function ui:set_detail_tips_enabled(tips_active)
  self.v_uiobjects.FateLvUpTips:SetActive(tips_active)
  self.v_uiobjects.DetailBgClose:SetActive(tips_active)
end

function ui:check_can_release_level()
  local destiny_level = self:get_destiny_level()
  if destiny_level < self.v_release_level_count then
    Util.show_message_tip(2294)
    return false
  end
  local ring_cfg = ShareRes.get_curse_ring_config(self.v_ring_id)
  local select_index = ChallengeRingPlusMgr:get_destiny_drop_index(self.v_ring_id, self.v_progress ~= nil)
  if ring_cfg.DestinyLevelDropType == Config.CommonDefine.CURSE_DROP_TYPE.SELECT_DROP and not select_index then
    local fate_book_select_drop_tips = UIMgr:get_ui("fate_book_select_drop_tips")
    fate_book_select_drop_tips:ui_show(self.v_ring_id)
    Util.show_message_tip("请选择奖励")
    return false
  end
  local cost_item = self.v_cost_id
  local cost_count = self.v_cost_count * self.v_release_level_count
  if Util.is_more_than_zero(cost_item) and Util.is_more_than_zero(cost_count) and not Util.check_item_cost_enough(cost_item, cost_count) then
    local item_num = BagMgr:get_item_num(cost_item)
    local lack_cnt = cost_count - item_num
    Util.show_recharge_box_by_item_id(cost_item, lack_cnt, nil, nil, function()
      local item_config = ShareRes.get_item_cfg(cost_item)
      local exchange_config = CharacterMgr:get_exchange_config_by_target_id(Config.EXCHANGE_TYPE.DEFAULT, cost_item)
      local exchange_config_id = exchange_config.Id
      local exchange_cost_id = exchange_config.Material[1]
      local exchange_cost_cnt = exchange_config.Num[1] * lack_cnt
      local item_maxnum = item_config.MaxCount
      local release_level_count = self.v_release_level_count
      local material_cur_count = BagMgr:get_item_num(exchange_cost_id)
      if item_maxnum < item_num + lack_cnt then
        Util.show_message_tip(2103)
        return
      end
      if exchange_cost_cnt > material_cur_count then
        UIMgr:get_ui("uiforcerecharg"):ui_show(nil, exchange_cost_cnt - material_cur_count)
        return
      end
      CharacterMgr:request_exchange_item(exchange_config_id, lack_cnt, function()
        UIMgr:try_hide_ui("fate_exchange")
        self:get_curse_desnity_level_award(release_level_count)
      end)
    end)
    return false
  end
  return true
end

function ui:clear_item_list()
  self:give_back_auto_cache(FATE_BOOK_LEVEL_AWARD_TEMP)
  for key, item in pairs(self.v_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_item_list[key] = nil
  end
end

function ui:get_destiny_level()
  local destiny_level = ChallengeRingPlusMgr:get_ring_destiny_level(self.v_ring_id)
  if not self.v_get_new_ring_data_suc then
    local all_cfg = ShareRes.get_curse_destiny_level_cfg()
    local pass_floor_id = self.v_progress and self.v_progress.pass_floor_id or 0
    local cfg
    for floor_id = 1, pass_floor_id do
      cfg = all_cfg[floor_id]
      if cfg then
        destiny_level = destiny_level + (cfg.Grade or 0)
      end
    end
    local ring_cfg = ShareRes.get_curse_ring_config(self.v_ring_id)
    if ring_cfg.MaxDestinyLevel then
      destiny_level = math.min(destiny_level, ring_cfg.MaxDestinyLevel)
    end
  end
  return destiny_level
end

function ui:get_curse_desnity_level_award(count)
  local function cb()
    if not self:visible() then
      return
    end
    self:refresh_view()
  end
  
  if not SceneMgr:check_main_scene() and not self.v_get_new_ring_data_suc then
    Log.Error("提示：释放等级时，尚未接收到服务器更新数据")
  end
  local cfg = ShareRes.get_curse_ring_config(self.v_ring_id)
  ChallengeRingPlusMgr:request_get_curse_destiny_level_award(cfg.EpisodeId, count, cb)
end

return ui
