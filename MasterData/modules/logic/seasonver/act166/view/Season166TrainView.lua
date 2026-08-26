-- chunkname: @modules/logic/seasonver/act166/view/Season166TrainView.lua

module("modules.logic.seasonver.act166.view.Season166TrainView", package.seeall)

local Season166TrainView = class("Season166TrainView", BaseView)

function Season166TrainView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txtcurIndex = gohelper.findChildText(self.viewGO, "right/title/#txt_curIndex")
	self._txttotalIndex = gohelper.findChildText(self.viewGO, "right/title/#txt_totalIndex")
	self._txttitle = gohelper.findChildText(self.viewGO, "right/title/#txt_title")
	self._txttitleEn = gohelper.findChildText(self.viewGO, "right/title/#txt_titleen")
	self._btnleftArrow = gohelper.findChildButtonWithAudio(self.viewGO, "right/title/#btn_leftArrow")
	self._btnrightArrow = gohelper.findChildButtonWithAudio(self.viewGO, "right/title/#btn_rightArrow")
	self._txtenemyinfo = gohelper.findChildText(self.viewGO, "right/episodeInfo/enemyInfo/#txt_enemyinfo")
	self._txtepisodeInfo = gohelper.findChildText(self.viewGO, "right/episodeInfo/#txt_episodeInfo")
	self._gorewardContent = gohelper.findChild(self.viewGO, "right/reward/#go_rewardContent")
	self._gorewardItem = gohelper.findChild(self.viewGO, "right/reward/#go_rewardContent/#go_rewardItem")
	self._btnfight = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_fight")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166TrainView:addEvents()
	self._btnleftArrow:AddClickListener(self._btnleftArrowOnClick, self)
	self._btnrightArrow:AddClickListener(self._btnrightArrowOnClick, self)
	self._btnfight:AddClickListener(self._btnfightOnClick, self)
end

function Season166TrainView:removeEvents()
	self._btnleftArrow:RemoveClickListener()
	self._btnrightArrow:RemoveClickListener()
	self._btnfight:RemoveClickListener()
end

function Season166TrainView:_btnleftArrowOnClick()
	self.trainId = Mathf.Max(self.trainId - 1, 1)

	self:refreshUI()
end

function Season166TrainView:_btnrightArrowOnClick()
	local trainId = Mathf.Min(self.trainId + 1, #self.trainConfigList)

	if not self.unlockTrainMap[trainId] then
		GameFacade.showToast(ToastEnum.Season166TrainLock)

		return
	end

	self.trainId = trainId

	self:refreshUI()
end

function Season166TrainView:_btnfightOnClick()
	Season166TrainController.instance:enterTrainFightScene()
end

function Season166TrainView:_editableInitView()
	self.rightArrowCanvasGroup = self._btnrightArrow.gameObject:GetComponent(gohelper.Type_CanvasGroup)
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self.isClickClose = false
end

function Season166TrainView:onUpdateParam()
	return
end

function Season166TrainView:onOpen()
	self.actId = self.viewParam.actId
	self.trainId = self.viewParam.trainId
	self.config = self.viewParam.config
	self.trainConfigList = Season166Config.instance:getSeasonTrainCos(self.actId)
	self.unlockTrainMap = Season166TrainModel.instance:getUnlockTrainInfoMap(self.actId)

	Season166Controller.instance:dispatchEvent(Season166Event.OpenTrainView, {
		isEnter = true
	})
	self:refreshUI()
	self.viewContainer:setOverrideCloseClick(self.setCloseOverrideFunc, self)
end

function Season166TrainView:refreshUI()
	self:refreshInfo()
	self:refreshReward()
	Season166Controller.instance:dispatchEvent(Season166Event.TrainViewChangeTrain, self.trainId)
end

function Season166TrainView:refreshInfo()
	self.config = self.trainConfigList[self.trainId]
	self._txtcurIndex.text = string.format("%02d", self.trainId)
	self._txttotalIndex.text = string.format("%02d", #self.trainConfigList)
	self._txttitle.text = self.config.name
	self._txttitleEn.text = self.config.nameEn
	self._txtepisodeInfo.text = self.config.desc
	self._txtenemyinfo.text = HeroConfig.instance:getLevelDisplayVariant(self.config.level)

	Season166TrainModel.instance:initTrainData(self.actId, self.trainId)
	gohelper.setActive(self._btnleftArrow.gameObject, self.trainId > 1)
	gohelper.setActive(self._btnrightArrow.gameObject, self.trainId < #self.trainConfigList)

	local nextTrainId = Mathf.Min(self.trainId + 1, #self.trainConfigList)

	self.rightArrowCanvasGroup.alpha = self.unlockTrainMap[nextTrainId] and 1 or 0.5
end

function Season166TrainView:refreshReward()
	local rewardList = string.split(self.config.firstBonus, "|")

	gohelper.CreateObjList(self, self.rewardItemShow, rewardList, self._gorewardContent, self._gorewardItem)
end

function Season166TrainView:rewardItemShow(obj, data, index)
	local itemPos = gohelper.findChild(obj, "go_itempos")
	local goHasGet = gohelper.findChild(obj, "go_hasget")
	local item = IconMgr.instance:getCommonPropItemIcon(itemPos)
	local itemCo = string.splitToNumber(data, "#")

	item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
	item:setHideLvAndBreakFlag(true)
	item:hideEquipLvAndBreak(true)
	item:setCountFontSize(51)

	local isFinish = Season166TrainModel.instance:checkIsFinish(self.actId, self.trainId)

	gohelper.setActive(goHasGet, isFinish)
end

function Season166TrainView:setCloseOverrideFunc()
	if not self.isClickClose then
		self._animPlayer:Play("out", self.closeThis, self)
		Season166Controller.instance:dispatchEvent(Season166Event.CloseTrainView, {
			isEnter = false
		})
		Season166Controller.instance:dispatchEvent(Season166Event.TrainViewChangeTrain)

		self.isClickClose = true
	end
end

function Season166TrainView:onClose()
	return
end

function Season166TrainView:onDestroyView()
	return
end

return Season166TrainView
