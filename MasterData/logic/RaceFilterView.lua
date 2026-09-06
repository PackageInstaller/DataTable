-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/filter/RaceFilterView.lua

module("logic.extensions.bag.view.filter.RaceFilterView", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local RaceFilterView = class("RaceFilterView")
local raceTypes = {
	{
		GameEnum.Races.草,
		GameEnum.Races.神草
	},
	{
		GameEnum.Races.水,
		GameEnum.Races.神水
	},
	{
		GameEnum.Races.火,
		GameEnum.Races.神火
	},
	{
		GameEnum.Races.光,
		GameEnum.Races.神光
	},
	{
		GameEnum.Races.暗,
		GameEnum.Races.神暗
	}
}

function RaceFilterView.AddOnce(go)
	local component = RaceFilterView.Get(go)

	component = component or LuaComponentContainer.Add(go, RaceFilterView)

	return component
end

function RaceFilterView.Get(go)
	return (LuaComponentContainer.Get(go, RaceFilterView))
end

function RaceFilterView:ctor(target)
	self._go = target.gameObject
	self._filterGo = self._go
	self._filterGoList = {}

	for i = 1, 5 do
		local go = goutil.findChild(self._filterGo, "Cell" .. i)

		table.insert(self._filterGoList, go)
	end

	for i = 1, #self._filterGoList do
		local go = self._filterGoList[i]

		GameUtil.asBtn(go):AddClickListener(function()
			self:_onClickFilterBtn(go, i)
		end)
	end

	self:reset()
end

function RaceFilterView:reset()
	for i = 1, #self._filterGoList do
		local go = self._filterGoList[i]
		local mark = goutil.findChild(go, "Mark")

		GameUtil.SetActive(mark, false)
	end

	self._filter = {}

	for k, v in pairs(GameEnum.Races) do
		self._filter[v] = false
	end
end

function RaceFilterView:init(func, tar)
	self._callback = func
	self._callbackTar = tar
end

function RaceFilterView:OnDestroy()
	for i = 1, #self._filterGoList do
		local go = self._filterGoList[i]

		GameUtil.asBtn(go):RemoveClickListener()
	end
end

function RaceFilterView:_onClickFilterBtn(go, idx)
	local mark = goutil.findChild(go, "Mark")
	local isActive = mark.activeSelf
	local races = raceTypes[idx]

	for i, v in ipairs(races) do
		self._filter[v] = not isActive
	end

	GameUtil.SetActive(mark, not isActive)
	self._callback(self._callbackTar)
end

function RaceFilterView:show()
	return
end

function RaceFilterView:raceFilter(pet)
	local firstEle = PetSkinConfig.instance:getFisrtEleAttrIdx(pet.curFaceId)

	return self:isMatch(firstEle)
end

function RaceFilterView:isMatch(raceType)
	local isAllFalse = true
	local isHit = false

	for k, v in pairs(self._filter) do
		if v then
			isAllFalse = false
		end

		if k == GameEnum.Races[raceType] then
			isHit = v
		end
	end

	return isAllFalse or isHit
end

return RaceFilterView
