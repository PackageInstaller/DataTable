local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local CU = require("Common/ChatUtil")
local U = require("Common/Util")
local HU = require("Common/HtmlUtil")
local DU = require("Common/DungeonUtil")
local TPU = require("Common/TopPvpUtil")
local AU = require("Common/ActorUtil")
local m_level, m_groupId, m_timeElapse, m_activityId, m_dungeonId, m_callback, m_invoke, m_isMatched, m_dunType

function SetupWindow()
end

function InitWindow()
  this:DelayInvokeInSeconds(2.0, function()
    if m_callback then
      m_callback()
    end
  end)
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUnInited)
  CS.UIBaseProcess.Instance:SwitchUICameraProjection(true)
end

function InitData(dungeonType)
  m_dunType = dungeonType
  local data = this:GetData("TopPvpFightActorInfo")
  SetData(data)
end

function OnWindowUnInited(window)
  if window.name == "SceneLoading" then
    WU.DestroyWindow(this)
  end
end

function SetData(data)
  if data == nil then
    return
  end
  for i = 1, 2 do
    if this:GetData("playerId") == data[i].playerId then
      SetPlayerInfo(_ENV["$"](REF.PlayerInfo1), data[i])
    else
      SetPlayerInfo(_ENV["$"](REF.PlayerInfo2), data[i])
    end
  end
end

function SetActor(refHead, data)
  if data and data.id > 0 then
    local actorConfig = PB.get("ActorConfig", data.id)
    if actorConfig then
      refHead.gameObject:SetActive(true)
      refHead.UITexture.mainTexturePath = "Texture/ActorGroup/selectteam_" .. actorConfig.animRes
    else
      refHead.gameObject:SetActive(false)
    end
  else
    refHead.gameObject:SetActive(false)
  end
end

function SetPlayerInfo(ref, data)
  ref.LabelName.UILabel.text = data.name
  local segID
  local score = data.score
  if score == nil then
    score = 0
  end
  local segInfo = TPU.GetCurSegInfo(score)
  if segInfo == nil then
    ref.SpriteLvIcon.gameObject:SetActive(false)
    ref.SpriteSeg.gameObject:SetActive(false)
  elseif segInfo then
    ref.SpriteLvIcon.gameObject:SetActive(true)
    ref.SpriteSeg.gameObject:SetActive(true)
    segID = segInfo.seg
    ref.SpriteLvIcon.UITexture.mainTexturePath = string.format("Texture/PVP/pvp_stage_%d", segID)
    ref.SpriteSeg.UITexture.mainTexturePath = string.format("Texture/PVP/pvp_stage_name_%d", segID)
  end
  for i = 1, 3 do
    local refActorPanel = _ENV["$"](ref[string.format("SpriteGroup%d", i)])
    local headMain = refActorPanel.TextureHeadMain
    local headSub = refActorPanel.TextureHeadSub
    local mainActor = data.actors[i]
    local subActor = data.actors[3 + i]
    SetActor(headMain, mainActor)
    SetActor(headSub, subActor)
    local a1 = 0
    if mainActor and 0 < mainActor.id then
      a1 = AU.GetActorCultivationDegree(mainActor)
    end
    local a2 = 0
    if subActor and 0 < subActor.id then
      a2 = AU.GetActorCultivationDegree(subActor)
    end
    refActorPanel.LabelPractice.gameObject:SetActive(false)
  end
end

function SetCallback(call)
  m_callback = call
end
