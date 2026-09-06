-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonaruisi/view/DragonaruisilevelView.lua

module("logic.extensions.dragonaruisi.view.DragonaruisilevelView", package.seeall)

local DragonaruisilevelView = class("DragonaruisilevelView", DragonDishitianLevelView)

function DragonaruisilevelView:_openClgView(chapterId)
	UIStateManager.instance:push(ViewName.DragonaruisiclgView, self._activityId, chapterId)
end

return DragonaruisilevelView
