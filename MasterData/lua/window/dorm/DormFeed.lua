local Base = inherit("Window/Dorm/DormBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DormUtil")
local U = require("Common/Util")
local AI = require("Common/DormAI")
local DBH = require("Manager/DataBindingHandler")
local SIZE = CS.UnityEngine.Vector3(18, 18, 9)
local m_dormInfo, m_dorm, m_agentMap, m_AIController, m_inited, m_feedSeats, m_remainingTime, m_elapsedTime, m_shopGoods

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonExtend, OnClickExtend)
  WU.BindButtonEvent(REF.ButtonActorSelect, OnClickActorSelect)
  for i = 0, #REF.GridFood - 1 do
    WU.BindButtonEvent(REF.GridFood[i].root, OnClickFood)
    WU.BindButtonEvent(REF.GridFood[i].SpriteAdd, function()
      OnClickAddFood(REF.GridFood[i].root)
    end)
    WU.SetActive(REF.GridFood[i].root, false)
  end
  local rt = CS.GameGlobal.Instance:AcquireRenderTextureContext("__dorm").m_rt
  REF.DormRT.UITexture.mainTexture = rt
  REF.DormRT.UITexture.width = rt.width
  SetupBase(REF.DormHome)
end

function InitWindow()
  this:Bind("fci/dorm/{playerId}", OnDormChange)
  this:BindRemote(this:GameRequest("fci/Shop/" .. PB.index("Misc", 1).dormFoodShopId .. "/Goods"), OnDormFoodShopChange)
  this:RepeatInvokeInSeconds(1, UpdateCountdown)
  this:RegisterGameEvent("OnShopPurchaseSuccess", OnShopPurchaseSuccess)
  CS.GameGlobal.Instance:AssignCameraRenderTexture(REF.DormCamera.Camera, "__dorm")
  local foodConfigs = PB.all("DormFoodConfig")
  for idx, config in ipairs(foodConfigs) do
    this:Bind("fci/item/" .. config.foodId, function(data)
      OnItemChange(idx, data)
    end)
  end
  m_aiOptions.enableActorInteractive = false
end

function UninitWindow()
  m_inited = false
  m_feedSeats = nil
  UninitRestaurant()
  this:BroadcastGameEvent("DormNeedReload")
end

function UpdateWindow(deltaTime)
  if m_AIController then
    m_AIController:Update(deltaTime)
  end
end

function OnDormChange(data)
  if data then
    m_dormInfo = data.dormInfo
    REF.SpriteProgress.UISprite.fillAmount = m_dormInfo.foodCount / m_dormInfo.foodCountMax
    REF.LabelFood.UILabel.text = string.format("%d/%d", m_dormInfo.foodCount, m_dormInfo.foodCountMax)
    if not U.ListElementIsSame(m_feedSeats, m_dormInfo.feedSeat) then
      m_feedSeats = _ENV["!"](m_dormInfo.feedSeat):where(function(k, v)
        return v ~= 0
      end):toarray()
      if m_inited then
        ReloadRestaurant()
      else
        InitRestaurant()
        m_inited = true
      end
    end
    SetCountdown()
  end
end

function OnDormFoodShopChange(data)
  m_shopGoods = data
  WU.SetActive(REF.GridFood, m_shopGoods ~= nil)
end

function OnItemChange(idx, data)
  local widget = REF.GridFood[idx - 1]
  WU.SetActive(widget.root, data ~= nil)
  if data then
    widget["@foodId"] = data.id
    widget["@foodIndex"] = idx
    _ENV["$"](widget.SpriteAdd)["@foodId"] = data.id
    local widgetIconItem = widget.WidgetIconItem
    widgetIconItem["$ResetState"]()
    widgetIconItem["$SetData"](data.id, data.count)
  end
end

function InitRestaurant()
  InitBase(SIZE)
  LoadStatic()
  UpdateMovableBoard()
  InitAIController()
  LoadDynamic()
  UpdateMovableBoard()
  RearrangeAllBox()
end

function UninitRestaurant()
  m_root.borderList:Clear()
  m_root.boxList:Clear()
  for i = 0, m_root.transform.childCount - 1 do
    CS.UnityEngine.GameObject.Destroy(m_root.transform:GetChild(i).gameObject)
  end
  m_AIController = nil
end

function LoadStatic()
  local furnitures = PB.get("DormInitialTheme", 999).arrangement.furnitures
  for _, furn in ipairs(furnitures) do
    local xlsxConfig = PB.get("FurnitureConfig", furn.furnitureId)
    local prefabName = "furniture_" .. furn.furnitureId
    local go = WU.InstantiateWindowPrefabAttached(REF.DormRoot, "Dorm/Furniture/" .. prefabName, prefabName)
    local box = go:GetComponent(typeof(CS.IsometricGame.IsometricBox))
    box.isoPosition = furn.position
    box.flip = furn.flip
    box:AddToRoot(m_root)
  end
end

function LoadDynamic()
  for i = 1, #m_feedSeats do
    local uid = m_feedSeats[i]
    local go = WU.InstantiateWindowPrefabAttached(REF.DormRoot, "Dorm/dormActorTemplate", "dormActorTemplate")
    local box = go:GetComponent(typeof(CS.IsometricGame.IsometricBox))
    box.isoPosition = {
      x = i * 3,
      y = 16,
      z = 0
    }
    box:AddToRoot(m_root)
    local dynamicAgent = _ENV["$"](go).root
    m_agentMap[box] = dynamicAgent
    local actorId = this:GetData("fci/actor/" .. uid).id
    dynamicAgent["$Init"](actorId, _ENV, m_AIController)
  end
end

function ReloadRestaurant()
  UninitRestaurant()
  InitRestaurant()
end

function InitAIController()
  m_agentMap = {}
  m_AIController = AI.NewController(m_root, m_board, m_agentMap)
end

function UpdateMovableBoard()
  Base.UpdateMovableBoard(m_root.boxList)
end

function SetCountdown()
  local seatCnt = _ENV["!"](m_feedSeats):where(function(k, v)
    return v ~= 0
  end):count()
  local const = PB.index("Misc", 1).dormFoodActorCost.actorFoodConst[seatCnt] or 0
  local interval = PB.index("Misc", 1).dormFoodRefreshInterval
  m_remainingTime = math.floor(m_dormInfo.foodCount / const * interval)
  m_elapsedTime = 0
  UpdateCountdown()
end

function UpdateCountdown()
  if m_remainingTime and m_remainingTime ~= math.huge and not isNaN(m_remainingTime) then
    m_elapsedTime = m_elapsedTime + 1
    REF.LabelCountdown.UIHtmlLabel.text = WU.GetString("Dorm_FeedCountDown", WU.RenderCountDownTime(math.max(0, m_remainingTime - m_elapsedTime), 32, false, true))
  else
    REF.LabelCountdown.UIHtmlLabel.text = ""
  end
end

function OnShopPurchaseSuccess(result)
  DBH.ResChange(result.resChange)
  this:DelayInvokeInFrames(1, function()
    WU.ShowRewards(result.resChange)
  end)
end

function OnClickFood(go)
  local id = _ENV["$"](go)["@foodId"]
  if this:GetData("fci/item/" .. id).count == 0 then
    OnClickAddFood(go)
  else
    this:GameRequest("fci/dorm-food-add"):Post({id = id, count = 1}, function(resp)
      DBH.ResChange(resp.resChange)
      m_dormInfo.foodCount = resp.foodCount
      m_dormInfo.foodInfo = resp.foodInfo
      this:SetData("fci/dorm/{playerId}", {dormInfo = m_dormInfo})
    end)
  end
end

function OnClickAddFood(go)
  local foodIndex = _ENV["$"](go)["@foodIndex"]
  local shopId = PB.index("Misc", 1).dormFoodShopId
  this:SetData("Shop/Id", shopId)
  this:SetData("Shop/Goods", this:GetData("fci/Shop/" .. shopId .. "/Goods")[foodIndex])
  WU.AcquireWindowAsync("ShopBuy")
end

function OnClickExtend()
  local extensionConfigs = PB.all("DormExtensionCost"):where(function(k, v)
    return v.extType == PB.enum.DormExtensionType.Food
  end):toarray():sort(function(a, b)
    return a.target < b.target
  end)
  local idx, _ = table.find(extensionConfigs, function(k, v)
    return v.target == m_dormInfo.foodCountMax
  end)
  local config = extensionConfigs[(idx or 0) + 1]
  if config then
    DU.ShowExtendMessage(PB.enum.DormExtensionType.Food, config.target, function(resp)
      m_dormInfo.foodCountMax = config.target
      this:SetData("fci/dorm/{playerId}", {dormInfo = m_dormInfo})
      WU.ShowHintText("Dorm_ExtendFoodSucceed")
    end)
  end
end

function OnClickActorSelect()
  WU.AcquireWindowAsync("DormActorSelectExp")
end
