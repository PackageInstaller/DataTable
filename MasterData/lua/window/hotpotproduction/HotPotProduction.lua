local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local RU = require("Common/RedMarkUtil")
local m_cuisines, m_curCuisines, m_curKind

function SetupWindow()
  for i = 1, 4 do
    local tab = REF.TabGrid[i - 1]
    tab["$$SetClickCallback"](function()
      UpdateCurCuisines(i)
    end)
  end
  WU.BindButtonEvent(REF.BtnResearch, OnBtnResearchClick)
  LU.Bind(REF.WrapContentCuisine, {
    dataSource = function(index)
      return m_curCuisines and m_curCuisines[index]
    end,
    updateSlot = UpdateCuisineSlot
  })
end

function InitWindow()
  RU.SetRedMark("Welfare/ChineseNewYear/HotPot/CookFirst", false)
  WU.RecordFirstTimeInClient("Welfare2019CNYHotPotCook")
  this:RegisterGameEvent("HotPot/UpdateRecipeList", OnUpdateRecipeList)
  local cuisines = PB.all("ItemInfo"):where(function(k, v)
    return v.bindActivityType == PB.enum.ActivityType.Cooking and v.funcType == PB.enum.ItemFuncType.Food
  end):toarray()
  local recipeGot = this:GetData("fci/cooking-summary/").recipeGots
  m_cuisines = {
    [1] = _ENV["!"]({}),
    [2] = _ENV["!"]({}),
    [3] = _ENV["!"]({}),
    [4] = _ENV["!"]({}),
    [5] = _ENV["!"]({})
  }
  local haveCount = 0
  local allCount = #cuisines
  for i = 1, allCount do
    if cuisines[i].param[1] ~= 5 then
      local info = {}
      info.cuisine = cuisines[i]
      info.recipes = PB.all("RecipeInfo"):where(function(k, v)
        return v.food.id == info.cuisine.id
      end):distinct()
      info.recipesState = _ENV["!"]({})
      local cuisineUnlock = false
      for i = 1, #info.recipes do
        local recipeId = info.recipes[i].recipeId
        local _, v = table.find(recipeGot, function(k1, v1)
          return v1.recipeId == recipeId
        end)
        info.recipesState[i] = v ~= nil
        if v ~= nil then
          cuisineUnlock = true
        end
      end
      info.unlock = cuisineUnlock
      if info.unlock then
        haveCount = haveCount + 1
      end
      table.insert(m_cuisines[info.cuisine.param[1]], info)
    end
  end
  ShowProgress(haveCount, allCount - 1)
  UpdateCurCuisines(1)
end

function UninitWindow()
  this:UnregisterGameEvent("HotPot/UpdateRecipeList", OnUpdateRecipeList)
end

function UpdateCurCuisines(kind)
  m_curKind = kind
  REF.TabGrid[kind - 1]["$UIToggle"].value = true
  m_curCuisines = m_cuisines[kind]
  local row = #REF.WrapContentCuisine[0]["$"]
  local rowCount = math.ceil(#m_curCuisines / row)
  LU.Set(REF.WrapContentCuisine, rowCount)
end

function UpdateCuisineSlot(ref, info)
  local item = {}
  item.id = info.cuisine.id
  item.type = info.cuisine.type
  local hideCount = false
  if not info.unlock then
    hideCount = true
  end
  if info.cuisine.param[1] == 3 or info.cuisine.param[1] == 4 then
    hideCount = true
  else
    local count
    for i = 1, #info.recipes[1].ingredients do
      local itemInfo = this:GetData("fci/item/" .. info.recipes[1].ingredients[i].id) or {}
      if count == nil then
        count = itemInfo.count or 0
      else
        count = math.min(count, itemInfo.count or 0)
      end
    end
    info.recipes[1].maxCount = count
    item.count = count
  end
  ref["@info"] = info
  ref["$$SetItem"](item)
  ref["$$ShowCustom"]({
    unknown = not info.unlock,
    hideCount = hideCount
  })
  ref["$$SetClickCallback"](OnCuisineClick)
end

function OnBtnResearchClick()
  WU.AcquireWindowAsync("HotPotResearch")
end

function OnCuisineClick(go)
  local ref = _ENV["$"](go)
  local info = ref["@info"]
  if not info.unlock then
    WU.ShowHintText(WU.GetString("HotPot_CuisineNotUnlock"))
    return
  end
  this:SetData("HotPot/Cuisine", info)
  WU.AcquireWindowAsync("HotPotCuisineDetail")
end

function OnUpdateRecipeList()
  UpdateCurCuisines(m_curKind)
end

function ShowProgress(haveCount, allCount)
  local str = tostring(haveCount)
  REF.LabelHaveNum.UILabel.text = string.sub(str, 1, 1)
  REF.LabelHaveNumR.UILabel.text = string.sub(str, 2, string.len(str))
  str = tostring(allCount)
  REF.LabelAllNum.UILabel.text = string.sub(str, 1, 1)
  REF.LabelAllNumR.UILabel.text = string.sub(str, 2, string.len(str))
  REF.CollectionProgress.gameObject:SetActive(true)
end
