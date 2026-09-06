-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reviveelizabeth/view/ReviveElizabethProgressView.lua

module("logic.extensions.reviveelizabeth.view.ReviveElizabethProgressView", package.seeall)

local ReviveElizabethProgressView = class("ReviveElizabethProgressView", ViewComponent)

function ReviveElizabethProgressView:ctor()
	ReviveElizabethProgressView.super.ctor(self)
end

function ReviveElizabethProgressView:unbindEvents()
	ReviveElizabethProgressView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ReviveElizabethProgressView:bindEvents()
	ReviveElizabethProgressView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ReviveElizabethProgressView:buildUI()
	ReviveElizabethProgressView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollerList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regReloadFinish(GameUtil.handler(self._reloadFinish, self))
end

function ReviveElizabethProgressView:onExit()
	ReviveElizabethProgressView.super.onExit(self)
	self._scrollerList:dispose()
end

function ReviveElizabethProgressView:onEnter()
	ReviveElizabethProgressView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ReviveElizabethGetInfoRes, self._refreshView, self)

	local param = self:getFirstParam()

	if not param then
		FloatWordMgr.instance:show("打开页面失败~")
		self:close()

		return
	end

	self._activityId = param
	self._cfg = ReviveElizabethConfig.instance:getSoulConfig(self._activityId)

	self:_refreshView()
end

function ReviveElizabethProgressView:_updateCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local content = goutil.findChildTextComponent(cell, "txt")
	local btn = goutil.findChild(cell, "btn")
	local lock = goutil.findChildTextComponent(cell, "lock")

	ReviveElizabethController.instance:setSpriteToImage(icon, ReviveElizabethController.FlowerIconFolderUrl, data.flowerIcon)

	content.text = data.flowerContent

	local isUnlock = data.progress <= self._info.progress

	if self._info.hasInjectSoulPrizeIds then
		local isGot = table.keyof(self._info.hasInjectSoulPrizeIds, data.prizeId) ~= nil

		lock.text = isGot and "已注入" or string.format("累计%d朵解锁", data.progress)

		goutil.setActive(lock.gameObject, not isUnlock or isGot)
		goutil.setActive(btn, not lock.gameObject.activeSelf)
		GameUtil.rmClickHandler(btn)

		if not lock.gameObject.activeSelf then
			GameUtil.addClickHandler(btn, GameUtil.handler(self.onClickBtnSoul, self, data.flowerId, data.prizeId), self)
		end
	end
end

function ReviveElizabethProgressView:_clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
end

function ReviveElizabethProgressView:_reloadFinish()
	local curProgStep = 1
	local hasInjectSoulPrizeIds = self._info.hasInjectSoulPrizeIds
	local flag = false

	if hasInjectSoulPrizeIds then
		for i, v in ipairs(self._cfg) do
			if v.prizeId ~= hasInjectSoulPrizeIds[v.flowerId] then
				curProgStep = v.flowerId
				flag = true

				break
			end
		end
	end

	local maxStep = #self._cfg

	curProgStep = flag and curProgStep or maxStep

	self._scrollerList:MoveCellToCenter(curProgStep - 1)
end

function ReviveElizabethProgressView:_setIconImg(icon, bgName)
	local isNeedSetBg = icon and not string.nilorempty(bgName)

	local function localFunc()
		local image = icon:GetComponent(goutil.Type_UIImage)

		if image then
			image:SetNativeSize()
		end
	end

	if isNeedSetBg then
		local bgUrl = string.format("ui/bigbg/story/story_bg/%s.png", bgName)

		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, bgUrl, localFunc)
	end
end

function ReviveElizabethProgressView:onClickBtnSoul(flowerId, prizeId)
	UIStateManager.instance:push(ViewName.ReviveElizabethFlowerView, self._activityId, flowerId, prizeId)
end

function ReviveElizabethProgressView:_refreshView()
	self._info = ReviveElizabethModel.instance:getInfo(self._activityId)

	self._scrollerList:reloadData(self._cfg)
end

return ReviveElizabethProgressView
