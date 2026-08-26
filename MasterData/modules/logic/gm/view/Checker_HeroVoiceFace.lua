-- chunkname: @modules/logic/gm/view/Checker_HeroVoiceFace.lua

module("modules.logic.gm.view.Checker_HeroVoiceFace", package.seeall)

local Checker_HeroVoiceFace = class("Checker_HeroVoiceFace", Checker_Hero)
local split = string.split
local sf = string.format

local function _onExecBegin(self)
	self._okExec = true

	self:appendLine(sf("%s(%s) skin %s: ", self:heroName(), self:heroId(), self:skinId()))
	self:pushMarkLine()
	self:addIndent()
end

local function _onExecEnd(self)
	self:subIndent()

	local index = self:popMarkLine()

	if self._okExec then
		self:pushIndent()
		self:appendWithIndex(self:makeColorStr("ok", Checker_Base.Color.Green), index)
		self:popIndent()
	end
end

local function _onLoopBegin(self, characterVoiceCO)
	self._okLoop = true

	self:appendLine(sf("audio %s: ", characterVoiceCO.audio))
	self:pushMarkLine()
	self:addIndent()
end

local function _onLoopEnd(self, characterVoiceCO)
	self:subIndent()

	local index = self:popMarkLine()

	if self._okLoop then
		self:pushIndent()
		self:appendWithIndex(self:makeColorStr("ok", Checker_Base.Color.Green), index)
		self:popIndent()
	else
		self._okExec = false
	end
end

local function _onCheckBegin(self, characterVoiceCO, memName)
	self._okCheck = true

	self:appendLine(sf("%s: ", memName))
	self:pushMarkLine()
	self:addIndent()
end

local function _onCheckEnd(self, characterVoiceCO, memName)
	self:subIndent()

	local index = self:popMarkLine()

	if self._okCheck then
		self:pushIndent()
		self:appendWithIndex(self:makeColorStr("ok", Checker_Base.Color.Green), index)
		self:popIndent()
	else
		self._okLoop = false
	end
end

function Checker_HeroVoiceFace:ctor(...)
	Checker_Hero.ctor(self, ...)
end

function Checker_HeroVoiceFace:_onExec_Spine(inst)
	self:_onExecInner(inst, inst.hasAnimation)
end

function Checker_HeroVoiceFace:_onExec_Live2d(inst)
	self:_onExecInner(inst, inst.hasExpression)
end

function Checker_HeroVoiceFace:_onExecInner(inst, instCheckCSFunc)
	_onExecBegin(self)

	local skincharacterVoiceCOList = self:skincharacterVoiceCOList()

	for _, characterVoiceCO in ipairs(skincharacterVoiceCOList) do
		_onLoopBegin(self, characterVoiceCO)
		self:_check(inst, instCheckCSFunc, characterVoiceCO, "face")
		self:_check(inst, instCheckCSFunc, characterVoiceCO, "twface")
		self:_check(inst, instCheckCSFunc, characterVoiceCO, "jpface")
		self:_check(inst, instCheckCSFunc, characterVoiceCO, "enface")
		self:_check(inst, instCheckCSFunc, characterVoiceCO, "krface")
		_onLoopEnd(self, characterVoiceCO)
	end

	_onExecEnd(self)
end

function Checker_HeroVoiceFace:_check(inst, instCheckCSFunc, characterVoiceCO, memName)
	_onCheckBegin(self, characterVoiceCO, memName)
	self:_onCheck(inst, instCheckCSFunc, characterVoiceCO[memName])
	_onCheckEnd(self, characterVoiceCO, memName)
end

function Checker_HeroVoiceFace:_onCheck(inst, instCheckCSFunc, faceStr)
	if string.nilorempty(faceStr) then
		return
	end

	local faceStrList = split(faceStr, "|")

	for i = #faceStrList, 1, -1 do
		local actionStr = faceStrList[i]
		local actionStrList = split(actionStr, "#")
		local s = ""

		if #actionStrList < 3 then
			s = "#action params count < 3"
		else
			local faceActionName = "e_" .. tostring(actionStrList[1])
			local startTime = tonumber(actionStrList[2])
			local endTime = tonumber(actionStrList[3])
			local duration

			if startTime and endTime then
				duration = endTime - startTime
			end

			if not instCheckCSFunc(inst, faceActionName) then
				s = "not exist animation '" .. tostring(faceActionName) .. "'"
			end

			if not duration then
				if not startTime then
					if s ~= "" then
						s = s .. ","
					end

					s = s .. "startTime == nil"
				end

				if not endTime then
					if s ~= "" then
						s = s .. ","
					end

					s = s .. "endTime == nil"
				end
			elseif duration <= 0 then
				if s ~= "" then
					s = s .. ","
				end

				s = s .. "duration <= 0"
			end
		end

		if s ~= "" then
			self:appendLine("'" .. actionStr .. "': " .. s)

			self._okCheck = false
		end
	end
end

return Checker_HeroVoiceFace
