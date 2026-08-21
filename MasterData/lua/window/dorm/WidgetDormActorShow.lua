local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DormUtil")
local m_skeletonAnim, m_clickCallback

function Awake()
  WU.BindButtonEvent(REF.root, function(go)
    if m_clickCallback then
      m_clickCallback(go)
    end
  end)
end

function ResetState()
  WU.SetActive(REF.TextureBG, false)
  WU.SetActive(REF.TextureEmpty, false)
  WU.SetActive(REF.TextureExtend, false)
  WU.SetActive(REF.SpriteWelcome, false)
  REF.TextureEmpty.UITexture.alpha = 1
  WU.SetActive(REF.SpriteShadow, false)
  REF.LabelDebugActorId.UILabel.text = ""
end

function SetExtend()
  ResetState()
  WU.SetActive(REF.TextureEmpty, true)
  REF.TextureEmpty.UITexture.alpha = 0.5
  WU.SetActive(REF.TextureExtend, true)
end

function SetEmpty()
  ResetState()
  WU.SetActive(REF.TextureEmpty, true)
  WU.SetActive(REF.SpriteWelcome, true)
end

function SetActor(actorId)
  ResetState()
  WU.SetActive(REF.TextureBG, true)
  WU.SetActive(REF.SpriteShadow, true)
  local skeletonDataAsset = WU.AcquireAsset("Dependencies/Spine/leafa/lifa_SkeletonData")
  m_skeletonAnim = REF.SkeletonActor.SkeletonGenerator:SetSkeleton(skeletonDataAsset)
  m_skeletonAnim.AnimationState:SetAnimation(0, "idle", true)
  REF.LabelDebugActorId.UILabel.text = actorId
end

function SetClickCallback(calllback)
  m_clickCallback = calllback
end
