local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local UIArchivePath = "UIArchive/%s"

function ui:ui_wrap()
end

function ui:ui_finish_load()
  self.v_weakness_obj_list = {}
end

function ui:ui_on_show()
end

function ui:ui_on_destroy()
  self.v_weakness_obj_list = nil
end

function ui:set_data(enemy_id)
  for _, obj in ipairs(self.v_weakness_obj_list) do
    obj:SetActive(false)
  end
  local enemy_cfg = ShareRes.get_enemy_cfg(enemy_id)
  local headIcon = string.format(UIArchivePath, enemy_cfg.HeadIcon)
  local enemy_image = Util.get_image(nil, self.v_uiobjects.EnemyIcon)
  ResMgr:load_set_icon(enemy_image, headIcon, nil, true)
  local enemy_character_cfg = ShareRes.get_character_cfg(enemy_id)
  if enemy_character_cfg.ElementWeakList then
    for index, elementID in ipairs(enemy_character_cfg.ElementWeakList) do
      if index > #self.v_weakness_obj_list then
        local obj = UnityGameObject.Instantiate(self.v_uiobjects.EleIconTem, self.v_uiobjects.EleBg.transform)
        table.insert(self.v_weakness_obj_list, obj)
      end
      local element_obj = self.v_weakness_obj_list[index]
      local element_cfg = ShareRes.get_element_cfg(elementID)
      local elementIconPath = element_cfg.ElementIconPath
      local image_com = Util.get_image(nil, element_obj)
      ResMgr:load_set_icon(image_com, elementIconPath)
      element_obj:SetActive(true)
    end
  end
end

return ui
