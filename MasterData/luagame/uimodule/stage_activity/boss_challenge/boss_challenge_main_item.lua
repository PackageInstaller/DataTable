local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(id)
  self.v_parent_ui:play_select_sound()
  local cfg = ShareRes.get_boss_fight_cfg(id)
  local is_lock = not BossChallengeMgr:get_boss_challenge_is_unlock(id)
  self:set_button_listener(self.v_uicompents.Button_btn, function()
    local is_can_fight = true
    if Game_AssetBundle and DownloadMgr and cfg and cfg.ResChapter and cfg.ResChapter > 3 then
      local is_res_integrity = CS.GameToLua.CheckUpdate.GetResIntegrity()
      if not is_res_integrity then
        is_can_fight = DownloadMgr:is_can_fight(cfg.ResChapter, true, true)
      end
    end
    if not is_can_fight then
      return
    end
    if BossChallengeMgr:get_boss_challenge_is_unlock(id) then
      UIMgr:try_show_ui("boss_challenge_point_detail", nil, id)
    end
  end)
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, cfg.IconPath, nil, true, self)
  self.v_uiobjects.Lock:SetActive(is_lock)
  self.v_uiobjects.Name:SetActive(not is_lock)
  self.v_uiobjects.UnLockCondition:SetActive(is_lock)
  if not is_lock then
    self.v_uicompents.Name_txt.text = cfg.Name
  else
    self.v_uicompents.UnLockCondition_txt.text = ShareRes.get_condition_desc(cfg.UnlockCondition)
  end
  Util.apply_grey_ex(self.v_uiobjects.Content, is_lock)
  ResMgr:load_set_icon(self.v_uicompents.Frame_img, cfg.FrameIconPath, nil, true, self)
  local FrameIconPath = cfg.FrameIconPath
  local child
  for i = 0, self.v_uicompents.Frame_rect.childCount - 1 do
    child = self.v_uicompents.Frame_rect:GetChild(i)
    child.gameObject:SetActive(string.find(FrameIconPath, child.name) ~= nil)
  end
end

return ui
