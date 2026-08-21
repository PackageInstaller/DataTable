local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local MatCfg = ShareRes.create("activity.barbecue_materail")

function ui:set_data(cfg)
  self.v_stage_id = cfg.Id
  self.v_stage_cfg = cfg
  self.v_uicompents.ProfitNum_txt.text = cfg.Score
  self.v_uiobjects.Add:SetActiveEx(0 ~= cfg.NextMatId)
  self.v_uiobjects.RecipeIcon2:SetActiveEx(0 ~= cfg.NextMatId)
  ResMgr:load_set_icon(self.v_uicompents.RecipeIcon1_img, MatCfg[cfg.PrefixMatId].Icon)
  if 0 ~= cfg.NextMatId then
    ResMgr:load_set_icon(self.v_uicompents.RecipeIcon2_img, MatCfg[cfg.NextMatId].Icon)
  end
  ResMgr:load_set_icon(self.v_uicompents.RecipeIcon3_img, cfg.Icon)
end

return ui
