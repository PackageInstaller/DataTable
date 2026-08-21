local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GroupUtil")
local DBH = require("Manager/DataBindingHandler")
local AU = require("Common/ActorUtil")
local DU = require("Common/DungeonUtil")
local IU = require("Common/ItemUtil")
local LU = require("Common/ListUtil")
local S = require("Common/Singleton")
local PU = require("Common/PlatformUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local SDU = require("Common/SoundUtil")
ShiningStarDelay = 0.35
TitleAnimTime = 0.5
RewardAnimTime = 0.2
GroupAnimTime = 1
DungeonTeamDamageAnimTime = 0.33
local m_isPlaying
m_rewards = {}
local m_actorTexture, m_doneList

function InitTargets(balance, dungeonId)
  m_doneList = {}
  local dungeonReward = PB.get("DungeonReward", dungeonId)
  if dungeonReward ~= nil and #dungeonReward.target > 0 then
    for i = 1, #REF.Targets do
      local target = dungeonReward.target[i]
      if target then
        do
          local refTarget = REF.Targets[i - 1]
          local isTargetDone = false
          if table.find(balance.targetsDone, function(k, v)
            return v == target.id
          end) then
            isTargetDone = true
          end
          table.insert(m_doneList, isTargetDone)
          refTarget.LabelTarget.UILabel.text = WU.GetDungeonTargetText(target)
          refTarget.SpriteStar.gameObject:SetActive(not isTargetDone)
          if isTargetDone then
            refTarget.LabelTarget.UILabel.color = CS.UnityEngine.Color.white
          else
            refTarget.LabelTarget.UILabel.color = CS.NGUIMath.HexToColor(3335516415)
          end
        end
      end
    end
  else
    REF.Targets.gameObject:SetActive(false)
  end
end

function UpdateSlot(ref, wrapIndex, realIndex)
  if m_rewards and realIndex < #m_rewards then
    local reward = m_rewards[realIndex + 1]
    if reward.baseRes then
      ref["$$SetData"](reward.baseRes.type, reward.baseRes.id, reward.baseRes.countDelta or reward.baseRes.count)
      ref["$$SetClickCallback"](function()
        WU.ShowResourceDetail(reward.baseRes.type, reward.baseRes.id)
      end)
      if reward.multiple and reward.multiple ~= 0 then
        ref["$$ShowCustom"]({dropUp = true})
      end
      if reward.isExpReturn and reward.isExpReturn == 1 then
        ref["$$ShowExpReturn"](true)
      end
    elseif reward.actor then
      ref["$$SetActor"](reward.actor)
    elseif reward.equip then
      ref["$$SetEquip"](reward.equip)
      ref["$$SetClickCallback"](function()
        WU.ShowEquipDetailByUid(reward.equip.uid, {
          enhance = false,
          equipped = false,
          share = false
        })
      end)
    end
    local additions = ref.Visual.transform:Find("Additions")
    WU.SetActive(additions, reward.showAdditions)
    if additions == nil and reward.showAdditions then
      AddAdditions(ref)
    end
    ref["$$SetOwnerBox"](reward.ownerBoxId)
  end
end

function AddAdditions(ref)
  local additions = CS.UnityEngine.GameObject.Instantiate(ref.ButtonRemove.gameObject, ref.Visual.transform)
  additions.transform.localPosition = CS.UnityEngine.Vector3(-3, 143, 0)
  additions.name = "Additions"
  local uisprite = _ENV["$"](additions)["$UISprite"]
  uisprite.atlasPath = "CommonWindow"
  uisprite.spriteName = "actor_tips"
  uisprite:SnapWithoutScale()
  additions.gameObject:SetActive(true)
  local labelObj = CS.UnityEngine.GameObject.Instantiate(ref.CountLabel.gameObject, additions.transform)
  local label = labelObj.transform:GetComponent(typeof(CS.UILabel))
  label.fontSize = 38
  label.text = WU.GetString("Window_SemiFixedAdditionsBalance")
  label.color = CS.NGUIMath.HexToColor(2945268223)
  label.depth = uisprite.depth + 1
  labelObj.transform.localPosition = CS.UnityEngine.Vector3(0, 12, 0)
  labelObj.gameObject:SetActive(true)
end

function InitAcquirement(balance, additionsInfo)
  m_rewards = DU.GetDungeonBalanceRewards(balance)
  if m_rewards ~= nil then
    if additionsInfo then
      for i = 1, #additionsInfo do
        m_rewards[additionsInfo[i]].showAdditions = true
      end
    end
    local newActors = m_rewards:where(function(k, v)
      return v.actor
    end):select(function(v)
      return v.actor
    end):toarray()
    local dungeonId = this:GetData("WindowDungeon/DungeonId")
    local hideActors = {
      2112,
      1008,
      2114
    }
    if dungeonId and dungeonId == 2012 and newActors then
      for i = 1, #hideActors do
        local index, ac = newActors:find(function(k, v)
          return v.id == hideActors[i]
        end)
        if index then
          newActors:remove(index)
        end
        local indexRewards, r = m_rewards:find(function(k, v)
          return v.actor and v.actor.id == hideActors[i]
        end)
        if indexRewards then
          m_rewards:remove(indexRewards)
        end
      end
    end
    LU.Bind(REF.AcquirementContent, {
      updateRow = UpdateSlot
    })
    LU.Set(REF.AcquirementContent, #m_rewards)
    REF.AcquirementList.BoxCollider2D.enabled = false
    WU.TraverseChildren(REF.AcquirementContent, function(go)
      go:GetComponentInChildren(typeof(CS.UIDragScrollView)).enabled = false
    end)
    local newActors = m_rewards:where(function(k, v)
      return v.actor
    end):select(function(v)
      return v.actor
    end):toarray()
    WU.ShowNewActorGet(newActors)
  end
end

function InitPlayerInfo(balance)
  REF.LabelPlayerTitle.UILabel.text = WU.GetString("Window_PlayerLevel")
  local expAdd = 0
  local preExpAll = 0
  local expBeforeBalance = 0
  local _, expChange = table.find(balance.resChange, function(_, change)
    return change.baseRes and change.baseRes.type == PB.enum.ResourceType.ResPlayerExp
  end)
  if expChange then
    expAdd = expChange.baseRes.countDelta
    expBeforeBalance = expChange.baseRes.count - expChange.baseRes.countDelta
  else
    expBeforeBalance = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[PB.enum.ResourceType.ResPlayerExp] .. "_0")
  end
  local playerConfig = PB.get("PlayerLevelInitConfig", balance.playerLevel + 1)
  if playerConfig == nil then
    playerConfig = PB.get("PlayerLevelInitConfig", balance.playerLevel)
  end
  if playerConfig.exp == 0 then
    playerConfig.exp = 1
  end
  if balance.playerLevel ~= balance.playerLevelBeforeBalance then
    for i = balance.playerLevelBeforeBalance + 1, balance.playerLevel do
      local config = PB.get("PlayerLevelInitConfig", i)
      preExpAll = preExpAll + config.exp
    end
    local expLeft = expAdd - (preExpAll - expBeforeBalance)
    local playerConfigBefore = PB.get("PlayerLevelInitConfig", balance.playerLevelBeforeBalance + 1)
    if playerConfigBefore.exp == 0 then
      playerConfigBefore.exp = 1
    end
    REF.SpriteExpAdd.UISprite.fillAmount = math.max(0, expBeforeBalance / playerConfigBefore.exp)
    REF.WidgetProgressBar["$BalanceExp"](math.max(0, expBeforeBalance / playerConfigBefore.exp), math.max(0, expLeft / playerConfig.exp), true, {
      fromLv = balance.playerLevelBeforeBalance,
      toLv = balance.playerLevel
    })
  else
    local expLeft = expBeforeBalance + expAdd
    REF.SpriteExpAdd.UISprite.fillAmount = math.max(0, expBeforeBalance / playerConfig.exp)
    REF.WidgetProgressBar["$BalanceExp"](math.max(0, expBeforeBalance / playerConfig.exp), math.max(0, expLeft / playerConfig.exp), false, {
      fromLv = balance.playerLevel
    })
  end
end

function UninitWindow()
  if PU.IsRecordVideoEnabled() then
    CS.RecordVideoManager.Instance:CancelGenerateMomentsVideo()
    CS.RecordVideoManager.Instance:CloseGenerateMomentsVideoDialog()
  end
end

function ShiningStars(noDelay)
  if m_isPlaying then
    return
  end
  m_isPlaying = true
  local delay = 0
  for i = 1, #m_doneList do
    if m_doneList[i] then
      if not noDelay then
        this:DelayInvokeInSeconds(delay, function()
          REF.Targets[i - 1].Effect.EffectGenerator:Play()
          CS.SoundManager.Instance:PlaySound("Sound/system/s_System_GetStar" .. i)
        end)
        delay = delay + ShiningStarDelay
      else
        REF.Targets[i - 1].Effect.EffectGenerator:Play()
      end
    end
  end
end

function OnDungeonAnimFinished()
  this:BroadcastGameEvent("AddAuraStranger")
end

function OnButtonContinueClick(windowParam)
  WU.RecordButtonClick(985)
  DU.LeaveDungeon(1, windowParam)
end

function SetProfitBuff(profits, privot)
  if REF.WidgetProfitBuffList then
    if profits and next(profits) ~= nil then
      WU.ToggleRendering(REF.WidgetProfitBuffList, true)
      REF.WidgetProfitBuffList["$SetProfitBuffList"](profits, privot)
      REF.WidgetProfitBuffList["$SetClickCallback"](function()
        WU.AcquireWindowAsync("ProfitBuff")
      end)
    else
      WU.ToggleRendering(REF.WidgetProfitBuffList, false)
    end
  end
end

function ToggleTriggleEventEffect(flag)
  REF.TriggeredEvent.gameObject:SetActive(flag)
  REF.TriggeredEventEffect.gameObject:SetActive(flag)
end

function ToggleReceiveFoodGameEventEffect(flag)
  WU.SetActive(REF.GameReceiveEvent, flag)
  WU.SetActive(REF.GameReceiveEventEffect, flag)
end

function GetFavourChangeRoles(favour)
  if favour == nil then
    return
  end
  local notepads = this:GetData("fci/RoleNotePad/")
  local roleIds = {}
  for i, v in ipairs(favour) do
    if notepads == nil then
      roleIds[v.roleId] = 1
    else
      local k2, v2 = table.find(notepads, function(k3, v3)
        return v3.roleId == v.roleId
      end)
      if v2 and v.favourLevel ~= v.oldFavourLevel then
        roleIds[v.roleId] = 1
      end
    end
  end
  return roleIds
end

function SetActorTextureEffect(id)
  if id and 0 < id then
    local actorConfig = PB.get("ActorConfig", id)
    if actorConfig == nil then
      return
    end
    SDU.PlayActorWin(id)
    m_actorTexture = WU.AcquireAsset("Texture/ActorPortrait/actor_portrait_" .. actorConfig.animRes, this)
    REF.Role_01.MeshRenderer.material:SetTexture("_MainTex", m_actorTexture)
    REF.Role_01ADD.MeshRenderer.material:SetTexture("_MainTex", m_actorTexture)
    REF.EffectRight.EffectGenerator:Play()
    local portraitOffset = CS.UnityEngine.Vector3(actorConfig.portraitOffsetX, actorConfig.portraitOffsetY, 0)
    local effectOffset = REF.Balance_01D2.transform:InverseTransformPoint(REF.EffectRight.transform:TransformPoint(portraitOffset))
    REF.Role_01.transform.localPosition = REF.Role_01.transform.localPosition + effectOffset
    REF.Role_01ADD.transform.localPosition = REF.Role_01ADD.transform.localPosition + effectOffset
  end
end

function OnDestroy()
  if m_actorTexture then
    WU.ReleaseAsset(m_actorTexture, this)
  end
end
