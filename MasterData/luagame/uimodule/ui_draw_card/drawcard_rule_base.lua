local RULE_BASE_BUDDY_ITEM = require("uimodule.ui_draw_card.drawcard_rule_base_buddy_item")
local util_get_color = Util.get_unity_color_by_hex
local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_char_tem = {
    "CharTem",
    BIND_TYPE.OBJECT
  },
  v_content = {
    "Content",
    BIND_TYPE.OBJECT
  },
  v_info_tem1 = {
    "InfoTem1",
    BIND_TYPE.OBJECT
  },
  v_info_tem2 = {
    "InfoTem2",
    BIND_TYPE.OBJECT
  },
  v_main_title = {
    "MainTitle",
    BIND_TYPE.OBJECT
  },
  v_scroll_view = {
    "ScrollView",
    BIND_TYPE.SCROLL
  }
}
local QUALITY_COLOR = {
  [0] = "9969e3",
  [4] = "9969e3",
  [5] = "ddae65"
}
local DRAWCARD_BASE_RULE_TEMPLATE_KEY = "DRAWCARD_BASE_RULE_TEMPLATE_KEY"
local DRAWCARD_BASE_RULE_TEMPLATE_KEY1 = "DRAWCARD_BASE_RULE_TEMPLATE_KEY1"
local DRAWCARD_BASE_RULE_TEMPLATE_KEY2 = "DRAWCARD_BASE_RULE_TEMPLATE_KEY2"
local DRAWCARD_BASE_RULE_TEMPLATE_KEY2_CHILD = "DRAWCARD_BASE_RULE_TEMPLATE_KEY2_CHILD"

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:register_exist_auto_template(DRAWCARD_BASE_RULE_TEMPLATE_KEY, self.v_main_title, self.v_content)
  self:register_exist_auto_template(DRAWCARD_BASE_RULE_TEMPLATE_KEY1, self.v_info_tem1, self.v_content)
  self:register_exist_auto_template(DRAWCARD_BASE_RULE_TEMPLATE_KEY2, self.v_info_tem2, self.v_content)
  self:register_exist_auto_template(DRAWCARD_BASE_RULE_TEMPLATE_KEY2_CHILD, self.v_char_tem, self.v_info_tem2)
end

function ui:ui_on_show()
  self.v_scroll_view.verticalNormalizedPosition = 1
end

function ui:set_data(group_id, pool_id)
  self.v_group_id = group_id
  self.v_pool_id = pool_id
  pool_id = self:get_fake_pool_id() or self.v_pool_id
  local cfg = ShareRes.get_draw_base_rule(pool_id)
  assert(cfg, "not found drawcard pool rule config, pool_id:" .. pool_id)
  self:give_back_auto_cache(DRAWCARD_BASE_RULE_TEMPLATE_KEY)
  self:give_back_auto_cache(DRAWCARD_BASE_RULE_TEMPLATE_KEY1)
  self:give_back_auto_cache(DRAWCARD_BASE_RULE_TEMPLATE_KEY2)
  self:give_back_auto_cache(DRAWCARD_BASE_RULE_TEMPLATE_KEY2_CHILD)
  self:clear_child_item_ui_wrap()
  self.v_child_item_list = {}
  local sibling_idx = 0
  for idx, title in ipairs(cfg.Title) do
    sibling_idx = sibling_idx + 1
    local obj = self:get_auto_cache(DRAWCARD_BASE_RULE_TEMPLATE_KEY)
    obj.transform:SetSiblingIndex(sibling_idx)
    self:get_text("MainTitle/TitleDesc", obj).text = title
    sibling_idx = self:build_content_items(cfg.ContentID[idx], sibling_idx)
  end
end

function ui:build_content_items(content_id_list, sibling_idx)
  if not content_id_list or 0 == #content_id_list then
    return sibling_idx
  end
  for _, content_id in ipairs(content_id_list) do
    sibling_idx = sibling_idx + 1
    local cfg = ShareRes.get_draw_base_rule_content(content_id)
    local obj = self:get_auto_cache(DRAWCARD_BASE_RULE_TEMPLATE_KEY .. cfg.Type)
    obj.transform:SetSiblingIndex(sibling_idx)
    self:get_text("SecendTitle/SecendTitle", obj).text = cfg.Title
    if 1 == cfg.Type then
      self:get_child_gameobj("SecendTitle", obj):SetActive(cfg.Title ~= "")
      self:get_text("DescTem", obj).text = cfg.ContentText
    elseif 2 == cfg.Type then
      local qulity_color = QUALITY_COLOR[cfg.Quality] or QUALITY_COLOR[0]
      self:get_image("SecendTitle/Quality", obj).color = util_get_color(tonumber(qulity_color, 16))
      if cfg.Buddys then
        for _, id in ipairs(cfg.Buddys) do
          local buddy_obj = self:get_auto_cache(DRAWCARD_BASE_RULE_TEMPLATE_KEY2_CHILD)
          local lua_obj = RULE_BASE_BUDDY_ITEM:ui_wrap_ex(self, buddy_obj, true)
          self.v_child_item_list[#self.v_child_item_list + 1] = lua_obj
          buddy_obj.transform:SetParent(obj.transform, false)
          lua_obj:set_data(id)
        end
      end
    end
  end
  return sibling_idx
end

function ui:clear_child_item_ui_wrap()
  if self.v_child_item_list then
    for _, lua_obj in pairs(self.v_child_item_list) do
      lua_obj:ui_hide()
      lua_obj:ui_destroy()
    end
    self.v_child_item_list = nil
  end
end

function ui:ui_on_hide()
  self:clear_child_item_ui_wrap()
end

function ui:get_fake_pool_id()
  local pool_vo = DrawCardMgr:get_pool_vo(self.v_group_id, self.v_pool_id)
  if nil == pool_vo then
    return
  end
  local choose_id = pool_vo.choose_id
  if not choose_id or 0 == choose_id then
    return
  end
  local choose_cfg = ShareRes.create("draw.draw_pool_choose_group", choose_id)
  return choose_cfg.FakePoolId
end

return ui
