-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/word/FloatWordMgr.lua

module("logic.extensions.common.word.FloatWordMgr", package.seeall)

local FloatWordMgr = class("FloatWordMgr")
local floatItemPrefab

FloatWordMgr.showType1 = 1
FloatWordMgr.showType2 = 2
FloatWordMgr.showType3 = 3
FloatWordMgr.showType4 = 4

local function createFloatItem()
	local go = goutil.clone(floatItemPrefab)
	local item = Astral.SimpleLuaComponentContainer.Add(go, FloatWordItem)

	return item
end

local function destroyFloatItem(obj)
	goutil.destroy(obj.gameObject)
end

local function resetFloatItem(obj)
	obj:reset()
	obj.gameObject:SetActive(false)
end

function FloatWordMgr:ctor()
	self._floatWordItemContainer = nil
	self._initialY = 0
	self._targetY = 100
	self._yAddition = 40
	self._flySpeed = 150
	self._stayTime = 3
	self._items = {}
	self._flyQueue = {}
	self._isFling = false
	self._pool = ObjectPool.New(4, createFloatItem, destroyFloatItem, resetFloatItem)
end

function FloatWordMgr:init(itemPrefab)
	self._floatWordItemContainer = ViewMgr.instance:getRoot(ViewRootType.Top)
	floatItemPrefab = itemPrefab
end

function FloatWordMgr:show(content, showType)
	content = content and StringUtil.trim(content) or nil

	if string.nilorempty(content) then
		return
	end

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_generic_error, nil, nil, nil)
	ToolTipsMgr.showCharacterTopToast(content, CommEnum.CharacterTopToastIcon.Info, 1)
end

function FloatWordMgr:clear(isForceClear)
	for i, v in ipairs(self._items) do
		self._pool:returnObject(v)
	end

	self._items = {}

	if isForceClear ~= false then
		self._isFling = false

		for i, v in ipairs(self._flyQueue) do
			v:reset()

			v:getContentText().alignment = UnityEngine.TextAnchor.MiddleCenter

			self._pool:returnObject(v)
		end

		self._flyQueue = {}
	end
end

function FloatWordMgr:_autoAdjustFloatItemSize(item)
	local text = item:getContentText()
	local bg = item:getBg()

	if #self._flyQueue > 0 then
		local lastBg = self._flyQueue[#self._flyQueue]:getBg()

		return lastBg.rectTransform.anchoredPosition.y - (goutil.getHeight(lastBg.rectTransform) + goutil.getHeight(bg.rectTransform)) / 2 + 5
	end

	return self._initialY
end

function FloatWordMgr:_flyNext()
	if #self._items > 0 then
		local item = self._items[1]

		table.remove(self._items, 1)
		item.gameObject:SetActive(true)
		item.gameObject.transform:SetAsLastSibling()

		local startY = self:_autoAdjustFloatItemSize(item)

		Astral.GeometryUtil.SetAnchorPosY(item.gameObject.transform, startY)

		self._flyQueue[#self._flyQueue + 1] = item

		local h = 0

		for i, v in ipairs(self._flyQueue) do
			if #self._flyQueue >= 3 then
				self._flyQueue[i]:flyTo(self._targetY - h, self._flySpeed, self._stayTime, self._onFloatDone, self)
			else
				self._flyQueue[i]:flyTo(self._targetY - h, self._flySpeed, self._stayTime, self._onFloatDone, self)
			end

			h = h + goutil.getHeight(self._flyQueue[i].gameObject.transform)
		end
	end
end

function FloatWordMgr:_onFloatDone(item)
	for i, v in ipairs(self._flyQueue) do
		if v == item then
			table.remove(self._flyQueue, i)

			break
		end
	end

	item:reset()

	item:getContentText().alignment = UnityEngine.TextAnchor.MiddleCenter

	self._pool:returnObject(item)

	if #self._flyQueue == 0 and #self._items == 0 then
		self._isFling = false
	else
		self:_flyNext()
	end
end

FloatWordMgr.instance = FloatWordMgr.New()

return FloatWordMgr
