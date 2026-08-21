local Base = require("ui.uiobject")
local M = Util.create_child_mt(Base)
local HERO_ICON_PATH = "Icon/Profile/%s"
local ITEM_QUALITY_PATH = "UICommon/%s"
local _floor = math.floor
local ONE_HOUR_SEC = 3600
local ONE_MINUTE_SEC = 60

function M:ui_finish_load()
end

function M:ui_on_hide()
  self.v_data = nil
end

function M:set_data(go, data_list, index)
  self.v_data = data_list[index]
  self.v_uiobjects.RankNumBgList:SetActive(index <= 3)
  if index <= 3 then
    for i = 1, 3 do
      self.v_uiobjects["RankNumBg" .. i]:SetActive(i == index)
    end
    self.v_uiobjects.RankNum:SetActive(false)
  else
    self.v_uiobjects.RankNum:SetActive(true)
    self.v_uicompents.RankNum_txt.text = index
  end
  if self.v_data.rank == nil then
    self.v_uiobjects.OccupyObj:SetActive(false)
    self.v_uiobjects.EmptyObj:SetActive(true)
    local empty_btn = Util.get_button(nil, self.v_uiobjects.EmptyObj)
    self:set_button_listener(empty_btn, function()
      local msg = MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_ENDLESS_RANK_ICON_CLICK)
      msg.mm_obj = nil
    end)
    return
  else
    self.v_uiobjects.OccupyObj:SetActive(true)
    self.v_uiobjects.EmptyObj:SetActive(false)
  end
  local snap_info = self.v_data.snapinfo
  local avatar_cfg = ShareRes.create("player.player_avatar", snap_info.face_id)
  ResMgr:load_set_icon(self.v_uicompents.Profile_img, string.format(HERO_ICON_PATH, avatar_cfg.Icon))
  self.v_uicompents.PlayerName_txt.text = snap_info.name
  self.v_uicompents.Score_txt.text = RankMgr:get_score(self.v_data.rank_name, self.v_data.value)
  local buddy_list = {}
  for k, v in pairs(self.v_data.infinite_data.buddy_list) do
    table.insert(buddy_list, v)
  end
  table.sort(buddy_list, function(a, b)
    return a.pos < b.pos
  end)
  local len = UtilTable.hash_lenth(buddy_list)
  for i = 1, 3 do
    self.v_uiobjects["CharTem" .. i]:SetActive(i <= len)
    self.v_uiobjects["NoChar" .. i]:SetActive(i > len)
    if i > len then
    else
      local buddy_info = buddy_list[i]
      local char_obj = self.v_uiobjects["CharTem" .. i]
      local char_bg = self:get_image("CharBg", char_obj)
      local char_icon = self:get_image("CharIcon", char_obj)
      local char_pow = self:get_text("CharPowLayout/CharPow", char_obj)
      local buddy_cfg = ShareRes.get_buddy_cfg(buddy_info.buddy_id)
      local quality_path = UtilUI.get_quality_icon(buddy_cfg.Quality)
      local icon_path = UtilUI.get_hero_images(buddy_info.buddy_id, 1, buddy_info.fashion)
      ResMgr:load_set_icon(char_bg, quality_path)
      ResMgr:load_set_icon(char_icon, icon_path)
      char_pow.text = buddy_info.power
    end
  end
  local icon_btn = Util.get_button(nil, self.v_uiobjects.OccupyObj)
  self.function_btn_container = Util.get_child_gameobj("FunctionBtnContainer", self.v_uiobjects.OccupyObj)
  local look_btn = Util.get_button("Look", self.function_btn_container)
  self.function_btn_container:SetActive(false)
  self:set_button_listener(icon_btn, function()
    local uuid = self.v_data.snapinfo.uuid
    if uuid == Global.player_uuid then
      return
    end
    local msg = MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_ENDLESS_RANK_ICON_CLICK)
    msg.mm_obj = self
  end)
  self:set_button_listener(look_btn, function()
    self.function_btn_container:SetActive(false)
    local uuid = self.v_data.snapinfo.uuid
    if uuid == Global.player_uuid then
      return
    end
    Network:call("c2gs_search_role", {
      target_uuid = self.v_data.snapinfo.uuid
    }, function(ok, resp)
      if not ok then
        return
      end
      if not resp.role_list or 0 == #resp.role_list then
        return
      end
      UIMgr:get_ui("ui_player_info"):ui_show(resp.role_list[1])
      MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_ENDLESS_HIDE_RANK_FUNCTION_PANEL)
    end)
  end)
end

function M:hide_function_btn()
  if not Util.is_nil(self.function_btn_container) then
    self.function_btn_container:SetActive(false)
  end
end

function M:show_function_btn()
  if not Util.is_nil(self.function_btn_container) then
    self.function_btn_container:SetActive(true)
  end
end

return M
