local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("common/HtmlUtil")
local S = require("Common/Singleton")
local IU = require("Common/ItemUtil")
local DBH = require("Manager/DataBindingHandler")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local m_activityManager = S:Get("ActivityManager")
local m_sealRecord = {}
local m_costSeal
local m_row = 5
local m_col = 5
local m_data, m_allRewardInfo, m_roleReward, m_seal

function Awake()
  WU.BindButtonEvent(REF.buttonGet, OnGetBigReward)
  WU.SetActive(REF.GridStock, false)
  WU.SetActive(REF.PanelBoxBottom, false)
  WU.SetActive(REF.PanelBoxRight, false)
  WU.SetActive(REF.PanelSeal, false)
  DB:GameRequest("fci/seal/"):Get(function(res)
    m_seal = res
    InitData()
    WU.SetActive(REF.GridStock, true)
    WU.SetActive(REF.PanelBoxBottom, true)
    WU.SetActive(REF.PanelBoxRight, true)
    WU.SetActive(REF.PanelSeal, true)
  end)
end

function OnGetBigReward()
  OnClickBox(m_roleReward)
end

function InitData()
  m_activityManager.GetByActivityOpen(PB.enum.ActivityType.Seal, function()
    if m_seal then
      InitRecord(m_seal)
    end
  end, true)
  m_activityManager.GetActivityByType(PB.enum.ActivityType.Seal, function(activityList)
    if activityList then
      local activity = activityList[1]
      local strTime = string.format("%s-%s", ACU.RenderTime2(activity.timestampStart, true), ACU.RenderTime2(activity.timestampEnd, true))
      REF.HtmlLabelTime.UIHtmlLabel.text = WU.GetString("Seal_Tips15", strTime)
    end
  end)
end

function OnClickSeal(row, col, sealData)
  if sealData.fill == true then
    return
  end
  local costID = sealData.info.cost.id
  local costCount = sealData.info.cost.count
  local key = "fci/item/" .. costID
  local curCount = this:GetData(key).count
  if costCount > curCount then
    WU.ShowHintText(WU.GetString("Seal_Error1", WU.GetItemName(costID, PB.enum.ResourceType.ResItem)))
    return
  end
  this:Unbind(key)
  this:Bind(key, function()
    UpdateStockSeal()
  end)
  local url = string.format("fci/seal/fill/%d/", sealData.info.cellId)
  DB:GameRequest(url):Post(nil, function(result)
    if result.cellId then
      for i, v in ipairs(m_data.cellInfo) do
        if v.info.cellId == result.cellId then
          v.fill = true
          break
        end
      end
      UpdateState()
      DBH.ResChange(result.resChange)
    end
  end)
end

function OnClickBox(boxData)
  local state = CheckBoxState(boxData)
  if boxData.info.rewardKind == 4 and state ~= 1 then
    return
  end
  if boxData.got == true or state ~= 1 then
    local buttonTitle = WU.GetString("WindowGacha_Close")
    WU.AcquireWindowAsync("RewardPreview", function(ui)
      local str = ""
      if boxData.info.rewardKind == 1 then
        str = WU.GetString("Seal_Tips8")
      elseif boxData.info.rewardKind == 2 then
        str = WU.GetString("Seal_Tips10")
      elseif boxData.info.rewardKind == 3 then
        str = WU.GetString("Seal_Tips9")
      end
      _ENV["$"](ui)["$$SetView"](boxData.info.reward, WU.GetString("Seal_Title2"), str, boxData.got)
      local heroID
      for i, v in ipairs(boxData.info.reward) do
        if v.type == PB.enum.ResourceType.ResActor then
          heroID = v.id
          break
        end
      end
      if heroID then
        _ENV["$"](ui)["$$SetCustomActorInfo"](heroID, boxData.info.quality)
      end
    end)
  else
    local url = string.format("fci/seal/reward/%d/", boxData.info.rewardId)
    DB:GameRequest(url):Post(nil, function(result)
      DBH.ResChange(result.resChange)
      if result.rewardId then
        for i, v in ipairs(m_data.rewardInfo) do
          if v.info.rewardId == result.rewardId then
            v.got = true
            break
          end
        end
        WU.ShowRewards(result.resChange)
        UpdateState()
      end
    end)
  end
end

function OnEnable()
  InitData()
  RU.SetRedMark("Welfare/Seal", false)
  local data = this:GetData("fci/redpoint/data")
  if data and data.sealFlagResult then
    data.sealFlagResult.newOpenFlag = false
  end
  this:GameRequest("fci/seal/flag"):Patch({newOpenFlag = false})
end

function UpdateStockSeal()
  local stock = REF.GridStock
  local count = 0
  for k, v in pairs(m_costSeal) do
    local container = stock[count]
    local iconWidget = container.WidgetIconSlot
    local labelNum = container.LabelBottomRight
    local itemNum = this:GetData("fci/item/" .. v.id).count
    labelNum.UIHtmlLabel.text = tostring(itemNum)
    iconWidget["$SetData"](v.type, v.id, 0)
    iconWidget["$ShowCustom"]({hideBG = true})
    count = count + 1
  end
end

function PlayCanGetAni(refBox, boxData)
  refBox.effectFudai.gameObject:SetActive(true)
  refBox.SpriteIcon.gameObject:SetActive(false)
  refBox.effectFudai.EffectGenerator:Play()
end

function UpdateBoxState()
  local total = m_row + m_col + 1
  local count = 1
  for i = 1, total do
    local boxContainer, box
    local boxData = m_data.rewardInfo[i]
    if boxData.info.rewardKind == 3 then
      boxContainer = REF.PanelBoxBottom
      box = boxContainer[5].root
    else
      if i <= m_row then
        boxContainer = REF.PanelBoxRight
        box = boxContainer[(count - 1) % m_row].root
      else
        boxContainer = REF.PanelBoxBottom
        box = boxContainer[(count - 1) % m_col].root
      end
      count = count + 1
    end
    local refBox = _ENV["$"](box)
    refBox.effectFudai.gameObject:SetActive(false)
    refBox.SpriteIcon.gameObject:SetActive(true)
    if boxData.got == true then
      refBox.SpriteIcon.UISprite.spriteName = "seal/fudai_open_icon"
      refBox.SpriteGet.gameObject:SetActive(true)
    else
      refBox.SpriteIcon.UISprite.spriteName = "seal/fudai_icon"
      refBox.SpriteGet.gameObject:SetActive(false)
    end
    local state = CheckBoxState(boxData)
    refBox.SpriteIcon.UISprite.color = CS.NGUIMath.HexToColor(4294967295)
    refBox.SpriteMask.gameObject:SetActive(false)
    if state == 1 then
      PlayCanGetAni(refBox, boxData)
    elseif state == 0 then
      refBox.SpriteIcon.UISprite.color = CS.NGUIMath.HexToColor(4294967115)
      refBox.SpriteMask.UISprite.color = CS.NGUIMath.HexToColor(4294967115)
      refBox.SpriteMask.gameObject:SetActive(true)
    end
    WU.ClearButtonEvent(box)
    WU.BindButtonEvent(box, function()
      OnClickBox(boxData)
    end)
  end
  REF.HtmlLabelBtn.UIHtmlLabel.text = WU.GetString("Seal_Tips7")
  for i, v in ipairs(m_data.rewardInfo) do
    if v.info.rewardKind == 4 then
      m_roleReward = v
      local state = CheckBoxState(v)
      REF.buttonGet.gameObject:SetActive(false)
      REF.buttonGetDisable.gameObject:SetActive(true)
      if state == 1 then
        REF.buttonGet.gameObject:SetActive(true)
        REF.buttonGetDisable.gameObject:SetActive(false)
        REF.HtmlLabelBtn.UIHtmlLabel.text = WU.GetString("Seal_Tips6")
        break
      end
      if state == 0 then
        REF.HtmlLabelBtn.UIHtmlLabel.text = WU.GetString("Seal_Tips5")
      end
      break
    end
  end
end

function UpdateSealState()
  m_costSeal = {}
  for i = 1, m_row do
    local container = REF.PanelSeal[i - 1].root
    for j = 1, m_col do
      local seal = container[j - 1]
      local sealDataWrap = m_sealRecord[i][j]
      local costInfo = sealDataWrap.data.info.cost
      seal.root["$SetData"](costInfo.id, costInfo.count)
      local costData = m_costSeal[costInfo.id]
      if costData == nil then
        costData = costInfo
        m_costSeal[costInfo.id] = costData
      end
      if sealDataWrap.data.fill == true then
        seal.root.UIWidget.alpha = 1
      else
        seal.root.UIWidget.alpha = 0.3
      end
      seal.root["$SetClickCallback"](function()
        OnClickSeal(i, j, sealDataWrap.data)
      end)
    end
  end
end

function InitRecord(data)
  if data == nil then
    return
  end
  m_data = data
  for i = 1, m_row do
    local recordRow = {}
    for j = 1, m_col do
      local sealData = {}
      recordRow[j] = sealData
    end
    m_sealRecord[i] = recordRow
  end
  local row = 1
  for i, v in ipairs(data.cellInfo) do
    local row = math.ceil(i / m_col)
    local col = (i - 1) % m_col + 1
    local sealData = m_sealRecord[row][col]
    if sealData then
      sealData.data = v
    end
  end
  UpdateState()
end

function UpdateState()
  UpdateSealState()
  UpdateBoxState()
  UpdateStockSeal()
end

function SetRecord(row, col, data)
  local record = m_sealRecord[row][col]
  record.state = data.state
  record.reqCount = data.reqCount
end

function Start(...)
end

function SetData(...)
end

function CheckBoxState(boxData)
  if boxData.got == true then
    return 2
  end
  if boxData.info.rewardKind == 2 then
    local bFill = 1
    for i = 1, m_row do
      local record = m_sealRecord[i][boxData.info.rewardIndex]
      if record.data.fill == false then
        bFill = 0
        break
      end
    end
    return bFill
  elseif boxData.info.rewardKind == 1 then
    local bFill = 1
    for i = 1, m_col do
      local record = m_sealRecord[boxData.info.rewardIndex][i]
      if record.data.fill == false then
        bFill = 0
        break
      end
    end
    return bFill
  elseif boxData.info.rewardKind == 3 then
    local row = 1
    local col = 1
    for i = 1, m_row do
      local seal = m_sealRecord[row][col]
      if seal.data.fill == false then
        return 0
      end
      row = row + 1
      col = col + 1
    end
    return 1
  elseif boxData.info.rewardKind == 4 then
    for i = 1, m_row do
      local rowSeal = m_sealRecord[i]
      for j = 1, m_col do
        local seal = rowSeal[j]
        if seal.data.fill == false then
          return 0
        end
      end
    end
    return 1
  end
  return 0
end

function Update()
end
