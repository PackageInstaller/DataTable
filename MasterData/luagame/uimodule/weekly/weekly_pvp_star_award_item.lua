local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE
local Math = require("base.mathx")

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(reward_cfg, curr_score)
  if reward_cfg then
    self.v_reward_cfg = reward_cfg
  end
  if curr_score then
    self.v_curr_score = curr_score
  end
  self.v_is_get_award = WeeklyMgr:is_get_pvp_award(self.v_reward_cfg.Fraction)
  self:refresh_item()
  self:refresh_award(self.v_reward_cfg.RewardGroupId)
end

function ui:refresh_item()
  local coms = self.v_uicompents
  local objs = self.v_uiobjects
  coms.CtTitle_txt.text = "奖励"
  coms.CtContent_txt.text = Util.format_str("总星数达到{1}", self.v_reward_cfg.Fraction)
  local max = self.v_reward_cfg.Fraction
  local cur = self.v_curr_score
  coms.Now_txt.text = cur
  coms.Need_txt.text = max
  local slider_img = coms.CtTaskDone_img
  slider_img.fillAmount = cur / max
  objs.BgComplete:SetActive(max <= cur)
  objs.NowText:SetActive(max > cur)
  objs.FinishText:SetActive(self.v_is_get_award)
  local color = self.v_parent_ui:get_color(max <= cur)
  Util.set_color(coms.CtContent_txt, color)
  Util.set_color(coms.Now_txt, color)
  Util.set_color(coms.Need_txt, color)
  Util.set_color(coms.split_txt, color)
end

function ui:refresh_award(award_group_id)
  local item_parent = self.v_uiobjects.AwardContent
  local award_data = ShareRes.get_award_item_data(award_group_id)
  if not award_data then
    Log.Error("任务配置奖励为空， 奖励ID：", award_group_id or "空", debug.traceback())
    return
  end
  for _, data in ipairs(award_data) do
    local award_ui = self.v_parent_ui:get_award_item()
    local item_id = data[1]
    award_ui.transform:SetParent(item_parent.transform)
    local icon_path, quality_path = UtilUI.get_item_images(item_id)
    local quality_img = Util.get_image("CiPz", award_ui)
    self:update_item_img(quality_img, quality_path)
    local icon = Util.get_image("CiItemIcon", award_ui.transform)
    self:update_item_img(icon, icon_path)
    local mask = self:get_child_gameobj("Mask_", award_ui)
    mask.gameObject:SetActive(false)
    local amount_txt = Util.get_text("AmoBg/CiItemAmount", award_ui)
    amount_txt.text = data[2]
    self:set_button_listener(Util.get_button(nil, award_ui), function()
      UIMgr:get_ui("itemTip"):ui_show({
        item_id = item_id,
        jump_cb = function()
          UIMgr:try_hide_ui("weekly_pvp_star_award")
        end
      })
    end)
  end
  self.v_uicompents.CtGet_btn:SetActive(self.v_curr_score >= self.v_reward_cfg.Fraction and not self.v_is_get_award)
  self:set_button_listener(self.v_uicompents.CtGet_btn, function()
    WeeklyMgr:request_week_acty_pvp_periods_award(self.v_reward_cfg.Fraction)
  end)
end

function ui:update_item_img(icon, path)
  icon.gameObject:SetActive(true)
  ResMgr:load_set_icon(icon, path)
end

return ui
