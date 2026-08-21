local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local ACU = require("Common/ActivityUtil")
local DBH = require("Manager/DataBindingHandler")
local SE = require("Common/SkillEffect")
local TU = require("Common/TextUtil")
local m_relicList = {}
local m_currentRelicList = {}
local m_index, m_selectRelicPosition, m_mazeActivityId, m_clickCallback, m_canClickConfirm

function SetupWindow()
  WU.TraverseChildren(REF.NodeSlots, function(go, index)
    local ref = _ENV["$"](go)
    WU.BindButtonEvent(ref.BG, function()
      m_index = index + 1
      ResetSelect()
    end)
  end)
  WU.BindButtonEvent(REF.ButtonClose, function()
    this:GameRequest("fci/Maze/Hollow/" .. m_mazeActivityId .. "/"):Delete(function()
      WU.RecycleWindow(this)
    end)
  end)
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    if m_index and m_canClickConfirm == true then
      DB:GameRequest("fci/Maze/Hollow/" .. m_index .. "/" .. m_mazeActivityId .. "/"):Patch(nil, function(result)
        if result then
          DBH.ResChange(result.resChange)
          local mazeInfo = DB:GetData("fci/MazeInfo/")
          mazeInfo.dropHollows = {}
          DB:SetData("fci/MazeInfo/", mazeInfo)
          WU.ShowRewards(result.resChange, function()
            if m_clickCallback then
              m_clickCallback()
            end
          end)
        end
      end)
    end
  end)
end

function InitWindow()
  m_mazeActivityId = this:GetData("MazeActivityId")
  m_index = nil
  m_clickCallback = nil
  m_canClickConfirm = true
  m_relicList = {}
  REF.ButtonConfirm.UISprite.spriteName = "disable_button_01"
  REF.LabelConfirm.UILabel.color = CS.NGUIMath.HexToColor(1448498908)
  REF.NodeSlots.gameObject:SetActive(false)
end

function ResetSelect()
  WU.TraverseChildren(REF.NodeSlots, function(go, index)
    local ref = _ENV["$"](go)
    if index + 1 == m_index then
      ref.SpriteSelect.gameObject:SetActive(true)
      REF.ButtonConfirm.UISprite.spriteName = "yellow_button_01"
      REF.LabelConfirm.UILabel.color = CS.NGUIMath.HexToColor(810386175)
    else
      ref.SpriteSelect.gameObject:SetActive(false)
    end
  end)
end

function SetData(data)
  if data then
    ResetSelect()
    m_relicList = data
    RefreshRelicGrid()
  end
end

function RefreshRelicGrid()
  if m_relicList and not table.empty(m_relicList) then
    for i = 1, #REF.NodeSlots do
      local ref = REF.NodeSlots[i - 1]
      local hollowInfo = PB.get("MazeEquipmentInfo", m_relicList[i].id)
      local hollowAffixText
      if hollowInfo and hollowInfo.buffId then
        local tpl = WU.GetString("AffixDesc_" .. hollowInfo.buffId)
        local tplParam = SE.GetAffixTplParam(hollowInfo.buffId)
        if tplParam == nil then
          return
        else
          hollowAffixText = TU.render(tpl, tplParam)
        end
      else
        error("MazeEquipmentInfo.xlsx has no id " .. id)
        return
      end
      ref.LabelTitle.UILabel.text = WU.GetString("Maze_HollowName_" .. m_relicList[i].id)
      ref.LabelDesc.UIHtmlLabel.text = hollowAffixText
      _ENV["$"](ref.WidgetIconSlotRelicItem)["$$SetData"](m_relicList[i].type, m_relicList[i].id)
      _ENV["$"](ref.WidgetIconSlotRelicItem)["$$SetClickCallback"]()
      ref.LabelRelicPos.gameObject:SetActive(false)
    end
    REF.NodeSlots.gameObject:SetActive(true)
  end
end

function SetClickCallBack(callBack)
  m_clickCallback = callBack
end
