local Base = require("ui.uiobject")
local bagConfig = require("gamelogic.character.fight_bag_configs")
local M = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local EQUIP_QUALITY_PATH = "Icon/BattleCommon/Ba_%dx"
local EQUIP_ICON_PATH = "Icon/BattleWeapon/%s"

function M:ui_finish_load()
  self.v_tog = Util.get_toggle(nil, self.v_object)
  Global.listener_mgr:add_listener(self.v_object, self.v_tog.onValueChanged, function(isOn)
    self:_on_click_tog(isOn)
  end)
  local MODEL = {
    v_equip_info = {
      "EquipInfo",
      BIND_TYPE.OBJECT
    },
    v_equip_quality = {
      "CePz",
      BIND_TYPE.IMAGE
    },
    v_equip_icon = {
      "CeIcon",
      BIND_TYPE.IMAGE
    },
    v_change_obj = {
      "CeChang",
      BIND_TYPE.OBJECT
    },
    v_choose_obj = {
      "CeChoose",
      BIND_TYPE.OBJECT
    },
    v_add_btn = {
      "Empty",
      BIND_TYPE.OBJECT
    }
  }
  self:init_model(MODEL)
  self:set_button("Empty", function()
    self:_onclick_add_btn()
  end)
  self.v_choose_obj:SetActiveEx(false)
  self.v_equip_info:SetActiveEx(false)
end

function M:ui_on_show()
  self:set_equip()
end

function M:ui_on_hide()
  self.v_equip_pos = nil
  self.v_equip_data = nil
end

function M:set_equip(equip_pos, equip_data)
  self.v_add_btn:SetActiveEx(nil == equip_data)
  if nil == equip_data then
    return
  end
  self.v_equip_data = equip_data
  self.v_equip_pos = equip_pos
  self.v_equip_info:SetActiveEx(true)
  local quality = 1
  if self.v_equip_data.Quality >= 3 then
    quality = self.v_equip_data.Quality - 2
  end
  ResMgr:load_set_icon(self.v_equip_quality, string.format(EQUIP_QUALITY_PATH, quality))
  ResMgr:load_set_icon(self.v_equip_icon, string.format(EQUIP_ICON_PATH, self.v_equip_data.Icon))
  local isChange = false
  self.v_change_obj:SetActiveEx(isChange)
end

function M:clear_equip()
  self.v_equip_pos = nil
  self.v_equip_data = nil
  self.v_equip_info:SetActiveEx(false)
end

function M:high_light(flag)
  self.v_simulate = true
  self.v_tog.isOn = flag
  self.v_choose_obj:SetActive(flag)
  self.v_simulate = false
end

function M:_on_click_tog(isOn)
  if self.v_equip_data == nil then
    return
  end
  if self.v_simulate == true then
    return
  end
  if isOn then
    if self:_get_is_finish_fight() == false then
      Util.show_message_tip(2108)
      return
    end
    local msg = MsgGame:mq_publish2(Const.MSG_ON_CLICK_FIGHT_EQUIP_TIPS)
    msg.mm_obj = {
      item_data = self.v_equip_data,
      source = bagConfig.EquipSrc.Hero
    }
  end
end

function M:_onclick_add_btn()
  Util.show_message_tip(2184)
end

function M:_get_is_finish_fight()
  local tower = TowerMgr:get_tower()
  local is_pass = tower:is_pass_room(tower:get_room_num())
  return is_pass
end

return M
