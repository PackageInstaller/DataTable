local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local SE = require("Common/SkillEffect")
local m_configDataManager = S:Get("ConfigDataManager")
local m_separateB4 = false
local m_pillList
local m_selectedList = {}
local m_selectedIndex, m_curGroup
local m_initWindow = false
local m_selectedSprList = {}

function SetupWindow()
  if CS.GameGlobal.DoesDeviceHaveNotch() then
    REF.ScrollView.UIPanel.clipSoftness = CS.UnityEngine.Vector2(CS.UIRoot.LeftNotchWidth, 0)
  end
  WU.BindButtonEvent(REF.ButtonClose, function()
    WU.RecordButtonClick(100121804)
    local modify = false
    local dataList = this:GetData("TowerNew/PillSelected")
    local myCnt = 0
    local dataCnt = 0
    for k, v in pairs(m_selectedList) do
      myCnt = myCnt + 1
    end
    if dataList then
      for k, v in pairs(dataList) do
        dataCnt = dataCnt + 1
      end
      if dataCnt ~= myCnt then
        modify = true
      else
        for k, v in pairs(dataList) do
          if m_selectedList[k] and dataList[k].id ~= m_selectedList[k].id then
            modify = true
            break
          end
        end
      end
    end
    if modify or dataList == nil and 0 < myCnt then
      WU.ShowMessageYesNo(WU.GetString("Tower_PillBackValidate"), function(result)
        if result == "YES" then
          this:SetData("TowerNew/PillSelected", m_selectedList)
          WU.RecycleWindow(this)
        else
          ManagePillSelected(this:GetData("TowerNew/PillSelected"))
          LU.Set(REF.WrapContent, #m_pillList, false)
        end
      end)
    else
      WU.RecycleWindow(this)
    end
  end)
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    WU.RecordButtonClick(100121803)
    this:SetData("TowerNew/PillSelected", m_selectedList)
    WU.RecycleWindow(this)
  end)
  LU.Bind(REF.WrapContent, {
    updateRow = UpdatePillSlot
  })
end

function InitWindow()
  m_initWindow = true
  LU.Set(REF.WrapContent, 0)
  this:Bind("fci/extreme-challenge/summary/", OnPillsChanged)
end

function OnPillsChanged(pills)
  if pills == nil then
    return
  end
  if not m_separateB4 then
    m_pillList = SeparatePillGroups(pills.challengeItems)
  end
  table.sort(m_pillList, SortPill)
  this:Bind("TowerNew/PillSelected", ManagePillSelected)
  REF.LabelCurScore.UILabel.text = WU.GetString("Tower_Score") .. pills.curScore
  LU.Set(REF.WrapContent, #m_pillList)
end

function SeparatePillGroups(list)
  this:SetData("TowerNew/PillSelected", nil)
  local newList = WU.SplitItems(list)
  m_separateB4 = true
  return newList
end

function UpdatePillSlot(ref, wrapIndex, realIndex)
  if m_pillList == nil or realIndex >= #m_pillList then
    return
  end
  local root = ref.root
  local idx = realIndex + 1
  local curPill = m_pillList[idx]
  local pillInfo = PB.get("ExtremeChallengeBuffItem", curPill.id)
  if m_initWindow then
    for k, v in pairs(m_pillList) do
      local idx, pill = table.find(m_selectedList, function(k, v)
        return v == curPill
      end)
      v.selected = pill ~= nil
      v.index = idx
    end
  end
  ref.NodeSelected.gameObject:SetActive(curPill.selected)
  if curPill.selected then
    ref.SpriteTick.UISprite.spriteName = "number_icon_" .. curPill.index
  end
  ref.WidgetIconSlot["$SetData"](curPill.type, curPill.id, curPill.count)
  ref.WidgetIconSlot["$SetClickCallback"](nil)
  ref.LabelDesc.UIHtmlLabel.text = SE.GetTowerPillDesc(m_pillList[idx].id)
  ref.SpriteGlobal.gameObject:SetActive(pillInfo.isDragfastGlobal)
  ref.NodeEffectSingle.gameObject:SetActive(pillInfo.dragfastAdd == 0 or pillInfo.score == 0)
  ref.NodeEffectDouble.gameObject:SetActive(pillInfo.dragfastAdd ~= 0 and pillInfo.score ~= 0)
  if pillInfo.dragfastAdd ~= 0 and pillInfo.score ~= 0 then
    ref.LabelPill.UIHtmlLabel.text = "<img src='Tournament.challenge_limit_icon'/>" .. " +" .. pillInfo.dragfastAdd
    ref.LabelScore.UIHtmlLabel.text = "<img src='Tournament.challenge_hotspot_icon'/>" .. " +" .. pillInfo.score
  else
    ref.NodeEffectSingle.UISprite.color = CS.NGUIMath.HexToColor(fif(pillInfo.dragfastAdd ~= 0, 4294967295, 2313485311))
    ref.LabelSingle.UIHtmlLabel.text = fif(pillInfo.dragfastAdd ~= 0, "<img src='Tournament.challenge_limit_icon'/>" .. " +" .. pillInfo.dragfastAdd, "<img src='Tournament.challenge_hotspot_icon'/>" .. " +" .. pillInfo.score)
  end
  WU.ClearButtonEvent(ref.NodeButton)
  WU.BindButtonEvent(ref.NodeButton, function()
    local index = table.find(m_selectedList, function(k, v)
      return v == curPill
    end)
    if not table.has(m_selectedList, curPill) then
      m_selectedList[m_selectedIndex] = curPill
      curPill.index = m_selectedIndex
    elseif m_selectedList[m_selectedIndex] == curPill then
      m_selectedList[m_selectedIndex] = nil
      curPill.index = nil
    else
      local tmpPill = m_selectedList[m_selectedIndex]
      m_selectedList[m_selectedIndex] = curPill
      curPill.index = m_selectedIndex
      if tmpPill ~= nil then
        m_selectedList[index] = tmpPill
        tmpPill.index = index
      else
        m_selectedList[index] = nil
      end
    end
    for k, v in pairs(m_pillList) do
      v.selected = table.has(m_selectedList, v)
    end
    ManagePillSelected(m_selectedList, true)
    LU.Set(REF.WrapContent, #m_pillList, false)
  end)
end

function ManagePillSelected(pills, mData)
  pills = pills or {}
  if mData then
    m_selectedList = pills
  else
    m_selectedList = _ENV["!"]({})
    _ENV["!"](pills):copy(m_selectedList)
  end
  WU.TraverseChildren(REF.GridSelected, function(go, index)
    local ref = _ENV["$"](go)
    local root = ref.root
    local realIndex = 3 - index
    local pill = pills[realIndex]
    if pill then
      ref.WidgetIconSlot["$SetData"](pill.type, pill.id, pill.count)
    else
      local custom = {notShowEmpty = true}
      ref.WidgetIconSlot["$SetData"](PB.enum.ResourceType.ResExtremeChallengeItem, nil, nil)
      ref.WidgetIconSlot["$ShowCustom"](custom)
    end
    m_selectedSprList[realIndex] = ref.SpriteSelected
    ref.SpriteSelected.gameObject:SetActive(realIndex == m_selectedIndex)
    ref.SpriteEmpty.gameObject:SetActive(pill == nil)
    ref.LabelEmpty.UILabel.text = realIndex
    if not root.bindB4 then
      WU.BindButtonEvent(ref.ButtonSelect, function()
        WU.RecordButtonClick(10012180 .. index)
        m_selectedIndex = realIndex
        for k, v in pairs(m_selectedSprList) do
          v.gameObject:SetActive(k == m_selectedIndex)
        end
      end)
      root.bindB4 = true
    end
    ref.ColorMain.gameObject:SetActive(false)
    ref.ColorSub.gameObject:SetActive(false)
    if m_curGroup then
      local redVal = PB.index("Misc", 1).extremeChallengeDrugLimit
      local main = m_curGroup[realIndex].actor
      local sub = m_curGroup[realIndex + 3].actor
      
      local function manageAc(actor, key, color)
        ref["Empty" .. key].gameObject:SetActive(not actor)
        ref["Head" .. key].gameObject:SetActive(actor)
        if actor then
          ref["Head" .. key].UISprite.spriteName = "actor_head_" .. actor.id .. "a"
        end
        ref["Color" .. key].gameObject:SetActive(actor and actor.hp < 0 or color ~= nil)
        ref["Color" .. key].UISprite.color = CS.NGUIMath.HexToColor(color)
        if actor and actor.hp < 0 then
          ref["Color" .. key].UISprite.color = CS.NGUIMath.HexToColor(861286)
        end
      end
      
      local color
      if main and sub then
        color = fif(redVal <= main.dragfast + sub.dragfast, 3963305574, nil)
      end
      manageAc(main, "Main", color)
      manageAc(sub, "Sub", color)
      ref.SpriteUseless.gameObject:SetActive(false)
      if pill then
        local pillInfo = PB.get("ExtremeChallengeBuffItem", pill.id)
        local useful = main and sub and main.hp >= 0 and sub.hp >= 0 and redVal > main.dragfast + sub.dragfast
        ref.SpriteUseless.gameObject:SetActive(not useful and pillInfo.dragfastAdd and 0 < pillInfo.dragfastAdd)
      end
      ref.SpriteUnable.gameObject:SetActive(false)
      ref.ButtonSelect.gameObject:SetActive(true)
      ref.LabelEmpty.gameObject:SetActive(pill == nil)
    end
  end)
end

function SetSelectedIndex(index)
  m_selectedIndex = index
  ManagePillSelected(m_selectedList, true)
end

function SetGroup(group)
  m_curGroup = group
end

function SortPill(a, b)
  local info1 = PB.get("ExtremeChallengeBuffItem", a.id)
  local info2 = PB.get("ExtremeChallengeBuffItem", b.id)
  
  local function Compare(param1, param2, reverse)
    if not param1 and not param2 then
      return false
    elseif param1 and not param2 then
      return true
    elseif not param1 and param2 then
      return false
    elseif param1 and param2 and param1 ~= param2 then
      if reverse then
        return param1 < param2
      else
        return param2 < param1
      end
    end
  end
  
  if info1.quality ~= info2.quality then
    return info1.quality > info2.quality
  else
    local score = Compare(info1.score, info2.score)
    if score ~= nil then
      return score
    end
    local drug = Compare(info1.isDragfastGlobal, info2.isDragfastGlobal)
    if drug ~= nil then
      return drug
    end
    return a.id < b.id
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001218, on)
end
