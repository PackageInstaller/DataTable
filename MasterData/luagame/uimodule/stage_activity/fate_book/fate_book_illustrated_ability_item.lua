local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:open_keyword_view()
  if UtilTable.is_empty(self.v_key_id_list) then
    return
  end
  UIMgr:try_show_ui("keyword_tips_v2", nil, self.v_key_id_list)
end

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
  self.v_ssv = nil
end

function ui:ui_on_destroy()
  self.v_ssv = nil
end

function ui:_on_click_button()
  if self.v_ability_id and self.v_ssv then
    local parent_ui = self.v_ssv:get_parent_ui()
    parent_ui:on_select_ability(self)
  end
end

function ui:set_data(cfg, ssv)
  local SECT_TYPE = Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.SECT
  self.v_ssv = ssv
  self.v_ability_id = cfg.Id
  self.v_ability_cfg = ShareRes.get_ability_cfg(self.v_ability_id)
  local genres_cfg = ShareRes.get_genres_cfg(self.v_ability_cfg.Sect)
  local quality_cfg = ShareRes.get_ability_quality_cfg(self.v_ability_cfg.Quality)
  local objs = self.v_uiobjects
  local comps = self.v_uicompents
  ResMgr:load_set_icon(comps.SectIcon_img, genres_cfg.IconPath, nil, true, self)
  ResMgr:load_set_icon(comps.QualityBg_img, self.v_ssv and quality_cfg.QualityBg3 or quality_cfg.QualityBg1, nil, true)
  self.v_is_unlock = FateBookMgr:check_illustrated_is_unlock(SECT_TYPE, self.v_ability_id)
  comps.TalentName_txt.text = self.v_is_unlock and self.v_ability_cfg.Name or "？？？"
  if objs.CurrLayout then
    objs.CurrLayout:SetActive(false)
  end
  if objs.LvMax then
    objs.LvMax:SetActive(false)
  end
  if objs.HandBookUnlock then
    objs.HandBookUnlock:SetActive(self.v_is_unlock)
  end
  if objs.Lock then
    objs.Lock:SetActive(not self.v_is_unlock)
  end
  if objs.IllustratedLock then
    objs.IllustratedLock:SetActive(not self.v_is_unlock)
  end
  if objs.Select then
    objs.Select:SetActive(1 == cfg.idx)
  end
  self.v_is_red = FateBookMgr:get_red_state(SECT_TYPE, self.v_ability_id)
  if objs.RedPoint then
    objs.RedPoint:SetActive(self.v_is_red)
  end
  local upgrade_cfg = ShareRes.get_ability_upgrade_cfg(self.v_ability_id, 1)
  local ability_next_lv_cfg = ShareRes.get_ability_upgrade_cfg(self.v_ability_id, 2)
  if objs.ScrollView then
    comps.TalentDesc_txt.text = upgrade_cfg.Desc
    objs.ScrollView:SetActive(self.v_is_unlock)
    if ability_next_lv_cfg then
      comps.TalentLvUpDesc_txt.text = "<color=#ffda90>升级后：</color>" .. ability_next_lv_cfg.Desc
      objs.TalentLvUpDesc:SetActive(true)
    else
      objs.TalentLvUpDesc:SetActive(false)
    end
  end
  if comps.Tag_txt then
    comps.Tag_txt.text = cfg.Tag
  end
  if comps.DescContent_rect then
    local show_desc = self.v_is_unlock
    objs.DescContent:SetActive(show_desc)
    if show_desc then
      local key_id_list = upgrade_cfg.KeyIDList
      local next_key_id_list = ability_next_lv_cfg.KeyIDList
      local init_x = comps.DescContent_rect.anchoredPosition.x
      comps.DescContent_rect:SetAnchoredPositionA(init_x, 0)
      if comps.TalentDesc_btn then
        self:set_button_listener(comps.TalentDesc_btn, function()
          self.v_key_id_list = key_id_list
          self:open_keyword_view(key_id_list)
        end)
      end
      if comps.TalentLvUpDesc_btn then
        self:set_button_listener(comps.TalentLvUpDesc_btn, function()
          self.v_key_id_list = next_key_id_list
          self:open_keyword_view()
        end)
      end
    end
  end
  self:set_start()
  local btn = self:get_button()
  if btn then
    self:set_button_listener(btn, function()
      self:_on_click_button()
    end)
  end
  if 1 == cfg.idx then
    self:_on_click_button()
  end
end

function ui:set_start()
  local start_layout_tf = self.v_uiobjects.StarLayout.transform
  if start_layout_tf.childCount < self.v_ability_cfg.Star then
    for index = start_layout_tf.childCount, self.v_ability_cfg.Star do
      local child_tf = start_layout_tf:GetChild(0)
      UnityGameObject.Instantiate(child_tf.gameObject, start_layout_tf)
    end
  end
  for index = 1, start_layout_tf.childCount do
    local child_tf = start_layout_tf:GetChild(index - 1)
    if index <= self.v_ability_cfg.Star and index <= self.v_ability_cfg.Star then
      child_tf.gameObject:SetActive(true)
    else
      child_tf.gameObject:SetActive(false)
    end
  end
end

function ui:refresh_red()
  if self.v_is_red then
    FateBookMgr:close_redpoint(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.SECT, self.v_ability_id, true)
    self.v_is_red = false
    self.v_uiobjects.RedPoint:SetActive(self.v_is_red)
  end
end

function ui:set_selected(is_select)
  self.v_uiobjects.Select:SetActive(is_select)
  if is_select then
    self:refresh_red()
  end
end

function ui:on_clear()
  self.v_ssv = nil
  self.v_ability_id = nil
  self.v_ability_cfg = nil
end

return ui
