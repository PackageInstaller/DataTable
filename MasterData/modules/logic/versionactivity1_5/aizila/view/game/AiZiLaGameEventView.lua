-- chunkname: @modules/logic/versionactivity1_5/aizila/view/game/AiZiLaGameEventView.lua

module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameEventView", package.seeall)

local AiZiLaGameEventView = class("AiZiLaGameEventView", BaseView)

function AiZiLaGameEventView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "content/#simage_PanelBG")
	self._scrollDescr = gohelper.findChildScrollRect(self.viewGO, "content/#scroll_Descr")
	self._txtDescr = gohelper.findChildText(self.viewGO, "content/#scroll_Descr/Viewport/Content/#txt_Descr")
	self._simagePanelBGMask = gohelper.findChildSingleImage(self.viewGO, "content/#simage_PanelBGMask")
	self._simageLevelPic = gohelper.findChildSingleImage(self.viewGO, "content/#simage_LevelPic")
	self._goselectItem = gohelper.findChild(self.viewGO, "content/#go_selectItem")
	self._goEnable = gohelper.findChild(self.viewGO, "content/#go_selectItem/#go_Enable")
	self._goDisable = gohelper.findChild(self.viewGO, "content/#go_selectItem/#go_Disable")
	self._txtname = gohelper.findChildText(self.viewGO, "content/#go_selectItem/#txt_name")
	self._txtdesc = gohelper.findChildText(self.viewGO, "content/#go_selectItem/#txt_desc")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "content/#go_selectItem/#btn_click")
	self._goselectGroup = gohelper.findChild(self.viewGO, "content/scroll_select/Viewport/#go_selectGroup")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaGameEventView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function AiZiLaGameEventView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnclick:RemoveClickListener()
end

function AiZiLaGameEventView:_btncloseOnClick()
	self:closeThis()
end

function AiZiLaGameEventView:_btnclickOnClick()
	return
end

function AiZiLaGameEventView:_editableInitView()
	self._animator = self.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	self._goTagBG = gohelper.findChild(self.viewGO, "content/image_TagBG")

	transformhelper.setLocalPos(self._goselectItem.transform, 0, 0, 0)
	gohelper.setActive(self._goselectItem, false)
end

function AiZiLaGameEventView:onUpdateParam()
	return
end

function AiZiLaGameEventView:playViewAnimator(animName)
	if self._animator then
		self._animator.enabled = true

		self._animator:Play(animName, 0, 0)
	end
end

function AiZiLaGameEventView:onOpen()
	self.addEventCb(self, AiZiLaController.instance, AiZiLaEvent.ExitGame, self.closeThis, self)
	self.addEventCb(self, AiZiLaController.instance, AiZiLaEvent.RefreshGameEpsiode, self.refreshUI, self)

	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._btncloseOnClick, self)
	end

	self._eventId = AiZiLaGameModel.instance:getEventId()
	self._actId = AiZiLaGameModel.instance:getActivityID()
	self._eventCfg = AiZiLaConfig.instance:getEventCo(self._actId, self._eventId)
	self._episodeCfg = AiZiLaConfig.instance:getEpisodeCo(self._actId, AiZiLaGameModel.instance:getEpisodeId())

	if not self._eventCfg then
		logError("export_事件 配置找不到: activityId:%s eventId:%s", self._actId, self._eventId)
	end

	if self._eventCfg.eventType == AiZiLaEnum.EventType.BranchLine then
		AiZiLaController.instance:dispatchEvent(AiZiLaEvent.OnBranchLineEvent)
	end

	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_forward_paper)
	self:refreshUI()
end

function AiZiLaGameEventView:onClose()
	return
end

function AiZiLaGameEventView:onDestroyView()
	self._simageLevelPic:UnLoadImage()
end

function AiZiLaGameEventView:refreshUI()
	if not self._eventCfg then
		return
	end

	if self._episodeCfg and not string.nilorempty(self._episodeCfg.picture) then
		self._simageLevelPic:LoadImage(string.format("%s.png", self._episodeCfg.picture))
	end

	gohelper.setActive(self._goTagBG, self._eventCfg.eventType == AiZiLaEnum.EventType.BranchLine)

	local datalist = self:_getOptionMOList()

	gohelper.CreateObjList(self, self._onSelectItem, datalist, self._goselectGroup, self._goselectItem, AiZiLaGameEventItem)

	self._txtDescr.text = self._eventCfg.desc
end

function AiZiLaGameEventView:_getOptionMOList()
	local datalist = {}

	if self._eventCfg and not string.nilorempty(self._eventCfg.optionIds) then
		local params = string.splitToNumber(self._eventCfg.optionIds, "|")

		if params then
			for i, optionId in ipairs(params) do
				table.insert(datalist, {
					optionId = optionId,
					actId = self._actId,
					index = i,
					eventType = self._eventCfg.eventType
				})
			end
		end
	end

	return datalist
end

function AiZiLaGameEventView:_onSelectItem(cell_component, data, index)
	cell_component:onUpdateMO(data)

	cell_component._view = self
end

return AiZiLaGameEventView
