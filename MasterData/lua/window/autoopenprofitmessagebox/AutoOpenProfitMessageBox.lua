local WU, DB, REF = require("Common/WindowUtil")(this)

function SetupWindow()
end

function SetBuffIds(profitIds)
  if table.count(profitIds) >= 1 and REF.Icon then
    local tex = WU.AcquireAsset("Texture/BuffIcon/BuffIcon_" .. profitIds[1])
    REF.Icon.MeshRenderer.material:SetTexture("_MainTex", tex)
    REF.Label.UILabel.text = WU.GetString("Buff_Profit_Id_" .. profitIds[1])
  end
end
