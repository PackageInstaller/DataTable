local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local ACU = require("Common/ActivityUtil")
local DBH = require("Manager/DataBindingHandler")
local SE = require("Common/SkillEffect")
local m_goodsId, m_grade, m_activityType

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonCancel, function()
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.ButtonConfirm, OnClickConfirm)
end

function InitWindow()
  m_activityType = this:GetData("Welfare/ActivityType")
  this:Bind("Carnival91Pass/GoodsId", OnGoodsId)
end

function OnGoodsId(goodsId)
  if goodsId then
    m_goodsId = goodsId
    this:Unbind("fci/BuffShop/" .. m_activityType, OnBuffShop)
    this:Bind("fci/BuffShop/" .. m_activityType, OnBuffShop)
  end
end

function OnBuffShop(result)
  if result then
    local shopInfo = result.shopInfo
    local _, goodInfo = table.find(shopInfo, function(k, v)
      return v.goodsId == m_goodsId
    end)
    m_grade = goodInfo.grade
    local xlsxConfig = PB.get("ActivityBuffGoods", m_goodsId, fif(m_grade == 0, 1, m_grade))
    local upgradeXlsxConfig = PB.get("ActivityBuffGoods", m_goodsId, m_grade + 1)
    REF.SpriteBuff.UISprite.spriteName = xlsxConfig.spriteName
    REF.LabelGrade.UILabel.text = "Lv." .. fif(m_grade == 0, 1, m_grade)
    REF.LabelConfirm.UIHtmlLabel.text = WU.GetString(fif(m_grade == 0, "Window_Activate", "Window_Levelup"))
    REF.LabelBuffName.UIHtmlLabel.text = WU.GetString("ActivityBuffGoodName_" .. m_goodsId)
    if upgradeXlsxConfig then
      WU.SetActive(REF.LabelCost, true)
      WU.SetActive(REF.ButtonConfirm, true)
      WU.SetActive(REF.LabelBuffLevel, true)
      local cost = upgradeXlsxConfig.cost[1]
      REF.LabelCost.ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
      REF.LabelBuffDesc.UIHtmlLabel.text = SE.GetActivityBuffDesc(m_goodsId, fif(m_grade == 0, 1, m_grade), fif(m_grade == 0, false, true))
      REF.LabelBuffLevel.UIHtmlLabel.text = fif(m_grade == 0, "Lv.1", string.format("Lv.%s&nbsp;<img src='Common.arrow_right'/>&nbsp;Lv.%s", m_grade, m_grade + 1))
    else
      WU.SetActive(REF.LabelCost, false)
      WU.SetActive(REF.ButtonConfirm, false)
      WU.SetActive(REF.LabelBuffLevel, false)
      REF.LabelBuffDesc.UIHtmlLabel.text = SE.GetActivityBuffDesc(m_goodsId, m_grade)
    end
  end
end

function OnClickConfirm()
  local uri = "fci/BuffShop/" .. m_activityType
  this:GameRequest(uri):Post({
    goodsId = m_goodsId,
    grade = m_grade + 1
  }, function(resp)
    DBH.ResChange(resp.resChange)
    REF.EffectUpgrade.EffectGenerator:Play()
    if m_grade == 0 then
      this:SetData("Carnival91Pass/EffectGoodsId", m_goodsId)
    end
    local shopInfo = this:GetData(uri).shopInfo
    DBH.DBUpdate(shopInfo, "goodsId", {
      goodsId = m_goodsId,
      grade = m_grade + 1
    })
    this:SetData(uri, {shopInfo = shopInfo})
  end)
end
