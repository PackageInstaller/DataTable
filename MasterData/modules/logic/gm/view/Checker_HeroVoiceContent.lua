-- chunkname: @modules/logic/gm/view/Checker_HeroVoiceContent.lua

module("modules.logic.gm.view.Checker_HeroVoiceContent", package.seeall)

local Checker_HeroVoiceContent = class("Checker_HeroVoiceContent", Checker_Hero)
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

function Checker_HeroVoiceContent:ctor(...)
	Checker_Hero.ctor(self, ...)
end

function Checker_HeroVoiceContent:_onExec_Spine(inst)
	self:_onExecInner(inst)
end

function Checker_HeroVoiceContent:_onExec_Live2d(inst)
	self:_onExecInner(inst)
end

function Checker_HeroVoiceContent:_onExecInner(inst)
	_onExecBegin(self)

	local skincharacterVoiceCOList = self:skincharacterVoiceCOList()

	for _, characterVoiceCO in ipairs(skincharacterVoiceCOList) do
		_onLoopBegin(self, characterVoiceCO)
		self:_check(inst, characterVoiceCO, "content")
		self:_check(inst, characterVoiceCO, "twcontent")
		self:_check(inst, characterVoiceCO, "jpcontent")
		self:_check(inst, characterVoiceCO, "encontent")
		self:_check(inst, characterVoiceCO, "krcontent")
		_onLoopEnd(self, characterVoiceCO)
	end

	_onExecEnd(self)
end

function Checker_HeroVoiceContent:_check(inst, characterVoiceCO, memName)
	_onCheckBegin(self, characterVoiceCO, memName)
	self:_onCheck(inst, characterVoiceCO[memName])
	_onCheckEnd(self, characterVoiceCO, memName)
end

function Checker_HeroVoiceContent:_onCheck(inst, contentStr)
	if string.nilorempty(contentStr) then
		return
	end

	local contentStrList = split(contentStr, "|")

	for i = #contentStrList, 1, -1 do
		local contentString = contentStrList[i]
		local contentStringList = split(contentString, "#")
		local contentParam = contentStringList[1]

		if not string.nilorempty(contentParam) then
			local startTime = tonumber(contentStringList[2])
			local s = ""

			if string.nilorempty(startTime) then
				s = "没有配置时间"
			elseif startTime < 0 then
				if s ~= "" then
					s = s .. ","
				end

				s = s .. "startTime(" .. tostring(startTime) .. ") < 0"
			end

			if s ~= "" then
				self:appendLine("'" .. contentString .. "': " .. s)

				self._okCheck = false
			end
		end
	end
end

return Checker_HeroVoiceContent
