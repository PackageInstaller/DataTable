-- chunkname: @modules/logic/explore/map/unit/comp/ExplorePipeComp.lua

module("modules.logic.explore.map.unit.comp.ExplorePipeComp", package.seeall)

local ExplorePipeComp = class("ExplorePipeComp", LuaCompBase)
local mainColorId = UnityEngine.Shader.PropertyToID("_GasColor")
local fadeId = UnityEngine.Shader.PropertyToID("_Fade")
local processId = UnityEngine.Shader.PropertyToID("_Process")

function ExplorePipeComp:ctor(unit)
	self.unit = unit
	self._allMatDict = {}
	self._dirToPipeType = {}
	self._fromColor = {}
	self._toColor = {}
end

function ExplorePipeComp:initData()
	for i = 0, 270, 90 do
		self._dirToPipeType[i] = self.unit.mo:getDirType(i)
	end

	self._dirToPipeType[-1] = ExploreEnum.PipeGoNode.Center
end

function ExplorePipeComp:setup(go)
	self.go = go
	self._allMatDict = {}

	for type, name in pairs(ExploreEnum.PipeGoNodeName) do
		local mat = self:_getMat(name)

		if mat then
			self._allMatDict[type] = mat

			self._allMatDict[type]:SetFloat(processId, 1)
		end
	end

	self:tweenColor(1)
end

function ExplorePipeComp:_getMat(name)
	local go = gohelper.findChild(self.go, "#go_rotate/" .. name)

	if not go then
		return
	end

	local renderer = go:GetComponent(typeof(UnityEngine.Renderer))

	return renderer and renderer.material
end

function ExplorePipeComp:applyColor(applyNow)
	for dir, type in pairs(self._dirToPipeType) do
		self._fromColor[dir] = self._toColor[dir]
		self._toColor[dir] = self.unit.mo:getColor(dir)
	end

	self._toColor[-1] = self.unit.mo:getColor(-1)

	if applyNow then
		for k, v in pairs(self._toColor) do
			self._fromColor[k] = v
		end

		self._fromColor[-1] = self._toColor[-1]

		self:tweenColor(1)
	end
end

local cacheColor = Color()

function ExplorePipeComp:tweenColor(value)
	for dir, color in pairs(self._toColor) do
		local type = self._dirToPipeType[dir]
		local mat = self._allMatDict[type]

		if mat then
			if color == self._fromColor[dir] then
				if color == ExploreEnum.PipeColor.None then
					mat:SetFloat(fadeId, 1)
				else
					mat:SetFloat(fadeId, 0)
					mat:SetColor(mainColorId, ExploreEnum.PipeColorDef[color])
				end
			elseif color == ExploreEnum.PipeColor.None then
				mat:SetFloat(fadeId, value)
			elseif self._fromColor[dir] == ExploreEnum.PipeColor.None then
				mat:SetFloat(fadeId, 1 - value)
				mat:SetColor(mainColorId, ExploreEnum.PipeColorDef[color])
			else
				mat:SetFloat(fadeId, 0)
				mat:SetColor(mainColorId, MaterialUtil.getLerpValue("Color", ExploreEnum.PipeColorDef[self._fromColor[dir]], ExploreEnum.PipeColorDef[color], value, cacheColor))
			end
		end
	end
end

function ExplorePipeComp:clear()
	self._allMatDict = {}
end

function ExplorePipeComp:onDestroy()
	self:clear()

	self._fromColor = {}
	self._toColor = {}
	self._dirToPipeType = {}
	self.unit = nil
end

return ExplorePipeComp
