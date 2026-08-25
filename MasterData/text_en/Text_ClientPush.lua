__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ClientPush = readonly({
  ClientPush_18731_Body = {
    Text = "Menophin has been replenished. Continue your investigation journey."
  },
  ClientPush_18731_Title = {
    Text = "Menophin Replenished"
  },
  ClientPush_18732_Body = {
    Text = "Keeper, it's been a while since you last checked in at Mythag. Everyone misses you."
  },
  ClientPush_18732_Title = {
    Text = "Mythag Communication"
  },
  ClientPush_18733_Body = {
    Text = "Keeper, is the mission proceeding smoothly? Ramona is ready to set off and is waiting for you to join the next investigation."
  },
  ClientPush_18733_Title = {
    Text = "Mythag Communication"
  },
  ClientPush_18734_Body = {
    Text = "The resources at the Research Center are ready. Come and claim them."
  },
  ClientPush_18734_Title = {Text = "Claimable"},
  ClientPush_18735_Body = {
    Text = "Keeper, how's everything? Everyone is waiting for your good news."
  },
  ClientPush_18735_Title = {
    Text = "Mythag Communication"
  },
  ClientPush_18736_Body = {
    Text = "There are completed assignments. Check the results ASAP."
  },
  ClientPush_18736_Title = {
    Text = "Assignments Completed"
  }
})
return Text_ClientPush
