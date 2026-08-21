local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local IU = require("Common/ItemUtil")
local RU = require("Common/RedMarkUtil")
local m_data, m_index

function Start()
  WU.BindButtonEvent(REF.ButtonConditionReward, function()
    local reward = this:GetData("ConditionReward")
    WU.AcquireWindowAsync("ManualBoxActor", function(ui)
      _ENV["$"](ui)["$$SetBoxIdTrueLove"](reward.id, function(flag)
        this:SetData("shouldActiveCondition", not flag)
        if flag then
          WU.RecycleWindow("Welfare")
          WU.AcquireWindowAsync("City")
        end
      end)
    end)
  end)
end
