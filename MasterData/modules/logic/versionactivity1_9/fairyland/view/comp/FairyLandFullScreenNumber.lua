-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/comp/FairyLandFullScreenNumber.lua

module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandFullScreenNumber", package.seeall)

local FairyLandFullScreenNumber = class("FairyLandFullScreenNumber", UserDataDispose)
local Time = UnityEngine.Time

function FairyLandFullScreenNumber:init(param)
	self:__onInit()

	self.viewGO = param.viewGO
	self.goNum = gohelper.findChild(self.viewGO, "numbg")
	self.textContent = gohelper.findChild(self.viewGO, "numbg/content")
	self.text = gohelper.findChildText(self.viewGO, "numbg/content/Text")
	self.content = "1.4142135623730950488016887242096980785696718753769480731766797379907324784621070388503875343276415727350138462309122970249248360558507372126441214970999358314132226659275055927557999505011527820605714701095599716059702745345968620147285174186408891986095523292304843087143214508397626036279952514079896872533965463318088296406206152583523950547457502877599617298355752203375318570113543746034084988471603868999706990048150305440277903164542478230684929369186215805784631115966687130130156185689872372352885092648612494977154218334204285686060146824720771435854874155657069677653720226485447015858801620758474922657226002085584466521458398893944370926591800311388246468157082630100594858704003186480342194897278290641045072636881313739855256117322040245091227700226941127573627280495738108967504018369868368450725799364729060762996941380475654823728997180326802474420629269124859052181004459842150591120249441341728531478105803603371077309182869314710171111683916581726889419758716582152128229518488472"
	self.numTab = {}

	local index = 1

	for c in string.gmatch(self.content, ".") do
		self.numTab[index] = c
		index = index + 1
	end

	self.numCount = index - 1
	self._showCheckStamp = 0
end

function FairyLandFullScreenNumber:addUpdate()
	if self.hasAddUpdate then
		return
	end

	self.hasAddUpdate = true

	LateUpdateBeat:Add(self._updateText, self)
end

function FairyLandFullScreenNumber:_updateText()
	if self.showTextTween then
		self._showCheckStamp = self._showCheckStamp + Time.deltaTime

		if self._showCheckStamp > self.showTweenStamp then
			self._showCheckStamp = 0

			self:_playShowText()
		end
	end

	if self.showZeroTween then
		self._showCheckStamp = self._showCheckStamp + Time.deltaTime

		if self._showCheckStamp > self.showTweenStamp then
			self._showCheckStamp = 0

			self:_playZeroTween()
		end
	end
end

function FairyLandFullScreenNumber:playShowTween()
	if self.showTextTween then
		return
	end

	gohelper.setActive(self.goNum, true)

	self.text.text = ""
	self.showStartIndex = 1
	self.showStartCount = 1
	self.showTextIsFull = false
	self.textWidth = recthelper.getWidth(self.text.transform)
	self.textHeight = recthelper.getHeight(self.text.transform)
	self.lineCount = math.floor(self.textWidth / 50)
	self.showAddCount = math.ceil(self.lineCount / 10)
	self.showTextTween = true
	self.showZeroTween = false
	self.showTweenStamp = 0.01

	self:addUpdate()
end

function FairyLandFullScreenNumber:_playShowText()
	if not self.showTextIsFull then
		local textHeight = self.text.preferredHeight

		if textHeight > self.textHeight then
			self.showTextIsFull = true
			self.showTweenStamp = 0.1
		end
	end

	if self.showTextIsFull then
		self.showStartIndex = self.showStartIndex + 1
	else
		self.showStartCount = self.showStartCount + 20
	end

	self.text.text = self:getShowText(self.showStartIndex, self.showStartCount)
end

function FairyLandFullScreenNumber:getShowText(startIndex, showCount)
	self.showTextTab = self.showTextTab or {}

	local index

	for i = 1, showCount do
		index = i + startIndex

		if i + startIndex > self.numCount then
			index = index % self.numCount
		end

		self.showTextTab[i] = self.numTab[index] or ""
	end

	return table.concat(self.showTextTab, "")
end

function FairyLandFullScreenNumber:playZeroTween(callback, callbackObj)
	if self.showZeroTween then
		return
	end

	gohelper.setActive(self.goNum, true)

	self.showTextTween = false
	self.showZeroTween = true
	self.showTweenStamp = 0.1
	self.zeroCallback = callback
	self.zeroCallbackObj = callbackObj

	self:addUpdate()
end

function FairyLandFullScreenNumber:_playZeroTween()
	local text, allZero = self:getZeroText()

	self.text.text = text

	if allZero then
		self.showZeroTween = false

		TaskDispatcher.runDelay(self._onFinishZeroTween, self, 0.5)
	end
end

function FairyLandFullScreenNumber:_onFinishZeroTween()
	if self.zeroCallback then
		self.zeroCallback(self.zeroCallbackObj)
	end
end

function FairyLandFullScreenNumber:getZeroText()
	self.showTextTab = self.showTextTab or {}

	local allZero = true
	local num

	for i, v in ipairs(self.showTextTab) do
		num = tonumber(v)

		if num then
			if num ~= 0 then
				num = num - 1
				allZero = false
			end
		else
			num = v
		end

		self.showTextTab[i] = num
	end

	return table.concat(self.showTextTab, ""), allZero
end

function FairyLandFullScreenNumber:clear()
	gohelper.setActive(self.goNum, false)
	TaskDispatcher.cancelTask(self._onFinishZeroTween, self)

	self.showTextTween = false
	self.showZeroTween = false

	if self.hasAddUpdate then
		LateUpdateBeat:Remove(self._updateText, self)

		self.hasAddUpdate = false
	end
end

function FairyLandFullScreenNumber:destory()
	self:clear()
	self:__onDispose()
end

return FairyLandFullScreenNumber
