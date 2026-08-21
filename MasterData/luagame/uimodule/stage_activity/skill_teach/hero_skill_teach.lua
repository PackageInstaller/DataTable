local Base = require("ui.uibase")
local commonDef = require("cs_share.common_define")
local Act_ID = commonDef.ACTY_TYPE.BUDDY_TEACH
local M = Util.create_child_mt(Base)

function M:ui_finish_load()
  self.v_template_key = {
    hero_item = "hero_item" .. self:ui_get_name()
  }
  self:register_exist_auto_template(self.v_template_key.hero_item, self.v_uiobjects.Stage, self.v_uiobjects.Content)
  self:set_button("BtnRet", function()
    self:ui_hide()
  end)
  self.v_content_rect = self.v_uicompents.Content_rect
  local scroll_rect = self.v_uiobjects.StageList:GetComponent(typeof(UnityEngine.UI.ScrollRect))
  self:set_scrollrect_listener(scroll_rect, function()
    local width = self.v_content_rect:GetSizeDeltaA()
    local pos = self.v_content_rect.anchoredPosition.x
    self.v_uiobjects.ScrollTip:SetActiveEx(width + pos > 100)
  end)
end

function M:ui_on_show()
  self:_refresh_hero_list()
end

function M:ui_on_hide()
end

function M:_refresh_hero_list()
  local all_buddy_cfg = ShareRes.create("activity.buddy_teach_episode_key")
  local tb = {}
  for _, teach_cfg in pairs(all_buddy_cfg) do
    local buddy_id = teach_cfg.BuddyID
    if not buddy_id or ShareRes.get_buddy_is_show(buddy_id) and CharacterMgr:check_buddy_release(buddy_id) then
      table.insert(tb, teach_cfg)
    end
  end
  table.sort(tb, function(a, b)
    local com_teach_a = a.BuddyID and 0 or 1
    local com_teach_b = b.BuddyID and 0 or 1
    local has_a = ActivityMgr:invoke(Act_ID, "get_open_teach_point", a.BuddyID) and 1 or 0
    local has_b = ActivityMgr:invoke(Act_ID, "get_open_teach_point", b.BuddyID) and 1 or 0
    local cfg_a = ShareRes.get_buddy_teach_cfg_by_point_id(a.EpisodeId)
    local cfg_b = ShareRes.get_buddy_teach_cfg_by_point_id(b.EpisodeId)
    if com_teach_a ~= com_teach_b then
      return com_teach_a > com_teach_b
    elseif has_a ~= has_b then
      return has_a > has_b
    elseif cfg_a.Sort ~= cfg_b.Sort then
      return cfg_a.Sort > cfg_b.Sort
    elseif a.Id ~= b.Id then
      return a.Id > b.Id
    else
      return false
    end
  end)
  self:give_back_auto_cache(self.v_template_key.hero_item, false)
  for i, v in ipairs(tb) do
    local item = self:get_auto_cache(self.v_template_key.hero_item)
    self:_set_hero_data(item, v)
  end
end

function M:_get_has_hero(buddy_id)
  return CharacterMgr:get_buddy_by_id(buddy_id) or ActivityMgr:invoke(Act_ID, "get_open_teach_point", buddy_id)
end

function M:_set_hero_data(item, data)
  local hero_name = self:get_text("HeroName", item)
  local img = self:get_image("HeroIconMask/HeroIcon", item)
  local is_real_has, has_buddy, progress_value
  local icon = data.HeroIcon
  if data.BuddyID then
    is_real_has = CharacterMgr:get_buddy_by_id(data.BuddyID) ~= nil
    icon = icon or UtilUI.get_hero_images(data.BuddyID, Config.HERO_ICON_LV.HD_FULL_IMG)
    has_buddy = ActivityMgr:invoke(Act_ID, "get_open_teach_point", data.BuddyID)
    progress_value = ActivityMgr:invoke(Act_ID, "get_teach_progress", data.BuddyID)
  else
    if not icon then
      Log.Error("获取立绘失败，请检查角色教学副本表ID：", data.Id)
      return
    end
    is_real_has = false
    has_buddy = true
    progress_value = ActivityMgr:invoke(Act_ID, "get_teach_progress", data.EpisodeId)
  end
  hero_name.text = data.StageName
  ResMgr:load_set_icon(img, icon, nil, true, self)
  local stage_cfg = ShareRes.get_buddy_teach_cfg_by_point_id(data.EpisodeId)
  local canvas_group = self:get_canvas_group(nil, item)
  local bg = self:get_image("StageBg", item)
  if stage_cfg.Hero_Bg then
    ResMgr:load_set_icon(bg, string.format("UIHeroTeaching/%s", stage_cfg.Hero_Bg), nil, true, self)
  end
  if stage_cfg.Bg_Pos then
    local img_rect = self:get_rect_transform(nil, img.gameObject)
    img_rect:SetAnchoredPositionA(stage_cfg.Bg_Pos[1], stage_cfg.Bg_Pos[2], stage_cfg.Bg_Pos[3])
  end
  local lock = self:get_child_gameobj("Lock", item)
  lock:SetActive(not has_buddy)
  canvas_group.alpha = has_buddy and 1 or 0.9
  Util.apply_grey_ex(item.gameObject, not has_buddy)
  local trial_tips = self:get_child_gameobj("TrialTips_", item)
  trial_tips:SetActive(not is_real_has and has_buddy and data.BuddyID ~= nil)
  local stage = self:get_text("StageName", item)
  stage.text = stage_cfg.StageName
  local progress = self:get_text("Completion", item)
  local complete_tag = self:get_child_gameobj("Complete", item)
  local pro = progress_value .. "%"
  progress.text = Util.format_str("完成度：<color=#f5ede2>{1}</color>", pro)
  complete_tag:SetActive(100 == progress_value)
  for i = 1, 5 do
    local star = self:get_child_gameobj(string.format("Hard/HardIcon%d/Lightup%d", i, i), item)
    star:SetActive(i <= stage_cfg.Difficulty)
  end
  local btn = self:get_button(nil, item)
  self:set_button_listener(btn, function()
    if not has_buddy then
      Util.show_message_tip(stage_cfg.Lock_Notice)
      return
    end
    UIMgr:get_ui("teach_chapter_point"):ui_show(data.EpisodeId)
  end)
end

function M:cache_ui()
  return true
end

return M
