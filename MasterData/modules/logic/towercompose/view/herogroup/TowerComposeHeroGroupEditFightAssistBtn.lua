-- chunkname: @modules/logic/towercompose/view/herogroup/TowerComposeHeroGroupEditFightAssistBtn.lua

module("modules.logic.towercompose.view.herogroup.TowerComposeHeroGroupEditFightAssistBtn", package.seeall)

local TowerComposeHeroGroupEditFightAssistBtn = class("TowerComposeHeroGroupEditFightAssistBtn", BaseView)

function TowerComposeHeroGroupEditFightAssistBtn:onInitView()
	self._btnassist = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#go_assistContent/#btn_assist")
	self._goassist = gohelper.findChild(self.viewGO, "#go_ops/#go_assistContent/#btn_assist/#go_assist")
	self._gorelease = gohelper.findChild(self.viewGO, "#go_ops/#go_assistContent/#btn_assist/#go_release")
	self._btnassist1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#go_assistContent/#btn_assist1")
	self._goassist1 = gohelper.findChild(self.viewGO, "#go_ops/#go_assistContent/#btn_assist1/#go_assist1")
	self._gorelease1 = gohelper.findChild(self.viewGO, "#go_ops/#go_assistContent/#btn_assist1/#go_release1")
	self._golock1 = gohelper.findChild(self.viewGO, "#go_ops/#go_assistContent/#btn_assist1/#go_lock1")
	self._goassistCD1 = gohelper.findChild(self.viewGO, "#go_ops/#go_assistContent/#btn_assist1/#go_assistCD1")
	self._imageAssistCD1 = gohelper.findChildImage(self.viewGO, "#go_ops/#go_assistContent/#btn_assist1/#go_assistCD1")
	self._btnassist2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#go_assistContent/#btn_assist2")
	self._goassist2 = gohelper.findChild(self.viewGO, "#go_ops/#go_assistContent/#btn_assist2/#go_assist2")
	self._gorelease2 = gohelper.findChild(self.viewGO, "#go_ops/#go_assistContent/#btn_assist2/#go_release2")
	self._golock2 = gohelper.findChild(self.viewGO, "#go_ops/#go_assistContent/#btn_assist2/#go_lock2")
	self._goassistCD2 = gohelper.findChild(self.viewGO, "#go_ops/#go_assistContent/#btn_assist2/#go_assistCD2")
	self._imageAssistCD2 = gohelper.findChildImage(self.viewGO, "#go_ops/#go_assistContent/#btn_assist2/#go_assistCD2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeHeroGroupEditFightAssistBtn:addEvents()
	self._btnassist:AddClickListener(self._btnassistOnClick, self)
	self._btnassist1:AddClickListener(self._btnassistOnClick1, self)
	self._btnassist2:AddClickListener(self._btnassistOnClick2, self)
end

function TowerComposeHeroGroupEditFightAssistBtn:removeEvents()
	self._btnassist:RemoveClickListener()
	self._btnassist1:RemoveClickListener()
	self._btnassist2:RemoveClickListener()
end

function TowerComposeHeroGroupEditFightAssistBtn:_btnassistOnClick()
	local params = {
		planeId = self:getAssistPlaneId()
	}
	local assistMo = HeroGroupModel.instance:getEditorAssistMo(params)

	if assistMo then
		self:onReleaseAssist(params)

		return
	end

	if not self._episdoeType then
		return
	end

	local assistType = PickAssistEnum.EpisdoeTypeAssistType[self._episdoeType]

	if not assistType then
		return
	end

	PickAssistController.instance:openPickAssistView(assistType, self._episdoeActId, nil, self._pickOverCallBack, self, true, nil, nil, {
		episodeId = DungeonModel.instance.curSendEpisodeId
	})
end

function TowerComposeHeroGroupEditFightAssistBtn:_pickOverCallBack(mo)
	if not mo then
		return
	end

	self:setAssistMo(mo, {
		planeId = self:getAssistPlaneId()
	})
	self:refreshAssistBtn()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)

	local isQuickEdit = HeroGroupEditListModel.instance:getQuickEditState()

	if not isQuickEdit and mo then
		local index = HeroGroupEditListModel.instance:getSelectAssistHeroIndex(mo)

		if index then
			HeroGroupEditListModel.instance:selectCell(index, true)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, mo.heroMO)
		end
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnAssistPickOver, mo)
end

function TowerComposeHeroGroupEditFightAssistBtn:_btnassistOnClick1()
	if self:checkPlaneLock(1) then
		GameFacade.showToast(ToastEnum.TowerComposeRecordRoleLock)

		return
	end

	local params = {
		planeId = 1
	}
	local _, assistMo = HeroGroupHandler.getAssistMo(self.fightParam.episodeId, true, {
		planeId = 1
	})

	if assistMo then
		self:onReleaseAssist(params)

		return
	end

	if not self._episdoeType then
		return
	end

	if self.isInCD then
		GameFacade.showToast(ToastEnum.Season123RefreshAssistInCD)

		return
	end

	local assistType = PickAssistEnum.EpisdoeTypeAssistType[self._episdoeType]

	if not assistType then
		return
	end

	PickAssistController.instance:openPickAssistView(assistType, self._episdoeActId, nil, self._pickOverCallBack1, self, true, nil, nil, {
		episodeId = DungeonModel.instance.curSendEpisodeId
	})
end

function TowerComposeHeroGroupEditFightAssistBtn:_pickOverCallBack1(mo)
	if not mo then
		return
	end

	self:setAssistMo(mo, {
		planeId = 1
	})
	self:refreshAssistBtn()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)

	local isQuickEdit = HeroGroupEditListModel.instance:getQuickEditState()

	if not isQuickEdit and mo then
		local index = HeroGroupEditListModel.instance:getSelectAssistHeroIndex(mo)
		local isAssistInPlane = TowerComposeModel.instance:getAssistIsInPlane(mo.heroUid)
		local curPlaneId = Mathf.Ceil(self._singleGroupMOId / 4)

		if index and isAssistInPlane == curPlaneId then
			HeroGroupEditListModel.instance:selectCell(index, true)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, mo.heroMO)
		end
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnAssistPickOver, mo)
end

function TowerComposeHeroGroupEditFightAssistBtn:_btnassistOnClick2()
	if self:checkPlaneLock(2) then
		GameFacade.showToast(ToastEnum.TowerComposeRecordRoleLock)

		return
	end

	local params = {
		planeId = 2
	}
	local _, assistMo = HeroGroupHandler.getAssistMo(self.fightParam.episodeId, true, {
		planeId = 2
	})

	if assistMo then
		self:onReleaseAssist(params)

		return
	end

	if not self._episdoeType then
		return
	end

	if self.isInCD then
		GameFacade.showToast(ToastEnum.Season123RefreshAssistInCD)

		return
	end

	local assistType = PickAssistEnum.Type.TowerCompose2

	PickAssistController.instance:openPickAssistView(assistType, self._episdoeActId, nil, self._pickOverCallBack2, self, true, nil, nil, {
		episodeId = DungeonModel.instance.curSendEpisodeId
	})
end

function TowerComposeHeroGroupEditFightAssistBtn:_pickOverCallBack2(mo)
	if not mo then
		return
	end

	self:setAssistMo(mo, {
		planeId = 2
	})
	self:refreshAssistBtn()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)

	local isQuickEdit = HeroGroupEditListModel.instance:getQuickEditState()

	if not isQuickEdit and mo then
		local index = HeroGroupEditListModel.instance:getSelectAssistHeroIndex(mo)
		local isAssistInPlane = TowerComposeModel.instance:getAssistIsInPlane(mo.heroUid)
		local curPlaneId = Mathf.Ceil(self._singleGroupMOId / 4)

		if index and isAssistInPlane == curPlaneId then
			HeroGroupEditListModel.instance:selectCell(index, true)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, mo.heroMO)
		end
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnAssistPickOver, mo)
end

function TowerComposeHeroGroupEditFightAssistBtn:setAssistMo(mo, params)
	if not mo then
		return
	end

	local heroList = HeroSingleGroupModel.instance:getList()

	heroList = heroList or {}

	local planeId = self:getAssistPlaneId(params)
	local startIndex, endIndex = 1, #heroList
	local index

	for i = startIndex, endIndex do
		local _mo = heroList[i]

		if _mo then
			::label_10_0::

			local canSelect = TowerComposeHeroGroupModel.instance:checkCanSelectAssistHero(_mo.heroUid, i, i)

			if canSelect then
				if _mo.heroUid == "0" then
					index = index or i
				else
					local heroMo = HeroModel.instance:getById(_mo.heroUid)

					if heroMo and heroMo.heroId == mo.heroId then
						HeroSingleGroupModel.instance:remove(_mo.heroUid)
						HeroGroupModel.instance:saveCurGroupData()

						index = i
					end
				end
			end
		end
	end

	TowerComposeModel.instance:setEditorAssistMo(mo, {
		planeId = planeId
	})
	self:refreshAssistBtn()
end

function TowerComposeHeroGroupEditFightAssistBtn:getAssistPlaneId(params)
	if params and params.planeId then
		return params.planeId
	end

	return self.fightParam.plane == 1 and 1 or 0
end

function TowerComposeHeroGroupEditFightAssistBtn:onReleaseAssist(params)
	local isSelectAssist = HeroGroupEditListModel.instance:isCurSelectAssistHero()

	HeroGroupModel.instance:clearCurAssist(true, params)
	self:refreshAssistBtn()

	if isSelectAssist then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	GameFacade.showToast(ToastEnum.CancelAssist)
end

function TowerComposeHeroGroupEditFightAssistBtn:_editableInitView()
	TaskDispatcher.cancelTask(self.refreshCD, self)
	TaskDispatcher.runRepeat(self.refreshCD, self, 0.01)
end

function TowerComposeHeroGroupEditFightAssistBtn:onUpdateParam()
	return
end

function TowerComposeHeroGroupEditFightAssistBtn:onOpen()
	self._singleGroupMOId = self.viewParam.singleGroupMOId
	self.fightParam = TowerComposeModel.instance:getRecordFightParam()

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self.fightParam.episodeId)

	self._episdoeType = episodeConfig.type

	local chapterCo = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	self._episdoeActId = chapterCo.actId

	self:refreshAssistBtn()
end

function TowerComposeHeroGroupEditFightAssistBtn:refreshAssistBtn()
	if self.fightParam.plane == 2 then
		gohelper.setActive(self._btnassist.gameObject, false)
		gohelper.setActive(self._btnassist1.gameObject, true)
		gohelper.setActive(self._btnassist2.gameObject, true)

		local _, assistMo1 = HeroGroupHandler.getAssistMo(self.fightParam.episodeId, false, {
			planeId = 1
		})
		local editorAssistMo1 = HeroGroupModel.instance:getEditorAssistMo({
			planeId = 1
		})

		gohelper.setActive(self._goassist1, assistMo1 == nil and editorAssistMo1 == nil)
		gohelper.setActive(self._gorelease1, assistMo1 ~= nil or editorAssistMo1 ~= nil)

		local _, assistMo2 = HeroGroupHandler.getAssistMo(self.fightParam.episodeId, false, {
			planeId = 2
		})
		local editorAssistMo2 = HeroGroupModel.instance:getEditorAssistMo({
			planeId = 2
		})

		gohelper.setActive(self._goassist2, assistMo2 == nil and editorAssistMo2 == nil)
		gohelper.setActive(self._gorelease2, assistMo2 ~= nil or editorAssistMo2 ~= nil)
		gohelper.setActive(self._golock1, self:checkPlaneLock(1))
		gohelper.setActive(self._golock2, self:checkPlaneLock(2))
	else
		gohelper.setActive(self._btnassist.gameObject, true)
		gohelper.setActive(self._btnassist1.gameObject, false)
		gohelper.setActive(self._btnassist2.gameObject, false)
		gohelper.setActive(self._golock1, false)
		gohelper.setActive(self._golock2, false)

		if self.fightParam.plane == 1 then
			local _, assistMo1 = HeroGroupModel.instance:getAssistMo({
				planeId = 1
			})
			local editorAssistMo1 = HeroGroupModel.instance:getEditorAssistMo({
				planeId = 1
			})

			gohelper.setActive(self._goassist, assistMo1 == nil and editorAssistMo1 == nil)
			gohelper.setActive(self._gorelease, assistMo1 ~= nil or editorAssistMo1 ~= nil)
		elseif self.fightParam.plane == 0 then
			local _, assistMo = HeroGroupModel.instance:getAssistMo({
				planeId = 0
			})
			local editorAssistMo = HeroGroupModel.instance:getEditorAssistMo({
				planeId = 0
			})

			gohelper.setActive(self._goassist, assistMo == nil and editorAssistMo == nil)
			gohelper.setActive(self._gorelease, assistMo ~= nil or editorAssistMo ~= nil)
		end
	end
end

function TowerComposeHeroGroupEditFightAssistBtn:checkPlaneLock(planeId)
	local themeId = self.fightParam.themeId
	local themeMo = TowerComposeModel.instance:getThemeMo(themeId)
	local curBossMo = themeMo:getCurBossMo()

	if curBossMo and curBossMo.lock then
		local planeMo = themeMo:getPlaneMo(planeId)
		local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(themeId, planeId)

		return isPlaneLock and planeMo.hasFight
	end

	return false
end

function TowerComposeHeroGroupEditFightAssistBtn:refreshCD()
	local cdRate = PickAssistController.instance:getRefreshCDRate()

	self.isInCD = cdRate > 0
	self._imageAssistCD1.fillAmount = cdRate
	self._imageAssistCD2.fillAmount = cdRate

	gohelper.setActive(self._goassistCD1, self.isInCD)
	gohelper.setActive(self._goassistCD2, self.isInCD)
end

function TowerComposeHeroGroupEditFightAssistBtn:onClose()
	return
end

function TowerComposeHeroGroupEditFightAssistBtn:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshCD, self)
end

return TowerComposeHeroGroupEditFightAssistBtn
