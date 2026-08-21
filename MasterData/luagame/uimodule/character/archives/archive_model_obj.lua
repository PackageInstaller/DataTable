local M = Util.create_class()
local Vec3 = require("base.vec3")
local Quat = require("base.quat")
local Quaternion = UnityEngine.Quaternion
local Model_Order_ParentObj = "OrderNumbers"
local Model_Text_Pos = "TextPos"
local Model_NewTag_Pos = "NewTag"
local Model_Locked = "Locked"
local CSUnityEngine = UnityEngine
local UnityShader = CSUnityEngine.Shader
local TypeCollider = typeof(CSUnityEngine.Collider)
local TypeMeshRenderer = typeof(CSUnityEngine.MeshRenderer)
local ColorPropID = UnityShader.PropertyToID("_Color")
local Color = require("base.color")
local ARCHIVE_EVENT = {
  ADD = "ADD",
  UPGRADE = "UPGRADE",
  FAVOR = "FAVOR",
  EPISODE = "EPISODE"
}

function M:_init(data)
  self.v_data = data
  self.v_book_trans = data.trans
  self.v_ui_text = data.ui_text
  self.v_new_tag_obj = data.new_tag_obj
  self.v_parent_ui = data.parent_ui
  self:init_obj()
  self:set_model_ui()
end

function M:init_obj()
  local config = self.v_data.cfg
  local model_obj = Util.active_child_but(self.v_book_trans, config.Style - 1)
  model_obj:SetActive(true)
  self.v_model_obj = model_obj
  self.v_model_trans = model_obj.transform
  local pos = config.Pos
  local rotate = config.Rotate
  self.v_model_trans:SetEuler(rotate[1], rotate[2], rotate[3])
  self.v_model_trans:SetLocalPositionA(pos[1], pos[2], pos[3])
end

function M:set_model_ui()
  local orders_parent_trans = self.v_model_obj:FindChild(Model_Order_ParentObj)
  if orders_parent_trans then
    local index = self.v_data.cfg.Priority - 1
    Util.active_child_but(orders_parent_trans, index)
  end
  local is_unlocked = self.v_data.info.unlocked
  local locked_obj = self.v_model_obj:FindChild(Model_Locked)
  if locked_obj then
    locked_obj:SetActive(not is_unlocked)
  end
  self:set_model_gray(not is_unlocked)
  local is_new = self.v_data.info.have_red
  self.v_not_new = not is_new
  self.v_new_tag_obj:SetActive(is_new)
  if is_new then
    self:set_newtag_pos()
  end
  self:refresh_condition()
end

local gray_color = Color.New(0.25, 0.25, 0.25, 1)
local org_color = Color.New(0.6, 0.6, 0.6, 1)

function M:set_model_gray(is_gray)
  local mesh_renderer = self.v_model_obj:GetComponentInChildren(TypeMeshRenderer)
  if not mesh_renderer then
    return
  end
  local mat = mesh_renderer.material
  local color = is_gray and gray_color or org_color
  mat:SetColor(ColorPropID, color)
end

function M:refresh_condition()
  local condition_txt = self.v_ui_text
  condition_txt:SetActive(not self.v_data.info.unlocked)
  if self.v_data.info.unlocked then
    return
  end
  local config = self.v_data.cfg
  local event = config.Event
  local arg = config.Arg
  if event == ARCHIVE_EVENT.ADD then
    condition_txt.text = ""
  elseif event == ARCHIVE_EVENT.UPGRADE and arg then
    condition_txt.text = Util.format_str("突破{1}后解锁", arg - 1)
  elseif event == ARCHIVE_EVENT.FAVOR and arg then
    condition_txt.text = Util.format_str("好感度Lv{1}级解锁", arg)
  elseif event == ARCHIVE_EVENT.EPISODE and arg then
    local chapter_cfg = ShareRes.get_chapter_point_cfg(arg)
    condition_txt.text = Util.format_str("通关{1}后解锁", chapter_cfg.PointName)
  end
  self:set_text_pos()
end

function M:on_click(id)
  if not self.v_data.info.unlocked then
    return
  end
  UIMgr:get_ui("archive_detail_pop"):ui_show(id)
  self.v_new_tag_obj:SetActive(false)
  if not self.v_not_new then
    CharacterMgr:on_update_archive_state(self.v_parent_ui:get_buddy_id(), id, function()
      self.v_not_new = true
    end)
  end
end

function M:clear()
  self.v_model_obj = nil
  self.v_model_trans:SetActive(false)
  self.v_model_trans = nil
  self.v_book_trans = nil
  self.v_ui_text:SetActive(false)
  self.v_ui_text = nil
  self.v_new_tag_obj:SetActive(false)
  self.v_new_tag_obj = nil
end

function M:set_text_pos()
  local text_obj_trans = self.v_model_trans:FindChild(Model_Text_Pos)
  if not text_obj_trans then
    return
  end
  local uimain = UIMgr:get_ui("uimain")
  if not uimain then
    return
  end
  local x, y, z = text_obj_trans:GetPositionA()
  local screen_pos_x, screen_pos_y = uimain:world_to_screen_pos(x, y, z)
  local text_rect = Util.get_rect_transform(nil, self.v_ui_text)
  text_rect:SetAnchoredPositionA(screen_pos_x, screen_pos_y)
end

function M:set_newtag_pos()
  local newtag_trans = self.v_model_trans:FindChild(Model_NewTag_Pos)
  if not newtag_trans then
    return
  end
  local uimain = UIMgr:get_ui("uimain")
  if not uimain then
    return
  end
  local x, y, z = newtag_trans:GetPositionA()
  local screen_pos_x, screen_pos_y = uimain:world_to_screen_pos(x, y, z)
  local rect = Util.get_rect_transform(nil, self.v_new_tag_obj)
  rect:SetAnchoredPositionA(screen_pos_x, screen_pos_y)
end

function M:get_archive_id()
  return self.v_data.cfg.ID
end

return M
