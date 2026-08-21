local CommandConst = {}

local CommandName = {}
CommandName.UseItemCommand = "UseItemCommand"
CommandName.VoteCommand = "VoteCommand"
CommandName.BuyItemCommand = "BuyItemCommand"
CommandName.AchievementCommand = "AchievementCommand"
CommandName.TeamConfigCommand = "TeamConfigCommand"
-- CommandName.GetHeroCommand = "GetHeroCommand"
CommandName.UpdateDevelopCommand = "UpdateDevelopCommand"


local Commands = {}
Commands.UseItemCommand = "Command.UseItemCommand"
Commands.VoteCommand = "Command.VoteCommand"
Commands.BuyItemCommand = "Command.BuyItemCommand"
Commands.AchievementCommand = "Command.AchievementCommand"
Commands.TeamConfigCommand = "Command.TeamConfigCommand"
-- Commands.GetHeroCommand = "Command.GetHeroCommand"
Commands.UpdateDevelopCommand = "Command.UpdateDevelopCommand"


CommandConst.Commands = Commands
CommandConst.CommandName = CommandName

return CommandConst
