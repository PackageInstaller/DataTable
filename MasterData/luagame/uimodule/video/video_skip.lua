local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Timer = Global.timer
local MODEL = {
  v_btn_bg = {
    "BtnBg",
    BIND_TYPE.BUTTON
  },
  v_btn_skip = {
    "BtnSkip",
    BIND_TYPE.BUTTON
  }
}
local skip_visible = false

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.video_image = self.v_uicompents.VideoImage_img
  self.usm_mask = self.v_uiobjects.UsmMask
  self.canvas_group = self.video_image:GetComponent("CanvasGroup")
  self.usm_mask_canvas_group = self.usm_mask:GetComponent("CanvasGroup")
  self.v_aspect_ratio_fitter = self.video_image:GetComponent(typeof(UnityEngineUI.AspectRatioFitter))
  self.v_init_aspect_ratio = self.v_aspect_ratio_fitter.aspectRatio
  self:set_button("BtnSkip", function()
    self:click_skip_btn()
  end)
  self:set_button("BtnBg", function()
    if not self.v_is_can_skip then
      return
    end
    if self.canvas_group.alpha < 1 then
      return
    end
    skip_visible = not skip_visible
    self.v_btn_skip.gameObject:SetActive(skip_visible)
  end)
end

function ui:click_skip_btn()
  VideoMgr:stop()
  self:ui_hide()
end

function ui:ui_on_show(callback, is_can_skip, aspect_ratio)
  self.v_btn_skip.gameObject:SetActive(false)
  self.v_is_can_skip = is_can_skip
  self.canvas_group.alpha = 1
  if aspect_ratio then
    self.v_aspect_ratio_fitter.aspectRatio = aspect_ratio
  end
  if callback then
    self.usm_mask:SetActive(true)
    callback(self.video_image, self.canvas_group, self.usm_mask_canvas_group)
  end
  self:register_event()
  self.v_uicompents.Subtitles_txt.text = ""
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_CRI_VIDEO_SUBTITLE_UPDATE, self.on_subtitle_refresh, self)
end

function ui:on_subtitle_refresh(msg)
  self.v_uicompents.Subtitles_txt.text = msg.mm_x
end

function ui:ui_on_hide()
  self.v_aspect_ratio_fitter.aspectRatio = self.v_init_aspect_ratio
  self.v_btn_skip.gameObject:SetActive(true)
  self.usm_mask:SetActive(false)
  self.video_image.gameObject:SetActive(false)
end

return ui
