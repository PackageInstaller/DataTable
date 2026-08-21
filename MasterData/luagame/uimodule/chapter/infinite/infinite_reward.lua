local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local INFINITE_REWARD_POINT_VIEW_CLASS = require("uimodule.chapter.infinite.infinite_reward_view")
local MODEL = {
  v_full_screen_bg = {
    "FullScreenBackground",
    BIND_TYPE.IMAGE
  },
  v_point_parent = {
    "PointParent",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
end

function ui:ui_on_show(infinite_id)
  self.v_infinite_id = infinite_id
  self:set_full_screen_bg()
  self:init_infinite_reward_point_obj()
end

function ui:ui_on_hide()
  if self.v_infinite_reward_point_lua_obj then
    self:remove_wrap_ui(self.v_infinite_reward_point_lua_obj)
  end
  if self.v_infinite_reward_point_obj then
    ResMgr:destroy_gameobj(self.v_infinite_reward_point_obj)
    self.v_infinite_reward_point_obj = nil
  end
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_infinite_id
end

function ui:set_full_screen_bg()
  local infinite_cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
  ResMgr:load_set_icon(self.v_full_screen_bg, infinite_cfg.BgName, nil, true, self)
end

function ui:init_infinite_reward_point_obj()
  local infinite_cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
  local point_path = infinite_cfg.AdditionAwardPath
  local path = Path.get_full_prefab_path(point_path)
  local infinite_reward_point_obj = ResMgr:load_gameobj(path)
  infinite_reward_point_obj.transform:SetParent(self.v_point_parent.transform, false)
  self.v_infinite_reward_point_obj = infinite_reward_point_obj
  self:wrap_infinite_reward_point_obj()
end

function ui:wrap_infinite_reward_point_obj()
  if not self.v_infinite_reward_point_obj then
    return
  end
  if self.v_infinite_reward_point_lua_obj then
    self:remove_wrap_ui(self.v_infinite_reward_point_lua_obj)
  end
  self.v_infinite_reward_point_lua_obj = INFINITE_REWARD_POINT_VIEW_CLASS:ui_wrap_ex(self, self.v_infinite_reward_point_obj, false)
  self.v_infinite_reward_point_lua_obj:set_enable(true, self.v_infinite_id)
end

return ui
