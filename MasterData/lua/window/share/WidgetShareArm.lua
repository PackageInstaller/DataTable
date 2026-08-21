local WU, DB, REF = require("Common/WindowUtil")(this)
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_arm
local m_nameScale = 0.8
local m_porSetting = PB.enum.WeaponPicSituationType.Share

function OnEnable()
  WU.ToggleRendering(REF["$gameObject"], false)
end

function SetShareInfo(arm)
  m_arm = arm
  this:DelayInvokeInFrames(1, ModifyEffect)
end

function ModifyEffect()
  if m_arm ~= nil then
    local resArmConfig = PB.get("UniqueWeaponInfo", m_arm.id)
    if resArmConfig == nil then
      error("NewArm", string.format("Id:%d does not exists in resArmConfig", actorId))
      return
    end
    WU.ModifyWeaponPortrait(REF.TextureActor, m_arm.id, m_porSetting, this.name, 0)
    WU.ModifyWeaponPortrait(REF.TextureActorADD, m_arm.id, m_porSetting, this.name, 0)
    WU.ModifyWeaponPortrait(REF.TextureActor01, m_arm.id, m_porSetting, this.name, 0)
    WU.ModifyWeaponPortrait(REF.TextureActorADD01, m_arm.id, m_porSetting, this.name, 0)
    REF.RoleName.UITexture.mainTexturePath = "Texture/ImpressionRole_name/impression_role_name_" .. resArmConfig.id .. "_0"
    REF.LabelActorType.UILabel.text = WU.GetString("WindowGacha_ActorType" .. resArmConfig.position)
    REF.LabelCharactorType.UILabel.text = WU.GetString("tag" .. resArmConfig.position .. "_kind") .. "\194\183" .. WU.GetString("Window_Arm")
    REF.RoleName.UITexture:MakePixelPerfect()
    local textureArmQualityPath
    if m_arm.quality == 3 then
      REF.RoleName.UITexture.color = CS.NGUIMath.HexToColor(3160932351)
      textureArmQualityPath = "Texture/NewArmShow/NewArmShow_ColorPurple_"
    elseif m_arm.quality == 4 then
      REF.RoleName.UITexture.color = CS.NGUIMath.HexToColor(4238616831)
      textureArmQualityPath = "Texture/NewArmShow/NewArmShow_ColorYellow_"
    end
    for i = 1, 3 do
      REF["Color" .. i].MeshRenderer.material:SetTexture("_MainTex", WU.AcquireAsset(textureArmQualityPath .. i))
    end
    WU.TraverseChildren(reRef(REF.EffectBG1).AllColor4, function(go, i)
      local ref = _ENV["$"](go).root
      if ref.MeshRenderer then
        ref.MeshRenderer.material:SetTexture("_MainTex", WU.AcquireAsset(textureArmQualityPath .. 4))
      else
        _ENV["$"](go).Color4.MeshRenderer.material:SetTexture("_MainTex", WU.AcquireAsset(textureArmQualityPath .. 4))
      end
    end)
    WU.ToggleRendering(REF["$gameObject"], true)
    if resArmConfig.position == PB.enum.ActorType.Sub then
      REF.NewArmGet.Animator:Play("DelayOpen_01", -1, 0)
    elseif resArmConfig.position == PB.enum.ActorType.Main then
      REF.NewArmGet.Animator:Play("DelayOpen", -1, 0)
    end
    REF.NodeShare.gameObject:SetActive(false)
    REF.EffectQG.gameObject:SetActive(false)
  end
end
