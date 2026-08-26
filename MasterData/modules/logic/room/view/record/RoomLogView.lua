-- chunkname: @modules/logic/room/view/record/RoomLogView.lua

module("modules.logic.room.view.record.RoomLogView", package.seeall)

local RoomLogView = class("RoomLogView", BaseView)

function RoomLogView:onInitView()
	self._btnbook = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_book")
	self._gohandbookreddot = gohelper.findChild(self.viewGO, "root/#btn_book/#go_handbookreddot")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_task")
	self._gotaskreddot = gohelper.findChild(self.viewGO, "root/#btn_task/#go_taskreddot")
	self._txtleftpages = gohelper.findChildText(self.viewGO, "root/#txt_leftpages")
	self._txtrightpages = gohelper.findChildText(self.viewGO, "root/#txt_rightpages")
	self._btnback = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_back")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_next")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_reward")
	self._gobookContent = gohelper.findChild(self.viewGO, "root/content")
	self._gobookItem = gohelper.findChild(self.viewGO, "root/content/bookitem")
	self._gopool = gohelper.findChild(self.viewGO, "pool")
	self._goleftempty = gohelper.findChild(self.viewGO, "root/#go_leftempty")
	self._gorightempty = gohelper.findChild(self.viewGO, "root/#go_rightempty")
	self._gorewardreddot = gohelper.findChild(self.viewGO, "root/#btn_reward/#go_rewardreddot")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._leftContentHeight = 740
	self._rightContentHeight = 925.7935
	self._singleTextHeight = 37.1
	self._itemspace = 40
	self._contentHeight = 0
	self._isLeftFull = false
	self._isRightFull = false
	self._itempool = {}
	self._itemList = {}
	self._leftItemList = {}
	self._rightItemList = {}
	self._moIndex = 1
	self._pageToMo = {}
	self._curCreateBookItem = nil
	self._bookItemTab = {}
	self._bookPage = 1

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomLogView:addEvents()
	self._btnbook:AddClickListener(self._btnbookOnClick, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self.addEventCb(self, RoomTradeController.instance, RoomTradeEvent.OnGetTradeTaskExtraBonusReply, self.refreshBtn, self)
end

function RoomLogView:removeEvents()
	self._btnbook:RemoveClickListener()
	self._btntask:RemoveClickListener()
	self._btnback:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	self.removeEventCb(self, RoomTradeController.instance, RoomTradeEvent.OnGetTradeTaskExtraBonusReply, self.refreshBtn, self)
end

function RoomLogView:_btnbookOnClick()
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.Log2HandBook,
		view = RoomRecordEnum.View.HandBook
	})
end

function RoomLogView:_btntaskOnClick()
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.Log2Task,
		view = RoomRecordEnum.View.Task
	})
end

function RoomLogView:_btnbackOnClick()
	self._bookPage = self._bookPage - 1

	self._animator:Play("switch", 0, 0)
	self:refreshUI()
end

function RoomLogView:_btnrewardOnClick()
	RoomRpc.instance:sendGetTradeTaskExtraBonusRequest()
end

function RoomLogView:refreshBtn()
	local canGetReward = RoomTradeTaskModel.instance:getCanGetExtraBonus()

	gohelper.setActive(self._btnreward.gameObject, canGetReward)
end

function RoomLogView:_btnnextOnClick()
	self._bookPage = self._bookPage + 1

	if self._moIndex ~= #self._molist then
		self._moIndex = self._moIndex + 1
	end

	self._animator:Play("switch", 0, 0)
	self:refreshUI()
end

function RoomLogView:_editableInitView()
	return
end

function RoomLogView:onUpdateParam()
	return
end

function RoomLogView:onOpen()
	self._molist = RoomLogModel.instance:getInfos()

	local isEmpty = not self._molist or #self._molist == 0

	gohelper.setActive(self._gobookContent, not isEmpty)
	gohelper.setActive(self._goleftempty, isEmpty)
	gohelper.setActive(self._gorightempty, isEmpty)

	if not isEmpty then
		self:updateView()
		self:refreshBtn()
	end

	RedDotController.instance:addRedDot(self._gotaskreddot, RedDotEnum.DotNode.TradeTask)
	RedDotController.instance:addRedDot(self._gorewardreddot, RedDotEnum.DotNode.StrikerReward)
	RedDotController.instance:addRedDot(self._gohandbookreddot, RedDotEnum.DotNode.CritterHandBook)
end

function RoomLogView:updateView()
	gohelper.setActive(self._goleftempty, false)
	gohelper.setActive(self._gorightempty, false)

	local bookItem = self:createBookItem()

	if not bookItem.isFull then
		local mo = self._molist[self._moIndex]

		self:buildLogItem(mo, self._moIndex)

		if not self._rightItemList[bookItem.page] then
			gohelper.setActive(bookItem.goempty, true)
		end
	end

	for index, bookItem in ipairs(self._bookItemTab) do
		gohelper.setActive(bookItem.go, bookItem.page == self._bookPage)
	end

	if self._bookPage == 1 then
		gohelper.setActive(self._btnback.gameObject, false)

		if self._moIndex ~= #self._molist then
			gohelper.setActive(self._btnnext.gameObject, true)
		end
	else
		gohelper.setActive(self._btnback.gameObject, true)
	end

	if self._bookPage ~= #self._bookItemTab then
		gohelper.setActive(self._btnnext.gameObject, true)
	elseif self._moIndex == #self._molist then
		gohelper.setActive(self._btnnext.gameObject, false)
	end

	self._txtleftpages.text = self._bookPage * 2 - 1
	self._txtrightpages.text = self._bookPage * 2
end

function RoomLogView:createBookItem()
	local bookItem = self._bookItemTab[self._bookPage]

	if not bookItem then
		bookItem = self:getUserDataTb_()
		bookItem.page = self._bookPage
		bookItem.go = gohelper.cloneInPlace(self._gobookItem, "bookItem" .. self._bookPage)
		bookItem.goLeft = gohelper.findChild(bookItem.go, "left/content")
		bookItem.goRight = gohelper.findChild(bookItem.go, "right/content")
		bookItem.goempty = gohelper.findChild(bookItem.go, "#go_empty")

		gohelper.setActive(bookItem.go, true)

		self._bookItemTab[self._bookPage] = bookItem
		self._curCreateBookItem = bookItem
	end

	return bookItem
end

function RoomLogView:createLogItem()
	local mo = self._molist[self._moIndex]

	if mo then
		self:buildLogItem(mo, self._moIndex)
	end
end

function RoomLogView:checkContinue()
	if self._curCreateBookItem.isFull then
		return false
	end

	if self._isLeftFull and self._isRightFull then
		return false
	end

	local moCount = tabletool.len(self._molist)

	if moCount <= self._moIndex then
		return false
	end

	return true
end

function RoomLogView:buildLogItem(mo, index)
	local itemObj = self:createOrGetItem()

	itemObj.mo = mo
	itemObj.index = index
	self.localContentHeight = 0

	if mo.type == RoomRecordEnum.LogType.Normal then
		itemObj = self:buildNoramlItem(itemObj, mo, index)
	elseif mo.type == RoomRecordEnum.LogType.Speical then
		itemObj = self:buildSpeicalItem(itemObj, mo, index)
	elseif mo.type == RoomRecordEnum.LogType.Custom then
		itemObj = self:buildCustomItem(itemObj, mo, index)
	elseif mo.type == RoomRecordEnum.LogType.Time then
		itemObj = self:buildTimeItem(itemObj, mo, index)
	end

	if itemObj then
		self:setParent(itemObj)
		self:checkSingleItemHeightIsFull()
	end

	if self:checkContinue() then
		self._moIndex = self._moIndex + 1

		self:createLogItem()
	else
		self._curCreateBookItem.isFull = true
	end
end

function RoomLogView:buildNoramlItem(itemObj, mo, index)
	local gotype = self:handleType(itemObj, mo)

	if gotype then
		local gotime = gohelper.findChild(gotype, "timebg")
		local txttime = gohelper.findChildText(gotype, "timebg/#txt_time")
		local goIcon = gohelper.findChild(gotype, "icon")

		gohelper.setActive(gotime, not mo.isclone)
		gohelper.setActive(goIcon, not mo.isclone)

		txttime.text = mo.timestr

		local gocontent = gohelper.findChild(gotype, "#scroll_details/Viewport/Content")
		local cscontent = gocontent:GetComponent(gohelper.Type_VerticalLayoutGroup)

		itemObj.cscontent = cscontent

		local logitem = gohelper.findChild(gotype, "#scroll_details/Viewport/Content/logitem")

		if mo.content then
			gohelper.setActive(logitem, true)

			local content = mo.content
			local txt = gohelper.findChildText(logitem, "#txt_log")
			local goicon = gohelper.findChild(logitem, "icon")

			gohelper.setActive(goicon, not mo.isclone)

			txt.text = content

			ZProj.UGUIHelper.RebuildLayout(gocontent.transform)
			self:checkSingleItemHeightIsFull(true)

			local canshow = self:checkAndHandleOverText(mo, itemObj.index, nil, cscontent, false, txt)

			if canshow then
				ZProj.UGUIHelper.RebuildLayout(gocontent.transform)
			else
				self:resetFunc(itemObj)
				gohelper.destroy(itemObj.go)

				itemObj = nil

				if not self._isLeftFull then
					self._isLeftFull = true
				else
					self._isRightFull = true
				end

				return false
			end
		end

		itemObj.preferredHeight = cscontent.preferredHeight
	end

	return itemObj
end

function RoomLogView:buildSpeicalItem(itemObj, mo, index)
	local gotype = self:handleType(itemObj, mo)

	if gotype then
		local gotime = gohelper.findChild(gotype, "timebg")
		local txttime = gohelper.findChildText(gotype, "timebg/#txt_time")
		local goIcon = gohelper.findChild(gotype, "icon")

		txttime.text = mo.timestr

		gohelper.setActive(gotime, not mo.isclone)
		gohelper.setActive(goIcon, not mo.isclone)

		local cscontent = itemObj.go:GetComponent(gohelper.Type_VerticalLayoutGroup)

		itemObj.cscontent = cscontent

		local logitem = gohelper.findChild(gotype, "#scroll_details/Viewport/Content/logitem")

		if mo.logConfigList and #mo.logConfigList > 0 then
			local logList = self:getUserDataTb_()

			for index, logconfig in ipairs(mo.logConfigList) do
				local go = gohelper.cloneInPlace(logitem, "speicalLog" .. index)

				gohelper.setActive(go, true)

				local name = logconfig.speaker
				local content = logconfig.content
				local gologcontent = go:GetComponent(gohelper.Type_HorizontalLayoutGroup)
				local txt = gohelper.findChildText(go, "#txt_log")

				txt.text = "<color=#A14114>" .. name .. "</color>" .. ":" .. content

				ZProj.UGUIHelper.RebuildLayout(go.transform)
				ZProj.UGUIHelper.RebuildLayout(itemObj.go.transform)

				local state = self:checkSingleItemHeightIsFull(false, gologcontent.preferredHeight)

				if not state then
					gohelper.destroy(go)

					break
				end

				local needContinue = self:checkAndHandleOverText(mo, itemObj.index, index, cscontent, true, txt)

				if needContinue then
					table.insert(logList, go)
				else
					gohelper.destroy(go)

					break
				end
			end

			itemObj.logList = logList
		end

		if not itemObj.logList or not next(itemObj.logList) then
			self:resetFunc(itemObj)
			gohelper.destroy(itemObj.go)

			itemObj = nil

			return false
		end

		ZProj.UGUIHelper.RebuildLayout(itemObj.go.transform)

		itemObj.preferredHeight = cscontent.preferredHeight
	end

	return itemObj
end

function RoomLogView:buildCustomItem(itemObj, mo, index)
	local gotype = self:handleType(itemObj, mo)

	if self._isLeftFull then
		if not self._rightContentHeight then
			if not mo.num then
				local num = math.random(1, 2)

				if gotype then
					local item = self:getUserDataTb_()

					for i = 1, 2 do
						local gobg = gohelper.findChild(gotype, "#scroll_details/image_detailsbg" .. i)

						gohelper.setActive(gobg, false)
					end

					item.num = num

					local gobg = gohelper.findChild(gotype, "#scroll_details/image_detailsbg" .. num)
					local godecIcon = gohelper.findChild(gobg, "dec")
					local goIcon = gohelper.findChild(gobg, "dec/icon")
					local gotime = gohelper.findChild(gobg, "timebg")
					local txttime = gohelper.findChildText(gobg, "timebg/#txt_time")

					txttime.text = mo.timestr

					gohelper.setActive(gobg, true)

					item.simagesticker = gohelper.findChildSingleImage(gotype, "#scroll_details/#simage_stickers")
					item.simagesignature = gohelper.findChildSingleImage(gotype, "#scroll_details/#simage_signature")

					local txtname = gohelper.findChildText(gotype, "#scroll_details/#txt_name")
					local gologitem = gohelper.findChild(gotype, "#scroll_details/Viewport/Content/logitem")

					txtname.text = mo.name

					local temp = string.split(mo.config.extraBonus, "#")
					local stickerpath = temp[2]
					local signaturepath = mo.config.icon

					if stickerpath then
						item.simagesticker:LoadImage(ResUrl.getPropItemIcon(stickerpath))
					end

					if signaturepath then
						item.simagesignature:LoadImage(ResUrl.getSignature("characterget/" .. signaturepath))
					end

					gohelper.setActive(goIcon, not mo.isclone)
					gohelper.setActive(godecIcon, not mo.isclone)
					gohelper.setActive(gotime, not mo.isclone)
					gohelper.setActive(item.simagesticker.gameObject, not mo.isclone)
					gohelper.setActive(txtname.gameObject, not mo.isclone)

					local cscontent = itemObj.go:GetComponent(gohelper.Type_VerticalLayoutGroup)

					itemObj.cscontent = cscontent

					if mo.logConfigList and #mo.logConfigList > 0 then
						local logList = self:getUserDataTb_()

						for index, logconfig in ipairs(mo.logConfigList) do
							local go = gohelper.cloneInPlace(gologitem, "customLog" .. index)

							gohelper.setActive(go, true)

							local gologcontent = go:GetComponent(gohelper.Type_VerticalLayoutGroup)
							local txt = gohelper.findChildText(go, "#txt_log")

							txt.text = logconfig.content

							ZProj.UGUIHelper.RebuildLayout(go.transform)
							ZProj.UGUIHelper.RebuildLayout(itemObj.go.transform)
							self:checkSingleItemHeightIsFull(false, gologcontent.preferredHeight)

							local needContinue = self:checkAndHandleOverText(mo, itemObj.index, index, cscontent, true, txt, item)

							if needContinue then
								table.insert(logList, go)
							else
								gohelper.destroy(go)

								break
							end
						end

						itemObj.logList = logList
					end

					if not itemObj.logList or not next(itemObj.logList) then
						self:resetFunc(itemObj)
						gohelper.destroy(itemObj.go)

						itemObj = nil

						return false
					end

					ZProj.UGUIHelper.RebuildLayout(itemObj.go.transform)

					itemObj.preferredHeight = cscontent.preferredHeight
				end

				return itemObj
			end
		end
	end
end

function RoomLogView:buildTimeItem(itemObj, mo, index)
	local gotype = self:handleType(itemObj, mo)

	if gotype then
		local cscontent = itemObj.go:GetComponent(gohelper.Type_VerticalLayoutGroup)

		itemObj.cscontent = cscontent

		local txt = gohelper.findChildText(gotype, "bg/#txt_time")

		txt.text = luaLang("weekday" .. tonumber(mo.day))

		ZProj.UGUIHelper.RebuildLayout(itemObj.go.transform)

		itemObj.preferredHeight = cscontent.preferredHeight

		local state = self:checkSingleItemHeightIsFull(false, itemObj.preferredHeight)

		if not state then
			table.insert(self._molist, index + 1, mo)
			self:resetFunc(itemObj)
			gohelper.destroy(itemObj.go)

			itemObj = nil

			return false
		end
	end

	return itemObj
end

function RoomLogView:checkSingleItemHeightIsFull(isNormal, preferredHeight)
	local topspace = 16
	local bottomspace = 16
	local itemspace = isNormal and 40 or 0
	local height = preferredHeight or self._singleTextHeight

	if not self._isLeftFull then
		if topspace + height + bottomspace + itemspace > self._leftContentHeight - self._contentHeight then
			self._isLeftFull = true

			return false
		end
	elseif not self._isRightFull and topspace + height + bottomspace + itemspace > self._rightContentHeight - self._contentHeight then
		self._isRightFull = true

		return false
	end

	return true
end

function RoomLogView:handleType(itemObj, mo)
	local gotype

	for type, go in ipairs(itemObj.gotypelist) do
		if type == mo.type then
			gohelper.setActive(go, true)

			gotype = go
		else
			gohelper.setActive(go, false)
		end
	end

	return gotype
end

function RoomLogView:createOrGetItem()
	local itemObj

	if not itemObj then
		itemObj = self:getUserDataTb_()

		local resPath = self.viewContainer:getSetting().otherRes[3]

		if self._isLeftFull then
			if not self._curCreateBookItem.goRight then
				local cloneInPageGO = self._curCreateBookItem.goLeft

				itemObj.go = self:getResInst(resPath, cloneInPageGO, "item")
				itemObj.gotypelist = {}

				for i = 1, 4 do
					local gotype = gohelper.findChild(itemObj.go, "type" .. i)

					table.insert(itemObj.gotypelist, gotype)
				end
			end
		end
	end

	gohelper.setActive(itemObj.go, true)

	return itemObj
end

function RoomLogView:setParent(itemObj)
	local isLeft = not self._isLeftFull

	if self._isLeftFull then
		if not self._rightContentHeight then
			local contentHeight = self._leftContentHeight

			self._contentHeight = self:calculateHeight(isLeft)

			function self.checkfunc(itemObj)
				if self._contentHeight + itemObj.preferredHeight > contentHeight then
					if itemObj.logList and #itemObj.logList > 1 then
						local loggo = table.remove(itemObj.logList)

						gohelper.destroy(loggo)
						ZProj.UGUIHelper.RebuildLayout(itemObj.go.transform)

						itemObj.preferredHeight = itemObj.cscontent.preferredHeight

						self.checkfunc(itemObj, self)
					else
						if isLeft then
							self._isLeftFull = true
						else
							self._isRightFull = true
						end

						self._contentHeight = 0

						self:resetFunc(itemObj)

						itemObj = nil
					end
				elseif isLeft then
					itemObj.go.transform:SetParent(self._curCreateBookItem.goLeft.transform)

					self._leftItemList[self._bookPage] = self._leftItemList[self._bookPage] or {}

					table.insert(self._leftItemList[self._bookPage], itemObj)

					self._pageToMo[self._bookPage] = self._pageToMo[self._bookPage] or {}
					self._pageToMo[self._bookPage][itemObj.index] = itemObj.mo
					self._contentHeight = self:calculateHeight(true)
				else
					itemObj.go.transform:SetParent(self._curCreateBookItem.goRight.transform)

					self._rightItemList[self._bookPage] = self._rightItemList[self._bookPage] or {}

					table.insert(self._rightItemList[self._bookPage], itemObj)

					self._pageToMo[self._bookPage][itemObj.index] = itemObj.mo
					self._contentHeight = self:calculateHeight(false)
				end
			end

			self.checkfunc(itemObj, self)
		end
	end
end

function RoomLogView:refreshUI()
	self._isLeftFull = false
	self._isRightFull = false
	self._contentHeight = 0

	self:updateView()
end

function RoomLogView:resetFunc(itemObj)
	if itemObj.logList and #itemObj.logList > 0 then
		for index, go in ipairs(itemObj.logList) do
			gohelper.destroy(go)
		end

		itemObj.logList = nil
	end
end

function RoomLogView:checkAndHandleOverText(mo, moListIndex, logIndex, gologcontent, isloop, txtcomp, customitem)
	local height = gologcontent.preferredHeight
	local topspace = 16
	local bottomspace = 16
	local logspace = 10
	local stickerHeight = 220
	local customTop = 30
	local customBottom = 80
	local isLeft = not self._isLeftFull

	if self._isLeftFull then
		if not self._rightContentHeight then
			local contentHeight = self._leftContentHeight

			self.localContentHeight = self.localContentHeight == 0 and self:calculateHeight(isLeft) or self.localContentHeight

			if not isloop or #mo.logConfigList == 1 then
				local tempHeight = self:calculateHeight(isLeft)
				local desc = txtcomp.text
				local textInfo = txtcomp:GetTextInfo(desc)
				local lineCount = textInfo.lineCount
				local splitWordIndex = 0

				for i = 0, lineCount - 1 do
					local lineHeight = textInfo.lineInfo[i].lineHeight

					tempHeight = tempHeight + lineHeight

					if contentHeight < topspace + tempHeight + bottomspace + (i + 1) * logspace then
						if i > 1 then
							splitWordIndex = textInfo.lineInfo[i - 1].firstVisibleCharacterIndex
						else
							table.insert(self._molist, moListIndex + 1, mo)

							return false
						end

						txtcomp.text = GameUtil.utf8sub(desc, 1, splitWordIndex)

						local splitDesc = GameUtil.utf8sub(desc, splitWordIndex + 1, textInfo.characterCount)

						if mo.type == RoomRecordEnum.LogType.Normal then
							local newmo = mo

							newmo.content = splitDesc
							newmo.isclone = true

							table.insert(self._molist, moListIndex + 1, newmo)

							return true
						else
							local newmo = mo

							newmo.logConfigList[1].content = splitDesc
							newmo.isclone = true

							table.insert(self._molist, moListIndex + 1, newmo)

							return true
						end
					end
				end
			elseif mo.type == RoomRecordEnum.LogType.Custom then
				local tempHeight = self:calculateHeight(isLeft)

				if stickerHeight > contentHeight - tempHeight - customTop - customBottom then
					if isLeft then
						self._isLeftFull = true
					else
						self._isRightFull = true
					end

					table.insert(self._molist, moListIndex + 1, mo)

					return false
				elseif contentHeight < tempHeight + height then
					local newmo = mo

					mo.num = customitem.num

					local newConfigLogList = {}

					newmo.isclone = true

					for i = logIndex, #mo.logConfigList do
						table.insert(newConfigLogList, mo.logConfigList[i])
					end

					newmo.logConfigList = newConfigLogList

					table.insert(self._molist, moListIndex + 1, newmo)

					if customitem then
						gohelper.setActive(customitem.simagesignature.gameObject, false)
					end

					return false
				end
			else
				local tempHeight = self:calculateHeight(isLeft)

				if contentHeight < tempHeight + height then
					local newmo = mo
					local newConfigLogList = {}

					newmo.isclone = true

					for i = logIndex, #mo.logConfigList do
						table.insert(newConfigLogList, mo.logConfigList[i])
					end

					newmo.logConfigList = newConfigLogList

					table.insert(self._molist, moListIndex + 1, newmo)

					return false
				end
			end

			return true
		end
	end
end

function RoomLogView:calculateHeight(isLeft)
	local height = 0

	if isLeft then
		if self._leftItemList[self._bookPage] and #self._leftItemList[self._bookPage] > 0 then
			for index, itemObj in ipairs(self._leftItemList[self._bookPage]) do
				height = height + itemObj.preferredHeight
			end

			height = height + self._itemspace * (#self._leftItemList[self._bookPage] - 1)
		end
	elseif self._rightItemList[self._bookPage] and #self._rightItemList[self._bookPage] > 0 then
		for index, itemObj in ipairs(self._rightItemList[self._bookPage]) do
			height = height + itemObj.preferredHeight
		end

		height = height + self._itemspace * (#self._rightItemList[self._bookPage] - 1)
	end

	return height
end

function RoomLogView:onClose()
	return
end

function RoomLogView:onDestroyView()
	return
end

return RoomLogView
