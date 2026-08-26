-- chunkname: @modules/logic/gm/view/Checker_HeroVoiceMouth.lua

module("modules.logic.gm.view.Checker_HeroVoiceMouth", package.seeall)

local Checker_HeroVoiceMouth = class("Checker_HeroVoiceMouth", Checker_Hero)
local split = string.split
local sf = string.format
local autoBizuiFlag = "auto_bizui|"
local pauseFlag = "pause"
local autoActName = "_auto"

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

function Checker_HeroVoiceMouth:ctor(...)
	Checker_Hero.ctor(self, ...)

	self._mouthActionList = {
		[AudioMgr.instance:getIdFromString("Smallmouth")] = "xiao",
		[AudioMgr.instance:getIdFromString("Mediumsizedmouth")] = "zhong",
		[AudioMgr.instance:getIdFromString("Largemouth")] = "da"
	}
end

function Checker_HeroVoiceMouth:_onExec_Spine(inst)
	self:_onExecInner(inst, inst.hasAnimation)
end

function Checker_HeroVoiceMouth:_onExec_Live2d(inst)
	self:_onExecInner(inst, inst.hasExpression)
end

function Checker_HeroVoiceMouth:_onExecInner(inst, instCheckCSFunc)
	_onExecBegin(self)

	local skincharacterVoiceCOList = self:skincharacterVoiceCOList()

	for _, characterVoiceCO in ipairs(skincharacterVoiceCOList) do
		_onLoopBegin(self, characterVoiceCO)
		self:_check(inst, instCheckCSFunc, characterVoiceCO, "mouth")
		self:_check(inst, instCheckCSFunc, characterVoiceCO, "twmouth")
		self:_check(inst, instCheckCSFunc, characterVoiceCO, "jpmouth")
		self:_check(inst, instCheckCSFunc, characterVoiceCO, "enmouth")
		self:_check(inst, instCheckCSFunc, characterVoiceCO, "krmouth")
		_onLoopEnd(self, characterVoiceCO)
	end

	_onExecEnd(self)
end

function Checker_HeroVoiceMouth:_check(inst, instCheckCSFunc, characterVoiceCO, memName)
	_onCheckBegin(self, characterVoiceCO, memName)
	self:_onCheck(inst, instCheckCSFunc, characterVoiceCO[memName])
	_onCheckEnd(self, characterVoiceCO, memName)
end

function Checker_HeroVoiceMouth:_onCheck(inst, instCheckCSFunc, mouthStr)
	if string.nilorempty(mouthStr) then
		return
	end

	if string.find(mouthStr, autoBizuiFlag) then
		local mouthActionName = StoryAnimName.T_BiZui

		if not instCheckCSFunc(inst, mouthActionName) then
			local s = "not exist animation '" .. tostring(mouthActionName) .. "'"

			self:appendLine("'" .. autoBizuiFlag .. "': " .. s)

			self._okCheck = false
		end

		mouthStr = string.gsub(mouthStr, autoBizuiFlag, "")
	end

	local mouthStrList = split(mouthStr, "|")

	for i = #mouthStrList, 1, -1 do
		local actionStr = mouthStrList[i]
		local actionStrList = split(actionStr, "#")
		local s = ""

		if string.find(actionStr, pauseFlag) then
			-- block empty
		else
			local mouthActionName = "t_" .. tostring(actionStrList[1])
			local checkL2d = actionStrList[1] == autoActName

			if not checkL2d and not instCheckCSFunc(inst, mouthActionName) then
				s = "not exist animation '" .. tostring(mouthActionName) .. "'"
			end

			local startTime = tonumber(actionStrList[2])
			local endTime = tonumber(actionStrList[3])
			local duration

			if startTime and endTime then
				duration = endTime - startTime
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

return Checker_HeroVoiceMouth
