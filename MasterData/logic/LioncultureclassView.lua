-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LioncultureclassView.lua

module("logic.extensions.lionculture.view.LioncultureclassView", package.seeall)

local LioncultureclassView = class("LioncultureclassView", ViewComponent)

function LioncultureclassView:ctor()
	LioncultureclassView.super.ctor(self)
end

function LioncultureclassView:unbindEvents()
	LioncultureclassView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function LioncultureclassView:bindEvents()
	LioncultureclassView.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		self:close()
	end, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "fireworkrule")
	end, self)
end

function LioncultureclassView:buildUI()
	LioncultureclassView.super.buildUI(self)

	self._closeButton = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/txtTitle/btnTip")
	self._tabScrollerview = self:getGo("tabCol/tabScrollerview")
	self._tabScrollercell = self:getGo("tabCol/tabScrollercell")
	self._tabScrollList = ScrollerList.create(self._tabScrollerview, self._tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function LioncultureclassView:onExit()
	LioncultureclassView.super.onExit(self)
	self._tabScrollList:dispose()
end

function LioncultureclassView:onEnter()
	LioncultureclassView.super.onEnter(self)

	self.configs = LioncultureConfig.instance:getGameClassCfgs()

	self._tabScrollList:reloadData(self.configs)
end

function LioncultureclassView:_setTitle(index)
	self.curIndex = index

	self._tabScrollList:refresh()
end

function LioncultureclassView:_updateTabCell(view, cell, data, tag)
	local index = cell.index + 1
	local mainGo = cell.gameObject
	local changeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data[1].tabName

	GameUtil.rmClickHandler(mainGo)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickTabCell, self, index, data))

	if not self.curIndex then
		self:_clickTabCell(index, data)
	end

	local isSelected = self.curIndex == index

	changeGroup:SetState(isSelected and 1 or 0)
	self:getGo("tabs/contentCol" .. index):SetActive(isSelected)
end

function LioncultureclassView:_clearTabCell(cell)
	return
end

function LioncultureclassView:_clickTabCell(index, data)
	self:_setTitle(index)

	for i = 1, #data do
		local config = data[i]

		self:getTxt(string.format("tabs/contentCol%d/text%d", index, i)).text = config.desc
	end
end

return LioncultureclassView
