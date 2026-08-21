local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local Vec3 = require("base.vec3")
local Type2Bg = {
  [1] = "UIBattleGame1/SP/Battlegame_bg_rdb",
  [2] = "UIBattleGame1/SP/Battlegame_bg_rdl",
  [3] = "UIBattleGame1/SP/Battlegame_bg_rdl",
  [4] = "UIBattleGame1/SP/Battlegame_bg_rdh",
  [5] = "UIBattleGame1/SP/Battlegame_bg_rdh"
}
local Type2Color = {
  [1] = "ColorLink_img",
  [2] = "ColorStart_img",
  [3] = "ColorEnd_img",
  [4] = "ColorStart_img",
  [5] = "ColorEnd_img"
}
local TypeLink = 1
local TypeWater = 2
local TypeWaterEnd = 3
local TypeDirtyWater = 4
local TypeDirtyWaterEnd = 5

function ui:ui_finish_load()
end

function ui:set_data(data)
  self.pipe_cnt = #data.directions
  if self.pipe_cnt < 1 then
    self.v_uiobjects.Content:SetActive(false)
    self.v_uiobjects.Button:SetActive(false)
    return
  else
    self.v_uiobjects.Content:SetActive(true)
    self.v_uiobjects.Button:SetActive(true)
  end
  self.v_pipes = {
    self.v_uiobjects.Top,
    self.v_uiobjects.Right,
    self.v_uiobjects.Lower,
    self.v_uiobjects.Left
  }
  self.v_data = data
  self.v_uiobjects.Lock:SetActive(data.isLock)
  self:set_pipe()
  self:set_initial()
  if not self.v_data.isLock then
    self:set_button("Button", function()
      self:rotate()
    end)
  end
end

function ui:set_pipe()
  for k, obj in ipairs(self.v_pipes) do
    obj:SetActive(false)
  end
  local directions = self.v_data.directions
  self.v_pipe_dict = {}
  for i = 1, #directions do
    directions[i] = (directions[i] + math.floor(self.v_data.rotateAngle / 90)) % 4
    self.v_pipes[directions[i] + 1]:SetActive(true)
    table.insert(self.v_pipe_dict, directions[i] + 1)
  end
  self:set_node_icon(self.v_data.centerType)
end

function ui:set_node_icon(ty)
  self.v_is_start_node = ty == TypeWater or ty == TypeDirtyWater
  self.v_is_end_node = ty == TypeWaterEnd or ty == TypeDirtyWaterEnd
  self.v_end_node_light_eff = nil
  self.v_uiobjects.NodeLink:SetActiveEx(ty == TypeLink)
  self.v_uiobjects.NodeStart:SetActiveEx(self.v_is_start_node)
  self.v_uiobjects.NodeEnd:SetActiveEx(self.v_is_end_node)
  self.v_uiobjects.Fx_NodeStart_Red:SetActiveEx(ty == TypeDirtyWater)
  self.v_uiobjects.Fx_NodeStart_Blue:SetActiveEx(ty == TypeWater)
  self.v_color_img = self.v_uicompents[Type2Color[ty]]
  self.v_color_img.gameObject:SetActiveEx(self.v_is_start_node)
  ResMgr:load_set_icon(self.v_uicompents.Bg_img, Type2Bg[ty], nil)
  if self.v_is_start_node then
    local color_str = ty == TypeWater and "79a5ff" or "ff5e5e"
    Util.set_color(self.v_color_img, color_str)
  elseif self.v_is_end_node then
    self.v_end_node_light_eff = ty == TypeWaterEnd and self.v_uiobjects.Fx_NodeEnd_Blue or self.v_uiobjects.Fx_NodeEnd_Red
  end
end

function ui:rotate()
  if not self.v_parent_class then
    self.v_parent_class = UIMgr:get_ui("ui_water_pipe_sp")
  end
  Global.sound_mgr:play_sound_by_id("Sound_pipe_turn")
  self.v_parent_class:change_canvas_raycaster(false)
  for i = 1, self.pipe_cnt do
    self.v_data.directions[i] = (self.v_data.directions[i] + 3) % 4
  end
  self:clear_sequence()
  self.v_sequence = Util.create_sequence()
  self.v_sequence:Join(self.v_uiobjects.Rotation.transform:DORotate(Vec3.New(0, 0, 90), 0.1, CS.DG.Tweening.RotateMode.WorldAxisAdd))
  self.v_sequence:OnComplete(function()
    self.v_parent_class:check_is_pass()
  end)
end

function ui:set_pipe_state(state)
  if self.pipe_cnt < 1 or state == self.v_state then
    return
  end
  for i = 1, #self.v_pipe_dict do
    local transform = self.v_pipes[self.v_pipe_dict[i]].transform
    if not transform then
      break
    end
    if 3 == state then
      transform:GetChild(0):SetActive(false)
      transform:GetChild(1):SetActive(true)
      if not self.v_is_start_node then
        self.v_color_img.gameObject:SetActiveEx(true)
        Util.set_color(self.v_color_img, "ff5e5e")
      end
      transform:FindChild("DirtyWater/Fx_UIBattleGame_DirtyWater"):SetActive(true)
      self:set_link()
    elseif 2 == state then
      transform:GetChild(0):SetActive(true)
      transform:GetChild(1):SetActive(false)
      transform:FindChild("Water/Fx_UIBattleGame_Water"):SetActive(true)
      if not self.v_is_start_node then
        self.v_color_img.gameObject:SetActiveEx(true)
        Util.set_color(self.v_color_img, "79a5ff")
      end
      self:set_link()
    elseif 1 == state then
      transform:GetChild(0):SetActive(false)
      transform:GetChild(1):SetActive(false)
      if not self.v_is_start_node then
        self.v_color_img.gameObject:SetActiveEx(false)
      end
    end
  end
  local ty = self.v_data.centerType
  if self.v_end_node_light_eff then
    local active = ty == TypeWaterEnd and 2 == state or ty == TypeDirtyWaterEnd and 3 == state
    self.v_end_node_light_eff:SetActiveEx(active)
    if active then
      Global.sound_mgr:play_sound_by_id("Sound_pipe_connect")
    end
  end
  self.v_state = state
end

function ui:set_initial()
  if self.pipe_cnt < 1 then
    return
  end
  self.v_uiobjects.NodeAni:SetActiveEx(false)
  self.v_uiobjects.NodeAni:SetActive(true)
end

function ui:set_link()
  if self.pipe_cnt < 1 then
    return
  end
  self.v_uiobjects.LinkAni:SetActiveEx(false)
  self.v_uiobjects.LinkAni:SetActive(true)
end

function ui:set_glow(state)
  if self.pipe_cnt < 1 then
    return
  end
  self.v_uiobjects.GlowAni:SetActiveEx(false)
  if state then
    self.v_uiobjects.GlowAni:SetActive(true)
  else
    self.v_uicompents.BgGlow_cg.alpha = 0
  end
end

function ui:on_clear()
  self:set_glow(false)
  self.v_uiobjects.LinkAni:SetActiveEx(false)
  self:clear_sequence()
end

function ui:clear_sequence()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

return ui
