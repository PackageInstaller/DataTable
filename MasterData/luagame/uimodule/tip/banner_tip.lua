local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Timer = Global.timer
local MODEL = {}

function ui:ui_finish_load()
  self:init_model(MODEL)
end

function ui:ui_on_show(tip_text)
  if self.v_Sequence then
    self.v_Sequence:Kill(false)
    self.v_Sequence = nil
  end
  self.v_uicompents.NoticeText_txt.text = tip_text
  local canvas_group = self.v_object:GetComponent("CanvasGroup")
  canvas_group.alpha = 0
  self.v_Sequence = Util.create_sequence()
  self.v_Sequence:SetUpdate(true)
  self.v_Sequence:Append(canvas_group:DOFade(1, 0.5))
  self.v_Sequence:Append(canvas_group:DOFade(0, 0.5):SetDelay(0.5))
  self.v_Sequence:AppendCallback(function(...)
    self:ui_hide()
  end)
end

function ui:ui_on_hide(...)
  if self.v_Sequence then
    self.v_Sequence:Kill(false)
    self.v_Sequence = nil
  end
end

return ui
