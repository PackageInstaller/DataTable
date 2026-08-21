local M = {}
local Vec2 = require("base.vec2")
local _format = string.format
local cache_had = {}

function M.check_had_child(childs)
  local count = 0
  local temp
  for idx, id in pairs(childs) do
    cache_had[id] = FightBagMgr:get_item_num_by_id(id)
  end
  for _, id in pairs(childs) do
    temp = cache_had[id]
    temp = temp - 1
    cache_had[id] = temp
    if temp >= 0 then
      count = count + 1
    end
  end
  return count
end

function M.get_child_num(childs)
  local count = 0
  for i = 1, 3 do
    if childs[i] and 0 ~= childs[i] then
      count = count + 1
    end
  end
  return count
end

local TYPE_FIXED_VALUE = 1

function M.get_equip_attr_str(attr_id, attr_type, attr_value)
  local name = ShareRes.equip_attr_str(attr_id) or "***"
  local val = M.get_real_type(attr_id, attr_type) == TYPE_FIXED_VALUE and attr_value or attr_value / 100 .. "%"
  return name, val
end

function M.get_real_type(attr_id, attr_type)
  return ShareRes.create("battle.equip_client_show_type", attr_id).show[attr_type]
end

local WEAPON_TEX_PATH = "Weapon/%s"

function M.get_item_icon(item_id, get_quality_path)
  return ShareRes.get_item_icon_path(item_id, get_quality_path)
end

local ITEM_TYPE_PREFIX = "Icon/BattleItem/%s"
local EQUIP_TYPE_PREFIX = "Icon/BattleWeapon/%s"

function M.get_battle_item_icon(item_id)
  local item_cfg = ShareRes.create("battle.battle_item", item_id)
  local collection_cfg = ShareRes.create("battle.battle_collection", item_id)
  local ornament_cfg = ShareRes.create("item.ornaments", item_id)
  local cfg, path
  if item_cfg then
    cfg = item_cfg
    path = ITEM_TYPE_PREFIX
  elseif collection_cfg then
    cfg = collection_cfg
    path = EQUIP_TYPE_PREFIX
  elseif ornament_cfg then
    cfg = ornament_cfg
    path = ITEM_TYPE_PREFIX
  end
  if not cfg then
    Log.Error("配置不存在，id为" .. item_id)
  end
  return string.format(path, cfg.Icon)
end

local BATTLE_ITEM_QUALITY_PATH = "UICommon/%s"

function M.get_battle_item_quality_icon(item_id)
  local fight_item_cfg = ShareRes.create("battle.battle_item", item_id)
  local fight_collection_cfg = ShareRes.create("battle.battle_collection", item_id)
  local item_quality_cfg = ShareRes.create("battle.battle_item_quality")
  local ornament_cfg = ShareRes.create("item.ornaments", item_id)
  local quality
  if fight_item_cfg then
    quality = fight_item_cfg.Quality
  elseif fight_collection_cfg then
    quality = fight_collection_cfg.Quality
  elseif ornament_cfg then
    quality = ornament_cfg.Quality
  end
  return string.format(BATTLE_ITEM_QUALITY_PATH, item_quality_cfg[quality].DropQualityIcon)
end

function M.get_item_quality_icon(item_id)
  return ShareRes.get_item_quality_path(item_id)
end

function M.get_quality_icon(quality)
  return ShareRes.get_quality_path(quality)
end

function M.get_item_images(item_id)
  local icon_path, quality_path = ShareRes.get_item_icon_path(item_id, true)
  return icon_path, quality_path
end

function M.get_hero_images(hero_id, icon_lv, fashion_id, ret_quality)
  icon_lv = icon_lv or Config.HERO_ICON_LV.THUMBNAIL
  local icon_name, icon_path
  if fashion_id and fashion_id > 0 then
    local fashion_cfg = ShareRes.get_fashion_cfg(fashion_id)
    if fashion_cfg then
      icon_name = fashion_cfg.Icon[icon_lv]
    end
  end
  local buddy_config = ShareRes.create("buddy.buddy", hero_id)
  if not icon_name then
    if not buddy_config then
      Log.Error("读取英雄配置失败，英雄id=", hero_id)
      return
    end
    if not buddy_config.Icon or next(buddy_config.Icon) == nil then
      Log.Error("英雄头像或者品质配置异常，英雄id=", hero_id)
      return
    end
    icon_name = buddy_config.Icon[icon_lv]
  end
  if icon_lv == Config.HERO_ICON_LV.THUMBNAIL or icon_lv == Config.HERO_ICON_LV.SHOW_IMG then
    icon_path = _format("Icon/Profile/%s", icon_name)
  else
    icon_path = icon_name
  end
  if ret_quality then
    local quality_name, quality_path
    if icon_lv == Config.HERO_ICON_LV.SHOW_IMG then
      quality_name = ShareRes.get_buddy_qualityIcon_Big(buddy_config.Quality)
      quality_path = _format("UICommon/%s", quality_name)
    else
      quality_name = ShareRes.get_buddy_qualityIcon_Small(buddy_config.Quality)
      quality_path = _format("UICommon/%s", quality_name)
    end
    return icon_path, quality_path
  end
  return icon_path
end

function M.get_hero_settle_spine(hero_id, fashion_id)
  local spine_id, offset
  local is_spine = false
  if fashion_id and fashion_id > 0 then
    local fashion_cfg = ShareRes.get_fashion_cfg(fashion_id)
    if 1 == fashion_cfg.DisplayRegionCfg then
    else
      if fashion_cfg.SettleViewSpine then
        spine_id = fashion_cfg.SettleViewSpine
        is_spine = true
      elseif fashion_cfg.Icon[8] then
        spine_id = fashion_cfg.Icon[8]
        is_spine = true
      elseif fashion_cfg.Icon[7] then
        spine_id = fashion_cfg.Icon[7]
      elseif fashion_cfg.SpineId then
        spine_id = fashion_cfg.SpineId
        is_spine = true
      else
        spine_id = fashion_cfg.Icon[5]
      end
      offset = fashion_cfg.SettleViewOffset
    end
  end
  if not spine_id then
    local buddy_config = ShareRes.create("buddy.buddy", hero_id)
    local buddy_info = CharacterMgr:get_buddy_by_id(hero_id)
    if buddy_info and buddy_info.break_lv > 2 then
      if buddy_config.SettleViewSpine1 then
        spine_id = buddy_config.SettleViewSpine1
        is_spine = true
      elseif buddy_config.Icon[8] then
        spine_id = buddy_config.Icon[8]
        is_spine = true
      elseif buddy_config.Icon[7] then
        spine_id = buddy_config.Icon[7]
      end
      offset = buddy_config.SettleViewOffset1
    end
    if not spine_id then
      if buddy_config.SettleViewSpine2 then
        spine_id = buddy_config.SettleViewSpine2
        is_spine = true
      elseif buddy_config.SpineId then
        spine_id = buddy_config.SpineId
        is_spine = true
      else
        spine_id = buddy_config.Icon[5]
      end
      offset = buddy_config.SettleViewOffset2
    end
  end
  return spine_id, is_spine, offset
end

function M.get_hero_display_big_spine(hero_id, fashion_id)
  local spine_id, offset
  local is_spine = false
  if fashion_id and fashion_id > 0 then
    local fashion_cfg = ShareRes.get_fashion_cfg(fashion_id)
    if 1 == fashion_cfg.IsBase then
    else
      if fashion_cfg.Icon[8] then
        spine_id = fashion_cfg.Icon[8]
        is_spine = true
      elseif fashion_cfg.Icon[7] then
        spine_id = fashion_cfg.Icon[7]
      end
      offset = fashion_cfg.DisplayViewOffset1
      return spine_id, is_spine, offset
    end
  end
  local buddy_config = ShareRes.create("buddy.buddy", hero_id)
  if buddy_config.Icon[8] then
    spine_id = buddy_config.Icon[8]
    is_spine = true
  elseif buddy_config.Icon[7] then
    spine_id = buddy_config.Icon[7]
  end
  offset = buddy_config.DisplayViewOffset1
  return spine_id, is_spine, offset
end

function M.get_hero_display_simple_spine(hero_id, fashion_id)
  local spine_id, offset
  local is_spine = false
  if fashion_id and fashion_id > 0 then
    local fashion_cfg = ShareRes.get_fashion_cfg(fashion_id)
    if 1 == fashion_cfg.IsBase then
    else
      if fashion_cfg.SpineId then
        spine_id = fashion_cfg.SpineId
        is_spine = true
      elseif fashion_cfg.Icon[5] then
        spine_id = fashion_cfg.Icon[5]
      end
      offset = fashion_cfg.DisplayViewOffset2
      return spine_id, is_spine, offset
    end
  end
  local buddy_config = ShareRes.create("buddy.buddy", hero_id)
  if buddy_config.SpineId then
    spine_id = buddy_config.SpineId
    is_spine = true
  else
    spine_id = buddy_config.Icon[5]
  end
  offset = buddy_config.DisplayViewOffset2
  return spine_id, is_spine, offset
end

function M.get_item_qulity(item_id)
  local cfg = M.get_item_cfg(item_id)
  return cfg and cfg.Quality or 0
end

function M.get_item_name(item_id)
  local cfg = M.get_item_cfg(item_id)
  return cfg and cfg.Name or ""
end

function M.get_item_cfg(item_id)
  return ShareRes.get_item_cfg(item_id)
end

function M.get_hero_attr_info(attr_id)
  local attr_info = ShareRes.create("buddy.attribute_define", attr_id)
  if not attr_info then
    Log.Error("读取属性配置失败，属性 id=", attr_id)
    return
  end
  local icon_name = attr_info.IconName
  if not icon_name then
    Log.Error("读取图标名字失败，属性 id=", attr_id)
    return
  end
  local attr_name = ShareRes.get_buddy_attr_name(attr_id)
  if not attr_name then
    Log.Error("读取属性名字失败，属性 id=", attr_id)
    return
  end
  return attr_name, icon_name
end

M.ANCHOR_LAYOUT = {
  MIDDLE = {
    min_x = 0.5,
    min_y = 0.5,
    max_x = 0.5,
    max_y = 0.5
  },
  LEFT = {
    min_x = 0,
    min_y = 0.5,
    max_x = 0,
    max_y = 0.5
  }
}

function M.set_rect_anchor(rect, anchor_name)
  local anchor_map = M.ANCHOR_LAYOUT
  local anchor_data = anchor_map[anchor_name]
  if not anchor_data then
    Log.Error("anchor is not exist = ", anchor_name)
  end
  local min_x = anchor_data.min_x
  local min_y = anchor_data.min_y
  local max_x = anchor_data.max_x
  local max_y = anchor_data.max_y
  rect:SetAnchoredMinMax(min_x, min_y, max_x, max_y)
end

function M.world_to_screen_pos(camera, canvas, x, y, z)
  local screen = UnityEngine.Screen
  local cur_screen_width, cur_screen_height
  cur_screen_width, cur_screen_height = Global.render_mgr:get_cur_resolution()
  cur_screen_width = cur_screen_width or screen.width
  cur_screen_height = cur_screen_height or screen.height
  if Global.screen_width ~= cur_screen_width or Global.screen_height ~= cur_screen_height then
    Global.screen_width = cur_screen_width
    Global.screen_height = cur_screen_height
  end
  local rx, ry, rz = camera:WorldToScreenPointA(x, y, z)
  if canvas then
    local canvas_rect = Util.get_rect_transform(nil, canvas)
    local screen_width = Global.screen_width
    local screen_height = Global.screen_height
    local delta_x, delta_y = canvas_rect:GetSizeDeltaA()
    rx = rx * delta_x / screen_width
    ry = ry * delta_y / screen_height
  end
  return rx, ry
end

function M.convert_to_resolution_pos(raw_pos)
  local screen = UnityEngine.Screen
  if Global.screen_width ~= screen.width then
    return raw_pos / screen.width * Global.screen_width
  end
  return raw_pos
end

function M.get_weapon_tex(name)
  return _format(WEAPON_TEX_PATH, name)
end

return M
