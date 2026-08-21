local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local SU = require("Common/SortUtil")
local Tags = {
  Skip = 0,
  Tags1 = 1,
  Tags2 = 2
}
local m_sortLocalContext, m_context, m_sortMate, m_tabIndex, m_reverse

function SetupWindow()
  local function SetupTags(filterRef, xlsxData, fieldName)
    for i = 1, #filterRef.SelectionGrid do
      local id = 0
      
      if xlsxData[i] then
        id = xlsxData[i].id
      end
      local tagsRef = filterRef.SelectionGrid[i - 1]
      tagsRef["$gameObject"]:SetActive(i == 1 or id ~= 0)
      tagsRef["@id"] = fif(i == 1 or id ~= 0, id, nil)
      tagsRef.Label.UILabel.text = WU.GetString("tag" .. id .. fif(fieldName == "kind", "_kind", ""))
      WU.BindButtonEvent(tagsRef["$"], function(go)
        local ref = _ENV["$"](go)
        ref["$UIToggle"].value = true
        m_context[fieldName] = ref["@id"]
        CalculateCount(m_context)
      end)
    end
  end
  
  local function SetupFilters()
    local xlsxDataSet = {
      tags1 = {
        {id = 0, displayOrder = 0}
      },
      tags2 = {
        {id = 0, displayOrder = 0}
      }
    }
    local actorTagInfo = PB.all("ActorTagInfo")
    for i = 1, #actorTagInfo do
      if actorTagInfo[i].filterType ~= Tags.Skip then
        if actorTagInfo[i].filterType == Tags.Tags1 then
          table.insert(xlsxDataSet.tags1, actorTagInfo[i])
        elseif actorTagInfo[i].filterType == Tags.Tags2 then
          table.insert(xlsxDataSet.tags2, actorTagInfo[i])
        end
      end
    end
    table.sort(xlsxDataSet.tags1, function(v1, v2)
      return v1.displayOrder < v2.displayOrder
    end)
    table.sort(xlsxDataSet.tags2, function(v1, v2)
      return v1.displayOrder < v2.displayOrder
    end)
    SetupTags(_ENV["$"](REF.FilterKind), {
      {
        id = U.ToInt(PB.enum.ActorType.None)
      },
      {
        id = U.ToInt(PB.enum.ActorType.Main)
      },
      {
        id = U.ToInt(PB.enum.ActorType.Sub)
      }
    }, "kind")
    SetupTags(_ENV["$"](REF.FilterTags1), xlsxDataSet.tags1, "tags1")
    SetupTags(_ENV["$"](REF.FilterTags2), xlsxDataSet.tags2, "tags2")
  end
  
  SetupFilters()
  WU.TraverseChildren(REF.SelectionGridSort, function(go, index)
    WU.BindButtonEvent(go, function(go)
      local reverse = fif(index == m_tabIndex, not m_reverse, true)
      OnButtonSort(go, index, reverse)
    end)
  end)
  WU.BindButtonEvent(REF.ButtonReturn, function()
    this:BroadcastGameEvent("SortModeChanged", false)
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.ButtonReset, OnButtonReset)
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    WU.RecordButtonClick(982)
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.DisplayEquip, function()
    m_context.displayOption = "equip"
    SwitchDisplayOption(m_context)
  end)
  WU.BindButtonEvent(REF.DisplayGroup, function()
    m_context.displayOption = "group"
    SwitchDisplayOption(m_context)
  end)
  WU.BindButtonEvent(REF.DisplayName, function()
    m_context.displayOption = "name"
    SwitchDisplayOption(m_context)
  end)
  WU.BindButtonEvent(REF.DisplayArm, function()
    m_context.displayOption = "arm"
    SwitchDisplayOption(m_context)
  end)
end

function InitWindow()
  m_tabIndex = nil
  m_reverse = nil
  m_sortLocalContext = WU.GetGameDataCache("SortLocalContext")
  this:Bind("SortMate/Current", OnCurrentSortMate)
  this:Bind("SortFinished", function(data)
    m_context.displayOption = WU.GetGameDataCache("LocalDisplayOption") or "name"
    SwitchDisplayOption(m_context)
  end)
  local showArm = DB:GetData("Arm/ArmUnlock")
  REF.DisplayArm.gameObject:SetActive(showArm)
  REF.ScrollView.UIScrollView:ResetPosition()
end

function UninitWindow()
  this:BroadcastGameEvent("ApplySortAlternative", m_tabIndex, m_reverse, {
    contextName = m_context.contextName,
    kind = m_context.kind,
    tags1 = m_context.tags1,
    tags2 = m_context.tags2
  })
end

function OnCurrentSortMate(sortMate)
  if sortMate == nil then
    return
  end
  if not sortMate.advancedMode then
    error("Sort", "SortMate not in advance Mode")
    return
  end
  sortMate.showGroup = false
  m_sortMate = sortMate
  InitDisplay(sortMate)
  InitSortSelection(sortMate)
  m_context = m_sortLocalContext[sortMate.contextName]
  if m_context.displayOption == "group" then
    m_context.displayOption = "equip"
  end
  SetFilterSelection(m_context)
  CalculateCount(m_context)
end

function InitDisplay(sortMate)
  REF.DisplayOption.gameObject:SetActive(sortMate.showGroup or sortMate.showName or sortMate.showEquip)
  REF.DisplayGroup.gameObject:SetActive(sortMate.showGroup)
  REF.DisplayOption.UIGrid:Reposition()
  REF.FilterKind.gameObject:SetActive(sortMate.kind)
end

function SwitchDisplayOption(context)
  WU.SetGameDataCache("LocalDisplayOption", context.displayOption)
  this:SetData("DisplayOptionChange", context.displayOption)
  REF.CheckboxSName.gameObject:SetActive(context.displayOption == "name")
  REF.CheckboxSGroup.gameObject:SetActive(context.displayOption == "group")
  REF.CheckboxSEquip.gameObject:SetActive(context.displayOption == "equip")
  REF.CheckboxSArm.gameObject:SetActive(context.displayOption == "arm")
end

function SetFilterSelection(context)
  local function SetSelection(filterRef, contextId)
    for i = 0, #filterRef.SelectionGrid - 1 do
      local ref = filterRef.SelectionGrid[i]
      
      ref["$UIToggle"].value = ref["@id"] == contextId
    end
  end
  
  SetSelection(_ENV["$"](REF.FilterKind), context.kind)
  SetSelection(_ENV["$"](REF.FilterTags1), context.tags1)
  SetSelection(_ENV["$"](REF.FilterTags2), context.tags2)
end

function OnButtonReset()
  WU.RecordButtonClick(983)
  local reverse = true
  m_context.contextName = m_sortMate.contextName
  m_context.displayOption = "name"
  SwitchDisplayOption(m_context)
  m_context.kind = 0
  m_context.tags1 = 0
  m_context.tags2 = 0
  SetFilterSelection(m_context)
  if m_context.contextName == "CollectionsActor" then
    reverse = false
  else
    reverse = true
  end
  OnButtonSort(REF.SelectionGridSort[0]["$gameObject"], 0, reverse)
  CalculateCount(m_context)
end

function InitSortSelection(sortMate)
  local xlsxDataSet = SU.GetXlsxSortData(sortMate)
  if table.empty(xlsxDataSet) then
    error("Sort", "SortMate ids error!")
    return
  end
  local len = #REF.SelectionGridSort
  for i = 0, len - 1 do
    local btnRef = REF.SelectionGridSort[i]
    btnRef["$gameObject"]:SetActive(i < #xlsxDataSet)
    if i < #xlsxDataSet then
      local xlsxData = xlsxDataSet[i + 1]
      if xlsxData ~= nil then
        btnRef.Label.UILabel.text = WU.GetString(xlsxData.localization)
      end
      btnRef["@data"] = xlsxData
    end
  end
  OnButtonSort(REF.SelectionGridSort[sortMate.tabIndex]["$gameObject"], sortMate.tabIndex, sortMate.reverse)
end

function OnButtonSort(go, index, reverse)
  local ref = _ENV["$"](go)
  m_tabIndex = index
  m_reverse = reverse
  ref["$UIToggle"].value = true
  WU.TraverseChildren(REF.SelectionGridSort, function(go)
    _ENV["$"](go).ArrowSprite.UISprite.flip = CS.UISprite.Flip.Nothing
  end)
  ref.ArrowSprite.UISprite.flip = fif(m_reverse, CS.UISprite.Flip.Nothing, CS.UISprite.Flip.Vertically)
end

function CalculateCount(context)
  local filterList = SU.CopyData(U.ToInt(m_sortMate.type))
  REF.CountLabel.UILabel.text = #filterList
  REF.FilterCountLabel.UILabel.text = #SU.ApplyFilters(filterList, context)
  REF.SortFullScreenFilters["$FilterContext"](context)
end
