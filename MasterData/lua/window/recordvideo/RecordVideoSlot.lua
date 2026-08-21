local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local GU = require("Common/GuildUtil")
local AU = require("Common/ActorUtil")
local SE = require("Common/SkillEffect")
local m_check = {}
local m_index = 0

function Start()
  local cnt = 1
  while true do
    local ref = REF[string.format("SpriteCheck%d", cnt)]
    if ref == nil then
      break
    end
    m_check[cnt] = false
    cnt = cnt + 1
  end
  UpdateCheck()
end

function UpdateCheck()
  local cnt = 1
  while true do
    local ref = REF[string.format("SpriteCheck%d", cnt)]
    local bCheck = m_check[cnt]
    if ref then
      if bCheck then
        ref.UISprite.spriteName = "checkbox2_s"
      else
        ref.UISprite.spriteName = "checkbox2_n"
      end
    else
      break
    end
    cnt = cnt + 1
  end
end

function SetUI(refPanel, data, index)
  refPanel.TextureMain.UITexture.mainTexturePath = "Texture/ActorInfightHead/main/" .. string.format("infight_head_%da", data.mainActorId)
  if data.subActorId then
    refPanel.TextureSub.UITexture.mainTexturePath = "Texture/ActorInfightHead/sub/" .. string.format("infight_head_%da", data.subActorId)
    refPanel.TextureSub.gameObject:SetActive(true)
  else
    refPanel.TextureSub.gameObject:SetActive(false)
  end
  if data.linkId == nil then
    local actorConfig = PB.get("ActorConfig", data.mainActorId)
    local actorCombo = PB.get("ActorCombo", data.mainActorId, 0, data.useIndex or 1)
    local actorSkill = PB.get("ActorSkill", actorCombo.skillList[1])
    refPanel.LabelName.UILabel.text = WU.GetString("SkillName_" .. actorCombo.skillList[1])
    refPanel.TextureSkill.UITexture.mainTexturePath = SE.GetSkillTexturePath(actorSkill, actorConfig.id)
  else
    refPanel.TextureSkill.UITexture.mainTexturePath = "Texture/ActorRelationSkill/actor_relation_" .. data.linkId
    refPanel.LabelName.UILabel.text = WU.GetString("Window_ActorLinkName_" .. data.linkId)
  end
  WU.BindButtonEvent(refPanel.SpriteBg, function()
    m_check[index] = not m_check[index]
    data.check = m_check[index]
    this:BroadcastGameEvent("SelectVideo", m_check[index])
    UpdateCheck()
  end)
  local startTime = this:GetData("RecordVideoStartTime")
  local videoTime = math.ceil((data.endTime - data.startTime) / 1000)
  local strVideoTime = string.format("%d", videoTime)
  refPanel.LabelTime.UILabel.text = WU.GetString("LocalVideo_VideoTime", strVideoTime)
end

function SetData(data, index)
  if data == nil then
    return
  end
  REF.RoundWinPanel.gameObject:SetActive(false)
  REF.RoundFaildPanel.gameObject:SetActive(false)
  local isWin = true
  local result = this:GetData("DungeonBalance/result")
  local fightDungeonType = this:GetData("FightDungeonType")
  if fightDungeonType == PB.enum.DungeonType.AsyncPvp then
    isWin = result.balanceInfo.win
  elseif fightDungeonType == PB.enum.DungeonType.AsyncPvpV2 then
    isWin = result.balanceInfo.win
  elseif fightDungeonType == PB.enum.DungeonType.BurstLinkPvp then
    isWin = result.isWin
  else
    isWin = result.win
  end
  if data.isLast then
    if isWin then
      REF.RoundWinPanel.gameObject:SetActive(true)
    else
      REF.RoundFaildPanel.gameObject:SetActive(true)
    end
  end
  REF.LabelRound.UILabel.text = tostring(data.round)
  m_index = index
  for i = 1, 3 do
    local ref = REF[string.format("Panel%d", i)]
    local recordData = data.recordData[i]
    if recordData then
      ref.gameObject:SetActive(true)
      SetUI(_ENV["$"](ref), recordData, i)
    else
      ref.gameObject:SetActive(false)
    end
  end
  REF.Container.UIGrid:Reposition()
end
