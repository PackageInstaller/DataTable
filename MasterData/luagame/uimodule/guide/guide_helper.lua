local SkillJoyStick = typeof(CS.Game.SkillJoyStick)
local DOTweenVisualManager = typeof(CS.DG.Tweening.DOTweenVisualManager)
local DOTweenAnimation = typeof(CS.DG.Tweening.DOTweenAnimation)
local UnityImage = TypeUnityUIImage
local INPUT_CODE = Config.INPUT_CODE
local helper = {}
local BIND_TYPE = Config.BIND_TYPE
local Vec2 = require("base.vec2")

function helper.get_obj_by_path(ui, ctr_path, target_ui)
  local idx = string.find(ctr_path, "/(%d+)")
  if idx and idx > 0 then
    local chid_idx = string.sub(ctr_path, idx + 1)
    local parent_path = string.sub(ctr_path, 1, idx - 1)
    if ui:get_child_gameobj(parent_path, target_ui:get_ui_obj()).transform.childCount > tonumber(chid_idx) then
      return ui:get_child_gameobj(parent_path, target_ui:get_ui_obj()).transform:GetChild(chid_idx).gameObject
    end
  else
    ctr_path = string.gsub(ctr_path, "&", "")
    if string.find(ctr_path, "/") then
      return ui:get_child_gameobj(ctr_path, target_ui:get_ui_obj())
    else
      local target_obj = target_ui:get_uiobject(ctr_path, BIND_TYPE.OBJECT)
      if target_obj then
        return target_obj
      end
      for _, v in pairs(target_ui:get_panels()) do
        target_obj = v:get_uiobject(ctr_path, BIND_TYPE.OBJECT)
        if target_obj then
          return target_obj
        end
      end
      for k, v in pairs(target_ui:get_wraps()) do
        target_obj = k:get_uiobject(ctr_path, BIND_TYPE.OBJECT)
        if target_obj then
          return target_obj
        end
      end
    end
  end
end

local FRAME_OFFSET = 10

function helper.adjust_frame_rect(ui, copy_obj, old_obj, adjust_rect)
  local target_rect = ui:get_rect_transform(nil, old_obj)
  local origin_pos = target_rect.position
  local origin_size = target_rect.sizeDelta
  local origin_pivot = target_rect.pivot
  local pivot_offset_x = (0.5 - origin_pivot.x) * origin_size.x
  local pivot_offset_y = (0.5 - origin_pivot.y) * origin_size.y
  local copy_rect = ui:get_rect_transform(nil, copy_obj)
  copy_rect:SetAnchoredMinMax(0.5, 0.5, 0.5, 0.5)
  copy_rect.pivot = Vec2.New(0.5, 0.5)
  copy_rect:SetLocalPositionA(0, 0, 0)
  copy_rect:SetSizeDeltaA(origin_size.x, origin_size.y)
  if old_obj.name == "Guide_Area" and 0 == copy_rect.sizeDelta.x and 0 == copy_rect.sizeDelta.y then
    copy_rect:SetSizeDeltaA(origin_size.x, origin_size.y)
  end
  adjust_rect.rotation = target_rect.rotation
  local edge_width = 0
  local edge_hight = 0
  edge_width, edge_hight = ui.v_parent_ui:get_safearea_width_height()
  edge_width = edge_width / 2
  edge_hight = edge_hight / 2
  
  local function clampFunc(value, min, max)
    if value < min then
      value = min
    elseif max < value then
      value = max
    end
    return value
  end
  
  adjust_rect:SetPositionA(origin_pos.x, origin_pos.y, origin_pos.z)
  adjust_rect:SetAnchoredPositionA(clampFunc(adjust_rect.anchoredPosition.x + pivot_offset_x, -edge_width, edge_width), clampFunc(adjust_rect.anchoredPosition.y + pivot_offset_y, -edge_hight, edge_hight), adjust_rect.anchoredPosition.z)
  if ui.v_guider then
    local cfg = ui.v_guider.v_cur_step_cfg
    if cfg then
      if cfg.ui_scale then
        adjust_rect:SetLocalScaleA(cfg.ui_scale)
      end
      if 1 == cfg.is_3d_ui then
        local screenPos = Global.ui_mgr.world_camera:WorldToScreenPoint(origin_pos)
        local half_screen_width = ScreenMgr:get_screen_width() / 2
        local half_screen_height = ScreenMgr:get_screen_height() / 2
        adjust_rect:SetLocalPositionA(screenPos.x - half_screen_width, screenPos.y - half_screen_height, adjust_rect.localPosition.z)
      end
    end
  end
  adjust_rect:SetSizeDeltaA(origin_size.x + FRAME_OFFSET, origin_size.y + FRAME_OFFSET)
end

function helper.get_mask_size(idx, frame_rect, size)
  local position = frame_rect.anchoredPosition
  local X = (1 == idx or 4 == idx) and -position.x or position.x
  local half_width = 0 == idx % 2 and frame_rect.sizeDelta.x * 0.5 or -frame_rect.sizeDelta.x * 0.5
  local Y = idx <= 2 and -position.y or position.y
  local half_height = 0 == idx % 2 and -frame_rect.sizeDelta.y * 0.5 or frame_rect.sizeDelta.y * 0.5
  local width = 0.5 * size.x + X + half_width
  local height = 0.5 * size.y + Y + half_height
  return width, height
end

function helper._destroy_tween(obj)
  local has = false
  local visible_mgr = obj:GetComponent(DOTweenVisualManager)
  if visible_mgr then
    UnityDestroy(visible_mgr)
    has = true
  end
  local tween_anis = obj:GetComponents(DOTweenAnimation)
  if tween_anis and tween_anis.Length > 0 then
    for i = 0, tween_anis.Length - 1 do
      UnityDestroy(tween_anis[i])
    end
    has = true
  end
  return has
end

function helper._reset_joystick(target_obj)
  local joystick = target_obj:GetComponent(SkillJoyStick)
  if joystick then
    joystick.BaseRectTrans:ResetAttr()
  end
end

function helper._reset_joystick_pos(target_obj)
  local joystick = target_obj:GetComponent(SkillJoyStick)
  if joystick then
    joystick:ResetRectPos()
  end
end

function helper.copy_image(old_obj, new_obj)
  local old_imgs = old_obj.gameObject:GetComponentsInChildren(UnityImage)
  local new_imgs = new_obj.gameObject:GetComponentsInChildren(UnityImage)
  for i = 0, old_imgs.Length - 1 do
    new_imgs[i].overrideSprite = old_imgs[i].overrideSprite
  end
end

helper.uiwidget_to_inputcode = {
  Btn_skill1 = {
    INPUT_CODE.INPUT_COMMON
  },
  Btn_skill2 = {
    INPUT_CODE.INPUT_SPECAIL_SKILL
  },
  Btn_skill3 = {
    INPUT_CODE.INPUT_SKILL1
  },
  Btn_skill4 = {
    INPUT_CODE.INPUT_SKILL2
  },
  Btn_skill5 = {
    INPUT_CODE.INPUT_SKILL3
  },
  ["SafeArea/Main_/TeamHeads_/ChangHero1_"] = {
    INPUT_CODE.QTE1
  },
  ["SafeArea/Main_/TeamHeads_/ChangHero2_"] = {
    INPUT_CODE.QTE2
  },
  Btn_skill8 = {
    INPUT_CODE.TOWER_SKILL
  },
  Btn_skill7 = {
    INPUT_CODE.TPS_ATK_SKILL
  },
  Btn_Interact = {
    INPUT_CODE.INPUT_INTERACT
  },
  ["SafeArea/Main_/TeamHeads_/ChangHero1_/UltSkill_"] = {
    INPUT_CODE.QTE_UltSkill_1
  },
  ["SafeArea/Main_/TeamHeads_/ChangHero2_/UltSkill_"] = {
    INPUT_CODE.QTE_UltSkill_2
  },
  ["SafeArea/JoystickContent_/PanelJoystick_/Thumb"] = {
    INPUT_CODE.FORWARD,
    INPUT_CODE.BACKWARD,
    INPUT_CODE.LEFT,
    INPUT_CODE.RIGHT
  },
  ["SafeArea/Main_/BattleTask_/TaskNavigator_/Clickpoint_"] = {
    INPUT_CODE.INPUT_NAVIGATION
  }
}
return helper
