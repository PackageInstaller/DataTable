local FormationFriendFightLayer = class("FormationFriendFightLayer", (require("view.Layer.Formation.FormationGrabMatchLayer")))
local TempWidget = require("view.Sprite.TempWidget")

function FormationFriendFightLayer:ctor()
	FormationFriendFightLayer.super.ctor(self)
end

function FormationFriendFightLayer:create(arg_2_1)
	local var_2_0 = FormationFriendFightLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function FormationFriendFightLayer:sureButtonCallBack()
	FormationFriendFightLayer.super.sureButtonCallBack(self)

	if self.configCallback then
		self.configCallback()
	end
end

return FormationFriendFightLayer
