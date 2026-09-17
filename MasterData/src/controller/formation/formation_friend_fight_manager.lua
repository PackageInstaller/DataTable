local FormationFriendFightManager = class("FormationFriendFightManager", (require("controller.formation.formation_grab_match_manager")))

FormationFriendFightManager.MULTITON_MSG = "FormationFriendFightManager instancealready constructed!"

function FormationFriendFightManager:ctor()
	FormationFriendFightManager.super.ctor(self)
end

return FormationFriendFightManager
