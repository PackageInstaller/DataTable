local UnionCfg = require("uimodule.union.union_config")
local UnionHelper = require("uimodule.union.union_helper")
local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_state = {
    "StateLab",
    BIND_TYPE.TEXT
  },
  v_union_name = {
    "UnionName",
    BIND_TYPE.TEXT
  },
  v_leader_name = {
    "LeaderName",
    BIND_TYPE.TEXT
  },
  v_member_num = {
    "MemberNum",
    BIND_TYPE.TEXT
  },
  v_select = {
    "Select",
    BIND_TYPE.OBJECT
  }
}
local STATE = UnionCfg.JOIN_STATE
local STATE_LAB = {
  [STATE.FULL] = Util.format_str("人数已满"),
  [STATE.JOIN] = Util.format_str("可加入"),
  [STATE.APPLY] = Util.format_str("可申请"),
  [STATE.APPLYING] = Util.format_str("申请中")
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_btn = self:get_button(nil, self.v_object.obj)
  self:set_button_listener(self.v_btn, function()
    self:_onclick_union_tog()
  end)
end

function ui:ui_on_hide()
end

function ui:set_data(go, data_list, index)
  self.v_index = index
  self.v_uniton_data = data_list[index]
  self.v_union_name.text = self.v_uniton_data.name
  self.v_leader_name.text = self.v_uniton_data.chairman_info.name
  local member_count = self.v_uniton_data.member_num
  local member_max = self.v_uniton_data.member_num_limit
  self.v_member_num.text = string.format("%s/%s", member_count, member_max)
  local state = UnionHelper.get_join_state(self.v_uniton_data)
  self.v_state.text = STATE_LAB[state]
  self:force_click_tog(1 == index)
end

function ui:force_click_tog(isOn)
  self:set_select_bg(isOn)
  if isOn then
    self:_onclick_union_tog()
  end
end

function ui:set_select_bg(isOn)
  self.v_select:SetActive(isOn)
end

function ui:_onclick_union_tog()
  self:set_select_bg(true)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_CHOOSE_UNION_ITEM)
  msg.mm_obj = self.v_uniton_data
  msg.mm_x = self.v_index
end

return ui
