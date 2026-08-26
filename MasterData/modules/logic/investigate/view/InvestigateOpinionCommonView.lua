-- chunkname: @modules/logic/investigate/view/InvestigateOpinionCommonView.lua

module("modules.logic.investigate.view.InvestigateOpinionCommonView", package.seeall)

local InvestigateOpinionCommonView = class("InvestigateOpinionCommonView", BaseView)

function InvestigateOpinionCommonView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "root/view/#simage_fullbg")
	self._simagefullbg2 = gohelper.findChildSingleImage(self.viewGO, "root/view/#simage_fullbg2")
	self._simagefullbg3 = gohelper.findChildSingleImage(self.viewGO, "root/view/#simage_fullbg3")
	self._simagefullbg4 = gohelper.findChildSingleImage(self.viewGO, "root/view/#simage_fullbg3/#simage_fullbg4")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "root/view/#simage_title")
	self._btnleftarrow = gohelper.findChildButtonWithAudio(self.viewGO, "root/view/#simage_title/#btn_leftarrow")
	self._goreddotleft = gohelper.findChild(self.viewGO, "root/view/#simage_title/#btn_leftarrow/#go_reddotleft")
	self._btnrightarrow = gohelper.findChildButtonWithAudio(self.viewGO, "root/view/#simage_title/#btn_rightarrow")
	self._goreddotright = gohelper.findChild(self.viewGO, "root/view/#simage_title/#btn_rightarrow/#go_reddotright")
	self._goprogress = gohelper.findChild(self.viewGO, "root/view/#go_progress")
	self._goprogresitem = gohelper.findChild(self.viewGO, "root/view/#go_progress/#go_progresitem")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "root/view/#scroll_desc")
	self._gocontent = gohelper.findChild(self.viewGO, "root/view/#scroll_desc/viewport/#go_content")
	self._txtroledec = gohelper.findChildText(self.viewGO, "root/view/#scroll_desc/viewport/#go_content/top/roledecbg/#txt_roledec")
	self._txtdec = gohelper.findChildText(self.viewGO, "root/view/#scroll_desc/viewport/#go_content/#txt_dec")
	self._goOpinion = gohelper.findChild(self.viewGO, "root/view/#go_Opinion")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function InvestigateOpinionCommonView:addEvents()
	self._btnleftarrow:AddClickListener(self._btnleftarrowOnClick, self)
	self._btnrightarrow:AddClickListener(self._btnrightarrowOnClick, self)
end

function InvestigateOpinionCommonView:removeEvents()
	self._btnleftarrow:RemoveClickListener()
	self._btnrightarrow:RemoveClickListener()
end

function InvestigateOpinionCommonView:_btnleftarrowOnClick()
	local index, mo = self:_getPrevValue(self._moIndex, self._moList)

	self._moIndex = index

	InvestigateOpinionModel.instance:setInfo(mo, self._moList)
	InvestigateController.instance:dispatchEvent(InvestigateEvent.ChangeArrow)
end

function InvestigateOpinionCommonView:_getPrevValue(index, moList)
	index = index - 1

	if index < 1 then
		index = #moList
	end

	local mo = moList[index]

	return index, mo
end

function InvestigateOpinionCommonView:_getNextValue(index, moList)
	index = index + 1

	if index > #moList then
		index = 1
	end

	local mo = moList[index]

	return index, mo
end

function InvestigateOpinionCommonView:_btnrightarrowOnClick()
	local index, mo = self:_getNextValue(self._moIndex, self._moList)

	self._moIndex = index

	InvestigateOpinionModel.instance:setInfo(mo, self._moList)
	InvestigateController.instance:dispatchEvent(InvestigateEvent.ChangeArrow)
end

function InvestigateOpinionCommonView:_editableInitView()
	self._opinionItemList = self:getUserDataTb_()
	self._progressItemList = self:getUserDataTb_()
	self._descItemList = self:getUserDataTb_()
	self._progressStatus = {}
	self._txtdec.text = ""

	gohelper.setActive(self._txtdec, false)
	gohelper.setActive(self._goOpinion, true)

	self._rootAnimator = self.viewGO:GetComponent("Animator")
	self._goDragTip = gohelper.findChild(self.viewGO, "root/view/#fullbg_glow")
	self._goUnFinishedTip = gohelper.findChild(self.viewGO, "root/view/Bottom/txt_tips")
	self._goFinishedTip = gohelper.findChild(self.viewGO, "root/view/Bottom/img_finished")
	self._redDotCompLeft = RedDotController.instance:addNotEventRedDot(self._goreddotleft, self._isShowLeftRedDot, self)
	self._redDotCompRight = RedDotController.instance:addNotEventRedDot(self._goreddotright, self._isShowRightRedDot, self)

	self.addEventCb(self, InvestigateController.instance, InvestigateEvent.ChangeArrow, self._onChangeArrow, self)
end

function InvestigateOpinionCommonView:_onChangeArrow()
	self._redDotCompLeft:refreshRedDot()
	self._redDotCompRight:refreshRedDot()
end

function InvestigateOpinionCommonView:_isShowLeftRedDot()
	local mo, moList = InvestigateOpinionModel.instance:getInfo()

	if not mo or not moList then
		return false
	end

	local index = tabletool.indexOf(moList, mo)

	if not index then
		return false
	end

	local _, mo = self:_getPrevValue(index, moList)

	return InvestigateController.showSingleInfoRedDot(mo.id)
end

function InvestigateOpinionCommonView:_isShowRightRedDot()
	local mo, moList = InvestigateOpinionModel.instance:getInfo()

	if not mo or not moList then
		return false
	end

	local index = tabletool.indexOf(moList, mo)

	if not index then
		return false
	end

	local _, mo = self:_getNextValue(index, moList)

	return InvestigateController.showSingleInfoRedDot(mo.id)
end

function InvestigateOpinionCommonView:_onLinkedOpinionSuccess(clueId)
	self:_updateProgress()
	self:_checkFinish()

	self._linkedClueId = clueId

	self:_initOpinionDescList(self._opinionList)

	self._linkedClueId = nil
end

function InvestigateOpinionCommonView:onTabSwitchOpen()
	self.addEventCb(self, InvestigateController.instance, InvestigateEvent.LinkedOpinionSuccess, self._onLinkedOpinionSuccess, self)

	local mo, moList = InvestigateOpinionModel.instance:getInfo()

	self:_initInfo(mo, moList)
end

function InvestigateOpinionCommonView:onTabSwitchClose()
	self.removeEventCb(self, InvestigateController.instance, InvestigateEvent.LinkedOpinionSuccess, self._onLinkedOpinionSuccess, self)
end

function InvestigateOpinionCommonView:setInExtendView(isExtend)
	self._isInExtendView = isExtend
end

function InvestigateOpinionCommonView:onOpen()
	return
end

function InvestigateOpinionCommonView:_initInfo(mo, moList)
	self._moList = moList
	self._moIndex = self._moList and tabletool.indexOf(self._moList, mo)
	self._moNum = self._moList and #self._moList

	gohelper.setActive(self._btnleftarrow, self._moIndex ~= nil)
	gohelper.setActive(self._btnrightarrow, self._moIndex ~= nil)
	self:_updateMo(mo)
end

function InvestigateOpinionCommonView:_updateMo(mo)
	self._mo = mo
	self._txtroledec.text = self._mo.desc
	self._opinionList = InvestigateConfig.instance:getInvestigateRelatedClueInfos(self._mo.id)

	self:_initOpinionItems()
	self:_checkFinish()
	self:_initOpinionProgress(self._opinionList)
	self:_initOpinionDescList(self._opinionList)
	self._redDotCompLeft:refreshRedDot()
	self._redDotCompRight:refreshRedDot()
end

function InvestigateOpinionCommonView:_initOpinionItems()
	self._opinionAllDataList = InvestigateConfig.instance:getInvestigateAllClueInfos(self._mo.id)
	self._opinionNum = #self._opinionAllDataList

	local posRoot = gohelper.findChild(self._goOpinion, tostring(self._opinionNum))

	gohelper.setActive(posRoot, true)

	if self._simagefullbg2 then
		local collider2D = self._simagefullbg2.gameObject:GetComponent(typeof(UnityEngine.Collider2D))
		local path = self.viewContainer:getSetting().otherRes[1]

		if self._curitemList then
			for i, v in ipairs(self._curitemList) do
				gohelper.setActive(v.viewGO, false)
			end
		end

		self._curitemList = self._opinionItemList[self._mo.id] or self:getUserDataTb_()
		self._opinionItemList[self._mo.id] = self._curitemList

		for i = 1, self._opinionNum do
			local data = self._opinionAllDataList[i]

			if not data then
				break
			end

			local item = self._curitemList[i]

			if not item then
				local go = gohelper.findChild(self._goOpinion, string.format("%s/opinion%s", self._opinionNum, i))
				local nodeEndGo = gohelper.findChild(self._goOpinion, string.format("%s/node%s", self._opinionNum, i))
				local itemGo = self:getResInst(path, go)

				item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, InvestigateOpinionItem)

				item:setIndex(i, self._opinionNum)
				item:setInExtendView(self._isInExtendView)

				if not nodeEndGo then
					logError(string.format("_initOpinionItems nodeEndGo is nil path:%s/node%s", self._opinionNum, i))
				end

				item:onUpdateMO(data, self._simagefullbg2, go, nodeEndGo, self._goDragTip)

				self._curitemList[i] = item
			end

			gohelper.setActive(item.viewGO, true)
		end
	end
end

function InvestigateOpinionCommonView:_initOpinionProgress(data_list)
	gohelper.CreateObjList(self, self._onItemShow, data_list, self._goprogress, self._goprogresitem)
	self:_updateProgress()
end

function InvestigateOpinionCommonView:_onItemShow(obj, data, index)
	local t = self:getUserDataTb_()

	self._progressItemList[index] = t
	t.unfinished = gohelper.findChild(obj, "unfinished")
	t.finished = gohelper.findChild(obj, "finished")
	t.light = gohelper.findChild(obj, "light")
	t.config = data
end

function InvestigateOpinionCommonView:_updateProgress()
	for i, v in ipairs(self._progressItemList) do
		local isFinished = InvestigateOpinionModel.instance:getLinkedStatus(v.config.id)

		gohelper.setActive(v.unfinished, not isFinished)
		gohelper.setActive(v.finished, isFinished)

		if not self._isInExtendView then
			local oldStatus = self._progressStatus[i]

			self._progressStatus[i] = isFinished

			if oldStatus == false and isFinished then
				gohelper.setActive(v.light, true)
			end
		end
	end
end

function InvestigateOpinionCommonView:_checkFinish()
	local isAllFinished = true

	for i, v in ipairs(self._opinionList) do
		local isFinished = InvestigateOpinionModel.instance:getLinkedStatus(v.id)

		if isFinished == false then
			isAllFinished = false

			break
		end
	end

	gohelper.setActive(self._goFinishedTip, isAllFinished)
	gohelper.setActive(self._goUnFinishedTip, not isAllFinished)
end

function InvestigateOpinionCommonView:_initOpinionDescList(data_list)
	local num = #data_list

	for i, v in ipairs(self._descItemList) do
		gohelper.setActive(v, i <= num)
	end

	for i, data in ipairs(data_list) do
		if not self._descItemList[i] then
			local itemGo = gohelper.cloneInPlace(self._txtdec.gameObject)

			self._descItemList[i] = itemGo

			gohelper.setActive(itemGo, true)

			local isLinked = InvestigateOpinionModel.instance:getLinkedStatus(data.id)
			local txt = gohelper.findChildTextMesh(itemGo, "")
			local line = gohelper.findChild(itemGo, "line")

			txt.text = data.relatedDesc

			local color = txt.color

			color.a = isLinked and 1 or 0
			txt.color = color

			gohelper.setActive(line, isLinked)

			if not self._isInExtendView then
				local animator = SLFramework.AnimatorPlayer.Get(itemGo)

				if animator and data.id == self._linkedClueId then
					animator:Play("open", self._openAnimDone, self)

					if num > 2 then
						self._scrolldesc.verticalNormalizedPosition = i > 2 and 0 or 1
					end

					AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_molu_jlbn_level_unlock)
				end
			end
		end
	end
end

function InvestigateOpinionCommonView:_openAnimDone()
	return
end

function InvestigateOpinionCommonView:onClose()
	self._rootAnimator:Play("close", 0, 0)
end

function InvestigateOpinionCommonView:onDestroyView()
	return
end

return InvestigateOpinionCommonView
