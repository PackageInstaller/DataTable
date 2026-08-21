local Base = require("ui.uiobject")
local M = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local TEMPLATE_KEY = {
  MONSTER_ITEM = "MONSTER_ITEM"
}

function M:ui_finish_load()
  local cur_temp = self.v_uiobjects.Npc_Item
  self:register_exist_auto_template(TEMPLATE_KEY.MONSTER_ITEM, cur_temp, cur_temp.transform.parent.gameObject)
  local MODEL = {
    v_cur_cast_name = {
      "CastName",
      BIND_TYPE.TEXT
    },
    v_magic_lv_input = {
      "MagicLv",
      BIND_TYPE.INPUT
    }
  }
  self:init_model(MODEL)
  self.v_magic_input = self:get_inputfield(nil, self.v_uiobjects.InputMagic)
  self.v_magic_list = {}
  self:set_inputfield_listener(self.v_magic_input, nil, function()
    self:_on_input_complete()
  end)
  self.v_caster = nil
  self:set_button("ClearAllBtn", function()
    self:_clear_all_npc_all_magic()
  end)
  self:set_button("CastToGodBtn", function()
    self:_add_magic(SceneMgr:get_god_npc())
  end)
end

function M:ui_on_show()
  self:_refresh_magic_info()
  self:_refresh_cur_unit_list()
end

function M:ui_on_hide()
end

function M:_regist_client_event()
end

function M:_refresh_magic_info()
end

function M:_refresh_cur_unit_list()
  local npc_list = SceneMgr:get_all_npc()
  local hero_list = SceneMgr:get_hero_list()
  self:give_back_auto_cache(TEMPLATE_KEY.MONSTER_ITEM, false)
  if nil ~= hero_list and nil ~= next(hero_list) then
    for hero_uuid, hero in pairs(hero_list) do
      self:_set_data(hero)
    end
  end
  if nil ~= npc_list and nil ~= next(npc_list) then
    for npc_uuid, npc in pairs(npc_list) do
      self:_set_data(npc)
    end
  end
end

function M:_set_data(unit)
  local obj = self:get_auto_cache(TEMPLATE_KEY.MONSTER_ITEM)
  local name = self:get_text("Npc_Name", obj)
  name.text = unit:get_name()
  local setBtn = self:get_button("SetBtn", obj)
  setBtn.onClick:RemoveAllListeners()
  setBtn.onClick:AddListener(function()
    self:_set_magic_caster(unit)
  end)
  local clearBtn = self:get_button("ClearBtn", obj)
  clearBtn.onClick:RemoveAllListeners()
  clearBtn.onClick:AddListener(function()
    self:_clear_all_magic(unit)
  end)
  local addBtn = self:get_button("AddBtn", obj)
  addBtn.onClick:RemoveAllListeners()
  addBtn.onClick:AddListener(function()
    self:_add_magic(unit)
  end)
  local clearAddBtn = self:get_button("ClearAddBtn", obj)
  clearAddBtn.onClick:RemoveAllListeners()
  clearAddBtn.onClick:AddListener(function()
    self:_clear_add_magic(unit)
  end)
end

function M:_on_input_complete()
  local str = self.v_magic_input.text
  local list = Util.split_str(str, ",")
  self.v_magic_list = {}
  for _, v in ipairs(list) do
    local magic_id = tonumber(v)
    if nil ~= magic_id then
      table.insert(self.v_magic_list, magic_id)
    else
      Log.Error("请正确输入magic的格式！！")
    end
  end
end

function M:_add_magic(unit)
  if self.v_caster == nil then
    self:_set_magic_caster(unit)
  end
  local lv = tonumber(self.v_magic_lv_input.text)
  for _, v in pairs(self.v_magic_list) do
    Log.Info("为单位", unit:get_name(), "添加了magic_id=", v, "，施放单位是", self.v_caster:get_name())
    unit.magic_mgr:add_magic(self.v_caster, v, nil, nil, lv)
  end
end

function M:_set_magic_caster(caster)
  self.v_caster = caster
  self.v_cur_cast_name.text = caster:get_name()
end

function M:_clear_add_magic(unit)
  if self.v_caster == nil then
    self:_set_magic_caster(unit)
  end
  for _, v in pairs(self.v_magic_list) do
    Log.Info("为单位", unit:get_name(), "移除了magic_id=", v)
    unit.magic_mgr:remove_first_magic(v)
  end
end

function M:_clear_all_magic(unit)
  if self.v_caster == nil then
    self:_set_magic_caster(unit)
  end
  unit.magic_mgr:remove_all_magic()
end

function M:_clear_all_npc_all_magic()
  local list = SceneMgr:get_all_npc()
  self:give_back_auto_cache(TEMPLATE_KEY.MONSTER_ITEM, false)
  if nil == list or nil == next(list) then
    return
  end
  for npc_uuid, npc in pairs(list) do
    self:_clear_all_magic(npc)
  end
end

return M
