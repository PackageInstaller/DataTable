local WU, DB, REF = require("Common/WindowUtil")(this)
local RU = require("Common/RedMarkUtil")
local NU = require("Common/NotepadUtil")

function SetupWindow()
  WU.BindButtonEvent(REF.Achievement, OnAchievementClick)
  WU.BindButtonEvent(REF.Medal, OnMedalClick)
  WU.BindButtonEvent(REF.ActorCollections, OnActorClick)
  WU.BindButtonEvent(REF.Equip, OnEquipClick)
  WU.BindButtonEvent(REF.Book, OnBookClick)
  WU.BindButtonEvent(REF.Story, OnStoryClick)
  WU.BindButtonEvent(REF.Scene, OnSceneClick)
end

function InitWindow()
  this:Bind("fci/medal/", OnMedalChange)
  RU.BindRedMark(this, "Journey/Achievement", function(flag)
    _ENV["$"](REF.Achievement).SpriteRedMark.gameObject:SetActive(flag)
  end)
  RU.BindRedMark(this, "Journey/Medal", function(flag)
    _ENV["$"](REF.Medal).SpriteRedMark.gameObject:SetActive(flag)
  end)
  RU.BindRedMark(this, "Journey/CollectionsNovel", function(flag)
    _ENV["$"](REF.Book).SpriteRedMark.gameObject:SetActive(flag)
  end)
  if not this:GetData("CollectionsNovel/clean") then
    this:GameRequest("fci/CollectionsNovel"):Get(function(data)
      this:SetData("fci/CollectionsNovel", data)
      for i = 1, #data.novels do
        RU.SetRedMark("Journey/CollectionsNovel/" .. data.novels[i].novelId, data.novels[i].canGetReward)
      end
      this:SetData("CollectionsNovel/clean", true)
    end)
  end
end

function OnAchievementClick()
  WU.RecordButtonClick(100136004)
  WU.AcquireWindowAsync("Achievement")
end

function OnMedalClick()
  WU.RecordButtonClick(100136005)
  WU.AcquireWindowAsync("MedalList")
end

function OnActorClick()
  WU.RecordButtonClick(100136006)
  NU.GetCollectionsActor(function()
    WU.AcquireWindowAsync("CollectionsActor")
  end)
end

function OnBookClick()
  WU.RecordButtonClick(100136003)
  WU.AcquireWindowAsync("CollectionsNovel")
end

function OnEquipClick()
  WU.RecordButtonClick(100136002)
  WU.AcquireWindowAsync("CollectionsEquipment", function(window)
    _ENV["$"](window)["$$SetSuitTab"]()
  end)
end

function OnSceneClick()
  WU.RecordButtonClick(100136007)
  WU.AcquireWindowAsync("CollectionsScene")
end

function OnMedalChange(list)
  SetMedalRedMark()
end

function SetMedalRedMark()
  local medals = this:GetData("fci/medal/")
  local hasNewMedal = table.find(medals, function(k, v)
    return v.isNew
  end)
  RU.SetRedMark("Journey/Medal/New", hasNewMedal)
end

function OnStoryClick()
  WU.RecordButtonClick(100136001)
  WU.AcquireWindowAsync("JourneyStory")
end

function Focus(on)
  WU.RecordWindowFocus(100136, on)
end
