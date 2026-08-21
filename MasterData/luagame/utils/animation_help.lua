local UnityTransform = _ENV.UnityTransform
local UnityClip = UnityEngine.AnimationClip
local UnityKeyframe = UnityEngine.Keyframe
local UnityCurve = UnityEngine.AnimationCurve
local UnityWrapMode = UnityEngine.WrapMode
local UnityCamera = UnityEngine.Camera
local M = {}
local PropertyType = {
  ["m_LocalPosition.x"] = UnityTransform,
  ["m_LocalPosition.y"] = UnityTransform,
  ["m_LocalPosition.z"] = UnityTransform,
  ["m_LocalRotation.x"] = UnityTransform,
  ["m_LocalRotation.y"] = UnityTransform,
  ["m_LocalRotation.z"] = UnityTransform,
  ["m_LocalRotation.w"] = UnityTransform,
  ["m_LocalScale.x"] = UnityTransform,
  ["m_LocalScale.y"] = UnityTransform,
  ["field of view"] = UnityCamera
}

function M.create_curve(keys)
  local curve = UnityCurve()
  for _, key in ipairs(keys) do
    local keyframe = UnityKeyframe(key.time, key.value, key.inTangent, key.outTangent)
    curve:AddKey(keyframe)
  end
  return curve
end

function M.create_trans_clip(curves)
  local clip = UnityClip()
  clip.wrapMode = UnityWrapMode.ClampForever
  clip.legacy = true
  for property, cfg in pairs(curves) do
    local curve = M.create_curve(cfg.keys)
    curve.preWrapMode = cfg.preWrapMode or UnityWrapMode.ClampForever
    curve.postWrapMode = cfg.postWrapMode or UnityWrapMode.ClampForever
    clip:SetCurve("", PropertyType[property], property, curve)
  end
  return clip
end

return M
