local ItemBase = require("ui.uiobject")
local AttrItem = Util.create_child_mt(ItemBase)

function AttrItem:ui_finish_load()
end

function AttrItem:set_entry_data(data)
  local entry_cfg = ShareRes.get_buddy_puzzle_entry_cfg(data.id, data.quality)
  self.v_uicompents.EffectName_txt.text = entry_cfg.Name
  self.v_uiobjects.EffectName:SetActive(true)
  self.v_uiobjects.EffectActive:SetActive(true)
  self.v_uiobjects.AttrName:SetActive(false)
  self.v_uiobjects.AttrNum:SetActive(false)
end

function AttrItem:set_attr_data(attr_id, attr_val, attr_show_cfg)
  self.v_uicompents.AttrName_txt.text = attr_show_cfg.Desc
  self.v_uiobjects.EffectName:SetActive(false)
  self.v_uiobjects.EffectActive:SetActive(false)
  self.v_uiobjects.AttrName:SetActive(true)
  self.v_uiobjects.AttrNum:SetActive(true)
  local is_ration = 1 == attr_show_cfg.AttrType or ShareRes.get_is_ration_attr(attr_id)
  self.v_uicompents.AttrNum_txt.text = Util.format_number(attr_val, is_ration)
end

local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local TEMPLATE_KEY_ATTR = "PUZZLE_ATTR_POP_TIPS_TEMPLATE_KEY_ATTR"

function ui:ui_finish_load()
  self:register_exist_auto_template(TEMPLATE_KEY_ATTR, self.v_uiobjects.AttrTem, self.v_uiobjects.Content)
end

function ui:ui_on_hide()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
  self:clear_wrap_items()
end

function ui:ui_after_show(new_attr, new_entry)
  local total_num = #new_attr + #new_entry
  local offset = total_num < 3 and -40 or 0
  self.v_uicompents.Content_rect:SetLocalPositionA(0, -100, 0)
  self.v_uicompents.Content_rect:DOLocalMoveY(offset, 0.2)
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
  self.v_sequence = Util.create_sequence()
  self.v_sequence:AppendInterval(total_num * 0.05 + 1.1)
  self.v_sequence:AppendCallback(function()
    self:ui_hide()
  end)
  local idx = 0
  self:clear_wrap_items()
  self.v_items = {}
  self:give_back_auto_cache(TEMPLATE_KEY_ATTR)
  for _, data in ipairs(new_entry) do
    idx = idx + 1
    self:refresh_entry_list(data, idx)
  end
  if #new_attr > 0 then
    local attr_id2value = {}
    for _, data in ipairs(new_attr) do
      attr_id2value[data.id] = data.val
    end
    for _, attr_show_cfg in ipairs(ShareRes.get_buddy_puzzle_attr_show_list()) do
      local attr_id = attr_show_cfg.AttrId
      local attr_val = attr_id2value[attr_id]
      if attr_val then
        idx = idx + 1
        self:refresh_attr_list(attr_id, attr_val, attr_show_cfg, idx)
      end
    end
  end
end

function ui:refresh_entry_list(data, idx)
  local obj = self:get_auto_cache(TEMPLATE_KEY_ATTR)
  local item = AttrItem:ui_wrap_ex(self, obj, true)
  item:set_entry_data(data)
  local cg = item:get_canvas_group()
  cg.alpha = 0
  cg:DOFade(1, 0.3):SetDelay(idx * 0.05)
  cg:DOFade(0, 0.3):SetDelay(idx * 0.05 + 0.8)
  table.insert(self.v_items, item)
end

function ui:refresh_attr_list(attr_id, attr_val, attr_show_cfg, idx)
  local obj = self:get_auto_cache(TEMPLATE_KEY_ATTR)
  local item = AttrItem:ui_wrap_ex(self, obj, true)
  item:set_attr_data(attr_id, attr_val, attr_show_cfg)
  item:get_canvas_group().alpha = 0
  local cg = item:get_canvas_group()
  cg.alpha = 0
  cg:DOFade(1, 0.3):SetDelay(idx * 0.05)
  cg:DOFade(0, 0.3):SetDelay(idx * 0.05 + 0.8)
  table.insert(self.v_items, item)
end

function ui:clear_wrap_items()
  if self.v_items then
    for idx = #self.v_items, 1, -1 do
      local item = self.v_items[idx]
      item:ui_hide()
      item:ui_destroy()
      self.v_items[idx] = nil
    end
    self.v_items = nil
  end
end

return ui
