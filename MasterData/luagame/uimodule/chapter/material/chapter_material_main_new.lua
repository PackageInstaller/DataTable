local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local _tinsert = table.insert
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local CHAPTER_MATERIAL_ITEM_KEY = "CHAPTER_MATERIAL_ITEM_KEY"
local _tsort = table.sort
local MODEL = {
  v_chapter_content = {
    "Content",
    BIND_TYPE.OBJECT
  },
  v_chapter_template = {
    "StageTem",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.list_key = "Chapter_Material_item_Key" .. self:ui_get_name()
  self:register_exist_auto_template(self.list_key, self.v_chapter_template, self.v_chapter_content)
end

function ui:ui_on_show()
  self:init_chapter_material_list()
  self:bind_auto_mq(Const.MSG_CLOSE_MATERIAL, self.close_material, self)
end

function ui:init_chapter_material_list()
  self.v_all_chapter_material = {}
  self.v_all_ui_go_material = {}
  self.day_of_week = ChapterMaterialMgr:get_day_of_week()
  local material_data = ShareRes.get_chapter_material_type_cfg()
  self:give_back_auto_cache(self.list_key)
  local new_data = {}
  for _, data in pairs(material_data) do
    _tinsert(new_data, data)
    self.v_all_chapter_material[data.Id] = data
  end
  _tsort(new_data, function(a, b)
    return a.Order < b.Order
  end)
  for index, material_data in ipairs(new_data) do
    self:new_chapter_material(material_data.Id)
  end
end

function ui:new_chapter_material(Id)
  local chapter_ui = self:get_auto_cache(self.list_key)
  local material_cfg = self.v_all_chapter_material[Id]
  self.v_all_ui_go_material[Id] = chapter_ui
  local stage_name = Util.get_text("Title_", chapter_ui)
  stage_name.text = material_cfg.Name
  local is_lock = false
  local tip_text
  if not Condition:check_condition(material_cfg.Condition) then
    is_lock = true
    if 0 ~= material_cfg.Condition then
      tip_text = ShareRes.create("condition.condition", material_cfg.Condition).Desc
    end
  end
  local tips = Util.get_text("Tips_", chapter_ui)
  tips.text = material_cfg.NoConditionTips
  local lock_go = Util.get_child_gameobj("Lock_", chapter_ui)
  local lock_text = Util.get_text("Lock_/Condition_", chapter_ui)
  lock_go:SetActive(is_lock)
  local temp_text = tip_text
  lock_text.text = temp_text
  local icon = Util.get_image("Icon_", chapter_ui)
  ResMgr:load_set_icon(icon, material_cfg.Icon, nil, true)
  self:update_element(chapter_ui, material_cfg)
  local red_obj = Util.get_child_gameobj("RedPoint_", chapter_ui)
  if red_obj then
    RedPointMgr:bind_redpoint(self, red_obj, material_cfg.MaterialType, Global.red_enum.MATERIAL_BTN_RED)
  end
  self:set_button_listener(Util.get_button(nil, chapter_ui), function()
    if is_lock then
      Util.show_message_tip(temp_text)
      return
    end
    ChapterMaterialMgr:request_click_new_material_epi(material_cfg.MaterialType)
    ChapterMaterialMgr:set_chapter_material_level_type(material_cfg.MaterialType)
    UIMgr:get_ui("chapter_material_level_main"):ui_show()
  end)
end

function ui:update_element(chapter_ui, material_cfg)
  local element_obj = Util.get_child_gameobj("EleObj_", chapter_ui)
  local drop_sign = ChapterMaterialMgr:get_material_is_drop_sign(material_cfg.MaterialType)
  if 1 ~= drop_sign then
    element_obj:SetActive(false)
  else
    element_obj:SetActive(true)
    self.element_cfg_list = ChapterMaterialMgr:get_today_element_list()
    local optional_obj = Util.get_child_gameobj("EleObj_/EleLayout2_", chapter_ui)
    local not_optional_obj = Util.get_child_gameobj("EleObj_/EleLayout1_", chapter_ui)
    local is_auto_select = ChapterMaterialMgr:get_material_is_auto_select_with_type(material_cfg.MaterialType)
    if is_auto_select then
      optional_obj:SetActive(true)
      not_optional_obj:SetActive(false)
    else
      optional_obj:SetActive(false)
      not_optional_obj:SetActive(true)
    end
    local len = #self.element_cfg_list
    for i = 1, len do
      local iconPath
      if is_auto_select then
        iconPath = string.format("EleObj_/EleLayout2_/Ele%s/EleIcon", i)
      else
        iconPath = string.format("EleObj_/EleLayout1_/Ele%s/EleIcon", i)
      end
      local image = Util.get_image(iconPath, chapter_ui)
      ResMgr:load_set_icon(image, self.element_cfg_list[i].ElementIconPath)
    end
    self:set_button_listener(Util.get_button("EleObj_/BtnEleDropRule_", chapter_ui), function()
      UIMgr:get_ui("element_drop_main"):ui_show(self.day_of_week)
    end)
  end
end

function ui:close_material(msg)
  local material_id = msg.mm_obj
  local chapter_ui = self.v_all_ui_go_material[material_id]
  local lock_go = Util.get_child_gameobj("Lock", chapter_ui)
  local text = Util.get_text("Lock/Text", chapter_ui).text
  lock_go:SetActive(true)
  self:set_button_listener(Util.get_button(nil, chapter_ui), function()
    Util.show_message_tip(text)
  end)
end

return ui
