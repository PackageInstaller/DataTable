local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local FASHION_LIST_CLASS = require("uimodule.archives.fashion_list_item")
local FASHION_ITEM_LIST_KEY = "FASHION_ITEM_LIST_KEY"
local BIND_TYPE = Config.BIND_TYPE
local SHOW_TYPE = {BRAND = 0, CHAR = 1}

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    FashionMgr:read_all_fashion_red_point()
    ArchiveMgr.v_is_save_fasion_operation = false
    self:ui_hide()
  end)
  self:set_dropdown("TypeDropdown", function(option_index)
    self:option_dropdown(option_index)
  end, 1)
  self:set_toggle("IfHold", function(isOn)
    self:update_fishion_show()
  end, true)
  self:register_exist_auto_template(FASHION_ITEM_LIST_KEY, self.v_uiobjects.FashionItemList, self.v_uiobjects.FashionList)
  self.v_is_show_not_have = true
  self.v_show_type = SHOW_TYPE.BRAND
  self.v_fishion_item_list = {}
  self.v_char_original_skin_list = {}
  local buddy_info_list = ShareRes.create("buddy.buddy")
  for _, info in pairs(buddy_info_list) do
    self.v_char_original_skin_list[info.FashionInitId] = info.FashionInitId
  end
end

function ui:on_go_to_main()
  FashionMgr:read_all_fashion_red_point()
end

function ui:option_dropdown(type_id)
  self.v_show_type = type_id
  self.v_uicompents.FashionList_rect.transform:SetAnchoredPositionA(0, 0)
  self:update_fishion_show()
end

function ui:ui_on_show()
  if not ArchiveMgr.v_is_save_fasion_operation then
    self:option_dropdown(SHOW_TYPE.BRAND)
    self.v_uicompents.FashionList_rect.transform:SetAnchoredPositionA(0, 0)
    self:get_uiobject("TypeDropdown", BIND_TYPE.DROPDOWN).value = SHOW_TYPE.BRAND
    ArchiveMgr.v_is_save_fasion_operation = false
  end
  self:update_fishion_show()
end

function ui:update_fishion_show()
  self:remove_wrap_list()
  self.v_fashion_show_list = {}
  if self.v_show_type == SHOW_TYPE.BRAND then
    self:deal_brand_fashion_data()
  elseif self.v_show_type == SHOW_TYPE.CHAR then
    self:deal_char_fashion_data()
  end
  self:show_fashion()
end

function ui:show_fashion()
  for _, data in ipairs(self.v_fashion_show_list) do
    local item = self:get_auto_cache(FASHION_ITEM_LIST_KEY)
    local obj = FASHION_LIST_CLASS:ui_wrap_ex(self, item, true)
    obj:set_data(data)
    table.insert(self.v_fishion_item_list, obj)
  end
  self.v_uiobjects.NoFashion:SetActive(#self.v_fashion_show_list < 1)
end

function ui:deal_brand_fashion_data()
  local brand_list = ShareRes.create("buddy.buddy_fashion_brand")
  local buddy_info_list = ShareRes.create("buddy.buddy")
  local all_fashion_cfg = ShareRes.create("buddy.buddy_fashion")
  for fashion_id, info in pairs(all_fashion_cfg) do
    if info.IsHide then
    else
      local buddy_cfg = buddy_info_list[info.BuddyId]
      if 1 == buddy_cfg.IsShow or not CharacterMgr:check_buddy_release(info.BuddyId) then
      elseif info.ReleaseTime and not Date.check_time_pass_by_scheme_id(info.ReleaseTime) then
      else
        info.is_have = FashionMgr:check_has_bought_fashion(fashion_id)
        if (self.v_uicompents.IfHold_tog.isOn or info.is_have) and 1 == brand_list[info.Type].Visible then
          local index = self:is_have_fashion_by_brand_in_show_list(info.Type)
          if index then
            table.insert(self.v_fashion_show_list[index].list, info)
          else
            local data = {}
            data.list = {}
            data.brand_id = info.Type
            data.brand_name = brand_list[info.Type].TypeName
            data.brand_enname = brand_list[info.Type].TypeNameEn
            data.bg_color = brand_list[info.Type].BgColor
            data.a = 255
            data.show_priority = brand_list[info.Type].ShowPriority
            table.insert(data.list, info)
            table.insert(self.v_fashion_show_list, data)
          end
        end
      end
    end
  end
  table.sort(self.v_fashion_show_list, function(a, b)
    if a.show_priority ~= b.show_priority then
      return a.show_priority > b.show_priority
    end
    return a.brand_id > b.brand_id
  end)
  for _, data in ipairs(self.v_fashion_show_list) do
    table.sort(data.list, function(a, b)
      if a.is_have ~= b.is_have then
        return a.is_have and b.is_have or a.is_have
      end
      if a.ShowPriority ~= b.ShowPriority then
        return a.ShowPriority > b.ShowPriority
      end
      return a.Id > b.Id
    end)
  end
end

function ui:deal_char_fashion_data()
  local buddy_info_list = ShareRes.create("buddy.buddy")
  local all_fashion_cfg = ShareRes.create("buddy.buddy_fashion")
  for fashion_id, info in pairs(all_fashion_cfg) do
    if info.IsHide then
    else
      local buddy_cfg = buddy_info_list[info.BuddyId]
      if 1 == buddy_cfg.IsShow or not CharacterMgr:check_buddy_release(info.BuddyId) then
      elseif info.ReleaseTime and not Date.check_time_pass_by_scheme_id(info.ReleaseTime) then
      else
        info.is_have = FashionMgr:check_has_bought_fashion(fashion_id)
        if self.v_uicompents.IfHold_tog.isOn or info.is_have then
          local index = self:is_have_fashion_by_char_in_show_list(info.BuddyId)
          if index then
            table.insert(self.v_fashion_show_list[index].list, info)
          else
            local data = {}
            data.list = {}
            data.buddy_id = info.BuddyId
            data.buddy_name = buddy_cfg.Name
            data.bg_color = "292929"
            data.a = 153
            data.show_priority = buddy_cfg.Priority
            data.original_skin_id = buddy_cfg.FashionInitId
            table.insert(data.list, info)
            table.insert(self.v_fashion_show_list, data)
          end
        end
      end
    end
  end
  table.sort(self.v_fashion_show_list, function(a, b)
    if a.show_priority ~= b.show_priority then
      return a.show_priority > b.show_priority
    end
    return a.buddy_id > b.buddy_id
  end)
  for _, data in ipairs(self.v_fashion_show_list) do
    table.sort(data.list, function(a, b)
      if a.Id == data.original_skin_id then
        return true
      end
      if b.Id == data.original_skin_id then
        return false
      end
      if a.is_have ~= b.is_have then
        return a.is_have and b.is_have or a.is_have
      end
      if a.ShowPriority ~= b.ShowPriority then
        return a.ShowPriority > b.ShowPriority
      end
      return a.Id > b.Id
    end)
  end
end

function ui:is_have_fashion_by_brand_in_show_list(brand_id)
  for index, info in ipairs(self.v_fashion_show_list) do
    if info.brand_id == brand_id then
      return index
    end
  end
end

function ui:is_have_fashion_by_char_in_show_list(buddy_id)
  for index, info in ipairs(self.v_fashion_show_list) do
    if info.buddy_id == buddy_id then
      return index
    end
  end
end

function ui:ui_on_hide()
  self:remove_wrap_list()
end

function ui:remove_wrap_list()
  for _, obj in pairs(self.v_fishion_item_list) do
    obj:set_enable(false)
    self:remove_wrap_ui(obj)
  end
  self.v_fishion_item_list = {}
end

function ui:cache_ui()
  return true
end

return ui
