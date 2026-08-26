-- chunkname: @modules/logic/sp02/atomic/view/AtomicRewardView.lua

module("modules.logic.sp02.atomic.view.AtomicRewardView", package.seeall)

local AtomicRewardView = class("AtomicRewardView", BaseView)

function AtomicRewardView:onInitView()
	self.btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._txtScore = gohelper.findChildTextMesh(self.viewGO, "Left/starNum/#txt_num")
	self._gonormalline = gohelper.findChild(self.viewGO, "progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	self._rectnormalline = self._gonormalline.transform
	self.startSpace = 2
	self.cellWidth = 268
	self.space = 0
	self.goTesingItem = gohelper.findChild(self.viewGO, "Left/tesinglayout/#go_tesingitem")

	gohelper.setActive(self.goTesingItem, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicRewardView:addEvents()
	self.addClickCb(self, self.btnReward, self.onClickReward, self)
	self.addEventCb(self, MileStoneController.instance, MileStoneEvent.onGetBonus, self.onGainReward, self)
end

function AtomicRewardView:removeEvents()
	self:removeClickCb(self.btnReward)
	self.removeEventCb(self, MileStoneController.instance, MileStoneEvent.onGetBonus, self.onGainReward, self)
end

function AtomicRewardView:_editableInitView()
	return
end

function AtomicRewardView:onClickReward()
	return
end

function AtomicRewardView:openRewardView()
	return
end

function AtomicRewardView:onGainReward()
	self:refreshView()
end

function AtomicRewardView:onOpen()
	self.mileStoneId = self.viewParam and self.viewParam.id

	self:refreshView()
end

function AtomicRewardView:refreshView()
	self:refreshReward()
	self:refreshProgress()
end

function AtomicRewardView:refreshProgress()
	local totalProgress, dataList = AtomicDungeonModel.instance:getPolygonProgress(true)

	self:refreshTesingList(dataList)

	self._txtScore.text = totalProgress

	local list = MileStoneListModel.instance:getList()
	local curIndex = #list
	local curShowIndex

	for i, v in ipairs(list) do
		if curShowIndex == nil and not MileStoneUtil.isBonusHasGet(v.config.milestoneId, v.config.bonusId) then
			curShowIndex = i
		end

		if totalProgress < v:getProgress() then
			curIndex = i - 1

			break
		end
	end

	local curScore = list[curIndex] and list[curIndex]:getProgress() or 0
	local nextScore = list[curIndex + 1] and list[curIndex + 1]:getProgress() or curScore
	local beginPos = 0
	local nodeWidth = self:getNodeWidth(curIndex, beginPos)
	local offsetWidth = self:getNodeWidth(curIndex + 1, beginPos) - nodeWidth

	recthelper.setWidth(self._rectnormalline, nodeWidth + ((curScore < nextScore or nil) and (totalProgress - curScore) / (nextScore - curScore) * offsetWidth))

	if not self.isPlayMove then
		self.isPlayMove = true

		if curShowIndex ~= nil then
			local scrollView = self.viewContainer:getScrollView()

			scrollView:moveToByIndex(curShowIndex, 0.2)
		end
	end
end

function AtomicRewardView:getNodeWidth(index, beginPos)
	beginPos = beginPos or 0

	return (index > 0 or nil) and (index - 1) * (self.cellWidth + self.space) + self.startSpace + beginPos
end

function AtomicRewardView:refreshReward()
	MileStoneListModel.instance:refreshList(self.mileStoneId)
end

function AtomicRewardView:refreshTesingList(dataList)
	self.itemList = self.itemList or {}

	for i = 1, math.max(#self.itemList, #dataList) do
		local item = self:getTesingItem(i)

		self:updateTesingItem(item, dataList[i])
	end
end

function AtomicRewardView:getTesingItem(index)
	local item = self.itemList[index]

	if not item then
		item = {
			go = gohelper.cloneInPlace(self.goTesingItem)
		}
		item.txtName = gohelper.findChildTextMesh(item.go, "bg/#txt_tesingtext")
		item.starList = {}

		for i = 1, 3 do
			local starItem = {}

			starItem.go = gohelper.findChild(item.go, string.format("stariconlayout/star%s", i))
			starItem.goLight = gohelper.findChild(starItem.go, "#go_light")
			starItem.goDark = gohelper.findChild(starItem.go, "#go_dark")

			table.insert(item.starList, starItem)
		end

		self.itemList[index] = item
	end

	return item
end

function AtomicRewardView:updateTesingItem(item, data)
	item.data = data

	gohelper.setActive(item.go, data ~= nil)

	if not data then
		return
	end

	item.txtName.text = data.name

	for i = 1, 3 do
		local starItem = item.starList[i]
		local has = i <= data.totalProgress

		gohelper.setActive(starItem.go, has)

		if has then
			local light = i <= data.curProgress

			gohelper.setActive(starItem.goLight, light)
			gohelper.setActive(starItem.goDark, not light)
		end
	end
end

function AtomicRewardView:onClose()
	return
end

function AtomicRewardView:onDestroyView()
	return
end

return AtomicRewardView
