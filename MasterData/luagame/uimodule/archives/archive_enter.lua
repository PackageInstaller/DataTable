local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local LocalStorage = require("utils.localstorage")
local achive_fashion_red_key = "achive_fashion_red_key"
local COLLECTION_SYS_OPEN_KEY = 39
local SIGNBOARD_PARAM = Config.SIGNBOARD_PARAM
local BTN_LIST = {
  [1] = {
    btn_name = "BtnNetWork",
    ui_name = "char_map",
    red_id = RedEnum.ARCHIVES_CONCERN_NET
  },
  [2] = {
    btn_name = "BtnDictionary",
    ui_name = "world_dic",
    red_id = RedEnum.ARCHIVES_WORLD_DICTIONARY
  },
  [3] = {
    btn_name = "BtnFashion",
    ui_name = "fashion_book",
    red_id = RedEnum.ARCHIVES_FASHION
  },
  [4] = {
    btn_name = "BtnEnemy",
    ui_name = "enemy_info_sys",
    red_id = RedEnum.ARCHIVES_ENEMY_INFORMATION
  },
  [5] = {
    btn_name = "BtnVideo",
    ui_name = "archive_story",
    red_id = RedEnum.ARCHIVES_MOVE_VIDEO
  },
  [6] = {
    btn_name = "BtnPhoto",
    ui_name = "archive_photo",
    red_id = RedEnum.ARCHIVES_ALBUM_SYS
  },
  [7] = {
    btn_name = "BtnEquip",
    ui_name = "ui_archive_equip",
    red_id = RedEnum.ARCHIVES_EQUIP_SYS,
    first_red_id = RedEnum.ARCHIVES_EQUIP_SYS_FIRST
  }
}

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    if UIMgr:get_next_ui_name() == "uimain_close" then
      UIMgr:get_ui("uimain"):change_model_view_param(SIGNBOARD_PARAM.CHANGE_ROLE, true)
    end
    self:ui_hide()
  end)
  for k, v in ipairs(BTN_LIST) do
    local btn_name = v.btn_name
    self:set_button(btn_name, function()
      if SysOpenMgr:get_is_ui_open(v.ui_name, true) then
        local red_id = v.first_red_id or v.red_id
        ArchiveMgr:clear_red(red_id)
        UIMgr:get_ui(v.ui_name):ui_show()
      end
    end)
    if v.red_id then
      local red_go = self.v_uiobjects[btn_name].transform:Find("RedPoint").gameObject
      RedPointMgr:bind_redpoint(self, red_go, v.red_id)
    end
    if SysOpenMgr:get_is_ui_open(v.ui_name, false) then
      Util.apply_grey("Icon", self.v_uiobjects[btn_name], false)
    else
      Util.apply_grey("Icon", self.v_uiobjects[btn_name], true)
    end
  end
  self:set_button("BtnCollection", function()
    if SysOpenMgr:get_sys_is_open(COLLECTION_SYS_OPEN_KEY, true) then
      UIMgr:get_ui("collection_main"):ui_show()
    end
  end)
end

function ui:ui_on_show()
  local red_go_coll = self.v_uiobjects.BtnCollection.transform:Find("RedPoint").gameObject
  red_go_coll:SetActive(ChapterMgr:is_chapter_collection_red())
end

function ui:cache_ui()
  return true
end

return ui
