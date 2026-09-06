-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarypreheat/view/TenthAnniversaryBulletView.lua

module("logic.extensions.anniversarypreheat.view.TenthAnniversaryBulletView", package.seeall)

local TenthAnniversaryBulletView = class("TenthAnniversaryBulletView", ViewComponent)

function TenthAnniversaryBulletView:buildUI()
	TenthAnniversaryBulletView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._cells = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("main/btnCell_" .. i)
		cell.select = goutil.findChild(cell.go, "select")
		cell.txt = goutil.findChildTextComponent(cell.go, "Text")
		cell.cfg = nil
		self._cells[i] = cell
	end
end

function TenthAnniversaryBulletView:bindEvents()
	TenthAnniversaryBulletView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)

	for i = 1, 3 do
		GameUtil.rmClickHandler(self._cells[i].go)
		GameUtil.addClickHandler(self._cells[i].go, GameUtil.handler(self._refreshBulletParts, self, i))
	end
end

function TenthAnniversaryBulletView:unbindEvents()
	TenthAnniversaryBulletView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)

	for i = 1, 3 do
		GameUtil.rmClickHandler(self._cells[i].go)
	end
end

function TenthAnniversaryBulletView:onEnter()
	TenthAnniversaryBulletView.super.onEnter(self)

	self._bulletCfgs = AnniversaryPreheatConfig.instance:getBulletScreenCfgs()

	local maxCount = #self._bulletCfgs

	math.randomseed(os.time())

	for i = 1, maxCount do
		local randomNum = math.random(i, maxCount)

		self._bulletCfgs[i] = self._bulletCfgs[randomNum]
		self._bulletCfgs[randomNum] = self._bulletCfgs[i]
	end

	for i = 1, 3 do
		self._cells[i].cfg = self._bulletCfgs[i]
		self._cells[i].txt.text = self._cells[i].cfg.content
	end

	self:_refreshBulletParts(1)
end

function TenthAnniversaryBulletView:onExit()
	TenthAnniversaryBulletView.super.onExit(self)
end

function TenthAnniversaryBulletView:_refreshBulletParts(id)
	self._selectId = id

	for i = 1, 3 do
		goutil.setActive(self._cells[i].select, i == self._selectId)
	end
end

function TenthAnniversaryBulletView:_onClickSure()
	self:close()
	AnniversaryPreheatController.instance:sendDanMu(self._cells[self._selectId].cfg.id)
end

return TenthAnniversaryBulletView
