-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryHistoryItem.lua

module("logic.extensions.story.view.StoryHistoryItem", package.seeall)

local M = class("StoryHistoryItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
end

function M:Awake()
	self._dialogAnim = self._go:GetComponent(ComponentType.Animation)
	self.labName = goutil.findChildComponent(self._go, "txtName", typeof(TMPro.TextMeshProUGUI))
	self.labContent = goutil.findChildComponent(self._go, "txtContent", typeof(TMPro.TextMeshProUGUI))
	self.imgBg = goutil.findChild(self._go, "Image1")
	self._rectTran = goutil.findChildComponent(self._go, "txtContent", UIComponentType.RectTransform)
	self._selfRectTran = goutil.addComponentOnce(self._go, UIComponentType.RectTransform)
	self._dialogTypeTipGO = {
		[4] = goutil.findChild(self._go, "txtName/way/linggan"),
		goutil.findChild(self._go, "txtName/way/neixin"),
		[6] = goutil.findChild(self._go, "txtName/way/yuancheng")
	}
	self.btnVoice = ButtonAdapter.Get(goutil.findChild(self._go, "txtName/voice"))
	self._voiceLoopGo = goutil.findChild(self._go, "txtName/voice_loop")

	self.btnVoice:AddClickListener(self._clickVoice, self)

	self._selectObj = goutil.findChild(self._go, "txtContent/current")
	self._btnClick = ButtonAdapter.Get(self.labContent.gameObject)

	self._btnClick:AddClickListener(self._clickSelf, self)
	StoryDispatcher:addEventListener(StoryNotifyName.OnSelectHistory, self.OnSelectEvent, self)
end

function M:_clickVoice()
	self._hasClickVoice = true

	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._curIndex, self._historyData.index, true)
	end
end

function M:_clickSelf()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._curIndex, self._historyData.index, false)
	end
end

function M:OnSelectEvent(evt, index, storyIndex, isPlayVoice)
	local isSelect = self._historyData.index == storyIndex

	self:setSelectState(isSelect)

	if isPlayVoice and isSelect then
		local historyData = StoryModel.instance:getHistoryByIndex(storyIndex)

		if historyData and historyData.voice then
			CriwareAudioFacade.instance:playVoiceByName(historyData.voice, nil, self._onPlayVoiceFinish, self)
		end
	end
end

function M:_onPlayVoiceFinish()
	self._hasClickVoice = false

	goutil.setActive(self._voiceLoopGo, false)
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:OnDestroy()
	StoryDispatcher:removeEventListener(StoryNotifyName.OnSelectHistory, self.OnSelectEvent, self)
	self.btnVoice:RemoveClickListener()
	self._btnClick:RemoveClickListener()

	self._btnClick = nil
	self.btnVoice = nil
end

function M:OnEnable()
	if self._dialogAnim then
		self._dialogAnim:Play("story_historycell_open")
	end
end

function M:setSelectState(active)
	goutil.setActive(self._selectObj, active)
	TextUtils.SetTMPColor(self.labName, active and "#e8e7e7" or "#ffffff")
	TextUtils.SetTMPColor(self.labContent, active and "#e8e7e7" or "#ffffff")

	if self._hasClickVoice then
		goutil.setActive(self._voiceLoopGo, active and self.btnVoice.gameObject.activeSelf)
	else
		goutil.setActive(self._voiceLoopGo, false)
	end
end

function M:setHistoryCell(historyData, index)
	self._curIndex = index
	self._historyData = historyData

	if enableLog then
		print("history:", historyData.content)
	end

	self._data = historyData

	if self.imgBg then
		goutil.setActive(self.imgBg, not historyData.isNarration)
	end

	if historyData.name then
		if self.labName then
			local type = historyData.type

			for k, v in pairs(self._dialogTypeTipGO) do
				goutil.setActive(v, k == type)
			end

			if historyData.isNarration then
				self.labName.text = "——"
			else
				self.labName.text = historyData.name
			end
		end
	else
		self.labName.text = ""

		goutil.setActive(self.imgBg, false)
	end

	goutil.setActive(self.btnVoice.gameObject, historyData.voice)

	if self.labContent then
		self.labContent.text = historyData.content
	end

	RectTransformUtils.ForceRebuildLayoutImmediate(self._rectTran)

	local size = self._rectTran.sizeDelta
	local posY = Astral.TransformUtil.GetLocalPosY(self._rectTran.transform)

	if self.labContent then
		size.y = self.labContent.preferredHeight + math.abs(posY) + 10
	end

	local y = size.y < 88 and 88 or size.y

	goutil.setHeight(self._selfRectTran, y)
end

return M
