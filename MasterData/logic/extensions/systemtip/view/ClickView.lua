-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemtip/view/ClickView.lua

module("logic.extensions.systemtip.view.ClickView", package.seeall)

local M = class("ClickView", ViewComponent)
local ItemPrefab, root
local kUiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
local defaultPos = Vector2.New(0, 0)
local defaultScale = Vector3.New(1, 1, 1)
local maxTimes = 5
local timeLength = 1.5

function M:buildUI()
	self._point = goutil.findChild(self.mainGO, "vfx_comm_danji")
	self._UIRoot = ViewMgr.instance:getUIRoot()

	goutil.setActive(self._point, false)

	ItemPrefab = self._point
	root = self.mainGO
	self._curClick = {}
end

function M:ctor()
	self._pool = ObjectPool.New(8, self.createItem, self.destroyItem, self.resetItem)
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(EventType.INPUT_POINTER_PRESSED, self._setClickPos, self)
	GlobalDispatcher:addEventListener(EventType.SHOW_POINTER_EFFECT, self._onShowRoot, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.INPUT_POINTER_PRESSED, self._setClickPos, self)
	GlobalDispatcher:removeEventListener(EventType.SHOW_POINTER_EFFECT, self._onShowRoot, self)
end

function M:_onShowRoot(evt, show)
	if goutil.isNil(root) then
		return
	end

	goutil.setActive(root, show)
end

function M.createItem()
	local item = goutil.cloneAndSetParent(ItemPrefab, root.transform)

	return item
end

function M.destroyItem(obj)
	goutil.destroy(obj.gameObject)
end

function M.resetItem(obj)
	obj.transform.localPosition = defaultPos
	obj.transform.localScale = defaultScale

	obj:SetActive(false)
end

function M:_setClickPos(_, position)
	local item = self._pool:fetchObject()
	local x, y = RectTransformUtils.ScreenPointToLocalPointInRectangle(item.transform, position.x, position.y, kUiCamera, 0, 0)
	local newPos = Vector2.New(x, y)

	item.transform.localPosition = newPos

	goutil.setActive(item, true)
	settimer(0.8, function()
		self._pool:returnObject(item)
	end, self, false)

	if enableDebug and HacktoolMo.instance:getHideUIEnable() then
		if x < 0 and y < 0 then
			table.insert(self._curClick, Time.time)
		end

		if #self._curClick >= maxTimes then
			if self._curClick[maxTimes] - self._curClick[1] < timeLength then
				self:removeCanvas()

				self._curClick = {}
			else
				table.remove(self._curClick, 1)
			end
		end
	end
end

function M:removeCanvas()
	local canvasGroup = self._UIRoot:GetComponent(ComponentType.CanvasGroup)

	if canvasGroup then
		UnityEngine.GameObject.Destroy(canvasGroup)
	end

	HacktoolMo.instance:setHideUIEnable(false)
end

return M
