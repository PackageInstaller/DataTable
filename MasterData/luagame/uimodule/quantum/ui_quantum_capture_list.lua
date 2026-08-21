local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("PreviousBtn", function()
    self:on_click_switch_btn(-1)
  end)
  self:set_button("NextBtn", function()
    self:on_click_switch_btn(1)
  end)
  self:set_button("DeleteBtn", function()
    self:on_click_delete_btn()
  end)
  self.v_capture_item_list = {
    {
      gameobject = self.v_uiobjects.LocationTem
    }
  }
  self.v_capture_system_data = VisualGameManager:get_capture_system_data()
  local add_count = #self.v_capture_system_data.PovID - #self.v_capture_item_list
  for i = 1, add_count do
    local capture_item = UnityGameObject.Instantiate(self.v_uiobjects.LocationTem, self.v_uiobjects.LocationList.transform)
    local t = {gameobject = capture_item}
    table.insert(self.v_capture_item_list, t)
  end
  self:set_data()
  self.v_cur_select_index = 1
  self.v_raw_image = Util.get_rawimage(nil, self.v_uiobjects.PhotographRawImage)
end

function ui:ui_on_show()
  SceneMgr:set_player_control_off()
  self:refresh()
end

function ui:ui_on_update()
end

function ui:ui_on_hide()
  SceneMgr:set_player_control_on()
end

function ui:ui_on_destroy()
  for _, value in ipairs(self.v_capture_item_list) do
    self:remove_button_listener(value.Btn)
  end
  self.v_capture_item_list = nil
end

function ui:set_data()
  for index, value in ipairs(self.v_capture_item_list) do
    local item_obj = value.gameobject
    local NormalName_txt = Util.get_text("Nomal/NomalName", item_obj)
    local SelectName_txt = Util.get_text("Select/SelectName", item_obj)
    NormalName_txt.text = self.v_capture_system_data.Desc[index]
    SelectName_txt.text = self.v_capture_system_data.Desc[index]
    local Normal = Util.get_child_gameobj("Nomal", item_obj)
    local Select = Util.get_child_gameobj("Select", item_obj)
    local btn = Util.get_button(nil, item_obj)
    value.Normal = Normal
    value.Select = Select
    value.Btn = btn
    self:set_button_listener(btn, function()
      self:on_click_capture_btn(index)
    end)
  end
end

function ui:refresh()
  self.v_uiobjects.PreviousBtn:SetActiveEx(1 ~= self.v_cur_select_index and true or false)
  self.v_uiobjects.NextBtn:SetActiveEx(self.v_cur_select_index ~= #self.v_capture_system_data.PovID and true or false)
  local rt = VisualGameManager:get_capture_rt(self.v_capture_system_data.PovID[self.v_cur_select_index])
  self.v_uiobjects.PhotographRawImage:SetActiveEx(rt)
  if rt then
    self.v_raw_image.texture = rt
    self.v_uiobjects.Image:SetActiveEx(false)
  else
    self.v_uiobjects.Image:SetActiveEx(true)
  end
  for index, item in ipairs(self.v_capture_item_list) do
    item.Normal:SetActiveEx(index ~= self.v_cur_select_index)
    item.Select:SetActiveEx(index == self.v_cur_select_index)
  end
end

function ui:on_click_capture_btn(index)
  self:switch_capture(index)
end

function ui:on_click_switch_btn(offset)
  self:switch_capture(self.v_cur_select_index + offset)
end

function ui:switch_capture(index)
  if self.v_cur_select_index == index then
    return
  end
  self.v_cur_select_index = index
  self.v_uicompents.Ani_UIQuantumPhotographList_Select_pd.time = 0
  self.v_uicompents.Ani_UIQuantumPhotographList_Select_pd:Play()
  self:refresh()
end

function ui:on_click_delete_btn()
  local pov_index = self.v_capture_system_data.PovID[self.v_cur_select_index]
  VisualGameManager:remove_capture(pov_index)
  self:refresh()
end

return ui
