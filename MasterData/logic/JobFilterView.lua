-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/filter/JobFilterView.lua

module("logic.extensions.bag.view.filter.JobFilterView", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local JobFilterView = class("JobFilterView")

function JobFilterView.AddOnce(go)
	local component = JobFilterView.Get(go)

	component = component or LuaComponentContainer.Add(go, JobFilterView)

	return component
end

function JobFilterView.Get(go)
	return (LuaComponentContainer.Get(go, JobFilterView))
end

function JobFilterView:ctor(target)
	self._go = target.gameObject
	self._filterGo = self._go
	self._filterGoList = {}
	self._filter = {}

	for i, v in pairs(GameEnum.JobZh) do
		self._filter[v] = false

		local go = goutil.findChild(self._filterGo, "Cell" .. v)

		if go ~= nil then
			self._filterGoList[v] = go

			GameUtil.asBtn(go):AddClickListener(function()
				self:_onClickFilterBtn(go, v)
			end)
		end
	end
end

function JobFilterView:reset()
	self._filter = {}

	for k, v in pairs(GameEnum.JobZh) do
		self._filter[v] = false

		local go = self._filterGoList[v]
		local mark = goutil.findChild(go, "Mark")

		GameUtil.SetActive(mark, false)
	end
end

function JobFilterView:init(func, tar)
	self._callback = func
	self._callbackTar = tar
end

function JobFilterView:OnDestroy()
	for i = 1, #self._filterGoList do
		local go = self._filterGoList[i]

		GameUtil.asBtn(go):RemoveClickListener()
	end
end

function JobFilterView:_onClickFilterBtn(go, idx)
	local mark = goutil.findChild(go, "Mark")
	local isActive = mark.activeSelf

	self._filter[idx] = not isActive

	GameUtil.SetActive(mark, not isActive)
	GameUtil.callBack(self._callback, self._callbackTar)
end

function JobFilterView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._filterGo, false)
	end
end

function JobFilterView:show()
	return
end

function JobFilterView:filterByPet(pet)
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(pet.raceId)

	return self:_isMatch(firstJobIdx)
end

function JobFilterView:isMatch(firstJobIdx)
	local isAllFalse = true
	local isHit = false

	for k, v in pairs(self._filter) do
		if v then
			isAllFalse = false
		end

		if k == firstJobIdx then
			isHit = v
		end
	end

	return isAllFalse or isHit
end

return JobFilterView
