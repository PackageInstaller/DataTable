local Base = require("ui.uibase")
local CHAR_ITEM_CLASS = require("uimodule.fight.tips.damage_detail_char_item")
local DAMAGE_DETAIL_CHAR_ITEM = "DAMAGE_DETAIL_CHAR_ITEM"
local HERO_HP_RECORD_TYPE = Config.CommonDefine.HERO_HP_RECORD_TYPE
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:register_exist_auto_template(DAMAGE_DETAIL_CHAR_ITEM, self.v_uiobjects.CharTem, self.v_uiobjects.CharContent)
  self.v_char_item_map = {}
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
end

function ui:ui_on_show(progress, title_text)
  self.v_uicompents.StageName_txt.text = title_text
  self.v_progress = progress or TowerMgr:get_tower_progress()
  if not self.v_progress or not self.v_progress.damage_record then
    return
  end
  self:refresh_damage_detail()
end

function ui:ui_on_hide()
  self:clear_item()
  self.v_progress = nil
end

function ui:ui_on_destroy()
end

function ui:refresh_damage_detail()
  self:clear_item()
  local temp_data = {}
  local damage_data, owner_data, remove_merge_data, character_id, character_cfg
  local need_merge_list = {}
  local total_cure_value, total_t_damage_value, total_damage_value = 0, 0, 0
  local battle_buddy_data = self.v_progress.battle_buddy_data
  local buddy_data = {}
  for key, data in pairs(battle_buddy_data) do
    buddy_data[data.buddy_id] = {}
    buddy_data[data.buddy_id].character_id = data.buddy_id
    buddy_data[data.buddy_id].value = 0
    buddy_data[data.buddy_id].fashion_id = data.fashion
    buddy_data[data.buddy_id].lv = data.lv or 0
    buddy_data[data.buddy_id].break_lv = data.break_lv or 0
    buddy_data[data.buddy_id].damage_data = {}
  end
  for _, data in ipairs(self.v_progress.damage_record) do
    temp_data[data.character_id] = buddy_data[data.character_id] or {
      damage_data = {}
    }
    damage_data = temp_data[data.character_id].damage_data
    if not damage_data[data.type] then
      damage_data[data.type] = UtilTable.copy_table(data)
    else
      damage_data[data.type].value = damage_data[data.type].value + data.value
    end
    character_id = data.character_id
    character_cfg = ShareRes.get_character_cfg(character_id)
    if not Util.is_empty(character_cfg.SummonNpcIdList) then
      for _, npc_data in pairs(character_cfg.SummonNpcIdList) do
        need_merge_list[npc_data[1]] = character_id
      end
    end
    if data.type == HERO_HP_RECORD_TYPE.CURE then
      total_cure_value = total_cure_value + data.value
    elseif data.type == HERO_HP_RECORD_TYPE.TAKE_DAMAGE then
      total_t_damage_value = total_t_damage_value + data.value
    elseif data.type == HERO_HP_RECORD_TYPE.DAMAGE then
      total_damage_value = total_damage_value + data.value
    end
  end
  for need_merge_id, owner_id in pairs(need_merge_list) do
    if temp_data[need_merge_id] then
      owner_data, remove_merge_data = temp_data[owner_id].damage_data, temp_data[need_merge_id].damage_data
      for damage_type, data in pairs(remove_merge_data) do
        if not owner_data[damage_type] then
          owner_data[damage_type] = data.value
        else
          owner_data[damage_type].value = data.value + owner_data[damage_type].value
        end
      end
    end
  end
  local obj, item
  local last_cure_value, last_t_damage_value, last_damage_value = 0, 0, 0
  local cure_value, t_damage_value, damage_value, max_cure_id, max_t_damage_id, max_damage_id
  local format = "(%.2f%%)"
  for role_id, data in pairs(buddy_data) do
    damage_data = data.damage_data
    cure_value = damage_data[HERO_HP_RECORD_TYPE.CURE] and damage_data[HERO_HP_RECORD_TYPE.CURE].value or 0
    t_damage_value = damage_data[HERO_HP_RECORD_TYPE.TAKE_DAMAGE] and damage_data[HERO_HP_RECORD_TYPE.TAKE_DAMAGE].value or 0
    damage_value = damage_data[HERO_HP_RECORD_TYPE.DAMAGE] and damage_data[HERO_HP_RECORD_TYPE.DAMAGE].value or 0
    obj = self:get_auto_cache(DAMAGE_DETAIL_CHAR_ITEM)
    item = CHAR_ITEM_CLASS:ui_wrap_ex(self, obj, true)
    item:set_data(data, role_id)
    if Util.is_more_than_zero(cure_value) and last_cure_value < cure_value then
      last_cure_value = cure_value
      max_cure_id = role_id
    end
    if Util.is_more_than_zero(t_damage_value) and last_t_damage_value < t_damage_value then
      last_t_damage_value = t_damage_value
      max_t_damage_id = role_id
    end
    if Util.is_more_than_zero(damage_value) and last_damage_value < damage_value then
      last_damage_value = damage_value
      max_damage_id = role_id
    end
    item:set_cure_value(math.ceil(cure_value), string.format(format, total_cure_value > 0 and cure_value / total_cure_value * 100 or 0))
    item:set_tdamage_value(math.ceil(t_damage_value), string.format(format, total_t_damage_value > 0 and t_damage_value / total_t_damage_value * 100 or 0))
    item:set_damage_value(math.ceil(damage_value), string.format(format, total_damage_value > 0 and damage_value / total_damage_value * 100 or 0))
    self.v_char_item_map[role_id] = item
  end
  for role_id, char_item in pairs(self.v_char_item_map) do
    char_item:set_cure_mvp(max_cure_id == role_id)
    char_item:set_tdamage_mvp(max_t_damage_id == role_id)
    char_item:set_damage_mvp(max_damage_id == role_id)
  end
end

function ui:clear_item()
  self:give_back_auto_cache(DAMAGE_DETAIL_CHAR_ITEM)
  for key, item in pairs(self.v_char_item_map) do
    item:ui_hide()
    item:ui_destroy()
    self:remove_wrap_ui(item)
    self.v_char_item_map[key] = nil
  end
end

return ui
