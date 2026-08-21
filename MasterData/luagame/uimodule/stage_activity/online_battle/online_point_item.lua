local Base = require("ui.uiobject")
local CommonDef = require("cs_share.common_define")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local ui = Util.create_child_mt(Base)
local ACTY_TYPE = CommonDef.ACTY_TYPE

function ui:ui_finish_load()
  local btn = Util.get_button(nil, self.v_object)
  self:set_button_listener(btn, function()
    self:click_stage_tem()
  end)
end

function ui:ui_on_show(point_id, ...)
  self.v_point_id = point_id
  self.v_point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  self:refresh_mark_state(false)
  self:load_chapter_bg()
  self:refresh_chapter_index()
  self:refresh_chapter_state()
  self:refresh_chapter_name()
  self:refresh_point_type_icon()
  self:refresh_lock_state()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh_mark_state(is_visible)
  local mark_img = Util.get_child_gameobj("IconNow", self.v_uiobjects.StNow)
  mark_img:SetActive(is_visible)
end

function ui:load_chapter_bg()
  local bg_path = self.v_point_cfg.PointBgPath
  local img = self.v_uicompents.StBg_img
  local show = bg_path and "" ~= bg_path
  img:SetActive(show)
  if not show then
    return
  end
  ResMgr:load_set_icon(img, bg_path, nil, true)
end

function ui:refresh_chapter_name()
  local name_txt = self.v_uicompents.StName_txt
  local name = self.v_point_cfg.PointName
  name_txt.text = name
end

function ui:refresh_chapter_index()
  local index_txt = self.v_uicompents.StNum_txt
  local index = self.v_point_cfg.SerialNum
  index_txt.text = index
end

function ui:refresh_point_type_icon()
  local point_cfg = self.v_point_cfg
  local fight_obj = self.v_uiobjects.StFight
  local story_obj = self.v_uiobjects.StStory
  fight_obj:SetActive(point_cfg.PointType == CHAPTER_CONFIG.POINT_TYPE.FIGHT)
  story_obj:SetActive(point_cfg.PointType == CHAPTER_CONFIG.POINT_TYPE.STORY)
end

function ui:click_stage_tem()
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SELECT_STAGE_TEM)
  msg.mm_x = self.v_point_id
end

function ui:refresh_chapter_state()
  local has_pass = ActivityMgr:invoke(ACTY_TYPE.ONLINE_BATTLE, "get_has_pass_point", self.v_point_id)
  local complete_obj = self.v_uiobjects.StCom
  complete_obj:SetActive(has_pass)
  self.v_uiobjects.ComMask1:SetActive(has_pass)
  self.v_uiobjects.ComMask2:SetActive(has_pass)
end

function ui:refresh_lock_state()
  local front_id = self.v_point_cfg.FrontPointId
  if 0 == front_id then
    return
  end
  local has_pass = ActivityMgr:invoke(ACTY_TYPE.ONLINE_BATTLE, "get_has_pass_point", front_id)
  self.v_uiobjects.Lock:SetActive(not has_pass)
end

return ui
