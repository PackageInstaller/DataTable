local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local item_helper = require("utils.item_helper")
local ITEMTIPS_WIDTH = 434
local ITEMTIPS_OFFSET_X = 64
local ITEMTIPS_OFFSET_Y = 64

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self.v_canvas_rect = self:get_canvas():GetComponent(TypeUnityRectTransform)
end

function ui:ui_on_show(item_id, item_transform)
  self:set_data(item_id, item_transform)
end

function ui:ui_on_destroy()
end

function ui:set_data(item_id, item_transform)
  local pos = UIMgr.root_camera:WorldToViewportPoint(item_transform.position)
  pos.x = pos.x * self.v_canvas_rect.sizeDelta.x
  pos.y = pos.y * self.v_canvas_rect.sizeDelta.y
  pos.x = pos.x + ITEMTIPS_OFFSET_X
  pos.y = pos.y + ITEMTIPS_OFFSET_Y
  if pos.x + ITEMTIPS_WIDTH > self.v_canvas_rect.sizeDelta.x then
    pos.x = self.v_canvas_rect.sizeDelta.x - ITEMTIPS_WIDTH
  end
  self.v_uicompents.Content_rect:SetAnchoredPositionA(pos.x, pos.y)
  local item_cfg = item_helper.get_item_cfg(item_id)
  self.v_uicompents.ItemDesc_txt.text = item_cfg.Desc
  self.v_uicompents.WorldDesc_txt.text = item_cfg.WorldDesc
  local item_icon = Util.get_image("ItemIcon_", self.v_uiobjects.ItemObjCom1)
  local item_quality = Util.get_image("ItemQuality_", self.v_uiobjects.ItemObjCom1)
  local item_num_txt = Util.get_text("ItemAmount_/Bg/ItemNum_", self.v_uiobjects.ItemObjCom1)
  local item_icon_path = ShareRes.get_item_icon_path(item_id)
  local item_quality_path = ShareRes.get_item_quality_path(item_id)
  local item_count = BagMgr:get_item_num(item_id)
  ResMgr:load_set_icon(item_icon, item_icon_path)
  ResMgr:load_set_icon(item_quality, item_quality_path)
  self.v_uicompents.ItemNum_txt.text = item_count
  self.v_uicompents.ItemName_txt.text = item_cfg.Name
  item_num_txt.text = item_count
end

return ui
