local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SKILL_TREE_ITEM = require("uimodule.stage_activity.fate_book.fate_book_skill_tree_item")
local AssetBarView = require("ui.asset_bar.asset_bar")
local FATE_BOOK_SKILL_TREE_GROUP = "FATE_BOOK_SKILL_TREE_GROUP"
local DATE_STATISTICS_TEM = "DATE_STATISTICS_TEM"
local enough_color = Util.get_unity_color_by_hex(tonumber("F5EDE2", 16))
local not_enough_color = Util.CommonColor_RedWarm
local FIRST_GROUP = 1
local NOT_SHOW_LINE_POS = {
  [1] = true,
  [3] = true,
  [5] = true
}
local ASSET_BAR_CONFIG = {
  {
    item_id = 29,
    const_event = Const.MSG_ROLE_RES_CHANGE,
    func = "_on_click_item"
  }
}
local DELAY_MOVE_TIME = 0.03

local function sort(a, b)
  local _, a1 = next(a)
  local _, b1 = next(b)
  if a1 and b1 and a1.PosGroup ~= b1.PosGroup then
    return a1.PosGroup < b1.PosGroup
  else
    return false
  end
end

local function sort2(a, b)
  if a.type ~= b.type then
    return a.type < b.type
  else
    return false
  end
end

function ui:on_select_bless_item(select_bless_id)
  self.v_select_bless_id = select_bless_id
  for key, item in pairs(self.v_skill_tree_item_map) do
    item:on_select_item(self.v_select_bless_id)
  end
  self:refresh_select_info()
end

function ui:on_click_blessing_btn()
  if not self.v_uiobjects.BuffContent.activeSelf then
    self:open_content()
  else
    self:close_content()
  end
end

function ui:on_click_return_btn()
  self:ui_hide()
end

function ui:on_click_unlock_btn()
  if not self.v_select_bless_id or not ChallengeRingPlusMgr:check_skill_item_is_active(self.v_select_bless_id) then
    return
  end
  local unlock_id = self.v_select_bless_id
  
  local function cb()
    self:refresh_skill_tree()
    self:play_unlock_effect(unlock_id)
  end
  
  local cfg = ShareRes.get_curse_ring_bless_cfg(unlock_id)
  if not Util.check_item_cost_enough(cfg.CostItem, cfg.CostCnt) then
    Util.show_message_tip(1027)
    return
  end
  ChallengeRingPlusMgr:request_unlock_bless(self.v_select_bless_id, cb)
end

function ui:ui_finish_load()
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, ASSET_BAR_CONFIG)
  self:set_button("BtnBlessing", function()
    self:on_click_blessing_btn()
  end)
  self:set_button("BtnRet1", function()
    self:on_click_return_btn()
  end)
  self:set_button("BtnUnlock", function()
    self:on_click_unlock_btn()
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.fate_book_talent_unlock_UI_SOUND)
  end)
  self:set_button("FullBtn", function()
    self:on_click_blessing_btn()
  end)
  self.v_skill_tree_item_map = {}
  self:register_exist_auto_template(FATE_BOOK_SKILL_TREE_GROUP, self.v_uiobjects.SkillGroupTem, self.v_uiobjects.SkillGroupContent)
  self:register_exist_auto_template(DATE_STATISTICS_TEM, self.v_uiobjects.BuffDescTem, self.v_uiobjects.BuffContent)
end

function ui:ui_on_show()
  self.v_asset_bar:on_create()
  self:refresh_skill_tree(true)
  self.v_uiobjects.BuffContent:SetActive(false)
  self.v_uiobjects.FullBtn:SetActive(false)
end

function ui:ui_on_hide()
  self.v_select_bless_id = nil
  self.v_asset_bar:on_hide()
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:refresh_total_num(total_num)
  self.v_uicompents.BlessingAll_txt.text = total_num
  self.v_uicompents.BlessingNow_txt.text = UtilTable.hash_lenth(ChallengeRingPlusMgr:get_bless_unlock_map())
end

function ui:refresh_skill_tree(is_first)
  self:clear_all_skill_tree_item()
  local all_cfg = ShareRes.get_curse_ring_skill_tree_pos_cfg()
  local temp_list = {}
  for key, group_cfg in pairs(all_cfg) do
    table.insert(temp_list, group_cfg)
  end
  table.sort(temp_list, sort)
  local obj, root, child_count, child, cfg, item
  local count = 0
  local first_can_unlock_id, final_id
  for key, group_cfg in ipairs(temp_list) do
    obj = self:get_auto_cache(FATE_BOOK_SKILL_TREE_GROUP)
    root = obj.transform
    child_count = root.childCount
    for index = 1, child_count do
      cfg = group_cfg[index]
      child = self:get_child_gameobj(index, root.gameObject)
      if cfg then
        if child then
          item = SKILL_TREE_ITEM:ui_wrap_ex(self, child.gameObject, true)
          item:set_data(cfg)
          self.v_skill_tree_item_map[cfg.Id] = item
        else
          Log.Error("祝福组获取点位失败，组ID：", cfg.PosGroup, "位置:", cfg.Pos)
        end
        final_id = cfg.Id
        if not first_can_unlock_id and ChallengeRingPlusMgr:check_skill_item_is_can_unlock(final_id) then
          first_can_unlock_id = final_id
        end
        count = count + 1
      else
        child.gameObject:SetActive(false)
      end
    end
  end
  self:refresh_total_num(count)
  local target_item = self.v_skill_tree_item_map[self.v_select_bless_id or first_can_unlock_id or final_id]
  if target_item then
    local function cb()
      local rect = target_item:get_rect_transform()
      
      Util.move_to_target_point_pos(rect, self.v_uicompents.ScrollView_rect, self.v_uicompents.SkillGroupContent_rect, true)
    end
    
    if is_first then
      self.v_move_timer = Timer:add_timer("move_timer", DELAY_MOVE_TIME, cb)
    end
    target_item:on_click_btn()
  end
end

function ui:refresh_select_info()
  local is_unlock = ChallengeRingPlusMgr:check_bless_is_unlock(self.v_select_bless_id)
  local is_active = ChallengeRingPlusMgr:check_skill_item_is_active(self.v_select_bless_id)
  self.v_uiobjects.BgActive:SetActive(is_unlock)
  local cfg = ShareRes.get_curse_ring_bless_cfg(self.v_select_bless_id)
  ResMgr:load_set_icon(self.v_uicompents.BlessingIcon_img, cfg.Icon)
  self.v_uicompents.BlessingName_txt.text = cfg.Name
  local int, float = math.modf(cfg.DescParam)
  local param = cfg.DescParam
  if float and 0 ~= float then
    param = math.ceil(param * 100) .. "%"
  end
  self.v_uicompents.BlessingDesc_txt.text = Util.format_str(cfg.StatisticsDesc, param)
  self.v_uiobjects.UnLock:SetActive(is_unlock)
  self.v_uiobjects.BlessingLock:SetActive(not is_unlock and not is_active)
  self:update_button_state(is_unlock, is_active, cfg)
end

function ui:update_button_state(is_unlock, is_active, cfg)
  if not is_unlock and is_active then
    local is_enough = BagMgr:get_cost_enough(cfg.CostItem, cfg.CostCnt)
    self.v_uicompents.CurrNum_txt.color = is_enough and enough_color or not_enough_color
    self.v_uicompents.CurrNum_txt.text = cfg.CostCnt
    local path = UtilUI.get_item_icon(cfg.CostItem)
    ResMgr:load_set_icon(self.v_uicompents.CurrIcon_img, path)
    self.v_uiobjects.BtnUnlock:SetActive(true)
  else
    self.v_uiobjects.BtnUnlock:SetActive(false)
  end
end

function ui:open_content()
  self.v_uiobjects.BuffContent:SetActive(true)
  self.v_uiobjects.FullBtn:SetActive(true)
  local temp_map = {}
  local all_cfg = ShareRes.get_curse_ring_bless_all_cfg()
  local temp
  local all_data = ChallengeRingPlusMgr:get_bless_unlock_map()
  local cfg, int, float
  for bless_id, _ in pairs(all_data) do
    cfg = all_cfg[bless_id]
    if cfg then
      temp_map[cfg.ShowType] = temp_map[cfg.ShowType] or {}
      temp = temp_map[cfg.ShowType]
      temp.value = (temp.value or 0) + cfg.DescParam
      int, float = math.modf(cfg.DescParam)
      if not temp.is_float then
        temp.is_float = nil ~= float and 0 ~= float
      end
      if not temp.desc then
        temp.desc = cfg.StatisticsDesc
      end
      if not temp.type then
        temp.type = cfg.ShowType
      end
    end
  end
  local temp_list = {}
  for key, data in pairs(temp_map) do
    table.insert(temp_list, data)
  end
  table.sort(temp_list, sort2)
  local obj, text, value
  for index, data in ipairs(temp_list) do
    obj = self:get_auto_cache(DATE_STATISTICS_TEM)
    text = self:get_text(nil, obj)
    if text then
      value = data.is_float and math.ceil(data.value * 100) .. "%" or data.value
      text.text = Util.format_str(data.desc, value)
    end
  end
end

function ui:close_content()
  self:give_back_auto_cache(DATE_STATISTICS_TEM)
  self.v_uiobjects.BuffContent:SetActive(false)
  self.v_uiobjects.FullBtn:SetActive(false)
end

function ui:clear_all_skill_tree_item()
  self:give_back_auto_cache(FATE_BOOK_SKILL_TREE_GROUP)
  for key, item in pairs(self.v_skill_tree_item_map) do
    item:ui_hide()
    item:ui_destroy()
    self.v_skill_tree_item_map[key] = nil
  end
end

function ui:check_is_first_group(group)
  return FIRST_GROUP == group
end

function ui:check_need_show_line(pos)
  return NOT_SHOW_LINE_POS[pos]
end

function ui:play_unlock_effect(unlock_id)
  local item = self.v_skill_tree_item_map[unlock_id]
  if item then
    local tf = item:get_object_transform()
    self.v_uiobjects.UnLockEffect:SetActive(true)
    self.v_uiobjects.UnLockEffect.transform:SetParent(tf, false)
    self.v_uiobjects.UnLockEffect.transform.localPosition = UnityVector3.zero
    self.v_uicompents.UnlockIPd_pd:ResetPD()
    self.v_uicompents.UnlockIPd_pd:Play()
  end
end

return ui
