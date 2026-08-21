local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:on_click_BtnConfirm()
  local activity_id = NoviceMgr.ponder_maze_mgr:get_game_param()
  NoviceMgr:stop_ponder_maze_game()
  UIMgr:try_show_ui("ui_maze_game_main", nil, activity_id)
end

function ui:on_click_BtnReStart()
  NoviceMgr.ponder_maze_mgr:restart_game()
  self:ui_hide()
end

function ui:on_click_BtnClose()
  if self.v_only_show then
    self:ui_hide()
  end
end

function ui:ui_finish_load()
  self:set_button("BtnConfirm", function()
    self:on_click_BtnConfirm()
  end)
  self:set_button("BtnReStart", function()
    self:on_click_BtnReStart()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
end

function ui:ui_on_show(ponder_id, activity_id, close_callback)
  self.v_only_show = nil ~= ponder_id
  self.v_activity_id = activity_id
  if not ponder_id then
    local temp_ponder_id = NoviceMgr:get_maze_game_settle_tips_ponder_id()
    ponder_id = 0 ~= temp_ponder_id and temp_ponder_id or nil
  end
  if not ponder_id and NoviceMgr.ponder_maze_mgr then
    ponder_id = NoviceMgr.ponder_maze_mgr:get_ponder_result()
  end
  self:refresh_view(ponder_id)
  self.v_close_callback = close_callback
  NoviceMgr:set_is_need_show_maze_game_settle_tips(false)
  NoviceMgr:set_maze_game_settle_tips_ponder_id(0)
end

function ui:ui_on_hide()
  self.v_only_show = false
  if self.v_close_callback then
    self.v_close_callback()
    self.v_close_callback = nil
  end
end

function ui:ui_on_destroy()
end

function ui:refresh_view(ponder_id)
  if ponder_id then
    local ponder_cfg = ShareRes.get_ponder_cfg(ponder_id)
    self.v_uicompents.AnswerDesc_txt.text = ponder_cfg.Desc
    self.v_uicompents.AnswerName_txt.text = ponder_cfg.Name
    ResMgr:load_set_icon(self.v_uicompents.AnswerIcon_img, ponder_cfg.IconPath)
    self.v_uiobjects.BtnReStart:SetActive(false)
    self.v_uiobjects.TitleDef:SetActive(false)
    self.v_uiobjects.Button:SetActive(false)
    self.v_uiobjects.TitleSuc:SetActive(not self.v_only_show)
  end
  if not self.v_only_show then
    local cfg_list = ShareRes.get_ponder_maze_story_cfg()
    for story_id, cfg in pairs(cfg_list) do
      if NoviceMgr:get_maze_game_story_state(story_id) == Config.CommonDefine.MAZE_GAME_STORY_STATE.NO_PLAY then
        if cfg.StoryType == Config.CommonDefine.MAZE_GAME_TRIGGER_TYPE.PONDER_UNLOCK and cfg.Param[1] == ponder_id then
          NoviceMgr:set_maze_game_story_state(story_id, Config.CommonDefine.MAZE_GAME_STORY_STATE.NEED_PLAY)
        elseif cfg.StoryType == Config.CommonDefine.MAZE_GAME_TRIGGER_TYPE.POINT_UNLOCK then
          local pass_all_point = true
          if not self.v_activity_id then
            self.v_activity_id = NoviceMgr.ponder_maze_mgr:get_game_param()
          end
          for key, point_id in pairs(cfg.Param) do
            if not NoviceMgr:get_ponder_maze_point_is_comp(self.v_activity_id, point_id) then
              pass_all_point = false
            end
          end
          if pass_all_point then
            NoviceMgr:set_maze_game_story_state(story_id, Config.CommonDefine.MAZE_GAME_STORY_STATE.NEED_PLAY)
          end
        end
      end
    end
  end
end

return ui
