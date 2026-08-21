local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local ToggleTab = require("ui.widget.widget_toggle_tab")
local Item_Helper = require("utils.item_helper")

function ui:ui_finish_load()
  self:set_button("BtnReplace", function()
    self:ornaments_operation(false)
  end)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnSell", function()
    self:ornaments_operation(true)
  end)
end

function ui:ornaments_operation(is_sell)
  local ornaments_info = {}
  ornaments_info.uuid = self.v_item_info.drop_uuid
  ornaments_info.item_id = self.v_item_info.item_id
  ornaments_info.is_sell = is_sell
  ornaments_info.ornaments_slot = self.v_cur_select_pos
  ChallengeRingPlusMgr:req_pickup_ornaments(ornaments_info)
  SceneMgr:get_scene_item_mgr():delete_item(self.v_item_info.drop_uuid)
  self:ui_hide()
end

function ui:ui_on_show(item_info)
  self.v_item_info = item_info
  self.v_cur_ornaments_list = ChallengeRingPlusMgr:get_ornaments()
  self:update_ornaments_tog()
  self:update_left_ornaments_info()
  self:update_right_ornaments_info()
end

function ui:update_ornaments_tog()
  for pos, ornaments_id in ipairs(self.v_cur_ornaments_list) do
    if 0 == ornaments_id then
      self.v_cur_select_pos = pos
      break
    end
  end
  for pos, ornaments_id in ipairs(self.v_cur_ornaments_list) do
    self.v_uiobjects["BgKong" .. pos]:SetActive(0 == ornaments_id)
    self.v_uiobjects["OrnamentsIcon" .. pos]:SetActive(0 ~= ornaments_id)
    if 0 ~= ornaments_id then
      local item_cfg = Item_Helper.get_item_cfg(ornaments_id)
      local path = string.format("Icon/BattleItem/%s", item_cfg.Icon)
      ResMgr:load_set_icon(self.v_uicompents["OrnamentsIcon" .. pos .. "_img"], path)
    end
  end
  self.v_ornaments_toggle = {}
  for i = 1, 3 do
    table.insert(self.v_ornaments_toggle, self.v_uicompents["OrnamentsTem" .. i .. "_tog"])
  end
  self.v_select_tag_toggle_tab = ToggleTab:new(self)
  self.v_select_tag_toggle_tab:init_by_toggles(self.v_ornaments_toggle, function(cur_select_pos)
    self:click_select_toggle(cur_select_pos)
  end, -1)
  self:click_select_toggle(self.v_cur_select_pos)
end

function ui:click_select_toggle(cur_select_pos)
  self.v_cur_select_pos = cur_select_pos
  self:update_left_ornaments_info()
end

function ui:update_left_ornaments_info()
  local item_id = self.v_cur_ornaments_list[self.v_cur_select_pos]
  local is_show_info = 0 ~= item_id
  self.v_uiobjects.ItemObjNow:SetActive(is_show_info)
  self.v_uiobjects.ItemNameNow:SetActive(is_show_info)
  self.v_uiobjects.ItemDescNow:SetActive(is_show_info)
  self.v_uiobjects.NoneItem:SetActive(not is_show_info)
  if not is_show_info then
    return
  end
  local item_cfg = Item_Helper.get_item_cfg(item_id)
  self.v_uiobjects.OrnNow:SetActive(true)
  Util.load_ui_new_battle_item(self.v_uiobjects.ItemObjNow, item_id)
  self.v_uicompents.ItemNameNow_txt.text = item_cfg.Name
  self.v_uicompents.ItemDescNow_txt.text = item_cfg.Desc
end

function ui:update_right_ornaments_info()
  local item_id = self.v_item_info.item_id
  Util.load_ui_new_battle_item(self.v_uiobjects.ItemObjNext, item_id)
  local item_cfg = Item_Helper.get_item_cfg(item_id)
  self.v_uicompents.ItemNameNext_txt.text = item_cfg.Name
  self.v_uicompents.ItemDescNext_txt.text = item_cfg.Desc
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

return ui
