local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ANSWERCONTENT_ANSWERTEM_TEMP_KEY = "ANSWERCONTENT_ANSWERTEM_TEMP_KEY"
local STORYCONTENT_STORYTEM_TEMP_KEY = "STORYCONTENT_STORYTEM_TEMP_KEY"
local PAGE_TYPE = {PONDER = 1, STORY = 2}
local TRIGGER_TYPE = {
  DEFAULT_UNLOCK = 1,
  PONDER_UNLOCK = 2,
  POINT_UNLOCK = 3
}

function ui:on_click_BtnRet1()
  self.v_select_page = nil
  self:ui_hide()
end

function ui:on_click_PageAnswer()
  self:refresh_view(PAGE_TYPE.PONDER)
end

function ui:on_click_PageStory()
  self:refresh_view(PAGE_TYPE.STORY)
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:on_click_BtnRet1()
  end)
  self:set_button("PageAnswer", function()
    self:on_click_PageAnswer()
  end)
  self:set_button("PageStory", function()
    self:on_click_PageStory()
  end)
  self.v_select_page = PAGE_TYPE.PONDER
  self:register_exist_auto_template(ANSWERCONTENT_ANSWERTEM_TEMP_KEY, self.v_uiobjects.AnswerTem, self.v_uiobjects.AnswerContent)
  self:register_exist_auto_template(STORYCONTENT_STORYTEM_TEMP_KEY, self.v_uiobjects.StoryTem, self.v_uiobjects.StoryContent)
  self.v_need_close_red_key = {}
end

function ui:ui_on_show(activity_id, select_page)
  self.v_activity_id = activity_id
  self:refresh_view(select_page)
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
end

function ui:ui_on_hide()
  for id, red_key in pairs(self.v_need_close_red_key) do
    NoviceMgr:close_ill_item_red(self.v_activity_id, id, red_key)
    self.v_need_close_red_key[id] = nil
  end
end

function ui:ui_on_destroy()
end

function ui:refresh_view(select_page)
  for id, red_key in pairs(self.v_need_close_red_key) do
    NoviceMgr:close_ill_item_red(self.v_activity_id, id, red_key)
    self.v_need_close_red_key[id] = nil
  end
  self.v_select_page = select_page or self.v_select_page or PAGE_TYPE.PONDER
  local is_ponder = self.v_select_page == PAGE_TYPE.PONDER
  local is_story = self.v_select_page == PAGE_TYPE.STORY
  self.v_uiobjects.AnswerSelect:SetActive(is_ponder)
  self.v_uiobjects.Answer:SetActive(is_ponder)
  self.v_uiobjects.StorySelect:SetActive(is_story)
  self.v_uiobjects.Story:SetActive(is_story)
  self:refresh_content()
end

function ui:refresh_content()
  self:give_back_auto_cache(ANSWERCONTENT_ANSWERTEM_TEMP_KEY)
  self:give_back_auto_cache(STORYCONTENT_STORYTEM_TEMP_KEY)
  local cfgs, temp_key
  if self.v_select_page == PAGE_TYPE.PONDER then
    cfgs = ShareRes.get_ponder_cfg()
    temp_key = ANSWERCONTENT_ANSWERTEM_TEMP_KEY
  elseif self.v_select_page == PAGE_TYPE.STORY then
    cfgs = ShareRes.get_ponder_maze_story_cfg()
    temp_key = STORYCONTENT_STORYTEM_TEMP_KEY
  end
  if cfgs then
    local list = UtilTable.map2list(cfgs, function(a, b)
      if a.Priority and b.Priority and a.Priority ~= b.Priority then
        return a.Priority < b.Priority
      end
      if a.Id ~= b.Id then
        return a.Id < b.Id
      end
      return false
    end)
    for id, cfg in ipairs(list) do
      if cfg.IllustrateShow then
        local red_key
        local obj = self:get_auto_cache(temp_key)
        local content_obj = self:get_child_gameobj("Content", obj) or self:get_child_gameobj("PosUp/Content", obj) or self:get_child_gameobj("PosDown/Content", obj)
        if self.v_select_page == PAGE_TYPE.PONDER then
          red_key = "ponder_id"
        elseif self.v_select_page == PAGE_TYPE.STORY then
          red_key = "story_id"
        end
        local RedPoint = self:get_child_gameobj("RedPoint", content_obj)
        local Lock = self:get_child_gameobj("Lock", content_obj)
        local is_red = NoviceMgr:check_ill_item_red(self.v_activity_id, cfg.Id, red_key)
        if is_red then
          self.v_need_close_red_key[cfg.Id] = red_key
        end
        local Icon_ = self:get_image("Icon", content_obj)
        local btn = self:get_button(nil, obj)
        ResMgr:load_set_icon(Icon_, cfg.IconPath)
        local Name_ = self:get_text("Name", content_obj)
        Name_.text = cfg.Name
        local click_cb
        local is_unlock = true
        local unlock_desc = cfg.UnlockDesc
        if self.v_select_page == PAGE_TYPE.PONDER then
          local ponder_id = cfg.Id
          is_unlock = NoviceMgr:get_ponder_is_unlock(self.v_activity_id, ponder_id)
          
          function click_cb()
            if is_unlock then
              UIMgr:get_ui("ui_maze_game_settle_tips"):ui_show(ponder_id)
              NoviceMgr:close_ill_item_red(self.v_activity_id, cfg.Id, red_key)
              RedPoint:SetActive(false)
            elseif unlock_desc then
              Util.show_message_tip(unlock_desc)
            end
          end
        elseif self.v_select_page == PAGE_TYPE.STORY then
          local story_id = cfg.Id
          if cfg.StoryType == TRIGGER_TYPE.DEFAULT_UNLOCK then
            is_unlock = true
          elseif cfg.StoryType == TRIGGER_TYPE.PONDER_UNLOCK then
            is_unlock = NoviceMgr:get_ponder_is_unlock(self.v_activity_id, cfg.Param[1])
          elseif cfg.StoryType == TRIGGER_TYPE.POINT_UNLOCK then
            for _, point_id in pairs(cfg.Param) do
              is_unlock = NoviceMgr:get_ponder_maze_point_is_comp(self.v_activity_id, point_id)
            end
          else
            is_unlock = true
          end
          unlock_desc = cfg.UnlockDesc
          
          function click_cb()
            if is_unlock then
              StoryMgr:on_start(story_id)
              NoviceMgr:close_ill_item_red(self.v_activity_id, cfg.Id, red_key)
              RedPoint:SetActive(false)
            elseif unlock_desc then
              Util.show_message_tip(unlock_desc)
            end
          end
        end
        RedPoint:SetActive(is_unlock and is_red)
        Lock:SetActive(not is_unlock)
        Util.apply_grey_ex(Icon_, not is_unlock)
        Util.set_color(Name_, is_unlock and "f9efd4" or "a0a0a0")
        local root_name = cfg.UsePosUp and "PosUp" or "PosDown"
        local root = self:get_child_transform(root_name, obj)
        content_obj.transform:SetParent(root.transform)
        content_obj:ResetAttr()
        if click_cb then
          self:set_button_listener(btn, click_cb)
        end
      end
    end
  end
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name, nil, true)
end

return ui
