local BASE = inherit("Window/DungeonPrepareBase/DungeonPrepareBase", _ENV)
local PB = require("Common/PbHelper")
local WU, DB, REF = require("Common/WindowUtil")(this)
local m_chapterId, m_dungeonId, m_reward, m_record

function SetupWindow()
  BASE.BindDrop()
  WU.BindButtonEvent(REF.ButtonFight, function()
    BASE.ButtonFightClick(m_dungeonId, m_chapterId)
  end)
end

function InitWindow()
  this:RegisterGameEvent("SetDungeonPrepareFightButton", function(dungeonType, dungeonRecord)
    if dungeonType == PB.enum.DungeonType.Training then
      REF.Label1.UIHtmlLabel.text = WU.GetString("Training_dungone_play")
    elseif dungeonType == PB.enum.DungeonType.Challenge then
      REF.Label1.UIHtmlLabel.text = WU.GetString("ChallengeDungeonPlay")
    end
    WU.ToggleRendering(REF.SpritePassed, dungeonRecord.finished)
  end)
  BASE.SetCustom({
    nil,
    nil,
    true
  })
  this:Bind("DungeonPrepare/ChapterId", OnChapterIdChanged)
end

function OnChapterIdChanged(chapterId)
  if m_chapterId ~= nil then
    this:Unbind("fci/dungeon/chapter/" .. m_chapterId, OnChapterChanged)
  end
  m_chapterId = chapterId
  this:Bind("fci/dungeon/chapter/" .. m_chapterId, OnChapterChanged)
end

function OnChapterChanged(chapter)
  m_dungeonId = this:GetData("DungeonPrepare/DungeonId")
  m_reward = PB.get("DungeonReward", m_dungeonId)
  m_record = chapter.recordDungeons[m_dungeonId]
  local showReceiveTip = m_record and not m_record.new
  BASE.SetCustom({showReceivedTip = showReceiveTip})
  BASE.SetDrop(m_reward, m_reward.dropDisplay)
  BASE.ShowAffixList(m_dungeonId)
  BASE.SetDungeonInfo(m_dungeonId, m_chapterId, m_record)
end
