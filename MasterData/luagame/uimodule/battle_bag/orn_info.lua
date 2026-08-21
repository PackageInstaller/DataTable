local Base = require("ui.uiobject")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local Fight_Item_Helper = require("uimodule.fight_bag.fight_item_helper")
local Item_Helper = require("utils.item_helper")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_desc1 = {
    "Desc1",
    BIND_TYPE.TEXT
  },
  v_desc2 = {
    "Desc2",
    BIND_TYPE.TEXT
  }
}
local READ_BUFF_TYPE = {
  [9] = {
    [6] = 6,
    [7] = 7,
    [8] = 8
  },
  [8] = {
    [1] = 1
  }
}
local READ_ARG_TYPE = {
  [9] = {
    [1] = 1
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
end

function ui:ui_on_show(item_id, ...)
  if not item_id then
    return
  end
  self.v_item_id = item_id
  self.v_item_cfg = Item_Helper.get_item_cfg(item_id)
  self.v_desc1.text = Util.format_str(self.v_item_cfg.Desc, Item_Helper.get_item_effect(self.v_item_id, self.v_item_cfg))
  self.v_desc2.text = self.v_item_cfg.WorldDesc
  self.v_uiobjects.Desc2:SetActive(not Util.is_empty(self.v_item_cfg.WorldDesc))
  self.v_use_num = 1
end

function ui:ui_on_hide()
end

return ui
