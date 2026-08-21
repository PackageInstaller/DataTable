local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local RU = require("Common/RedMarkUtil")
local m_duringTime = 2
local m_plateMaxNum = 8
local m_pos = {
  [1] = {
    scale = 1,
    x = {0},
    y = {0}
  },
  [2] = {
    scale = 1,
    x = {-155, 155},
    y = {0, 0}
  },
  [3] = {
    scale = 1,
    x = {
      -270,
      0,
      270
    },
    y = {
      -40,
      80,
      -40
    }
  },
  [4] = {
    scale = 1,
    x = {
      -340,
      -135,
      135,
      340
    },
    y = {
      -90,
      75,
      75,
      -90
    }
  },
  [5] = {
    scale = 1,
    x = {
      -340,
      -135,
      135,
      340,
      0
    },
    y = {
      -70,
      110,
      110,
      -70,
      -135
    }
  },
  [6] = {
    scale = 0.8,
    x = {
      -325,
      -120,
      120,
      325,
      -120,
      120
    },
    y = {
      0,
      135,
      135,
      0,
      -120,
      -120
    }
  },
  [7] = {
    scale = 0.8,
    x = {
      -325,
      -120,
      120,
      325,
      -220,
      0,
      220
    },
    y = {
      50,
      135,
      135,
      50,
      -160,
      -80,
      -160
    }
  },
  [8] = {
    scale = 0.8,
    x = {
      -360,
      -120,
      120,
      360,
      -360,
      -120,
      120,
      360
    },
    y = {
      50,
      170,
      170,
      50,
      -200,
      -100,
      -100,
      -200
    }
  }
}
local m_cuisines, m_chefs, m_curChef, m_beginTime, m_postingNow, m_selectedFoods, m_tempLevel, m_tempExp, m_isInit, m_curPlateCount, m_leftPos, m_rightPos, m_canClick
local m_moveTime = 1
local m_remainMoveTime, m_oldPos

function SetupWindow()
  WU.BindButtonEvent(REF.BtnActor, OnBtnChefClick)
  WU.BindButtonEvent(REF.BtnProduction, OnBtnProductionClick)
  WU.BindButtonEvent(REF.BtnResearch, OnBtnResearchClick)
  WU.TraverseChildren(REF.NodePlates, function(go)
    WU.BindButtonEvent(_ENV["$"](go).root, OnPlateClick)
  end)
  WU.BindButtonEvent(REF.BtnPrizePreview, OnBtnPrizePreviewClick)
end

function InitWindow()
  m_leftPos = REF.DropPointLeft.transform.position
  m_rightPos = REF.DropPointRight.transform.position
  m_isInit = true
  m_canClick = true
  m_beginTime = nil
  m_remainMoveTime = nil
  ResetPutInfo()
  this:Bind("NavigationContext", OnTopMostWindow)
  this:RegisterGameEvent("HotPot/CuisineDropIntoPot", OnCuisineDropIntoPot)
  this:RegisterGameEvent("HotPot/ChefChange", OnChefChange)
  WU.ToggleRendering(REF.BoardSpeechText, false)
  REF.SpriteActor["$SetSpeechMode"](1)
  REF.SpriteActor["$SetAutoPlay"](false)
  ManagerRedPoint()
  WU.SetActive(REF.SpriteTemp, false)
  WU.SetActive(REF.EmoteActor, false)
  WU.SetActive(REF.NodePlates, false)
  WU.SetActive(REF.NodeLevel, false)
  this:BindRemote(DB:GameRequest("fci/cooking-summary/"), OnHotPotInfoChange)
end

function UninitWindow()
  this:UnregisterGameEvent("HotPot/CuisineDropIntoPot", OnCuisineDropIntoPot)
  this:UnregisterGameEvent("HotPot/ChefChange", OnChefChange)
end

function OnTopMostWindow(windowName)
  if windowName ~= this.name then
    return
  end
  if m_cuisines == nil then
    return
  end
  local newCount = #m_cuisines
  if m_curPlateCount and newCount > m_curPlateCount then
    for i = m_curPlateCount + 1, newCount do
      local ref = REF.NodePlates[i - 1]
      ref["$$DoAppearEffect"]()
    end
    m_curPlateCount = newCount
  end
  REF.SpriteActorRoot.gameObject:SetActive(true)
  REF.SpriteActor["$PlayRandomAnimation"](true, false)
end

function Focus(on)
  REF.SpriteActorRoot.gameObject:SetActive(on)
  if on == false then
    REF.SpriteActor["$StopAnimation"]()
  end
end

function UpdateWindow(delta)
  if m_remainMoveTime then
    m_remainMoveTime = m_remainMoveTime - delta
    if m_remainMoveTime < 0 then
      m_remainMoveTime = nil
      m_oldPos = _ENV["!"]({})
      SetDining()
    else
      local count = #m_oldPos
      local newPos = m_pos[count]
      local lerpVal = 1 - m_remainMoveTime / m_moveTime
      for i = 1, count do
        local ref = m_oldPos[i]
        local oldPos = ref["$transform"].localPosition
        local oldScale = ref["$transform"].localScale.x
        local x = CS.UnityEngine.Mathf.Lerp(oldPos.x, newPos.x[i], lerpVal)
        local y = CS.UnityEngine.Mathf.Lerp(oldPos.y, newPos.y[i], lerpVal)
        local scale = CS.UnityEngine.Mathf.Lerp(oldScale, newPos.scale, lerpVal)
        local to = CS.UnityEngine.Vector3(x, y, 0)
        ref["$transform"].localPosition = to
        ref["$transform"].localScale = CS.UnityEngine.Vector3(scale, scale, 0)
      end
    end
  end
  if m_cuisines == nil then
    return
  end
  if m_postingNow or m_beginTime == nil then
    return
  end
  local now = CS.GameTime.serverUtc
  local during = now - m_beginTime
  if during > m_duringTime then
    DoPutInPot(0)
  end
end

function OnHotPotInfoChange(data)
  if data == nil then
    return
  end
  m_chefs = data.roleProgressDetails
  if data.currentRoleId == nil or data.currentRoleId == 0 then
    data.currentRoleId = 1
  end
  m_cuisines = data.placedFoods or _ENV["!"]({})
  HandleChefsInfo(data.currentRoleId)
  if m_isInit then
    SetChef(true)
    m_isInit = false
  end
  SetDining()
end

function OnChefChange(roleId)
  m_curChef = m_chefs[roleId]
  SetChef(true)
end

function HandleChefsInfo(curRoleId)
  if m_chefs == nil then
    return
  end
  for roleId, chef in pairs(m_chefs) do
    chef.isMax = IsChefMaxLevel(chef)
    chef.roleConfig = PB.get("Role", chef.roleId)
  end
  m_curChef = m_chefs[curRoleId]
end

function SetChef(isInit)
  if m_chefs == nil then
    return
  end
  if m_curChef == nil then
    return
  end
  if m_curChef.isMax then
    REF.LabelLevel.UILabel.text = WU.GetString("Window_Level", "Max")
    REF.LabelLevelTemp.UILabel.text = WU.GetString("Window_Level", "Max")
    REF.LabelProgress.UILabel.text = ""
    REF.SpriteProgress.UIProgressBar.value = 1
  else
    REF.LabelLevel.UILabel.text = WU.GetString("Window_Level", m_curChef.level)
    REF.LabelLevelTemp.UILabel.text = WU.GetString("Window_Level", m_curChef.level)
    local levelConfig = PB.get("RoleCookingInfo", m_curChef.roleId, m_curChef.level)
    REF.LabelProgress.UILabel.text = WU.GetString("Window_TowerReward2", m_curChef.exp, levelConfig.exp)
    REF.SpriteProgress.UIProgressBar.value = m_curChef.exp * 1.0 / levelConfig.exp
  end
  WU.SetActive(REF.SpriteTemp, false)
  WU.SetActive(REF.NodeLevel, true)
  if isInit then
    SetActorEmote()
  end
  if m_curChef.isMax then
    local _, v = table.find(m_chefs, function(k1, v1)
      return v1.isMax ~= true
    end)
    WU.SetActive(_ENV["$"](REF.BtnActor).SpriteRed, v)
  else
    WU.SetActive(_ENV["$"](REF.BtnActor).SpriteRed, false)
  end
end

function SetDining()
  local amount = #m_cuisines
  local posConfig = m_pos[amount]
  for i = 0, #REF.NodePlates - 1 do
    local index = i + 1
    local ref = REF.NodePlates[i]
    WU.SetActive(ref.root, amount >= index)
    if amount >= index then
      local cuisine = m_cuisines[index]
      cuisine.index = index
      ref.root.transform.localPosition = {
        x = posConfig.x[index],
        y = posConfig.y[index],
        z = 0
      }
      ref.root.transform.localScale = {
        x = posConfig.scale,
        y = posConfig.scale,
        z = 1
      }
      ref["$$SetItem"](cuisine)
      ref["@cuisine"] = cuisine
    else
      ref["@cuisine"] = nil
    end
  end
  WU.SetActive(REF.NodePlates, true)
end

function SetTempProgressView(toMax)
  WU.SetActive(REF.SpriteTemp, true)
  local oldLevel = REF.LabelLevel.UILabel.text
  if toMax then
    REF.LabelLevel.UILabel.text = WU.GetString("Window_Level", "Max")
    REF.LabelLevelTemp.UILabel.text = WU.GetString("Window_Level", "Max")
    REF.SpriteTemp.UISprite.fillAmount = 1
    REF.LabelProgress.UILabel.text = ""
  else
    REF.LabelLevel.UILabel.text = WU.GetString("Window_Level", m_tempLevel)
    REF.LabelLevelTemp.UILabel.text = WU.GetString("Window_Level", m_tempLevel)
    local levelConfig = PB.get("RoleCookingInfo", m_curChef.roleId, m_tempLevel)
    REF.LabelProgress.UILabel.text = WU.GetString("Window_TowerReward2", m_tempExp, levelConfig.exp)
    REF.SpriteTemp.UISprite.fillAmount = m_tempExp * 1.0 / levelConfig.exp
    if m_tempLevel ~= m_curChef.level then
      REF.SpriteProgress.UIProgressBar.value = 0
    end
  end
  local nowLevel = REF.LabelLevel.UILabel.text
  if oldLevel ~= nowLevel then
    ShowLevelLabelEffect()
  end
end

function OnBtnChefClick()
  WU.AcquireWindowAsync("HotPotChefChange")
end

function OnBtnProductionClick()
  if #m_cuisines >= m_plateMaxNum then
    WU.ShowHintText(WU.GetString("HotPot_TableFull"))
    return
  end
  m_curPlateCount = #m_cuisines
  WU.AcquireWindowAsync("HotPotProduction")
end

function OnBtnResearchClick()
  m_curPlateCount = #m_cuisines
  WU.AcquireWindowAsync("HotPotResearch")
end

function OnBtnPrizePreviewClick(go)
  WU.AcquireWindowAsync("PrizePreview", function(window)
    _ENV["$"](window)["$$SetPrizePreview"]("HotPotDining", {
      roleId = m_curChef.roleId,
      playerRecord = m_curChef.level,
      xlsxFilter = {
        [1] = {
          key = "roleId",
          value = m_curChef.roleId
        }
      }
    })
  end)
end

function OnPlateClick(go)
  if not (not m_postingNow and m_canClick) or m_remainMoveTime then
    return
  end
  local cuisine = _ENV["$"](go)["@cuisine"]
  local _, v = table.find(m_selectedFoods, function(k1, v1)
    return v1.id == cuisine.id
  end)
  if v then
    return
  end
  if m_curChef.isMax then
    local _, chef = table.find(m_chefs, function(k1, v1)
      return v1.isMax ~= true
    end)
    if chef then
      WU.ShowHintText(WU.GetString("HotPot_ChefExpIsMax"))
      return
    else
      RecordFoodsPutInPot(go, true)
    end
  else
    RecordFoodsPutInPot(go)
  end
end

function RecordFoodsPutInPot(go, allMax)
  local ref = _ENV["$"](go)
  local cuisine = ref["@cuisine"]
  if m_beginTime == nil then
    m_tempLevel = m_curChef.level
    m_tempExp = m_curChef.exp
  end
  m_beginTime = CS.GameTime.serverUtc
  local data = this:GetData("fci/cooking-summary/")
  if allMax then
    table.insert(m_selectedFoods, {
      id = cuisine.id,
      type = 11,
      count = cuisine.count
    })
    ref["$$DoPutIntoPot"](GetDropPos(ref))
    DoDropEffect()
  else
    local canToMax, realCount = IsCuisineCanToMax(cuisine)
    table.insert(m_selectedFoods, {
      id = cuisine.id,
      type = 11,
      count = realCount
    })
    SetTempProgressView(canToMax)
    if cuisine.count == realCount then
      ref["$$DoPutIntoPot"](GetDropPos(ref))
      DoDropEffect()
    else
      ref["$$DoPutIntoPot"](GetDropPos(ref), cuisine.count - realCount)
      DoDropEffect()
    end
    if canToMax then
      DoPutInPot(m_duringTime)
    elseif #m_selectedFoods == #m_cuisines then
      DoPutInPot(m_duringTime)
    end
  end
end

function IsCuisineCanToMax(cuisine)
  local cuisineConfig = PB.get("ItemInfo", cuisine.id)
  local expPer = cuisineConfig.param[2]
  local cuisineAmountExp = expPer * cuisine.count
  local costExp = 0
  local levelInfo = PB.get("RoleCookingInfo", m_curChef.roleId, m_tempLevel)
  while levelInfo ~= nil do
    local toNextLevelExp = levelInfo.exp
    local upgradeNeedExp = toNextLevelExp - m_tempExp
    if cuisineAmountExp >= costExp + upgradeNeedExp then
      costExp = costExp + upgradeNeedExp
      m_tempLevel = m_tempLevel + 1
      m_tempExp = 0
    else
      m_tempExp = m_tempExp + cuisineAmountExp - costExp
      costExp = cuisineAmountExp
      break
    end
    levelInfo = PB.get("RoleCookingInfo", m_curChef.roleId, m_tempLevel)
  end
  local count = math.ceil(costExp / expPer)
  return levelInfo == nil, count
end

function DoPutInPot(time)
  m_postingNow = true
  this:DelayInvokeInSeconds(time, function()
    local path = "fci/cooking-feed/" .. m_curChef.roleId
    this:GameRequest(path):Post({foods = m_selectedFoods}, function(res)
      if res then
        local alreadyMax = m_curChef.isMax
        local oldLevel = m_curChef.level
        m_curChef.level = res.roleInfo.level
        m_curChef.exp = res.roleInfo.exp
        m_curChef.rewardGot = res.roleInfo.rewardGot
        if not m_curChef.isMax then
          m_curChef.isMax = IsChefMaxLevel(m_curChef)
        end
        local data = this:GetData("fci/cooking-summary/")
        data.placedFoods = res.placedFoods or _ENV["!"]({})
        m_cuisines = data.placedFoods
        SetChef()
        if 0 < #m_cuisines then
          DoMovePlate()
        else
          SetDining()
        end
        DBH.ResChange(res.resChange)
        if alreadyMax then
          WU.ShowRewards(res.resChange)
        else
          WU.ShowRewards(res.resChange, PlayBAnimation, nil, nil, true, "HotPotLevelUp", {
            [1] = oldLevel,
            [2] = m_curChef.level
          })
        end
        ResetPutInfo()
        RU.SetRedMark("Welfare/ChineseNewYear/HotPot/EatFirst", false)
        WU.RecordFirstTimeInClient("Welfare2019CNYHotPotEat")
      end
    end)
  end)
end

function IsChefMaxLevel(chef)
  local maxLevel = PB.all("Misc"):first().maxCookingRoleLevel
  return chef.level == maxLevel
end

function ResetPutInfo()
  m_beginTime = nil
  m_selectedFoods = {}
  m_postingNow = false
  m_tempLevel = 0
  m_tempExp = 0
end

function PutInPotEffect(ref, remainCount)
  WU.SetActive(ref.Content, false)
  ref.EffectEat.EffectGenerator:Reset()
  ref.EffectEat.EffectGenerator:Play(function()
    if remainCount then
      ref.LabelCount.UILabel.text = remainCount
      ref.EffectAppear.EffectGenerator:Reset()
      ref.EffectAppear.EffectGenerator:Play(function()
        WU.SetActive(ref.Content, true)
      end)
    else
      WU.SetActive(ref.root, false)
      WU.SetActive(ref.Content, true)
    end
  end)
  REF.EffectHigh.EffectGenerator:Reset()
  REF.EffectHigh.EffectGenerator:Play()
end

function OnCuisineDropIntoPot()
  REF.EffectHigh.EffectGenerator:Reset()
  REF.EffectHigh.EffectGenerator:Play()
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Put_Food")
end

function GetDropPos(ref)
  local a = math.random(1, 2)
  if a == 1 then
    return ref["$transform"]:InverseTransformPoint(m_leftPos)
  else
    return ref["$transform"]:InverseTransformPoint(m_rightPos)
  end
end

function ManagerRedPoint()
  RU.BindRedMark(this, "Welfare/ChineseNewYear/HotPot/Research/", function(flag)
    WU.SetActive(_ENV["$"](REF.BtnResearch).SpriteRed, flag)
  end)
  RU.BindRedMark(this, "Welfare/ChineseNewYear/HotPot/CookFirst", function(flag)
    WU.SetActive(_ENV["$"](REF.BtnProduction).SpriteRed, flag)
  end)
end

function ShowLevelLabelEffect()
  REF.LabelLevel.TweenScale:ResetToBeginning()
  REF.LabelLevelTemp.TweenScale:ResetToBeginning()
  REF.LabelLevelTemp.TweenAlpha:ResetToBeginning()
  REF.LabelLevel.TweenScale:PlayForward()
  REF.LabelLevelTemp.TweenScale:PlayForward()
  REF.LabelLevelTemp.TweenAlpha:PlayForward()
end

function SetActorEmote()
  WU.SetActive(REF.EmoteActor, true)
  local emoteActorId = PB.get("RoleCookingInfo", m_curChef.roleId, 1).emoteActorId
  local boardActorConfig = PB.get("BoardActorConfig", emoteActorId)
  if boardActorConfig == nil then
    warning("Hot pot chef roleId:" .. emoteActorId .. "lack of emote")
    return
  end
  this:DelayInvokeInFrames(1, function()
    REF.SpriteActor["$SetBoardActorConfig"](boardActorConfig, true)
    REF.SpriteActor["$PlayRandomAnimation"](true, false)
    this:DelayInvokeInFrames(1, function()
      REF.SpriteActor["$OnGamePreferencesChanged"]()
    end)
    REF["$UILuaWindow"]:PlayUITweener()
  end)
end

function PlayBAnimation()
  REF.SpriteActor["$PlayIdleAnimation"]()
end

function DoDropEffect()
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_OK")
end

function DoMovePlate()
  m_oldPos = _ENV["!"]({})
  local count = 0
  for i = 0, #REF.NodePlates - 1 do
    local ref = REF.NodePlates[i]
    if ref["$gameObject"].activeSelf then
      table.insert(m_oldPos, ref)
    end
  end
  m_remainMoveTime = m_moveTime
end
