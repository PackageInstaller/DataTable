-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelanswerresaultView.lua

module("logic.extensions.goodfeel.view.GoodfeelanswerresaultView", package.seeall)

local GoodfeelanswerresaultView = class("GoodfeelanswerresaultView", ViewComponent)

function GoodfeelanswerresaultView:ctor()
	GoodfeelanswerresaultView.super.ctor(self)
end

function GoodfeelanswerresaultView:buildUI()
	GoodfeelanswerresaultView.super.buildUI(self)

	self._getBtn = self:getBtn("getBtn")
	self._descText = goutil.findChildTextComponent(self.mainGO, "descText")
	self._trueText = goutil.findChildTextComponent(self.mainGO, "trueText")
	self._wrongText = goutil.findChildTextComponent(self.mainGO, "wrongText")
	self._noWrongText = goutil.findChildTextComponent(self.mainGO, "noWrongText")
	self._itemCon = self:getGo("itemCon")
	self._itemCell = self:getGo("cell")
	self._itemGroup = ItemGroup.New(self._itemCon, self._itemCell, nil, nil, true)
end

function GoodfeelanswerresaultView:bindEvents()
	GoodfeelanswerresaultView.super.bindEvents(self)
	self._getBtn:AddClickListener(self.close, self)
end

function GoodfeelanswerresaultView:unbindEvents()
	GoodfeelanswerresaultView.super.unbindEvents(self)
	self._getBtn:RemoveClickListener()
end

function GoodfeelanswerresaultView:destroyUI()
	GoodfeelanswerresaultView.super.destroyUI(self)
end

function GoodfeelanswerresaultView:onEnter()
	GoodfeelanswerresaultView.super.onEnter(self)

	local params = self:getOpenParam()
	local data = params[1]

	self._changeSetId = params[2]
	self._descText.text = data.isRight and "恭喜你答对啦，这是你的奖励" or "你的回答错误，不要灰心，这是你的奖励"

	if data.isRight then
		self._trueText.text = ""
		self._wrongText.text = ""
		self._noWrongText.text = "你的选择：" .. data.rightTxt
	else
		self._trueText.text = "正确答案：" .. data.rightTxt
		self._wrongText.text = "你的选择：" .. data.selectTxt
		self._noWrongText.text = ""
	end

	self._list = MaterialController.instance:getTempItemsByChangeSetId(self._changeSetId) or {}

	self._itemGroup:updateWithMoArray(self._list, function(item, data)
		MaterialMgr.setCellByMo(data, item.mainGO)
	end)
end

function GoodfeelanswerresaultView:onEnterFinished()
	GoodfeelanswerresaultView.super.onEnterFinished(self)
end

function GoodfeelanswerresaultView:onExit()
	GoodfeelanswerresaultView.super.onExit(self)
	MaterialMgr.resetAll(self._itemCon)

	if self._list then
		MaterialController.instance:showChangeSetItemMo(self._list, self._changeSetId)
	end
end

function GoodfeelanswerresaultView:onExitFinished()
	GoodfeelanswerresaultView.super.onExitFinished(self)
end

return GoodfeelanswerresaultView
