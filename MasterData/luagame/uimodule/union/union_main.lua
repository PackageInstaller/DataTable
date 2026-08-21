local Base = require("ui.uibase")
local UnionCfg = require("uimodule.union.union_config")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_ret1 = {
    "BtnRet1",
    BIND_TYPE.BUTTON
  },
  v_create = {
    "Create",
    BIND_TYPE.TOGGLE
  },
  v_message = {
    "Message",
    BIND_TYPE.TOGGLE
  },
  v_pagelist = {
    "Pagelist",
    BIND_TYPE.OBJECT
  },
  v_search = {
    "Search",
    BIND_TYPE.TOGGLE
  }
}
local UNION_PAGES = UnionCfg.UNION_PAGES
local CHILDREN_UIS = {
  [UNION_PAGES.SEARCH] = {
    tog_name = "v_search",
    ui_name = "union_search"
  },
  [UNION_PAGES.CREATE] = {
    tog_name = "v_create",
    ui_name = "union_create"
  },
  [UNION_PAGES.INVITATAION] = {
    tog_name = "v_message",
    ui_name = "union_invite_message"
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self.v_togs = {}
  for k, v in pairs(CHILDREN_UIS) do
    self.v_togs[k] = self[v.tog_name]
    self:set_toggle_listener(self[v.tog_name], function(isOn)
      self:_onclick_toggle(k, isOn)
    end)
  end
  local redPoint = self:get_child_gameobj("RedPoint", self.v_message.gameObject)
  RedPointMgr:bind_redpoint(self, redPoint, RedEnum.JION_UNION_INVITE, RedEnum.UNION)
end

function ui:ui_on_show(tog_name, ...)
  local has_union = UnionMgr:get_in_union()
  self.v_pagelist:SetActive(not has_union)
  if has_union then
    UIMgr:get_ui("union_lobby"):ui_show(tog_name, ...)
    return
  end
  local def_tog = self:_get_default_enter()
  if tog_name then
    def_tog = tog_name
  end
  self.v_cur_tog = ""
  self.v_param = table.pack(...)
  self.v_togs[def_tog].isOn = true
  self:_onclick_toggle(def_tog, true)
  self:_regist_client_event()
end

function ui:ui_on_hide()
  UnionMgr:refresh_redpoint()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_HAS_UNION_STATE_UPDATE, self._response_in_union_state_update, self)
end

function ui:open_lobby()
  self.v_pagelist:SetActive(false)
  if self.v_cur_ui then
    self.v_cur_ui:ui_hide()
  end
  UIMgr:get_ui("union_lobby"):ui_show()
end

function ui:_get_default_enter()
  return UNION_PAGES.SEARCH
end

function ui:_onclick_toggle(tog_name, isOn)
  if not isOn or self.v_cur_tog == tog_name then
    return
  end
  self.v_cur_tog = tog_name
  if self.v_cur_ui then
    self.v_cur_ui:ui_hide()
  end
  local ui_name = CHILDREN_UIS[tog_name].ui_name
  self.v_cur_ui = UIMgr:get_ui(ui_name)
  self.v_cur_ui:ui_show(table.unpack(self.v_param))
end

function ui:_response_in_union_state_update(msg)
  local in_union = msg.mm_x
  if not in_union then
    return
  end
  if UIMgr:try_get_visible_ui("union_lobby") then
    return
  end
  self:open_lobby()
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  local param
  if self.v_param then
    param = table.unpack(self.v_param)
  end
  return self.v_cur_tog, param
end

return ui
