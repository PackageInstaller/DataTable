local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("common/HtmlUtil")
local DBH = require("Manager/DataBindingHandler")
local ACU = require("Common/ActivityUtil")
local m_newActors, m_actor, m_actorEffectInstance, m_bgEffectInstance, m_texturePortrait, m_textureActorQuality, m_textureActorQuality2, m_audioSource, m_qualityAudioSource, m_callback
local ActorQualityColors = {
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

function SetupWindow()
  WU.BindButtonEvent(REF.Black, NextNewActor)
  WU.BindButtonEvent(_ENV["$"](REF.MainShare).ButtonShare, function()
    OnShareClick(_ENV["$"](REF.MainShare))
  end)
  WU.BindButtonEvent(_ENV["$"](REF.SubShare).ButtonShare, function()
    OnShareClick(_ENV["$"](REF.SubShare))
  end)
end

function OnShareClick(ref)
  WU.RecordButtonClick(901)
  this:SetData("ShareConfig", {
    shareName = "NewActorGet",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  ref.ButtonShare.gameObject:SetActive(false)
  ref.EffectButton.gameObject:SetActive(false)
  ref.AwardLabel.gameObject:SetActive(false)
  ref.AwardDialog.gameObject:SetActive(false)
  REF.Continue_Label.gameObject:SetActive(false)
  WU.AcquireWindowAsync("Share", function(ui)
    if m_actor then
      _ENV["$"](ui)["$$SetShareActorId"](m_actor.id)
    end
  end)
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
  m_actor = nil
  m_isMain = nil
  m_canClickToContinue = false
end

function OnDestroy()
  ReleaseAllAssets()
  DestoryEffect()
end

function InitWindow()
  WU.SetLockFlag(WU.LockInputFlag.UITransition, true)
  WU.ToggleRendering(REF["$gameObject"], false)
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  this:RegisterGameEvent("ShareSuccess", OnShareSuccess)
  m_shareOn = WU.IsShareSwitchOn()
  if m_shareOn then
    local activityLists = this:GetData("ActivityList")
    local _, activityWeekly = table.find(activityLists, function(k, v)
      return v.activityId == id_ActivityshareWeekly
    end)
    local _, activityGoldSkin = table.find(activityLists, function(k, v)
      return v.activityId == id_ActivityshareGoldSkin
    end)
    m_openShareWeekly = ACU.GetStatus(activityWeekly) == PB.enum.ActivityStatus.Started
    m_openShareGoldSkin = ACU.GetStatus(activityGoldSkin) == PB.enum.ActivityStatus.Started
  end
  REF.MainShare.gameObject:SetActive(false)
  REF.SubShare.gameObject:SetActive(false)
  m_haveGotShareResult = false
end

function OnWindowUninited(window)
  if window.name == "Share" and m_isMain ~= nil and not m_haveGotShareResult then
    local ref = fif(m_isMain, _ENV["$"](REF.MainShare), _ENV["$"](REF.SubShare))
    ref.ButtonShare.gameObject:SetActive(true)
    ref.EffectButton.gameObject:SetActive(true)
    if m_haveReward then
      ref.AwardLabel.gameObject:SetActive(true)
      ref.AwardDialog.gameObject:SetActive(true)
    end
    REF.Continue_Label.gameObject:SetActive(true)
  end
end

function NewActorGet(actors, callback)
  if #actors == 0 then
    m_newActors = {actors}
  else
    m_newActors = actors
  end
  m_callback = callback
  OnCurrentActorUidChanged(m_newActors[1].uid)
end

function NextNewActor()
  if m_canClickToContinue then
    if m_newActors ~= nil and 0 < #m_newActors then
      OnCurrentActorUidChanged(m_newActors[1].uid)
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

function OnCurrentActorUidChanged(uid)
  if uid ~= nil and 0 < uid then
    this:Bind("fci/actor/" .. uid, OnActorChange)
  end
end

function OnActorChange(actor)
  if actor and (not m_actor or m_actor.uid ~= actor.uid) then
    m_actor = actor
    m_canClickToContinue = true
    WU.ToggleRendering(REF.Continue_Label, true)
    if m_canClickToContinueCoro ~= nil then
      this:StopCoroutine(m_canClickToContinueCoro)
      m_canClickToContinueCoro = nil
    end
    if m_actor.quality >= 4 then
      m_canClickToContinue = false
      WU.ToggleRendering(REF.Continue_Label, false)
      m_canClickToContinueCoro = this:DelayInvokeInSeconds(3, function()
        m_canClickToContinueCoro = nil
        m_canClickToContinue = true
        WU.ToggleRendering(REF.Continue_Label, true)
      end)
    end
    local resActorConfig = PB.get("ActorConfig", m_actor.id)
    if resActorConfig == nil then
      error("NewActor", string.format("Id:%d does not exists in ResActorConfig", m_actor.id))
      return
    end
    m_isMain = resActorConfig.kind == PB.enum.ActorType.Main
    if m_actor.quality >= 1 and m_actor.quality <= 4 then
      m_qualityAudioSource = CS.SoundManager.Instance:PlaySound("Sound/system/s_System_RewardCard" .. tostring(m_actor.quality), 1.0)
    end
    if #resActorConfig.chooseAudio > 0 then
      local delayTime = 0.01
      if m_qualityAudioSource then
        delayTime = m_qualityAudioSource.clip.length
      end
      this:DelayInvokeInSeconds(delayTime, function()
        m_audioSource = CS.SoundManager.Instance:PlaySound("Voice/" .. resActorConfig.chooseAudio[1], 1.0)
      end)
    end
    local actormainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. resActorConfig.animRes
    REF.TextureShadow.UITexture.mainTexturePath = actormainTexturePath
    REF.TextureActor.UITexture.mainTexturePath = actormainTexturePath
    REF.TextureActorADD.UITexture.mainTexturePath = actormainTexturePath
    REF.TextureActor01.UITexture.mainTexturePath = actormainTexturePath
    REF.TextureActorADD01.UITexture.mainTexturePath = actormainTexturePath
    REF.TextureShadow.transform.localPosition = CS.UnityEngine.Vector3(resActorConfig.portraitOffsetX, resActorConfig.portraitOffsetY, 0)
    REF.TextureActor.transform.localPosition = CS.UnityEngine.Vector3(resActorConfig.portraitOffsetX, resActorConfig.portraitOffsetY, 0)
    REF.TextureActorADD.transform.localPosition = CS.UnityEngine.Vector3(resActorConfig.portraitOffsetX, resActorConfig.portraitOffsetY, 0)
    REF.TextureActor01.transform.localPosition = CS.UnityEngine.Vector3(resActorConfig.portraitOffsetX, resActorConfig.portraitOffsetY, 0)
    REF.TextureActorADD01.transform.localPosition = CS.UnityEngine.Vector3(resActorConfig.portraitOffsetX, resActorConfig.portraitOffsetY, 0)
    REF.TextureLogo.UITexture.mainTexturePath = "Texture/ActorLogo/actor_logo_" .. resActorConfig.animRes
    REF.TextureLogoADD.UITexture.mainTexturePath = "Texture/ActorLogo/actor_logo_" .. resActorConfig.animRes
    REF.ColorLine.UISprite.color = CS.NGUIMath.HexToColor(ActorQualityColors[m_actor.quality])
    REF.LabelCV.UILabel.text = WU.GetString("ActorCV_" .. m_actor.id)
    REF.SpriteActorType.UISprite.spriteName = "actor_type_" .. m_actor.id
    REF.SpriteActorName.UISprite.spriteName = "actor_name_" .. resActorConfig.animRes
    REF.LabelActorType.UILabel.text = WU.GetString("WindowGacha_ActorType" .. resActorConfig.kind)
    local actorTag = PB.get("ActorTag", m_actor.id)
    if actorTag then
      local ActorTypePrefix = {
        "Window_ActorMainPrefix",
        "Window_ActorAssistPrefix"
      }
      REF.LabelCharactorType.UILabel.text = WU.GetString(ActorTypePrefix[resActorConfig.kind]) .. WU.GetString("tag" .. actorTag.tag[1])
    end
    DestoryEffect()
    ReleaseAllAssets()
    local scale = REF["$transform"].localScale.x
    m_texturePortrait = WU.AcquireAsset("Texture/ActorPortrait/actor_portrait_" .. resActorConfig.animRes, this)
    local effectName = ""
    local bgEffectName = ""
    if resActorConfig.kind == PB.enum.ActorType.Sub then
      REF.root.Animator:Play("DelayOpen_01", -1, 0)
      effectName = effectName .. "UI_NewActorGetAni_Sub"
      bgEffectName = bgEffectName .. "UI_NewActorGetBG_Sub"
    elseif resActorConfig.kind == PB.enum.ActorType.Main then
      REF.root.Animator:Play("DelayOpen", -1, 0)
      effectName = effectName .. "NewActorGetAni_Main"
      bgEffectName = bgEffectName .. "NewActorGetBG_Main"
    end
    WU.ToggleRendering(REF["$gameObject"], true)
    this:DelayInvokeInSeconds(REF["$Animator"]:GetCurrentAnimatorStateInfo(0).length, function()
      WU.SetLockFlag(WU.LockInputFlag.UITransition, false)
    end)
    m_bgEffectInstance = _ENV["$"](CS.GameLogic.CreateUIEffectFromPool(bgEffectName, CS.UnityEngine.Vector3.zero, CS.UnityEngine.Vector3.zero, REF.EffectBG.transform, true, REF.EffectBG.UIPanel.depth, true, scale))
    m_actorEffectInstance = _ENV["$"](CS.GameLogic.CreateUIEffectFromPool(effectName, CS.UnityEngine.Vector3.zero, CS.UnityEngine.Vector3.zero, REF.EffectQuality.transform, true, REF.EffectQuality.UIPanel.depth, true, scale))
    if resActorConfig.kind == PB.enum.ActorType.Sub then
      m_textureActorQuality = WU.AcquireAsset("Texture/NewActorShow/Sub_LevelBG01_" .. ActorQualityTexture[m_actor.quality], this)
      m_textureActorQuality2 = WU.AcquireAsset("Texture/NewActorShow/Sub_LevelBG02_" .. ActorQualityTexture[m_actor.quality], this)
      m_actorEffectInstance.SubActorColorGet1.MeshRenderer.material:SetTexture("_MainTex", m_textureActorQuality)
      m_actorEffectInstance.SubActorColorGet2.MeshRenderer.material:SetTexture("_MainTex", m_textureActorQuality2)
      for i = 1, 6 do
        m_actorEffectInstance["line" .. tostring(i)].MeshRenderer.material:SetColor("_TintColor", CS.NGUIMath.HexToColor(SubEffectColors[m_actor.quality]))
      end
    elseif resActorConfig.kind == PB.enum.ActorType.Main then
      m_textureActorQuality = WU.AcquireAsset("Texture/NewActorShow/MAIN_LevelBG_" .. ActorQualityTexture[m_actor.quality], this)
      m_actorEffectInstance.MainActorColorGet.MeshRenderer.material:SetTexture("_MainTex", m_textureActorQuality)
    end
    m_actorEffectInstance.MaskRole.MeshRenderer.material:SetTexture("_MainTex", m_texturePortrait)
    local mainOffset = m_actorEffectInstance.MaskRole.MeshRenderer.material.mainTextureOffset
    if mainOffset then
      mainOffset.x = mainOffset.x + resActorConfig.portraitUVOffsetX / 1000
      mainOffset.y = mainOffset.y + resActorConfig.portraitUVOffsetY / 1000
      m_actorEffectInstance.MaskRole.MeshRenderer.material.mainTextureOffset = mainOffset
    end
    if m_actor.quality == 4 then
      CS.GameUtility.Vibrate()
    end
    m_haveReward = false
    if m_shareOn then
      local ref = fif(m_isMain, _ENV["$"](REF.MainShare), _ENV["$"](REF.SubShare))
      ref.AwardLabel.gameObject:SetActive(false)
      ref.AwardDialog.gameObject:SetActive(false)
      ref.AwardLabel.UIHtmlLabel.text = ""
      ref.ButtonShare.gameObject:SetActive(true)
      ref.EffectButton.gameObject:SetActive(true)
      this:DelayInvokeInSeconds(1.2, function()
        ref["$gameObject"]:SetActive(true)
      end)
      if m_openShareGoldSkin and m_actor.quality == 4 then
        do
          local playerShareInfo = this:GetData("fci/share")
          if playerShareInfo then
            ShareRewardShowHandle(playerShareInfo)
          else
            this:GameRequest("fci/share"):Get(function(playerShareInfo)
              this:SetData("fci/share", playerShareInfo)
              ShareRewardShowHandle(playerShareInfo)
            end)
          end
        end
      end
    end
    if m_newActors ~= nil and 0 < #m_newActors then
      table.remove(m_newActors, 1)
    end
  end
end

function ReleaseAllAssets()
  if m_texturePortrait ~= nil then
    WU.ReleaseAsset(m_texturePortrait, this)
    m_texturePortrait = nil
  end
  if m_textureActorQuality ~= nil then
    WU.ReleaseAsset(m_textureActorQuality, this)
    m_textureActorQuality = nil
  end
  if m_textureActorQuality2 ~= nil then
    WU.ReleaseAsset(m_textureActorQuality2, this)
    m_textureActorQuality2 = nil
  end
end

function DestoryEffect()
  if m_actorEffectInstance then
    CS.NGUITools.Destroy(m_actorEffectInstance["$gameObject"])
    m_actorEffectInstance = nil
  end
  if m_bgEffectInstance then
    CS.NGUITools.Destroy(m_bgEffectInstance["$gameObject"])
    m_bgEffectInstance = nil
  end
end

function OnShareSuccess()
  if not m_openShareWeekly and not m_openShareGoldSkin then
    return
  end
  local playerShareInfo = this:GetData("fci/share")
  if playerShareInfo then
    ShareRewardGetHandle(playerShareInfo)
  else
    this:GameRequest("fci/share"):Get(function(playerShareInfo)
      this:SetData("fci/share", playerShareInfo)
      ShareRewardGetHandle(playerShareInfo)
    end)
  end
end

function ShareRewardShowHandle(playerShareInfo)
  if playerShareInfo.actorRewardGot then
    local haveReward = true
    for i = 1, #playerShareInfo.actorRewardGot do
      if playerShareInfo.actorRewardGot[i] == m_actor.id then
        haveReward = false
        break
      end
    end
    if haveReward then
      m_haveReward = true
      local shareRewardInfo = PB.get("ShareReward", id_ActivityshareGoldSkin)
      local reward = shareRewardInfo.reward
      if shareRewardInfo then
        local itemInfo = PB.get("ItemInfo", reward[1].id)
        local resImg = "<img src='ResIcon_s." .. itemInfo.icon .. "'/>"
        local count = reward[1].count
        local ref = fif(m_isMain, _ENV["$"](REF.MainShare), _ENV["$"](REF.SubShare))
        ref.AwardLabel.UIHtmlLabel.text = WU.GetString("Window_ShareReward", resImg, count)
        ref.AwardLabel.gameObject:SetActive(true)
        ref.AwardDialog.gameObject:SetActive(true)
      end
    end
  end
end

function ShareRewardGetHandle(playerShareInfo)
  if m_openShareGoldSkin and m_haveReward then
    this:GameRequest("fci/share"):Post({
      activityId = id_ActivityshareGoldSkin,
      actorUid = m_actor.uid
    }, function(result)
      playerShareInfo.weeklyRewarded = true
      playerShareInfo.actorRewardGot = result.actorRewardGot
      this:SetData("fci/share", playerShareInfo)
      m_haveReward = false
      local ref = fif(m_isMain, _ENV["$"](REF.MainShare), _ENV["$"](REF.SubShare))
      ref.AwardLabel.gameObject:SetActive(false)
      ref.AwardDialog.gameObject:SetActive(false)
      m_haveGotShareResult = true
      DBH.ResChange(result.resChange)
      WU.ShowRewards(result.resChange)
    end)
  elseif m_openShareWeekly and playerShareInfo.weeklyRewarded == false then
    this:GameRequest("fci/share"):Post({activityId = id_ActivityshareWeekly}, function(result)
      playerShareInfo.weeklyRewarded = true
      this:SetData("fci/share", playerShareInfo)
    end)
  end
end
