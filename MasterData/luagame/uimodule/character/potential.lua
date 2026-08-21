local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Timer = Global.timer
local _min = math.min
local _tinsert = table.insert
local _sformat = string.format
local dotween = CS.DG.Tweening.DOTweenAnimation
local VerticalLayoutGroup = UnityEngine.UI.VerticalLayoutGroup
local SKILL_CONTENT_ITEM = "SKILL_CONTENT_ITEM"
local Prop_Name_To_Show_Name = {
  hp = "血量",
  sparmor = "霸体值",
  energy = "能量",
  cvenergy = "能量恢复",
  exenergy = "大招能量",
  cvexenergy = "大招能量恢复",
  attack = "物理攻击",
  beacon_level = "信标等级",
  penetrate = "穿防",
  defense = "防御"
}
local UNLOCK_COLOR = Util.get_unity_color_by_hex(tonumber("FFFFFF", 16))
local LOCK_COLOR = Util.get_unity_color_by_hex(tonumber("858585", 16))
local LV_COLOR = Util.get_unity_color_by_hex(tonumber("FFDA9D", 16))
local MODEL = {
  v_advance_btn = {
    "AdvanceBtn",
    BIND_TYPE.BUTTON
  },
  v_advance_cost = {
    "AdvanceCost",
    BIND_TYPE.OBJECT
  },
  v_advance_icon = {
    "AdvanceIcon",
    BIND_TYPE.IMAGE
  },
  v_cost_item = {
    "CostItem",
    BIND_TYPE.BUTTON
  },
  v_down = {
    "Down",
    BIND_TYPE.OBJECT
  },
  v_img_no = {
    "ImgNo",
    BIND_TYPE.IMAGE
  },
  v_img_sure = {
    "ImgSure",
    BIND_TYPE.IMAGE
  },
  v_skill_content = {
    "SkillContent",
    BIND_TYPE.OBJECT
  },
  v_temp = {
    "Temp",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("AdvanceBtn", function()
    if self.v_is_play_eff or not self:check_advance() then
      return
    end
    Global.sound_mgr:play_lvup_sound()
    local is_show_lv_up = self:check_show_lv_up()
    
    local function callback()
      if self.v_forcus_lvup_ani then
        self.v_forcus_lvup_ani:SetActive(true)
      end
      self:play_up_lv_effect(is_show_lv_up)
      Util.show_message_tip(2141)
    end
    
    CharacterMgr:char_advance(self.v_buddy_info.id, callback)
  end)
  self:set_button("CostItem", function()
    if not self.v_cost_id then
      return
    end
    Util.show_item_tip(self.v_cost_id)
  end)
  self.v_advance_btn_canvasgroup = self.v_advance_btn.gameObject:GetComponent("CanvasGroup")
  self.v_page_tween = self.v_object:GetComponent(typeof(dotween))
  self:register_exist_auto_template(SKILL_CONTENT_ITEM, self.v_temp, self.v_skill_content)
  self.v_max_eff_obj = Util.get_child_gameobj("Title/AdvanceIcon_bg/Fx_UI_Qianneng_Loop", self.v_object)
end

function ui:play_up_lv_effect(is_show_lv_up)
  self.v_is_play_eff = true
  for _, eff in pairs(self.v_ui_effect) do
    eff.lv_up:SetActive(false)
    eff.max_lv_up:SetActive(false)
  end
  for i = 1, 6 do
    self.v_uiobjects["Ring_" .. i]:SetActive(false)
  end
  if self.v_role_next_lv_is_max then
    self.v_ui_effect[self.v_cur_unlock_node].max_lv_up:SetActive(true)
  else
    self.v_ui_effect[self.v_cur_unlock_node].lv_up:SetActive(true)
  end
  local eff_ring = self.v_uiobjects["Ring_" .. self.v_role_cur_lv - 1]
  if eff_ring then
    eff_ring:SetActive(true)
  end
  self.v_timer_idx = Timer:add_timer("potential:play_up_lv_effect", 0.7, function()
    if is_show_lv_up then
      UIMgr:get_ui("char_advance_suc_pnl"):ui_show(self.v_buddy_info.id)
    end
    self:update_info()
  end)
end

function ui:check_advance()
  if self.v_arrive_max_lv then
    return
  end
  local advance_cfg = self.v_next_lv_cfg
  local cost_id = advance_cfg.CostId
  local cost_num = advance_cfg.CostCnt
  local cur_item_num = BagMgr:get_item_num(cost_id)
  if cost_num > cur_item_num then
    Util.show_message_tip(2115)
    return false
  end
  return true
end

function ui:check_show_lv_up()
  return self.v_can_play_lv_eff
end

function ui:ui_on_show()
  self.v_page_tween:DORewind()
  self.v_page_tween:DOPlay()
  self:bind_auto_mq(Const.MSG_ON_BUDDY_TO_ADVANCE_ITEM, self._on_item_update, self)
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self._on_item_update, self)
  self.v_uicompents.SkillContent_rect:SetAnchoredPositionA(0, 0, 0)
  self.v_first_show = true
end

function ui:refresh(buddy_id)
  self.v_buddy_id = buddy_id
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  if not buddy_info then
    return
  end
  self:update_info()
end

function ui:update_info()
  self.v_buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  self:update_cur_cfg()
  self:update_fun()
  self.v_is_play_eff = false
end

function ui:update_cur_cfg()
  local advance_skill_cfg = ShareRes.create("buddy.buddy_advance", self.v_buddy_info.id)
  self.v_role_cur_lv = self.v_buddy_info.advance
  self.v_role_next_lv = self.v_role_cur_lv + 1
  self.v_role_next_lv_is_max = advance_skill_cfg[self.v_role_next_lv + 1] == nil
  self.v_next_lv_cfg = advance_skill_cfg[self.v_role_next_lv]
  self.v_arrive_max_lv = false
  if self.v_next_lv_cfg then
    local cur_show_lv = advance_skill_cfg[self.v_role_cur_lv].ShowLv
    local next_show_lv = advance_skill_cfg[self.v_role_next_lv].ShowLv
    if cur_show_lv < next_show_lv then
      self.v_can_play_lv_eff = true
    else
      self.v_can_play_lv_eff = false
    end
  else
    self.v_arrive_max_lv = true
  end
  self.v_role_lv_cfg = {}
  self.v_first_lock_node = nil
  self.v_cur_unlock_node = 1
  local str_unlock = "<color=#FFFFFF>%s</color>"
  local str_lock = "<color=#858585>%s</color>"
  local skill_up = Util.get_i18n("技能等级") .. " +%s"
  for _, lv_cfg in ipairs(advance_skill_cfg) do
    local index = lv_cfg.ShowLv
    self.v_role_lv_cfg[index] = self.v_role_lv_cfg[index] or {
      lv_num = index,
      lv_name = lv_cfg.SkillName,
      is_lock = false,
      desc = nil,
      color = LOCK_COLOR,
      lv_color = LOCK_COLOR
    }
    local skill_desc = ""
    if lv_cfg.SkillDesc and "" ~= lv_cfg.SkillDesc then
      skill_desc = lv_cfg.SkillDesc
    elseif lv_cfg.UpSkillLv > 0 then
      skill_desc = _sformat(skill_up, lv_cfg.UpSkillLv)
    else
      local add_value = 0
      skill_desc, add_value = self:get_prop_desc(lv_cfg.Lv)
      if add_value > 0 then
        skill_desc = Util.get_i18n(skill_desc) .. " +" .. add_value
      end
    end
    if lv_cfg.Lv <= self.v_role_cur_lv then
      skill_desc = _sformat(str_unlock, skill_desc)
      self.v_role_lv_cfg[index].is_lock = true
      self.v_role_lv_cfg[index].color = UNLOCK_COLOR
      self.v_role_lv_cfg[index].lv_color = LV_COLOR
      self.v_cur_unlock_node = index
    else
      self.v_first_lock_node = self.v_first_lock_node or index
      skill_desc = _sformat(str_lock, skill_desc)
    end
    if self.v_role_lv_cfg[index].desc then
      self.v_role_lv_cfg[index].desc = self.v_role_lv_cfg[index].desc .. "\n" .. skill_desc
    else
      self.v_role_lv_cfg[index].desc = skill_desc
    end
  end
  self.v_first_lock_node = self.v_first_lock_node or 1
end

function ui:get_prop_desc(lv)
  local cfg = ShareRes.create("buddy.buddy_upgrade_advance_attr", self.v_buddy_info.id)[lv]
  for prop_name, _ in pairs(Prop_Name_To_Show_Name) do
    if cfg[prop_name] > 0 then
      return Prop_Name_To_Show_Name[prop_name], cfg[prop_name]
    end
  end
  return "", 0
end

function ui:update_fun()
  self:update_skill_title()
  self:update_skill_content()
  if not self.v_is_other_player then
    self:update_cost_info()
  end
end

function ui:_on_item_update()
  if not self.v_is_other_player then
    self:update_cost_info()
  end
end

function ui:update_skill_title()
  local advance_icon_cfg = ShareRes.create("buddy.buddy_advance_icon", self.v_role_cur_lv)
  local icon_name = advance_icon_cfg.AdvacneAfter
  local icon_path = string.format("%s", icon_name)
  ResMgr:load_set_icon(self.v_advance_icon, icon_path, nil, true)
end

function ui:update_skill_content()
  self.v_uicompents.AdvanceLv_txt.text = self.v_cur_unlock_node - 1
  self.v_uiobjects.AdvanceLvNode:SetActive(0 ~= self.v_cur_unlock_node - 1)
  self:give_back_auto_cache(SKILL_CONTENT_ITEM)
  self.v_ui_effect = {}
  self.v_skill_content_obj = {}
  self.v_max_eff_obj:SetActive(false)
  if self.v_arrive_max_lv then
    self.v_max_eff_obj:SetActive(true)
  end
  for index, cfg in ipairs(self.v_role_lv_cfg) do
    if index > 1 then
      local ui = self:get_auto_cache(SKILL_CONTENT_ITEM)
      local Arrow = Util.get_child_gameobj("Arrow", ui)
      local LvText = Util.get_text("Text", ui)
      local Desc = Util.get_text("Desc", ui)
      local LvNum = Util.get_text("LvNum", ui)
      local LvName = Util.get_text("LvName", ui)
      self.v_ui_effect[index - 1] = {max_lv_up = nil, lv_up = nil}
      self.v_ui_effect[index - 1].max_lv_up = Util.get_child_gameobj("Animation/Ani_QiannengPanel1_Max", ui)
      self.v_ui_effect[index - 1].lv_up = Util.get_child_gameobj("Animation/Ani_QiannengPanel1_Up", ui)
      Arrow:SetActive(index == self.v_first_lock_node)
      Desc.text = cfg.desc
      LvNum.text = cfg.lv_num - 1
      LvName.text = cfg.lv_name
      LvNum.color = cfg.lv_color
      LvName.color = cfg.lv_color
      LvText.color = cfg.lv_color
      _tinsert(self.v_skill_content_obj, Util.get_rect_transform(nil, ui))
    end
  end
  if self.v_updatepos_timer then
    Timer:remove_timer(self.v_updatepos_timer)
    self.v_updatepos_timer = nil
  end
  if self.v_first_show then
    self.v_updatepos_timer = Timer:add_timer("potential:update_skillcontent_pos", 0.1, function()
      self:update_skillcontent_pos(self.v_role_cur_lv)
    end)
    self.v_first_show = nil
  else
    self:update_skillcontent_pos(self.v_role_cur_lv)
  end
end

function ui:update_cost_info()
  if self.v_arrive_max_lv then
    self.v_down:SetActive(false)
    return
  end
  self.v_down:SetActive(true)
  local advance_skill_cfg = ShareRes.create("buddy.buddy_advance", self.v_buddy_info.id)
  local advance_cfg = advance_skill_cfg[self.v_role_next_lv]
  local cost_id = advance_cfg.CostId
  local cost_num = advance_cfg.CostCnt
  local cur_item_num = BagMgr:get_item_num(cost_id)
  self.v_cost_id = cost_id
  Util.load_ui_item(self.v_cost_item.gameObject, cost_id, cur_item_num, cost_num)
  self.v_img_sure.gameObject:SetActive(cost_num <= cur_item_num)
  self.v_img_no.gameObject:SetActive(cost_num > cur_item_num)
  local red_point = Util.get_child_gameobj("Red", self.v_uiobjects.AdvanceBtn)
  if cost_num <= cur_item_num then
    self.v_advance_btn_canvasgroup.alpha = 1
    red_point:SetActive(true)
    Util.apply_grey_ex(self.v_uiobjects.AdvanceBtn, false)
  else
    self.v_advance_btn_canvasgroup.alpha = 0.4
    red_point:SetActive(false)
    Util.apply_grey_ex(self.v_uiobjects.AdvanceBtn, true)
  end
end

function ui:ui_on_hide()
  if self.v_timer_idx then
    self.v_timer_idx = nil
  end
  if self.v_ui_effect and next(self.v_ui_effect) then
    for _, eff in pairs(self.v_ui_effect) do
      if not Util.is_nil(eff.lv_up) then
        eff.lv_up:SetActive(false)
      end
      if not Util.is_nil(eff.max_lv_up) then
        eff.max_lv_up:SetActive(false)
      end
    end
  end
  if self.v_updatepos_timer then
    Timer:remove_timer(self.v_updatepos_timer)
    self.v_updatepos_timer = nil
  end
end

function ui:update_skillcontent_pos(idx)
  local content_x = self.v_uicompents.SkillContent_rect.anchoredPosition.x
  local content_y = self.v_uicompents.SkillContent_rect.anchoredPosition.y
  local content_spacing_cpt = Util.get_component(nil, self.v_uiobjects.SkillContent, typeof(VerticalLayoutGroup))
  local content_spacing = content_spacing_cpt.spacing
  local scroll_view_height = self.v_uicompents.SkillContentScrollView_rect.sizeDelta.y
  local cur_pos = content_spacing * (idx - 1)
  for index, ui_obj in ipairs(self.v_skill_content_obj) do
    if idx > index then
      local height = ui_obj.sizeDelta.y
      cur_pos = cur_pos + height
    end
  end
  if content_y <= cur_pos and cur_pos <= content_y + scroll_view_height then
    return
  else
    self.v_uicompents.SkillContent_rect:SetAnchoredPositionA(content_x, cur_pos)
  end
end

return ui
