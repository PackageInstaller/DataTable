local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local UIBrandPath = "UIArchive/UIBrand/%s"

function ui:set_data(info, data)
  ResMgr:load_set_icon(self.v_uicompents.FashionIcon_img, info.SpriteId, nil, true)
  self.v_uiobjects.GetWayBg:SetActive(0 ~= info.Tag)
  self.v_uicompents.FashionName_txt.text = info.Name
  self.v_uiobjects.Lock:SetActive(not info.is_have)
  local show_red = info.is_have and FashionMgr:check_fashion_red_point(info.Id)
  self.v_uiobjects.Red:SetActive(show_red)
  local sale_tips_obj = Util.get_child_gameobj("SaleTips", self.v_object)
  sale_tips_obj:SetActive(false)
  self.v_uiobjects.GetWayBg:SetActive(false)
  if 0 ~= info.Tag then
    local set_img = Util.get_image("Bg", self.v_uiobjects.GetWayBg)
    local tag_cfg = ShareRes.get_fashion_tag_cfg(info.Tag)
    local tag_bg_path = string.format(UIBrandPath, tag_cfg.TagBg)
    ResMgr:load_set_icon(set_img, tag_bg_path)
    self.v_uicompents.GetWayText_txt.text = tag_cfg.TagName
    self.v_uiobjects.GetWayBg:SetActive(true)
  end
  if data.brand_id then
    local fashion_list = {}
    local buddy_list = {}
    local fashion_list_order_by_index = {}
    for _, temp_data in pairs(data.list) do
      if not fashion_list[temp_data.BuddyId] then
        fashion_list[temp_data.BuddyId] = {}
      end
      if info.Type == temp_data.Type then
        table.insert(fashion_list[temp_data.BuddyId], temp_data.Id)
      end
      if not UtilTable.contains(buddy_list, temp_data.BuddyId) then
        table.insert(buddy_list, temp_data.BuddyId)
      end
      table.insert(fashion_list_order_by_index, temp_data.Id)
    end
    self:set_button("Bg", function()
      if show_red then
        FashionMgr:read_red_point_request(info.BuddyId, info.Id)
      end
      UIMgr:get_ui("ui_fashionable_dress"):ui_show(info.BuddyId, buddy_list, info.Id, fashion_list, nil, nil, true, nil, fashion_list_order_by_index)
      ArchiveMgr.v_is_save_fasion_operation = true
    end)
  end
  if data.buddy_id then
    self:set_button("Bg", function()
      UIMgr:get_ui("ui_fashionable_dress"):ui_show(info.BuddyId, nil, info.Id)
      ArchiveMgr.v_is_save_fasion_operation = true
    end)
  end
end

return ui
