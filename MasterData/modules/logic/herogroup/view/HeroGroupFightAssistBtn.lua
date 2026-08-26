-- chunkname: @modules/logic/herogroup/view/HeroGroupFightAssistBtn.lua

module("modules.logic.herogroup.view.HeroGroupFightAssistBtn", package.seeall)

local HeroGroupFightAssistBtn = class("HeroGroupFightAssistBtn", BaseView)

function HeroGroupFightAssistBtn:onInitView()
	self._btnassist = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#btn_assist")
	self._btnrelease = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/btnContain/horizontal/#btn_release")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupFightAssistBtn:addEvents()
	if self._btnassist then
		self._btnassist:AddClickListener(self._btnassistOnClick, self)
	end

	if self._btnrelease then
		self._btnrelease:AddClickListener(self._btnreleaseOnClick, self)
	end

	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._refresh, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._onModifyGroupSelectIndex, self)
end

function HeroGroupFightAssistBtn:removeEvents()
	if self._btnassist then
		self._btnassist:RemoveClickListener()
	end

	if self._btnrelease then
		self._btnrelease:RemoveClickListener()
	end

	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._refresh, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._onModifyGroupSelectIndex, self)
end

function HeroGroupFightAssistBtn:_btnassistOnClick()
	if not self._episdoeType then
		return
	end

	local assistType = PickAssistEnum.EpisdoeTypeAssistType[self._episdoeType]

	if not assistType then
		return
	end

	PickAssistController.instance:openPickAssistView(assistType, self._episdoeActId, nil, self._pickOverCallBack, self, true)
end

function HeroGroupFightAssistBtn:_pickOverCallBack(mo)
	if not mo then
		return
	end

	local heroList = HeroSingleGroupModel.instance:getList()

	heroList = heroList or {}

	local index

	for i, _mo in ipairs(heroList) do
		if _mo.heroUid == "0" then
			index = index or i
		else
			local heroMo = HeroModel.instance:getById(_mo.heroUid)

			if heroMo and heroMo.heroId == mo.heroId then
				index = i
			end
		end
	end

	if index then
		self:_setAssistMo(mo, index)
	else
		HeroGroupModel.instance:setEditorAssistMo(mo)

		local firstMo = HeroSingleGroupModel.instance:getByIndex(1)
		local param = {}

		param.singleGroupMOId = 1
		param.isQiuckEditor = true

		if firstMo then
			param.originalHeroUid = firstMo.heroUid or mo.heroUid
		end

		ViewMgr.instance:openView(ViewName.HeroGroupEditView, param)
	end

	self:_refresh()
end

function HeroGroupFightAssistBtn:_setAssistMo(mo, i)
	HeroGroupModel.instance:setAssistMo(mo, i)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function HeroGroupFightAssistBtn:_btnreleaseOnClick()
	HeroGroupModel.instance:clearCurAssist(true)
	self:_refresh()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	GameFacade.showToast(ToastEnum.CancelAssist)
end

function HeroGroupFightAssistBtn:_onModifyGroupSelectIndex()
	HeroGroupModel.instance:clearCurAssist(true)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	self:_refresh()
end

function HeroGroupFightAssistBtn:_editableInitView()
	return
end

function HeroGroupFightAssistBtn:onUpdateParam()
	return
end

function HeroGroupFightAssistBtn:onOpen()
	self:_refresh()
end

function HeroGroupFightAssistBtn:_refresh()
	local isAllow, assistMo, episdoeType, actId = HeroGroupModel.instance:getAssistMo()
	local editorAssistMo = HeroGroupModel.instance:getEditorAssistMo()

	self._episdoeType = episdoeType
	self._episdoeActId = actId

	if self._btnassist then
		gohelper.setActive(self._btnassist.gameObject, isAllow and assistMo == nil and editorAssistMo == nil)
	end

	if self._btnrelease then
		gohelper.setActive(self._btnrelease.gameObject, isAllow and (assistMo ~= nil or editorAssistMo ~= nil))
	end
end

function HeroGroupFightAssistBtn:onClose()
	return
end

function HeroGroupFightAssistBtn:onDestroyView()
	return
end

return HeroGroupFightAssistBtn
