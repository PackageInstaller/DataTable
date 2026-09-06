-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/floatword/FloatWordMgr.lua

module("logiccommon.common.viewlib.floatword.FloatWordMgr", package.seeall)

local FloatWordMgr = class("FloatWordMgr")

FloatWordMgr.OffsetY = 200

local floatItemPrefab

local function createFloatItem()
	local go = goutil.clone(floatItemPrefab)

	return (Framework.LuaComponentContainer.Add(go, FloatWordItem))
end

local function destroyFloatItem(obj)
	goutil.destroy(obj.gameObject)
end

local function resetFloatItem(obj)
	obj:reset()

	obj:getContentText().alignment = UnityEngine.TextAnchor.MiddleCenter

	obj.gameObject:SetActive(false)
	goutil.addChildToParent(obj.gameObject, FloatWordMgr.instance._defaultRootNode)
end

function FloatWordMgr:ctor()
	self._defaultRootNode = ViewMgr.instance:getRoot(ViewRootType.Top)
	self._floatWordItemContainer = nil
	self._limitItemCount = 6
	self._charPreLine = 27
	self._dieAlphaTime = 1
	self._items = Queue.New()
	self._isFling = false
	self._pool = ObjectPool.New(10, createFloatItem, destroyFloatItem, resetFloatItem)
end

function FloatWordMgr:getDieAlphaTime()
	return self._dieAlphaTime
end

function FloatWordMgr:init(itemPrefab)
	self._floatWordItemContainer = self._defaultRootNode
	floatItemPrefab = itemPrefab
end

function FloatWordMgr:setParent(parent)
	self._floatWordItemContainer = parent
end

function FloatWordMgr:resetParent()
	self._floatWordItemContainer = self._defaultRootNode

	if self._items then
		self._items:traversal(function(key, item)
			goutil.addChildToParent(item.gameObject, self._floatWordItemContainer)
		end)
	end
end

function FloatWordMgr:show(content, forceDelayTime)
	if string.nilorempty(content) then
		return
	end

	if self._items:count() >= self._limitItemCount then
		local itemPopUp = self._items:dequeue()

		self._pool:returnObject(itemPopUp)
	end

	local item = self._pool:fetchObject()

	goutil.addChildToParent(item.gameObject, self._floatWordItemContainer)
	item.gameObject.transform:SetAsFirstSibling()
	item:setContent(content)
	item:born()
	self._items:enqueue(item)
	self:_flyNext()

	if not self._isFling then
		self._isFling = true

		settimer(self._dieAlphaTime, self._onFloatDone, self, true)
	end
end

function FloatWordMgr:_flyNext()
	local itemsCount = self._items:count()

	if itemsCount > 0 then
		local height = 0

		self._items:traversal(function(key, item)
			if not key or not item then
				return
			end

			local content = item:getContentText().text
			local len = string.utf8len(content)
			local line = math.floor(len / self._charPreLine)

			height = -30 + FloatWordMgr.OffsetY + (itemsCount - key) * (50 + line * 30)

			GameUtil.setLocalPos(item._rt.gameObject, 0, height, 0)
			item.gameObject:SetActive(true)
		end)
	end
end

function FloatWordMgr:_onFloatDone()
	if not self._items then
		return
	end

	local item = self._items:peek()

	if not item then
		return
	end

	item:dying()

	if not item:isLiving() then
		self._items:dequeue()
		self._pool:returnObject(item)
	end

	local itemsCount = self._items:count()

	if itemsCount == 0 then
		self._isFling = false

		removetimer(self._onFloatDone, self)
	end
end

function FloatWordMgr:lock()
	self._locked = true
end

function FloatWordMgr:unlock()
	self._locked = false
end

function FloatWordMgr:clear(isForceClear)
	self._items:traversal(function(key, item)
		self._pool:returnObject(item)
	end)
	self._items:clear()
end

FloatWordMgr.instance = FloatWordMgr.New()

return FloatWordMgr
