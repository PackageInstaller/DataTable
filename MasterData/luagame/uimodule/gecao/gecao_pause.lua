local Base = require("ui.uibase")
local M = Util.create_child_mt(Base)
local SaticSv = require("ui.widget.static_scroll_view")
local TaskItem = require("uimodule.gecao.local_widgets.gecao_settle_task_item")
local TaskItemKey = "GECAO_SETTLE_TASK_ITEM_KEY"
local Stars = {
  "Star1",
  "Star2",
  "Star3"
}
local Item_Helper = require("utils.item_helper")
local _sort = table.sort
local _insert = table.insert
local commonDef = require("cs_share.common_define")
local AwardItem = require("uimodule.gecao.local_widgets.settle_item_obj_com1")
local AwardItemKey = "GECAO_AWARD_PREVIEW_ITEM_KEY"

function M:ui_finish_load()
  self:set_button("BtnReturn", function()
    self:on_click_return()
  end)
  self:set_button("BtnSaveQuit", function()
    self:save_and_quit()
  end)
  self:set_button("BtnDirectQuit", function()
    self:settle()
  end)
  local uobj = self.v_uiobjects
  self.v_ui_name = self:ui_get_name()
  self.v_task_sv = SaticSv:new(self, uobj.TargetObj, TaskItem, TaskItemKey .. self.v_ui_name)
  self.v_award_preview_sv = SaticSv:new(self, uobj.RewardContent, AwardItem, AwardItemKey .. self.v_ui_name)
end

function M:on_click_return()
  self:ui_hide()
end

function M:settle()
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  if tower:is_skip_open_card() then
    local tower_progress = TowerMgr:get_tower_progress()
    local fight_info = TowerMgr:get_fight_info()
    TowerMgr:request_entry_choose_award(function(choose_reward_list)
      TowerMgr:get_fight_reward(nil, false, function()
        UIMgr:get_ui("gecao_settle"):ui_show(tower_progress, fight_info, choose_reward_list, true)
      end)
    end)
  else
    TowerMgr:entry_choose_award_new(true)
  end
  UIMgr:try_hide_ui("gecao_battle")
end

function M:save_and_quit()
  local function cb()
    Global.scene_mgr:on_enter_main_scene()
    
    UIMgr:revert_cache_ui()
  end
  
  if TowerMgr then
    TowerMgr:on_exit_tower(cb)
  end
end

function M:cache_hide_ui()
  return false
end

function M:ui_on_show()
  UIMgr:try_hide_ui("pop_text_tip")
  self.v_tower_progress = TowerMgr:get_tower_progress()
  self.v_fight_info = TowerMgr:get_fight_info()
  self.v_is_in_fight = true
  self.v_chapter_id = self.v_fight_info.param
  self.v_chapter_cfg = ShareRes.get_gecao_cfg(self.v_fight_info.param)
  assert(self.v_chapter_cfg, "gecao chapter config is null!")
  self:refresh_task_list()
  local ucom = self.v_uicompents
  local cfg = self.v_chapter_cfg
  ucom.Hard_txt.text = cfg.LevelName
  local star_num = self:get_star_num()
  local uobj = self.v_uiobjects
  for i = 1, 3 do
    local star_obj = uobj[Stars[i]]
    local star_light_obj = star_obj.transform:GetChild(0)
    star_light_obj:SetActive(i <= star_num)
  end
  local pass_floor = self.v_tower_progress.pass_floor_id
  ucom.RingFinish_txt.text = pass_floor
  local chapter_point_cfg = ShareRes.get_chapter_point_cfg(cfg.EpisodeId)
  local tower_cfg = ShareRes.get_tower_cfg(chapter_point_cfg.FightId)
  local max_floor = tower_cfg.FloorMax
  ucom.RingMax_txt.text = max_floor
  self:update_show_drawing()
  self:refresh_award_list()
end

function M:refresh_award_list()
  local award_list = self.v_tower_progress.award_list
  local have_award = award_list and UtilTable.hash_lenth(award_list) > 0
  self.v_uiobjects.TextRewardNone:SetActive(not have_award)
  local new_award_list = {}
  for key, value in pairs(award_list) do
    _insert(new_award_list, value)
  end
  _sort(new_award_list, function(a, b)
    local cfg_a = Item_Helper.get_item_cfg(a.id)
    local cfg_b = Item_Helper.get_item_cfg(b.id)
    if not cfg_a or not cfg_b then
      return false
    end
    if cfg_a.Quality == cfg_b.Quality then
      if cfg_a.Priority == cfg_b.Priority then
        return a.id > b.id
      else
        return cfg_a.Priority > cfg_b.Priority
      end
    else
      return cfg_a.Quality > cfg_b.Quality
    end
  end)
  self.v_award_preview_sv:update_list(new_award_list)
end

function M:get_star_num()
  local task_list = self.v_tower_progress and self.v_tower_progress.tower_task
  assert(task_list, "task_list is nil")
  if not task_list then
    return 0
  end
  local num = 0
  for key, value in pairs(task_list) do
    if value.status then
      num = num + 1
    end
  end
  return num
end

function M:ui_on_hide()
  self.v_task_sv:clear()
  self.v_award_preview_sv:clear()
end

function M:ui_on_destroy()
  self.v_task_sv = nil
  self.v_award_preview_sv = nil
end

function M:refresh_task_list()
  local task_list = self:get_tower_task_list()
  self.v_task_sv:update_list(task_list)
end

function M:settlement()
  if SceneMgr:check_main_scene() then
    self:ui_hide()
  end
  Global.scene_mgr:on_enter_main_scene()
  UIMgr:revert_cache_ui()
end

function M:update_show_drawing()
  local pos_data = {}
  local hero_list = SceneMgr:get_hero_list()
  if hero_list then
    for uuid, hero in pairs(hero_list) do
      local hero_id = hero:get_buddy_id()
      _insert(pos_data, {buddy_id = hero_id})
    end
  end
  local new_data = {}
  for _, data in ipairs(pos_data) do
    if 0 ~= data.buddy_id then
      _insert(new_data, data.buddy_id)
    end
  end
  if #new_data <= 0 then
    return
  end
  local random_index = math.random(1, #new_data)
  local buddy_id = new_data[random_index]
  local hero_icon = self.v_uicompents.HeroIcon_img
  local icon_path = UtilUI.get_hero_images(buddy_id, Config.HERO_ICON_LV.HD_FULL_IMG)
  ResMgr:load_set_icon(hero_icon, icon_path, nil, true)
end

function M:get_tower_task_list()
  return self.v_tower_progress and self.v_tower_progress.tower_task
end

return M
