-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/view/LengZhou6LevelItem.lua

module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6LevelItem", package.seeall)

local LengZhou6LevelItem = class("LengZhou6LevelItem", ListScrollCellExtend)

function LengZhou6LevelItem:onInitView()
	self._goNormal = gohelper.findChild(self.viewGO, "#go_Normal")
	self._goEvenLine = gohelper.findChild(self.viewGO, "#go_Normal/#go_EvenLine")
	self._goLockedevenLine = gohelper.findChild(self.viewGO, "#go_Normal/#go_EvenLine/#go_Locked_evenLine")
	self._goUnlockedevenLine = gohelper.findChild(self.viewGO, "#go_Normal/#go_EvenLine/#go_Unlocked_evenLine")
	self._goOddLine = gohelper.findChild(self.viewGO, "#go_Normal/#go_OddLine")
	self._goLockedoddLine = gohelper.findChild(self.viewGO, "#go_Normal/#go_OddLine/#go_Locked_oddLine")
	self._goUnlockedoddLine = gohelper.findChild(self.viewGO, "#go_Normal/#go_OddLine/#go_Unlocked_oddLine")
	self._goType1 = gohelper.findChild(self.viewGO, "#go_Normal/#go_Type1")
	self._goLocked1 = gohelper.findChild(self.viewGO, "#go_Normal/#go_Type1/#go_Locked_1")
	self._goNormal1 = gohelper.findChild(self.viewGO, "#go_Normal/#go_Type1/#go_Normal_1")
	self._goCompleted1 = gohelper.findChild(self.viewGO, "#go_Normal/#go_Type1/#go_Completed_1")
	self._goType2 = gohelper.findChild(self.viewGO, "#go_Normal/#go_Type2")
	self._goLocked2 = gohelper.findChild(self.viewGO, "#go_Normal/#go_Type2/#go_Locked_2")
	self._goNormal2 = gohelper.findChild(self.viewGO, "#go_Normal/#go_Type2/#go_Normal_2")
	self._goCompleted2 = gohelper.findChild(self.viewGO, "#go_Normal/#go_Type2/#go_Completed_2")
	self._imageStageNum = gohelper.findChildImage(self.viewGO, "#go_Normal/#image_StageNum")
	self._txtStageName = gohelper.findChildText(self.viewGO, "#go_Normal/#txt_StageName")
	self._goEndless = gohelper.findChild(self.viewGO, "#go_Endless")
	self._txtEndless = gohelper.findChildText(self.viewGO, "#go_Endless/#txt_Endless")
	self._txtLv = gohelper.findChildText(self.viewGO, "#go_Endless/#txt_Lv")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Endless/#btn_reset")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LengZhou6LevelItem:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function LengZhou6LevelItem:removeEvents()
	self._btnreset:RemoveClickListener()
end

function LengZhou6LevelItem:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.LengZhou6EndLessClear, MsgBoxEnum.BoxType.Yes_No, self._endLessClear, nil, nil, self)
end

function LengZhou6LevelItem:_endLessClear()
	UIBlockHelper.instance:startBlock(LengZhou6Enum.BlockKey.OneClickResetLevel)
	LengZhou6Controller.instance:finishLevel(self._episodeId, "")
end

function LengZhou6LevelItem:_editableInitView()
	self._clickLister = SLFramework.UGUI.UIClickListener.Get(self.viewGO)

	self._clickLister:AddClickListener(self._onClick, self)

	self.ani = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function LengZhou6LevelItem:_editableAddEvents()
	return
end

function LengZhou6LevelItem:_editableRemoveEvents()
	return
end

function LengZhou6LevelItem:_onClick()
	if self._episodeId == nil then
		return
	end

	if not self._episode:unLock() then
		ToastController.instance:showToast(23)

		return
	end

	LengZhou6Controller.instance:clickEpisode(self._episodeId)
end

function LengZhou6LevelItem:initEpisodeId(index, episodeId)
	self._index = index
	self._episodeId = episodeId
	self._episode = LengZhou6Model.instance:getEpisodeInfoMo(episodeId)

	self:initView()
end

function LengZhou6LevelItem:initView()
	if self._episode == nil or self._episodeId == nil then
		return
	end

	local isEndLess = self._episode:isEndlessEpisode()

	if not isEndLess then
		self._txtStageName.text = self._episode:getEpisodeName()

		local imageName = "v2a7_hissabeth_level_stage_0" .. self._index

		UISpriteSetMgr.instance:setHisSaBethSprite(self._imageStageNum, imageName)
	else
		self._txtEndless.text = self._episode:getEpisodeName()
	end
end

function LengZhou6LevelItem:refreshState()
	local isDown = self._episode:isDown()
	local unLock = self._episode:unLock()
	local isFinish = self._episode.isFinish
	local isEndLess = self._episode:isEndlessEpisode()
	local haveEliminate = self._episode:haveEliminate()

	self._aniName = "open"

	if isFinish then
		self._aniName = "finish"
	elseif unLock then
		self._aniName = "unlock"
	end

	gohelper.setActive(self._goEvenLine, not isDown)
	gohelper.setActive(self._goOddLine, isDown)
	gohelper.setActive(self._goNormal, not isEndLess)
	gohelper.setActive(self._goEndless, isEndLess)

	if not isEndLess then
		gohelper.setActive(self._goLocked1, not unLock)
		gohelper.setActive(self._goLocked2, not unLock)
		gohelper.setActive(self._goLockedevenLine, not unLock)
		gohelper.setActive(self._goLockedoddLine, not unLock)
		gohelper.setActive(self._goUnlockedevenLine, unLock)
		gohelper.setActive(self._goUnlockedoddLine, unLock)
		gohelper.setActive(self._goNormal1, unLock)
		gohelper.setActive(self._goNormal2, unLock)
		gohelper.setActive(self._goCompleted1, isFinish)
		gohelper.setActive(self._goCompleted2, isFinish)
		gohelper.setActive(self._goType1, not haveEliminate)
		gohelper.setActive(self._goType2, haveEliminate)
	else
		local isNilProgress = string.nilorempty(self._episode.progress)
		local needShow = false

		if not isNilProgress then
			local progress = self._episode:getEndLessBattleProgress()
			local lv = self._episode:getLevel()

			if progress and progress == LengZhou6Enum.BattleProgress.selectFinish or lv ~= 1 then
				needShow = true
			end
		end

		self._txtLv.text = needShow and string.format("Lv.%s", self._episode:getLevel()) or ""

		gohelper.setActive(self._btnreset.gameObject, needShow)
	end
end

function LengZhou6LevelItem:finishStateEnd()
	return self._aniName == "finish"
end

function LengZhou6LevelItem:updateInfo(showAni)
	if self._episode == nil or self._episodeId == nil then
		return
	end

	self:refreshState()

	local canShowItem = self._episode:canShowItem()

	gohelper.setActive(self.viewGO, canShowItem)

	if showAni then
		self:playAni(self._aniName)
	end
end

function LengZhou6LevelItem:playAni(name)
	if self.ani and name then
		self.ani:Play(name, 0, 0)
	end
end

function LengZhou6LevelItem:onDestroyView()
	if self._clickLister ~= nil then
		self._clickLister:RemoveClickListener()

		self._clickLister = nil
	end
end

return LengZhou6LevelItem
