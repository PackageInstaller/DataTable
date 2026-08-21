local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:on_click_ItemDesc()
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
end

function ui:ui_on_destroy()
end

function ui:set_data(ornament_id, not_real_count, select_index, show_new)
  self.v_select_index = select_index
  self.v_ornament_id = ornament_id
  local ornament_cfg = ShareRes.create("item.ornaments")[ornament_id]
  local bg2_img = self.v_uicompents.Bg2_img
  local orn_icon_img = self.v_uicompents.OrnIcon_img
  local name = self.v_uicompents.ItemName_txt
  local desc_text = self.v_uicompents.ItemDesc_txt
  if not_real_count then
    self:set_fake_buff_count(ornament_cfg)
  else
    self.v_is_breaked = BattleOrnamentMgr:is_ornament_breaked(ornament_id)
    self.v_uiobjects.Mask:SetActive(self.v_is_breaked)
    self:set_real_buff_count(ornament_cfg.MainBuff)
  end
  ResMgr:load_set_icon(bg2_img, BattleOrnamentMgr:get_ornament_bg_icon(ornament_cfg.Quality))
  orn_icon_img.gameObject:SetActive(true)
  ResMgr:load_set_icon(orn_icon_img, ornament_cfg.Icon)
  name.text = ornament_cfg.Name
  desc_text.text = BattleOrnamentMgr:get_ornament_desc(ornament_id)
  self.v_uicompents.WorldDesc_txt.text = ornament_cfg.WorldDesc
  if self.v_uicompents.DescContent_rect then
    local init_x = self.v_uicompents.DescContent_rect.anchoredPosition.x
    self.v_uicompents.DescContent_rect:SetAnchoredPositionA(init_x, 0)
  end
  if self.v_uicompents.Ani_OrnTem_Select_Drop_pd then
    self.v_uicompents.Ani_OrnTem_Select_Drop_pd:ResetPD()
    self.v_uicompents.Ani_OrnTem_Select_Drop_pd:Play()
  end
  self.v_uiobjects.New:SetActive(not show_new and not FateBookMgr:check_illustrated_is_unlock(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.ORNAMENT, self.v_ornament_id))
  local tog = self:get_toggle()
  if tog then
    self:set_toggle_listener(tog, function()
      self:on_select_ornament()
    end)
  end
  if self.v_uiobjects.ItemDesc then
    self.v_key_id_list = ornament_cfg.KeyIDList
    self:set_button("ItemDesc", function()
      self:on_click_ItemDesc()
    end)
  end
  if self.v_uiobjects.WorldDesc then
    self.v_key_id_list = ornament_cfg.KeyIDList
    self:set_button("WorldDesc", function()
      self:on_click_ItemDesc()
    end)
  end
  if self.v_uiobjects.BtnChoose then
    self:set_button("BtnChoose", function()
      self:on_select_ornament(true)
      self.v_parent_ui:on_click_select_button()
    end)
  end
  return tog
end

function ui:set_fake_buff_count(ornament_cfg)
  self:set_buff_count(ornament_cfg.BuffCount, true)
end

function ui:set_real_buff_count(buff_id)
  if not buff_id or buff_id <= 0 then
    self.v_uiobjects.LimitTag:SetActive(false)
    return
  end
  local buff_count = BuffMgr:get_buff_round_count(buff_id)
  self:set_buff_count(buff_count, true)
end

function ui:set_buff_count(buff_count, set_mask)
  local show_mask
  if not buff_count or buff_count < 0 then
    self.v_uiobjects.LimitTag:SetActive(false)
    show_mask = false
  elseif buff_count > 0 then
    self.v_uicompents.LimitNum_txt.text = buff_count
    self.v_uiobjects.LimitTag:SetActive(true)
    show_mask = false
  elseif 0 == buff_count then
    self.v_uiobjects.LimitTag:SetActive(false)
    show_mask = true
  end
  if set_mask and not self.v_is_breaked then
    self.v_uiobjects.Mask:SetActive(show_mask)
  end
end

function ui:on_select_ornament()
  self.v_parent_ui:on_select_ornament(self.v_select_index, self.v_ornament_id)
end

function ui:colse_key_word_tips()
  self:reset_key_word_btn()
end

return ui
