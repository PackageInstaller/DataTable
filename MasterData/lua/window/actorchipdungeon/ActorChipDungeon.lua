local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local DU = require("Common/DungeonUtil")
local m_dungeonList = {}
local m_dungeonReward = {}
local m_exchangeInfo, m_chapterSumry, m_posIndex
local m_repeatedContext = {}

function SetupWindow()
  for i = 1, 2 do
    WU.BindButtonEvent(REF["ButtonGoto" .. i], function()
      DU.IsDungeonUnlocked(m_chapterSumry, m_dungeonList[i].dungeonId, function(unlocked)
        if unlocked then
          WU.AcquireWindowAsync("DungeonStory", function()
            this:SetData("DungeonPrepare/ChapterId", DU.GetChapterId(m_dungeonList[i].dungeonId))
            this:SetData("DungeonPrepare/DungeonId", m_dungeonList[i].dungeonId)
          end)
        else
          WU.ShowHintText(WU.GetString("Error_DungeonLocked"))
        end
      end)
    end)
  end
end

function InitWindow()
  this:Bind("ActorChipExchange/DungeonList", OnDungeonListChange)
end

function OnDungeonListChange()
  SetContent(m_posIndex)
end

function SetContent(posIndex)
  if posIndex == nil then
    return
  end
  m_dungeonList = {}
  m_exchangeInfo = this:GetData("fci/chipexchange/")
  m_posIndex = posIndex
  m_chapterSumry = this:GetData("fci/dungeon/chapter-summary")
  local allList = this:GetData("ActorChipExchange/DungeonList")
  for k, v in pairs(allList) do
    if v.posIndex == posIndex then
      table.insert(m_dungeonList, v)
    end
  end
  LU.Set(REF.WrapContent, 0)
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateDungeonSlot
  })
  LU.Set(REF.WrapContent, #m_dungeonList)
end

function UpdateDungeonSlot(rowRef, wrapIndex, realIndex)
  if realIndex < 0 or m_dungeonList == nil or realIndex >= #m_dungeonList then
    return
  end
  local ref = _ENV["$"](rowRef.root)
  local info = m_dungeonList[realIndex + 1]
  ref.LabelName.UILabel.text = WU.GetString("DungeonNameChipExchange_" .. info.dungeonId)
  ref.LabelTimeLeft.UILabel.text = WU.GetString("Window_TimeLeft") .. info.restTimes .. "/" .. info.maxTimes
  local iconSlot = _ENV["$"](ref.WidgetIconSlot)
  iconSlot["$$SetData"](info.drop.type, m_exchangeInfo.exchangePosInfo[info.posIndex], info.drop.count)
  DU.IsDungeonUnlocked(m_chapterSumry, info.dungeonId, function(unlocked)
    WU.SetActive(ref["ButtonGoto" .. realIndex + 1], unlocked)
    WU.SetActive(ref["SpriteLock" .. realIndex + 1], not unlocked)
  end)
end
