local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local CommonDef = require("cs_share.common_define")
local MODEL = {
  v_btn_main = {
    "BtnMain",
    BIND_TYPE.BUTTON
  },
  v_btn_ret1 = {
    "BtnRet1",
    BIND_TYPE.BUTTON
  },
  v_chap_tem = {
    "ChapTem",
    BIND_TYPE.BUTTON
  },
  v_content = {
    "Content",
    BIND_TYPE.OBJECT
  }
}
local linear_type_key = "linear_type_key"

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:register_exist_auto_template(linear_type_key, self.v_chap_tem, self.v_content)
  local cfg_list = ShareRes.create("chapter.linear")
  self.linear_type_list = {}
  for i, cfg in pairs(cfg_list) do
    table.insert(self.linear_type_list, cfg)
  end
  table.sort(self.linear_type_list, function(a, b)
    return a.Order < b.Order
  end)
end

function ui:ui_on_show()
  self:give_back_auto_cache(linear_type_key)
  local is_need_show_up = true
  for _, cfg in ipairs(self.linear_type_list) do
    local obj = self:get_auto_cache(linear_type_key)
    local up_item = Util.get_child_gameobj("Up", obj)
    local bottom_item = Util.get_child_gameobj("Bottom", obj)
    up_item:SetActive(is_need_show_up)
    bottom_item:SetActive(not is_need_show_up)
    local item
    if is_need_show_up then
      item = up_item
    else
      item = bottom_item
    end
    is_need_show_up = not is_need_show_up
    self:refresh_item_info(cfg, item)
  end
end

function ui:refresh_item_info(cfg, item)
  local is_open, tips = self:refresh_item_lock_state(cfg, item)
  self:refresh_item_name_and_index(is_open, cfg, item)
  self:refresh_item_icon(cfg, item)
  self:refresh_item_star(cfg, item)
  self:refresh_red(cfg, item)
  local item_btn = Util.get_button(nil, item)
  self:set_button_listener(item_btn, function()
    if is_open then
      UIMgr:get_ui("ui_linear_stage"):ui_show(cfg.Id)
    else
      Util.show_message_tip(tips)
    end
  end)
end

function ui:refresh_item_lock_state(cfg, item)
  local condition = cfg.Condition
  local tips
  local is_open = Condition:check_condition(condition)
  local lock_obj = Util.get_child_gameobj("Lock", item)
  if is_open then
    lock_obj:SetActive(false)
  else
    lock_obj:SetActive(true)
    local condition = ShareRes.create("condition.condition", condition)
    if condition then
      tips = condition.Desc
    end
  end
  if tips then
    local condition = Util.get_text("Lock/Condition", item)
    condition.text = tips
  end
  return is_open, tips
end

function ui:refresh_item_name_and_index(is_open, cfg, item)
  local name = Util.get_text("Lower/StageName", item)
  name.text = cfg.Name
  local index = Util.get_text("Lower/StageNum/StageNum", item)
  index.text = CommonDef.ROME_NUM[cfg.Id]
  local name_color = name.color
  local index_color = index.color
  if is_open then
    name_color.a = 1
    index_color.a = 1
  else
    name_color.a = 0.4
    index_color.a = 0.6
  end
  name.color = name_color
  index.color = index_color
end

function ui:refresh_item_icon(cfg, item)
  local icon = Util.get_image("StageIcon", item)
  ResMgr:load_set_icon(icon, "UIChapter/" .. cfg.Background, nil, true)
end

function ui:refresh_item_star(cfg, item)
  local now_star = LinearMgr:get_group_star(cfg.Id)
  local max_star = LinearMgr:get_group_max_star(cfg.Id)
  local star_now = Util.get_text("Star/StarNow", item)
  local star_max = Util.get_text("Star/StarMax", item)
  local star_icon_finish = Util.get_child_gameobj("Star/StarIconFinish", item)
  star_now.text = now_star
  star_max.text = max_star
  star_icon_finish:SetActive(now_star == max_star)
end

function ui:refresh_red(cfg, item)
  local red = Util.get_child_gameobj("Red", item)
  local red_id = LinearMgr:get_red_id(cfg.Id)
  RedPointMgr:bind_redpoint(self, red, red_id, Global.red_enum.FIGHT_LINEAR_RED)
end

function ui:refresh_anim(index)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:cache_ui()
  return true
end

return ui
