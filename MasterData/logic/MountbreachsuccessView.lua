-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mount/view/MountbreachsuccessView.lua

module("logic.extensions.mount.view.MountbreachsuccessView", package.seeall)

local MountbreachsuccessView = class("MountbreachsuccessView", ViewComponent)
local MAX_POTENTIAL_STATE = 3
local MAX_LIGHT_NUM = 5

function MountbreachsuccessView:ctor()
	MountbreachsuccessView.super.ctor(self)
end

function MountbreachsuccessView:buildUI()
	MountbreachsuccessView.super.buildUI(self)

	self.textAtt = goutil.findChildTextComponent(self.mainGO, "textAtt")
	self._bulbs = {}
	self._lines = {}

	for i = 1, 5 do
		table.insert(self._bulbs, goutil.findChildComponent(self.mainGO, "bulbs/bulb_" .. i, "UIImageSpriteChange"))
		table.insert(self._lines, goutil.findChildComponent(self.mainGO, "bulbs/line" .. i, "UIImageSpriteChange"))
	end

	self.bgBtn = GameUtil.asBtn(self:getGo("bg"))
end

function MountbreachsuccessView:bindEvents()
	MountbreachsuccessView.super.bindEvents(self)
	self.bgBtn:AddClickListener(self.close, self)
end

function MountbreachsuccessView:unbindEvents()
	MountbreachsuccessView.super.unbindEvents(self)
	self.bgBtn:RemoveClickListener()
end

function MountbreachsuccessView:destroyUI()
	MountbreachsuccessView.super.destroyUI(self)
end

function MountbreachsuccessView:onEnter()
	MountbreachsuccessView.super.onEnter(self)

	self._curData = self._viewPresentor._openParam[1]

	self:refresh(self._curData)
end

function MountbreachsuccessView:onEnterFinished()
	MountbreachsuccessView.super.onEnterFinished(self)
end

function MountbreachsuccessView:onExit()
	MountbreachsuccessView.super.onExit(self)
end

function MountbreachsuccessView:onExitFinished()
	MountbreachsuccessView.super.onExitFinished(self)
end

function MountbreachsuccessView:refresh(data)
	local arr = string.split(data.att, "+")
	local id = table.indexof(GameEnum.AttrTypeName, arr[1])
	local value = checknumber(arr[2])
	local propertyVal = GameUtil.GetPropertyValue(id, value)

	self.textAtt.text = arr[1] .. "+" .. propertyVal

	local level = data.lightup

	for i = 1, MAX_LIGHT_NUM do
		local state = self:getPotentialState(i, level, 5)

		self._bulbs[i]:SetState(state)

		if self._lines[i] then
			self._lines[i]:SetState(state)
		end
	end
end

function MountbreachsuccessView:getPotentialState(index, level)
	local res = 0

	for i = MAX_POTENTIAL_STATE, 0, -1 do
		if level >= index + i * MAX_LIGHT_NUM then
			res = i + 1

			break
		end
	end

	return res
end

return MountbreachsuccessView
