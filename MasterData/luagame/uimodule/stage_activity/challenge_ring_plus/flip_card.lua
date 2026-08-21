local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CARD_AWARD_KEY = "FLIP_CARD_AWARD_KEY"
local Item_Helper = require("utils.item_helper")
local ITEM_ICON_PATH = "Icon/Item/"
local bagConfig = require("gamelogic.character.fight_bag_configs")
local ITEM_OBJ_COM = require("uimodule.item.item_obj_com")
local type_playable_director = typeof(UnityEngine.Playables.PlayableDirector)
local type_canvas_group = typeof(UnityEngine.CanvasGroup)
local type_ui_particle = typeof(CS.UIParticleExtensions.UIParticle)
local TypeEffectStatus = _ENV.TypeEffectStatus

function ui:ui_finish_load()
  self.v_item_list = {}
  self.v_particles = {}
  self:set_button("CloseBtn", function()
    if self.v_in_flip_start_anima then
      self:skip_flip_anima()
    else
      self:ui_hide()
    end
  end)
  self:register_exist_auto_template(CARD_AWARD_KEY, self.v_uiobjects.ItemObjCom1, self.v_uiobjects.AwardContent)
  self.v_timer_dict = {}
  self.v_timers = {}
  self.v_award_bg = self.v_uiobjects.AwardBg:GetComponent(type_canvas_group)
  self.v_award = self.v_uiobjects.Award:GetComponent(type_canvas_group)
  self.v_award_content = self.v_uiobjects.AwardContent:GetComponent(type_canvas_group)
  for index = 1, 7 do
    self.v_particles[index] = self.v_uiobjects["Particle" .. index]:GetComponent(type_ui_particle)
  end
  self:get_pd()
end

function ui:get_pd()
  self.v_card_in_box_pd = self.v_uiobjects.CardInBox:GetComponent(type_playable_director)
  self.v_award_show_pd = self.v_uiobjects.AwardShow:GetComponent(type_playable_director)
  self.v_award_hide_pd = self.v_uiobjects.AwardHide:GetComponent(type_playable_director)
  self.v_flip_pds = {}
  for index = 1, 5 do
    self.v_flip_pds[index] = self.v_uiobjects["FlipCard" .. index]:GetComponent(type_playable_director)
  end
end

function ui:ui_on_show(data, reward_list, award_tf)
  self.v_uiobjects.GetParticle:SetActive(false)
  self.v_award_tf = award_tf
  self.v_uiobjects.Card:SetActive(true)
  self.v_in_flip_done_anima = false
  self.v_in_flip_start_anima = false
  self:set_no_click(false)
  self.v_uiobjects.Award:SetActive(false)
  self.v_card_cfg = data.item_cfg
  self.v_card_quality = self.v_card_cfg.Quality
  self.v_reward_list = reward_list
  ResMgr:load_set_icon(self.v_uicompents.Card_img, data.img_name, nil, true)
  self:show_award()
end

function ui:ui_on_hide()
  for key, particle in pairs(self.v_particles) do
    particle.gameObject:SetActive(false)
  end
  if self.v_particle_sequence then
    self.v_particle_sequence:Kill(false)
    self.v_particle_sequence = nil
  end
  for key, item in pairs(self.v_item_list) do
    item:ui_hide()
    self:remove_wrap_ui(item)
  end
  self.v_award_tf = nil
  self.v_item_list = {}
  self.v_uiobjects.Award:SetActive(false)
  self:stop_all_pd()
  self:remove_all_timer()
end

function ui:show_award()
  if not self.v_reward_list then
    return
  end
  self:give_back_auto_cache(CARD_AWARD_KEY)
  self.v_item_coms = {}
  for index, data in ipairs(self.v_reward_list) do
    self.v_item_coms[index] = {}
    local item = self:get_auto_cache(CARD_AWARD_KEY)
    self.v_item_coms[index].go = item
    local in_go = Util.get_child("AwardIn_", item)
    self.v_item_coms[index].award_in = in_go:GetComponent(type_playable_director)
    local out_go = Util.get_child("AwardOut_", item)
    self.v_item_coms[index].award_out = out_go:GetComponent(type_ui_particle)
    local award_data = {
      id = data.id,
      count = data.count,
      cb = function()
        UIMgr:get_ui("itemTip"):ui_show({
          item_id = data.id,
          is_hide_get_way = true
        })
      end
    }
    self.v_item_list[index] = ITEM_OBJ_COM:ui_wrap(self, item)
    self.v_item_list[index]:set_data(award_data)
  end
  BagMgr.flip_card_award_list = nil
  self:on_flip_start()
end

function ui:on_flip_start()
  self.v_in_flip_start_anima = true
  local pd = self.v_flip_pds[self.v_card_quality]
  
  local function start_done_cb()
    self:stop_flip_start_pd()
    self.v_in_flip_start_anima = false
    self:on_flip_done()
  end
  
  local function play_award_in_pd_cb()
    self:play_award_in_pd()
    self:add_timer("start_done_cb", 1, start_done_cb)
  end
  
  local function show_cb()
    self.v_award_show_pd:Play()
    self.v_uiobjects.Award:SetActive(true)
    self:add_timer("play_award_in_pd_cb", 1, play_award_in_pd_cb)
  end
  
  pd:Play()
  self.v_award_bg.alpha = 1
  self.v_award.alpha = 1
  self:add_timer("show_cb", 0.5, show_cb)
end

function ui:on_flip_done()
  self.v_in_flip_done_anima = true
  
  local function done_cb()
    if self:visible() then
      self:ui_hide()
      self:stop_flip_done_pd()
      self.v_in_flip_done_anima = false
    end
  end
  
  local function award_hide_pd_cb()
    if self:visible() then
      self.v_award_hide_pd:Play()
    end
  end
  
  local duration = self.v_award_hide_pd.duration
  self:play_award_out_pd()
  local target_tf = self.v_award_tf
  if not target_tf or target_tf:IsNull() then
    self.v_award_hide_pd:Play()
    self:add_timer("done_cb", duration + 0.15, done_cb)
  else
    self:particle_move(done_cb, target_tf)
  end
  self:add_timer("award_hide_pd_cb", 0.5, award_hide_pd_cb)
end

function ui:particle_move(cb, target_tf)
  local function dotween_cb()
    self.v_uiobjects.GetParticle:SetActive(false)
    
    cb()
  end
  
  if self.v_particle_sequence then
    self.v_particle_sequence:Kill(false)
    self.v_particle_sequence = nil
  end
  self.v_particle_sequence = Util.create_sequence()
  for index, com in ipairs(self.v_item_coms) do
    local start_go = com.go
    local particle = self.v_particles[index]
    local particle_go = particle.gameObject
    local particle_tf = particle_go.transform
    particle_tf.position = start_go.transform.position
    if particle_go.activeInHierarchy then
      particle_go:SetActive(false)
    end
    particle_go:SetActive(true)
    particle:RePlay()
    self.v_particle_sequence:Join(particle_tf:DOMove(target_tf.position, 1))
  end
  self.v_particle_sequence:OnComplete(function()
    for index, particle in ipairs(self.v_particles) do
      particle.gameObject:SetActive(false)
    end
    if self.v_uiobjects.GetParticle.activeInHierarchy then
      self.v_uiobjects.GetParticle:SetActive(false)
    end
    self.v_uiobjects.GetParticle:SetActive(true)
    self:add_timer("dotween_cb", 0.5, dotween_cb)
  end)
end

function ui:play_award_in_pd()
  for key, pds in pairs(self.v_item_coms) do
    if pds.award_in then
      pds.award_in:Play()
    end
  end
end

function ui:play_award_out_pd(is_skip)
  for key, pds in pairs(self.v_item_coms) do
    if pds.award_out then
      pds.award_out.gameObject:SetActive(false)
      if not is_skip then
        pds.award_out.gameObject:SetActive(true)
        pds.award_out:RePlay()
      end
    end
  end
end

function ui:add_timer(key, duration, cb)
  self:remove_timer(key)
  self.v_timer_dict[key] = Timer:add_timer("flip_card", duration, cb)
  table.insert(self.v_timers, self.v_timer_dict[key])
end

function ui:remove_timer(key)
  if self.v_timer_dict[key] then
    Timer:remove_timer(self.v_timer_dict[key])
    self.v_timer_dict[key] = nil
  end
end

function ui:remove_all_timer()
  for key, timer in pairs(self.v_timers) do
    Timer:remove_timer(timer)
  end
  self.v_timers = {}
end

function ui:stop_all_pd()
  self.v_card_in_box_pd:Stop()
  self.v_award_show_pd:Stop()
  self.v_award_hide_pd:Stop()
  for key, pd in pairs(self.v_flip_pds) do
    pd:Stop()
  end
end

function ui:stop_flip_start_pd()
  self.v_award_show_pd:Stop()
  for key, pd in pairs(self.v_flip_pds) do
    pd:Stop()
  end
end

function ui:stop_flip_done_pd()
  self.v_card_in_box_pd:Stop()
  self.v_award_hide_pd:Stop()
end

function ui:set_no_click(is_can_click)
  self.v_uiobjects.NoClick:SetActive(is_can_click)
end

function ui:skip_flip_anima()
  self:stop_all_pd()
  self:remove_all_timer()
  self.v_uiobjects.Card:SetActive(false)
  self.v_uiobjects.Award:SetActive(true)
  self:set_color_alpha(self.v_uicompents.AwardBg_img, 1)
  self:set_color_alpha(self.v_uicompents.VX_BG_img, 0)
  self.v_award_content.alpha = 1
  self.v_award_bg.alpha = 1
  self.v_award.alpha = 1
  self.v_in_flip_start_anima = false
  
  local function skip_start_cb()
    self:on_flip_done()
  end
  
  for key, pds in pairs(self.v_item_coms) do
    if pds.award_out then
      pds.award_out.gameObject:SetActive(false)
    end
  end
  self:add_timer("skip_start_cb", 1.5, skip_start_cb)
end

function ui:set_color_alpha(img, a)
  local color = img.color
  img:SetGraphicColor(color.r, color.g, color.b, a)
end

return ui
