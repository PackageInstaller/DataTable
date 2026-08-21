local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Item_Helper = require("utils.item_helper")

function ui:add_linster()
  self.v_listener = self:bind_auto_mq(Const.MSG_ON_ORNAMENT_CHANGE, self._on_ornament_update, self)
end

function ui:_on_ornament_update()
  self:_refresh()
end

function ui:ui_finish_load()
  self.v_orn_obj_list = {}
  for index = 1, 4 do
    self:set_button("Orn" .. index, function()
      self:on_click(index)
    end)
  end
end

function ui:on_click(index)
  for key, orn_obj in pairs(self.v_orn_obj_list) do
    if key == index and orn_obj.ornament_data then
      local pos = orn_obj.ornament_data.id
      if BattleOrnamentMgr:get_select_pos() == pos then
        orn_obj.select_obj.gameObject:SetActive(false)
        self.v_select_pos = nil
        BattleOrnamentMgr:set_select_pos(nil)
      else
        orn_obj.select_obj.gameObject:SetActive(true)
        self.v_select_pos = orn_obj.ornament_data.id
        BattleOrnamentMgr:set_select_pos(self.v_select_pos)
      end
    else
      orn_obj.select_obj.gameObject:SetActive(false)
    end
  end
end

function ui:ui_on_show()
  self:_refresh()
end

function ui:_refresh()
  local ornaments_list = BattleOrnamentMgr:get_ornaments_list()
  if not ornaments_list then
    return
  end
  self.v_ornaments_list = UtilTable.copy_table(ornaments_list)
  self:set_ornament_data()
end

function ui:set_ornament_data()
  self.new_data_list = {}
  local new_ornaments_list = UtilTable.copy_table(self.v_ornaments_list)
  local is_max_count = BattleOrnamentMgr:is_ornament_count_max()
  for index, ornament_data in pairs(new_ornaments_list) do
    if ornament_data.item_id then
      local ornament_cfg = ShareRes.create("item.ornaments", ornament_data.item_id)
      if not ornament_cfg and ornament_data.item_id then
        Log.Error("饰品表中没有ID为：", ornament_data.item_id, "的配置信息")
      end
      ornament_data.quality = ornament_cfg.Quality
      ornament_data.ornament_cfg = ornament_cfg
      table.insert(self.new_data_list, ornament_data)
    end
  end
  for index = 1, 4 do
    local ornament_data = self.new_data_list[index]
    local bg2_img, bg1_obj, orn_icon_img, select_obj, desc_txt, point_img
    if not self.v_orn_obj_list[index] then
      local tb = {}
      tb.desc_txt = self.v_uicompents["Desc" .. index .. "_txt"]
      tb.point_img = self.v_uicompents["Point" .. index .. "_img"]
      tb.select_obj = self.v_uiobjects["Select" .. index]
      tb.orn_obj = self.v_uiobjects["Orn" .. index]
      tb.bg2_img = Util.get_image("Bg2_", tb.orn_obj)
      tb.bg1_obj = Util.get_child("Bg1_", tb.orn_obj)
      tb.orn_icon_img = Util.get_image("OrnIcon_", tb.orn_obj)
      self.v_orn_obj_list[index] = tb
    end
    bg2_img = self.v_orn_obj_list[index].bg2_img
    bg1_obj = self.v_orn_obj_list[index].bg1_obj
    orn_icon_img = self.v_orn_obj_list[index].orn_icon_img
    select_obj = self.v_orn_obj_list[index].select_obj
    desc_txt = self.v_orn_obj_list[index].desc_txt
    point_img = self.v_orn_obj_list[index].point_img
    select_obj.gameObject:SetActive(false)
    self.v_orn_obj_list[index].ornament_data = ornament_data
    if ornament_data then
      ResMgr:load_set_icon(bg2_img, BattleOrnamentMgr:get_ornament_bg_icon(ornament_data.quality))
      ResMgr:load_set_icon(orn_icon_img, ornament_data.ornament_cfg.Icon)
      desc_txt.text = ornament_data.ornament_cfg.Desc
      if 5 == ornament_data.quality then
        desc_txt.color = BattleOrnamentMgr:get_ornament_color(ornament_data.quality)
      else
        desc_txt.color = BattleOrnamentMgr:get_ornament_color(0)
      end
      point_img.color = BattleOrnamentMgr:get_ornament_color(ornament_data.quality)
      bg2_img.gameObject:SetActive(true)
      orn_icon_img.gameObject:SetActive(true)
    else
      bg2_img.gameObject:SetActive(false)
      orn_icon_img.gameObject:SetActive(false)
    end
  end
  if is_max_count then
    self:defaul_select_orn()
  end
end

function ui:defaul_select_orn()
  table.sort(self.new_data_list, function(a, b)
    local x = 0
    local y = 0
    x = a.quality * 100000
    y = b.quality * 100000
    if x ~= y then
      return x < y
    end
    return false
  end)
  if self.new_data_list[1] then
    local select_item_id = self.new_data_list[1].item_id
    for key, orn_obj in pairs(self.v_orn_obj_list) do
      if orn_obj.ornament_data and orn_obj.ornament_data.item_id and orn_obj.ornament_data.item_id == select_item_id then
        orn_obj.select_obj.gameObject:SetActive(true)
        self.v_select_pos = orn_obj.ornament_data.id
        BattleOrnamentMgr:set_select_pos(self.v_select_pos)
        break
      else
        orn_obj.select_obj.gameObject:SetActive(false)
      end
    end
  end
end

function ui:ui_on_hide()
  if not self.v_is_wear_orn then
    self.v_select_pos = nil
    BattleOrnamentMgr:set_select_pos(nil)
  end
  self.v_is_wear_orn = nil
end

return ui
