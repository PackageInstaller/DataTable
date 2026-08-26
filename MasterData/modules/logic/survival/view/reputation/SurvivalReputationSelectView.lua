-- chunkname: @modules/logic/survival/view/reputation/SurvivalReputationSelectView.lua

module("modules.logic.survival.view.reputation.SurvivalReputationSelectView", package.seeall)

local SurvivalReputationSelectView = class("SurvivalReputationSelectView", BaseView)

function SurvivalReputationSelectView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._scrollbuild = gohelper.findChildScrollRect(self.viewGO, "build/#scroll_build")
	self._gobuildcontent = gohelper.findChild(self.viewGO, "build/#scroll_build/Viewport/#go_build_content")
	self._txtscore = gohelper.findChildText(self.viewGO, "Btn/score/#txt_score")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "Btn/#btn_confirm")
	self._btnconfirmgrey = gohelper.findChild(self.viewGO, "Btn/#btn_confirm_grey")
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "item/#scroll_item")
	self.txt_tips = gohelper.findChildTextMesh(self.viewGO, "titlebg/txt_tips")
	self.customItems = {}

	self:createItemScroll()

	self._sequence = FlowSequence.New()
end

function SurvivalReputationSelectView:createItemScroll()
	local scrollParam = SimpleListParam.New()

	scrollParam.cellClass = SurvivalReputationSelectBagItem
	scrollParam.lineCount = 1

	local res = self.viewContainer:getSetting().otherRes.survivalreputationselectbagitem

	self.simpleListComp = GameFacade.createSimpleListComp(self._scrollitem.gameObject, scrollParam, res, self.viewContainer)
end

function SurvivalReputationSelectView:addEvents()
	self.addClickCb(self, self._btnconfirm, self.onClickBtnConfirm, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnReceiveSurvivalReputationExpReply, self.onReceiveSurvivalReputationExpReply, self)
end

function SurvivalReputationSelectView:onOpen()
	self.isReceiveMsg = nil

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	self.items = weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):getReputationItem()
	self.score = SurvivalReputationModel.instance:getSelectViewReputationAdd(self.items)
	self._txtscore.text = self.score

	self:refreshItemList()
	self:refreshBuildList()
	self:refreshBtnConfirm()
	self:refreshTextTip()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideSurvivalReputationSelectViewOpen)
end

function SurvivalReputationSelectView:onClose()
	return
end

function SurvivalReputationSelectView:onDestroyView()
	if self._sequence and self._sequence.status == WorkStatus.Running then
		self._sequence:stop()
	end
end

function SurvivalReputationSelectView:refreshItemList()
	self.simpleListComp:setData(self.items)
end

function SurvivalReputationSelectView:refreshBtnConfirm()
	gohelper.setActive(self._btnconfirm.gameObject, self.curSelect ~= nil)
	gohelper.setActive(self._btnconfirmgrey, self.curSelect == nil)
end

function SurvivalReputationSelectView:onClickBtnConfirm()
	if self.isReceiveMsg then
		return
	end

	local reputationId = self.customItems[self.curSelect].reputationId

	SurvivalWeekRpc.instance:sendSurvivalReputationExpRequest(reputationId)
end

function SurvivalReputationSelectView:onReceiveSurvivalReputationExpReply(param)
	self.isReceiveMsg = true

	local msg = param.msg
	local survivalBuilding = msg.building
	local customItem

	for i, v in ipairs(self.customItems) do
		if v.buildingCfgId == survivalBuilding.buildingId then
			customItem = self.customItems[i]
		end
	end

	local flow = FlowSequence.New()

	flow:addWork(FunctionWork.New(self.playItemAnim, self))
	flow:addWork(AnimatorWork.New({
		animName = "uiclose",
		go = self.viewGO
	}))
	flow:addWork(customItem:playUpAnim(survivalBuilding))
	flow:addWork(TimerWork.New(0.5))
	self._sequence:addWork(flow)
	self._sequence:registerDoneListener(self.onAnimalPlayCallBack, self)
	self._sequence:start()
end

function SurvivalReputationSelectView:playItemAnim()
	local items = self.simpleListComp:getItems()

	for i, v in ipairs(items) do
		v:playSearch()
	end
end

function SurvivalReputationSelectView:onAnimalPlayCallBack()
	self:closeThis()
end

function SurvivalReputationSelectView:refreshBuildList()
	local resPath = self.viewContainer:getSetting().otherRes.survivalreputationbuilditem
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local list = weekInfo:getReputationBuilds()
	local customItemAmount = #self.customItems
	local listLength = #list

	for i = 1, listLength do
		local mo = list[i]

		if customItemAmount < i then
			local obj = self:getResInst(resPath, self._gobuildcontent)

			self.customItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SurvivalReputationBuildItem)
		end

		self.customItems[i]:setData({
			score = self.score,
			mo = mo,
			index = i,
			onClickCallBack = self.onClickCallBack,
			onClickContext = self,
			onAnimalPlayCallBack = self.onAnimalPlayCallBack
		})
	end

	for i = listLength + 1, customItemAmount do
		self.customItems[i]:setData(nil)
	end
end

function SurvivalReputationSelectView:onClickCallBack(item)
	if not item.isMaxLevel then
		self:setSelect(item.index)
	end
end

function SurvivalReputationSelectView:setSelect(tarSelect)
	if self.isReceiveMsg then
		return
	end

	local haveChange = (not tarSelect or not self.curSelect or self.curSelect ~= tarSelect) and (not not tarSelect or not not self.curSelect)

	if haveChange then
		if self.curSelect then
			self.customItems[self.curSelect]:setSelect(false)
		end

		self.curSelect = tarSelect

		if self.curSelect then
			self.customItems[self.curSelect]:setSelect(true)
		end
	end

	self:refreshBtnConfirm()
	self:refreshTextTip()
end

function SurvivalReputationSelectView:refreshTextTip()
	if self.curSelect then
		local survivalReputationBuildItem = self.customItems[self.curSelect]

		self.txt_tips.text = survivalReputationBuildItem.buildCfg.desc
	else
		self.txt_tips.text = ""
	end
end

return SurvivalReputationSelectView
