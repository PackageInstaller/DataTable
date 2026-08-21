local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:set_data(endless_data)
  self:refresh_endless_items(endless_data)
end

function ui:refresh_endless_items(endless_data)
  self.v_object:SetActive(true)
  local chapter_id = endless_data.id
  if -1 == chapter_id then
    self.v_uiobjects.NoScore:SetActive(true)
    self.v_uiobjects.Score:SetActive(false)
    self.v_uicompents.StageName_txt.text = "ÔÝÎ´½âËø"
    self.v_uiobjects.Bg:SetActive(false)
  else
    self.v_chapter_id = chapter_id
    self.v_infinite_cfg = ShareRes.get_inf_chapter_cfg(chapter_id)
    local score = endless_data.score
    local StageName = self.v_infinite_cfg.Name
    self.v_uiobjects.Score:SetActive(score and 0 ~= score)
    self.v_uiobjects.NoScore:SetActive(0 == score or nil)
    if 0 ~= score then
      self.v_uicompents.Score_txt.text = score
    end
    self.v_uicompents.StageName_txt.text = StageName
  end
end

function ui:clear_static_view()
  if self.v_static_sv then
    self.v_static_sv:clear()
    self.v_static_sv = nil
  end
end

function ui:on_clear()
  self:clear_static_view()
end

return ui
