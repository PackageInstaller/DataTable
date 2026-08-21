local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_actorSwitchEffect
local m_dragDelta = CS.UnityEngine.Vector2.zero
local m_effect = "RoleChange_01_D"
local m_actorDBTag = "Actor/SelectedUid"
local m_roleNotepadDBTag = "Notepad/SelectedRoleId"
local m_roleId
local m_traverseTag = "Actor/RollerTraverse"
local m_mode = "actor"
local m_playSoundActorId, m_lastAudioIdx
local m_allowRoller = true
local m_effectInstance, m_texturePortrait, m_dragCallback, m_clickCallback

function SetShowLogo(show)
  if REF.TextureLogo then
    WU.ToggleRendering(REF.TextureLogo, show)
  end
end

function SetMode(mode)
  m_mode = mode
  if m_mode == "actor" then
    this:Bind(m_actorDBTag, OnActorSelected)
  end
end

function SetDragCallback(f)
  m_dragCallback = f
end

function SetClickCallback(f)
  m_clickCallback = f
end

function SetAllowRoller(flag)
  m_allowRoller = flag
end

function SetEffect(effect)
  m_effect = effect
end

function OnActorSelected(uid)
  if uid then
    local actor = this:GetData("fci/actor/" .. uid)
    if actor then
      m_playSoundActorId = actor.id
      m_effectInstance = SwitchActor(actor.id)
    end
  end
end

function OnRoleNotepadActorSelected(roleId)
  if roleId then
    m_roleId = roleId
    m_effectInstance = SelectRoleNotapadRole(roleId)
  end
end

function SetRollerActor(actor)
  if actor then
    m_playSoundActorId = actor.id
    m_effectInstance = SwitchActor(actor.id)
  end
end

function Start()
  if REF.DragArea ~= nil then
    WU.BindDragEvent(REF.DragArea, OnDraging)
    WU.BindPressEvent(REF.DragArea, OnPress, "empty")
    WU.BindButtonEvent(REF.DragArea, function()
      if m_clickCallback then
        m_clickCallback()
      end
    end)
  end
end

function OnDestroy()
  WU.ReleaseAsset(m_texturePortrait, this)
end

function OnDraging(go, delta)
  WU.RecordButtonClick(589)
  m_dragDelta = m_dragDelta + delta
end

function OnPress(go, pressed)
  if pressed then
    m_dragDelta = CS.UnityEngine.Vector2.zero
    if m_playSoundActorId ~= nil then
      RandomPlaySound(m_playSoundActorId)
    end
  elseif m_mode == "actor" or m_mode == "roleNotepad" and m_allowRoller then
    local val = 0
    if m_dragDelta.x < -100 then
      val = 1
    elseif m_dragDelta.x > 100 then
      val = -1
    end
    if val ~= 0 then
      if m_mode == "actor" then
        CS.SoundManager.Instance:PlaySound("Sound/system/s_System_ActorChange")
        SelectActor(val)
      elseif m_mode == "roleNotepad" then
        CS.SoundManager.Instance:PlaySound("Sound/system/s_System_ActorChange")
        SwitchNotepadRole(val)
      end
      if m_dragCallback then
        m_dragCallback(val)
      end
    end
  end
end

function RandomPlaySound(actorId)
  local resActorConfig = PB.get("ActorConfig", actorId)
  local audioInfo = this:GetData("WidgetActorRollerAudioInfo") or {id = 0, audioSource = nil}
  local audioSource = audioInfo.audioSource
  if not (audioInfo.id == actorId and audioSource) or not audioSource.isPlaying then
    if audioSource then
      audioSource:Stop()
    end
    if #resActorConfig.chooseAudio > 1 then
      local idx
      if audioInfo.id == actorId and m_lastAudioIdx ~= nil then
        idx = math.random(1, #resActorConfig.chooseAudio)
        while idx == m_lastAudioIdx do
          idx = math.random(1, #resActorConfig.chooseAudio)
        end
      else
        idx = math.random(1, #resActorConfig.chooseAudio)
      end
      m_lastAudioIdx = idx
      audioSource = CS.SoundManager.Instance:PlaySound("Voice/" .. resActorConfig.chooseAudio[idx], 1.0)
    elseif 0 < #resActorConfig.chooseAudio then
      info("Actor", "Actor id " .. actorId .. " only have one chooseAudio source")
      audioSource = CS.SoundManager.Instance:PlaySound("Voice/" .. resActorConfig.chooseAudio[1], 1.0)
    end
    this:SetData("WidgetActorRollerAudioInfo", {id = actorId, audioSource = audioSource})
  end
end

function SwitchActor(actorId)
  local scale = REF["$transform"].localScale.x
  local resActorConfig = PB.get("ActorConfig", actorId)
  if resActorConfig == nil then
    error("Actor", string.format("Id:%d does not exists in ResActorConfig", actorId))
    return
  end
  local thePortrait = PB.get("ActorPortrait", actorId, 0)
  RandomPlaySound(actorId)
  if REF.TextureLogo then
    REF.TextureLogo.UITexture.mainTexturePath = "Texture/ActorLogo/actor_logo_" .. resActorConfig.animRes
    REF.LogoOffset.transform.localPosition = CS.UnityEngine.Vector3(resActorConfig.logoOffsetX, resActorConfig.logoOffsetY, 0)
  end
  if m_texturePortrait ~= nil then
    WU.ReleaseAsset(m_texturePortrait, this)
  end
  m_texturePortrait = WU.AcquireAsset("Texture/ActorPortrait/actor_portrait_" .. resActorConfig.animRes, this)
  REF.Effect.gameObject:SetActive(false)
  REF.Effect.gameObject:SetActive(true)
  m_actorSwitchEffect = _ENV["$"](REF.Effect)
  m_actorSwitchEffect["$transform"].localScale = CS.UnityEngine.Vector3(scale, scale, 1)
  m_actorSwitchEffect["Plane add"].MeshRenderer.material:SetTexture("_MaskTex", m_texturePortrait)
  m_actorSwitchEffect["Plane nor"].MeshRenderer.material:SetTexture("_MainTex", m_texturePortrait)
  if thePortrait then
    local portraitOffset = CS.UnityEngine.Vector3(thePortrait.position[2].Xoffset, thePortrait.position[2].Yoffset, 0)
    local effectOffset = m_actorSwitchEffect["Plane nor"].transform.parent:InverseTransformPoint(REF["$transform"]:TransformPoint(portraitOffset))
    local curPortraitPos = m_actorSwitchEffect["Plane nor"].transform.localPosition
    effectOffset.z = curPortraitPos.z
    m_actorSwitchEffect["Plane nor"].transform.localPosition = effectOffset
    m_actorSwitchEffect["Plane add"].transform.localPosition = effectOffset
    if thePortrait.position[2].scale then
      m_actorSwitchEffect["Plane nor"].transform.localScale = m_actorSwitchEffect["Plane nor"].transform.localScale * thePortrait.position[2].scale
      m_actorSwitchEffect["Plane add"].transform.localScale = m_actorSwitchEffect["Plane add"].transform.localScale * thePortrait.position[2].scale
    end
  else
    warning("ActorPortrait.xlsx", "ActorPortrait.xlsx\232\161\168\228\184\173\228\184\141\229\173\152\229\156\168" .. actorId)
  end
  return m_actorSwitchEffect
end

function SelectRoleNotapadRole(roleId)
  local top = WU.TopWindow()
  if top and top.name ~= "RoleNotepadDetail" then
    return
  end
  local scale = REF["$transform"].localScale.x
  local role = PB.get("Role", roleId)
  local offsetX = 0
  local offsetY = 0
  if role then
    local allActorConfig = PB.all("ActorConfig")
    local actorCofnig
    for _, v in pairs(allActorConfig) do
      if v.role == roleId then
        actorCofnig = v
        break
      end
    end
    offsetX = -actorCofnig.portraitUVOffsetX / 1394
    offsetY = actorCofnig.portraitUVOffsetY / 1080
  else
    error("Role.xlsx error", "role id " .. tostring(roleId))
  end
  local animRes = role.animRes
  local m_texturePortrait = WU.AcquireAsset("Texture/ActorPortrait/actor_portrait_" .. animRes, this)
  REF.Effect.gameObject:SetActive(false)
  REF.Effect.gameObject:SetActive(true)
  m_actorSwitchEffect = _ENV["$"](REF.Effect)
  m_actorSwitchEffect["$transform"].localScale = CS.UnityEngine.Vector3(scale, scale, 1)
  
  local function changeTexture()
    m_actorSwitchEffect["Plane add"].MeshRenderer.material:SetTexture("_MaskTex", m_texturePortrait)
    m_actorSwitchEffect["Plane nor"].MeshRenderer.material:SetTexture("_MainTex", m_texturePortrait)
    local mainOffset = CS.UnityEngine.Vector2(offsetX, offsetY)
    m_actorSwitchEffect["Plane add"].MeshRenderer.material:SetTextureOffset("_MaskTex", mainOffset)
    m_actorSwitchEffect["Plane nor"].MeshRenderer.material.mainTextureOffset = mainOffset
  end
  
  this:DelayInvokeInFrames(1, function()
    changeTexture()
  end)
  return m_actorSwitchEffect
end

function SelectActor(val)
  local selectedUid = this:GetData(m_actorDBTag)
  local traverseActors = this:GetData(m_traverseTag)
  if traverseActors then
    local idx = table.find(traverseActors, function(k, v)
      return v and v.uid == selectedUid
    end)
    if idx then
      if #traverseActors == 1 then
        return
      end
      idx = idx + val
      if idx > #traverseActors then
        idx = 1
      elseif idx < 1 then
        idx = #traverseActors
      end
      this:SetData(m_actorDBTag, traverseActors[idx].uid)
    end
  end
end

function SwitchNotepadRole(val)
  local allSortedNotepads = this:GetData("Notepad/AllSortedNotepads")
  if allSortedNotepads == nil then
    return
  end
  this:SetData("RoleNotepadUpdateAble", true)
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_ActorChange")
  if 0 < val then
    local index = table.find(allSortedNotepads, function(_, v)
      return v.roleId == m_roleId
    end)
    if index == nil or index == #allSortedNotepads then
      return
    end
    this:SetData("Notepad/SelectedRoleId", allSortedNotepads[index + 1].roleId)
    this:BroadcastGameEvent("RoleNotePadDetailSwitch", allSortedNotepads[index + 1].roleId)
  end
  if val < 0 then
    local index = table.find(allSortedNotepads, function(_, v)
      return v.roleId == m_roleId
    end)
    if index == nil or index == 1 then
      return
    end
    this:SetData("Notepad/SelectedRoleId", allSortedNotepads[index - 1].roleId)
    this:BroadcastGameEvent("RoleNotePadDetailSwitch", allSortedNotepads[index - 1].roleId)
  end
end
