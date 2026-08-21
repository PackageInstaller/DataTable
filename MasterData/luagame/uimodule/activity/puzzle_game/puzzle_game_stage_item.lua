local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local CommDefine = require("cs_share.common_define")

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(data)
  local cfg = data.cfg
  local idx = cfg.SortId
  self.v_stage_id = cfg.Id
  local x, y, z
  if 0 ~= idx % 2 then
    x, y, z = self.v_uicompents.LowerPos_rect:GetLocalPositionA3()
  else
    x, y, z = self.v_uicompents.UpPos_rect:GetLocalPositionA3()
  end
  self.v_uicompents.Content_rect:SetLocalPositionA(0, y, 0)
  local open_time = data.start_time or 0
  local pre_stage_id = cfg.FrontEpisodeId
  local is_open = open_time <= Date:server_time()
  local is_pre_stage_done = not pre_stage_id or PuzzleGameMgr:is_stage_passed(pre_stage_id)
  local is_unlock = is_open and is_pre_stage_done
  local is_done = data.pass_second > 0
  self.v_uiobjects.PassState:SetActive(is_done)
  self.v_uiobjects.UnlockState:SetActive(not is_done and is_unlock)
  self.v_uiobjects.LockState:SetActive(not is_unlock)
  self.v_uicompents.StageName_txt.text = string.format("关卡%s", idx)
  self.v_uiobjects.Check:SetActive(is_done)
  self.v_uiobjects.Lock:SetActive(not is_unlock)
  self.v_uiobjects.UnlockDesc:SetActive(not is_unlock)
  local str
  if not is_open then
    local remain_time = open_time - Date:server_time()
    if remain_time > 86400 then
      str = string.format("%s天后解锁", math.ceil(remain_time / 86400))
    else
      str = string.format("%s小时后解锁", math.ceil(remain_time / 3600))
    end
  elseif not is_pre_stage_done then
    str = "通关前置关卡"
  end
  self.v_uicompents.UnlockDesc_txt.text = str
  self.v_uiobjects.ScoreNone:SetActive(is_unlock and data.grade == CommDefine.PUZZLE_GAME_SCORE_GRADE.UNKNOW)
  self.v_uiobjects.ScoreA:SetActive(data.grade == CommDefine.PUZZLE_GAME_SCORE_GRADE.A)
  self.v_uiobjects.ScoreS:SetActive(data.grade == CommDefine.PUZZLE_GAME_SCORE_GRADE.S)
  self:set_button_listener(self.v_uicompents.Button_btn, function()
    if str then
      Util.show_message_tip(str)
    else
      self:on_click()
    end
  end)
end

function ui:on_click()
  UIMgr:get_ui("puzzle_game_battle_panel"):ui_show(self.v_stage_id)
end

return ui
