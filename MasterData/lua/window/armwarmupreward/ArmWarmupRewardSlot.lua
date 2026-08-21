local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local LU = require("Common/ListUtil")
local S = require("Common/Singleton")
local ACU = require("Common/ActivityUtil")

function SetData(data)
  if data then
    REF.SpriteBasicGet.gameObject:SetActive(false)
    REF.SpriteOtherGet.gameObject:SetActive(false)
    REF.LabelProgressId.UILabel.text = data.progressId
    if data.progressReward and not table.empty(data.progressReward) then
      REF.SpriteBasicGet.gameObject:SetActive(data.hasGet)
      REF.BasicRewards.gameObject:SetActive(true)
      WU.TraverseChildren(REF.BasicRewards, function(go, i)
        if data.progressReward[i + 1] then
          local info = data.progressReward[i + 1]
          go:SetActive(true)
          _ENV["$"](go)["$$SetData"](info.type, info.id, info.count)
        else
          go:SetActive(false)
        end
      end)
    else
      REF.BasicRewards.gameObject:SetActive(false)
    end
    if data.progressRewardSecretPlan and not table.empty(data.progressRewardSecretPlan) then
      REF.SpriteOtherGet.gameObject:SetActive(data.hasSecretPlan and data.hasGet)
      REF.OtherRewards.gameObject:SetActive(true)
      WU.TraverseChildren(REF.OtherRewards, function(go, i)
        if data.progressRewardSecretPlan[i + 1] then
          local info = data.progressRewardSecretPlan[i + 1]
          go:SetActive(true)
          _ENV["$"](go)["$$SetData"](info.type, info.id, info.count)
        else
          go:SetActive(false)
        end
      end)
    else
      REF.OtherRewards.gameObject:SetActive(false)
    end
  end
end
