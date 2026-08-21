local Base = require("ui.uibase")
local SaticSv = require("ui.widget.static_scroll_view")
local LvTemClass = Util.create_child_mt(require("ui.uiobject"))
local ItemTemClass = Util.create_child_mt(require("ui.uiobject"))
local LvTemKey = "MINESWEEPER_LVTEM"
local ItemTemKey = "MINESWEEPER_ITEMTEM"
local ui = Util.create_child_mt(Base)
ui.Panel_Type = {Level = 1, Item = 2}

function LvTemClass:ui_finish_load()
end

function LvTemClass:set_data(data)
  local start_time = data.StartTime and Date.get_time_stamp_by_scheme_id(data.StartTime)
  local server_time = Date.server_time()
  if start_time and start_time > server_time then
    self.v_uiobjects.Lock:SetActiveEx(true)
    self.v_uiobjects.Content:SetActiveEx(false)
    self.v_uicompents.Time_txt.text = Date.get_time_format_7(start_time - server_time) .. "后解锁"
  else
    self.v_uiobjects.Content:SetActiveEx(true)
    self.v_uiobjects.Lock:SetActiveEx(false)
    self.v_uicompents.Desc_txt.text = data.Desc
    self.v_uicompents.LvNum_txt.text = data.Level
    local knowledge_level = MineSweeperMgr.knowledge_level
    self.v_uiobjects.LvBgLock:SetActiveEx(knowledge_level < data.Level)
  end
end

function LvTemClass:on_clear()
end

function ItemTemClass:ui_finish_load()
end

function ItemTemClass:set_data(data)
  local bless_id = data[1]
  local bless_cfg = ShareRes.get_minesweeper_bless_cfg(bless_id)
  local quality_cfg = ShareRes.get_minesweeper_bless_quality_cfg(bless_cfg.Quality)
  local icon_img = Util.get_image("Icon_", self.v_object)
  local quality_img = Util.get_image("QuailityIcon_", self.v_object)
  ResMgr:load_set_icon(icon_img, bless_cfg.Icon)
  ResMgr:load_set_icon(quality_img, quality_cfg.Icon)
  local btn = Util.get_button(nil, self.v_object)
  self:set_button_listener(btn, function()
    self.v_parent_ui:set_item_info(data.idx)
  end)
end

function ItemTemClass:on_clear()
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("Btn_ItemInfo", function()
    self:set_panel_type(self.Panel_Type.Item)
  end)
  self:set_button("Btn_LvList", function()
    self:set_panel_type(self.Panel_Type.Level)
  end)
  self.v_static_sv_level = SaticSv:new(self, self.v_uiobjects.LvContent, LvTemClass, LvTemKey)
  self.v_static_sv_item = SaticSv:new(self, self.v_uiobjects.ItemContent, ItemTemClass, ItemTemKey)
end

function ui:ui_on_show()
  self:refresh()
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh()
  local minesweeper_chapter_info = MineSweeperMgr:get_minesweeper_chapter_info()
  local minesweep_chapter_id = minesweeper_chapter_info.chapter_id
  local level, level_range_begin, level_range_end = MineSweeperMgr:calc_minesweeper_knowledge_level(minesweeper_chapter_info.knowledge_level_score, minesweep_chapter_id, true)
  self.v_uicompents.LvNum_txt.text = level
  self.v_uicompents.ExpNum_txt.text = (level_range_begin or "-") .. "/" .. (level_range_end or "-")
  local minesweeper_chapter_cfg = ShareRes.create("minesweeper.minesweeper_chapter")[minesweep_chapter_id]
  local knowledge_level_id = minesweeper_chapter_cfg.KnowledgeLevelId
  local bless_pool_id = minesweeper_chapter_cfg.BlessId
  self.v_drop_list = ShareRes.create("minesweeper.minesweeper_bless_pool")[bless_pool_id].DropList
  self.v_static_sv_item:update_list(self.v_drop_list)
  local knowledge_level_cfg = ShareRes.create("minesweeper.minesweeper_level")[knowledge_level_id]
  local temp = {}
  for _, v in ipairs(knowledge_level_cfg) do
    if not v.StartTime or v.StartTime and Date.get_time_stamp_by_scheme_id(v.StartTime) < Date.server_time() then
      table.insert(temp, v)
    else
      table.insert(temp, v)
      break
    end
  end
  self.v_static_sv_level:update_list(temp)
  self:set_item_info(1)
end

function ui:set_panel_type(panel_type)
  if panel_type == self.v_cur_panel_type then
    return
  end
  self.v_cur_panel_type = panel_type
  if self.v_cur_panel_type == self.Panel_Type.Level then
    self.v_uiobjects.HBLvList:SetActiveEx(true)
    self.v_uiobjects.HBItemInfo:SetActiveEx(false)
  elseif self.v_cur_panel_type == self.Panel_Type.Item then
    self.v_uiobjects.HBItemInfo:SetActiveEx(true)
    self.v_uiobjects.HBLvList:SetActiveEx(false)
  end
end

function ui:set_item_info(index)
  self:set_panel_type(self.Panel_Type.Item)
  local bless_id = self.v_drop_list[index][1]
  local bless_cfg = ShareRes.get_minesweeper_bless_cfg(bless_id)
  local quality_cfg = ShareRes.get_minesweeper_bless_quality_cfg(bless_cfg.Quality)
  ResMgr:load_set_icon(self.v_uicompents.ItemIcon_img, bless_cfg.Icon)
  ResMgr:load_set_icon(self.v_uicompents.QualityIcon_img, quality_cfg.Icon)
  self.v_uicompents.ItemName_txt.text = bless_cfg.Name
  self.v_uicompents.ItemDesc_txt.text = bless_cfg.Desc
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(MineSweeperMgr.activity_id, self.v_ui_name, nil, true)
end

return ui
