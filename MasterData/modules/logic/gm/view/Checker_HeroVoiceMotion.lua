-- chunkname: @modules/logic/gm/view/Checker_HeroVoiceMotion.lua

module("modules.logic.gm.view.Checker_HeroVoiceMotion", package.seeall)

local Checker_HeroVoiceMotion = class("Checker_HeroVoiceMotion", Checker_Hero)
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

function Checker_HeroVoiceMotion:ctor(...)
	Checker_Hero.ctor(self, ...)
end

function Checker_HeroVoiceMotion:_onExec_Spine(inst)
	self:_onExecInner(inst, inst.hasAnimation)
end

function Checker_HeroVoiceMotion:_onExec_Live2d(inst)
	self:_onExecInner(inst, inst.hasAnimation)
end

function Checker_HeroVoiceMotion:_onExecInner(inst, instCheckCSFunc)
	_onExecBegin(self)

	local skincharacterVoiceCOList = self:skincharacterVoiceCOList()

	for _, characterVoiceCO in ipairs(skincharacterVoiceCOList) do
		_onLoopBegin(self, characterVoiceCO)
		self:_check(inst, instCheckCSFunc, characterVoiceCO, "motion")
		self:_check(inst, instCheckCSFunc, characterVoiceCO, "twmotion")
		self:_check(inst, instCheckCSFunc, characterVoiceCO, "jpmotion")
		self:_check(inst, instCheckCSFunc, characterVoiceCO, "enmotion")
		self:_check(inst, instCheckCSFunc, characterVoiceCO, "krmotion")
		_onLoopEnd(self, characterVoiceCO)
	end

	_onExecEnd(self)
end

function Checker_HeroVoiceMotion:_check(inst, instCheckCSFunc, characterVoiceCO, memName)
	_onCheckBegin(self, characterVoiceCO, memName)
	self:_onCheck(inst, instCheckCSFunc, characterVoiceCO[memName])
	_onCheckEnd(self, characterVoiceCO, memName)
end

function Checker_HeroVoiceMotion:_onCheck(inst, instCheckCSFunc, motionStr)
	if string.nilorempty(motionStr) then
		return
	end

	local motionStrList = split(motionStr, "|")

	for i = #motionStrList, 1, -1 do
		local actionStr = motionStrList[i]
		local actionStrList = split(actionStr, "#")
		local s = ""

		if #actionStrList < 2 then
			s = "#action params count < 2"
		else
			local actionName = "b_" .. tostring(actionStrList[1])
			local time = tonumber(actionStrList[2])
			local loopTimes = tonumber(actionStrList[3]) or 0

			if loopTimes < -1 then
				s = "loopTimes < -1"
			end

			if not instCheckCSFunc(inst, actionName) then
				s = "not exist animation '" .. tostring(actionName) .. "'"
			end

			if not time then
				if s ~= "" then
					s = s .. ","
				end

				s = s .. "time == nil"
			elseif time <= 0 then
				if s ~= "" then
					s = s .. ","
				end

				s = s .. "time(" .. tostring(time) .. ") <= 0"
			end
		end

		if s ~= "" then
			self:appendLine("'" .. actionStr .. "': " .. s)

			self._okCheck = false
		end
	end
end

return Checker_HeroVoiceMotion
