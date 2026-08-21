local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local ORNAMENT_TIP = {UNLOOK = 1, LOOKED = 2}
local PAGE = {QUALITY = 1, GROUP = 2}
local _tinsert = table.insert
local _tsort = table.sort
local SaticSv = require("ui.widget.static_scroll_view")
local ORNAMENT_ITEM_CLASS = require("uimodule.ornaments.ornament_item")
local ORNAMENT_ITEM_KEY = "ORNAMENT_ITEM_KEY"
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_icon1 = {
    "QualityIcon",
    BIND_TYPE.IMAGE
  },
  v_icon2 = {
    "GroupIcon",
    BIND_TYPE.IMAGE
  },
  v_group_name = {
    "GroupName",
    BIND_TYPE.TEXT
  },
  v_en_name = {
    "EnName",
    BIND_TYPE.TEXT
  },
  v_arrow_flod = {
    "ArrowFlod",
    BIND_TYPE.OBJECT
  },
  v_arrow_unfloded = {
    "ArrowUnFloded",
    BIND_TYPE.OBJECT
  },
  v_orn_content = {
    "OrnContent",
    BIND_TYPE.OBJECT
  },
  v_red_point = {
    "Red",
    BIND_TYPE.OBJECT
  },
  v_orn_tem = {
    "OrnTem",
    BIND_TYPE.TOGGLE
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnDropdown", function()
    local is_active = self.v_orn_content.activeSelf
    self:on_click_btndropdown()
    if not is_active then
      local msg = MsgGame:mq_publish2(Const.MSG_ON_ORNAMENT_GROUP_SELECT)
      msg.mm_obj = self
    end
    if not is_active and self.v_orn_content.activeSelf and not self.v_is_select and self.v_static_sv then
      self.v_static_sv:get_item_by_idx(1):select_item()
    end
  end)
end

function ui:set_data(data)
  local group_info = data.group_info
  local item_info = data.item_info
  local unlocked_ornaments = PlayerMgr:get_ornament_list()
  self.v_ornaments = {}
  self.v_cur_idx = data.idx
  for _, info in pairs(item_info) do
    local ornament_id = info.Id
    local ornament_info = {}
    local unlock_data = unlocked_ornaments[ornament_id] or {}
    ornament_info.ornament = info
    ornament_info.sort_order = info.ShowPriority
    ornament_info.is_unlock = nil ~= unlocked_ornaments[ornament_id] or nil == next(info.Condition)
    ornament_info.is_read = unlock_data.tip == ORNAMENT_TIP.LOOKED
    ornament_info.show_red = ornament_info.is_unlock and ornament_info.is_read == false
    ornament_info.group_idx = self.v_cur_idx
    _tinsert(self.v_ornaments, ornament_info)
  end
  
  local function sort_func(a, b)
    if data.cur_page == PAGE.QUALITY then
      if a.is_unlock == b.is_unlock then
        return a.sort_order < b.sort_order
      else
        return a.is_unlock
      end
    else
      return a.sort_order < b.sort_order
    end
  end
  
  _tsort(self.v_ornaments, sort_func)
  self.v_icon1:SetActive(false)
  self.v_icon2:SetActive(false)
  self["v_icon" .. data.cur_page]:SetActive(true)
  ResMgr:load_set_icon(self["v_icon" .. data.cur_page], group_info.Icon)
  self.v_group_name.text = group_info.Name
  self.v_en_name.text = group_info.EnName
  self:flod_content(1 ~= self.v_cur_idx)
  self.v_is_select = 1 == self.v_cur_idx
  self.v_red_point:SetActive(self.v_show_red_point)
  if not self.v_static_sv then
    self.v_static_sv = SaticSv:new(self, self.v_orn_content, ORNAMENT_ITEM_CLASS, ORNAMENT_ITEM_KEY .. self.v_cur_idx)
  end
  self.v_static_sv:update_list(self.v_ornaments)
end

function ui:on_refresh()
  self.v_show_red_point = false
end

function ui:on_click_btndropdown()
  local change_before = self.v_orn_content.activeSelf
  self.v_orn_content:SetActive(not change_before)
  self.v_arrow_flod:SetActive(change_before)
  self.v_arrow_unfloded:SetActive(not change_before)
end

function ui:flod_content(flod)
  self.v_arrow_flod:SetActive(flod)
  self.v_arrow_unfloded:SetActive(not flod)
  self.v_orn_content:SetActive(not flod)
end

function ui:set_selected(is_select)
  self:flod_content(not is_select)
  self.v_is_select = is_select
end

function ui:on_clear()
  if self.v_static_sv then
    self.v_static_sv:clear()
    self.v_static_sv = nil
  end
end

return ui
