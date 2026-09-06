-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolamengmeng/view/DuolaMMGameRuleView.lua

module("logic.extensions.duolamengmeng.view.DuolaMMGameRuleView", package.seeall)

local DuolaMMGameRuleView = class("DuolaMMGameRuleView", ViewComponent)
local RULE_STR = {
	"看准时机点击屏幕，让小炎跳向下一个光圈，可获得光圈内的碎片！",
	"小心哦，如果撞到齿轮，将会损失生命值！",
	"注意，地狱岩浆正在上涨，长时间未向上跳跃将被吞噬淹没，也会损失生命值！"
}

function DuolaMMGameRuleView:ctor()
	DuolaMMGameRuleView.super.ctor(self)
end

function DuolaMMGameRuleView:buildUI()
	DuolaMMGameRuleView.super.buildUI(self)

	self._btnClose = self:getBtn("btnSure")
	self._btnLeft = self:getBtn("btnPrevious")
	self._btnRight = self:getBtn("btnNext")
	self._txtRule = self:getTxt("txtRule")
	self.page = PageComponent.New()

	self.page:init(self:getGo("page"), self:getGo("PageCell"), 888, 252, 888, 8)
	self.page:setUpdateCallBack(GameUtil.handler(self._updateCell, self))
	self.page:setMoveEndCallBack(GameUtil.handler(self._onSetOffsetFinish, self))
end

function DuolaMMGameRuleView:bindEvents()
	DuolaMMGameRuleView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnLeft:AddClickListener(function()
		self:_onClickSwitch(true)
	end, self)
	self._btnRight:AddClickListener(function()
		self:_onClickSwitch(false)
	end, self)
end

function DuolaMMGameRuleView:unbindEvents()
	DuolaMMGameRuleView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function DuolaMMGameRuleView:destroyUI()
	DuolaMMGameRuleView.super.destroyUI(self)
end

function DuolaMMGameRuleView:onEnter()
	DuolaMMGameRuleView.super.onEnter(self)

	self._curViewDatas = {
		1,
		2,
		3
	}
	self._curIndex = 1

	self.page:setData(self._curViewDatas)
	self.page:moveToIdx(self._curIndex - 1)
end

function DuolaMMGameRuleView:onEnterFinished()
	DuolaMMGameRuleView.super.onEnterFinished(self)
end

function DuolaMMGameRuleView:onExit()
	DuolaMMGameRuleView.super.onExit(self)
	GlobalDispatcher:dispatch(GlobalNotify.SuppressGameToStartGame)
end

function DuolaMMGameRuleView:onExitFinished()
	DuolaMMGameRuleView.super.onExitFinished(self)
end

function DuolaMMGameRuleView:_updateCell(cell, data, idx)
	local img1 = goutil.findChild(cell, "imgRule1")
	local img2 = goutil.findChild(cell, "imgRule2")
	local img3 = goutil.findChild(cell, "imgRule3")

	goutil.setActive(img1, idx == 1)
	goutil.setActive(img2, idx == 2)
	goutil.setActive(img3, idx == 3)
end

function DuolaMMGameRuleView:_onSetOffsetFinish()
	self._curIndex = self.page:getCurIndex() + 1
	self._txtRule.text = RULE_STR[self._curIndex]

	goutil.setActive(self._btnClose.gameObject, self._curIndex == 3)
	self:_updateSwitchBtnStatus()
end

function DuolaMMGameRuleView:_updateSwitchBtnStatus()
	goutil.setActive(self._btnLeft.gameObject, self.page:getCurIndex() > 0)
	goutil.setActive(self._btnRight.gameObject, self.page:getCurIndex() + 1 < #self._curViewDatas)
end

function DuolaMMGameRuleView:_onClickSwitch(isLeft)
	if isLeft then
		self.page:prePage()
	else
		self.page:nextPage()
	end
end

return DuolaMMGameRuleView
