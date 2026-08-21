local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("EndLessFloor", function()
    self:ui_hide()
    if self.v_endless_cb then
      self.v_endless_cb()
    end
  end)
  self:set_button("ResetFloor", function()
    MineSweeperMgr:request_reset_floor(function()
      self:ui_hide()
    end)
  end)
  self:set_button("BtnConfirm", function()
    MineSweeperMgr:request_minesweeper_settlement(function()
      self:ui_hide()
      if self.v_confirm_cb then
        self.v_confirm_cb()
      end
    end)
  end)
end

function ui:ui_on_show(settlement_type, game_mode, confirm_cb, endless_cb)
  self.v_settlement_type = settlement_type
  self.v_confirm_cb = confirm_cb
  self.v_endless_cb = endless_cb
  self.v_game_mode = game_mode
  self:refresh()
  if self.v_settlement_type == MineSweeperMgr.GAME_SETTLEMENT_TYPE.SUCCESS then
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_minesweeper_settle_suc_UI_SOUND)
  else
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_minesweeper_settle_fail_UI_SOUND)
  end
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh()
  self.v_uiobjects.EndLessFloor:SetActiveEx(self.v_settlement_type == MineSweeperMgr.GAME_SETTLEMENT_TYPE.SUCCESS and self.v_game_mode == MineSweeperMgr.GAME_MODE.BASE)
  self.v_uiobjects.ResetFloor:SetActiveEx(self.v_settlement_type == MineSweeperMgr.GAME_SETTLEMENT_TYPE.FAIL)
  self.v_uiobjects.Fail:SetActiveEx(self.v_settlement_type == MineSweeperMgr.GAME_SETTLEMENT_TYPE.FAIL or self.v_settlement_type == MineSweeperMgr.GAME_SETTLEMENT_TYPE.MANUAL_EXIT)
  self.v_uiobjects.Success:SetActiveEx(self.v_settlement_type == MineSweeperMgr.GAME_SETTLEMENT_TYPE.SUCCESS)
  local minesweeper_chapter_info = MineSweeperMgr:get_minesweeper_chapter_info()
  self.v_uicompents.FloorNum_txt.text = minesweeper_chapter_info.floor_idx
  self.v_uicompents.ScoreNum_txt.text = minesweeper_chapter_info.cur_score
  local cur_knowledge_level = MineSweeperMgr.knowledge_level
  self.v_uicompents.LvNum_txt.text = cur_knowledge_level
  local next_score = minesweeper_chapter_info.knowledge_level_score + minesweeper_chapter_info.cur_score
  local next_knowledge_level, _, level_range_end = MineSweeperMgr:calc_minesweeper_knowledge_level(next_score, minesweeper_chapter_info.chapter_id, true)
  local diff = level_range_end and next_knowledge_level - cur_knowledge_level or 0
  self.v_uicompents.LvNumAdd_txt.text = "+" .. diff
  self.v_uiobjects.Max:SetActiveEx(not level_range_end)
end

return ui
