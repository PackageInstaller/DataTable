local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("common/HtmlUtil")
local DBH = require("Manager/DataBindingHandler")
local ACU = require("Common/ActivityUtil")
local m_newArms, m_arm, m_actorEffectInstance, m_bgEffectInstance, m_textureArmQuality, m_audioSource, m_qualityAudioSource, m_callback
local ArmQualityColors = {
  614232319,
  8380927,
  2689062655,
  4289200383
}
local SubEffectColors = {
  1473614335,
  801110271,
  3497128447,
  4290783487
}
local ActorQualityTexture = {
  "G",
  "B",
  "P",
  "Y"
}
local m_isMain
local m_shareOn = false
local m_haveReward = false
local id_ActivityshareWeekly = 24001
local id_ActivityshareGoldSkin = 24002
local m_openShareWeekly = false
local m_openShareGoldSkin = false
local m_haveGotShareResult = false
local m_canClickToContinue = false
local m_canClickToContinueCoro
local m_porSetting = PB.enum.WeaponPicSituationType.Share

function SetupWindow()
  WU.BindButtonEvent(REF.Black, NextNewActor)
  WU.BindButtonEvent(_ENV["$"](REF.NodeShare).ButtonShare, function()
    OnShareClick()
  end)
end

function OnShareClick()
  WU.RecordButtonClick(901)
  this:SetData("ShareConfig", {
    shareName = "NewArmGet",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  this:SetData("Share/NewArmGet", m_arm)
  WU.AcquireWindowAsync("Share")
end

function UninitWindow()
  if m_audioSource then
    m_audioSource:Stop()
    m_audioSource = nil
  end
  if m_qualityAudioSource then
    m_qualityAudioSource:Stop()
    m_qualityAudioSource = nil
  end
  m_arm = nil
  m_isMain = nil
  m_canClickToContinue = false
end

function InitWindow()
  WU.SetLockFlag(WU.LockInputFlag.UITransition, true)
  WU.ToggleRendering(REF["$gameObject"], false)
  m_haveGotShareResult = false
end

function NewArmGet(arms, callback)
  if #arms == 0 then
    m_newArms = {arms}
  else
    m_newArms = arms
  end
  m_callback = callback
  OnCurrentArmidChanged(m_newArms[1].id)
end

function NextNewActor()
  if m_canClickToContinue then
    if m_newArms ~= nil and 0 < #m_newArms then
      OnCurrentArmidChanged(m_newArms[1].id)
    else
      WU.RecycleWindow(this)
      DB:DelayInvokeInFrames(1, function()
        if m_callback then
          m_callback()
          m_callback = nil
        end
      end)
    end
  end
end

function OnCurrentArmidChanged(id)
  if id ~= nil and 0 < id then
    this:Bind("fci/arms/" .. id, OnArmChange)
  end
end

function OnArmChange(arm)
  if arm and (not m_arm or m_arm.id ~= arm.id) then
    m_arm = arm
    m_canClickToContinue = true
    WU.ToggleRendering(REF.Continue_Label, true)
    if m_canClickToContinueCoro ~= nil then
      this:StopCoroutine(m_canClickToContinueCoro)
      m_canClickToContinueCoro = nil
    end
    if m_arm.quality >= 4 then
      m_canClickToContinue = false
      WU.ToggleRendering(REF.Continue_Label, false)
      m_canClickToContinueCoro = this:DelayInvokeInSeconds(3, function()
        m_canClickToContinueCoro = nil
        m_canClickToContinue = true
        WU.ToggleRendering(REF.Continue_Label, true)
      end)
    end
    local resArmConfig = PB.get("UniqueWeaponInfo", m_arm.id)
    if resArmConfig == nil then
      error("NewArm", string.format("Id:%d does not exists in resArmConfig", actorId))
      return
    end
    if m_arm.quality >= 1 and m_arm.quality <= 4 then
      m_qualityAudioSource = CS.SoundManager.Instance:PlaySound("Sound/system/s_System_RewardCard" .. tostring(m_arm.quality), 1.0)
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
      reRef(REF.EffectBG1)["Color" .. i].MeshRenderer.material:SetTexture("_MainTex", WU.AcquireAsset(textureArmQualityPath .. i))
    end
    WU.TraverseChildren(reRef(REF.EffectBG1).AllColor4, function(go, i)
      local ref = _ENV["$"](go).root
      if ref.MeshRenderer then
        ref.MeshRenderer.material:SetTexture("_MainTex", WU.AcquireAsset(textureArmQualityPath .. 4))
      else
        _ENV["$"](go).Color4.MeshRenderer.material:SetTexture("_MainTex", WU.AcquireAsset(textureArmQualityPath .. 4))
      end
    end)
    local scale = REF["$transform"].localScale.x
    if resArmConfig.position == PB.enum.ActorType.Sub then
      REF.root.Animator:Play("DelayOpen_01", -1, 0)
    elseif resArmConfig.position == PB.enum.ActorType.Main then
      REF.root.Animator:Play("DelayOpen", -1, 0)
    end
    WU.ToggleRendering(REF["$gameObject"], true)
    this:DelayInvokeInSeconds(REF["$Animator"]:GetCurrentAnimatorStateInfo(0).length, function()
      WU.SetLockFlag(WU.LockInputFlag.UITransition, false)
    end)
    if m_arm.quality == 4 then
      CS.GameUtility.Vibrate()
    end
    if m_newArms ~= nil and 0 < #m_newArms then
      table.remove(m_newArms, 1)
    end
  end
end
