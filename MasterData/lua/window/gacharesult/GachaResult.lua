local WU, DB, REF = require("Common/WindowUtil")(this)
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local PU = require("Common/PlatformUtil")
local CO = require("Common/Coroutine")
local m_dropList = {}
local m_showDropList = {}
local m_showInterval = 0.25
local m_time = m_showInterval
local m_newActorShowing = false
local m_newArmShowing = false
local m_armUpgradeShowing = false
local m_curIndex = 0
local m_allNewActors = {}
local m_allNewArms = {}
local m_isShowingResult = false
local m_gachaDetail, m_gachaData, m_update
local m_displayResetRow = 0
local m_resetDisplayRowIndex = 0
local m_setDisplayRowIndex = 0
local m_actors, m_arms, m_showNewActorIds
local m_hasMoreThanSixActor = false
local m_totalCnt = 0
local m_curDropCnt = 0
local m_preDropCnt = 0
local m_detalCnt = 0
local m_curCnt = 0

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonClose, OnCloseClick)
  WU.BindButtonEvent(REF.ButtonGacha, OnGachaClick)
  WU.BindButtonEvent(REF.ButtonShare, OnShareClick)
  WU.BindButtonEvent(REF.ButtonVideoShare, OnVideoShareClick)
  CS.EventDelegate.Add(_ENV["$"](REF.OneDrop).Visual.UIPlayTween.onFinished, OnAnimationFinished)
  LU.Bind(REF.WrapContent, {
    dataSource = function(dataIndex)
      return m_dropList and m_dropList[dataIndex]
    end,
    updateSlot = UpdateDropSlot,
    updateRow = UpdateDropRow
  })
  WU.PreloadWindow("NewActorGet")
end

function InitWindow()
  this:SetData("DungeonTeamInviteHint/Hide", true)
  REF.HtmlLabelGetTips.gameObject:SetActive(false)
  m_dropList = {}
  m_time = m_showInterval
  m_showDropList = {}
  m_allNewActors = {}
  m_allNewArms = {}
  m_curIndex = 0
  m_isShowingResult = true
  m_newActorShowing = false
  m_newArmShowing = false
  m_armUpgradeShowing = false
  m_displayResetRow = 0
  m_resetDisplayRowIndex = 0
  m_setDisplayRowIndex = 0
  REF.PanelAchieveEffect.gameObject:SetActive(false)
  m_actors = {}
  local actors = this:GetData("fci/actor/")
  _ENV["!"](actors):copy(m_actors)
  m_arms = {}
  local arms = this:GetData("OldArms")
  _ENV["!"](arms):copy(m_arms)
  m_showNewActorIds = {}
  ResetDisplayDrop()
  ResetDropScrollView()
  REF.ButtonClose.gameObject:SetActive(false)
  REF.ButtonGacha.gameObject:SetActive(false)
  REF.ButtonShare.gameObject:SetActive(false)
  REF.ButtonVideoShare.gameObject:SetActive(false)
  this:Bind("fci/gachaResult/", OnGachaResult)
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  this:BroadcastGameEvent("StopArmGachaEffect")
end

function UpdateWindow(delta)
  if m_newActorShowing or m_newArmShowing or m_armUpgradeShowing or #m_showDropList == 0 then
    return
  end
  REF.OneDrop[0].root.gameObject:SetActive(false)
  m_time = m_time + delta
  if m_time > m_showInterval then
    local displayDropSlot
    if 0 < #m_showDropList then
      if m_totalCnt == 1 then
        REF.ScrollViewDrag.gameObject:SetActive(false)
        ShowDisplayDropSlot(m_showDropList[1], REF.OneDrop[0])
        UpdateShowData()
      else
        REF.ScrollViewDrag.gameObject:SetActive(true)
        local row = math.floor(m_curIndex / #REF.GachaResultRow)
        local col = m_curIndex - row * #REF.GachaResultRow
        if 0 < row and m_displayResetRow ~= row then
          m_displayResetRow = row
          if m_resetDisplayRowIndex == m_setDisplayRowIndex then
            m_setDisplayRowIndex = 1 - m_setDisplayRowIndex
          else
            for i = 0, #REF.DisplayDropRowGrid[m_resetDisplayRowIndex]["$"] - 1 do
              local displayDropSlot = REF.DisplayDropRowGrid[m_resetDisplayRowIndex]["$"][i]
              displayDropSlot["$gameObject"]:SetActive(false)
              CS.EventDelegate.Remove(displayDropSlot.Visual.UIPlayTween.onFinished, OnAnimationFinished)
            end
            REF.DisplayDropRowGrid[m_resetDisplayRowIndex]["$UIGrid"]:Reposition()
            local tempPos = REF.DisplayDropRowGrid[m_resetDisplayRowIndex]["$transform"].localPosition
            REF.DisplayDropRowGrid[m_resetDisplayRowIndex]["$transform"].localPosition = REF.DisplayDropRowGrid[m_setDisplayRowIndex]["$transform"].localPosition
            REF.DisplayDropRowGrid[m_setDisplayRowIndex]["$transform"].localPosition = tempPos
            local tempIndex = m_resetDisplayRowIndex
            m_resetDisplayRowIndex = m_setDisplayRowIndex
            m_setDisplayRowIndex = tempIndex
          end
        end
        local displayDropRow = REF.DisplayDropRowGrid[m_setDisplayRowIndex]["$"]
        if col < #displayDropRow then
          displayDropSlot = displayDropRow[col]
          ShowDisplayDropSlot(m_showDropList[1], displayDropSlot)
          UpdateShowData()
        end
      end
    end
    if #m_showDropList == 0 and displayDropSlot then
      CS.EventDelegate.Add(displayDropSlot.Visual.UIPlayTween.onFinished, OnAnimationFinished)
    end
    m_time = 0
  end
end

function ResetDisplayDrop()
  REF.DisplayDropRowGrid.gameObject:SetActive(true)
  for i = 0, #REF.DisplayDropRowGrid - 1 do
    for j = 0, #REF.DisplayDropRowGrid[i]["$"] - 1 do
      local displayDropSlot = REF.DisplayDropRowGrid[i]["$"][j]
      displayDropSlot["$gameObject"]:SetActive(false)
      CS.EventDelegate.Remove(displayDropSlot.Visual.UIPlayTween.onFinished, OnAnimationFinished)
    end
  end
  REF.DisplayDropRowGrid.UIGrid:Reposition()
end

function ResetDropScrollView()
  WU.ToggleRendering(REF.ScrollViewDrag, false)
end

function MoveScrollviewToBottom()
  local row = math.ceil(#m_dropList / #REF.GachaResultRow)
  local v3 = CS.UnityEngine.Vector3.zero
  if 2 < row then
    v3.y = REF.WrapContent.UIWrapContent.itemSize * (row - 2)
  end
  REF.ScrollView.UIScrollView:MoveRelative(v3)
end

function ShowDisplayDropSlot(dropData, dropSlot)
  local ref = dropSlot
  ref["@dropData"] = dropData
  if dropData.baseRes then
    ref["$$SetData"](dropData.baseRes.type, dropData.baseRes.id, dropData.baseRes.countDelta)
    ref["$$SetClickCallback"](OnSlotClick)
  elseif dropData.actor then
    ref["$$SetActor"](dropData.actor)
    ref["$$ShowCustom"]({
      name = false,
      showLock = false,
      showStar = false,
      showActorLevel = false
    })
    ref["$$SetClickCallback"](OnSlotClick)
  elseif dropData.equip then
    ref["$$SetEquip"](dropData.equip)
    ref["$$SetClickCallback"](OnSlotClick)
  elseif dropData.weapon then
    if dropData.inBox and #dropData.inBox > 0 then
      ref["$$SetData"](dropData.inBox[1].baseRes.type, dropData.inBox[1].baseRes.id, dropData.inBox[1].baseRes.countDelta)
      ref["$$SetClickCallback"](OnSlotClick)
    else
      ref["$$SetArm"](dropData.weapon, "S")
      ref["$$ShowCustom"]({
        hideLevel = true,
        showStar = false,
        hideNew = true
      })
      ref["$$SetClickCallback"](OnSlotClick)
    end
  end
  if this:GetData("CurrentTutorial") == 32 then
    ref["$$SetClickCallback"](nil)
  end
  local bShowAchieve = IsShowAchievementGet(dropData.actor)
  if dropData.actor == nil or IsShowActorGet(dropData.actor) == false then
    if dropData.weapon == nil or IsShowArmGet(dropData.weapon) == false then
      if dropData.afterUpgradeWeapon and dropData.weapon then
        local index = table.find(m_arms, function(k, v)
          return v.id == dropData.weapon.id
        end)
        if index then
          ShowArmUpgrade(m_arms[index], dropData.afterUpgradeWeapon, dropSlot)
          m_arms[index] = dropData.afterUpgradeWeapon
        else
          error("no oldweapon id " .. dropData.weapon.id)
          return
        end
      elseif dropData.weapon and dropData.inBox and #dropData.inBox > 0 then
        local weaponCopy = {}
        table.copy(dropData.weapon, weaponCopy, true)
        weaponCopy.phase = weaponCopy.phase - 1
        ShowArmChange(weaponCopy, dropData.inBox, dropSlot)
      else
        dropSlot["$gameObject"]:SetActive(true)
        dropSlot["$UICustomSound"]:PlayCustomSound()
        dropSlot.Visual.UIPlayTween:Play(true)
        local refGrid = _ENV["$"](dropSlot["$transform"].parent)["$UIGrid"]
        if refGrid then
          refGrid:Reposition()
        end
      end
    elseif IsShowArmGet(dropData.weapon) == true then
      ShowArmGet(dropData.weapon, dropSlot)
    end
  elseif bShowAchieve then
    ShowAchievementGet(dropData.actor, dropSlot)
  else
    ShowActorGet(dropData.actor, dropSlot)
  end
  if PU.IsRecordGachaEnabled() then
    local isRecording = CS.RecordVideoManager.Instance:isRecordingMoments()
    if isRecording then
      local isOrangeActor = dropData.actor and dropData.actor.quality >= 4
      local recordVideoData = this:GetData("RecordVideoData")
      if recordVideoData then
        local endTime = CS.GameJoy.getSystemCurrentTimeMillis
        recordVideoData.endTime = endTime
        local list = this:GetData("RecordVideoList")
        if list == nil then
          list = {}
        end
        table.insert(list, recordVideoData)
        this:SetData("RecordVideoList", list)
        local newRecordVideoData = {
          startTime = endTime,
          showActorGet = fif(dropData.actor and IsShowActorGet(dropData.actor), true, false),
          isOrangeActor = fif(dropData.actor and dropData.actor.quality >= 4, true, false),
          show91Effect = bShowAchieve
        }
        this:SetData("RecordVideoData", newRecordVideoData)
      end
    end
  end
end

function IsShowAchievementGet(actor)
  local dropActorId = this:GetData("GachaDropActorId")
  local maxCnt = this:GetData("GachaMaxDropCnt")
  if actor and maxCnt and dropActorId and maxCnt < m_curDropCnt and maxCnt > m_preDropCnt and actor.id == dropActorId and actor.quality >= PB.enum.ActorQuality.Orange then
    return true
  end
  return false
end

function ShowEffectNumber(cnt)
  local s = math.floor(cnt / 10) % 10
  local g = cnt % 10
  local number_l = string.format("Texture/Gacha/UI_GGAG_NO_%02d", s)
  local number_r = string.format("Texture/Gacha/UI_GGAG_NO_%02d", g)
  local number_l_tex = WU.AcquireAsset(number_l)
  local number_r_tex = WU.AcquireAsset(number_r)
  REF.NumL.MeshRenderer.material:SetTexture("_MainTex", number_l_tex)
  REF.NumR.MeshRenderer.material:SetTexture("_MainTex", number_r_tex)
end

function ShowAchievementGet(actor, dropSlot)
  m_newActorShowing = true
  if m_update ~= nil then
    this:StopCoroutine(m_update)
    m_update = nil
  end
  REF.PanelAchieveEffect.gameObject:SetActive(true)
  REF.HtmlLabelGetTips.gameObject:SetActive(true)
  local maxCnt = this:GetData("GachaMaxDropCnt")
  local realCnt = m_curCnt
  m_preDropCnt = maxCnt + 1
  local temp = maxCnt - realCnt
  if temp <= 0 then
    temp = 1
  end
  local actorConfig = PB.get("ActorConfig", actor.id)
  local strTips = WU.GetString("WindowGacha_HasGetActor", realCnt)
  if actorConfig then
    strTips = strTips .. WU.GetString("RoleName_" .. actorConfig.role)
  end
  REF.HtmlLabelGetTips.UIHtmlLabel.text = strTips
  REF.BackBlack.MeshRenderer.material.renderQueue = 3000
  local fps = 0.03
  local detal = 1
  local totalTime = 0.75
  local timeDetal = totalTime / temp
  if fps > timeDetal then
    detal = math.ceil(temp / (totalTime / 0.03))
    timeDetal = fps
  end
  m_detalCnt = maxCnt
  m_update = this:RepeatInvokeInSeconds(timeDetal, function()
    ShowEffectNumber(m_detalCnt)
    if m_detalCnt <= realCnt then
      if m_update ~= nil then
        this:StopCoroutine(m_update)
        m_update = nil
      end
      return
    end
    m_detalCnt = m_detalCnt - detal
    if m_detalCnt < realCnt then
      m_detalCnt = realCnt
    end
  end)
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Gacha_04", 1.0)
  REF.PanelAchieveEffect.EffectGenerator:Play(function()
    REF.PanelAchieveEffect.gameObject:SetActive(false)
    REF.HtmlLabelGetTips.gameObject:SetActive(false)
    ShowActorGet(actor, dropSlot)
  end)
end

function IsShowActorGet(actor)
  if actor.quality < PB.enum.ActorQuality.Purple then
    return false
  end
  if actor.quality < 4 then
    for _, v in pairs(m_actors) do
      if actor.uid ~= v.uid and actor.id == v.id and actor.quality <= v.quality then
        local key1, gachaGetActor = table.find(m_allNewActors, function(k1, v1)
          return v1.uid == v.uid
        end)
        if gachaGetActor then
          local key2, showNewActor = table.find(m_showNewActorIds, function(k2, v2)
            return v2.id == actor.id and v2.quality >= actor.quality
          end)
          if showNewActor then
            return false
          else
            table.insert(m_showNewActorIds, {
              id = actor.id,
              quality = actor.quality
            })
            return true
          end
        else
          return false
        end
      end
    end
  end
  table.insert(m_showNewActorIds, {
    id = actor.id,
    quality = actor.quality
  })
  return true
end

function IsShowArmGet(arm)
  if arm and arm.id then
    for _, v in pairs(m_arms) do
      if v.id == arm.id then
        return false
      end
    end
    return true
  end
  return false
end

function ShowArmGet(arm, dropSlot)
  m_newArmShowing = true
  table.insert(m_arms, arm)
  WU.ShowNewArmGet(arm, function()
    if dropSlot then
      dropSlot["$gameObject"]:SetActive(true)
      dropSlot.Visual.UIPlayTween:Play(true)
      local ref = _ENV["$"](dropSlot["$transform"].parent)["$UIGrid"]
      if ref then
        ref:Reposition()
      end
    end
  end, m_allNewArms)
end

function ShowArmUpgrade(arm1, arm2, dropSlot)
  m_armUpgradeShowing = true
  if m_totalCnt == #m_showDropList then
    this:DelayInvokeInFrames(1, function()
      WU.ShowArmUpgrade(arm1, arm2, function()
        if dropSlot then
          dropSlot["$gameObject"]:SetActive(true)
          dropSlot.Visual.UIPlayTween:Play(true)
          local ref = _ENV["$"](dropSlot["$transform"].parent)["$UIGrid"]
          if ref then
            ref:Reposition()
          end
        end
      end)
    end)
  else
    WU.ShowArmUpgrade(arm1, arm2, function()
      if dropSlot then
        dropSlot["$gameObject"]:SetActive(true)
        dropSlot.Visual.UIPlayTween:Play(true)
        local ref = _ENV["$"](dropSlot["$transform"].parent)["$UIGrid"]
        if ref then
          ref:Reposition()
        end
      end
    end)
  end
end

function ShowArmChange(arm, item, dropSlot)
  m_armUpgradeShowing = true
  WU.ShowArmTransfer(arm, item, function()
    if dropSlot then
      dropSlot["$gameObject"]:SetActive(true)
      dropSlot.Visual.UIPlayTween:Play(true)
      local ref = _ENV["$"](dropSlot["$transform"].parent)["$UIGrid"]
      if ref then
        ref:Reposition()
      end
    end
  end)
end

function ShowActorGet(actor, dropSlot)
  m_newActorShowing = true
  table.insert(m_actors, actor)
  WU.ShowNewActorGet(actor, function()
    if dropSlot then
      dropSlot["$gameObject"]:SetActive(true)
      dropSlot.Visual.UIPlayTween:Play(true)
      local ref = _ENV["$"](dropSlot["$transform"].parent)["$UIGrid"]
      if ref then
        ref:Reposition()
      end
    end
  end, m_allNewActors)
end

function UpdateShowData()
  m_curIndex = m_curIndex + 1
  table.remove(m_showDropList, 1)
  if #m_showDropList == 0 then
    m_curIndex = 0
  end
end

function OnGachaResult(gachaResult)
  if gachaResult then
    m_allNewActors = {}
    m_allNewArms = {}
    m_dropList = {}
    m_showDropList = {}
    m_curCnt = 0
    local score = gachaResult.addGachaScore
    if gachaResult.info.id == 6 then
      if gachaResult.isClawSuccess then
        REF.LabelScore.UILabel.text = WU.GetString("WindowGacha_GachaFriendGetReward")
      else
        REF.LabelScore.UILabel.text = WU.GetString("WindowGacha_GachaFriendNoGetReward")
      end
    else
      REF.LabelScore.UILabel.text = WU.GetString("WindowGacha_GetScoreTips", score)
    end
    m_curDropCnt = 0
    if gachaResult.activityInfo then
      m_curDropCnt = gachaResult.activityInfo.curDropActivityActor
      m_preDropCnt = gachaResult.activityInfo.preDropActivityActor
      m_curCnt = gachaResult.activityInfo.getActivityActorCount
    end
    ManageReschange(gachaResult.info.resChange)
  end
end

function ManageReschange(reschange)
  for i = 1, #reschange do
    local change = reschange[i]
    local valid = false
    if change.baseRes then
      valid = change.baseRes.countDelta > 0 and change.baseRes.param == PB.enum.ResourceParamType.None
    elseif change.equip then
      valid = 0 < change.equip.countDelta
    elseif change.actor then
      valid = 0 < change.actor.countDelta
      if valid then
        table.insert(m_allNewActors, change.actor)
      end
    elseif change.weapon then
      valid = true
      if valid then
        table.insert(m_allNewArms, change.weapon)
      end
    end
    if valid then
      table.insert(m_showDropList, change)
      table.insert(m_dropList, change)
    end
  end
  m_totalCnt = #m_showDropList
  LU.Set(REF.WrapContent, math.ceil(#m_dropList / #REF.GachaResultRow))
  MoveScrollviewToBottom()
end

function SetResultLabel(str)
  REF.LabelScore.UILabel.text = str
end

function UpdateDropSlot(slot, dropData)
  local ref = slot
  ref["@dropData"] = dropData
  if dropData.baseRes then
    ref["$$SetData"](dropData.baseRes.type, dropData.baseRes.id, dropData.baseRes.countDelta)
    ref["$$SetClickCallback"](OnSlotClick)
  elseif dropData.actor then
    ref["$$SetActor"](dropData.actor)
    ref["$$ShowCustom"]({
      name = false,
      showLock = false,
      showStar = false,
      showActorLevel = false
    })
    ref["$$SetClickCallback"](OnSlotClick)
  elseif dropData.equip then
    ref["$$SetEquip"](dropData.equip)
    ref["$$SetClickCallback"](OnSlotClick)
  elseif dropData.weapon then
    if dropData.inBox and #dropData.inBox > 0 then
      ref["$$SetData"](dropData.inBox[1].baseRes.type, dropData.inBox[1].baseRes.id, dropData.inBox[1].baseRes.countDelta)
      ref["$$SetClickCallback"](OnSlotClick)
    else
      ref["$$SetArm"](dropData.weapon, "S")
      ref["$$ShowCustom"]({
        hideLevel = true,
        showStar = false,
        hideNew = true
      })
      ref["$$SetClickCallback"](OnSlotClick)
    end
  else
    ref["$$SetClickCallback"](nil)
  end
  if this:GetData("CurrentTutorial") == 32 then
    ref["$$SetClickCallback"](nil)
  end
end

function UpdateDropRow(rowRef, wrapIndex, rowIndex)
  if rowIndex >= math.ceil(#m_dropList / #REF.GachaResultRow) then
    return
  end
  S:Get("UIWindowManager").PendingRefresh(function()
    rowRef["$UIGrid"]:Reposition()
  end)
end

function OnSlotClick(go)
  if not m_isShowingResult then
    local dropData = _ENV["$"](go)["@dropData"]
    if dropData.baseRes then
      WU.ShowResourceDetail(dropData.baseRes.type, dropData.baseRes.id)
    elseif dropData.actor then
      WU.ShowNewActorGet(dropData.actor, nil, m_allNewActors)
    elseif dropData.weapon then
      WU.ShowNewArmGet(dropData.weapon, nil, m_allNewArms)
    elseif dropData.equip then
      WU.ShowEquipDetailByUid(dropData.equip.uid, {
        enhance = true,
        equipped = true,
        share = false
      })
    end
  end
end

function OnAnimationFinished()
  this:DelayInvokeInSeconds(0.5, function()
    m_isShowingResult = false
    WU.ToggleRendering(REF.ScrollViewDrag, true)
    REF.DisplayDropRowGrid.gameObject:SetActive(false)
    REF.ButtonClose.gameObject:SetActive(true)
    m_gachaDetail = this:GetData("fci/gachaDetail/")
    m_gachaData = this:GetData("fci/gachaData/")
    local showContinue = m_gachaData and m_gachaData.showContinue
    if showContinue then
      local times = m_gachaData and m_gachaData.times
      REF.ButtonGacha.gameObject:SetActive(m_gachaDetail and times)
      if m_gachaDetail and times then
        local gachaType = PB.get("GachaType", m_gachaDetail.id)
        local cost = gachaType.cost
        local costStock = 0
        if gachaType.cost.type == PB.enum.ResourceType.ResItem then
          costStock = this:GetData("fci/item/" .. gachaType.cost.id).count
        else
          costStock = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[gachaType.cost.type] .. "_" .. gachaType.cost.id)
        end
        if costStock <= 0 then
          cost = gachaType.costSub
        end
        _ENV["$"](REF.ButtonGacha).Label.UIHtmlLabel.text = WU.GetString("WindowGacha_Gacha" .. times)
        _ENV["$"](REF.ButtonGacha).LabelCost.ResourcePrinter:SetAutoColor(false)
        _ENV["$"](REF.ButtonGacha).LabelCost.ResourcePrinter:SetResource(cost.type, cost.id, cost.count * times)
      end
    else
      REF.ButtonGacha.gameObject:SetActive(false)
    end
    ShowShareButton(m_dropList)
    EndRecordVideo()
    REF.ButtonGrid.UIGrid:Reposition()
    if this:GetData("CurrentTutorial") == 32 then
      this:BroadcastGameEvent("Tutorial/StepReady")
    else
      local tutorialMgr = S:Get("TutorialManager")
      local isDone = tutorialMgr.IsTutorialDone(20)
      if not isDone then
        this:BroadcastGameEvent("Tutorial/TriggerTutorial", "GachaResult")
      end
    end
  end)
end

function OnCloseClick(go)
  this:BroadcastGameEvent("ResetGachaTimes")
  WU.RecycleWindow(this)
end

function OnGachaClick(go)
  if not m_gachaData.onOk then
    m_gachaData.onOk = Reset
  end
  S:Get("Gacha").DoGacha(m_gachaDetail, m_gachaData)
end

function OnWindowUninited(window)
  if window.name == "NewActorGet" then
    m_newActorShowing = false
  elseif window.name == "NewArmGet" then
    m_newArmShowing = false
  elseif window.name == "HintArmUpgrade" then
    m_armUpgradeShowing = false
  elseif window.name == "HintArmTransfer" then
    m_armUpgradeShowing = false
  elseif window.name == "Share" then
    REF.root.gameObject:SetActive(true)
  end
end

function UninitWindow()
  this:SetData("DungeonTeamInviteHint/Hide", nil)
  DB:SetData("Share/SelectedActors", nil)
  this:UnregisterGameEvent("UI/WindowUninited", OnWindowUninited)
  CancelRecordVideo()
end

function OnShareClick()
  WU.RecordButtonClick(901)
  this:SetData("ShareConfig", {
    shareName = "GachaResult",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  WU.AcquireWindowAsync("Share", function()
    REF.root.gameObject:SetActive(false)
  end)
end

function OnVideoShareClick()
  local screenOffsetPix, buttomOffsetPix = PU.GetScreenOffsetPix(190)
  local verticalRatio = (screenOffsetPix + buttomOffsetPix) / CS.UnityEngine.Screen.height
  local horizontalRatio = (REF.ButtonVideoShare.transform.localPosition.x + CS.UnityEngine.Screen.width * 0.5) / CS.UnityEngine.Screen.width
  OnGenerateVideoClickImpl(horizontalRatio, verticalRatio)
end

function OnGenerateVideoClickImpl(dialogPositionX, dialogPositionY)
  if PU.IsRecordGachaEnabled() then
    REF.ButtonVideoShare.UIButton.isEnabled = false
    CS.RecordVideoManager.Instance:ClearRecordTime()
    CS.RecordVideoManager.Instance:SetDefaultUploadShareDialogPosition(dialogPositionX, dialogPositionY)
    local data = this:GetData("RecordVideoList")
    if data then
      for i = 1, #data do
        if data[i].isIntro then
          local duration = data[i].endTime - data[i].startTime
          if 4000 < duration then
            data[i].endTime = data[i].startTime + 4000
          end
        elseif data[i].showActorGet then
          local duration = data[i].endTime - data[i].startTime
          if data[i].isOrangeActor then
            if data[i].show91Effect then
              data[i].endTime = data[i].startTime + 5500
            else
              data[i].endTime = data[i].startTime + 3000
            end
          elseif 2000 < duration then
            data[i].endTime = data[i].startTime + 2000
          end
        end
      end
      local noConflictedData = {}
      for i = 1, #data do
        if not data[i].needSkip then
          table.insert(noConflictedData, data[i])
          for j = i + 1, #data do
            if data[i].endTime > data[j].startTime then
              if data[i].endTime >= data[j].endTime then
                data[j].needSkip = true
              else
                data[j].startTime = data[i].endTime
              end
            else
              break
            end
          end
        end
      end
      data = noConflictedData
      local mergedRecordVideoList = {}
      for i = 1, #data do
        if i < #data then
          if data[i].isOrangeActor == data[i + 1].isOrangeActor and data[i].endTime >= data[i + 1].startTime then
            data[i + 1].startTime = data[i].startTime
          else
            table.insert(mergedRecordVideoList, data[i])
          end
        else
          table.insert(mergedRecordVideoList, data[i])
        end
      end
      local startTime = this:GetData("RecordVideoStartTime")
      local highSpeedValue = 4
      local normalSpeedValue = 1
      local totalTime = 0
      for i, v in ipairs(mergedRecordVideoList) do
        totalTime = totalTime + (v.endTime - v.startTime) / fif(v.isOrangeActor, normalSpeedValue, highSpeedValue)
      end
      info("RecordVideo", "Original total time is: " .. totalTime)
      if 9000 <= totalTime then
        local scale = totalTime / 9000
        highSpeedValue = highSpeedValue * scale
        normalSpeedValue = normalSpeedValue * scale
        totalTime = 0
        for i, v in ipairs(mergedRecordVideoList) do
          totalTime = totalTime + (v.endTime - v.startTime) / fif(v.isOrangeActor, normalSpeedValue, highSpeedValue)
        end
        info("RecordVideo", "Scaled total time is: " .. totalTime)
      end
      for i, v in ipairs(mergedRecordVideoList) do
        CS.RecordVideoManager.Instance:AddRecordTime(v.startTime - startTime, v.endTime - startTime, fif(v.isOrangeActor, normalSpeedValue, highSpeedValue))
      end
    end
    local savePath = CS.System.IO.Path.Combine(CS.UnityEngine.Application.persistentDataPath, "gacharecord.aac")
    if CS.System.IO.File.Exists(savePath) then
      CS.RecordVideoManager.Instance:GenerateMomentsVideoWithSpeed(WU.GetString("Platform_RecordVideoGachaTitle"), savePath)
    else
      CO.coroutine_call(function()
        local path = CS.System.IO.Path.Combine(CS.UnityEngine.Application.streamingAssetsPath, "gacharecord.aac")
        CO.yield_return(CS.RecordVideoManager.Instance:CopyFile(path, savePath))
        CS.RecordVideoManager.Instance:GenerateMomentsVideoWithSpeed(WU.GetString("Platform_RecordVideoGachaTitle"), savePath)
      end)()
    end
  end
end

function EndRecordVideo()
  if PU.IsRecordGachaEnabled() then
    local isRecording = CS.RecordVideoManager.Instance:isRecordingMoments()
    if isRecording then
      REF.ButtonVideoShare.gameObject:SetActive(true)
      REF.ButtonVideoShare.UIButton.isEnabled = true
      local recordVideoData = this:GetData("RecordVideoData")
      if recordVideoData then
        recordVideoData.endTime = CS.GameJoy.getSystemCurrentTimeMillis
        local list = this:GetData("RecordVideoList")
        if list == nil then
          list = {}
        end
        table.insert(list, recordVideoData)
        this:SetData("RecordVideoList", list)
        this:SetData("RecordVideoData", nil)
      end
      CS.RecordVideoManager.Instance:EndMomentsRecording(function(status)
        if status == CS.GameJoyAPI.RecordingStartStatus.Fail then
          warning("RecordVideo", "record end fail")
        end
      end)
    end
  end
end

function CancelRecordVideo()
  if PU.IsRecordGachaEnabled() then
    EndRecordVideo()
    CS.RecordVideoManager.Instance:CancelGenerateMomentsVideo()
    CS.RecordVideoManager.Instance:CloseGenerateMomentsVideoDialog()
    CS.RecordVideoManager.Instance:ClearEndMomentsRecordingCallbacks()
  end
end

function ShowShareButton(data)
  if not WU.IsShareSwitchOn() then
    return
  end
  local actorList = {}
  for i = 1, #data do
    local actor = data[i].actor
    if actor then
      local actorConfig = PB.get("ActorConfig", actor.id)
      local item = {
        id = actor.id,
        uid = actor.uid,
        quality = actor.quality,
        config = actorConfig
      }
      table.insert(actorList, item)
    end
  end
  if #actorList < 6 then
    return
  end
  table.sort(actorList, function(a, b)
    if a.quality == b.quality then
      if a.id == b.id then
        return a.uid < b.uid
      else
        return a.id < b.id
      end
    else
      return a.quality > b.quality
    end
  end)
  local d = this:GetData("GachaShareInfo/Base")
  local shareInfo = {
    actorList = actorList,
    gachaId = d.id,
    gachaCount = d.times,
    count = 6
  }
  if shareInfo.gachaId == PB.enum.GachaId.Chips then
    shareInfo.costCount = this:GetData("GachaShareInfo/ChipsCount")
  end
  this:SetData("Share/GachaResult", shareInfo)
  REF.ButtonShare.gameObject:SetActive(true)
end
