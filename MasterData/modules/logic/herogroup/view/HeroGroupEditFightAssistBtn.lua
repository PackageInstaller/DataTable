-- chunkname: @modules/logic/herogroup/view/HeroGroupEditFightAssistBtn.lua

module("modules.logic.herogroup.view.HeroGroupEditFightAssistBtn", package.seeall)

local HeroGroupEditFightAssistBtn = class("HeroGroupEditFightAssistBtn", BaseView)

function HeroGroupEditFightAssistBtn:onInitView()
	self._btnassist = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_assist")
	self._btnrelease = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_release")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupEditFightAssistBtn:addEvents()
	if self._btnassist then
		self._btnassist:AddClickListener(self._btnassistOnClick, self)
	end

	if self._btnrelease then
		self._btnrelease:AddClickListener(self._btnreleaseOnClick, self)
	end
end

function HeroGroupEditFightAssistBtn:removeEvents()
	if self._btnassist then
		self._btnassist:RemoveClickListener()
	end

	if self._btnrelease then
		self._btnrelease:RemoveClickListener()
	end
end

function HeroGroupEditFightAssistBtn:_btnassistOnClick()
	if not self._episdoeType then
		return
	end

	local assistType = PickAssistEnum.EpisdoeTypeAssistType[self._episdoeType]

	if not assistType then
		return
	end

	local episodeId = self:_getEpisodeId()

	PickAssistController.instance:openPickAssistView(assistType, self._episdoeActId, nil, self._pickOverCallBack, self, true, nil, nil, {
		episodeId = episodeId
	})
end

function HeroGroupEditFightAssistBtn:_getEpisodeId()
	local episodeId = DungeonModel.instance.curSendEpisodeId

	if episodeId ~= nil then
		logNormal("HeroGroupEditFightAssistBtn use curSendEpisodeId curId: " .. tostring(episodeId) .. " episodeID: " .. tostring(HeroGroupModel.instance.episodeId))

		return episodeId
	end

	logNormal("HeroGroupEditFightAssistBtn use HeroGroupModelId curId: " .. tostring(episodeId) .. " episodeID: " .. tostring(HeroGroupModel.instance.episodeId))

	return HeroGroupModel.instance.episodeId
end

function HeroGroupEditFightAssistBtn:_pickOverCallBack(mo)
	if not mo then
		return
	end

	self:_setAssistMo(mo)
	self:_refreshAssistBtn()

	local isQuickEdit = HeroGroupEditListModel.instance:getQuickEditState()

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)

	if not isQuickEdit and mo then
		local index = HeroGroupEditListModel.instance:getSelectAssistHeroIndex(mo)

		if index then
			HeroGroupEditListModel.instance:selectCell(index, true)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, mo.heroMO)
		end
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnAssistPickOver, mo)
end

function HeroGroupEditFightAssistBtn:_setAssistMo(mo)
	if self._episdoeType == DungeonEnum.EpisodeType.V3_2ZongMao then
		V3a2_BossRushModel.instance:setEditorAssistMo(mo)
	end

	HeroGroupHandler.setAssistMo(HeroGroupModel.instance.episodeId, mo, 1, true)
end

function HeroGroupEditFightAssistBtn:_btnreleaseOnClick()
	local isSelectAssist = HeroGroupEditListModel.instance:isCurSelectAssistHero()

	HeroGroupModel.instance:clearCurAssist(true)
	self:_refreshAssistBtn()

	if isSelectAssist then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	GameFacade.showToast(ToastEnum.CancelAssist)
end

function HeroGroupEditFightAssistBtn:_editableInitView()
	return
end

function HeroGroupEditFightAssistBtn:onUpdateParam()
	return
end

function HeroGroupEditFightAssistBtn:onOpen()
	self.singleGroupMOId = self.viewParam.singleGroupMOId

	self:_refreshAssistBtn()
end

function HeroGroupEditFightAssistBtn:_refreshAssistBtn()
	local isAllow, assistMo, episdoeType, actId = HeroGroupModel.instance:getAssistMo()
	local editorAssistMo = HeroGroupModel.instance:getEditorAssistMo()

	self._episdoeType = episdoeType
	self._episdoeActId = actId

	gohelper.setActive(self._btnassist.gameObject, isAllow and assistMo == nil and editorAssistMo == nil)
	gohelper.setActive(self._btnrelease.gameObject, isAllow and (assistMo ~= nil or editorAssistMo ~= nil))
end

function HeroGroupEditFightAssistBtn:onClose()
	return
end

function HeroGroupEditFightAssistBtn:onDestroyView()
	return
end

return HeroGroupEditFightAssistBtn
