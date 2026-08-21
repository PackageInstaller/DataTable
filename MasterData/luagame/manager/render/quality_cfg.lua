local GRAPHIC = {
  LOW = 1,
  MIDDLE = 2,
  HIGH = 3,
  ULTRA = 4
}
local SHADOW = {
  CLOSE = 1,
  LOW = 2,
  MIDDLE = 3,
  HIGH = 4
}
local QUALITY = {
  VERY_LOW = 0,
  LOW = 1,
  MIDDLE = 2,
  HIGH = 3,
  VERY_HIGH = 4,
  ULTRA = 5
}
local RESOLUTION = {
  LOW = 1.6,
  MIDDLE = 1.5,
  HIGH = 1.2,
  VERY_HIGH = 1
}
local RENDER_FRAME = {LOW = 1, NORMAL = 2}
local cfg = {
  [QUALITY.LOW] = {
    unity_quality = QUALITY.LOW,
    render_frame = RENDER_FRAME.LOW,
    resolution = QUALITY.LOW,
    effect_quality = GRAPHIC.LOW,
    shadow = SHADOW.CLOSE,
    fps = 30,
    postprocess = false,
    reflect = false,
    physics = false,
    HDR = false,
    anti_aliasing = false,
    distortion = true,
    rim = false,
    cam_dist = 0.5
  },
  [QUALITY.MIDDLE] = {
    unity_quality = QUALITY.MIDDLE,
    render_frame = RENDER_FRAME.NORMAL,
    resolution = QUALITY.MIDDLE,
    effect_quality = GRAPHIC.MIDDLE,
    shadow = SHADOW.LOW,
    fps = 60,
    postprocess = true,
    reflect = false,
    physics = false,
    HDR = true,
    anti_aliasing = true,
    distortion = true,
    rim = false,
    cam_dist = 0.8
  },
  [QUALITY.HIGH] = {
    unity_quality = QUALITY.HIGH,
    render_frame = RENDER_FRAME.NORMAL,
    resolution = QUALITY.HIGH,
    effect_quality = GRAPHIC.HIGH,
    shadow = SHADOW.MIDDLE,
    fps = 60,
    postprocess = true,
    reflect = false,
    physics = true,
    HDR = true,
    anti_aliasing = true,
    distortion = true,
    rim = false,
    cam_dist = 1
  },
  [QUALITY.VERY_HIGH] = {
    unity_quality = QUALITY.VERY_HIGH,
    render_frame = RENDER_FRAME.NORMAL,
    resolution = QUALITY.VERY_HIGH,
    effect_quality = GRAPHIC.ULTRA,
    shadow = SHADOW.HIGH,
    fps = 60,
    postprocess = true,
    reflect = true,
    physics = true,
    HDR = true,
    anti_aliasing = true,
    distortion = true,
    rim = true,
    cam_dist = 1.2
  },
  [QUALITY.ULTRA] = {
    unity_quality = QUALITY.VERY_HIGH,
    render_frame = RENDER_FRAME.NORMAL,
    resolution = QUALITY.VERY_HIGH,
    effect_quality = GRAPHIC.ULTRA,
    shadow = SHADOW.HIGH,
    fps = 60,
    postprocess = true,
    reflect = true,
    physics = true,
    HDR = true,
    anti_aliasing = true,
    distortion = true,
    rim = true,
    cam_dist = 1.5
  }
}
local layers = require("utils.layer").Layer
local cam_clip_dist = {
  [layers.SceneObjFarAway] = 80,
  [layers.SceneObjMiddle] = 60,
  [layers.SceneObjNear] = 40
}
return {
  CFG = cfg,
  SHADOW = SHADOW,
  QUALITY = QUALITY,
  CLIP_CFG = cam_clip_dist,
  RENDER_FRAME = RENDER_FRAME,
  RESOLUTION = RESOLUTION
}
