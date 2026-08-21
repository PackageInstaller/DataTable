local Base = require("ui.uibase")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local CommonDef = require("cs_share.common_define")
local POINT_INFO_CLASS = require("uimodule.chapter.point_info_common")
local OnlineConfig = require("gamelogic.activity.online_config")
local OnlineHelper = require("uimodule.stage_activity.online_battle.online_battle_helper")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Act_ID = CommonDef.ACTY_TYPE.ONLINE_BATTLE
local MODEL = {
  v_award_content = {
    "AwardContent",
    BIND_TYPE.OBJECT
  },
  v_award_item = {
    "AwardItem",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnRet", function()
    self:_onclick_close_btn()
  end)
  self:set_button("BtnMatch", function()
    self:_onclick_start_match_btn()
  end)
  self:set_button("BtnCreateRoom", function()
    self:_onclick_create_room_btn()
  end)
  self:set_button("BtnStrength", function()
    UIMgr:get_ui("uiforcerecharg"):ui_show()
  end)
  self.template_key = "AWARD_KEY_ITEM" .. self:ui_get_name()
  self:register_exist_auto_template(self.template_key, self.v_award_item, self.v_award_content)
end

function ui:ui_on_show(point_id)
  self.v_point_id = point_id
  self.v_point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  self.v_detail_cfg = ShareRes.get_chapter_point_details_cfg(self.v_point_cfg.PointDetail)
  self:init_point_info()
  self:_refresh_point_detail()
  self:_refresh_cost_info()
  self:_refresh_drop_award()
  self:_regist_client_event()
end

function ui:ui_on_hide()
  self:release_point_info_obj()
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

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ROLE_RES_CHANGE, self._refresh_cost_info, self)
  self:bind_auto_mq(Const.MSG_ON_QUIT_MATCH_QUEUE, self._refresh_point_detail, self)
end

function ui:init_point_info()
  self:release_point_info_obj()
  if self.v_point_cfg.PointDesc ~= nil then
    return
  end
  local path = Path.get_language_full_prefab_path(CHAPTER_CONFIG.POINT_INFO_RES_PATH)
  local point_info_obj = ResMgr:load_gameobj(path)
  point_info_obj.transform:SetParent(self.v_uiobjects.InfoParent.transform, false)
  self.v_point_info_obj = point_info_obj
  self.v_point_info_lua_obj = POINT_INFO_CLASS:ui_wrap_ex(self, point_info_obj, false)
  self.v_point_info_lua_obj:set_enable(true, nil, self.v_point_id)
end

function ui:_refresh_point_detail()
  local bg_path = self.v_point_cfg.BgPath
  ResMgr:load_set_icon(self.v_uicompents.Title_img, bg_path, nil, true)
  self.v_uicompents.SiName_txt.text = self.v_point_cfg.PointName
  local wait_match = ActivityMgr:invoke(Act_ID, "get_cur_match_point") == self.v_point_id
  self.v_uiobjects.NormalState:SetActive(not wait_match)
  self.v_uiobjects.MatchingState:SetActive(wait_match)
end

function ui:_refresh_cost_info()
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  local has_pass = ActivityMgr:invoke(Act_ID, "get_has_pass_point", self.v_point_id)
  local cost_val = false == has_pass and point_cfg.FightCost[1] or point_cfg.FightCost[2]
  self.v_uicompents.CreateNeed_txt.text = cost_val
  self.v_uicompents.MatchNeed_txt.text = cost_val
  local has = BagMgr:get_item_num(Config.PLAYER_SP_ITEMID)
  self.v_uicompents.ForceAmount_txt.text = has
  self.v_uicompents.ForceMax_txt.text = CharacterMgr:get_res_force_max_val()
  self.v_money_enough = cost_val <= has
end

function ui:_refresh_drop_award()
  self:give_back_auto_cache(self.template_key)
  local has_reward = false
  local has_pass = ActivityMgr:invoke(Act_ID, "get_has_pass_point", self.v_point_id)
  local award_id = has_pass and self.v_point_cfg.AwardId[2] or self.v_point_cfg.AwardId[1]
  if award_id > 0 then
    for _, data in ipairs(ShareRes.get_award_item_data(award_id)) do
      local award_ui = self:get_auto_cache(self.template_key)
      self:update_item_info(award_ui, data[1], data[2], true)
      has_reward = true
    end
  end
  local many_award_list = self.v_point_cfg.ShowRewardList
  for _, item_id in ipairs(many_award_list) do
    local award = ShareRes.get_award_item_data(item_id)
    if award then
      for _, data in ipairs(award) do
        local award_ui = self:get_auto_cache(self.template_key)
        self:update_item_info(award_ui, data[1], data[2], false)
      end
      has_reward = true
    else
      Log.Error("read award failure, award_id=", item_id)
    end
  end
  self.v_uiobjects.NoRewardDesc:SetActive(not has_reward)
end

function ui:update_item_info(award_ui, item_id, num, is_first)
  local first_img = Util.get_image("FirstGet", award_ui.transform)
  first_img.gameObject:SetActive(is_first)
  local award_num = Util.get_text("SiItemAmount", award_ui.transform)
  award_num.text = 0 ~= num and num or ""
  local num_bg = Util.get_image("AmoBg", award_ui.transform)
  num_bg.gameObject:SetActive(0 ~= num)
  self:set_award_icon(item_id, award_ui)
  self:set_button_listener(Util.get_button(nil, award_ui), function()
    UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
  end)
end

function ui:set_award_icon(item_id, award_ui)
  local quality_img = Util.get_image("Quality", award_ui.transform)
  Util.load_quality_icon(item_id, quality_img.gameObject)
  local obj = self:create_item_obj(nil, quality_img.gameObject, nil, {item_id = item_id})
  local button = Util.get_button(nil, obj.v_object)
  if button then
    button.enabled = false
  end
end

function ui:_onclick_close_btn()
  self:ui_hide()
end

function ui:_onclick_start_match_btn()
  if not self.v_money_enough then
    Util.show_message_tip(2216)
    return
  end
  
  local function return_cb()
    self.v_uiobjects.NormalState:SetActive(false)
    self.v_uiobjects.MatchingState:SetActive(true)
    UIMgr:get_ui("online_battle_match_tips"):ui_show(OnlineConfig.Quick_TIPS_TYPE.MATCH)
  end
  
  local function match_cb()
    ActivityMgr:invoke(Act_ID, "request_join_match", self.v_point_id, return_cb)
  end
  
  local wait_match = ActivityMgr:invoke(Act_ID, "get_in_matching")
  if wait_match then
    local match_op = ActivityMgr:invoke(Act_ID, "get_cur_match_point") == self.v_point_id and OnlineConfig.MATCH_OPERATE.BREAK or OnlineConfig.MATCH_OPERATE.RESTART
    local cb
    if match_op == OnlineConfig.MATCH_OPERATE.RESTART then
      cb = match_cb
    end
    OnlineHelper.quit_match(self, cb, match_op)
    return
  end
  match_cb()
end

function ui:_onclick_create_room_btn()
  if not self.v_money_enough then
    Util.show_message_tip(2216)
    return
  end
  
  local function cb()
    UIMgr:get_ui("online_create_room_tips"):ui_show(self.v_point_id)
  end
  
  local wait_match = ActivityMgr:invoke(Act_ID, "get_in_matching")
  if wait_match then
    OnlineHelper.quit_match(self, cb)
    return
  end
  cb()
end

return ui
