local WU, DB, REF = require("Common/WindowUtil")(this)
local m_callback

function Start()
  WU.BindButtonEvent(REF["$"], OnTabClick)
end

function OnTabClick(go, RECflag)
  if m_callback ~= nil then
    m_callback(go, RECflag)
  end
end

function SetClickCallback(callback)
  m_callback = callback
end

function SetSelected()
  REF["$UIToggle"].value = true
  OnTabClick(REF["$gameObject"], true)
end

function TabSelected(val)
  REF["$UIToggle"].optionCanBeNone = true
  REF["$UIToggle"].value = val
  REF["$UIToggle"].optionCanBeNone = false
  if val then
    OnTabClick(REF["$gameObject"])
  end
end

function SetTab(content, atlasPath, spriteName, isNew)
  REF.LabelButton.UIHtmlLabel.text = content
  if atlasPath == nil or spriteName == nil then
    REF.SpriteFront.UISprite.enabled = false
  else
    REF.SpriteFront.UISprite.enabled = true
    REF.SpriteFront.UISprite.atlasPath = atlasPath
    REF.SpriteFront.UISprite.spriteName = spriteName
  end
  REF.SpriteFront.UISprite:SnapWithoutScale()
  REF.SpriteNew.gameObject:SetActive(isNew)
  SetActivity(false)
end

function SetNew(isNew)
  REF.SpriteNew.gameObject:SetActive(isNew)
end

function SetActivity(isActivity, tipsType)
  if REF.SpriteActivity then
    if isActivity then
      if tipsType == 0 or tipsType == nil then
        REF.SpriteActivity.UISprite.atlasPath = "Common"
        REF.SpriteActivity.UISprite.spriteName = "activity_tips"
        REF.LabelActivity.UILabel.color = CS.NGUIMath.HexToColor(2608280063)
        REF.LabelActivity.UILabel.text = WU.GetString("WindowShop_ActivityTips")
      elseif tipsType == 1 then
        REF.SpriteActivity.UISprite.atlasPath = "CommonWindow"
        REF.SpriteActivity.UISprite.spriteName = "activity_tips_red"
        REF.LabelActivity.UILabel.color = CS.NGUIMath.HexToColor(4294967295)
        REF.LabelActivity.UILabel.text = WU.GetString("WindowShop_SpecialTips")
      end
    end
    REF.SpriteActivity.gameObject:SetActive(isActivity)
  end
end

function SetTabText(content1, content2)
  if REF.LabelButton then
    REF.LabelButton.UIHtmlLabel.text = content1 or ""
  end
  if REF.LabelButton2 then
    REF.LabelButton2.UIHtmlLabel.text = content2 or ""
  end
end
