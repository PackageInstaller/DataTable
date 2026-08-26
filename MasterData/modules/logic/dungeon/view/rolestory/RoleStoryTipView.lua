-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryTipView.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryTipView", package.seeall)

local RoleStoryTipView = class("RoleStoryTipView", BaseView)

function RoleStoryTipView:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self.itemList = {}
	self.goItem = gohelper.findChild(self.viewGO, "layout/item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryTipView:addEvents()
	self.btnClose:AddClickListener(self._btncloseOnClick, self)
end

function RoleStoryTipView:removeEvents()
	self.btnClose:RemoveClickListener()
end

function RoleStoryTipView:_editableInitView()
	return
end

function RoleStoryTipView:_btncloseOnClick()
	self:closeThis()
end

function RoleStoryTipView:_btntipsOnClick()
	gohelper.setActive(self.goTips, false)
end

function RoleStoryTipView:onUpdateParam()
	self:refreshView()
end

function RoleStoryTipView:onOpen()
	self:refreshView()
end

function RoleStoryTipView:onClose()
	return
end

function RoleStoryTipView:refreshView()
	self.storyId = RoleStoryModel.instance:getCurActStoryId()

	local scoreList = RoleStoryConfig.instance:getScoreConfig(self.storyId) or {}

	for i = 1, math.max(#self.itemList, #scoreList) do
		local item = self.itemList[i]

		if not item then
			item = self:createItem(i)
			self.itemList[i] = item
		end

		self:updateItem(item, scoreList[i], scoreList[i - 1])
	end
end

function RoleStoryTipView:createItem(index)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.cloneInPlace(self.goItem)
	item.txtNum = gohelper.findChildTextMesh(item.go, "#txt_num")
	item.txtScore = gohelper.findChildTextMesh(item.go, "#txt_score")
	item.goLine = gohelper.findChild(item.go, "line")

	gohelper.setActive(item.goLine, item.index ~= 1)

	return item
end

function RoleStoryTipView:updateItem(item, data, lastData)
	if not item then
		return
	end

	item.data = data

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	item.txtScore.text = tostring(data.score)
	item.txtNum.text = lastData and lastData.wave < data.wave - 1 and formatLuaLang("rolestoryactivitytips_wave", string.format("%s-%s", GameUtil.getNum2Chinese(lastData.wave + 1), GameUtil.getNum2Chinese(data.wave))) or formatLuaLang("rolestoryactivitytips_wave", GameUtil.getNum2Chinese(data.wave))
end

function RoleStoryTipView:onDestroyView()
	return
end

return RoleStoryTipView
