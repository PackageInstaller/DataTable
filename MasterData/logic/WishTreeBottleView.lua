-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtreebottle/view/WishTreeBottleView.lua

module("logic.extensions.wishtreebottle.view.WishTreeBottleView", package.seeall)

local WishTreeBottleView = class("WishTreeBottleView", ViewComponent)

function WishTreeBottleView:ctor()
	WishTreeBottleView.super.ctor(self)
end

function WishTreeBottleView:unbindEvents()
	WishTreeBottleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)

	for i, v in ipairs(self._bottleList) do
		GameUtil.rmClickHandler(v.btn)
	end
end

function WishTreeBottleView:bindEvents()
	WishTreeBottleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)

	for i, v in ipairs(self._bottleList) do
		GameUtil.addClickHandler(v.btn, GameUtil.handler(self._onClickBottle, self, i))
	end
end

function WishTreeBottleView:buildUI()
	WishTreeBottleView.super.buildUI(self)

	self._bottleList = {}

	for i = 1, 3 do
		local bottle = {}

		bottle.change = self:getGo("btnBottle_" .. i):GetComponent("UIImageSpriteChange")
		bottle.btn = self:getBtn("btnBottle_" .. i)
		bottle.txtName = self:getTxt("btnBottle_" .. i .. "/txtName")
		bottle.select = self:getGo("btnBottle_" .. i .. "/select")

		table.insert(self._bottleList, bottle)
	end

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
end

function WishTreeBottleView:onExit()
	WishTreeBottleView.super.onExit(self)
	GameUtil.SetActive(self._bottleList[self._typeId].select, false)
end

function WishTreeBottleView:onEnter()
	WishTreeBottleView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.WishTreeBottle)
	self._typeId = WiShTreeBottleModel.instance:getBottleTypeId()
	self._typeCfg = WiShTreeBottleConfig.instance:getWtbTypeCfg(self._activityId)

	for i, v in ipairs(self._bottleList) do
		v.txtName.text = self._typeCfg[i].content

		GameUtil.SetActive(v.select, self._typeId == i)
		v.change:ChangeSprite(self._typeCfg[i].pic)
	end
end

function WishTreeBottleView:_onClickBottle(id)
	if self._bottleList[id] and self._bottleList[self._typeId] then
		GameUtil.SetActive(self._bottleList[self._typeId].select, false)

		self._typeId = id

		GameUtil.SetActive(self._bottleList[self._typeId].select, true)
	end
end

function WishTreeBottleView:_onClickSure()
	WiShTreeBottleModel.instance:setBottleTypeId(self._typeId)
	self:_onClickClose()
end

function WishTreeBottleView:_onClickClose()
	self:close()
	UIStateManager.instance:push(ViewName.WishTreeBottleEditView)
end

return WishTreeBottleView
