-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/DragonBuffsItem.lua

module("logic.extensions.dragonlords.view.DragonBuffsItem", package.seeall)

local DragonBuffsItem = class("DragonBuffsItem")

function DragonBuffsItem:ctor(go, parant)
	self._mainGo = goutil.cloneAndSetParent(go, parant.transform)
	self._grid = {}
	self._grid.go = self._mainGo
	self._grid.txtName = goutil.findChildTextComponent(self._mainGo, "txtName")
	self._grid.txtDesc = goutil.findChildTextComponent(self._mainGo, "View/Viewport/Content/txtDesc")
	self._grid.btn = Framework.ButtonAdapter.GetFrom(self._mainGo, "btn")
	self._grid.bufIcon = Framework.ImageBigBG.GetFrom(self._mainGo, "BuffIcon")
	self._grid.buffLv = goutil.findChildComponent(self._mainGo, "level", "UIImageSpriteChange")
	self._grid.buffLvState = goutil.findChildComponent(self._mainGo, "icon", "UIImageSpriteChange")
	self._grid.buffLvIcon = self._grid.buffLv:GetComponent(typeof(UnityEngine.UI.Image))
	self._grid.scrollRect = goutil.findChildComponent(self._mainGo, "View", "ScrollRect")
	self._grid.content = goutil.findChild(self._mainGo, "View/Viewport/Content").transform
	self._grid.viewClick = Framework.UIClickTrigger.Get(self._grid.scrollRect.gameObject)
	self._grid.leftSide = goutil.findChild(self._mainGo, "LeftSide")
	self._grid.rightSide = goutil.findChild(self._mainGo, "RightSide")
end

function DragonBuffsItem:getGrid()
	return self._grid
end

return DragonBuffsItem
