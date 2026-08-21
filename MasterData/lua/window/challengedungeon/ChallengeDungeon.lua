local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local RU = require("Common/RedMarkUtil")
local m_chapterId

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonEntry, function()
    WU.RecordButtonClick("167" .. m_chapterId .. "1")
    this:SetData("ChapterRewardDefaultSelectChapter", this:GetData("WindowDungeon/ChapterId"))
    WU.AcquireWindowAsync("ChallengeRewardListAll", function(win)
      _ENV["$"](win)["$$SetFrom"]("ChallengeDungeon")
    end)
  end)
end

function InitWindow()
  this:Bind("WindowDungeon/ChapterId", OnChapterChooseChange)
  REF.LabelTotalStar.UILabel.text = ""
  this:Bind("fci/dungeon/chapter-summary", OnChapterSummaryChanged)
  RU.BindRedMark(this, string.format("Activity/%s", PB.enum.ActivityType.ChallengeMode), OnRedMarkChange)
end

function OnChapterChooseChange(chapterId)
  if m_chapterId ~= chapterId then
    if m_chapterId then
      this:Unbind("fci/dungeon/chapter/" .. m_chapterId, OnGetChapterInfo)
    end
    m_chapterId = chapterId
    if m_chapterId then
      this:Bind("fci/dungeon/chapter/" .. m_chapterId, OnGetChapterInfo)
    end
    WU.SetNaviationBackCallback(function()
      WU.RecordButtonClick("167" .. m_chapterId .. "5")
      _ENV["$"](WU.FindWindow("Navigation"))["$$Back"]()
    end)
    WU.SetNaviationHomeCallback(function()
      WU.RecordButtonClick("167" .. m_chapterId .. "6")
      _ENV["$"](WU.FindWindow("Navigation"))["$$Home"]()
    end)
  end
end

function OnGetChapterInfo(chapterInfo)
  if chapterInfo then
    local recordDungeonsArray = {}
    for k, v in pairs(chapterInfo.recordDungeons) do
      table.insert(recordDungeonsArray, v)
    end
    table.sort(recordDungeonsArray, function(a, b)
      return a.dungeonId < b.dungeonId
    end)
    for i = 0, #REF.Dungeons - 1 do
      local dungeonRef = REF.Dungeons[i]
      local isActive = i < #recordDungeonsArray
      dungeonRef["$gameObject"]:SetActive(isActive)
      if isActive then
        dungeonRef["$$SetData"](recordDungeonsArray[i + 1], m_chapterId)
      end
    end
    REF.Dungeons.UIGrid:Reposition()
  end
end

function OnChapterSummaryChanged(chapterSummary)
  if chapterSummary then
    REF.LabelTotalStar.UILabel.text = chapterSummary.totalChallengeStar
  end
end

function OnRedMarkChange(flag)
  WU.SetActive(_ENV["$"](REF.ChapterRewardEntry).Effect, flag)
  WU.SetActive(REF.SpriteRed, flag)
end

function Focus(on)
  WU.RecordWindowFocus(100167, on)
end
