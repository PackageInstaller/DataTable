-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtreebottle/view/WishTreeBottleInfoView.lua

module("logic.extensions.wishtreebottle.view.WishTreeBottleInfoView", package.seeall)

local WishTreeBottleInfoView = class("WishTreeBottleInfoView", ViewComponent)

function WishTreeBottleInfoView:ctor()
	WishTreeBottleInfoView.super.ctor(self)
end

function WishTreeBottleInfoView:unbindEvents()
	WishTreeBottleInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnKoi)
	GameUtil.rmClickHandler(self._btnIsLiked)
end

function WishTreeBottleInfoView:bindEvents()
	WishTreeBottleInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnKoi, self._onClickKoi, self)
	GameUtil.addClickHandler(self._btnIsLiked, self._onClickIsLiked, self)
end

function WishTreeBottleInfoView:buildUI()
	WishTreeBottleInfoView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnKoi = self:getBtn("btnKoi")
	self._btnIsLiked = self:getBtn("btnIsLiked")
	self._txtName = self:getTxt("txtName")
	self._txtNum = self:getTxt("txtNum")
	self._head = self:getGo("head/con")
	self._txtDesc = self:getTxt("txtDesc")
	self._txtName = self:getTxt("txtName")
	self._bottle = self:getGo("bottle"):GetComponent("UIImageSpriteChange")
	self._txtBottleName = self:getTxt("bottle/txtName")
	self._area = self:getGo("area")
	self._txtArea = self:getTxt("area/txt")
end

function WishTreeBottleInfoView:onExit()
	WishTreeBottleInfoView.super.onExit(self)
	uGuiUtil.clearImage(self._bottle)
	uGuiUtil.clearImage(self._head)
	HeadItemController.instance:resetHeadCell(self._head)
end

function WishTreeBottleInfoView:onEnter()
	WishTreeBottleInfoView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.WishTreeBottleLikeRes, self._refreshNum, self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.WishTreeBottle)

	local data = self:getFirstParam()

	self._targetUserId = data.userId
	self._totalNum = WiShTreeBottleModel.instance:getDailyLikeNum()
	self._likeNum = checknumber(data.likeNum)
	self._typeCfg = WiShTreeBottleConfig.instance:getWtbTypeCfgById(self._activityId, data.typeId)
	self._txtBottleName.text = self._typeCfg.content
	self._txtDesc.text = data.content
	self._txtNum.text = self._likeNum
	self._bottleIsLiked = WiShTreeBottleController.instance:bottleIsLiked(self._targetUserId)

	if checknumber(self._targetUserId) > 0 then
		if data.opHeadInfo then
			HeadItemController.instance:setHeadCellByInfo(self._head, data.opHeadInfo)

			self._txtName.text = data.opHeadInfo.userName
			self._txtArea.text = data.opHeadInfo.areaName
		else
			HeadItemController.instance:setMyHeadCell(self._head)

			self._txtArea.text = RoleModel.instance:getAreaName()
			self._txtName.text = RoleModel.instance:getUserName()
		end

		GameUtil.SetActive(self._area, true)
	else
		self._txtName.text = data.name

		uGuiUtil.setSpriteToImage(self._head, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(data.opHeadInfo))
		GameUtil.SetActive(self._area, false)
	end

	self._bottle:ChangeSprite(self._typeCfg.pic)
	GameUtil.SetActive(self._btnKoi.gameObject, not self._bottleIsLiked)
	GameUtil.SetActive(self._btnIsLiked.gameObject, self._bottleIsLiked)
end

function WishTreeBottleInfoView:_refreshNum()
	self._totalNum = WiShTreeBottleModel.instance:getDailyLikeNum()
	self._likeNum = self._likeNum + 1
	self._bottleIsLiked = true
	self._txtNum.text = self._likeNum

	GameUtil.SetActive(self._btnKoi.gameObject, not self._bottleIsLiked)
	GameUtil.SetActive(self._btnIsLiked.gameObject, self._bottleIsLiked)
	self:close()
end

function WishTreeBottleInfoView:_onClickKoi()
	local dailyLikeTimes = WiShTreeBottleConfig.instance:getWtbActCfg(self._activityId).dailyLikeTimes

	if dailyLikeTimes <= self._totalNum then
		FloatWordMgr.instance:show("点赞次数已用完哦~")

		return
	end

	WiShTreeBottleController.instance:sendPM_WishTreeBottleLikeReq(self._activityId, self._targetUserId)
end

function WishTreeBottleInfoView:_onClickIsLiked()
	FloatWordMgr.instance:show("您已点赞过当前许愿瓶哦~")
end

return WishTreeBottleInfoView
