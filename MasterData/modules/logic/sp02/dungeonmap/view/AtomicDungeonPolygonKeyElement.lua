-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonPolygonKeyElement.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonPolygonKeyElement", package.seeall)

local AtomicDungeonPolygonKeyElement = class("AtomicDungeonPolygonKeyElement", LuaCompBase)
local BOX_COLLIDER_SIZE = Vector2(150, 150)

function AtomicDungeonPolygonKeyElement:ctor(param)
	self.config = param[1]
	self.mainCamera = param[2]
	self.sceneElements = param[3]
	self.type = self.config.type
	self.iskey = self.config.type == AtomicDungeonEnum.ElementType.KeyDoor and not string.nilorempty(self.config.parm) and tonumber(self.config.parm) == AtomicDungeonEnum.PolygonKeyDoorType.Key
end

function AtomicDungeonPolygonKeyElement:init(go)
	self.go = go
	self.trans = self.go.transform
	self.itemRootMap = self:getUserDataTb_()

	for rootType, rootUrl in pairs(AtomicDungeonEnum.PolygonElementTypeRoot) do
		local itemRoot = self.itemRootMap[rootType]

		if not itemRoot then
			itemRoot = {
				go = gohelper.findChild(self.go, "#go_" .. rootUrl)
			}
			self.itemRootMap[rootType] = itemRoot
		end
	end

	self.goBoss = gohelper.findChild(self.go, "#go_boss")
	self.goKey = gohelper.findChild(self.go, "#go_key")
	self.goselect = gohelper.findChild(self.go, "#go_key/go_select")
	self.godrag = gohelper.findChild(self.go, "#go_key/go_drag")
	self.animKey = self.goKey:GetComponent(gohelper.Type_Animator)
	self.imageKey = gohelper.findChildImage(self.goKey, "icon")
	self.keyIconCanvasGroup = self.imageKey:GetComponent(gohelper.Type_CanvasGroup)
	self.gotxten = gohelper.findChild(self.go, "#go_txten")
	self._goName = gohelper.findChild(self.go, "#go_name")
	self._txtName = gohelper.findChildText(self.go, "#go_name/#txt_name")

	gohelper.setActive(self.gotxten, false)
	gohelper.setActive(self.goBoss, false)
	gohelper.setActive(self.goKey, true)
	gohelper.setActive(self.goselect, false)
	gohelper.setActive(self.godrag, false)
	self:updateInfo()
end

function AtomicDungeonPolygonKeyElement:updateInfo()
	local posParam = {}
	local keyElementData = AtomicDungeonModel.instance:getKeyElementData(self.config.id)

	if not keyElementData or string.nilorempty(self.config.pos) then
		posParam = {
			0,
			0,
			0
		}

		logError("事件坐标为空，请检查：" .. self.config.id)
	else
		posParam = {
			keyElementData.posX,
			keyElementData.posY,
			0
		}
	end

	transformhelper.setLocalPos(self.trans, posParam[1], posParam[2], posParam[3])

	for rootType, itemRoot in pairs(self.itemRootMap) do
		gohelper.setActive(itemRoot.go, false)
	end

	self._txtName.text = self.config.title

	local touchElementList = AtomicDungeonModel.instance:getCurTouchElementId(keyElementData.posX, keyElementData.posY)

	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnInitTouchKeyElement, self.config.id, touchElementList)
	UISpriteSetMgr.instance:setSp02AtomicDungeonElementSprite(self.imageKey, self.config.icon)
end

function AtomicDungeonPolygonKeyElement:needShowArrow()
	return false
end

function AtomicDungeonPolygonKeyElement:playShowOrHideAnim(show)
	if self.showState == show then
		return
	end

	self.showState = show

	self:playAnim(show and "open" or "close")
end

function AtomicDungeonPolygonKeyElement:playAnim(animName)
	if animName == "open" then
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_icon_emerge)
	elseif animName == "close" then
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_icon_disappear)
	end

	self.animKey:Play(animName, 0, 0)
	self.animKey:Update(0)
end

function AtomicDungeonPolygonKeyElement:setSelectState(state)
	gohelper.setActive(self.goselect, state)
end

function AtomicDungeonPolygonKeyElement:setDragState(state)
	gohelper.setActive(self.godrag, state)
end

function AtomicDungeonPolygonKeyElement:setNameShowState(state)
	gohelper.setActive(self._goName, state)
end

function AtomicDungeonPolygonKeyElement:onDestroy()
	return
end

return AtomicDungeonPolygonKeyElement
