local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("common/HtmlUtil")
local m_chapterId = 0

function Awake()
  WU.BindButtonEvent(REF.TextureBg, OnBtnChapter)
end

function Start()
end

function OnBtnChapter()
  local chapterSummary = this:GetData("fci/dungeon/chapter-summary")
  local chapterInfo = PB.get("ChapterInfo", m_chapterId)
  if chapterInfo == nil then
    return
  end
  local storyInfo = PB.get("ChapterInfo", chapterInfo.storyChapterId)
  local chapterId = chapterInfo.preChapterId
  if storyInfo then
    chapterId = storyInfo.preChapterId
  end
  local unlockTips
  if 0 < chapterId and not DU.IsChapterFinished(chapterSummary, chapterId) then
    unlockTips = WU.GetString("Window_ChapterUnlockPreChapterLimit", WU.GetString("ChapterName_" .. chapterId))
  elseif chapterInfo.preChapterStar > chapterSummary.totalNormalStar and not DU.IsChapterUnlocked(chapterSummary, m_chapterId) then
    unlockTips = WU.GetString("Window_ChapterUnlockStarLimit", chapterInfo.preChapterStar - chapterSummary.totalNormalStar)
  end
  if unlockTips then
    WU.ShowHintText(unlockTips)
    return
  end
  local index = chapterInfo.chapterIndex
  this:BroadcastGameEvent("ChapterPageTo", index)
  local attachedWindow = REF["$"]:queryParent("UILuaWindow")
  if attachedWindow ~= nil then
    WU.RecycleWindow(attachedWindow)
  end
end

function SetData(data)
  local chapterId = data.chapterId
  m_chapterId = chapterId
  REF.TextureBg.UITexture.mainTexturePath = string.format("Texture/ChapterList/ChapterIcon_%d", chapterId)
  local chapterSummary = this:GetData("fci/dungeon/chapter-summary")
  local isUnlock = false
  if chapterSummary then
    isUnlock = DU.IsChapterUnlocked(chapterSummary, chapterId)
  end
  REF.TextureBg.UITexture.graify = not isUnlock
  local finishedCnt = 0
  this:Bind("fci/dungeon/chapter/" .. chapterId, OnChapterChanged)
end

function OnChapterChanged(chapter)
  if chapter == nil then
    REF.LabelProcess.UILabel.text = WU.GetString("NewChapterTips1", 0)
    return
  end
  local chapterInfo = PB.get("ChapterInfo", m_chapterId)
  local count = 0
  for k, dungeonRecord in pairs(chapter.recordDungeons) do
    count = count + #dungeonRecord.targetsDone
  end
  local totalStar = 0
  if chapterInfo then
    for i, v in ipairs(chapterInfo.dungeonId) do
      local dungeonReward = PB.get("DungeonReward", v)
      if dungeonReward then
        totalStar = totalStar + #dungeonReward.target
      end
    end
  end
  if totalStar == 0 then
    local pro = math.floor(count / totalStar * 100)
    REF.LabelProcess.UILabel.text = WU.GetString("NewChapterTips1", 0)
  else
    local pro = math.floor(count / totalStar * 100)
    REF.LabelProcess.UILabel.text = WU.GetString("NewChapterTips1", pro)
  end
end
