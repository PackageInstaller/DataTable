local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ShopTemClass = Util.create_child_mt(require("ui.uiobject"))
local ShopTemKey = "MINESWEEPER_SHOPTEM"
local SaticSv = require("ui.widget.static_scroll_view")
local MineSweeperBuffUI = require("uimodule.activity.minesweeper.ui_minesweeper_buff")
local minesweeper_misc = ShareRes.get_minesweeper_misc()
local AwardType = {
  Gold = 1,
  Hp = 2,
  Score = 3,
  Bless = 4
}

function ShopTemClass:ui_finish_load()
  self:set_button("BtnBuy", function()
    if self.v_award_type == AwardType.Bless then
      local param = {
        shop_grid_index = self.v_parent_ui.shop_grid_index,
        id = self.v_id,
        bless_id = self.v_bless_id,
        cost = self.v_cost
      }
      UIMgr:get_ui("ui_minesweeper_buff"):ui_show(MineSweeperBuffUI.Type.Shop, param)
    else
      Util.show_notify_popup_message(function()
        local args = {
          self.v_id
        }
        MineSweeperMgr:use_grid(self.v_parent_ui.shop_grid_index, args, function()
          self.v_parent_ui:refresh()
        end)
      end, "是否购买该物品", nil, "是", "否", nil, nil, nil, true)
    end
  end)
end

function ShopTemClass:set_data(data)
  local award_type = data.AwardType
  local grid_info = MineSweeperMgr:get_minesweeper_grid(self.v_parent_ui.shop_grid_index)
  local bought_shop_id_list = grid_info.buy_shop_id or E
  local id = data.Id
  self.v_id = id
  self.v_award_type = award_type
  self.v_cost = data.ConsumeCount
  if award_type == AwardType.Bless then
    local args = grid_info.args
    local bless_id
    for i = 1, #args, 2 do
      local temp_id = args[i]
      if temp_id == id then
        bless_id = args[i + 1]
        break
      end
    end
    self.v_bless_id = bless_id
    local bless_cfg = ShareRes.get_minesweeper_bless_cfg(bless_id)
    local bless_quality_icon = ShareRes.get_minesweeper_bless_quality_cfg(bless_cfg.Quality).Icon
    self.v_uiobjects.Buff:SetActiveEx(true)
    self.v_uicompents.Name_txt.text = bless_cfg.Name
    self.v_uicompents.GoldNum_txt.text = data.ConsumeCount
    ResMgr:load_set_icon(self.v_uicompents.Icon_img, bless_cfg.Icon)
    ResMgr:load_set_icon(self.v_uicompents.BuffQualityIcon_img, bless_quality_icon)
  else
    self.v_uiobjects.Buff:SetActiveEx(false)
    self.v_uicompents.Name_txt.text = data.Name
    self.v_uicompents.GoldNum_txt.text = data.ConsumeCount
    ResMgr:load_set_icon(self.v_uicompents.Icon_img, data.Icon)
  end
  local minesweeper_info = MineSweeperMgr:get_minesweeper_chapter_info()
  local gold_count = minesweeper_info.gold_count
  Util.set_color(self.v_uicompents.GoldNum_txt, gold_count >= data.ConsumeCount and 16117218 or 16735838)
  local purchased
  for _, v in ipairs(bought_shop_id_list) do
    if v == id then
      purchased = true
      break
    end
  end
  self.v_uiobjects.BtnBuy:SetActiveEx(not purchased)
  self.v_uiobjects.Purchased:SetActiveEx(purchased)
end

function ShopTemClass:on_clear()
end

function ui:ui_finish_load()
  self:set_button("BtnBgClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnHpDetail", function()
    local rule_id = ShareRes.get_minesweeper_misc().RuleId[2]
    UIMgr:get_ui("info_tips"):ui_show(rule_id)
  end)
  self.v_static_sv_tem = SaticSv:new(self, self.v_uiobjects.Content, ShopTemClass, ShopTemKey)
end

function ui:ui_on_show(grid_index)
  self:refresh(grid_index)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh(grid_index)
  self.shop_grid_index = grid_index or self.shop_grid_index
  local grid_info = MineSweeperMgr:get_minesweeper_grid(self.shop_grid_index)
  local grid_cfg = ShareRes.get_minesweeper_grid_cfg(grid_info.grid_id)
  local shop_id = grid_cfg.Args[1]
  local item_list = ShareRes.get_minesweeper_shop_item_list(shop_id)
  self.v_static_sv_tem:update_list(item_list)
  local minesweeper_info = MineSweeperMgr:get_minesweeper_chapter_info()
  self.v_uicompents.GoldNum_txt.text = minesweeper_info.gold_count
  self.v_uicompents.ScoreNum_txt.text = minesweeper_info.cur_score
  local cur_hp = minesweeper_info.blood_count
  local max_hp = minesweeper_misc.StaminaLimit
  self.v_real_fillamount = cur_hp / max_hp
  self.v_uicompents.HpText_txt.text = cur_hp .. "/" .. max_hp
  self.v_uicompents.HpBarFill_img.fillAmount = self.v_real_fillamount
end

return ui
