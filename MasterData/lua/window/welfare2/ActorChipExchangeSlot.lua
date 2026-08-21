local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local NU = require("Common/NotepadUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local m_activityManager = S:Get("ActivityManager")
local m_item1 = {}
local m_item2 = {}
local m_originalList = {}
local m_dungeonList = {}

function Awake()
  for i = 1, 2 do
    WU.BindButtonEvent(REF["Chip" .. i], function()
      FuncSelected(i)
    end)
  end
  m_item1 = REF.Chip1
  m_item2 = REF.Chip2
end

function Start()
  m_dungeonList = this:GetData("ActorChipExchange/DungeonList")
  m_originalList = PB.index("Misc", 1).chipExchangeSet
  ResetSelected()
  this:RegisterGameEvent("ActorChipSelectedChange", function(item)
    ResetSelected()
    for i = 1, 2 do
      local gb = Index2Item(i)
      if gb.chipIndex == item.chipIndex then
        WU.SetActive(REF["NodeSelected" .. i], true)
      end
    end
  end)
  this:RegisterGameEvent("ActorChipSelectedByIndex", FuncSelectedChipIndex)
end

function ResetSelected()
  for i = 1, 2 do
    WU.SetActive(REF["NodeSelected" .. i], false)
  end
end

function SetData(data1, data2)
  ManageChipData(data1, 1, m_item1.custom ~= nil)
  ManageChipData(data2, 2, m_item2.custom ~= nil)
end

function ManageChipData(data, index, hasCustom)
  if data == nil or data == 0 then
    REF["TextureChip" .. index].UITexture.mainTexturePath = "Texture/ItemIcon/ActorChipExchange_button"
  elseif data ~= 0 then
    REF["TextureChip" .. index].UITexture.mainTexturePath = "Texture/ActorChipIcon/ResItem_" .. data
  end
  local dList = {}
  for k, v in pairs(m_dungeonList) do
    if v.posIndex == Index2Item(index).chipIndex then
      table.insert(dList, v)
    end
  end
  for k, v in pairs(dList) do
    if REF["ChipOriginal" .. index .. "_" .. k] ~= nil then
      REF["ChipOriginal" .. index .. "_" .. k].UITexture.mainTexturePath = "Texture/ActorChipIcon/ResItem_" .. v.drop.id
      REF["LabelName" .. index .. "_" .. k].UILabel.text = WU.GetString("DungeonNameChipExchange_" .. v.dungeonId)
      WU.SetActive(REF["SpriteSet" .. index .. "_" .. k], hasCustom)
    end
  end
end

function SetIndex(doubleIndex)
  m_item1.chipIndex = doubleIndex * 2 - 1
  m_item2.chipIndex = doubleIndex * 2
end

function SetCustom(opList, doubleIndex)
  m_item1.custom = fif(opList[doubleIndex * 2 - 1] == 0, nil, opList[doubleIndex * 2 - 1])
  m_item2.custom = fif(opList[doubleIndex * 2] == 0, nil, opList[doubleIndex * 2])
end

function FuncSelected(index)
  for i = 1, 2 do
    WU.SetActive(REF["NodeSelected" .. i], false)
  end
  WU.SetActive(REF["NodeSelected" .. index], true)
  this:BroadcastGameEvent("ActorChipSelectedChange", Index2Item(index))
end

function FuncSelectedChipIndex(chipIndex, callBack)
  for i = 1, 2 do
    local item = Index2Item(i)
    if item.chipIndex == chipIndex then
      if callBack then
        callBack(item)
      else
        this:BroadcastGameEvent("ActorChipSelectedChange", item)
      end
    end
  end
end

function Index2Item(index)
  if index == 1 then
    return m_item1
  else
    return m_item2
  end
end
