local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BuffTemClass = Util.create_child_mt(require("ui.uiobject"))
local BuffTemKey = "MINESWEEPER_BUFFTEM"
local BuffTemKey1 = "MINESWEEPER_BUFFTEM1"
local BuffTemKey2 = "MINESWEEPER_BUFFTEM2"
ui.Type = {
  Bag = 1,
  Remove = 2,
  Shop = 3,
  Item = 4,
  Replace = 5
}

function BuffTemClass:ui_finish_load()
  self:set_button("BtnBuy", function()
    local args = {
      self.v_parent_ui.id
    }
    MineSweeperMgr:use_grid(self.v_parent_ui.shop_grid_index, args, function()
      self.v_parent_ui:ui_hide()
      local minesweeper_shop = UIMgr:try_get_visible_ui("ui_minesweeper_shop")
      if minesweeper_shop then
        minesweeper_shop:refresh()
      end
    end)
  end)
  self:set_button("BtnEquip", function()
    local bless_cfg = ShareRes.get_minesweeper_bless_cfg(self.v_data.bless_id)
    local bless_quality = bless_cfg.Quality
    local bless_quality_cfg = ShareRes.get_minesweeper_bless_quality_cfg(bless_quality)
    local limit = bless_quality_cfg.Limit
    local bless_list = MineSweeperMgr:get_minesweeper_chapter_info().bless_list
    local count = 0
    for _, bless_id in ipairs(bless_list) do
      local cfg = ShareRes.get_minesweeper_bless_cfg(bless_id)
      if cfg.Quality == bless_quality then
        count = count + 1
      end
    end
    if count == limit then
      self.v_parent_ui:refresh(ui.Type.Remove, self.v_data.grid_index)
    else
      MineSweeperMgr:use_grid(self.v_data.grid_index, nil, function()
        self.v_parent_ui:ui_hide()
      end)
    end
  end)
  self:set_button("BtnDel", function()
    Util.show_notify_popup_message(function()
      local ui_type = self.v_parent_ui:get_type()
      if ui_type == ui.Type.Bag then
        MineSweeperMgr:request_minesweeper_remove_bless(self.v_data.bless_id, function()
          self.v_parent_ui:refresh()
        end)
      elseif ui_type == ui.Type.Remove then
        MineSweeperMgr:request_minesweeper_remove_bless(self.v_data.bless_id, function()
          MineSweeperMgr:use_grid(self.v_parent_ui.replace_bless_grid_index, nil, function()
            self.v_parent_ui:ui_hide()
          end)
        end)
      elseif ui_type == ui.Type.Replace then
        if self.v_parent_ui.shop_grid_index then
          local args = {
            self.v_parent_ui.id
          }
          MineSweeperMgr:request_minesweeper_remove_bless(self.v_data.bless_id, function()
            MineSweeperMgr:use_grid(self.v_parent_ui.shop_grid_index, args, function()
              self.v_parent_ui:ui_hide()
              local minesweeper_shop = UIMgr:try_get_visible_ui("ui_minesweeper_shop")
              if minesweeper_shop then
                minesweeper_shop:refresh()
              end
            end)
          end)
        else
          MineSweeperMgr:request_minesweeper_remove_bless(self.v_data.bless_id, function()
            MineSweeperMgr:use_grid(self.v_parent_ui.replace_bless_grid_index, nil, function()
              self.v_parent_ui:ui_hide()
            end)
          end)
        end
      end
    end, "是否中止该谋略", nil, "是", "否", nil, nil, nil, true)
  end)
end

function BuffTemClass:set_data(data)
  self.v_data = data
  local bless_cfg = ShareRes.get_minesweeper_bless_cfg(data.bless_id)
  local bless_quality_cfg = ShareRes.get_minesweeper_bless_quality_cfg(bless_cfg.Quality)
  self.v_uicompents.BuffName_txt.text = bless_cfg.Name
  self.v_uicompents.BuffDesc_txt.text = bless_cfg.Desc
  if self.v_data.cost then
    self.v_uicompents.GoldNum_txt.text = self.v_data.cost
    local minesweeper_info = MineSweeperMgr:get_minesweeper_chapter_info()
    local gold_count = minesweeper_info.gold_count
    Util.set_color(self.v_uicompents.GoldNum_txt, gold_count >= self.v_data.cost and 16117218 or 16735838)
  end
  ResMgr:load_set_icon(self.v_uicompents.BuffIcon_img, bless_cfg.Icon)
  ResMgr:load_set_icon(self.v_uicompents.QualityIcon_img, bless_quality_cfg.Icon)
  local ui_type = self.v_parent_ui:get_type()
  if ui_type == ui.Type.Bag or ui_type == ui.Type.Remove or ui_type == ui.Type.Replace then
    self.v_uiobjects.BtnBuy:SetActiveEx(false)
    self.v_uiobjects.BtnEquip:SetActiveEx(false)
    self.v_uiobjects.BtnDel:SetActiveEx(true)
  elseif ui_type == ui.Type.Item then
    self.v_uiobjects.BtnBuy:SetActiveEx(false)
    self.v_uiobjects.BtnEquip:SetActiveEx(true)
    self.v_uiobjects.BtnDel:SetActiveEx(false)
  elseif ui_type == ui.Type.Shop then
    self.v_uiobjects.BtnBuy:SetActiveEx(true)
    self.v_uiobjects.BtnEquip:SetActiveEx(false)
    self.v_uiobjects.BtnDel:SetActiveEx(false)
  end
end

function BuffTemClass:on_clear()
end

function BuffTemClass:hide_all_button()
  self.v_uiobjects.BtnBuy:SetActiveEx(false)
  self.v_uiobjects.BtnEquip:SetActiveEx(false)
  self.v_uiobjects.BtnDel:SetActiveEx(false)
end

function ui:ui_finish_load()
  self:set_button("BtnBack", function()
    self:ui_hide()
  end)
  self:register_exist_auto_template(BuffTemKey, self.v_uiobjects.BuffTem, self.v_uiobjects.BuffSVContent)
  self:register_exist_auto_template(BuffTemKey1, self.v_uiobjects.BuffNew1, self.v_uiobjects.ChangeBuffSVContent)
  self:register_exist_auto_template(BuffTemKey2, self.v_uiobjects.BuffNew2, self.v_uiobjects.ChangeBuffLayout)
end

function ui:ui_on_show(type, param)
  self:refresh(type, param)
end

function ui:ui_on_hide()
  local wrap_uis = self:get_wraps()
  for wrap_ui, _ in pairs(wrap_uis) do
    self:remove_wrap_ui(wrap_ui)
  end
end

function ui:ui_on_destroy()
end

function ui:refresh(type, param)
  self.v_type = type or self.v_type
  if self.v_type == ui.Type.Bag then
    self:refresh_bag()
  elseif self.v_type == ui.Type.Shop then
    self:refresh_shop(param)
  elseif self.v_type == ui.Type.Remove then
    self:refresh_remove(param)
  elseif self.v_type == ui.Type.Item then
    self:refresh_item(param)
  elseif self.v_type == ui.Type.Replace then
    self:refresh_replace(param)
  end
  local minesweeper_chapter_info = MineSweeperMgr:get_minesweeper_chapter_info()
  self.v_uicompents.GoldNum_txt.text = minesweeper_chapter_info.gold_count
end

function ui:refresh_bag()
  self.v_uiobjects.TipsBag:SetActiveEx(true)
  self.v_uiobjects.TipsEquip:SetActiveEx(false)
  self.v_uiobjects.BuffChangeObj:SetActiveEx(false)
  local minesweeper_chapter_info = MineSweeperMgr:get_minesweeper_chapter_info()
  local bless_list = {}
  for _, id in ipairs(minesweeper_chapter_info.bless_list) do
    table.insert(bless_list, {bless_id = id})
  end
  self.v_uiobjects.BuffScrollView:SetActiveEx(#bless_list > 3)
  self.v_uiobjects.BuffLayout:SetActiveEx(#bless_list <= 3)
  self.v_uiobjects.NoBuff:SetActiveEx(0 == #bless_list)
  self:give_back_auto_cache(BuffTemKey)
  for i, data in ipairs(bless_list) do
    local buff_obj = self:get_auto_cache(BuffTemKey)
    local parent = #bless_list > 3 and self.v_uiobjects.BuffSVContent or self.v_uiobjects.BuffLayout
    buff_obj.transform:SetParent(parent.transform, false)
    local buff_tem = BuffTemClass:ui_wrap_ex(self, buff_obj, true)
    buff_tem:set_data(data)
  end
end

function ui:refresh_remove(grid_index)
  self.v_uiobjects.TipsBag:SetActiveEx(true)
  self.v_uiobjects.TipsEquip:SetActiveEx(false)
  self.v_uiobjects.BuffChangeObj:SetActiveEx(false)
  local minesweeper_chapter_info = MineSweeperMgr:get_minesweeper_chapter_info()
  self.replace_bless_grid_index = grid_index
  local grid_info = MineSweeperMgr:get_minesweeper_grid(grid_index)
  local bless_quality = ShareRes.get_minesweeper_bless_cfg(grid_info.args[1]).Quality
  local bless_list = {}
  for _, id in ipairs(minesweeper_chapter_info.bless_list) do
    local quality = ShareRes.get_minesweeper_bless_cfg(id).Quality
    if quality == bless_quality then
      table.insert(bless_list, {bless_id = id})
    end
  end
  self.v_uiobjects.BuffScrollView:SetActiveEx(#bless_list > 3)
  self.v_uiobjects.BuffLayout:SetActiveEx(#bless_list <= 3)
  self.v_uiobjects.NoBuff:SetActiveEx(0 == #bless_list)
  self:give_back_auto_cache(BuffTemKey)
  for i, data in ipairs(bless_list) do
    local buff_obj = self:get_auto_cache(BuffTemKey)
    local parent = #bless_list > 3 and self.v_uiobjects.BuffSVContent or self.v_uiobjects.BuffLayout
    buff_obj.transform:SetParent(parent.transform, false)
    local buff_tem = BuffTemClass:ui_wrap_ex(self, buff_obj, true)
    buff_tem:set_data(data)
  end
end

function ui:refresh_shop(param)
  local bless_cfg = ShareRes.get_minesweeper_bless_cfg(param.bless_id)
  local bless_quality = bless_cfg.Quality
  local bless_quality_cfg = ShareRes.get_minesweeper_bless_quality_cfg(bless_quality)
  local limit = bless_quality_cfg.Limit
  local bless_list = MineSweeperMgr:get_minesweeper_chapter_info().bless_list
  local count = 0
  for _, bless_id in ipairs(bless_list) do
    local cfg = ShareRes.get_minesweeper_bless_cfg(bless_id)
    if cfg.Quality == bless_quality then
      count = count + 1
    end
  end
  if count == limit then
    self:refresh(ui.Type.Replace, param)
    return
  end
  self.v_uiobjects.TipsBag:SetActiveEx(false)
  self.v_uiobjects.TipsEquip:SetActiveEx(true)
  self.v_uiobjects.NoBuff:SetActiveEx(false)
  self.v_uiobjects.BuffChangeObj:SetActiveEx(false)
  self.shop_grid_index = param.shop_grid_index
  self.id = param.id
  self.bless_id = param.bless_id
  self.cost = param.cost
  bless_list = {
    {
      bless_id = self.bless_id,
      cost = self.cost
    }
  }
  self.v_uiobjects.BuffScrollView:SetActiveEx(#bless_list > 3)
  self.v_uiobjects.BuffLayout:SetActiveEx(#bless_list <= 3)
  self:give_back_auto_cache(BuffTemKey)
  for i, data in ipairs(bless_list) do
    local buff_obj = self:get_auto_cache(BuffTemKey)
    local parent = #bless_list > 3 and self.v_uiobjects.BuffSVContent or self.v_uiobjects.BuffLayout
    buff_obj.transform:SetParent(parent.transform, false)
    local buff_tem = BuffTemClass:ui_wrap_ex(self, buff_obj, true)
    buff_tem:set_data(data)
  end
end

function ui:refresh_item(grid_index)
  local grid_info = MineSweeperMgr:get_minesweeper_grid(grid_index)
  local bless_cfg = ShareRes.get_minesweeper_bless_cfg(grid_info.args[1])
  local bless_quality = bless_cfg.Quality
  local bless_quality_cfg = ShareRes.get_minesweeper_bless_quality_cfg(bless_quality)
  local limit = bless_quality_cfg.Limit
  local bless_list = MineSweeperMgr:get_minesweeper_chapter_info().bless_list
  local count = 0
  for _, bless_id in ipairs(bless_list) do
    local cfg = ShareRes.get_minesweeper_bless_cfg(bless_id)
    if cfg.Quality == bless_quality then
      count = count + 1
    end
  end
  if count == limit then
    self:refresh(ui.Type.Replace, grid_index)
    return
  end
  self.v_uiobjects.TipsBag:SetActiveEx(false)
  self.v_uiobjects.TipsEquip:SetActiveEx(true)
  self.v_uiobjects.NoBuff:SetActiveEx(false)
  self.v_uiobjects.BuffChangeObj:SetActiveEx(false)
  local bless_list = {
    {
      bless_id = grid_info.args[1],
      grid_index = grid_index
    }
  }
  self.v_uiobjects.BuffScrollView:SetActiveEx(#bless_list > 3)
  self.v_uiobjects.BuffLayout:SetActiveEx(#bless_list <= 3)
  self:give_back_auto_cache(BuffTemKey)
  for i, data in ipairs(bless_list) do
    local buff_obj = self:get_auto_cache(BuffTemKey)
    local parent = #bless_list > 3 and self.v_uiobjects.BuffSVContent or self.v_uiobjects.BuffLayout
    buff_obj.transform:SetParent(parent.transform, false)
    local buff_tem = BuffTemClass:ui_wrap_ex(self, buff_obj, true)
    buff_tem:set_data(data)
  end
end

function ui:refresh_replace(param)
  self.v_uiobjects.TipsBag:SetActiveEx(false)
  self.v_uiobjects.TipsEquip:SetActiveEx(false)
  self.v_uiobjects.NoBuff:SetActiveEx(false)
  self.v_uiobjects.BuffChangeObj:SetActiveEx(true)
  self.v_uiobjects.BuffScrollView:SetActiveEx(false)
  self.v_uiobjects.BuffLayout:SetActiveEx(false)
  local new_bless_id
  if type(param) == "table" then
    self.shop_grid_index = param.shop_grid_index
    self.id = param.id
    self.bless_id = param.bless_id
    self.replace_bless_grid_index = nil
    new_bless_id = param.bless_id
  else
    self.shop_grid_index = nil
    local grid_index = param
    self.replace_bless_grid_index = grid_index
    local grid_info = MineSweeperMgr:get_minesweeper_grid(grid_index)
    new_bless_id = grid_info.args[1]
  end
  local bless_cfg = ShareRes.get_minesweeper_bless_cfg(new_bless_id)
  local bless_quality = bless_cfg.Quality
  local bless_list = MineSweeperMgr:get_minesweeper_chapter_info().bless_list
  local temp_list = {}
  for _, id in ipairs(bless_list) do
    local quality = ShareRes.get_minesweeper_bless_cfg(id).Quality
    if quality == bless_quality then
      table.insert(temp_list, {bless_id = id})
    end
  end
  local new_bless_obj = #temp_list >= 3 and self.v_uiobjects.ReplaceBuff1 or self.v_uiobjects.ReplaceBuff2
  local new_bless_tem = BuffTemClass:ui_wrap_ex(self, new_bless_obj, true)
  new_bless_tem:set_data({bless_id = new_bless_id})
  new_bless_tem:hide_all_button()
  self:give_back_auto_cache(BuffTemKey1)
  self:give_back_auto_cache(BuffTemKey2)
  if #temp_list >= 3 then
    self.v_uiobjects.ChangeType1:SetActiveEx(true)
    self.v_uiobjects.ChangeType2:SetActiveEx(false)
    for _, data in ipairs(temp_list) do
      local buff_obj = self:get_auto_cache(BuffTemKey1)
      local buff_tem = BuffTemClass:ui_wrap_ex(self, buff_obj, true)
      buff_tem:set_data(data)
    end
  else
    self.v_uiobjects.ChangeType1:SetActiveEx(false)
    self.v_uiobjects.ChangeType2:SetActiveEx(true)
    for _, data in ipairs(temp_list) do
      local buff_obj = self:get_auto_cache(BuffTemKey2)
      local buff_tem = BuffTemClass:ui_wrap_ex(self, buff_obj, true)
      buff_tem:set_data(data)
    end
  end
  new_bless_tem.v_uiobjects.BtnBuy:SetActiveEx(self.shop_grid_index and true or false)
  if self.shop_grid_index then
    local grid_info = MineSweeperMgr:get_minesweeper_grid(self.shop_grid_index)
    local grid_cfg = ShareRes.get_minesweeper_grid_cfg(grid_info.grid_id)
    local shop_id = grid_cfg.Args[1]
    new_bless_tem.v_uicompents.GoldNum_txt.text = ShareRes.create("minesweeper.minesweeper_shop")[shop_id][self.id].ConsumeCount
  end
end

function ui:get_type()
  return self.v_type
end

return ui
