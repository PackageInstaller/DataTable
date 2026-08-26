-- chunkname: @modules/logic/story/view/StoryLogItem.lua

module("modules.logic.story.view.StoryLogItem", package.seeall)

local StoryLogItem = class("StoryLogItem", MixScrollCell)

function StoryLogItem:init(go)
	self.viewGO = go
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._goname = gohelper.findChild(self.viewGO, "#go_normal/#go_name")
	self._goplayicon = gohelper.findChild(self.viewGO, "#go_normal/#go_playicon")
	self._gostopicon = gohelper.findChild(self.viewGO, "#go_normal/#go_stopicon")
	self._goicon = gohelper.findChild(self.viewGO, "#go_normal/#go_name/#go_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_normal/#go_name/#txt_name")
	self._txtcontent = gohelper.findChildText(self.viewGO, "#go_normal/#txt_content")
	self._gonorole = gohelper.findChild(self.viewGO, "#go_normal/#go_norole")
	self._gobranch = gohelper.findChild(self.viewGO, "#go_branch")
	self._simagebranch1 = gohelper.findChildSingleImage(self.viewGO, "#go_branch/#simage_branch1")
	self._txtbranch1 = gohelper.findChildText(self.viewGO, "#go_branch/#simage_branch1/#txt_branch1")
	self._simagebranch2 = gohelper.findChildSingleImage(self.viewGO, "#go_branch/#simage_branch2")
	self._txtbranch2 = gohelper.findChildText(self.viewGO, "#go_branch/#simage_branch2/#txt_branch2")
	self._simagebranch3 = gohelper.findChildSingleImage(self.viewGO, "#go_branch/#simage_branch3")
	self._txtbranch3 = gohelper.findChildText(self.viewGO, "#go_branch/#simage_branch3/#txt_branch3")
	self._simagebranch4 = gohelper.findChildSingleImage(self.viewGO, "#go_branch/#simage_branch4")
	self._txtbranch4 = gohelper.findChildText(self.viewGO, "#go_branch/#simage_branch4/#txt_branch4")
	self._btnplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_play")
	self._btnstop = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_stop")
	self._goselect1 = gohelper.findChild(self.viewGO, "#go_branch/#simage_branch1/#go_select1")
	self._goselect2 = gohelper.findChild(self.viewGO, "#go_branch/#simage_branch2/#go_select2")
	self._goselect3 = gohelper.findChild(self.viewGO, "#go_branch/#simage_branch3/#go_select3")
	self._goselect4 = gohelper.findChild(self.viewGO, "#go_branch/#simage_branch4/#go_select4")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoryLogItem:addEvents()
	return
end

function StoryLogItem:removeEvents()
	return
end

function StoryLogItem:_editableInitView()
	self._txtbranchs = {
		self._txtbranch1,
		self._txtbranch2,
		self._txtbranch3,
		self._txtbranch4
	}
	self._simagebranchs = {
		self._simagebranch1,
		self._simagebranch2,
		self._simagebranch3,
		self._simagebranch4
	}
	self._goselects = {
		self._goselect1,
		self._goselect2,
		self._goselect3,
		self._goselect4
	}

	self._btnplay:AddClickListener(self._onPlayClick, self)
	self._btnstop:AddClickListener(self._onStopClick, self)
	StoryController.instance:registerCallback(StoryEvent.LogSelected, self._onItemSelected, self)
	StoryController.instance:registerCallback(StoryEvent.LogAudioFinished, self._onItemAudioFinished, self)
end

function StoryLogItem:_editableAddEvents()
	return
end

function StoryLogItem:_editableRemoveEvents()
	return
end

function StoryLogItem:_onItemAudioFinished()
	if self._hasLowPassAudio then
		AudioMgr.instance:trigger(AudioEnum.Story.Stop_Lowpass)

		self._hasLowPassAudio = false
	end

	if not self._audioId or self._audioId == 0 then
		return
	end

	if not self._mo or type(self._mo.info) ~= "number" then
		return
	end

	if self._audioId == StoryLogListModel.instance:getPlayingLogAudioId() then
		gohelper.setActive(self._gostopicon, false)
		gohelper.setActive(self._goplayicon, true)
		gohelper.setActive(self._btnplay.gameObject, true)
		gohelper.setActive(self._btnstop.gameObject, false)

		local co = StoryStepModel.instance:getStepListById(self._mo.info).conversation

		if co.type == StoryEnum.ConversationType.Player or co.nameShow and co.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == luaLang("mainrolename") and co.type ~= StoryEnum.ConversationType.None and co.type ~= StoryEnum.ConversationType.ScreenDialog then
			self:_setItemContentColor("#CCAD8F")
		else
			self:_setItemContentColor("#EEF1E8")
			SLFramework.UGUI.GuiHelper.SetColor(self._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
		end
	end
end

function StoryLogItem:_onItemSelected(audioId)
	if not audioId or audioId == 0 or not self._audioId or self._audioId == 0 then
		return
	end

	if self._audioId == audioId then
		return
	end

	if type(self._mo.info) == "number" then
		local co = StoryStepModel.instance:getStepListById(self._mo.info).conversation

		if co.type == StoryEnum.ConversationType.None then
			gohelper.setActive(self._goplayicon, false)
			gohelper.setActive(self._gostopicon, false)
			gohelper.setActive(self._btnplay.gameObject, false)
			gohelper.setActive(self._btnstop.gameObject, false)

			return
		end

		if self._audioId ~= 0 then
			AudioEffectMgr.instance:stopAudio(self._audioId, 0)
			gohelper.setActive(self._goplayicon, true)
			gohelper.setActive(self._gostopicon, false)
			gohelper.setActive(self._btnplay.gameObject, true)
			gohelper.setActive(self._btnstop.gameObject, false)
		else
			gohelper.setActive(self._goplayicon, false)
			gohelper.setActive(self._gostopicon, false)
			gohelper.setActive(self._btnplay.gameObject, false)
			gohelper.setActive(self._btnstop.gameObject, false)
		end
	elseif type(self._mo.info) == "table" then
		gohelper.setActive(self._goplayicon, false)
		gohelper.setActive(self._gostopicon, false)
		gohelper.setActive(self._btnplay.gameObject, false)
		gohelper.setActive(self._btnstop.gameObject, false)
	end
end

function StoryLogItem:_onPlayClick()
	gohelper.setActive(self._gostopicon, true)
	gohelper.setActive(self._goplayicon, false)
	gohelper.setActive(self._btnplay.gameObject, false)
	gohelper.setActive(self._btnstop.gameObject, true)
	self:_setItemContentColor("#D56B39")
	SLFramework.UGUI.GuiHelper.SetColor(self._gonorole:GetComponent(gohelper.Type_Image), "#BD5C2F")

	if not self._audioId or self._audioId == 0 then
		return
	end

	local playLogAudioId = StoryLogListModel.instance:getPlayingLogAudioId()

	if playLogAudioId == self._audioId then
		return
	end

	local isPlaying = AudioEffectMgr.instance:isPlaying(self._audioId)

	if isPlaying then
		return
	end

	AudioEffectMgr.instance:stopAudio(playLogAudioId, 0)

	local param = {}

	param.loopNum = 1
	param.fadeInTime = 0
	param.fadeOutTime = 0
	param.volume = 100
	param.callback = self._onAudioFinished
	param.callbackTarget = self

	AudioEffectMgr.instance:playAudio(self._audioId, param)
	StoryLogListModel.instance:setPlayingLogAudio(self._audioId)
	StoryController.instance:dispatchEvent(StoryEvent.LogSelected, self._audioId)

	local co = StoryStepModel.instance:getStepListById(self._mo.info).conversation

	if #co.audios > 1 then
		for _, v in pairs(co.audios) do
			if v == AudioEnum.Story.Play_Lowpass then
				self._hasLowPassAudio = true

				AudioMgr.instance:trigger(AudioEnum.Story.Play_Lowpass)

				break
			end
		end
	end
end

function StoryLogItem:_onStopClick()
	gohelper.setActive(self._gostopicon, false)
	gohelper.setActive(self._goplayicon, true)
	gohelper.setActive(self._btnplay.gameObject, true)
	gohelper.setActive(self._btnstop.gameObject, false)

	local co = StoryStepModel.instance:getStepListById(self._mo.info).conversation

	if co.type == StoryEnum.ConversationType.Player or co.nameShow and co.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == luaLang("mainrolename") and co.type ~= StoryEnum.ConversationType.None and co.type ~= StoryEnum.ConversationType.ScreenDialog then
		self:_setItemContentColor("#CCAD8F")
	else
		self:_setItemContentColor("#EEF1E8")
		SLFramework.UGUI.GuiHelper.SetColor(self._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
	end

	StoryLogListModel.instance:setPlayingLogAudioFinished(self._audioId)
	AudioEffectMgr.instance:stopAudio(self._audioId, 0)
end

function StoryLogItem:_onAudioFinished()
	StoryController.instance:dispatchEvent(StoryEvent.LogAudioFinished)

	if self._audioId ~= StoryLogListModel.instance:getPlayingLogAudioId() then
		StoryLogListModel.instance:setPlayingLogAudio(0)
	end

	if not self._mo or self._audioId == 0 then
		return
	end

	if type(self._mo.info) == "table" then
		StoryLogListModel.instance:setPlayingLogAudio(0)

		return
	end

	StoryLogListModel.instance:setPlayingLogAudioFinished(self._audioId)
	gohelper.setActive(self._gostopicon, false)
	gohelper.setActive(self._goplayicon, true)
	gohelper.setActive(self._btnplay.gameObject, true)
	gohelper.setActive(self._btnstop.gameObject, false)

	local co = StoryStepModel.instance:getStepListById(self._mo.info).conversation

	if co.type == StoryEnum.ConversationType.Player or co.nameShow and co.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == luaLang("mainrolename") and co.type ~= StoryEnum.ConversationType.None and co.type ~= StoryEnum.ConversationType.ScreenDialog then
		self:_setItemContentColor("#CCAD8F")
	else
		self:_setItemContentColor("#EEF1E8")
		SLFramework.UGUI.GuiHelper.SetColor(self._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
	end
end

function StoryLogItem:onUpdateMO(mo, mixType)
	if not mo then
		return
	end

	self._mo = mo

	self:_setItemContentColor("#EEF1E8")
	SLFramework.UGUI.GuiHelper.SetColor(self._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")

	if type(mo.info) == "number" then
		gohelper.setActive(self._gonormal, true)
		gohelper.setActive(self._gobranch, false)

		local stepCo = StoryStepModel.instance:getStepListById(mo.info)
		local co = stepCo.conversation
		local txt = string.find(co.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()], "<voffset") and co.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] or GameUtil.filterRichText(co.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

		if SDKModel.instance:isDmm() and LangSettings.instance:isJp() then
			local storyId = StoryController.instance._curStoryId
			local stepId = mo.info

			if storyId == 100601 and stepId == 36 then
				txt = "はっ！　正気の沙汰じゃない。一家そろって◯◯◯だぞ！"
			elseif storyId == 100602 and stepId == 30 then
				txt = "あんたらがマヌス・ヴェンデッタの仮面を研究したおかげで、その副作用が徹底的に分かったぜ！　おかげで、ラプラスの廊下は身体のあちこちから石油を垂らす◯◯◯で埋まっちまったがな。"
			elseif storyId == 100726 and stepId == 32 then
				txt = "ははは！　死ね、無様な◯◯◯どもが！！"
			end
		end

		self._audioId = 0

		if co.audios[1] and not co.disableAudio[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] then
			self._audioId = co.audios[1]
		end

		txt = StoryModel.instance:getStoryTxtByVoiceType(StoryTool.getFilterDia(txt), self._audioId)

		local markTopList = StoryTool.getMarkTopTextList(txt)

		txt = StoryTool.filterMarkTop(txt)

		if StoryModel.instance:isMagicType(stepCo) then
			txt = StoryConfig.instance:replaceStoryMagicText(txt)
		end

		if GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
			txt = string.gsub(txt, "<glitch>", "")
			txt = string.gsub(txt, "</glitch>", "")
		else
			txt = string.gsub(txt, "<glitch>", "<i><b>")
			txt = string.gsub(txt, "</glitch>", "</i></b>")
		end

		self._txtcontent.text = StoryTool.filterSpTag(txt)

		if co.type ~= StoryEnum.ConversationType.Aside then
			gohelper.setActive(self._gonorole, false)

			if not co.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] or co.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == "" or not co.nameShow then
				gohelper.setActive(self._goname, false)
			elseif mixType == 1 then
				gohelper.setActive(self._goname, false)
			else
				self._txtname.text = string.format("%s:", string.split(co.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()], "_")[1])

				gohelper.setActive(self._goname, true)
			end

			if self._audioId ~= 0 then
				local isPlaying = self._audioId == StoryLogListModel.instance:getPlayingLogAudioId()

				gohelper.setActive(self._gostopicon, isPlaying)
				gohelper.setActive(self._goplayicon, not isPlaying)
				gohelper.setActive(self._btnplay.gameObject, not isPlaying)
				gohelper.setActive(self._btnstop.gameObject, isPlaying)

				if isPlaying then
					self:_setItemContentColor("#D56B39")
				end
			else
				gohelper.setActive(self._gostopicon, false)
				gohelper.setActive(self._goplayicon, false)
				gohelper.setActive(self._btnplay.gameObject, false)
				gohelper.setActive(self._btnstop.gameObject, false)
			end
		else
			gohelper.setActive(self._gonorole, false)
			gohelper.setActive(self._goname, false)

			if self._audioId ~= 0 then
				local isPlaying = self._audioId == StoryLogListModel.instance:getPlayingLogAudioId()

				gohelper.setActive(self._gostopicon, isPlaying)
				gohelper.setActive(self._goplayicon, not isPlaying)
				gohelper.setActive(self._btnplay.gameObject, not isPlaying)
				gohelper.setActive(self._btnstop.gameObject, isPlaying)

				if isPlaying then
					self:_setItemContentColor("#D56B39")
					SLFramework.UGUI.GuiHelper.SetColor(self._gonorole:GetComponent(gohelper.Type_Image), "#BD5C2F")
				end
			else
				gohelper.setActive(self._gostopicon, false)
				gohelper.setActive(self._goplayicon, false)
				gohelper.setActive(self._btnplay.gameObject, false)
				gohelper.setActive(self._btnstop.gameObject, false)
			end
		end

		if co.type == StoryEnum.ConversationType.Player or co.nameShow and co.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == luaLang("mainrolename") and co.type ~= StoryEnum.ConversationType.None and co.type ~= StoryEnum.ConversationType.ScreenDialog then
			gohelper.setActive(self._goicon, true)
			self:_setItemContentColor("#CCAD8F")
		else
			gohelper.setActive(self._goicon, false)
		end
	elseif type(mo.info) == "table" then
		gohelper.setActive(self._gonormal, false)
		gohelper.setActive(self._gobranch, true)
		gohelper.setActive(self._goplayicon, false)
		gohelper.setActive(self._gostopicon, false)
		gohelper.setActive(self._btnplay.gameObject, false)
		gohelper.setActive(self._btnstop.gameObject, false)

		local boolbranchs = {
			false,
			false,
			false,
			false
		}
		local optList = StoryModel.instance:getShowStoryBranchOpts(mo.info.stepId)

		for i, opt in ipairs(optList) do
			boolbranchs[i] = true
			self._txtbranchs[i].text = opt.branchTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]

			if i == mo.info.index then
				self._simagebranchs[i]:LoadImage(ResUrl.getStoryItem("bg_xuanxiang_ovr.png"))
				ZProj.UGUIHelper.SetColorAlpha(self._txtbranchs[i], 1)
				gohelper.setActive(self._goselects[i], true)
			else
				self._simagebranchs[i]:LoadImage(ResUrl.getStoryItem("bg_xuanxiang.png"))
				ZProj.UGUIHelper.SetColorAlpha(self._txtbranchs[i], 0.7)
				gohelper.setActive(self._goselects[i], false)
			end
		end

		for i = 1, 4 do
			gohelper.setActive(self._simagebranchs[i].gameObject, boolbranchs[i])
		end
	end
end

function StoryLogItem:onSelect(isSelect)
	return
end

function StoryLogItem:_setItemContentColor(colorStr)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtname, colorStr)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtcontent, colorStr)
	TaskDispatcher.runDelay(function()
		if not self._txtcontent then
			return
		end

		local meshs = {}
		local subMeshs = self._txtcontent.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

		if subMeshs then
			local iter = subMeshs:GetEnumerator()

			while iter:MoveNext() do
				local subMesh = iter.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

				table.insert(meshs, subMesh)
			end
		end

		local matColor = GameUtil.parseColor(colorStr .. "FF")

		for _, v in pairs(meshs) do
			if v.sharedMaterial then
				v.sharedMaterial = UnityEngine.Object.Instantiate(v.sharedMaterial)

				v.materialForRendering:EnableKeyword("_GRADUAL_ON")
				v.materialForRendering:SetColor("_Color", matColor)
			end
		end
	end, nil, 0.01)
end

function StoryLogItem:onDestroy()
	if self._audioId ~= 0 then
		StoryLogListModel.instance:setPlayingLogAudioFinished(self._audioId)
		AudioEffectMgr.instance:stopAudio(self._audioId, 0)
	end

	self._btnplay:RemoveClickListener()
	self._btnstop:RemoveClickListener()
	StoryController.instance:unregisterCallback(StoryEvent.LogSelected, self._onItemSelected, self)
	StoryController.instance:unregisterCallback(StoryEvent.LogAudioFinished, self._onItemAudioFinished, self)

	for k, v in ipairs(self._simagebranchs) do
		self._simagebranchs[k]:UnLoadImage()
	end

	self._simagebranchs = nil
	self._txtbranchs = nil
	self._goselects = nil
end

return StoryLogItem
