-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/christmasandnewyear/NewyeartrailerView.lua

module("logic.extensions.bonus.view.christmasandnewyear.NewyeartrailerView", package.seeall)

local NewyeartrailerView = class("NewyeartrailerView", SummarySubTabView)

function NewyeartrailerView:ctor()
	NewyeartrailerView.super.ctor(self)
end

function NewyeartrailerView:init()
	NewyeartrailerView.super.init(self)

	self._likeCfgs = XiaonuoBirthConfig.instance:getDailyLikeCfg(self:thisActId(), self:getTabId())
end

function NewyeartrailerView:unbindEvents()
	NewyeartrailerView.super.unbindEvents(self)
end

function NewyeartrailerView:bindEvents()
	NewyeartrailerView.super.bindEvents(self)
end

function NewyeartrailerView:buildUI()
	NewyeartrailerView.super.buildUI(self)

	self.TableView = self:getGo("tableview")
	self.Cell = self:getGo("cell")
	self.tableview = ScrollerList.create(self.TableView, self.Cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function NewyeartrailerView:onExit()
	self.tableview:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.ActivitySummaryUpdate, self.onRefreshUI, self)
	NewyeartrailerView.super.onExit(self)
end

function NewyeartrailerView:onEnter()
	NewyeartrailerView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ActivitySummaryUpdate, self.onRefreshUI, self)
	self.tableview:reloadData(self._cfgs)
end

function NewyeartrailerView:_updateCell(view, cell, data)
	local btnJump = goutil.findChild(cell, "btnJump")

	GameUtil.addClickHandler(btnJump, GameUtil.handler(self._onJump, self, data))
	uGuiUtil.clearImage(btnJump)
	uGuiUtil.setSpriteToImage(btnJump, nil, GameUrl.getBonusIconUrl(data.background))

	local txtBtnJump = goutil.findChildTextComponent(cell, "btnJump/txtName")

	txtBtnJump.text = string.nilorempty(data.params) and "产品配表" or data.params

	local btnLike = goutil.findChild(cell, "btnLike")

	GameUtil.addClickHandler(btnLike, GameUtil.handler(self._onClickLike, self, data.id, btnLike))

	local red = goutil.findChild(cell, "btnLike/red")
	local hasLike = ActivitySummaryModel.instance:hasLike(self:thisActId(), data.tab, data.id)

	goutil.setActive(red, not hasLike)
end

function NewyeartrailerView:_clearCell(cell)
	local btnJump = goutil.findChild(cell, "btnJump")

	GameUtil.rmClickHandler(btnJump)

	local btnLike = goutil.findChild(cell, "btnLike")

	GameUtil.rmClickHandler(btnLike)
	uGuiUtil.clearImage(btnJump)
end

function NewyeartrailerView:_onClickLike(i, btnLike)
	local tab = self:getTabId()

	if ActivitySummaryModel.instance:hasLike(self:thisActId(), tab, i) then
		CommonTipsMgr.instance:openTipsByConfStr(btnLike, self._likeCfgs[i].prize)
	else
		ActivitySummaryController.instance:sendLike(tab, i)
	end
end

function NewyeartrailerView:onRefreshUI()
	self.tableview:refresh()
end

return NewyeartrailerView
