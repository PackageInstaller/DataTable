local base = inherit("Window/ChapterNormal/WidgetDungeonBaseSlot", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local U = require("Common/Util")
local S = require("Common/Singleton")
local DU = require("Common/DungeonUtil")
local m_dunId = 0

function Awake()
  WU.BindButtonEvent(REF["$"], function()
    if not DU.IsWaitingForJob(OnDungeonClick) then
      OnDungeonClick()
    end
  end)
end

function SetStatus(dungeonRecord)
  base.SetIcon(dungeonRecord)
  local label = WU.GetString("DungeonName_" .. m_dunId)
  REF.DungeonLabel.UIHtmlLabel.text = label
end

function SetData(data)
  _SetData(data)
  local chapter = data.chapter
  local dungeonRef = REF
  local dungeonButton = dungeonRef["$gameObject"]
  local dungeonId = data.dungeonId
  m_dunId = dungeonId
  m_normalChapterId = data.normalChapterId
  local dungeonRecord = chapter.recordDungeons[dungeonId]
  local sprites = dungeonButton:GetComponentsInChildren(typeof(CS.UISprite), true)
  for s = 0, sprites.Length - 1 do
    if not string.find(sprites[s].name, "Star") and not string.find(sprites[s].name, "RoadSprite") then
      sprites[s].graify = not dungeonRecord or not dungeonRecord.unlocked
    end
  end
  local rewardInfo = PB.get("DungeonReward", dungeonId)
  if rewardInfo.displayType == 1 then
    REF.Sprite.UISprite.spriteName = "accident_title"
  elseif rewardInfo.displayType == 2 then
    REF.Sprite.UISprite.spriteName = "light_title"
  else
    REF.Sprite.UISprite.spriteName = "story_title"
  end
  SetStatus(dungeonRecord)
end

function OnDungeonClick(go)
  local chapterId = base.GetChapterId()
  local chapter = this:GetData("fci/dungeon/chapter/" .. chapterId)
  if chapter then
    local dungeonId = base.GetDunId()
    local dungeonRecord = chapter.recordDungeons[dungeonId]
    local isUnlock, strTime = DU._IsDungeonUnlock(dungeonRecord)
    if dungeonRecord and isUnlock then
      if not dungeonRecord.finished or not dungeonRecord.onlyOnce then
        this:SetData("WindowDungeon/DungeonId", dungeonId)
        this:SetData("WindowDungeon/ChapterId", chapterId)
        this:SetData("DungeonPrepare/ChapterId", chapterId)
        this:SetData("DungeonPrepare/DungeonId", dungeonId)
        local rewardInfo = PB.get("DungeonReward", dungeonId)
        this:BroadcastGameEvent("SaveChapterPos", m_normalChapterId)
        if rewardInfo.notFight == 1 then
          local playMovie
          if dungeonId == 5301 then
            playMovie = "gearsoffate"
          elseif dungeonId == 5302 then
            playMovie = "fallinlove"
          elseif dungeonId == 5303 then
            playMovie = "seek"
          end
          if playMovie then
            WU.PlayMovie(playMovie)
          else
            local cartoon = WU.GetCartoonInfo(chapterId, dungeonId, 0)
            local cartoon_id = 0
            if cartoon ~= nil then
              cartoon_id = cartoon.id
            end
            WU.EnterStoryDungeon(dungeonId, nil, cartoon_id, PB.enum.DungeonType.Story)
          end
        else
          local curTutorial = this:GetData("CurrentTutorial")
          local tutorialLevel = this:GetData("TutorialLevel13")
          if curTutorial then
            if dungeonId == 2011 and curTutorial == 21 or dungeonId == 2012 and curTutorial == 22 then
              WU.EnterStoryDungeon(dungeonId, nil, nil, PB.enum.DungeonType.Story)
            elseif dungeonId == 2013 and (curTutorial == 23 or tutorialLevel) then
              WU.EnterTutorialStoryDungeon()
            elseif dungeonId == 2013 and curTutorial == 27 then
              WU.EnterStoryDungeon(dungeonId, nil, nil, PB.enum.DungeonType.Story)
            else
              WU.AcquireWindowAsync("DungeonStory")
            end
          else
            WU.AcquireWindowAsync("DungeonStory")
          end
        end
      else
        WU.ShowHintText(WU.GetString("Error_OneTimeDungeon"))
      end
    elseif strTime then
      WU.ShowHintText(WU.GetString("Window_DungeonOpenTime3", strTime))
    else
      WU.ShowHintText(WU.GetString("Error_DungeonLocked"))
    end
  end
end
