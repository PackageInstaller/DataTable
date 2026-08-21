local Base = require("ui.widget.widget_base")
local M = Util.create_child_mt(Base)
local ItemClass = require("uimodule.item.item_obj")
local item_res_path = Path.get_language_full_prefab_path("prefab/Item_Obj.prefab")
local fight_item_res_path = Path.get_language_full_prefab_path("prefab/FightItem_Obj.prefab")

function M:_init(parent_ui, replace_obj, is_fight)
  self.v_parent_ui = parent_ui
  self.v_template_key = string.format("Item_obj_%s", self.v_parent_ui)
  local itemObj = self:_get_item(replace_obj, is_fight)
  self.v_parent_ui:register_exist_auto_template(self.v_template_key, itemObj, nil)
  self.v_item_list = {}
end

function M:_get_item(replace_obj, is_fight)
  local itemObj
  local res_path = is_fight and fight_item_res_path or item_res_path
  if replace_obj then
    local name = is_fight and "FightItem_Obj" or "Item_Obj"
    if replace_obj.name == name or replace_obj.name == string.format("%s_", name) then
      itemObj = replace_obj
    else
      itemObj = ResMgr:load_gameobj(res_path, nil, true)
      itemObj:SetParent(self.v_parent_ui:get_object())
    end
    self:_handle_replace_obj(replace_obj)
  else
    itemObj = ResMgr:load_gameobj(res_path, nil, true)
    itemObj:SetParent(self.v_parent_ui:get_object())
  end
  return itemObj
end

function M:create_obj(parent, replace_obj, param, ...)
  if replace_obj then
    self:_handle_replace_obj(replace_obj)
  end
  parent = parent or self.v_item_parent
  assert(parent)
  local key = string.format("%s_%s", parent, param.item_id)
  local ui = self.v_item_list[key]
  if ui then
    ui:ui_show(param)
    return ui
  end
  local item = self.v_parent_ui:get_auto_cache(self.v_template_key)
  local rect = item:GetComponent(TypeUnityRectTransform)
  item:SetParent(parent, false)
  item.transform:SetSiblingIndex(self.v_sibling_idx + 1)
  ui = ItemClass:ui_wrap(self.v_parent_ui, item)
  self:_sync_rect(self.v_item_rect, rect)
  ui:set_enable(true, param)
  ui:set_scale(self.v_scale)
  self.v_item_list[key] = ui
  return ui
end

function M:clear()
  for k, v in pairs(self.v_item_list) do
    self.v_parent_ui:remove_wrap_ui(v)
  end
  self.v_item_list = {}
end

function M:force_clear()
  for k, v in pairs(self.v_item_list) do
    local obj = v:get_object()
    self.v_parent_ui:remove_wrap_ui(v)
    v:ui_hide()
    v:ui_destroy()
    self.v_parent_ui:give_back_auto_cache_obj(nil, obj, false)
  end
  self.v_item_list = {}
end

function M:_sync_rect(old, new, is_cpoy)
  new = new or {}
  new.anchorMin = old.anchorMin
  new.anchorMax = old.anchorMax
  new.offsetMin = old.offsetMin
  new.pivot = old.pivot
  new.sizeDelta = old.sizeDelta
  new.localPosition = old.localPosition
  new.localScale = old.localScale
  if is_cpoy then
    if 0 == old.rect.size.x then
      Log.Info(old.name, "old.rect.size大小为0")
    end
    self:_set_scale(old.rect.size)
    self.v_item_rect = new
  end
end

function M:_handle_replace_obj(replace_obj)
  local obj = replace_obj.gameObject
  local tra = replace_obj.transform
  local rect = obj:GetComponent(TypeUnityRectTransform)
  self:_sync_rect(rect, nil, true)
  self.v_item_parent = tra.parent.gameObject
  self.v_sibling_idx = tra:GetSiblingIndex()
  obj:SetActiveEx(false)
end

function M:_set_scale(new_size)
  self.v_scale = new_size.x / 100
end

return M
