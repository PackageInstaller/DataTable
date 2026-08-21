local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local HU = require("Common/HtmlUtil")
local RU = require("Common/RedMarkUtil")
local m_cuisine, m_maxAmount, m_curCount
local m_plateMaxNum = 8
local m_isBuff

function SetupWindow()
  for i = 1, 5 do
    local tab = REF.TabGrid[i - 1]
    tab["$$SetClickCallback"](function()
      SwitchRecipe(i)
    end)
    tab["$$SetTabText"]()
  end
  WU.BindButtonEvent(REF.BtnProduction, OnBtnProductionClick)
  WU.BindButtonEvent(REF.BtnResearch, OnBtnResearchClick)
  REF.WidgetNumberEdit["$SetNumberUpdateCallback"](OnAmountChange)
  REF.WidgetNumberEdit["$SetShowMax"](true)
end

function InitWindow()
  this:Bind("HotPot/Cuisine", UpdateView)
end

function UninitWindow()
  this:Unbind("HotPot/Cuisine", UpdateView)
end

function UpdateView(data)
  m_cuisine = data
  m_isBuff = m_cuisine.cuisine.param[1] == 3
  WU.SetActive(REF.Left, m_isBuff)
  WU.SetActive(REF.LabelLevel, m_isBuff)
  if m_isBuff then
    local recipeCount = #m_cuisine.recipes
    local level = 0
    for i = 1, 5 do
      local tab = REF.TabGrid[i - 1]
      WU.SetActive(tab.root, i <= recipeCount)
      if i <= recipeCount then
        local content = fif(m_cuisine.recipesState[i], WU.GetString("HotPot_Plan", WU.GetString("Window_Number_" .. i)), WU.GetString("HotPot_PlanUnknown"))
        tab["$$SetTabText"](content)
        level = level + fif(m_cuisine.recipesState[i], 1, 0)
      end
      REF.TabGrid.UIGrid:Reposition()
    end
    REF.LabelLevel.UILabel.text = WU.GetString("Window_Level", level)
  end
  REF.Right.transform.localPosition = fif(m_isBuff, {
    x = 240,
    y = 0,
    z = 0
  }, {
    x = 0,
    y = 0,
    z = 0
  })
  REF.NodeRecipeInfo.transform.localPosition = fif(m_isBuff, {
    x = 0,
    y = 0,
    z = 0
  }, {
    x = 0,
    y = 48,
    z = 0
  })
  REF.NodeOperation.transform.localPosition = fif(m_isBuff, {
    x = 45,
    y = -285,
    z = 0
  }, {
    x = 45,
    y = -262,
    z = 0
  })
  REF.NodeCuisine[0]["$$SetItem"](m_cuisine.cuisine)
  REF.NodeCuisine[0]["$$ShowCustom"]({hideCount = true})
  REF.LabelName.UILabel.text = WU.GetString("ItemName_" .. m_cuisine.cuisine.id)
  local content1 = WU.GetString("ItemDescribe_" .. m_cuisine.cuisine.id)
  local title2 = "RecipeDesc_" .. m_cuisine.cuisine.id
  local content2 = WU.GetString(title2)
  local mixContent = content1
  if content2 ~= title2 and content2 ~= "" then
    mixContent = mixContent .. content2
  end
  REF.LabelDesc.UILabel.text = mixContent
  SwitchRecipe(1)
end

function SwitchRecipe(index)
  if m_isBuff then
    REF.TabGrid[index - 1]["$UIToggle"].value = true
  end
  local recipe = m_cuisine.recipes[index]
  local unlock = m_cuisine.recipesState[index]
  local showProduction = m_cuisine.cuisine.param[1] == 1 or m_cuisine.cuisine.param[1] == 2
  local showResearch = m_cuisine.cuisine.param[1] == 3 and not unlock
  for i = 0, #REF.NodeIngredients - 1 do
    local ref = REF.NodeIngredients[i]
    if showResearch then
      WU.SetActive(ref.Content, false)
      WU.SetActive(ref.SelectedNode, false)
      WU.SetActive(ref.TextureQuestion, true)
      ref["$$SetClickCallback"]()
    else
      WU.SetActive(ref.Content, true)
      local ingredient = recipe.ingredients[i + 1]
      ref["$$SetItem"](ingredient)
      ref["$$ShowCustom"]({hideCount = true})
      ref["$$SetClickCallback"](function(go)
        WU.ShowResourceDetail(ingredient.type, ingredient.id)
      end)
    end
  end
  WU.SetActive(REF.NodeOperation, showProduction or showResearch)
  WU.SetActive(REF.NodeProduction, showProduction)
  WU.SetActive(REF.NodeResearch, showResearch)
  WU.SetActive(REF.NodeCounts, showProduction)
  if showProduction then
    SetCountChanger()
  end
end

function SetCountChanger()
  REF.WidgetNumberEdit["$SetNumber"](1, true)
  m_maxAmount = m_cuisine.recipes[1].maxCount
  if m_maxAmount == 0 then
    REF.WidgetNumberEdit["$SetRange"](1, 1)
  else
    REF.WidgetNumberEdit["$SetRange"](1, m_maxAmount)
  end
end

function OnAmountChange(count)
  m_curCount = count
  local ingredients = m_cuisine.recipes[1].ingredients
  for i = 0, #REF.NodeCounts - 1 do
    local item = this:GetData("fci/item/" .. ingredients[i + 1].id) or {}
    local haveCount = item.count or 0
    local needCount = count
    local haveStr = tostring(haveCount)
    local needStr = "1"
    if haveCount < needCount then
      haveStr = HU.ApplyFontColor(haveStr, HU.ColorDefines.Error)
    end
    REF.NodeCounts[i]["$UIHtmlLabel"].text = haveStr .. "/" .. needStr
  end
end

function OnBtnProductionClick()
  if m_curCount > m_cuisine.recipes[1].maxCount then
    return
  end
  local summary = this:GetData("fci/cooking-summary/")
  local cuisines = summary.placedFoods
  local count = #cuisines
  if count == m_plateMaxNum then
    WU.ShowHintText(WU.GetString("HotPot_TableFull"))
    return
  end
  local cost = _ENV["!"]({})
  local count = m_curCount
  for i = 1, #m_cuisine.recipes[1].ingredients do
    local ingredient = m_cuisine.recipes[1].ingredients[i]
    local item = {
      id = ingredient.id,
      type = ingredient.type,
      count = count
    }
    table.insert(cost, item)
  end
  this:GameRequest("fci/cooking"):Post({
    recipeId = m_cuisine.recipes[1].recipeId,
    ingredients = cost,
    foodsCount = count
  }, function(res)
    DBH.ResChange(res.resChange)
    m_cuisine.recipes[1].maxCount = m_cuisine.recipes[1].maxCount - count
    SetCountChanger()
    summary.placedFoods = res.placedFoods
    if res.placedFoods and res.placedFoods[1] and WU.IsFirstTimeInClient("Welfare2019CNYHotPotEat") then
      RU.SetRedMark("Welfare/ChineseNewYear/HotPot/EatFirst", true)
    end
    this:SetData("fci/cooking-summary/", summary)
    this:BroadcastGameEvent("HotPot/UpdateRecipeList")
    this:SetData("HotPot/ProductionResult", {
      item = m_cuisine.cuisine,
      count = count
    })
    WU.AcquireWindowAsync("HotPotProductionResult")
  end)
end

function OnBtnResearchClick()
  WU.AcquireWindowAsync("HotPotResearch")
end
