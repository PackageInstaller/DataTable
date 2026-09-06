-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/filter/StarFilterView.lua

module("logic.extensions.bag.view.filter.StarFilterView", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local StarFilterView = class("StarFilterView")

function StarFilterView.AddOnce(go)
	local component = StarFilterView.Get(go)

	component = component or LuaComponentContainer.Add(go, StarFilterView)

	return component
end

function StarFilterView.Get(go)
	return (LuaComponentContainer.Get(go, StarFilterView))
end

function StarFilterView:ctor(target)
	self._go = target.gameObject
	self._filterGo = self._go
	self._filterGoList = {}
	self._filter = {}

	for i = 1, 6 do
		local go = goutil.findChild(self._filterGo, "Cell" .. i)

		if go ~= nil then
			self._filter[i] = false

			table.insert(self._filterGoList, go)
			GameUtil.asBtn(go):AddClickListener(function()
				self:_onClickFilterBtn(go, i)
			end)
		end
	end
end

function StarFilterView:reset()
	for i, v in ipairs(self._filterGoList) do
		self._filter[i] = false

		local mark = goutil.findChild(v, "Mark")

		GameUtil.SetActive(mark, false)
	end
end

function StarFilterView:init(func, tar)
	self._callback = func
	self._callbackTar = tar
end

function StarFilterView:OnDestroy()
	for i = 1, #self._filterGoList do
		local go = self._filterGoList[i]

		GameUtil.asBtn(go):RemoveClickListener()
	end
end

function StarFilterView:_onClickFilterBtn(go, idx)
	local mark = goutil.findChild(go, "Mark")
	local isActive = mark.activeSelf

	self._filter[idx] = not isActive

	GameUtil.SetActive(mark, not isActive)
	GameUtil.callBack(self._callback, self._callbackTar)
end

function StarFilterView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._filterGo, false)
	end
end

function StarFilterView:show()
	return
end

function StarFilterView:isMatch(star)
	local isAllFalse = true
	local isHit = false

	for k, v in pairs(self._filter) do
		if v then
			isAllFalse = false
		end

		if k == star then
			isHit = v
		end
	end

	return isAllFalse or isHit
end

return StarFilterView
