local Base = require("ui.uibase")
local CommonDef = require("cs_share.common_define")
local POINT_INFO_CLASS = require("uimodule.chapter.point_info_common")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local ui = Util.create_child_mt(Base)
local TOP_VER_STAGE_INFO_ITEM = "TOP_VER_STAGE_INFO_ITEM"
local TopVersionMgr = ActivityMgr
local Act_ID = CommonDef.ACTY_TYPE.BEST_CONFIG_FIGHT
local CHAL_TYPE2FORMN_TYPE = CommonDef.CHAL_TYPE2FORMN_TYPE
local CHALLENGE_TYPE = CommonDef.CHALLENGE_TYPE

function ui:ui_finish_load()
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button("BtnStart", function()
    self:_onclick_fight()
  end)
  self.v_team_list = {}
  for i = 1, 3 do
    self.v_team_list[i] = self.v_uiobjects["position" .. i]
  end
  self:register_exist_auto_template(TOP_VER_STAGE_INFO_ITEM, self.v_uiobjects.InfoTem, self.v_uiobjects.InfoList)
end

function ui:ui_on_show(data, ...)
  self.v_stage_cfg = data
  self.v_fight_type = CHALLENGE_TYPE.BEST_CONF
  self.v_formation_type = CHAL_TYPE2FORMN_TYPE[self.v_fight_type]
  self.v_point_cfg = ShareRes.get_chapter_point_cfg(self.v_stage_cfg.Id)
  self.v_detail_cfg = ShareRes.get_chapter_point_details_cfg(self.v_point_cfg.PointDetail)
  TopVersionMgr:invoke(Act_ID, "request_get_best_conf_skill", self.v_stage_cfg.Id)
  self.v_fight_num = 0
  self:init_point_info()
  self:_refresh_team_list()
  self:_refresh_stage_info()
  self:_regist_client_event()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_HERO_SKILL_UPDATE, self._refresh_team_list, self)
  self:bind_auto_mq(Const.MSG_ON_CHANGE_FORMATION_BUDDY_ID, self._response_hero_change_event, self)
end

function ui:_response_hero_change_event(msg)
  self:_set_team_info(msg.mm_x, {
    [msg.mm_x] = {
      pos = msg.mm_x,
      buddy_id = msg.mm_y
    }
  })
  if msg.mm_y > 0 then
    UIMgr:get_ui("top_ver_prepare"):ui_show(self.v_stage_cfg.Id, msg.mm_y, msg.mm_x)
  end
  FormationMgr:send_change_formation_info(self.v_formation_type, nil, nil, self.v_fight_type)
end

function ui:ui_on_hide()
  self:release_point_info_obj()
  FormationMgr:send_change_formation_info(self.v_formation_type, nil, nil, self.v_fight_type)
end

function ui:_refresh_team_list()
  local use_team_id = FormationMgr:get_formation_use_id(self.v_formation_type, self.v_fight_type)
  local cur_fight_pos, team_list = FormationMgr:get_formation_info_by_id(self.v_formation_type, use_team_id, self.v_fight_type)
  local tb = {}
  if team_list then
    for _, team in pairs(team_list) do
      tb[team.pos] = team
    end
  end
  for i = 1, 3 do
    self:_set_team_info(i, tb)
  end
end

function ui:_set_team_info(idx, team_list)
  local item = self.v_team_list[idx]
  local team_info = team_list[idx]
  local has_hero = team_info and team_info.buddy_id > 0
  local info_bg = self:get_child_gameobj("Info", item)
  local add_btn = self:get_button("AddIcon", item)
  local lock = self:get_child_gameobj("Lock", item)
  local has_lock = self.v_point_cfg.MaxFightCount and idx > self.v_point_cfg.MaxFightCount
  lock:SetActive(has_lock)
  info_bg:SetActive(not has_lock)
  add_btn:SetActive(not has_lock)
  local use_team_id = FormationMgr:get_formation_use_id(self.v_formation_type, self.v_fight_type)
  local cur_fight_pos, team_data = FormationMgr:get_formation_info_by_id(self.v_formation_type, use_team_id, self.v_fight_type)
  local buddy_id = team_info and team_info.buddy_id or 0
  if has_lock then
    buddy_id = 0
  end
  local first_fight_pos = 0
  for i, v in ipairs(team_data) do
    if v.pos == idx then
      first_fight_pos = has_hero and idx or 0
    elseif v.buddy_id > 0 then
      first_fight_pos = i
    end
    if first_fight_pos > 0 then
      break
    end
  end
  FormationMgr:change_formation_info(self.v_formation_type, use_team_id, first_fight_pos, idx, buddy_id)
  if has_lock then
    return
  end
  self:set_button_listener(add_btn, function()
    local select_buddy_id = self:get_select_buddy_id(idx)
    if not select_buddy_id then
      local cur_id = FormationMgr:get_formation_use_id(self.v_formation_type, self.v_fight_type)
      local param_info = {
        select_pos = idx,
        formation_type = self.v_formation_type,
        select_team_id = use_team_id,
        select_buddy_id = select_buddy_id,
        pos_data = team_data,
        point_id = self.v_stage_cfg.Id,
        use_fixed_char_pool = false
      }
      UIMgr:get_ui("character_enter"):ui_show(param_info)
    end
  end)
  add_btn:SetActive(not has_hero)
  info_bg:SetActive(has_hero)
  local skill_list = {}
  for i = 1, 5 do
    local skill_item = self:get_child_gameobj("SkillList/Content/SkillTem" .. i, info_bg)
    skill_list[i] = skill_item
    skill_item:SetActive(false)
  end
  local btn = self:get_button(nil, info_bg)
  self:set_button_listener(btn, function()
    local select_buddy_id = self:get_select_buddy_id(idx)
    UIMgr:get_ui("top_ver_prepare"):ui_show(self.v_stage_cfg.Id, select_buddy_id, idx)
  end)
  if not has_hero then
    return
  end
  local skill_info = TopVersionMgr:invoke(Act_ID, "get_hero_skill_list", self.v_stage_cfg.Id, buddy_id)
  local num = 0
  for _, v in pairs(skill_info) do
    num = num + 1
    if skill_list[num] then
      skill_list[num]:SetActive(true)
      local skill_cfg = ShareRes.create("battle.battle_skill", v)
      local skill_icon = self:get_image("Icon", skill_list[num])
      ResMgr:load_set_icon(skill_icon, string.format("Skill/%s", skill_cfg.Icon))
    else
      Log.Error("角色buddy_id=", buddy_id, "关卡self.v_stage_cfg.Id=", self.v_stage_cfg.Id, "skill_info", skill_info)
    end
  end
  local point = self:get_text("Point", info_bg)
  point.text = TopVersionMgr:invoke(Act_ID, "get_remain_skill_point", self.v_stage_cfg.Id, idx, buddy_id)
  local icon = self:get_image("CharIconMask/CharIcon", info_bg)
  local img = UtilUI.get_hero_images(buddy_id, Config.HERO_ICON_LV.HALF_IMG)
  ResMgr:load_set_icon(icon, img, nil, true, self)
  self.v_fight_num = self.v_fight_num + 1
end

function ui:get_select_buddy_id(pos)
  local cur_id = FormationMgr:get_formation_use_id(self.v_formation_type, self.v_fight_type)
  local starting_pos, pos_data = FormationMgr:get_formation_info_by_id(self.v_formation_type, cur_id, self.v_fight_type)
  for _, slot in pairs(pos_data) do
    if slot.pos == pos and 0 ~= slot.buddy_id then
      return slot.buddy_id
    end
  end
end

function ui:_refresh_stage_info()
  self:give_back_auto_cache(TOP_VER_STAGE_INFO_ITEM, false)
  for i, v in ipairs(self.v_detail_cfg.ElementId) do
    if v > 0 then
      local obj = self:get_auto_cache(TOP_VER_STAGE_INFO_ITEM)
      local cfg = ShareRes.create("chapter.chapter_attr", v)
      local desc = self:get_text("Text", obj)
      desc.text = cfg.Desc
    end
  end
  self.v_uicompents.Time_txt.text = Util.format_str("{1}分钟", self.v_stage_cfg.Duration)
  local cost_val = self.v_point_cfg.FightCost[1]
  self.v_uicompents.ItemAmount_txt.text = cost_val
end

function ui:_onclick_fight()
  if Global.cs_lock_enter_tower then
    return
  end
  local cost_val = self.v_point_cfg.FightCost[1]
  if cost_val > BagMgr:get_item_num(Config.PLAYER_SP_ITEMID) then
    local cfg = ShareRes.create("item.item", Config.PLAYER_SP_ITEMID)
    local str = Util.format_str("{1}达到{2}可进入战斗", cfg.Name, cost_val)
    UIMgr:get_ui("uimessagetip"):ui_show(str)
    return
  end
  local min_fight_num = self.v_point_cfg.MinFightCount
  if self.v_fight_num < self.v_point_cfg.MinFightCount then
    Util.show_message_tip(2318, min_fight_num)
    return
  end
  FormationMgr:send_change_formation_info(self.v_formation_type, nil, nil, self.v_fight_type)
  TowerMgr:on_new_enter_tower(CommonDef.CHALLENGE_TYPE.BEST_CONF, self.v_stage_cfg.Id)
end

function ui:release_point_info_obj()
  if self.v_point_info_obj then
    ResMgr:destroy_gameobj(self.v_point_info_obj)
    self.v_point_info_obj = nil
  end
  if self.v_point_info_lua_obj then
    self.v_point_info_lua_obj:set_enable(false)
    self:remove_wrap_ui(self.v_point_info_lua_obj)
  end
end

function ui:init_point_info()
  self:release_point_info_obj()
  local path = Path.get_language_full_prefab_path(CHAPTER_CONFIG.POINT_INFO_RES_PATH)
  local point_info_obj = ResMgr:load_gameobj(path)
  point_info_obj.transform:SetParent(self.v_uiobjects.InfoParent.transform, false)
  self.v_point_info_obj = point_info_obj
  self.v_point_info_lua_obj = POINT_INFO_CLASS:ui_wrap_ex(self, point_info_obj, false)
  self.v_point_info_lua_obj:set_enable(true, nil, self.v_stage_cfg.Id)
  self.v_point_info_lua_obj:update_info_btn_visible(true)
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_stage_cfg
end

return ui
