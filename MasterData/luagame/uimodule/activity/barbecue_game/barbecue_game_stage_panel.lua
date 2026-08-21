local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BARBECUE_GAME_STAGE_ITEM_TEMP_KEY = "BARBECUE_GAME_STAGE_ITEM_TEMP_KEY"
local BarbecueGameStageItem = require("uimodule.activity.barbecue_game.barbecue_game_stage_item")
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder

function ui:on_click_BtnRet1()
  MsgGame:mq_publish2(Const.MSG_ON_BBQ_STAGE_BACK_TO_MAIN)
  self:ui_hide()
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:on_click_BtnRet1()
  end)
  self.v_view_port_width = self.v_uicompents.StageList_rect.rect.width
  self.v_item_width = self.v_uicompents.StageTem_rect.rect.width
  local content_layout_group = Util.get_component(nil, self.v_uiobjects.StageContent, typeof(UnityEngine.UI.HorizontalLayoutGroup))
  self.v_spacing = content_layout_group.spacing
  self:set_scrollrect_listener(self:get_scrollrect(nil, self.v_uiobjects.StageList), function()
    local width = self.v_uicompents.StageContent_rect:GetSizeDeltaA()
    local pos = self.v_uicompents.StageContent_rect.anchoredPosition.x
    self.v_uiobjects.RightArrow:SetActiveEx(width + pos > 200)
    self.v_uiobjects.LeftArrow:SetActiveEx(pos < -200)
  end)
  self:register_exist_auto_template(BARBECUE_GAME_STAGE_ITEM_TEMP_KEY, self.v_uiobjects.StageTem, self.v_uiobjects.StageContent)
end

function ui:ui_on_show()
  self.v_activity_id = BarbecueGameMgr:get_activity_id()
  self.v_activity_cfg = ShareRes.get_activity_cfg(self.v_activity_id)
  self:show_stage()
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name, true)
end

function ui:ui_on_hide()
  self:clear_wrap_items()
  UIMgr:try_hide_ui("barbecue_game_task")
end

function ui:ui_on_destroy()
end

function ui:show_stage()
  local stage_list = BarbecueGameMgr:get_stage_list(self.v_activity_id)
  self:give_back_auto_cache(BARBECUE_GAME_STAGE_ITEM_TEMP_KEY)
  self:clear_wrap_items()
  self.v_stage_item_list = {}
  local first_not_pass
  for idx, stage_cfg in ipairs(stage_list) do
    local obj = self:get_auto_cache(BARBECUE_GAME_STAGE_ITEM_TEMP_KEY)
    local item = BarbecueGameStageItem:ui_wrap_ex(self, obj, true)
    item:set_data(stage_cfg)
    table.insert(self.v_stage_item_list, item)
    if not first_not_pass and not BarbecueGameMgr:is_stage_pass(stage_cfg.Id) then
      first_not_pass = idx
    end
  end
  self.v_force_idx = first_not_pass or #self.v_stage_item_list
  local visible_width = self.v_force_idx * self.v_item_width + (self.v_force_idx - 1) * self.v_spacing
  local offset = 0
  if visible_width > self.v_view_port_width then
    offset = visible_width - self.v_view_port_width
  end
  self.v_uicompents.StageContent_rect:SetAnchoredPositionA(-offset, 0)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_uicompents.StageContent_rect)
  local width = self.v_uicompents.StageContent_rect:GetSizeDeltaA()
  local pos = self.v_uicompents.StageContent_rect.anchoredPosition.x
  self.v_uiobjects.RightArrow:SetActiveEx(width + pos > 200)
  self.v_uiobjects.LeftArrow:SetActiveEx(pos < -200)
end

function ui:clear_wrap_items()
  if self.v_stage_item_list then
    for idx = #self.v_stage_item_list, 1, -1 do
      local item = self.v_stage_item_list[idx]
      item:ui_destroy()
      self.v_stage_item_list[idx] = nil
    end
    self.v_stage_item_list = nil
  end
end

return ui
