local Base = require("ui.uibase")
local M = Util.create_child_mt(Base)
local ICON_PATH = "Icon/BattleRune/%s"
local OFFSET = -777
local PAGE_NUM = 12

function M:ui_finish_load()
  self:set_button("Return", function()
    self:ui_hide()
  end)
end

function M:ui_on_show(rune_id, last_lv, next_lv)
  self.v_rune_id = rune_id
  self.v_last_lv = last_lv
  self.v_next_lv = next_lv
  self:_refresh_rune_info()
  self:_refresh_rune_upgrade_info()
end

function M:ui_on_hide()
end

function M:_regist_client_event()
end

function M:_refresh_rune_info()
  local rune_cfg = ShareRes.create("battle.battle_rune", self.v_rune_id)
  local rune_name = rune_cfg.Name
  self.v_uicompents.OldChangeAttrValue_txt.text = Util.format_str(rune_name)
  self.v_uicompents.ChangeAttrValue_txt.text = Util.format_str(rune_name)
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, string.format(ICON_PATH, rune_cfg.Icon))
  self.v_uicompents.CurLevel_txt.text = self.v_last_lv
  self.v_uicompents.NextLevel_txt.text = self.v_next_lv
end

function M:_refresh_rune_upgrade_info()
  local lvCfg = ShareRes.create("battle.battle_rune_level_by_parent", self.v_rune_id)
  local data = lvCfg[self.v_next_lv]
  self.v_uicompents.Desc_txt.text = data.AttrName
  self.v_uicompents.AttrValue_txt.text = data.AttrValue
end

return M
