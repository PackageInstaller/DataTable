local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local SU = require("Common/SortUtil")
local index = 0
local m_repeatedContext = {}
local m_towerSumry
local m_providedList = {}
local m_gotList = {}
local m_initWindow = true
local m_buttonList = {}
local m_curChoice
local m_bindButtonB4 = false
local m_rowCount = 5
local m_maxGot = 30
local m_alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

function SetupWindow()
  LU.Bind(REF.ContentProvided, {
    updateRow = UpdateDropSlot
  })
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    WU.RecordButtonClick(100121303)
    if m_curChoice == nil then
      WU.ShowHintText(WU.GetString("Tower_SetPillNotLegal"))
      return
    end
    if this:GetData("Tower/JumpFromPreview") then
      WU.RecycleWindow(this)
    else
      WU.AcquireWindowAsync("TowerNewTeamPreview")
    end
  end)
end

function InitWindow()
  LU.Set(REF.ContentProvided, 0)
  m_initWindow = true
  m_curChoice = this:GetData("TowerNew/PillChoice")
  m_towerSumry = this:GetData("fci/extreme-challenge/summary/")
  ManageView()
  if m_towerSumry.itemSelectFloor < m_towerSumry.curFloor then
    WU.EnableToRequest("TowerNew/PillUpdateAble", "fci/extreme-challenge/select-buffitems/" .. m_towerSumry.curFloor - 1 .. "/", function(result)
      if result == nil then
        return
      end
      m_providedList = result.groups
      LU.Set(REF.ContentProvided, #m_providedList)
      if not m_bindButtonB4 then
        ManageButtonEvents()
      end
    end)
  end
  this:Bind("TowerNew/PillsGot", OnPillsChange)
  m_initWindow = false
end

function ManageView()
  local chose = m_towerSumry.itemSelectFloor >= m_towerSumry.curFloor
  REF.NodeProvided.gameObject:SetActive(not chose)
  REF.ButtonConfirm.gameObject:SetActive(not chose)
  REF.LabelTitleLeft.gameObject:SetActive(not chose)
end

function UpdateDropSlot(ref, wrapIndex, realIndex)
  ManageSlot(ref, wrapIndex, realIndex, m_providedList, true)
end

function UpdateGotSlot(ref, wrapIndex, realIndex)
  if m_gotList == nil or realIndex >= math.ceil(m_maxGot / m_rowCount) then
    return
  end
  for i = 1, m_rowCount do
    local data = m_gotList[realIndex * m_rowCount + i]
    local root = _ENV["$"](ref["Item" .. i])
    root.NodeItem.gameObject:SetActive(data ~= nil)
    if data then
      SetPillInfo(root, data.id)
      WU.ClearButtonEvent(root.ButtonSlot)
      WU.BindButtonEvent(root.ButtonSlot, function()
        WU.AcquireWindowAsync("TowerNewPillDetail", function(ui)
          _ENV["$"](ui)["$$SetPillDetail"](data)
        end)
      end)
    else
      root.SpriteEmptyPill.UISprite.spriteName = "head_bg"
    end
  end
  ref.bg.gameObject:SetActive(false)
  ref.NodeSelected.gameObject:SetActive(false)
end

function ManageSlot(ref, wrapIndex, realIndex, dataSource, showButton)
  if dataSource == nil or realIndex >= #dataSource then
    return
  end
  local data = dataSource[realIndex + 1].items
  for i = 1, m_rowCount do
    ref["Item" .. i].gameObject:SetActive(data[i] ~= nil)
    if data[i] then
      local root = _ENV["$"](ref["Item" .. i])
      root["$$SetData"](data[i].type, data[i].id, data[i].count)
      root["$$SetClickCallback"](function()
        WU.RecordButtonClick(100121302)
        WU.AcquireWindowAsync("TowerNewPillsProvidedDetail", function(ui)
          _ENV["$"](ui)["$$SetSelectedIndex"](realIndex + 1)
        end)
      end)
    end
    data.selected = fif(data.selected == nil, false, data.selected)
    if m_curChoice ~= nil then
      data.selected = realIndex + 1 == m_curChoice
    end
    ref.LabelAlphabet.UIHtmlLabel.text = tostring(realIndex + 1)
    ref.NodeSelected.gameObject:SetActive(data.selected)
  end
  ref.ButtonChoose.gameObject:SetActive(true)
  if not m_buttonList[realIndex + 1] then
    m_buttonList[realIndex + 1] = ref.ButtonChoose
  end
end

function ManageButtonEvents()
  local function removeItem(item)
    for i = 1, #item do
      local index, pill = table.find(m_gotList, function(_k, _v)
        return _v.id == item[i].id
      end)
      if 1 < pill.count then
        pill.count = pill.count - 1
      else
        table.remove(m_gotList, index)
      end
    end
    item.selected = false
  end
  
  for k, v in pairs(m_buttonList) do
    WU.BindButtonEvent(v, function()
      WU.RecordButtonClick(100121301)
      local item = m_providedList[k].items
      if not item.selected then
        if m_curChoice ~= nil then
          removeItem(m_providedList[m_curChoice].items)
        end
        for i = 1, #item do
          table.insert(m_gotList, item[i])
        end
        m_curChoice = k
        item.selected = true
      else
        removeItem(item)
        m_curChoice = nil
      end
      OnSelected()
      OnPillsChange(m_gotList)
    end)
  end
  m_bindButtonB4 = true
end

function OnPillsChange(pills)
  if pills == nil then
    pills = m_towerSumry.challengeItems
  end
  m_gotList = WU.SplitItems(pills)
  LU.Set(REF.ContentProvided, #m_providedList, false)
  REF.LabelPackageCount.UILabel.text = #m_gotList
end

function GetAlphabet(index)
  if 26 < index then
    warning("invalid index!")
    return "A"
  end
  return m_alphabet:sub(index, index)
end

function OnSelected()
  this:SetData("TowerNew/PillChoice", m_curChoice)
  this:SetData("TowerNew/PillsGot", m_gotList)
  this:SetData("TowerNew/PillSelected", nil)
end

function Focus(on)
  WU.RecordWindowFocus(1001213, on)
end
