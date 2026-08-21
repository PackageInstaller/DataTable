local Base = require("ui.uibase")
local LoopListClass = require("ui.widget.infinite_loop_list")
local ItemClass = require("uimodule.union.union_member.union_member_item")
local UnionCfg = require("uimodule.union.union_config")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_clear = {
    "BtnClear",
    BIND_TYPE.BUTTON
  },
  v_btn_search = {
    "BtnSearch",
    BIND_TYPE.BUTTON
  },
  v_search_input = {
    "SearchInput",
    BIND_TYPE.INPUT
  },
  v_union_tem = {
    "UnionTem",
    BIND_TYPE.OBJECT
  }
}
local UPDATE_INTERVAL = UnionCfg.MEMBER_LIST_UPDATE_INTERVAL

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnClear", function()
    self:_onclick_clear_btn()
  end)
  self:set_button("BtnSearch", function()
    self:_onclick_search_btn()
  end)
  self:set_inputfield_listener(self.v_search_input, function()
    self:_on_input()
  end, function()
    self:_on_input_end()
  end)
  self.v_list_view = LoopListClass:new(self, self.v_uiobjects.MemberScroll, ItemClass, nil, true)
end

function ui:ui_on_show()
  self.v_total_time = 0
  self.v_search_input.text = ""
  self.v_search_target = ""
  self.v_uiobjects.BtnClear:SetActive(false)
  self.v_info_panel = self.v_panels.union_memebr_info_tips
  self.v_info_panel:set_enable(false)
  UnionMgr:request_get_union_info(function()
    self:_set_member_list()
  end)
  self:_regist_client_event()
end

function ui:ui_on_update(delta_time)
  self.v_total_time = self.v_total_time + delta_time
  if self.v_total_time >= UPDATE_INTERVAL then
    self.v_total_time = self.v_total_time - UPDATE_INTERVAL
    self:_set_member_list()
  end
end

function ui:ui_on_hide()
  self.v_list_view:ui_on_hide()
end

function ui:ui_on_destroy()
  self.v_list_view:ui_on_destroy()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_UNION_MEMBER_DELET, self._response_member_delet, self)
  self:bind_auto_mq(Const.MSG_ON_CHOOSE_UNION_MEMBER_ITEM, self._show_member_info_tips, self)
  self:bind_auto_mq(Const.MSG_ON_UNION_TITLE_UPDATE, self._response_union_title_update, self)
end

function ui:_set_member_list(need_msg)
  local list = self:_fliter_list(UnionMgr:get_member_list(), "name", self.v_search_target)
  if self.v_search_target and self.v_search_target ~= "" and 0 == #list then
    if need_msg then
      Util.show_message_tip(2311)
    end
    return
  end
  self.v_list_view:refresh_data(list)
end

function ui:_fliter_list(list, key, fliter_str)
  if not fliter_str or "" == fliter_str then
    return list
  end
  local ret = {}
  for _, v in ipairs(list) do
    if v[key] and string.find(v[key], fliter_str) then
      table.insert(ret, v)
    end
  end
  return ret
end

function ui:_on_input()
  local len = Util.get_string_len(self.v_search_input.text)
  self.v_uiobjects.BtnClear:SetActive(len > 0)
end

function ui:_on_input_end()
  self.v_search_target = self.v_search_input.text
end

function ui:_onclick_clear_btn()
  local need_refresh = self.v_search_target ~= ""
  self.v_search_target = ""
  self.v_search_input.text = ""
  if not need_refresh then
    return
  end
  self:_set_member_list()
end

function ui:_onclick_search_btn()
  if self.v_search_target and self.v_search_target ~= "" then
    self:_set_member_list(true)
  end
end

function ui:_response_member_delet(msg)
  self.v_info_panel:set_enable(false)
  UnionMgr:request_get_union_info(function()
    self:_set_member_list()
  end)
end

function ui:_show_member_info_tips(msg)
  local member = msg.mm_obj
  local list = UnionMgr:get_member_list()
  local is_union_member = false
  for _, v in ipairs(list) do
    if v.uuid == member.uuid then
      is_union_member = true
      break
    end
  end
  if not is_union_member then
    Util.show_message_tip(2308)
    self:_set_member_list()
    return
  end
  self.v_info_panel:set_enable(false)
  self.v_info_panel:set_enable(true, member)
end

function ui:_response_union_title_update()
  UnionMgr:request_get_union_info(function()
    self:_set_member_list()
  end)
end

return ui
