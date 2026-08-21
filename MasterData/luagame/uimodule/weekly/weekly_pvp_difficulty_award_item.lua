local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local weekly_pvp_difficulty_award_item_key = "weekly_pvp_difficulty_award_item_key"
local item_obj_com = require("uimodule.item.item_obj_com")

function ui:ui_finish_load()
  self.v_item_list = {}
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:set_data(index, cfg_data, curr_score_cfg)
  self.curr_cfg = cfg_data
  self.curr_score_cfg = curr_score_cfg
  self.award_key = weekly_pvp_difficulty_award_item_key .. index
  self:register_exist_auto_template(self.award_key, self.v_uiobjects.ItemObjCom1, self.v_uiobjects.AwardContent)
  self:refresh_is_curr_award(index)
  self:refresh_score()
  self:refresh_award()
end

function ui:refresh_is_curr_award(index)
  self.v_uiobjects.NowAward:SetActive(self.curr_score_cfg and self.curr_cfg.Id == self.curr_score_cfg.Id and self.curr_cfg.Fraction == self.curr_score_cfg.Fraction)
  local str = index > 9 and "{1}" or "0{1}"
  self.v_uicompents.AwardNum_txt.text = Util.format_str(str, index)
end

function ui:refresh_score()
  self.v_uicompents.Condition_txt.text = Util.format_str("总积分达到{1}", self.curr_cfg.Fraction)
end

function ui:refresh_award()
  local data_list = {}
  ShareRes.get_item_obj_use_award_list(self.curr_cfg.RewardGroupId, data_list)
  self:give_back_auto_cache(self.award_key)
  for index, data in ipairs(data_list) do
    local obj = self:get_auto_cache(self.award_key)
    local item = item_obj_com:ui_wrap_ex(self, obj, true)
    item:set_data(data, true)
    table.insert(self.v_item_list, item)
  end
end

function ui:clear_award()
  self:give_back_auto_cache(self.award_key)
  for key, item in pairs(self.v_item_list) do
    item:ui_hide()
    self:remove_wrap_ui(item)
    self.v_item_list[key] = nil
  end
  self:unregister_template(self.award_key)
end

return ui
