-- chunkname: @modules/logic/explore/view/ExploreBonusSceneView.lua

module("modules.logic.explore.view.ExploreBonusSceneView", package.seeall)

local ExploreBonusSceneView = class("ExploreBonusSceneView", BaseView)

function ExploreBonusSceneView:onInitView()
	self._btnfullscreen = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fullscreen")
	self._gochoicelist = gohelper.findChild(self.viewGO, "#go_choicelist")
	self._gochoiceitem = gohelper.findChild(self.viewGO, "#go_choicelist/#go_choiceitem")
	self._txttalkinfo = gohelper.findChildText(self.viewGO, "#txt_talkinfo")
	self._txttalker = gohelper.findChildText(self.viewGO, "#txt_talker")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ExploreBonusSceneView:addEvents()
	NavigateMgr.instance:addSpace(ViewName.ExploreBonusSceneView, self.onClickFull, self)
	self._btnfullscreen:AddClickListener(self.onClickFull, self)
end

function ExploreBonusSceneView:removeEvents()
	NavigateMgr.instance:removeSpace(ViewName.ExploreBonusSceneView)
	self._btnfullscreen:RemoveClickListener()
end

function ExploreBonusSceneView:onClickFull()
	if self._hasIconDialogItem and self._hasIconDialogItem:isPlaying() then
		self._hasIconDialogItem:conFinished()

		return
	end

	if not self._btnDatas[1] then
		self._curStep = self._curStep + 1

		if self.config[self._curStep] then
			table.insert(self.options, -1)
			self:onStep()
		else
			if self.viewParam.callBack then
				self.viewParam.callBack(self.viewParam.callBackObj, self.options)
			end

			self:closeThis()
		end
	end
end

function ExploreBonusSceneView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open)

	self.unit = self.viewParam.unit
	self.config = ExploreConfig.instance:getDialogueConfig(self.viewParam.id)

	if not self.config then
		logError("对话配置不存在，id：" .. tostring(self.viewParam.id))
		self:closeThis()

		return
	end

	self.options = {}
	self._curStep = 1

	self:onStep()
end

function ExploreBonusSceneView:onStep()
	local co = self.config[self._curStep]
	local content = string.gsub(co.desc, " ", " ")

	self._hasIconDialogItem = self._hasIconDialogItem or MonoHelper.addLuaComOnceToGo(self.viewGO, TMPFadeIn)

	self._hasIconDialogItem:playNormalText(content)

	self._txttalker.text = co.speaker

	local btnDatas = {}

	if not string.nilorempty(co.bonusButton) then
		btnDatas = string.split(co.bonusButton, "|")
	end

	gohelper.CreateObjList(self, self._createItem, btnDatas, self._gochoicelist, self._gochoiceitem)

	self._btnDatas = btnDatas
end

function ExploreBonusSceneView:_createItem(obj, data, index)
	local txt = gohelper.findChildText(obj, "info")

	txt.text = data

	local btn = gohelper.findChildButtonWithAudio(obj, "click")

	self:removeClickCb(btn)
	self.addClickCb(self, btn, self.onBtnClick, self, index)
end

function ExploreBonusSceneView:onBtnClick(index)
	table.insert(self.options, index)

	local co = self.config[self._curStep]

	GameSceneMgr.instance:getCurScene().stat:onTriggerEggs(string.format("%d_%d", co.id, co.stepid), self._btnDatas[index])

	self._btnDatas = {}

	self:onClickFull()
end

return ExploreBonusSceneView
