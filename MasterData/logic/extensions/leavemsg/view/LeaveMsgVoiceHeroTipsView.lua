-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/leavemsg/view/LeaveMsgVoiceHeroTipsView.lua

module("logic.extensions.leavemsg.view.LeaveMsgVoiceHeroTipsView", package.seeall)

local M = class("LeaveMsgVoiceHeroTipsView", ViewComponent)

function M:buildUI()
	self._btnCloseOutSide = self:getBtn("0&universal_second_tips_common_bg_-1467035629")
	self._btnClose = self:getBtn("0&universal_second_tips_common_bg_1201003252")
	self._btnCancel = Astral.SimpleLuaComponentContainer.Add(self:getGo("2&btn_left_-1571983320"), CommButton)
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(self:getGo("3&btn_right_1251431307"), CommButton)
	self._scroll = self:getUIComponent("leave_message_role_tips_-1411590316", UIComponentType.ScrollRect)
	self._loopList = LoopGridViewHelper.New(self._scroll.gameObject)

	self._loopList:InitGridView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	for _, value in pairs(self._itemData or {}) do
		value.destroyUI()
	end

	self._itemData = nil

	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnCloseOutSide:AddClickListener(self._onClickClose, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
end

function M:unbindEvents()
	self._btnCloseOutSide:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	self:setSelectIndex(1)
	self:refreshView(true)
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onClickClose()
	self:close()
end

function M:_onClickCancel()
	self:close()
end

function M:_onClickConfirm()
	local index = self:getSelectIndex()
	local heroData = self._moLst[index]
	local heroId = heroData.isNone and -1 or heroData:getId()
	local info = self:getFirstParam()

	info.context:setVoiceHero(heroId)
	info.context:setVoice(-1)
	GlobalDispatcher:dispatchEvent(LeaveMsgEventType.ON_EDIT_MSG_PART_CHANGE, 1, LeaveMsgEnum.MsgPartType.VoiceHero, heroId)
	GlobalDispatcher:dispatchEvent(LeaveMsgEventType.ON_EDIT_MSG_PART_CHANGE, 1, LeaveMsgEnum.MsgPartType.VoiceHeroRes, -1)
	info.context:dispatchCurPreview()
	self:close()
end

function M:getSelectIndex()
	return self._selectIndex
end

function M:setSelectIndex(index, refreshSelect)
	self._selectIndex = index

	if refreshSelect then
		for _, cell in pairs(self._itemData or {}) do
			cell.updateSelect()
		end
	end
end

function M:refreshView(resetPos)
	local _tmpHeroList = HeroDepotModel.instance:getHeroDepotData():getShowDataList()
	local sortFunc = CharacterUtil.getSortFunc(CommEnum.HeroFilter.HeroDepot, CommEnum.HeroSortFieldType.Quality, false)

	table.sort(_tmpHeroList:getMoList(), sortFunc)

	self._moLst = _tmpHeroList:getMoList()

	table.insert(self._moLst, 1, {
		isNone = true
	})

	local len = self._moLst and #self._moLst or 0

	if len > 0 then
		if resetPos then
			self._loopList:ClearCells()
		end

		self._loopList:SetListItemCount(len, resetPos)
		self._loopList:RefreshAllShownItem()
	else
		self._loopList:ClearCells()
	end
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("headItem")

	self:_updateCell(item.gameObject, curIndex)

	return item
end

function M:_updateCell(go, index)
	if not self._itemData then
		self._itemData = {}
	end

	local key = go:GetInstanceID()
	local theItem = self._itemData[key]

	if not theItem then
		theItem = {
			go = go,
			goSelect = goutil.findChild(go, "imgSelect").gameObject,
			txtNum = goutil.findChildTextComponent(go, "txtNum"),
			heroHeadItem = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(go, "hero_item"), HeroHeadItem)
		}

		function theItem.getIndex()
			return theItem.index
		end

		function theItem.updateSelect()
			goutil.setActive(theItem.goSelect, theItem.getIndex() == self:getSelectIndex())
		end

		theItem.btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click").gameObject)

		theItem.heroHeadItem:setHandler(theItem)

		function theItem.onClickHeroItem(item, heroHeadItem)
			return
		end

		theItem.btnClick:AddClickListener(function()
			self:_onCellClick(theItem.getIndex())
		end, self)

		function theItem.destroyUI()
			theItem.heroHeadItem:setHandler(nil)
			theItem.btnClick:RemoveClickListener()
			theItem.heroHeadItem:unbindEvents()
		end

		self._itemData[key] = theItem
	end

	theItem.index = index

	local heroData = self._moLst[index]
	local unlockNum, maxNum = 0, 0

	theItem.heroHeadItem:setIsNone(heroData.isNone)

	if not heroData.isNone then
		theItem.heroHeadItem:setHeroMO(heroData)

		unlockNum, maxNum = self:_getHeroVoiceNum(heroData:getId())
	end

	theItem.heroHeadItem:showCareer(false)
	theItem.heroHeadItem:showCamp(false)
	theItem.heroHeadItem:showLevel(false)
	theItem.heroHeadItem:showQuality(false)

	theItem.txtNum.text = string.format("%s/%s", unlockNum, maxNum)

	goutil.setActive(theItem.txtNum.gameObject, not heroData.isNone)
	theItem.updateSelect()
end

function M:_onCellClick(index)
	self:setSelectIndex(index, true)
end

function M:_getHeroVoiceNum(heroId)
	local unlockNum = 0
	local maxNum = 0
	local cgfList = CharacterAudioConfig.instance:getCharacterAudiosById(heroId) or {}

	maxNum = 0

	for _, _cfg in pairs(cgfList) do
		local checkRes = true
		local isUnlock = CharacterInformationModel.instance:getUnlockVoice(heroId, _cfg.audioId, checkRes)

		if isUnlock then
			unlockNum = unlockNum + 1
		end

		maxNum = maxNum + 1
	end

	return unlockNum, maxNum
end

return M
