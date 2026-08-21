local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local Char_Helper = require("uimodule.character.char_helper")
local Quat = require("base.quat")
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_bg = {
    "Bg",
    BIND_TYPE.IMAGE
  },
  v_light_up = {
    "LightUp",
    BIND_TYPE.IMAGE
  },
  v_light_down = {
    "LightDown",
    BIND_TYPE.IMAGE
  },
  v_new_tip = {
    "NewTip",
    BIND_TYPE.OBJECT
  },
  v_chara_quality = {
    "CharaQuality",
    BIND_TYPE.IMAGE
  },
  v_equip_quality = {
    "EquipQuality",
    BIND_TYPE.IMAGE
  },
  v_quality_bg = {
    "QualityBg",
    BIND_TYPE.IMAGE
  },
  v_move_node = {
    "MoveNode",
    BIND_TYPE.OBJECT
  },
  v_quality_eff_3 = {
    "Ani_VX_UIDrawCard_Multi_Rlt_Blue",
    BIND_TYPE.OBJECT
  },
  v_quality_eff_4 = {
    "Ani_VX_UIDrawCard_Multi_Rlt_Pur",
    BIND_TYPE.OBJECT
  },
  v_quality_eff_5 = {
    "Ani_VX_UIDrawCard_Multi_Rlt_Glod",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_object:SetActive(true)
end

local function _set_naitive_size(img)
  img:SetNativeSize()
end

function ui:set_data(data, idx, cb, cb_self)
  local item_id = data.item_id
  local quality = UtilUI.get_item_qulity(item_id)
  local config = ShareRes.get_drawcard_anim_res(quality)
  local x, y, z
  if 0 == idx % 2 then
    x, y, z = self.v_uicompents.LowerPos_rect:GetLocalPositionA3()
  else
    x, y, z = self.v_uicompents.UpPos_rect:GetLocalPositionA3()
  end
  self.v_uicompents.CtrlNode_rect:SetLocalPositionA(0, y, 0)
  assert(config)
  ResMgr:load_set_icon(self.v_bg, string.format("UIDraw/%s", config.Bg[4]))
  ResMgr:load_set_icon(self.v_light_up, string.format("UIDraw/%s", config.Bg[5]))
  ResMgr:load_set_icon(self.v_light_down, string.format("UIDraw/%s", config.Bg[5]))
  ResMgr:load_set_icon(self.v_quality_bg, string.format("UIDraw/%s", config.Bg[6]))
  if config.Bg[8] ~= "" then
    self.v_uiobjects.QualityBg1:SetActive(true)
    ResMgr:load_set_icon(self.v_uicompents.QualityBg1_img, string.format("UIDraw/%s", config.Bg[8]))
  else
    self.v_uiobjects.QualityBg1:SetActive(false)
  end
  if config.Bg[9] ~= "" then
    self.v_uiobjects.QualityBg2:SetActive(true)
    ResMgr:load_set_icon(self.v_uicompents.QualityBg2_img, string.format("UIDraw/%s", config.Bg[9]))
  else
    self.v_uiobjects.QualityBg2:SetActive(false)
  end
  local type_config = Util.get_item_type_cfg(item_id)
  local item_type = type_config.AwardType
  self.v_uiobjects.OtherIcon:SetActive(item_type ~= Config.AWARD_TYPE.EQUIP and item_type ~= Config.AWARD_TYPE.CHARA)
  self.v_uiobjects.CharJob:SetActive(item_type == Config.AWARD_TYPE.CHARA)
  self.v_uiobjects.CharIcon:SetActive(item_type == Config.AWARD_TYPE.CHARA)
  self.v_uiobjects.WeaponIcon:SetActive(item_type == Config.AWARD_TYPE.EQUIP)
  Util.set_color(self.v_uicompents.ColorMask_img, config.Color[1])
  Util.set_color(self.v_uicompents.ColorIcon_img, config.Color[2])
  Util.set_color(self.v_uicompents.Line_img, config.Color[3])
  if item_type == Config.AWARD_TYPE.CHARA then
    local buddy_config = ShareRes.get_buddy_cfg(item_id)
    local path = UtilUI.get_hero_images(item_id, Config.HERO_ICON_LV.DRAW_CARD_IMG)
    ResMgr:load_set_icon(self.v_uicompents.CharIcon_img, path, nil, true, self)
    Char_Helper.set_buddy_quality_star(self.v_uiobjects, buddy_config.Quality)
    local pos = buddy_config.Icon[4]
    local trans = self.v_uiobjects.CharIcon.transform
    if pos then
      local scale = 0 ~= pos[3] and pos[3] or 1
      trans:SetLocalScaleA(scale, scale, scale)
      trans:SetLocalPositionA(pos[1], pos[2], 0)
    else
      Log.Error("角色未配置Icon[4]：", item_id)
    end
    local char_job_icon = Char_Helper.get_char_job_icon(item_id)
    ResMgr:load_set_icon(self.v_uicompents.CharJob_img, char_job_icon)
  elseif item_type == Config.AWARD_TYPE.EQUIP then
    local equip_cfg = ShareRes.get_equip(item_id)
    local pos_rotate = equip_cfg.MultiPosRotate
    local path = UtilUI.get_weapon_tex(equip_cfg.Painting[1])
    ResMgr:load_set_icon(self.v_uicompents.WeaponIcon_img, path, nil, true)
    Char_Helper.set_buddy_quality_star(self.v_uiobjects, equip_cfg.Quality)
    local trans = self.v_uiobjects.WeaponIcon.transform
    local scale = 0 ~= pos_rotate[3] and pos_rotate[3] or 1
    trans:SetLocalScaleA(scale, scale, scale)
    trans:SetLocalPositionA(pos_rotate[1], pos_rotate[2], 0)
    trans.localRotation = Quat.Euler(0, 0, pos_rotate[4])
  else
    local item_config = ShareRes.get_item_cfg(item_id)
    local path = string.format("Icon/Item/%s", item_config.Icon)
    ResMgr:load_set_icon(self.v_uiobjects.OtherIcon_img, path, _set_naitive_size)
    Char_Helper.set_buddy_quality_star(self.v_uiobjects, 0)
  end
  self.v_new_tip:SetActiveEx(data.is_new)
  local pos = self.v_move_node.transform.localPosition
  self.v_move_node.transform:SetLocalPositionA(pos.x + Global.screen_width * 0.2, pos.y, pos.z)
  local fade_obj = self:get_canvas_group(nil, self.v_move_node.transform)
  fade_obj.alpha = 0
  local TWEEN_EASE_OUT_EXPO = CS.DG.Tweening.Ease.OutQuad
  local MOVE_TIME = 0.2
  local FADE_TIME = 0.3
  if self.v_sequence then
    self.v_sequence:Kill(false)
  end
  self.v_quality_eff_3:SetActive(false)
  self.v_quality_eff_4:SetActive(false)
  self.v_quality_eff_5:SetActive(false)
  local sequence = Util.create_sequence()
  sequence:AppendInterval(MOVE_TIME * 0.3 * idx)
  sequence:AppendCallback(function()
    local eff_obj = self["v_quality_eff_" .. quality]
    if eff_obj then
      eff_obj:SetActive(true)
    end
  end)
  sequence:Append(fade_obj:DOFade(1, FADE_TIME):SetEase(TWEEN_EASE_OUT_EXPO))
  sequence:Join(self.v_move_node.transform:DOLocalMoveX(0, MOVE_TIME):SetEase(TWEEN_EASE_OUT_EXPO))
  sequence:AppendInterval(MOVE_TIME * idx + 0.5)
  sequence:AppendCallback(function()
    if cb then
      cb(cb_self)
    end
  end)
  self.v_sequence = sequence
end

function ui:ui_on_hide()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

return ui
