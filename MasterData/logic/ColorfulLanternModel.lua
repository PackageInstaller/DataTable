-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfullantern/model/ColorfulLanternModel.lua

module("logic.extensions.colorfullantern.model.ColorfulLanternModel", package.seeall)

local ColorfulLanternModel = class("ColorfulLanternModel", BaseModel)

function ColorfulLanternModel:ctor()
	self._activatedFragmentIds = {}
	self._curScore = 0
end

function ColorfulLanternModel:onInit()
	self:onReset()
end

function ColorfulLanternModel:onReset()
	self._activatedFragmentIds = {}
	self._curScore = 0
end

function ColorfulLanternModel:setData(msg)
	local ids = msg.activatedFragmentIds

	self._activatedFragmentIds = {}

	if ids then
		for i, v in ipairs(ids) do
			table.insert(self._activatedFragmentIds, checknumber(v))
		end
	else
		self._activatedFragmentIds = {}
	end

	table.sort(self._activatedFragmentIds)

	self._curScore = msg.curScore
end

function ColorfulLanternModel:getFragmentList()
	return self._activatedFragmentIds or {}
end

function ColorfulLanternModel:getCurScore()
	return checknumber(self._curScore)
end

ColorfulLanternModel.instance = ColorfulLanternModel.New()

return ColorfulLanternModel
