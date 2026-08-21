local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")

function ValidateRestrictions(guildId)
  local top = WU.TopWindow()
  if top and top.name == this.name and guildId == 0 then
    if not this:GetData("GuildQuitNotified") then
      this:SetData("GuildQuitNotified", true)
      WU.ShowMessageOK(WU.GetString("Window_JustQuitGuild"), function(result)
        local top = WU.TopWindow()
        if top and top.name == this.name then
          WU.RecycleWindow(this)
        end
      end)
    else
      WU.RecycleWindow(this)
    end
  end
end

function Focus(on)
  if on then
    ValidateRestrictions(this:GetData("guildId"))
  end
end
