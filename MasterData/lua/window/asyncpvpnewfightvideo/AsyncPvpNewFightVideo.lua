local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local CU = require("Common/ChatUtil")
local U = require("Common/Util")
local HU = require("Common/HtmlUtil")
local DU = require("Common/DungeonUtil")
local LU = require("Common/ListUtil")
local TPU = require("Common/TopPvpUtil")
local m_currentSelect
local m_attackInfo = {}
local m_defenseInfo = {}

function SetupWindow()
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateWidget
  })
  REF.ToggleDefense["$SetClickCallback"](function()
    OnTabChange(0)
  end)
  REF.ToggleAttack["$SetClickCallback"](function()
    OnTabChange(1)
  end)
end

function InitWindow()
  REF.ToggleAttack.UIToggle.value = true
  LU.Set(REF.WrapContent, 0)
  this:GameRequest("fci/asyncpvp_v2/record/0/"):Get(function(result)
    m_defenseInfo = table.sort(result.records, function(a, b)
      return a.balanceTime > b.balanceTime
    end)
  end)
  this:GameRequest("fci/asyncpvp_v2/record/1/"):Get(function(result)
    m_attackInfo = table.sort(result.records, function(a, b)
      return a.balanceTime > b.balanceTime
    end)
    OnTabChange(1)
  end)
end

function UninitWindow()
  m_currentSelect = nil
end

function OnTabChange(index)
  if m_currentSelect == index then
    return
  end
  m_currentSelect = index
  local currentRecords = fif(index == 0, m_defenseInfo, m_attackInfo)
  LU.Set(REF.WrapContent, #currentRecords)
  WU.SetActive(REF.SpriteEmpty, fif(#currentRecords == 0, true, false))
end

function UpdateWidget(refRow, wrapIndex, rowIndex)
  if rowIndex == nil then
    return
  end
  local info = fif(m_currentSelect == 0, m_defenseInfo, m_attackInfo)
  local trueIndex = rowIndex + 1
  if info[trueIndex] ~= nil then
    refRow["$$SetView"](info[trueIndex])
  end
end
