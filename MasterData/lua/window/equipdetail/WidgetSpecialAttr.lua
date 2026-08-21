local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local EU = require("Common/EquipUtil")
local AU = require("Common/ActorUtil")

function SetAttr(attr)
  if attr then
    if REF.SpritePos and attr.pos then
      REF.SpritePos.UISprite.spriteName = EU.EquipPosSpriteNameTable[attr.pos + 1]
    end
    REF.LabelDesc.UIHtmlLabel.text = AU.GetSpecialEffectDesc(attr.id, attr.effect, U.AttrColorTable.Value)
    REF.LabelDesc.UIHtmlLabel:MakePixelPerfect()
    REF.SpriteBG.UISprite.height = REF.LabelDesc.UIHtmlLabel.height + 10
  end
end
