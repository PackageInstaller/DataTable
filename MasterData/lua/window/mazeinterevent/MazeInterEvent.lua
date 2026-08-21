local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local ACU = require("Common/ActivityUtil")
local DBH = require("Manager/DataBindingHandler")
local TU = require("Common/TextUtil")
local SE = require("Common/SkillEffect")
local m_cellData
local m_eventList = PB.all("MazeRandomGenerate")
local m_eventInfo, m_goodList, m_target, m_cellIndex, m_balance, m_mazeInfo
local m_currentRelicList = {}
local m_dungeonId, m_mazeActivityId, m_abilitySucceed, m_brachList, m_hollowList

function SetupWindow()
  LU.Bind(REF.MazeShopWrapContent, {
    updateRow = UpdateMazeShopSlot
  })
  LU.Bind(REF.MazeHollowWrapContent, {
    updateRow = UpdateMazeHollowSlot
  })
  WU.BindButtonEvent(REF.ButtonSingleBack, function()
    this:GameRequest("fci/Maze/leave-story/" .. m_mazeActivityId .. "/"):Post({
      cellIndex = m_cellData.index
    }, function(result)
      if result and result.mazeInfo then
        WU.RecycleWindow(this)
        this:SetData("fci/MazeInfo/", result.mazeInfo)
      end
    end)
  end)
  WU.BindButtonEvent(REF.ButtonClose, function()
    if m_hollowList ~= nil and not table.empty(m_hollowList) then
      WU.RecycleWindow(this)
    else
      this:GameRequest("fci/Maze/EventInteraction/" .. m_mazeActivityId .. "/"):Post({
        params = {0},
        cellIndex = m_cellData.index
      }, function(result)
        if result and result.mazeInfo then
          DBH.ResChange(result.resChange)
          WU.RecycleWindow(this)
        end
      end)
    end
  end)
  WU.BindButtonEvent(REF.ButtonSingle, function()
    this:GameRequest("fci/Maze/EventInteraction/" .. m_mazeActivityId .. "/"):Post({
      params = {0},
      cellIndex = m_cellData.index
    }, function(result)
      if result and result.mazeInfo then
        DBH.ResChange(result.resChange)
        WU.ShowRewards(result.resChange, function()
          WU.RecycleWindow(this)
          this:SetData("fci/MazeInfo/", result.mazeInfo)
        end)
      end
    end)
  end)
  WU.BindButtonEvent(REF.ButtonFight, function()
    EnterActorGroup(m_cellData)
  end)
  WU.BindButtonEvent(REF.ButtonFastFight, function()
    local fightGroupInfo = this:GetData("fci/Maze/FightActorGroup/").fightGroup
    local noMain = true
    for i = 1, 3 do
      if fightGroupInfo[1].members[i].actorUid ~= 0 then
        local actor = this:GetData("fci/mazeactor/" .. fightGroupInfo[1].members[i].actorUid)
        if 0 < actor.hp and actor.dead == false then
          noMain = false
          break
        end
      end
    end
    if noMain == true then
      WU.ShowHintText(WU.GetString("Maze_FastFightNoMain"))
      return
    end
    local members = _ENV["!"]({})
    members = fightGroupInfo[1].members
    for i = 1, 3 do
      if fightGroupInfo[1].members[i].actorUid == 0 then
        members[i + 3] = {
          index = i + 2,
          actorUid = 0
        }
        members[i] = {
          index = i - 1,
          actorUid = 0
        }
      else
        local actor = this:GetData("fci/mazeactor/" .. fightGroupInfo[1].members[i].actorUid)
        if actor.hp == 0 or actor.dead == true then
          members[i + 3] = {
            index = i + 2,
            actorUid = 0
          }
          members[i] = {
            index = i - 1,
            actorUid = 0
          }
        else
          members[i + 3] = {
            index = i + 2,
            actorUid = fightGroupInfo[1].members[i + 3].actorUid
          }
          members[i] = {
            index = i - 1,
            actorUid = fightGroupInfo[1].members[i].actorUid
          }
        end
      end
    end
    this:GameRequest("fci/Maze/FightActorGroup/" .. m_mazeActivityId .. "/"):Post({members = members}, function(result)
      this:SetData("fci/Maze/FightActorGroup/", result)
      this:GameRequest("fci/maze-dungeon-quick/" .. m_mazeActivityId .. "/"):Post({cellIndex = m_cellIndex}, function(result)
        WU.RecycleWindow("MazeInterEvent")
        SetFastFightBalance(result)
      end)
    end)
  end)
  WU.TraverseChildren(REF.ButtonBranchGrid, function(go, index)
    WU.BindButtonEvent(go, function()
      local selectIndex = index + 1
      this:GameRequest("fci/Maze/EventInteraction/" .. m_mazeActivityId .. "/"):Post({
        params = {selectIndex},
        cellIndex = m_cellData.index
      }, function(result)
        if result and result.mazeInfo then
          DBH.ResChange(result.resChange)
          WU.ShowRewards(result.resChange, function()
            WU.RecycleWindow(this)
            this:SetData("fci/MazeInfo/", result.mazeInfo)
          end)
        end
      end)
    end)
  end)
  WU.TraverseChildren(REF.ButtonCampGrid, function(go, index)
    WU.BindButtonEvent(go, function()
      local selectIndex = index + 1
      this:GameRequest("fci/Maze/EventInteraction/" .. m_mazeActivityId .. "/"):Post({
        params = {selectIndex},
        cellIndex = m_cellData.index
      }, function(result)
        if selectIndex == 1 then
          WU.ShowHintText(WU.GetString("Maze_HPRecovered"))
        elseif selectIndex == 2 then
          WU.ShowHintText(WU.GetString("Maze_SkillNumRecovered"))
        end
        SetGetReward(result)
      end)
    end)
  end)
end

function InitWindow()
  m_mazeActivityId = this:GetData("MazeActivityId")
  m_cellData = {}
  m_eventInfo = {}
  m_brachList = {}
  m_hollowList = {}
  ResetWindow()
end

function UninitWindow()
  if m_cellIndex then
    this:Unbind("MazeCellData" .. m_cellIndex, SetCellData)
  end
end

function SetData(mazeData, cellData)
  if (mazeData.mazeInfo or mazeData) and cellData then
    m_mazeInfo = mazeData.mazeInfo or mazeData
    m_cellIndex = cellData.index
    this:Unbind("MazeCellData" .. m_cellIndex, SetCellData)
    this:Bind("MazeCellData" .. m_cellIndex, SetCellData)
  end
end

function SetCellData(data)
  if data then
    m_cellData = data
    if m_cellData.data.isComplete == true then
      WU.RecycleWindow(this)
      return
    end
    local index = table.find(m_eventList, function(k, v)
      return v.eventId == m_cellData.data.eventId
    end)
    if index then
      m_eventInfo = m_eventList[index]
      if m_cellData.data.eventType == PB.enum.MazeEventType.MazeEvent_Story then
        RefreshEventStory()
      elseif m_cellData.data.eventType == PB.enum.MazeEventType.MazeEvent_Fight then
        RefreshEventFight()
      elseif m_cellData.data.eventType == PB.enum.MazeEventType.MazeEvent_Boss then
        RefreshEventBoss()
      elseif m_cellData.data.eventType == PB.enum.MazeEventType.MazeEvent_Shop then
        RefreshEventShop()
      elseif m_cellData.data.eventType == PB.enum.MazeEventType.MazeEvent_Camp then
        RefreshEventCamp()
      end
      local activeButtons = {}
      WU.TraverseChildren(REF.NodeButtonGroups, function(go, index)
        if go.activeSelf then
          WU.TraverseChildren(_ENV["$"](go).root, function(go2, index2)
            if go2.activeSelf then
              table.insert(activeButtons, go2)
            end
          end)
        end
      end)
      table.reverse(activeButtons)
      local buttonCount = #activeButtons
      local height
      if buttonCount == 1 then
        height = -130
      elseif buttonCount == 2 then
        height = -200
      else
        height = -260
      end
      local offset = 130
      for _, v in ipairs(activeButtons) do
        v.transform.localPosition = {
          x = 0,
          y = height,
          z = 0
        }
        height = height + offset
      end
    else
      error("MazeRandomGenerate has no this eventId " .. m_cellData.data.eventId)
      return
    end
  end
end

function RefreshEventFight()
  ResetWindow()
  SetSmall()
  REF.LabelDescEvent.UILabel.text = WU.GetString("Maze_EventDesc_" .. m_eventInfo.eventId .. "_" .. PB.enum.MazeEventType.MazeEvent_Fight)
  REF.SpriteEventType.UISprite.spriteName = "fight_title"
  REF.LabelDescEvent.gameObject:SetActive(true)
  REF.ButtonFight.transform.localPosition = fif(m_eventInfo.quickFightEnable ~= true, CS.UnityEngine.Vector3(0, -70, 0), CS.UnityEngine.Vector3(0, 0, 0))
  REF.ButtonFastFight.gameObject:SetActive(m_eventInfo.quickFightEnable == true)
  REF.ButtonFightGrid.gameObject:SetActive(true)
  PlayAnimator()
end

function RefreshEventStory()
  ResetWindow()
  local storyId
  local storyInfo = {}
  storyId = m_cellData.data.eventProgress
  if storyId ~= 0 then
    storyInfo = PB.get("MazeEventStoryInfo", storyId)
    if storyInfo then
      if storyInfo.storyType == PB.enum.MazeEventStoryType.MazeEventStory_Fight then
        SetSmall()
        REF.ButtonFight.transform.localPosition = fif(storyInfo.quickFightEnable ~= true, CS.UnityEngine.Vector3(0, -70, 0), CS.UnityEngine.Vector3(0, 0, 0))
        REF.ButtonFastFight.gameObject:SetActive(storyInfo.quickFightEnable == true)
        REF.ButtonFightGrid.gameObject:SetActive(true)
        SetStoryWindow(storyInfo)
      elseif storyInfo.storyType == PB.enum.MazeEventStoryType.MazeEventStory_Branch then
        SetSmall()
        WU.TraverseChildren(REF.ButtonBranchGrid, function(go, index)
          local selectIndex = index + 1
          local branchInfo = {}
          go.gameObject:SetActive(selectIndex <= #storyInfo.conditionParam)
          if selectIndex <= #storyInfo.conditionParam then
            branchInfo = PB.get("MazeEventStoryInfo", tonumber(storyInfo.conditionParam[selectIndex]))
            if branchInfo == nil then
              error("MazeEventStoryInfo.xlsx has no this id " .. storyInfo.conditionParam[selectIndex])
              return
            end
            local abilityRatio
            if branchInfo.storyType == PB.enum.MazeEventStoryType.MazeEventStory_Ability then
              abilityRatio = fif(SetAbilityRatio(branchInfo) > 100, 100, SetAbilityRatio(branchInfo))
            end
            if abilityRatio == nil then
              _ENV["$"](go).LabelButton.UILabel.text = WU.GetString("Maze_EventStorySelect_" .. storyInfo.storyId .. "_" .. selectIndex)
            else
              _ENV["$"](go).LabelButton.UILabel.text = WU.GetString("Maze_EventStorySelect_" .. storyInfo.storyId .. "_" .. selectIndex, abilityRatio)
            end
          end
        end)
        REF.ButtonBranchGrid.gameObject:SetActive(true)
        SetStoryWindow(storyInfo)
      elseif storyInfo.storyType == PB.enum.MazeEventStoryType.MazeEventStory_Ability then
        m_brachList = {}
        if storyInfo.successStoryId then
          m_brachList[1] = storyInfo.successStoryId
        end
        if storyInfo.failedStoryId then
          m_brachList[2] = storyInfo.failedStoryId
        end
        this:GameRequest("fci/Maze/EventInteraction/" .. m_mazeActivityId .. "/"):Post({
          cellIndex = m_cellData.index
        }, function(result)
          if result and result.mazeInfo then
            DBH.ResChange(result.resChange)
            WU.ShowRewards(result.resChange, function()
              WU.RecycleWindow(this)
              this:SetData("fci/MazeInfo/", result.mazeInfo)
            end)
          end
        end)
      elseif storyInfo.storyType == PB.enum.MazeEventStoryType.MazeEventStory_ItemEnough or storyInfo.storyType == PB.enum.MazeEventStoryType.MazeEventStory_ItemCost then
        this:GameRequest("fci/Maze/EventInteraction/" .. m_mazeActivityId .. "/"):Post({
          cellIndex = m_cellData.index
        }, function(result)
          if result and result.mazeInfo then
            DBH.ResChange(result.resChange)
            WU.ShowRewards(result.resChange, function()
              WU.RecycleWindow(this)
              this:SetData("fci/MazeInfo/", result.mazeInfo)
            end)
          end
        end)
      elseif storyInfo.storyType == PB.enum.MazeEventStoryType.MazeEventStory_Speech then
        SetSmall()
        local selectIndex = 1
        REF.LabelSingle.UILabel.text = WU.GetString("Maze_EventStorySelect_" .. storyInfo.storyId .. "_" .. selectIndex)
        REF.ButtonSingle.gameObject:SetActive(true)
        SetStoryWindow(storyInfo)
      else
        error("Has no this storyType " .. storyInfo.storyType)
        return
      end
    else
      error("MazeEventStoryInfo has no storyId " .. storyId)
      return
    end
  else
    WU.RecycleWindow(this)
  end
end

function SetStoryWindow(storyInfo)
  REF.LabelDescEvent.UILabel.text = WU.GetString("Maze_EventStoryDesc_" .. storyInfo.storyId)
  REF.LabelDescEvent.gameObject:SetActive(true)
  REF.ButtonSingleBack.gameObject:SetActive(storyInfo.storyCanLeave and storyInfo.storyCanLeave == 1)
  if storyInfo.storyIcon and storyInfo.storyIcon ~= "" then
    REF.SpriteEventType.UISprite.spriteName = storyInfo.storyIcon
  else
    REF.SpriteEventType.UISprite.spriteName = "question_title"
  end
  PlayAnimator()
end

function RefreshEventBoss()
  ResetWindow()
  SetSmall()
  REF.LabelDescEvent.UILabel.text = WU.GetString("Maze_EventDesc_" .. m_eventInfo.eventId .. "_" .. PB.enum.MazeEventType.MazeEvent_Boss)
  REF.SpriteEventType.UISprite.spriteName = "boss_title"
  REF.LabelDescEvent.gameObject:SetActive(true)
  REF.ButtonFight.transform.localPosition = fif(m_eventInfo.quickFightEnable ~= true, CS.UnityEngine.Vector3(0, -70, 0), CS.UnityEngine.Vector3(0, 0, 0))
  REF.ButtonFastFight.gameObject:SetActive(m_eventInfo.quickFightEnable == true)
  REF.ButtonFightGrid.gameObject:SetActive(true)
  PlayAnimator()
end

function RefreshEventShop()
  ResetWindow()
  SetBig()
  if m_mazeInfo and m_mazeInfo.shopInfo and m_mazeInfo.shopInfo.goodsInfo and not table.empty(m_mazeInfo.shopInfo.goodsInfo) then
    OnGoodsInfo(m_mazeInfo.shopInfo.goodsInfo)
    REF.LabelDescEvent.UILabel.text = WU.GetString("Maze_EventDesc_" .. m_eventInfo.eventId .. "_" .. PB.enum.MazeEventType.MazeEvent_Shop)
    REF.SpriteEventType.UISprite.spriteName = "store_title"
    REF.NodeStock.gameObject:SetActive(true)
    REF.LabelDescEvent.gameObject:SetActive(true)
    REF.NodeMazeShopList.gameObject:SetActive(true)
  end
  REF.ButtonClose.gameObject:SetActive(true)
  PlayAnimator()
end

function RefreshEventCamp()
  ResetWindow()
  SetSmall()
  WU.TraverseChildren(REF.ButtonCampGrid, function(go, index)
    local selectIndex = index + 1
    _ENV["$"](go).LabelButton.UILabel.text = WU.GetString("Maze_EventCampSelect_" .. selectIndex)
  end)
  REF.LabelDescEvent.UILabel.text = WU.GetString("Maze_EventDesc_" .. m_eventInfo.eventId .. "_" .. PB.enum.MazeEventType.MazeEvent_Camp)
  REF.SpriteEventType.UISprite.spriteName = "camp_title"
  REF.LabelDescEvent.gameObject:SetActive(true)
  REF.ButtonCampGrid.gameObject:SetActive(true)
  REF.ButtonClose.gameObject:SetActive(false)
  PlayAnimator()
end

function EnterActorGroup(m_cellData)
  this:SetData("MazeSelectIndex", m_cellData.index)
  DB:GameRequest("fci/Maze/Actor/" .. m_mazeActivityId .. "/"):Get(function(res)
    this:SetData("fci/Maze/Actor/" .. m_mazeActivityId .. "/", res)
    WU.AcquireWindowAsync("MazeNewActorSelect", function(window)
      _ENV["$"](window)["$$SetMode"](2)
    end)
  end)
end

function ResetWindow()
  REF.ButtonBranchGrid.gameObject:SetActive(false)
  REF.ButtonFightGrid.gameObject:SetActive(false)
  REF.ButtonCampGrid.gameObject:SetActive(false)
  REF.NodeMazeShopList.gameObject:SetActive(false)
  REF.NodeStock.gameObject:SetActive(false)
  REF.LabelDescEvent.gameObject:SetActive(false)
  REF.ButtonClose.gameObject:SetActive(false)
  REF.ButtonSingle.gameObject:SetActive(false)
  REF.SpriteEventType.gameObject:SetActive(false)
  REF.ButtonNextFloorGrid.gameObject:SetActive(false)
  REF.ButtonSingleBack.gameObject:SetActive(false)
  REF.TextureBG.gameObject:SetActive(false)
  REF.NodeMazeHollowList.gameObject:SetActive(false)
end

function OnGoodsInfo(goods)
  if goods then
    m_goodList = {}
    REF.LabelStock.ResourcePrinter:SetResource(PB.enum.ResourceType.ResItem, 55004)
    for i = 1, #goods do
      table.insert(m_goodList, goods[i])
    end
    REF.NodeMazeShopList.gameObject:SetActive(true)
    LU.Set(REF.MazeShopWrapContent, #m_goodList)
  end
end

function UpdateMazeShopSlot(goRef, wrapIndex, realIndex)
  if m_goodList ~= nil and realIndex ~= nil and realIndex < #m_goodList then
    local pCost = {
      type = m_goodList[realIndex + 1].cost.type,
      id = m_goodList[realIndex + 1].cost.id,
      count = m_goodList[realIndex + 1].cost.count
    }
    local pReward = {
      type = m_goodList[realIndex + 1].reward.type,
      id = m_goodList[realIndex + 1].reward.id,
      count = m_goodList[realIndex + 1].reward.count
    }
    goRef.WidgetIconSlot["$SetData"](pReward.type, pReward.id, pReward.count)
    if pReward.type == PB.enum.ResourceType.ResMazeHollow then
      goRef.LabelTitle.UILabel.text = WU.GetString("Maze_HollowName_" .. pReward.id)
      goRef.LabelDesc.UILabel.text = WU.GetString("Maze_HollowDesc_" .. pReward.id)
    elseif pReward.type == PB.enum.ResourceType.ResItem then
      goRef.LabelTitle.UILabel.text = WU.GetString("ItemName_" .. pReward.id)
      goRef.LabelDesc.UILabel.text = WU.GetString("Maze_ItemDesc_" .. pReward.id)
    end
    goRef.LabelCost.ResourcePrinter:SetResource(pCost.type, pCost.id, pCost.count)
    local isSoldOut = m_goodList[realIndex + 1].buyLimited
    WU.SetActive(goRef.SpriteSoldOut, isSoldOut)
    WU.SetActive(goRef.ButtonBuy, not isSoldOut)
    if not isSoldOut then
      WU.ClearButtonEvent(goRef.ButtonBuy)
      WU.BindButtonEvent(goRef.ButtonBuy, function()
        WU.TryToPay(pCost.type, pCost.id, pCost.count, function()
          local selectIndex = realIndex + 1
          this:GameRequest("fci/Maze/EventInteraction/" .. m_mazeActivityId .. "/"):Post({
            params = {selectIndex},
            cellIndex = m_cellData.index
          }, function(result)
            SetGetReward(result)
            WU.RecycleWindow(this)
          end)
        end)
      end)
    end
  end
end

function SetBig()
  REF.TextureBG.gameObject:SetActive(true)
  REF.TextureBG.UITexture.height = 1120
  REF.TextureBG.UITexture.width = 1225
  REF.LabelDescEvent.UILabel.width = 900
  REF.LabelDescEvent.transform.localPosition = CS.UnityEngine.Vector3(-230, 195, 0)
  REF.NodeTweenType.transform.localPosition = CS.UnityEngine.Vector3(0, 70, 0)
end

function SetSmall()
  REF.TextureBG.gameObject:SetActive(true)
  REF.TextureBG.UITexture.height = 1024
  REF.TextureBG.UITexture.width = 1024
  REF.LabelDescEvent.UILabel.width = 700
  REF.LabelDescEvent.transform.localPosition = CS.UnityEngine.Vector3(-230, 130, 0)
  REF.NodeTweenType.transform.localPosition = CS.UnityEngine.Vector3(0, 20, 0)
end

function SetFastFightBalance(result)
  WU.AcquireWindowAsync("MazeFastFightBalance", function(window)
    _ENV["$"](window)["$$SetData"](result)
  end)
end

function OnHollowChanged(result)
  m_currentRelicList = {}
  if result and result.hollowDetails then
    for i = 1, 12 do
      m_currentRelicList[i] = 0
    end
    for k, v in pairs(result.hollowDetails) do
      m_currentRelicList[k] = v
    end
  end
end

function SelectHollow(data)
  if data == nil or table.empty(data) then
    WU.RecycleWindow(this)
    return
  end
  local index, info
  for k, v in pairs(data) do
    if k then
      index = k
      info = v
      break
    end
  end
  local pos = info.param
  local realPos
  for i = (pos - 1) * 4 + 1, pos * 4 do
    if m_currentRelicList[i] == 0 then
      realPos = i
      break
    end
  end
  if realPos then
    DB:GameRequest("fci/Maze/Hollow/" .. index .. "/" .. m_mazeActivityId .. "/"):Patch(nil, function(result)
      if result then
        WU.ShowHintText(WU.GetString("Maze_RelicHasPut") .. WU.GetString("Maze_HollowName_" .. info.id))
        this:SetData("fci/Maze/Hollow/" .. m_mazeActivityId .. "/", result)
        WU.RecycleWindow(this)
      end
    end)
  else
    WU.AcquireWindowAsync("MazeRelicChange", function(window)
      _ENV["$"](window)["$$SetData"](pos, 0)
      WU.RecycleWindow(this)
    end)
  end
end

function SetGetReward(result)
  if result and result.mazeInfo then
    DBH.ResChange(result.resChange)
    if result.mazeInfo.dropHollows and not table.empty(result.mazeInfo.dropHollows) then
      local info = {}
      for k, v in pairs(result.mazeInfo.dropHollows) do
        if v then
          table.copy(v, info, true)
          break
        end
      end
      info.countDelta = 1
      info.param = 0
      table.insert(result.resChange, {
        baseRes = info,
        multiple = 0,
        inBox = {},
        profitId = 0,
        extra = false
      })
    end
    WU.ShowRewards(result.resChange, function()
      this:SetData("fci/MazeInfo/", result.mazeInfo)
    end)
  end
end

function SetNextFloor(callBackYes, callBackNo, isLastFloor)
  WU.BindButtonEvent(REF.ButtonYes, function()
    callBackYes()
  end)
  WU.BindButtonEvent(REF.ButtonNo, function()
    callBackNo()
  end)
  ResetWindow()
  SetSmall()
  REF.ButtonNextFloorGrid.gameObject:SetActive(true)
  REF.LabelDescEvent.gameObject:SetActive(true)
  REF.LabelDescEvent.UILabel.text = fif(isLastFloor, WU.GetString("Maze_IsMazeOver"), WU.GetString("Maze_GoToNextMaze"))
  REF.SpriteEventType.UISprite.spriteName = fif(isLastFloor, "exit_title_2", "exit_title_1")
  PlayAnimator()
end

function PlayAnimator()
  REF["$Animator"]:Play("Open", -1, 0)
  this:DelayInvokeInSeconds(0.1, function()
    REF.SpriteEventType.gameObject:SetActive(true)
  end)
end

function SetAbilityRatio(branchInfo)
  local successRate = {}
  local logicRelation = tonumber(branchInfo.conditionParam[1])
  for i = 1, (#branchInfo.conditionParam - 1) / 3 do
    local abilityType = tonumber(branchInfo.conditionParam[(i - 1) * 3 + 2])
    local baseRate = tonumber(branchInfo.conditionParam[(i - 1) * 3 + 3])
    local baseAddRate = tonumber(branchInfo.conditionParam[(i - 1) * 3 + 4])
    local researchInfo = this:GetData("fci/Maze/Research/" .. m_mazeActivityId .. "/")
    local abilityValue = 0
    if researchInfo then
      abilityValue = researchInfo.researchAbility[abilityType]
    end
    local rate = (baseRate + abilityValue * baseAddRate) / 10000
    successRate[i] = rate
  end
  if successRate[2] == nil then
    successRate[2] = 0
  end
  if logicRelation == PB.enum.LogicOperator.And then
    return math.floor(successRate[1] * successRate[2] * 100)
  elseif logicRelation == PB.enum.LogicOperator.Or then
    return math.floor((successRate[1] + successRate[2] - successRate[1] * successRate[2]) * 100)
  else
    return 0
  end
end

function SetMazeHollow()
  this:Bind("fci/mazeHollow/", OnRefreshHollows)
end

function UpdateMazeHollowSlot(goRef, wrapIndex, realIndex)
  if m_hollowList ~= nil and realIndex ~= nil and realIndex < #m_hollowList then
    local data = m_hollowList[realIndex + 1]
    goRef.WidgetIconSlot["$SetData"](PB.enum.ResourceType.ResMazeHollow, data.id)
    goRef.LabelTitle.UILabel.text = WU.GetString("Maze_HollowName_" .. data.id)
    goRef.LabelDesc.UILabel.text = GetAttrsText(data.id)
    goRef.WidgetIconSlot["$SetClickCallback"](function()
      WU.ShowResourceDetail(PB.enum.ResourceType.ResMazeHollow, data.id)
    end)
  end
end

function OnRefreshHollows(result)
  ResetWindow()
  SetBig()
  m_hollowList = {}
  if result then
    for k, v in pairs(result) do
      if v.count > 0 then
        table.insert(m_hollowList, v)
      end
    end
    REF.NodeMazeHollowList.gameObject:SetActive(true)
    LU.Set(REF.MazeHollowWrapContent, #m_hollowList)
  end
  REF.ButtonClose.gameObject:SetActive(true)
  REF["$Animator"]:Play("Open", -1, 0)
end

function GetAttrsText(id)
  local hollowInfo = PB.get("MazeEquipmentInfo", id)
  local hollowAffixText
  if hollowInfo and hollowInfo.buffId then
    local tpl = WU.GetString("AffixDesc_" .. hollowInfo.buffId)
    local tplParam = SE.GetAffixTplParam(hollowInfo.buffId)
    if tplParam == nil then
      return
    else
      hollowAffixText = TU.render(tpl, tplParam)
      return hollowAffixText
    end
  else
    error("MazeEquipmentInfo.xlsx has no id " .. id)
    return
  end
end
