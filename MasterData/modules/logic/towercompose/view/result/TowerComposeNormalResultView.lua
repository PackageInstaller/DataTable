-- chunkname: @modules/logic/towercompose/view/result/TowerComposeNormalResultView.lua

module("modules.logic.towercompose.view.result.TowerComposeNormalResultView", package.seeall)

local TowerComposeNormalResultView = class("TowerComposeNormalResultView", BaseView)

function TowerComposeNormalResultView:onInitView()
	self._goresult = gohelper.findChild(self.viewGO, "go_Result")
	self._gobg = gohelper.findChild(self.viewGO, "go_Result/root/#go_bg")
	self._txtTower = gohelper.findChildText(self.viewGO, "go_Result/root/left/PermanentDetail/image_NameBG/txtTower")
	self._goRewards = gohelper.findChild(self.viewGO, "go_Result/root/left/goReward")
	self._goReward = gohelper.findChild(self.viewGO, "go_Result/root/left/goReward/scroll_reward/Viewport/#go_rewards")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "go_Result/#go_herogroupcontain/#btn_close")
	self._btnData = gohelper.findChildButtonWithAudio(self.viewGO, "go_Result/#go_herogroupcontain/#btn_Data")
	self._gonormalPlane = gohelper.findChild(self.viewGO, "go_Result/#go_herogroupcontain/#go_normalPlane")
	self._goentry = gohelper.findChild(self.viewGO, "go_Entry")
	self._goentrylimit = gohelper.findChild(self.viewGO, "go_Entry/#go_Limit")
	self._txtscore = gohelper.findChildTextMesh(self.viewGO, "go_Entry/#go_Limit/image_ScoreBG/#txt_Score")
	self._simagestageentry = gohelper.findChildSingleImage(self.viewGO, "go_Entry/#go_Limit/imgStage")
	self._simagewaveentry = gohelper.findChildSingleImage(self.viewGO, "go_Entry/#go_Limit/wavebg")
	self._goentrypermanent = gohelper.findChild(self.viewGO, "go_Entry/#go_Permanent")
	self._imgStage = gohelper.findChildImage(self.viewGO, "go_Entry/#go_Permanent/imgStage")
	self._goFinish = gohelper.findChild(self.viewGO, "goFinish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeNormalResultView:addEvents()
	self._btnClose:AddClickListener(self._onCloseClick, self)
	self._btnData:AddClickListener(self._onbtnDataClick, self)
end

function TowerComposeNormalResultView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnData:RemoveClickListener()
end

function TowerComposeNormalResultView:_onCloseClick()
	if not self._canClick then
		if self._popupFlow then
			local workList = self._popupFlow:getWorkList()
			local curWork = workList[self._popupFlow._curIndex]

			if curWork then
				curWork:onDone(true)
			end
		end

		return
	end

	self:closeThis()
end

function TowerComposeNormalResultView:_onbtnDataClick()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function TowerComposeNormalResultView:_editableInitView()
	self:_addSelfEvents()
end

function TowerComposeNormalResultView:_addSelfEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function TowerComposeNormalResultView:_removeSelfEvents()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function TowerComposeNormalResultView:onUpdateParam()
	return
end

function TowerComposeNormalResultView:onOpen()
	self.fightParam = TowerComposeModel.instance:getRecordFightParam()
	self._themeId, self._layerId = self.fightParam.themeId, self.fightParam.layerId
	self._towerEpisodeCo = TowerComposeConfig.instance:getEpisodeConfig(self._themeId, self._layerId)
	self._slotMapCo = TowerComposeConfig.instance:getModSlotNumMap(self._themeId)

	self:_refreshUI()
end

function TowerComposeNormalResultView:_refreshUI()
	self:_refreshResult()

	local waitNamePlateToastList = AchievementToastModel.instance:getWaitNamePlateToastList()

	if not waitNamePlateToastList or #waitNamePlateToastList == 0 then
		self:_startFlow()
	end
end

function TowerComposeNormalResultView:_refreshResult()
	local towerEpisodeCo = TowerComposeConfig.instance:getEpisodeConfig(self._themeId, self._layerId)

	self._txtTower.text = towerEpisodeCo.name

	self:_refreshHeroGroup()
	self:_refreshRewards(self._goReward, self._goRewards)
end

function TowerComposeNormalResultView:_refreshRewards(goReward, goRewards)
	if self._rewardItems == nil then
		self._rewardItems = {}
	end

	local dataList = FightResultModel.instance:getFirstMaterialDataList() or {}

	for i = 1, math.max(#self._rewardItems, #dataList) do
		local item = self._rewardItems[i]
		local data = dataList[i]

		if not item then
			item = IconMgr.instance:getCommonPropItemIcon(goReward)
			self._rewardItems[i] = item
		end

		gohelper.setActive(item.go, data ~= nil)

		if data then
			item:setMOValue(data.materilType, data.materilId, data.quantity)
			item:setScale(0.7)
			item:setCountTxtSize(51)
		end
	end

	gohelper.setActive(goRewards, #dataList ~= 0)
end

function TowerComposeNormalResultView:_startFlow()
	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end

	self._popupFlow = FlowSequence.New()

	self._popupFlow:addWork(TowerBossResultShowFinishWork.New(self._goFinish, AudioEnum.Tower.play_ui_fight_explore))
	self._popupFlow:addWork(TowerBossResultShowFinishWork.New(self._goentry, AudioEnum.Tower.play_ui_fight_ui_appear))
	self._popupFlow:addWork(TowerBossResultShowResultWork.New(self._goresult, AudioEnum.Tower.play_ui_fight_card_flip, self.onResultShowCallBack, self))
	self._popupFlow:registerDoneListener(self._onAllFinish, self)
	self._popupFlow:start()
end

function TowerComposeNormalResultView:onResultShowCallBack()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_complete)
end

function TowerComposeNormalResultView:_refreshHeroGroup()
	local planeId = self._towerEpisodeCo.plane

	if not self._slotItems then
		self._slotItems = TowerComposeResultSlotItem.New()

		self._slotItems:init(self._gonormalPlane, self._themeId, planeId)
	end

	self._slotItems:refresh()
end

function TowerComposeNormalResultView:onClose()
	FightController.onResultViewClose()
end

function TowerComposeNormalResultView:_onAllFinish()
	self._canClick = true
end

function TowerComposeNormalResultView:_onCloseViewFinish(viewName)
	if viewName == ViewName.AchievementNamePlateUnlockView then
		self:_startFlow()
	end
end

function TowerComposeNormalResultView:onDestroyView()
	self:_removeSelfEvents()

	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end

	if self._slotItems then
		self._slotItems:destroy()

		self._slotItems = nil
	end
end

return TowerComposeNormalResultView
