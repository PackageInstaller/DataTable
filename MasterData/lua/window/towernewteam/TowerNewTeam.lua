local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local SU = require("Common/SortUtil")
local index = 0
local m_repeatedContext = {}
local m_actorList = {}
local m_gotList = {}
local m_towerSumry
local m_countTotal = 0
local m_maxCountTeam = 0
local m_maxCountMain = 0
local m_maxCountSub = 0
local m_sortSelectedList = {}
local m_sortSelectedLabelList = {}
local m_curSortChoice = {}
local m_curSort = 1
local m_mainCount = 0
local m_subCount = 0
local m_rowCount = 10
local m_clickAble = true
local m_confirmLegal = false
local m_maxGot = 20
local Sort_Name2Type = {
  Quality = 32,
  Level = 33,
  Star = 34,
  Name = 37,
  Cultivation = 35,
  Speed = 36
}

function SetupWindow()
  ManageButtonEvents()
  LU.Bind(REF.ContentProvided, {
    updateRow = UpdateActorProvided
  })
end

function InitWindow()
  REF.DropList.gameObject:SetActive(false)
  REF.ContentGot.gameObject:SetActive(false)
  REF.NodeSelected.gameObject:SetActive(false)
  REF.ButtonConfirm.gameObject:SetActive(false)
  REF.ButtonHideSort.gameObject:SetActive(false)
  REF.ContentProvided.gameObject:SetActive(false)
  this:BindRemote(DB:GameRequest("fci/extreme-challenge/last-select/"), OnTeamChange)
end

function OnTeamChange(teamUids)
  if teamUids == nil then
    return
  end
  m_towerSumry = this:GetData("fci/extreme-challenge/summary/")
  m_maxCountSub = PB.get("ExtremeChallengeDungeon", m_towerSumry.curDifficulty).subLimit
  m_maxCountMain = PB.get("ExtremeChallengeDungeon", m_towerSumry.curDifficulty).mainLimit
  m_maxCountTeam = m_maxCountMain + m_maxCountSub
  local selectLocal = this:GetData("TowerNew/SelectedActorsLocal")
  m_actorList = this:GetData("fci/actor/")
  m_gotList = {}
  if selectLocal == nil and #teamUids.actorUids <= m_maxCountTeam then
    m_gotList = WU.CheckActorsLocal(teamUids.actorUids)
    this:SetData("TowerNew/SelectedActorsLocal", m_gotList)
  else
    selectLocal = selectLocal or {}
    m_gotList = WU.CheckActorsLocal(selectLocal)
  end
  local refName = m_curSortChoice.name or "ButtonSortLevel"
  local key = string.sub(refName, string.len("ButtonSort") + 1)
  SetSortSelected(true, m_curSort or 1)
  SU.SortOnce(m_actorList, PB.get("Sort", Sort_Name2Type[key]), true)
  this:SetData("TowerNew/SelectActor-NeverUpdate", false)
  UpdateGotActors()
  REF.ContentGot.gameObject:SetActive(true)
  LU.Set(REF.ContentProvided, #m_actorList)
  SetBottomBar()
end

function UpdateActorProvided(ref, wrapIndex, realIndex)
  if realIndex < 0 or m_actorList == nil or realIndex >= #m_actorList then
    return
  end
  local idx = realIndex + 1
  local root = ref.root
  local data = m_actorList[idx]
  if data then
    local custom = {showStar = true}
    root["$ResetState"]()
    root["$SetActor"](data)
    root["$ShowCustom"](custom)
    data.selected = data.selected or false
    if 0 < #m_gotList then
      for k, v in pairs(m_gotList) do
        local uid
        if v.uid then
          uid = v.uid
        else
          uid = v.actor.uid
        end
        if data.uid == uid then
          data.selected = true
        end
      end
    else
      data.selected = false
    end
    root["$SetSelected"](data.selected)
    root["$SetClickCallback"](function()
      if not m_clickAble then
        return
      end
      local kind = data.kind
      if not data.selected then
        if m_countTotal >= m_maxCountTeam then
          WU.ShowHintText(WU.GetString("Tower_MaxActors"))
          return
        elseif m_mainCount >= m_maxCountMain and kind == 1 then
          WU.ShowHintText(WU.GetString("Tower_MaxMainActors"))
          return
        elseif m_subCount >= m_maxCountSub and kind == 2 then
          WU.ShowHintText(WU.GetString("Tower_MaxSubActors"))
          return
        end
      end
      SetActorClick(data, true)
    end)
  end
end

function UpdateGotActors()
  local mainList = {}
  local subList = {}
  for k, v in pairs(m_gotList) do
    local actor = v.actor or v
    local kind = actor.kind or v.kind
    if kind == 1 then
      table.insert(mainList, actor)
    elseif kind == 2 then
      table.insert(subList, actor)
    end
  end
  
  local function SetData(Ref, dataSource, limit)
    WU.TraverseChildren(Ref, function(parGo, parIdx)
      local ref = _ENV["$"](parGo)
      for i = 1, m_rowCount do
        local root = _ENV["$"](ref["Item" .. i])
        local boxIndex = parIdx * m_rowCount + i
        local data = dataSource[boxIndex]
        local limitReach = boxIndex > limit
        root.SpriteEmpty.gameObject:SetActive(data == nil)
        if limitReach then
          root.NodeNextLock.gameObject:SetActive(boxIndex == limit + 1)
          root.LabelLock.gameObject:SetActive(boxIndex == limit + 1)
          root.SpriteLock.gameObject:SetActive(boxIndex ~= limit + 1)
          root.LabelLock.UILabel.text = WU.GetString("Tower_BoxLimit_" .. boxIndex)
          root.Visual.gameObject:SetActive(false)
        else
          root.SpriteLock.gameObject:SetActive(false)
          root.Visual.gameObject:SetActive(data ~= nil)
          if data then
            ref["Item" .. i]["$SetActor"](data)
            ref["Item" .. i]["$SetClickCallback"](function()
              SetActorClick(data)
            end)
          end
        end
        root.NodeLock.gameObject:SetActive(limitReach)
        root.NodeAcSelected.gameObject:SetActive(false)
      end
    end)
  end
  
  SetData(REF.GridMain, mainList, m_maxCountMain)
  SetData(REF.GridSub, subList, m_maxCountSub)
  m_subCount = #subList
  m_mainCount = #mainList
  m_countTotal = m_mainCount + m_subCount
  m_confirmLegal = 0 < m_mainCount and m_mainCount <= m_maxCountMain and m_subCount <= m_maxCountSub
  m_clickAble = not m_towerSumry.memberSelected
  REF.ButtonConfirm.gameObject:SetActive(not m_towerSumry.memberSelected)
  REF.NodeSelected.gameObject:SetActive(m_towerSumry.memberSelected)
  REF.LabelSubCount.UIHtmlLabel.text = string.format("%s / %s", m_subCount, m_maxCountSub)
  REF.LabelMainCount.UIHtmlLabel.text = string.format("%s / %s", m_mainCount, m_maxCountMain)
end

function SetActorClick(data, selectAble)
  local index, flag = table.find(m_gotList, function(k, v)
    if v.actor then
      return data.uid == v.actor.uid
    else
      return data.uid == v.uid
    end
  end)
  if flag then
    data.selected = false
    table.remove(m_gotList, index)
  elseif selectAble then
    table.insert(m_gotList, data)
    data.selected = true
    WU.RecordButtonClick(10012120 .. data.kind)
  end
  UpdateGotActors()
  this:SetData("TowerNew/SelectedActorsLocal", m_gotList)
  LU.Set(REF.ContentProvided, #m_actorList, false)
  SetBottomBar()
end

function SaveAndLeave()
  if this:GetData("Tower/JumpFromPreview") then
    WU.RecycleWindow(this)
  else
    WU.AcquireWindowAsync("TowerNewPills")
  end
end

function SetBottomBar()
  REF.BottomBarSpace.gameObject:SetActive(0 < #m_actorList)
  REF.BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3(#m_actorList * REF.ContentProvided.UIWrapContent.itemSize, -513, 0)
end

function ManageButtonEvents()
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    WU.RecordButtonClick(100121203)
    if m_confirmLegal then
      SaveAndLeave()
    elseif m_mainCount < 1 then
      WU.ShowHintText(WU.GetString("Tower_AtleastOneMain"))
    end
  end)
  WU.BindButtonEvent(REF.ButtonSort, function()
    local ref = REF.ButtonSort
    ref.show = REF.DropList.gameObject.activeSelf
    ref.show = not ref.show
    REF.DropList.gameObject:SetActive(ref.show)
    REF.ButtonHideSort.gameObject:SetActive(ref.show)
  end)
  WU.BindButtonEvent(REF.ButtonHideSort, function()
    REF.DropList.gameObject:SetActive(false)
    REF.ButtonHideSort.gameObject:SetActive(false)
  end)
  ManageSortButton()
end

function ManageSortButton()
  WU.TraverseChildren(REF.SortGrid, function(go, index)
    local gasket = _ENV["$"](go).root
    local realIndex = index + 1
    local key = string.sub(gasket.name, string.len("ButtonSort") + 1)
    m_sortSelectedList[realIndex] = _ENV["$"](go).DropListNodeSelected
    m_sortSelectedLabelList[realIndex] = _ENV["$"](go).DropListLabelItem
    WU.BindButtonEvent(gasket, function()
      for k, v in pairs(m_sortSelectedList) do
        SetSortSelected(false, k)
      end
      if gasket.sortType == nil then
        gasket.sortType = true
      end
      gasket.sortType = fif(m_curSortChoice ~= gasket, gasket.sortType, not gasket.sortType)
      m_curSortChoice = gasket
      m_curSort = realIndex
      SetSortSelected(true, realIndex)
      _ENV["$"](go).DropListSpriteSeqTagChild.UISprite.flip = fif(gasket.sortType, CS.UISprite.Flip.Nothing, CS.UISprite.Flip.Vertically)
      local xlsx = PB.get("Sort", Sort_Name2Type[key])
      SU.SortOnce(m_actorList, xlsx, gasket.sortType)
      LU.Set(REF.ContentProvided, #m_actorList)
      SetBottomBar()
    end)
  end)
end

function SetSortSelected(selected, index)
  if selected then
    m_sortSelectedList[index].gameObject:SetActive(true)
    m_sortSelectedLabelList[index].UILabel.color = CS.NGUIMath.HexToColor(995593215)
  else
    m_sortSelectedList[index].gameObject:SetActive(false)
    m_sortSelectedLabelList[index].UILabel.color = CS.NGUIMath.HexToColor(4294967295)
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001212, on)
end
