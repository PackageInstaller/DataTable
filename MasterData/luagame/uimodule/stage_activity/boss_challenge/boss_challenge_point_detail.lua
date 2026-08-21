local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ModelRtView = require("ui.model_rt_view.signboard_rt_view_new")
local ITEM_OBJ_COM = require("uimodule.item.item_obj_com")
local MODEL_CONFIG = require("ui.model_rt_view.model_config")
local MODEL_PARAM = MODEL_CONFIG.UI_ENEMY_MODEL_PARAM
local CONTENT_ITEMOBJTEM_TEMP_KEY = "CONTENT_ITEMOBJTEM_TEMP_KEY"
local BOSS_DIFFICULTYTEM_KEY = "BOSS_DIFFICULTYTEM_KEY"
local BOSS_DIFFICULTYMAX_KEY = "BOSS_DIFFICULTYMAX_KEY"
local BOSS_EFFECTTEM_KEY = "BOSS_EFFECTTEM_KEY"
local DIFFICULTY_MAP = {
  EASY = 1,
  NORMAL = 2,
  HARD = 3,
  NIGHTMARE = 4
}

function ui:on_click_episode_btn(episode_id)
  if not BossChallengeMgr:get_challenge_episode_is_unlock(self.v_boss_challenge_id, episode_id) then
    Util.show_message_tip(2278)
    return
  end
  if self.v_select_episode_id == episode_id then
    return
  end
  self.v_select_episode_id = episode_id
  self.v_episode_cfg = ShareRes.get_boss_fight_episode_cfg(episode_id)
  local act_time = self.v_uicompents.AcitivityTime_rect.parent
  if self.v_episode_cfg.EndTime ~= nil then
    act_time:SetActive(true)
    local end_time = Date.get_time_stamp_by_scheme_id(self.v_episode_cfg.EndTime) or 0
    local total_sec = end_time - Date.server_time()
    if total_sec <= 0 then
      act_time:SetActive(false)
    end
    self.v_uicompents.AcitivityTime_txt.text = Date.get_time_formate_2(total_sec)
  else
    act_time:SetActive(false)
  end
  self.v_select_point_id = self.v_episode_cfg.EpisodeId
  self.v_uicompents.Ani_UIBossChalStage_refresh_pd:ResetPD()
  self.v_uicompents.Ani_UIBossChalStage_refresh_pd:Play()
  self:refresh_all_episode_select()
  self:refresh_episode_info()
  self:refresh_btn_rank_visible()
end

function ui:on_click_BtnRet1()
  self:ui_hide()
end

function ui:on_click_StartFight()
  if not self:check_can_pay() then
    return
  end
  if TowerMgr:check_fight_progress() then
    return
  end
  UIMgr:get_ui("team"):ui_show(self.v_select_episode_id, self.v_select_point_id, Config.CommonDefine.CHALLENGE_TYPE.BOSS)
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:on_click_BtnRet1()
  end)
  self:set_button("StartFight", function()
    self:on_click_StartFight()
  end)
  self:set_button("BtnRank", function()
    self:on_btn_rank_click()
  end)
  self.v_item_list = {}
  self:register_exist_auto_template(CONTENT_ITEMOBJTEM_TEMP_KEY, self.v_uiobjects.ItemObjTem, self.v_uiobjects.Content)
  self:register_exist_auto_template(BOSS_EFFECTTEM_KEY, self.v_uiobjects.EffectTem, self.v_uiobjects.EffectContent)
  self:register_exist_auto_template(BOSS_DIFFICULTYTEM_KEY, self.v_uiobjects.DifficultyTem, self.v_uiobjects.NorGroupContent)
  self:register_exist_auto_template(BOSS_DIFFICULTYMAX_KEY, self.v_uiobjects.DifficultyMax, self.v_uiobjects.DifficultyMaxContent)
end

function ui:ui_on_show(boss_challenge_id)
  self:refresh_view(boss_challenge_id)
  self:bind_auto_mq(Const.MSG_ON_RANK_UPDATE, self.on_open_rank, self)
end

function ui:ui_on_hide()
  self.v_episode_obj_map = nil
  self.v_select_episode_id = nil
  self:release_model()
  self:clear_award_item()
end

function ui:ui_on_destroy()
end

function ui:refresh_view(boss_challenge_id)
  self.v_boss_challenge_id = boss_challenge_id
  self.v_boss_challenge_cfg = ShareRes.get_boss_fight_cfg(self.v_boss_challenge_id)
  self:update_enemy_model_show()
  self:refresh_diff_list()
end

function ui:on_btn_rank_click()
  local show_count = self.v_episode_cfg.ShowRankPlayer
  local total_count = self.v_episode_cfg.RankPlayer
  RankMgr:request_rank_list(Config.CommonDefine.RANK_NAME.BOSS_FIGHT, self.v_episode_cfg.EpisodeId, 1, show_count, total_count, true)
end

function ui:on_open_rank()
  local curr_rank_info
  local rank_info_list = {}
  local boss_name = self.v_boss_challenge_cfg.Name
  for i, cfg in pairs(self.v_episode_list) do
    if BossChallengeMgr:get_challenge_episode_is_unlock(self.v_boss_challenge_id, cfg.Id) and cfg.IsOpenRank then
      local info = RankMgr:get_new_rank_title(cfg.EpisodeId, cfg.DifficultyDesc, cfg.ShowRankPlayer, cfg.RankPlayer, cfg.RankRefreshType, boss_name)
      if cfg.Id == self.v_select_episode_id then
        curr_rank_info = info
      end
      table.insert(rank_info_list, info)
    end
  end
  UIMgr:get_ui("endless_rank"):ui_show(Config.CommonDefine.RANK_NAME.BOSS_FIGHT, curr_rank_info, rank_info_list)
end

function ui:refresh_btn_rank_visible()
  self.v_uiobjects.BtnRank:SetActive(self.v_episode_cfg.IsOpenRank)
end

function ui:refresh_diff_list()
  self.v_episode_obj_map = {}
  self:give_back_auto_cache(BOSS_DIFFICULTYMAX_KEY)
  self:give_back_auto_cache(BOSS_DIFFICULTYTEM_KEY)
  local map = ShareRes.get_boss_fight_episode_map(self.v_boss_challenge_id)
  local episode_list = {}
  for difficulty, episode_cfg in pairs(map) do
    episode_list[#episode_list + 1] = episode_cfg
  end
  table.sort(episode_list, function(a, b)
    if a.Difficulty ~= b.Difficulty then
      return a.Difficulty < b.Difficulty
    end
  end)
  local first_episode
  self.v_episode_list = episode_list
  for index, episode_cfg in ipairs(episode_list) do
    local obj
    local episode_id = episode_cfg.Id
    if episode_cfg.UseDifficultyMax then
      obj = self:get_auto_cache(BOSS_DIFFICULTYMAX_KEY)
    else
      obj = self:get_auto_cache(BOSS_DIFFICULTYTEM_KEY)
    end
    self:refresh_challenge_episode_obj(obj, episode_cfg)
    self.v_episode_obj_map[episode_id] = obj
    if BossChallengeMgr:get_challenge_episode_is_unlock(self.v_boss_challenge_id, episode_id) then
      first_episode = episode_id
    end
  end
  if first_episode then
    self:on_click_episode_btn(first_episode)
  end
end

function ui:refresh_challenge_episode_obj(obj, episode_cfg)
  local episode_id = episode_cfg.Id
  local is_unlock = BossChallengeMgr:get_challenge_episode_is_unlock(self.v_boss_challenge_id, episode_cfg.Id)
  local nor_img = self:get_image("BgNor", obj)
  local lock_obj = self:get_child_gameobj("Lock", obj)
  local bglock_img = self:get_image("BgLock", obj)
  local bgselect_img = self:get_image("BgSelect", obj)
  local entext_obj = self:get_child_gameobj("EnText", obj)
  local name_txt = self:get_text("DifficultyName", obj)
  local btn = self:get_button(nil, obj)
  nor_img.gameObject:SetActive(is_unlock)
  entext_obj:SetActive(is_unlock)
  lock_obj:SetActive(not is_unlock)
  bglock_img.gameObject:SetActive(not is_unlock)
  name_txt.text = episode_cfg.DifficultyDesc
  self:set_button_listener(btn, function()
    self:on_click_episode_btn(episode_id)
  end)
  if episode_cfg.IconPath then
    ResMgr:load_set_icon(bglock_img, episode_cfg.IconPath)
    ResMgr:load_set_icon(bgselect_img, episode_cfg.IconPath)
  end
  if episode_cfg.UnIconPath then
    ResMgr:load_set_icon(nor_img, episode_cfg.UnIconPath)
  end
end

function ui:refresh_all_episode_select()
  local select_obj
  for episode_id, obj in pairs(self.v_episode_obj_map) do
    select_obj = self:get_child_gameobj("BgSelect", obj)
    select_obj:SetActive(episode_id == self.v_select_episode_id)
  end
end

function ui:refresh_episode_info()
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_select_point_id)
  self.v_uicompents.StageName_txt.text = point_cfg.PointName
  local show_zhanli = Util.is_more_than_zero(point_cfg.RecomFightVal)
  self.v_uiobjects.ZhanliNeedBg:SetActive(show_zhanli)
  if show_zhanli then
    self.v_uicompents.ZhanliNeed_txt.text = point_cfg.RecomFightVal
  end
  self.v_uiobjects.DifficultyMaxBg:SetActive(self.v_episode_cfg.Difficulty >= DIFFICULTY_MAP.NIGHTMARE)
  local complete = BossChallengeMgr:get_challenge_episode_is_suc(self.v_boss_challenge_id, self.v_select_episode_id)
  local cost = complete and point_cfg.FightCost[1] or point_cfg.FightCost[2]
  if Util.is_more_than_zero(cost) then
    self.v_uicompents.CostAmount_txt.text = cost
    self.v_uiobjects.Cost:SetActive(true)
  else
    self.v_uiobjects.Cost:SetActive(false)
  end
  self:refresh_point_award()
  self:refresh_episode_effect()
  self:refresh_pass_time()
end

function ui:refresh_pass_time()
  local pass_time = BossChallengeMgr:get_challenge_episode_pass_time(self.v_boss_challenge_id, self.v_select_episode_id)
  if pass_time and pass_time > 0 then
    self.v_uicompents.Time_txt.text = Util.format_str("通关时间：")
    self.v_uicompents.TimeNum_txt.text = Util.format_str(Date.get_time_desc(pass_time))
    self.v_uiobjects.TimeNum:SetActive(true)
  else
    self.v_uicompents.Time_txt.text = Util.format_str("暂无通关记录")
    self.v_uiobjects.TimeNum:SetActive(false)
  end
end

function ui:refresh_episode_effect()
  self:give_back_auto_cache(BOSS_EFFECTTEM_KEY)
  local obj, desc_txt
  for key, desc in ipairs(self.v_episode_cfg.MagicDesc) do
    obj = self:get_auto_cache(BOSS_EFFECTTEM_KEY)
    desc_txt = self:get_text("EffectDesc", obj)
    desc_txt.text = desc
  end
end

function ui:refresh_point_award()
  local point_id = self.v_select_point_id
  local data_list = {}
  ShareRes.get_point_award2(point_id, data_list, true)
  ShareRes.get_point_star_award2(point_id, data_list)
  ShareRes.get_hard_node_type_five_award2(point_id, data_list)
  self:show_award(data_list)
end

function ui:show_award(data_list)
  self:clear_award_item()
  if UtilTable.is_empty(data_list) then
    self.v_uiobjects.NoAward:SetActive(true)
    return
  end
  self.v_uiobjects.NoAward:SetActive(false)
  local complete = BossChallengeMgr:get_challenge_episode_is_suc(self.v_boss_challenge_id, self.v_select_episode_id)
  for index, data in ipairs(data_list) do
    function data.cb()
      UIMgr:get_ui("itemTip"):ui_show({
        item_id = data.id,
        
        is_hide_get_way = true
      })
    end
    
    local obj = self:get_auto_cache(CONTENT_ITEMOBJTEM_TEMP_KEY)
    local item = ITEM_OBJ_COM:ui_wrap_ex(self, obj, true)
    item:set_data(data)
    local tag_obj = self:get_child_gameobj("Tag_", obj)
    tag_obj:SetActive(data.check_first_pass)
    local cmp_obj = self:get_child_gameobj("Complete_", obj)
    cmp_obj.gameObject:SetActive(complete)
    local tag_cmp_obj = self:get_child_gameobj("TagComplete_", obj)
    tag_cmp_obj.gameObject:SetActive(complete)
    local pd = self:get_child_gameobj("Complete_/Image/CompletePd_", obj)
    pd.gameObject:SetActive(false)
    table.insert(self.v_item_list, item)
  end
end

function ui:update_enemy_model_show()
  local enemy_id = self.v_boss_challenge_cfg.EnemyID
  local character_cfg = ShareRes.get_character_cfg(enemy_id)
  local model_id = character_cfg.ModelId
  local model_cfgs_list = ShareRes.get_scene_model_cfg()[self.v_cfg.name]
  local model_cfg
  if model_cfgs_list then
    local model_id_cfg = model_cfgs_list[model_id]
    if model_id_cfg then
      model_cfg = model_id_cfg[4]
    else
      model_cfg = model_cfgs_list[4]
    end
  end
  if not self.v_model_view then
    local function load_npc_done_cb()
      self.v_model_view:update_scene_model_type(self.v_ui_name, 4, true)
    end
    
    self.v_model_view = ModelRtView:new(MODEL_PARAM.BG_NAME)
    local params = {
      model_id = model_id,
      npc_id = enemy_id,
      is_reload = true,
      hide_weapon = true,
      cb = load_npc_done_cb
    }
    self.v_model_idx = self.v_model_view:load_npc(params)
    local pos = model_cfg and model_cfg.ContentRootPosition
    if pos then
      local pos_table = {
        pos_x = pos[1],
        pos_y = pos[2],
        pos_z = pos[3]
      }
      self.v_model_view:set_content_pos(pos_table)
    end
    self.v_model_view:set_bg("BossChallengeBg")
  end
end

function ui:check_can_pay()
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_select_point_id)
  local complete = BossChallengeMgr:get_challenge_episode_is_suc(self.v_boss_challenge_id, self.v_select_episode_id)
  local cost = complete and point_cfg.FightCost[1] or point_cfg.FightCost[2]
  local can_pay = Util.check_item_cost_enough(Config.PLAYER_SP_ITEMID, cost)
  if not can_pay then
    local item_name = ShareRes.get_item_name(Config.PLAYER_SP_ITEMID)
    Util.show_message_tip(2314, item_name)
  end
  return can_pay
end

function ui:clear_award_item()
  self:give_back_auto_cache(CONTENT_ITEMOBJTEM_TEMP_KEY)
  for key, item in pairs(self.v_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_item_list[key] = nil
  end
end

function ui:release_model()
  if self.v_model_view then
    self.v_model_view:on_destroy()
    self.v_model_view = nil
  end
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_boss_challenge_id
end

return ui
