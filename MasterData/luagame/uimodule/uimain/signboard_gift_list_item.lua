local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("BtnDel", function()
    local msg = MsgGame:mq_publish2(Const.MSG_FAVOR_ITEM_SELECTED_CHANGE)
    msg.mm_x = self.v_item_id
    msg.mm_y = -1
  end)
  self:set_button("BtnSelect", function()
    self:_onclick_use_btn()
  end)
end

function ui:set_data(data)
  self.v_item_id = data.item_id
  local path = UtilUI.get_quality_icon(data.quality)
  ResMgr:load_set_icon(self.v_uicompents.ItemQuality_img, path)
  path = UtilUI.get_item_icon(data.item_id)
  ResMgr:load_set_icon(self.v_uicompents.ItemIcon_img, path)
  self.v_uicompents.ItemNum_txt.text = data.own_num
  self.v_uiobjects.Favorite:SetActive(data.is_favorite == true)
  self.v_uiobjects.SelectObj:SetActive(false)
end

function ui:update_selected(selected_num)
  selected_num = selected_num or 0
  self.v_uiobjects.SelectObj:SetActive(selected_num > 0)
  if selected_num > 0 then
    self.v_uicompents.SelectNum_txt.text = selected_num
  end
end

function ui:_onclick_use_btn()
  local item_info = BagMgr:get_item(self.v_item_id)
  if not item_info then
    return
  end
  local item_cfg = ShareRes.get_item_cfg(self.v_item_id)
  local tcs_type_cfg = ShareRes.create("item.item_subtype", "treasure_chest_select")
  local s_type_cfg = ShareRes.create("item.item_subtype", "stamina_item")
  local tcu_type_cfg = ShareRes.create("item.item_subtype", "treasure_chest_unlocked")
  local f_type_cfg = ShareRes.create("item.item_subtype", "favor_item")
  if item_cfg.Subtype == tcs_type_cfg.SubtypeId then
    UIMgr:get_ui("use_select_item_tips"):ui_show(self.v_item_id, item_info.uuid)
  elseif item_cfg.Subtype == tcu_type_cfg.SubtypeId then
    UIMgr:get_ui("use_ramdom_item_tips"):ui_show(self.v_item_id, item_info.uuid)
  elseif item_cfg.Subtype == s_type_cfg.SubtypeId then
    self.v_panels.item_use_view:set_enable(true, {
      item_id = self.v_item_id,
      item_info.uuid
    })
  elseif item_cfg.Subtype == f_type_cfg.SubtypeId then
    local msg = MsgGame:mq_publish2(Const.MSG_FAVOR_ITEM_SELECTED_CHANGE)
    msg.mm_x = self.v_item_id
    msg.mm_y = 1
  end
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

return ui
