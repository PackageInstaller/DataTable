local Base = require("ui.uibase")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local SaticSv = require("ui.widget.static_scroll_view")
local SvItem = require("uimodule.fight.fight_settlement_skill_item")
local CommonDef = require("cs_share.common_define")
local Item_Helper = require("utils.item_helper")
local NOT_PROGRESS_BATTLE_TYPE = Config.NOT_PROGRESS_BATTLE_TYPE
local ui = Util.create_child_mt(Base)
local _insert = table.insert
local _random = math.random
local Skill_Type = {normal = 1, mastery = 2}
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_blur = {
    "Blur",
    BIND_TYPE.RAW_IMAGE
  },
  v_btn_confirm = {
    "BtnConfirm",
    BIND_TYPE.BUTTON
  },
  v_currency_obj = {
    "CurrencyObj",
    BIND_TYPE.BUTTON
  },
  v_hero1 = {
    "Hero1",
    BIND_TYPE.OBJECT
  },
  v_hero2 = {
    "Hero2",
    BIND_TYPE.OBJECT
  },
  v_hero3 = {
    "Hero3",
    BIND_TYPE.OBJECT
  },
  v_hero = {
    "Hero",
    BIND_TYPE.IMAGE
  },
  v_max_record = {
    "MaxRecord",
    BIND_TYPE.TEXT
  },
  v_max_round = {
    "MaxRound",
    BIND_TYPE.TEXT
  },
  v_now_round = {
    "NowRound",
    BIND_TYPE.TEXT
  },
  v_player_id = {
    "PlayerID",
    BIND_TYPE.TEXT
  },
  v_player_icon = {
    "PlayerIcon",
    BIND_TYPE.IMAGE
  },
  v_player_name = {
    "PlayerName",
    BIND_TYPE.TEXT
  },
  v_round_num = {
    "RoundNum",
    BIND_TYPE.TEXT
  },
  v_skill_list = {
    "SkillList",
    BIND_TYPE.OBJECT
  },
  v_skill_tem = {
    "SkillTem",
    BIND_TYPE.OBJECT
  },
  v_stage_name = {
    "StageName",
    BIND_TYPE.TEXT
  },
  v_item_content = {
    "ItemList",
    BIND_TYPE.OBJECT
  },
  v_item_template = {
    "ItemTem",
    BIND_TYPE.OBJECT
  },
  v_no_reward = {
    "NoRewadLab",
    BIND_TYPE.OBJECT
  }
}
local CR_REWARD_ITEM_KEY = "CR_REWARD_ITEM_KEY"
local CR_SETTLE_SKILL_ITEM = "CR_SETTLE_SKILL_ITEM"

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_hero_list = {}
  for i = 1, 3 do
    self.v_hero_list[i] = self.v_uiobjects["Hero" .. i]
  end
  self:set_button("BtnConfirm", function()
    self:click_confirm_btn()
  end)
  self:set_button("BtnGiveUp", function()
    self:click_confirm_btn()
  end)
  self:set_button("BtnRelive", function()
    self:click_reborn_btn()
  end)
  self:set_button("BtnReturnLastRoom", function()
    self:click_archieve_born_btn()
  end)
  self:register_exist_auto_template(CR_REWARD_ITEM_KEY, self.v_item_template, self.v_item_content)
  self.v_skill_show_list = SaticSv:new(self, self.v_uiobjects.SkillList, SvItem, CR_SETTLE_SKILL_ITEM)
end

function ui:ui_on_show(fight_state, tower_info)
  self.v_is_get_award = false
  if StoryMgr then
    StoryMgr:close_story()
  end
  self.v_state = fight_state
  self.v_all_die = fight_state == CHAPTER_CONFIG.POINTSTATE.all_die
  self.v_tower_info = TowerMgr:get_tower_progress()
  self.v_award_list = self.v_tower_info.award_list
  if (not self.v_award_list or next(self.v_award_list) == nil) and tower_info then
    self.v_award_list = tower_info.battle_exchange_item
  end
  local fight_info = TowerMgr:get_fight_info()
  if not fight_info and self.v_tower_info then
    fight_info = {
      type = self.v_tower_info.challenge_type,
      point_id = self.v_tower_info.episode_id,
      param = self.v_tower_info.param
    }
  end
  self.v_fight_info = fight_info
  self.v_fight_type = fight_info.type
  self.v_formation_type = CommonDef.CHAL_TYPE2FORMN_TYPE[self.v_fight_type]
  self.v_uiobjects.StageInfo:SetActive(self.v_fight_type ~= CommonDef.CHALLENGE_TYPE.BUDDY_TEACH)
  self:_refresh_hero_info()
  self:_refresh_player_info()
  self:_refresh_skill_info()
  if self.v_fight_type == CommonDef.CHALLENGE_TYPE.CHALLENGE_RING then
    self:_refresh_ring_info()
  else
    self:update_tower_info()
  end
  self:update_reward_content()
  self:_refresh_teach_info()
  self:update_show_drawing()
  self:_refresh_relive_info()
  if self.v_state ~= CHAPTER_CONFIG.POINTSTATE.complete then
    TowerMgr:play_retreat_sound(self.v_show_buddy_id)
  end
  local can_archieve_reborn = self.v_all_die and TowerMgr:can_archieve()
  local show = self.v_fight_type == CommonDef.CHALLENGE_TYPE.BUDDY_TEACH and self.v_state ~= CHAPTER_CONFIG.POINTSTATE.complete
  self.v_uiobjects.BtnGiveUp:SetActive(not can_archieve_reborn and show)
  self.v_uiobjects.BtnConfirm:SetActive(not can_archieve_reborn and not show)
  self.v_uiobjects.BtnReturnLastRoom:SetActive(can_archieve_reborn)
  self:register_event()
  if TowerMgr then
    if self.v_state == CHAPTER_CONFIG.POINTSTATE.all_die then
      local _, reborn_cost_num, reborn_cost_id = TowerMgr:get_reborn_cost()
      if not can_archieve_reborn and (not (_ and reborn_cost_id) or 0 == reborn_cost_id) then
        TowerMgr:get_fight_reward()
        self.v_is_get_award = true
      end
    else
      TowerMgr:get_fight_reward()
      self.v_is_get_award = true
    end
  end
end

function ui:register_event()
end

function ui:_refresh_hero_info()
  for i, v in ipairs(self.v_hero_list) do
    v:SetActive(false)
  end
  local point_id = self.v_tower_info.episode_id
  local team_list = FormationMgr:get_fight_team_data(nil, point_id).buddys
  for _, v in pairs(team_list) do
    local obj = self.v_hero_list[v.pos]
    if v.buddy_id > 0 then
      obj:SetActive(true)
      local icon = self:get_image("HeroIcon", obj)
      local img = UtilUI.get_hero_images(v.buddy_id, 1)
      ResMgr:load_set_icon(icon, img)
    end
  end
end

function ui:update_reward_content()
  if self.v_fight_type == CommonDef.CHALLENGE_TYPE.BUDDY_TEACH then
    self:update_skill_teach_reward_content()
  else
    self:update_reward_list()
  end
end

function ui:_refresh_player_info()
  self.v_player_name.text = PlayerMgr:get_player_name()
  self.v_player_id.text = Global.player_uuid
  local face_id = PlayerMgr:get_player_face_id()
  local player_icon_cfg = ShareRes.create("player.player_avatar", face_id)
  assert(player_icon_cfg, "player icon don't exist")
  local player_icon_path = string.format("Icon/Profile/%s", player_icon_cfg.Icon)
  ResMgr:load_set_icon(self.v_player_icon, player_icon_path)
end

function ui:_refresh_skill_info()
  self.v_skill_list = BattleSkillBookMgr:get_skill_list()
  local all_skill_cfg = ShareRes.create("battle.battle_skill")
  local point_id = self.v_tower_info.episode_id
  local team_list = FormationMgr:get_fight_team_data(nil, point_id).buddys
  local buddyid2pos = {}
  for _, pos_data in pairs(team_list) do
    local pos = pos_data.pos
    local buddy_id = pos_data.buddy_id
    buddyid2pos[buddy_id] = pos
  end
  local skill_group = {}
  for idx, skill_id in pairs(self.v_skill_list) do
    local skill_cfg = all_skill_cfg[skill_id]
    local group_num = skill_cfg.SkillGroup
    local now_level = skill_cfg.SkillLevel
    local buddy_id = skill_cfg.BuddyId
    if group_num then
      skill_group[buddy_id] = skill_group[buddy_id] or {}
      local group = skill_group[buddy_id][group_num]
      if not group then
        skill_group[buddy_id][group_num] = {
          skill_id = skill_id,
          idx = idx,
          level = now_level
        }
      elseif now_level > group.level then
        group.skill_id = skill_id
        group.idx = idx
        group.level = now_level
      end
    end
  end
  local show_point = {}
  for _, now_group in pairs(skill_group) do
    for _, skill_point in pairs(now_group) do
      local skill_id = skill_point.skill_id
      local skill_cfg = all_skill_cfg[skill_id]
      local skill_type = skill_cfg.SkillType
      local skill_buddy_id = skill_cfg.BuddyId
      if skill_type == Skill_Type.mastery then
        local temp = {
          idx = skill_point.idx,
          skill_id = skill_id,
          pos_id = buddyid2pos[skill_buddy_id]
        }
        table.insert(show_point, temp)
      end
    end
  end
  table.sort(show_point, function(a, b)
    if a.pos_id == b.pos_id then
      return a.idx > b.idx
    else
      return a.pos_id < b.pos_id
    end
  end)
  local max_col = 5
  local show_list = {}
  local point_idx = 1
  for i = 1, 20 do
    local temp = {}
    local row = math.floor((i - 1) / 5) + 1
    local col = 0 == i % max_col and max_col or i
    temp.row = row
    temp.col = col
    if not show_point[point_idx] or 0 == row % 2 and col == max_col then
      table.insert(show_list, temp)
    else
      local skill_id = show_point[point_idx].skill_id
      local pos_id = show_point[point_idx].pos_id
      temp.pos_id = pos_id
      temp.skill_cfg = all_skill_cfg[skill_id]
      point_idx = point_idx + 1
      table.insert(show_list, temp)
    end
  end
  self.v_skill_show_list:update_list(show_list)
end

function ui:_refresh_ring_info()
  local uicom = self.v_uicompents
  local uiobj = self.v_uiobjects
  uiobj.StageInfo:SetActive(self.v_fight_type == CommonDef.CHALLENGE_TYPE.CHALLENGE_RING)
  if self.v_fight_type ~= CommonDef.CHALLENGE_TYPE.CHALLENGE_RING then
    return
  end
  uicom.StageText_txt.text = Util.format_str("环数")
  uicom.MaxRecordTail_txt.text = Util.format_str("环")
  uiobj.RoundObj:SetActive(true)
  uiobj.FloorObj:SetActive(false)
  uiobj.NewRecord:SetActive(false)
  local ring_info = ChallengeRingMgr:get_cur_ring_info()
  local now_episode_id = ring_info.id
  local game_id = ActivityMgr:invoke(CommonDef.ACTY_TYPE.CHALLENGE_RING, "get_game_id")
  local list = ShareRes.create("activity.challenge_ring_main", game_id)
  local ring_tower_cfg
  for _, episode_id in ipairs(list.EpisodeIds) do
    if now_episode_id == episode_id then
      local chapter_cfg = ShareRes.get_chapter_point_cfg(now_episode_id)
      local tower_id = chapter_cfg.FightId
      ring_tower_cfg = ShareRes.create("activity.rings_of_challenge_ring_by_tower", tower_id)
      break
    end
  end
  local ring_max_num = 0
  local cur_pass_circle = ring_info.cur_pass_circle
  if ring_tower_cfg then
    ring_max_num = #ring_tower_cfg
    if cur_pass_circle >= ring_max_num - 1 and not self.v_all_die then
      cur_pass_circle = ring_max_num
    end
  end
  self.v_max_record.text = ring_info.history_max_circle
  self.v_max_round.text = ring_max_num
  self.v_round_num.text = ring_info.round
  self.v_now_round.text = cur_pass_circle
end

function ui:_refresh_teach_info()
  self.v_uiobjects.StageSitsation:SetActive(self.v_fight_type == CommonDef.CHALLENGE_TYPE.BUDDY_TEACH)
  if self.v_fight_type ~= CommonDef.CHALLENGE_TYPE.BUDDY_TEACH then
    return
  end
  self.v_uiobjects.Complete:SetActive(not self.v_all_die)
  self.v_uiobjects.Discontinue:SetActive(self.v_all_die)
end

function ui:update_show_drawing()
  local pos_data = {}
  local hero_list = SceneMgr:get_hero_list()
  if hero_list then
    for uuid, hero in pairs(hero_list) do
      local hero_id = hero:get_buddy_id()
      _insert(pos_data, {buddy_id = hero_id})
    end
  end
  if #pos_data <= 0 then
    local point_id = self.v_tower_info.episode_id
    pos_data = FormationMgr:get_fight_team_data(nil, point_id).buddys
  end
  local new_data = {}
  for i = 1, 3 do
    local data = pos_data[i]
    if data and 0 ~= data.buddy_id then
      _insert(new_data, data.buddy_id)
    end
  end
  if #new_data <= 0 then
    Log.Error("编队信息空了")
    return
  end
  local random_index = math.random(1, #new_data)
  local buddy_id = new_data[random_index]
  local hero_icon = self.v_uicompents.Hero_img
  local hero_shadow_icon = self.v_uicompents.HeroShadow_img
  local icon_path = UtilUI.get_hero_images(buddy_id, Config.HERO_ICON_LV.HD_FULL_IMG)
  ResMgr:load_set_icon(hero_icon, icon_path, nil, true)
  ResMgr:load_set_icon(hero_shadow_icon, icon_path, nil, true, self)
end

function ui:_refresh_relive_info()
  local is_reborn = self.v_all_die
  self.v_uiobjects.Relive:SetActive(is_reborn)
  local currency_obj = self.v_uiobjects.CurrencyObj
  if not is_reborn then
    currency_obj:SetActive(false)
    return
  end
  local point_id = self.v_fight_info.point_id
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  if not point_cfg.RebornId then
    self.v_uiobjects.Relive:SetActive(false)
    currency_obj:SetActive(false)
    return
  end
  local icon_path, reborn_cost_num, reborn_cost_id = TowerMgr:get_reborn_cost()
  ResMgr:load_set_icon(self.v_uicompents.CostIcon_img, icon_path)
  self.v_uicompents.CostNum_txt.text = reborn_cost_num
  local has_lab = self:get_text("Text1", currency_obj)
  has_lab.text = BagMgr:get_item_num(reborn_cost_id)
end

function ui:click_reborn_btn()
  local _, reborn_cost_num, reborn_cost_id = TowerMgr:get_reborn_cost()
  
  local function callback1()
    self:requese_reborn()
  end
  
  local item_cfg = ShareRes.create("item.item", reborn_cost_id)
  local item_tip = reborn_cost_num .. item_cfg.Name
  local stip = Util.format_str("是否使用{1}，进行复活", item_tip)
  UIMgr:get_ui("uinotice_tips"):ui_show(callback1, nil, stip)
end

function ui:click_archieve_born_btn()
  local function callback()
    self:ui_hide()
  end
  
  ChapterMgr:request_archieve_reborn_all(callback)
end

function ui:click_confirm_btn()
  if NOT_PROGRESS_BATTLE_TYPE[self.v_fight_type] and self.v_state ~= CHAPTER_CONFIG.POINTSTATE.complete then
    UIMgr:get_ui("not_progress_battle_def_settle"):ui_show()
  else
    local function callback()
      Global.scene_mgr:on_enter_main_scene()
      
      UIMgr:revert_cache_ui()
    end
    
    if SceneMgr:check_main_scene() then
      self:ui_hide()
    end
    if self.v_is_get_award then
      callback()
    else
      TowerMgr:get_fight_reward(callback)
    end
  end
end

function ui:requese_reborn()
  local _, reborn_cost_num, reborn_cost_id = TowerMgr:get_reborn_cost()
  local cur_num = BagMgr:get_item_num(reborn_cost_id)
  if reborn_cost_num > cur_num then
    Util.show_message_tip(2115)
    return
  end
  ChapterMgr:request_reborn_all()
  self:ui_hide()
end

function ui:update_reward_list()
  self:give_back_auto_cache(CR_REWARD_ITEM_KEY)
  local reward_list
  if self.v_all_die and self.v_fight_type == CommonDef.CHALLENGE_TYPE.CHALLENGE_RING then
    reward_list = self.v_award_list
  else
    local award_list = TowerMgr:get_fight_reward_list()
    if (not award_list or next(award_list) == nil) and self.v_award_list then
      reward_list = self.v_award_list
    end
  end
  if not reward_list then
    self.v_uiobjects.NoRewadLab:SetActive(true)
    self.v_uiobjects.ScrollView:SetActive(false)
    return
  end
  local exchange_cfg_list = ShareRes.create("battle.battle_item_exchange")
  for _, cfg in pairs(exchange_cfg_list) do
    local count = FightBagMgr:get_item_num_by_id(cfg.Id)
    if count > 0 then
      local reward_item = {}
      reward_item.id = cfg.ExchangeId
      reward_item.count = count
      table.insert(reward_list, reward_item)
    end
  end
  table.sort(reward_list, function(a, b)
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
  local length = UtilTable.hash_lenth(reward_list)
  self.v_uiobjects.NoRewadLab:SetActive(length <= 0)
  self.v_uiobjects.ScrollView:SetActive(length > 0)
  if length <= 0 then
    return
  end
  local currency_add_list = ChapterMgr:get_currency_add_list()
  for _, reward in pairs(reward_list) do
    if currency_add_list and currency_add_list[reward.id] then
      reward.count = math.floor(reward.count * (1 + currency_add_list[reward.id] / 10000))
    end
    self:new_ui(reward.id, reward.count)
  end
end

function ui:new_ui(item_id, item_num)
  local award_ui = self:get_auto_cache(CR_REWARD_ITEM_KEY)
  local item_quality = Util.get_image("ItemQuality", award_ui)
  
  local function click_cb()
    UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
  end
  
  self:create_item_obj(nil, item_quality.gameObject, nil, {item_id = item_id, click_cb = click_cb})
  local item_txt = Util.get_text("ItemAmount/Bg/ItemNum", award_ui)
  item_txt.text = item_num
end

function ui:update_tower_info()
  local uiobj = self.v_uiobjects
  local uicom = self.v_uicompents
  uicom.StageText_txt.text = Util.format_str("层数")
  uicom.MaxRecordTail_txt.text = Util.format_str("层")
  uiobj.RoundObj:SetActive(false)
  uiobj.FloorObj:SetActive(true)
  uiobj.RoundNumObj:SetActive(false)
  local point_id = self.v_fight_info.point_id
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  local tower_name = point_cfg.PointName
  local ui_comment = self.v_uicompents
  ui_comment.StageName_txt.text = tower_name
  local pass_floor = TowerMgr:get_pass_floor()
  ui_comment.FloorNum_txt.text = pass_floor
  local progress = TowerMgr:get_tower_progress()
  local history_floor = progress and progress.old_max_floor or 0
  assert(history_floor, "NO History Record = ", self.v_fight_type)
  assert(pass_floor, "NO PassFloor Id = ", self.v_fight_type)
  self.v_uiobjects.NewRecord:SetActive(pass_floor > history_floor)
  ui_comment.MaxRecord_txt.text = history_floor
end

function ui:update_skill_teach_reward_content()
  if self.v_fight_type ~= CommonDef.CHALLENGE_TYPE.BUDDY_TEACH then
    return
  end
  if self.v_state ~= CHAPTER_CONFIG.POINTSTATE.complete then
    return
  end
  if self.v_all_die then
    self.v_uiobjects.NoRewadLab:SetActive(true)
    self.v_uiobjects.ScrollView:SetActive(false)
    return
  end
  local point_id = self.v_tower_info.episode_id
  local pos_data = FormationMgr:get_fight_team_data(nil, point_id).buddys
  assert(pos_data, "NO Formaiton Pos Data! ERROR = " .. self.v_formation_type)
  local buddy_id
  for i = 1, 3 do
    local data = pos_data[i]
    if data and 0 ~= data.buddy_id then
      buddy_id = data.buddy_id
      break
    end
  end
  self:give_back_auto_cache(CR_REWARD_ITEM_KEY)
  local reward_list = {}
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_fight_info.point_id)
  local has_pass = ActivityMgr:invoke(CommonDef.ACTY_TYPE.BUDDY_TEACH, "get_point_has_passed", buddy_id, self.v_fight_info.point_id)
  local first_award_id = has_pass and point_cfg.AwardId[2] or point_cfg.AwardId[1]
  if 0 ~= first_award_id then
    local first_award = ShareRes.get_award_item_data(first_award_id)
    for _, data in ipairs(first_award) do
      table.insert(reward_list, {
        id = data[1],
        count = data[2]
      })
    end
  end
  for _, reward in pairs(reward_list) do
    self:new_ui(reward.id, reward.count)
  end
  self.v_no_reward:SetActive(0 == #reward_list)
end

return ui
