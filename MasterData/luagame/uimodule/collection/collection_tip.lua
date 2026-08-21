local Base = require("ui.uibase")
local M = Util.create_child_mt(Base)
local Item_Helper = require("utils.item_helper")
local ITEM_ICON_PATH = "Icon/Item/"
local OBJ_VISIBLE_TYPE = Config.FIGHT_OBJ_VISIBLE_TYPE
local CHANGE_HEIGHT = 590

function M:ui_finish_load()
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self.v_out_line = self.v_uiobjects.CollectionIcon:GetComponent(typeof(UnityEngine.UI.Outline))
end

function M:ui_on_show(item_id, is_lock)
  local fight = UIMgr:try_get_visible_ui("fight")
  if fight then
    fight:set_ui_node_visible("Right", OBJ_VISIBLE_TYPE.INTERACT, false)
    fight:set_uiobject_visible("Right")
    fight:set_ui_node_visible("JoystickContent", OBJ_VISIBLE_TYPE.INTERACT, false)
    fight:set_uiobject_visible("JoystickContent")
  end
  local ucom = self.v_uicompents
  local item_cfg = Item_Helper.get_item_cfg(item_id)
  ResMgr:load_set_icon(ucom.CollectionIcon_img, ITEM_ICON_PATH .. item_cfg.Icon)
  if is_lock then
    ucom.CollectionName_txt.text = "？？？"
    ucom.CollectionDesc_txt.text = item_cfg.Desc
    ucom.CollectionIcon_img.color = UnityEngine.Color(0, 0, 0, 1)
    self.v_out_line.enabled = true
  else
    ucom.CollectionName_txt.text = item_cfg.Name
    ucom.CollectionDesc_txt.text = item_cfg.WorldDesc
    ucom.CollectionIcon_img.color = UnityEngine.Color(1, 1, 1, 1)
    self.v_out_line.enabled = false
  end
  if ucom.CollectionDesc_rect.sizeDelta.y >= CHANGE_HEIGHT then
    ucom.CollectionDesc_rect.pivot.y = 1
  else
    ucom.CollectionDesc_rect.pivot.y = 0.5
  end
  self.v_item_id = item_id
end

function M:ui_on_hide()
  local fight = UIMgr:try_get_visible_ui("fight")
  if fight then
    fight:set_ui_node_visible("Right", OBJ_VISIBLE_TYPE.INTERACT, true)
    fight:set_uiobject_visible("Right")
    fight:set_ui_node_visible("JoystickContent", OBJ_VISIBLE_TYPE.INTERACT, true)
    fight:set_uiobject_visible("JoystickContent")
  end
  UIMgr:on_collection_tip_close(self.v_item_id)
end

return M
