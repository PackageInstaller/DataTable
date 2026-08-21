local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")

function SetShareInfo(data)
  if data.score then
    WU.SetActive(REF.LabelScoreTitle, true)
    REF.LabelScore.UILabel.text = data.score
    REF.LabelHighScoreTitle.transform.localPosition = CS.UnityEngine.Vector3(0, -274, 0)
  else
    WU.SetActive(REF.LabelScoreTitle, false)
    REF.LabelHighScoreTitle.transform.localPosition = CS.UnityEngine.Vector3(0, -162, 0)
  end
  if data.highScore then
    REF.LabelHighScore.UILabel.text = data.highScore
  end
  if data.coffeeLevel then
    REF.SpriteCoffeLevel.UISprite.spriteName = "coffee_level_" .. data.coffeeLevel
    REF.LabelCoffeeLevel.UILabel.text = WU.GetString("MaidCafe_RankMode_Type" .. data.coffeeLevel)
  end
  if data.theme then
    if data.theme == 1 then
      REF.SpriteTheme.UISprite.spriteName = "skill_test_share"
    elseif data.theme == 2 then
      REF.SpriteTheme.UISprite.spriteName = "endurance_test_share"
    end
  end
  if data.actorIds then
    for i = 0, #REF.GroupActors - 1 do
      local actorId = data.actorIds[i + 1]
      if actorId then
        local actorConfig = PB.get("ActorConfig", actorId)
        local actorData = {
          animRes = actorConfig.animRes,
          unlock = true,
          kind = actorConfig.kind,
          id = actorConfig.id
        }
        REF.GroupActors[i]["$$SetData"](actorData)
        REF.GroupActors[i]["$$SetSelected"](false)
      else
        REF.GroupActors[i]["$$SetEmpty"]()
      end
    end
  end
end
