local Base = require("uimodule.pop_up_widget.ui_popup_base")
local DayAwardItem = require("uimodule.shop.recommond_shop.day_award_item")
local FIRST_RECHARGE_POPUP_AWARD_TEM_KEY = "FIRST_RECHARGE_POPUP_AWARD_TEM_KEY"
local Seri = require("seri")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    Base:manual_close()
  end)
  self:set_button("BtnCharge", function()
    PopUpWindowMgr:jump_out(12115)
  end)
  self:set_button("BtnRecive", function()
    local can_get_award = RechargeMgr:can_get_first_recharge_award()
    if can_get_award then
      RechargeMgr:req_get_first_recharge_award(function()
        Base:manual_close()
      end)
    end
  end)
  self:register_exist_auto_template(FIRST_RECHARGE_POPUP_AWARD_TEM_KEY, self.v_uiobjects.AwardTem, self.v_uiobjects.AwardList)
end

function ui:ui_on_show(widget_id)
  self.v_widget_id = widget_id
  self.v_widget_cfg = ShareRes.get_pop_widget_cfg(widget_id)
  self.v_jump_id = self.v_widget_cfg.Arg[1]
  self.v_uicompents.TogDontEject_tog.isOn = false
  self.v_item_list = {}
  self.v_award_cfg = ShareRes.create("recharge.firse_recharge_award")
  self:_set_awards()
  self:_set_btns()
end

function ui:ui_on_update()
end

function ui:ui_on_hide()
  if not self.v_is_first_recharge_done and self.v_uicompents.TogDontEject_tog.isOn then
    local pack_args = Seri.packstring({true})
    local type_tmp = Config.SAVE_TYPE.FIRST_RECHARGE_POPUP
    Network:call("c2gs_netdisk_save_data", {type = type_tmp, pack_string = pack_args})
  end
end

function ui:ui_on_destroy()
end

function ui:_set_awards()
  self:clear_wrap_item()
  self:give_back_auto_cache(FIRST_RECHARGE_POPUP_AWARD_TEM_KEY)
  for day, _ in ipairs(self.v_award_cfg) do
    local obj = self:get_auto_cache(FIRST_RECHARGE_POPUP_AWARD_TEM_KEY)
    local item = DayAwardItem:ui_wrap_ex(self, obj, true)
    item:set_data(day, false)
    table.insert(self.v_item_list, item)
  end
end

function ui:_set_btns()
  local has_free_award = ShareRes.get_first_recharge_free_award() ~= nil
  self.v_uiobjects.BtnFreeAward:SetActive(has_free_award)
  if has_free_award then
    local can_get_free_award = RechargeMgr:can_get_free_first_recharge_award()
    self.v_uiobjects.ReciveIcon:SetActive(can_get_free_award)
    self.v_uiobjects.GotIcon:SetActive(not can_get_free_award)
  end
  local can_get_award = RechargeMgr:can_get_first_recharge_award()
  self.v_is_first_recharge_done = RechargeMgr:is_first_recharge_done()
  self.v_uiobjects.BtnCharge:SetActive(not self.v_is_first_recharge_done)
  self.v_uiobjects.BtnRecive:SetActive(can_get_award)
  self.v_uiobjects.Recived:SetActive(self.v_is_first_recharge_done and not can_get_award)
  self.v_uiobjects.TogDontEject:SetActive(not self.v_is_first_recharge_done)
end

function ui:clear_wrap_item()
  if self.v_item_list then
    for key, item in pairs(self.v_item_list) do
      item:ui_hide()
      item:ui_destroy()
      self.v_item_list[key] = nil
    end
  end
end

function ui:pop_up_precondition()
  local is_first_recharge_done = RechargeMgr:is_first_recharge_done()
  if is_first_recharge_done then
    local award_cfg = ShareRes.create("recharge.firse_recharge_award")
    local can_get_award = false
    for day, _ in ipairs(award_cfg) do
      can_get_award = can_get_award or RechargeMgr:can_get_first_recharge_award(day)
    end
    return can_get_award
  else
    local selected = BattleSettingMgr:get_net_disk_data(Config.SAVE_TYPE.FIRST_RECHARGE_POPUP)
    return not selected and true or false
  end
end

return ui
