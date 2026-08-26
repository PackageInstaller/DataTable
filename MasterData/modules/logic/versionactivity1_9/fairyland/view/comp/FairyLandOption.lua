-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/comp/FairyLandOption.lua

module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandOption", package.seeall)

local FairyLandOption = class("FairyLandOption", UserDataDispose)

function FairyLandOption:init(dialogView)
	self:__onInit()

	self.dialogView = dialogView
	self._go = gohelper.findChild(dialogView.dialogGO, "#go_Options")
	self.btnClick = gohelper.findChildButtonWithAudio(self._go, "#go_Click")
	self.goLeft = gohelper.findChild(self._go, "Left")

	gohelper.setActive(self.goLeft, false)

	self.goRight = gohelper.findChild(self._go, "Right")
	self.btnNext = gohelper.findChildButtonWithAudio(self.goRight, "#go_Next")
	self.btnContent = gohelper.findChildButtonWithAudio(self._go, "Right/#scroll_Dialogue/Viewport")

	self.addClickCb(self, self.btnNext, self.onClickNext, self)
	self.addClickCb(self, self.btnClick, self.onClicBtnClick, self)
	self.addClickCb(self, self.btnContent, self.onClicBtnClick, self)

	self.bubbleItems = {}

	gohelper.setActive(self.btnNext, false)
end

function FairyLandOption:onClicBtnClick()
	local nextConfig = self.sectionConfig[self.step + 1]
	local hasNext = self.sectionId == -1 or nextConfig ~= nil

	if not hasNext then
		return
	end

	self:onClickNext()
end

function FairyLandOption:onClickNext()
	if self.sectionId == -1 then
		return
	end

	if not self.dialogId then
		return
	end

	if self.isPlaying then
		self:showDialogText()
	else
		self:playNextStep()
	end
end

function FairyLandOption:startDialog(param)
	self.dialogId = param.dialogId

	gohelper.setActive(self._go, true)
	self:initContentList()
	self:selectOption(0)
	self:playNextStep()
end

function FairyLandOption:selectOption(sectionId)
	gohelper.setActive(self.goLeft, false)

	self.sectionId = sectionId
	self.step = 0
	self.sectionConfig = FairyLandConfig.instance:getDialogConfig(self.dialogId, self.sectionId)
end

function FairyLandOption:playNextStep()
	self.step = self.step + 1

	local stepConfig = self.sectionConfig[self.step]

	if not stepConfig then
		self:finished()

		return
	end

	self:playStep(stepConfig)

	local nextConfig = self.sectionConfig[self.step + 1]
	local hasNext = self.sectionId == -1 or nextConfig ~= nil

	gohelper.setActive(self.btnNext, not hasNext)
end

function FairyLandOption:playStep(stepConfig)
	self.isPlaying = true

	if stepConfig.type == "options" then
		self:showOptions(stepConfig)
	else
		self:addContent(stepConfig)
	end
end

function FairyLandOption:showDialogText()
	if self.contentList then
		if self.contentList then
			self.contentList.fadeText:onTextFinished()
		end
	end
end

function FairyLandOption:onTextPlayFinish()
	self.isPlaying = false
end

function FairyLandOption:finished()
	self.dialogId = nil
	self.isPlaying = false

	self.dialogView:finished()
end

function FairyLandOption:initContentList()
	self.contentIndex = 0

	if self.contentList then
		return
	end

	self.contentList = {}
	self.scrollContent = gohelper.findChild(self._go, "Right/#scroll_Dialogue/Viewport/LayoutGroup")
	self.goContent = gohelper.findChild(self.scrollContent, "#go_Option")
end

function FairyLandOption:addContent(param)
	self.contentIndex = self.contentIndex + 1

	local item = self:createContentItem(self.contentIndex)

	gohelper.setActive(item.go, true)

	local content = string.format("%s：%s", param.speaker, param.content)
	local config = {}

	if param.elementId == 1 then
		content = string.format("<color=#B9AB9E>%s</color>", content)
	end

	config.content = content
	config.tween = true
	config.callback = self.onTextPlayFinish
	config.callbackObj = self

	item.fadeText:setText(config)
	gohelper.setActive(item.goBg1, param.elementId == 1)
	gohelper.setActive(item.goBg2, param.elementId == 0)
	gohelper.setActive(item.goStar, param.elementId == 1)
	self:playAudio(param.audioId)
	self:moveLast()
end

function FairyLandOption:createContentItem(index)
	if self.contentList[index] then
		return self.contentList[index]
	end

	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.cloneInPlace(self.goContent, tostring(index))
	item.goBg1 = gohelper.findChild(item.go, "#go_BG1")
	item.goBg2 = gohelper.findChild(item.go, "#go_BG2")
	item.goText = gohelper.findChild(item.go, "#txt_Option")
	item.fadeText = MonoHelper.addNoUpdateLuaComOnceToGo(item.goText, FairyLandTextFade)
	item.goStar = gohelper.findChild(item.go, "#txt_Option/image_Star")

	table.insert(self.contentList, item)

	return item
end

function FairyLandOption:deleteContentItem(item)
	if item then
		item.fadeText:onDestroy()
	end
end

function FairyLandOption:initOption()
	if self.optionList then
		return
	end

	self.optionList = {}

	for i = 1, 3 do
		self.optionList[i] = self:createOption(i)
	end
end

function FairyLandOption:createOption(index)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.findChild(self.goLeft, "#go_Option" .. tostring(index))
	item.btn = gohelper.findButtonWithAudio(item.go)

	item.btn:AddClickListener(self.onClickOption, self, item)

	item.txtOption = gohelper.findChildTextMesh(item.go, "#txt_Option")
	item.goStar = gohelper.findChild(item.go, "image_Star")

	return item
end

function FairyLandOption:showOptions(stepConfig)
	self:initOption()

	self.sectionId = -1

	gohelper.setActive(self.goLeft, true)

	local params = string.splitToNumber(stepConfig.param, "#")
	local contents = string.split(stepConfig.content, "#")
	local options = {}

	for i, v in ipairs(params) do
		options[v] = contents[i]
	end

	for i, v in ipairs(self.optionList) do
		self:updateOption(v, options[i])
	end
end

function FairyLandOption:updateOption(item, content)
	if not content then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	item.txtOption.text = content
end

function FairyLandOption:onClickOption(item)
	local param = {}

	param.elementId = 1
	param.speaker = luaLang("mainrolename")
	param.content = item.txtOption.text

	self:addContent(param)
	self:selectOption(item.index)
end

function FairyLandOption:deleteOption(item)
	if not item then
		return
	end

	item.btn:RemoveClickListener()
end

function FairyLandOption:moveLast()
	local contentTransform = self.scrollContent.transform

	ZProj.UGUIHelper.RebuildLayout(contentTransform)

	local scrollHeight = recthelper.getHeight(contentTransform.parent)
	local contentHeight = recthelper.getHeight(contentTransform)
	local maxPos = math.max(contentHeight - scrollHeight, 0)

	recthelper.setAnchorY(contentTransform, maxPos)
end

function FairyLandOption:hide()
	gohelper.setActive(self._go, false)

	if self.contentList then
		for k, v in pairs(self.contentList) do
			gohelper.setActive(v.go, false)

			if v.fadeText then
				v.fadeText:killTween()
			end
		end
	end
end

function FairyLandOption:playAudio(audioId)
	self:stopAudio()

	if audioId and audioId > 0 then
		self.playingId = AudioMgr.instance:trigger(audioId)
	end
end

function FairyLandOption:stopAudio()
	if self.playingId then
		AudioMgr.instance:stopPlayingID(self.playingId)

		self.playingId = nil
	end
end

function FairyLandOption:dispose()
	self:stopAudio()

	if self.optionList then
		for k, v in pairs(self.optionList) do
			self:deleteOption(v)
		end
	end

	if self.contentList then
		for k, v in pairs(self.contentList) do
			self:deleteContentItem(v)
		end
	end

	self:__onDispose()
end

return FairyLandOption
