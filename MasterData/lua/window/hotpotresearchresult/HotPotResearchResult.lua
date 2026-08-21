local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local ACU = require("Common/ActivityUtil")
local m_recipe, m_recipeConfig

function SetupWindow()
  WU.BindButtonEvent(REF.BtnContinue, OnBtnContinueClick)
end

function InitWindow()
  WU.SetLockFlag(WU.LockInputFlag.UITransition, true)
  WU.SetActive(REF.TweenContent, false)
  WU.SetActive(REF.EffectCuisine, false)
  m_recipe = this:GetData("HotPot/ResearchResult")
  m_recipeConfig = PB.get("RecipeInfo", m_recipe.recipeId)
  UpdateView()
end

function UpdateView()
  local cuisineId = m_recipeConfig.food.id
  local cuisineInfo = PB.get("ItemInfo", cuisineId)
  local icon = cuisineInfo.icon
  local changeIcon = ACU.ReplaceIconRes(cuisineId)
  if changeIcon then
    icon = changeIcon
  end
  local tex = WU.AcquireAsset("Texture/Welfare/new_year/Food_" .. cuisineId)
  _ENV["$"](REF.EffectCuisine).FoodIcon.MeshRenderer.material:SetTexture("_MainTex", tex)
  WU.SetActive(REF.EffectCuisine, true)
  REF.EffectCuisine.EffectGenerator:Play()
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_cook_result")
  REF.LabelName.UILabel.text = WU.GetString("ItemName_" .. cuisineId)
  REF.LabelDesc.UILabel.text = WU.GetString("ItemDescribe_" .. cuisineId)
  local showReward = false
  if m_recipeConfig.rewards then
    local count = #m_recipeConfig.rewards
    if count ~= 0 then
      showReward = true
    end
  end
  if showReward then
    for i = 0, #REF.Rewards - 1 do
      local reward = m_recipeConfig.rewards[i + 1]
      WU.SetActive(REF.Rewards[i].root, reward)
      if reward then
        REF.Rewards[i]["$$SetItem"](reward)
      end
    end
  end
  this:DelayInvokeInSeconds(0.5, function()
    if showReward then
      WU.SetActive(REF.Rewards, false)
    end
    WU.SetActive(REF.NodeRewards, showReward)
    WU.SetActive(REF.TweenContent, true)
    REF.TweenContent.UIPlayTween:Play(true)
    if not showReward then
      WU.SetLockFlag(WU.LockInputFlag.UITransition, false)
    end
  end)
  if showReward then
    this:DelayInvokeInSeconds(2.5, function()
      WU.SetActive(REF.Rewards, true)
      REF.Rewards.UIGrid:Reposition()
      local t = REF.Rewards.UIPlayTween.mDelay * 2
      REF.Rewards.UIPlayTween:Play(true)
      for i = 0, #m_recipeConfig.rewards - 1 do
        local ii = i
        this:DelayInvokeInSeconds(t * ii, function()
          CS.SoundManager.Instance:PlaySound("Sound/system/s_System_GachaRrsult")
        end)
      end
      WU.SetLockFlag(WU.LockInputFlag.UITransition, false)
    end)
  end
end

function OnBtnContinueClick()
  WU.RecycleWindow("HotPotResearchResult")
end
