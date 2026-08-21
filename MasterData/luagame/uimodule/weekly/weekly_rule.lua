local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local MODEL = {}
local SHOW_RULE_ITEM_KEY = "SHOW_RULE_ITEM_KEY"

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:register_exist_auto_template(SHOW_RULE_ITEM_KEY, self.v_uiobjects.RuleTem, self.v_uiobjects.Content)
end

function ui:ui_update()
end

function ui:ui_on_show(is_pvp)
  self.v_is_pvp = is_pvp
  self:update_rule_view()
end

function ui:ui_on_hide()
end

function ui:update_rule_view()
  local rule_cfg = ShareRes.get_weekly_prepare_rule_cfg()
  if self.v_is_pvp then
    rule_cfg = ShareRes.get_weekly_pvp_rule_cfg()
  end
  self:give_back_auto_cache(SHOW_RULE_ITEM_KEY)
  for _, cfg in ipairs(rule_cfg) do
    local item = self:get_auto_cache(SHOW_RULE_ITEM_KEY)
    self:update_desc_info(item, cfg)
  end
end

function ui:update_desc_info(item, cfg)
  local titile_txt = Util.get_text("Title/RuleTitle", item)
  titile_txt.text = cfg.Title
  local desc_txt = Util.get_text("RuleDesc", item)
  desc_txt.text = cfg.Desc
end

return ui
