local Base = require("ui.widget.widget_base")
local M = Util.create_child_mt(Base)

function M:_init(content_gameobj, item_height)
  self.v_content_gameobj = content_gameobj
  self.v_content_transform = content_gameobj.transform
  self.v_content_rect_trans = Util.get_rect_transform(nil, self.v_content_gameobj)
  self.v_item_height = item_height
  self.v_item_gameobjs = {}
  self.v_item_count = 0
end

function M:push_item(item_gameobj)
  self:add_item(item_gameobj)
  self:update_content_height()
end

function M:add_item(item_gameobj)
  item_gameobj.transform:SetParent(self.v_content_transform)
  CSHelper.ResetGameObjectLocalAttr(item_gameobj)
  local rect_transform = Util.get_rect_transform(nil, item_gameobj)
  rect_transform:SetAnchoredPositionA(0, -self.v_item_count * self.v_item_height)
  self.v_item_count = self.v_item_count + 1
  item_gameobj:SetActive(true)
  table.insert(self.v_item_gameobjs, item_gameobj)
end

function M:update_content_height()
  self.v_content_rect_trans:SetSizeDeltaHeightA(self.v_item_count * self.v_item_height + 2)
end

function M:clear(clear_to_cache_mgr, template_key)
  for _, item_gameobj in ipairs(self.v_item_gameobjs) do
    if clear_to_cache_mgr and template_key then
      CacheMgr:push_to_cache(template_key, item_gameobj)
    else
      ResMgr:destroy_gameobj(item_gameobj)
    end
  end
  self.v_item_gameobjs = {}
  self.v_item_count = 0
end

return M
