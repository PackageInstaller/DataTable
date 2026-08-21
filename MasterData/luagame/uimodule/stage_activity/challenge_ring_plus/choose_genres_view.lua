local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SECT_TEM_KEY = "SECT_TEM_KEY"
local STAGE_SKILL_LV_UP_TEM = "STAGE_SKILL_LV_UP_TEM"
local VIEW_TYPE = {SELECT_VIEW = 1, DETAIL_VIEW = 2}

function ui:on_click_StageSkillDesc()
  if self.v_key_id_list then
    UIMgr:try_show_ui("keyword_tips_v2", nil, self.v_key_id_list)
  end
end

function ui:switch_select_genres(is_next)
  local select_index = is_next and self.v_select_index + 1 or self.v_select_index - 1
  if self.v_genres_cfg_list[select_index] then
    self.v_uicompents.SwitchOut_pd:ResetPD()
    self.v_uicompents.SwitchIn_pd:ResetPD()
    self.v_select_index = select_index
    self.v_uicompents.SwitchOut_pd:Play()
    self.v_switching = true
  end
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    if self.v_cur_view_type == VIEW_TYPE.SELECT_VIEW then
      self:ui_hide()
    elseif self.v_cur_view_type == VIEW_TYPE.DETAIL_VIEW then
      self:set_cur_show_view(VIEW_TYPE.SELECT_VIEW)
    end
  end)
  self:set_button("BtnStar", function()
    if self.v_select_genres then
      UIMgr:get_ui("team"):ui_show(self.v_select_genres, self.v_episode_id, Config.CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE)
    end
  end)
  self:set_button("StageSkillDesc", function()
    self:on_click_StageSkillDesc()
  end)
  
  function self.v_played_cb(pd)
    self.v_uicompents.SwitchIn_pd:Play()
    self:open_genres_detail(self.v_genres_cfg_list[self.v_select_index])
  end
  
  self.v_layout = self.v_uiobjects.SectLayout:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
  self:register_exist_auto_template(SECT_TEM_KEY, self.v_uiobjects.SectTem, self.v_uiobjects.SectLayout)
  self:register_exist_auto_template(STAGE_SKILL_LV_UP_TEM, self.v_uiobjects.StageSkillLvUpTem, self.v_uiobjects.StageSkillLvUpContent)
end

function ui:ui_on_show(episode_id)
  self.v_uicompents.SwitchOut_pd:stopped("+", self.v_played_cb)
  self.v_episode_id = episode_id
  self:set_cur_show_view(VIEW_TYPE.SELECT_VIEW)
end

function ui:ui_on_hide()
  self.v_switching = nil
  self.v_uicompents.SwitchOut_pd:played("-", self.v_played_cb)
  if self.v_tween then
    self.v_tween:Kill(false)
    self.v_tween = nil
  end
  self.v_select_genres = nil
  self.v_select_genres_cfg = nil
  self.v_genres_cfg_list = nil
  self.v_select_index = nil
  self.v_key_id_list = nil
end

function ui:ui_on_destroy()
end

function ui:set_cur_show_view(view_type)
  if view_type == VIEW_TYPE.SELECT_VIEW then
    self.v_uiobjects.SectSelectObj:SetActive(true)
    self.v_uiobjects.SectDetailObj:SetActive(false)
    self:refresh_genres_select_list()
  elseif view_type == VIEW_TYPE.DETAIL_VIEW then
    self.v_uiobjects.SectSelectObj:SetActive(false)
    self.v_uiobjects.SectDetailObj:SetActive(true)
    self:referesh_genres_detail()
  end
  self.v_cur_view_type = view_type
end

function ui:refresh_genres_select_list()
  self.v_layout.enabled = true
  self.v_uiobjects.AnimaSect:SetActive(false)
  self.v_select_genres_cfg = nil
  self:give_back_auto_cache(SECT_TEM_KEY)
  local genres_cfgs = ShareRes.get_all_genres_cfg()
  self.v_genres_cfg_list = {}
  for key, genres_cfg in pairs(genres_cfgs) do
    table.insert(self.v_genres_cfg_list, genres_cfg)
  end
  table.sort(self.v_genres_cfg_list, function(a, b)
    if a.Id ~= b.Id then
      return a.Id < b.Id
    end
    return false
  end)
  for index, genres_cfg in ipairs(self.v_genres_cfg_list) do
    local obj = self:get_auto_cache(SECT_TEM_KEY)
    self:set_genres_info(obj, genres_cfg, index)
  end
end

function ui:set_genres_info(obj, genres_cfg, index)
  obj:SetActive(true)
  genres_cfg = self.v_select_genres_cfg or genres_cfg
  local btn = self:get_button(nil, obj)
  if btn then
    self:set_button_listener(btn, function()
      local anima_obj = self.v_uiobjects.AnimaSect
      self:set_genres_info(anima_obj, genres_cfg)
      self.v_layout.enabled = false
      self.v_uicompents.SelectObjOutPd_pd:Stop()
      self.v_uicompents.SelectObjOutPd_pd:Play()
      anima_obj.transform.position = obj.transform.position
      obj:SetActive(false)
      self.v_tween = anima_obj.transform:DOMove(self.v_uiobjects.Sect.transform.position, self.v_uicompents.SelectObjOutPd_pd.duration)
      self.v_tween:SetEase(CS.DG.Tweening.Ease.InOutSine)
      self.v_select_index = index
      self.v_tween:OnComplete(function()
        self:open_genres_detail(genres_cfg)
        anima_obj:SetActive(false)
        self.v_tween:Kill(false)
        self.v_tween = nil
      end)
    end)
  end
  local sect_icon = self:get_image("SectIcon", obj)
  ResMgr:load_set_icon(sect_icon, genres_cfg.IconPath, nil, true, self)
  local sect_name = self:get_text("SectName", obj)
  sect_name.text = genres_cfg.Name
  local sect_desc = self:get_text("SectDesc", obj)
  sect_desc.text = genres_cfg.Desc
end

function ui:referesh_genres_detail()
  self:set_genres_info(self.v_uiobjects.Sect)
  self:set_skill_info(self.v_select_genres_cfg.Skill)
  self:refresh_change_select_btn()
end

function ui:set_skill_info(skill_id)
  self:give_back_auto_cache(STAGE_SKILL_LV_UP_TEM)
  local skill_cfg = ShareRes.get_scene_skill_cfg(skill_id)
  local skill_level_cfg = ShareRes.get_scene_skill_level_cfg(skill_id)
  local desc_cfg = ShareRes.create("activity.sect_client_desc")
  ResMgr:load_set_icon(self.v_uicompents.StageSkill_Icon_img, skill_level_cfg[1].IconPath)
  self.v_uicompents.StageSkillName_txt.text = skill_level_cfg[1].Name
  self.v_uicompents.StageSkillDesc_txt.text = skill_level_cfg[1].Desc
  self.v_uicompents.Desc1_txt.text = Util.format_str(desc_cfg[1].Desc, skill_cfg.Name, self.v_select_genres_cfg.Name)
  self.v_uicompents.Desc2_txt.text = Util.format_str(desc_cfg[2].Desc, self.v_select_genres_cfg.Name)
  self.v_key_id_list = {}
  if skill_level_cfg[1].KeyIDList then
    for _, id in ipairs(skill_level_cfg[1].KeyIDList) do
      self.v_key_id_list[#self.v_key_id_list + 1] = id
    end
  end
  if #skill_level_cfg > 1 then
    for index = 2, #skill_level_cfg do
      local obj = self:get_auto_cache(STAGE_SKILL_LV_UP_TEM)
      local text = self:get_text(nil, obj)
      text.text = skill_level_cfg[index].Name .. "：" .. skill_level_cfg[index].Desc
      if skill_level_cfg[index].KeyIDList then
        for _, id in ipairs(skill_level_cfg[1].KeyIDList) do
          self.v_key_id_list[#self.v_key_id_list + 1] = id
        end
      end
    end
  end
end

function ui:open_genres_detail(genres_cfg)
  self.v_select_genres = genres_cfg.Id
  self.v_select_genres_cfg = genres_cfg
  self:set_cur_show_view(VIEW_TYPE.DETAIL_VIEW)
end

function ui:refresh_change_select_btn()
  self.v_uiobjects.BtnLast:SetActive(self.v_genres_cfg_list[self.v_select_index - 1] ~= nil)
  self:set_button_listener(self.v_uicompents.BtnLast_btn, function()
    self:switch_select_genres(false)
  end)
  self.v_uiobjects.BtnNext:SetActive(self.v_genres_cfg_list[self.v_select_index + 1] ~= nil)
  self:set_button_listener(self.v_uicompents.BtnNext_btn, function()
    self:switch_select_genres(true)
  end)
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_episode_id
end

return ui
