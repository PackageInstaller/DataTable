local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BATTLE_DROP_TIPS_TEMPLATE = "BATTLE_DROP_TIPS_TEMPLATE"
local ITEM_ICON_PATH = "Icon/Item/"
local CommonDefine = require("cs_share.common_define")

local function _sort_func(a, b)
  local x = 0
  local y = 0
  if a.Priority then
    x = x + a.Priority * 10000
  end
  if b.Priority then
    y = y + b.Priority * 10000
  end
  x = x + a.quality * 100000 - a.item_cfg.Id
  y = y + b.quality * 100000 - b.item_cfg.Id
  if x ~= y then
    return x > y
  end
  return false
end

function ui:ui_finish_load()
  self:set_button("CloseBtn", function()
    self:ui_hide()
  end)
  self:register_exist_auto_template(BATTLE_DROP_TIPS_TEMPLATE, self.v_uiobjects.DropTem, self.v_uiobjects.DropContent)
  self:bind_auto_mq(Const.MSG_ON_HIDE_UI, self.on_hide_ui, self)
end

function ui:on_hide_ui(msg)
  if msg.mm_obj == "fight" then
    self:ui_hide()
  end
end

function ui:ui_on_show(is_show_all)
  UIMgr:try_hide_ui("ui_battle_item")
  if is_show_all and SceneMgr then
    SceneMgr:set_game_pause(true)
    self.v_is_pause_game = true
  end
  self.v_data_list = TowerMgr:get_tower_progress().award_list or {}
  self:set_data(is_show_all)
end

function ui:ui_on_hide()
  if self.v_is_pause_game and SceneMgr then
    SceneMgr:set_game_pause(false)
  end
  self.v_data_list = {}
  self.v_new_data_list = {}
end

function ui:ui_on_destroy()
end

function ui:get_cur_floor_award()
  local data_list = UtilTable.copy_table(self.v_data_list)
  local tower = TowerMgr:get_tower()
  local last_floor_award_list = tower:get_last_floor_award_list()
  for key, data in pairs(data_list) do
    if last_floor_award_list[key] then
      data.count = data.count - last_floor_award_list[key].count
    end
    if data.count <= 0 then
      data_list[key] = nil
    end
  end
  return data_list
end

function ui:set_data(is_show_all)
  local data_list
  if is_show_all then
    data_list = self.v_data_list
  else
    data_list = self:get_cur_floor_award()
  end
  self:give_back_auto_cache(BATTLE_DROP_TIPS_TEMPLATE)
  self.v_new_data_list = {}
  for index, data in pairs(data_list) do
    local item_cfg = ShareRes.get_item_cfg(data.id)
    data.quality = item_cfg.Quality
    data.Priority = item_cfg.Priority
    data.item_cfg = item_cfg
    table.insert(self.v_new_data_list, data)
  end
  table.sort(self.v_new_data_list, _sort_func)
  for index, data in ipairs(self.v_new_data_list) do
    local obj = self:get_auto_cache(BATTLE_DROP_TIPS_TEMPLATE)
    local DropItemIcon = Util.get_image("DropItemIcon_", obj)
    local DropNum = Util.get_text("DropNum_", obj)
    ResMgr:load_set_icon(DropItemIcon, ITEM_ICON_PATH .. data.item_cfg.Icon)
    DropNum.text = data.count
  end
end

return ui
