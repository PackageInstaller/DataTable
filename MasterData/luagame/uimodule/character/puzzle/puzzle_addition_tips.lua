local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local TEMPLATE_KEY_ATTR = "PUZZLE_ADDITION_TIPS_TEMPLATE_KEY_ATTR"
local TEMPLATE_KEY_EFFECT = "PUZZLE_ADDITION_TIPS_TEMPLATE_KEY_EFFECT"

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnClosePassDrag", function()
    self:ui_hide()
  end)
  self:set_toggle("PageAttr", function(isOn)
    self.v_uiobjects.AttrList:SetActive(isOn)
    self.v_uiobjects.EffectList:SetActive(not isOn)
  end)
  self:set_toggle("PageEffect", function(isOn)
    self.v_uiobjects.AttrList:SetActive(not isOn)
    self.v_uiobjects.EffectList:SetActive(isOn)
  end)
  self:register_exist_auto_template(TEMPLATE_KEY_ATTR, self.v_uiobjects.AttrTemp, self.v_uiobjects.AttrContent)
  self:register_exist_auto_template(TEMPLATE_KEY_EFFECT, self.v_uiobjects.EffectTem, self.v_uiobjects.EffectContent)
end

function ui:ui_after_show(puzzle_place_infos)
  self.v_show_data = puzzle_place_infos
  self.v_uicompents.PageAttr_tog.isOn = false
  self.v_uicompents.PageAttr_tog.isOn = true
  self:refresh_attr_list(puzzle_place_infos)
  self:refresh_entry_list(puzzle_place_infos)
end

function ui:refresh_attr_list(puzzle_place_infos)
  self:give_back_auto_cache(TEMPLATE_KEY_ATTR)
  local attr_id2value = {}
  for _, node_data in ipairs(puzzle_place_infos) do
    for _, attr_cfg_id in ipairs(node_data.attr_list) do
      local attr_cfg = ShareRes.get_buddy_puzzle_attr_cfg(attr_cfg_id)
      attr_id2value[attr_cfg.AttrId] = (attr_id2value[attr_cfg.AttrId] or 0) + attr_cfg.AttrValue
    end
  end
  local is_empty = not next(attr_id2value)
  self.v_uiobjects.AttrEmpty:SetActive(false)
  if is_empty then
    return
  end
  for _, attr_show_cfg in ipairs(ShareRes.get_buddy_puzzle_attr_show_list()) do
    local attr_id = attr_show_cfg.AttrId
    local attr_val = attr_id2value[attr_id]
    if attr_val then
      local item = self:get_auto_cache(TEMPLATE_KEY_ATTR)
      local icon = Util.get_image("AttrIcon", item)
      local name_txt = Util.get_text("AttrName", item)
      local val_txt = Util.get_text("AttrVal", item)
      Util.load_attr_icon(icon, ShareRes.get_attr_icon(attr_id))
      name_txt.text = attr_show_cfg.Desc
      local is_ration = 1 == attr_show_cfg.AttrType
      val_txt.text = Util.format_number(attr_val, is_ration)
    end
  end
end

function ui:refresh_entry_list(puzzle_place_infos)
  self:give_back_auto_cache(TEMPLATE_KEY_EFFECT)
  local entry_list = {}
  local entry_map = {}
  for _, puzzle_place_info in ipairs(puzzle_place_infos) do
    local puzzle_id = puzzle_place_info.id
    local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(puzzle_id)
    local entry_id = puzzle_cfg.EntryId
    if entry_id and (not entry_map[entry_id] or entry_map[entry_id] < puzzle_place_info.quality) then
      entry_map[entry_id] = puzzle_place_info.quality
    end
  end
  for entry_id, quality in pairs(entry_map) do
    entry_list[#entry_list + 1] = {id = entry_id, quality = quality}
  end
  table.sort(entry_list, function(a, b)
    if a.quality ~= b.quality then
      return a.quality > b.quality
    end
    return a.id < b.id
  end)
  local is_empty = not next(entry_list)
  self.v_uiobjects.EffectEmpty:SetActive(false)
  if is_empty then
    return
  end
  for _, data in ipairs(entry_list) do
    local item = self:get_auto_cache(TEMPLATE_KEY_EFFECT)
    local entry_cfg = ShareRes.get_buddy_puzzle_entry_cfg(data.id, data.quality)
    Util.get_text("Title/EffectName", item).text = entry_cfg.Name
    Util.get_text("Title/EffectLv", item).text = "Lv." .. entry_cfg.Lv
    Util.get_text("EffectDesc", item).text = entry_cfg.Desc
  end
end

return ui
