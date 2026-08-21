local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DormUtil")
local AU = require("Common/ActorUtil")
local m_clickCallback

function Awake()
  WU.BindButtonEvent(REF.root, function(go)
    if m_clickCallback then
      m_clickCallback(go)
    end
  end)
end

function ResetState()
  WU.SetActive(REF.SpriteEmpty, false)
  WU.SetActive(REF.SpriteBuy, false)
  WU.SetActive(REF.WidgetActorCard, false)
  WU.SetActive(REF.NodeExp, false)
end

function SetBuy(cost)
  ResetState()
  WU.SetActive(REF.SpriteBuy, true)
  REF.LabelCost.ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
end

function SetEmpty()
  ResetState()
  WU.SetActive(REF.SpriteEmpty, true)
end

function SetActor(uid)
  ResetState()
  WU.SetActive(REF.WidgetActorCard, true)
  REF.WidgetActorCard["$SetActorOnce"](this:GetData("fci/actor/" .. uid))
end

function SetExp(uid, expData, expAddPer)
  SetActor(uid)
  WU.SetActive(REF.NodeExp, true)
  local old = expData.old
  local new = expData.new
  local upConfig = PB.get("ActorLevelup", old.level + 1)
  local oldExpRatio = old.level + old.exp / (upConfig and upConfig.exp or old.exp)
  upConfig = PB.get("ActorLevelup", new.level + 1)
  local newExpRatio = new.level + new.exp / (upConfig and upConfig.exp or new.exp)
  if old.level == new.level then
    WU.SetActive(REF.SpriteProgress, true)
    REF.SpriteProgress.UISprite.fillAmount = oldExpRatio
  else
    WU.SetActive(REF.SpriteProgress, false)
  end
  REF.SpriteExpAdd.TweenFillAmountUnlimited.duration = (new.level - old.level + 1) * 0.8
  REF.SpriteExpAdd.TweenFillAmountUnlimited.from = oldExpRatio
  REF.SpriteExpAdd.TweenFillAmountUnlimited.to = newExpRatio
  REF.SpriteExpAdd.TweenFillAmountUnlimited:ResetToBeginning()
  REF.SpriteExpAdd.TweenFillAmountUnlimited:PlayForward()
  REF.LabelExpAdd.UILabel.text = "+ " .. expData.expAdd
  REF.LabelExpAddPer.UILabel.text = expAddPer
end

function SetClickCallback(calllback)
  m_clickCallback = calllback
  REF.WidgetActorCard["$SetClickCallback"](calllback)
end
