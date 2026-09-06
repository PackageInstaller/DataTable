-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/headitem/controller/HeadItemController.lua

module("logic.extensions.headitem.controller.HeadItemController", package.seeall)

local HeadItemController = class("HeadItemController", BaseController)

function HeadItemController:ctor()
	HeadItemController.super.ctor(self)
end

function HeadItemController:onInit()
	HeadItemAgent.instance:addHandler(HeadItemAgent.PM_notifyHeadIconChangeRes, self.onHeadIconChange, self)
	HeadItemAgent.instance:addHandler(HeadItemAgent.PM_notifyHeadFrameChangeRes, self.onHeadFrameChange, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadData, self)
	self:onReset()
end

function HeadItemController:onReset()
	return
end

function HeadItemController:_reloadData()
	HeadItemModel.instance:reInited()
end

function HeadItemController:onHeadIconChange(msg, status)
	HeadItemModel.instance:addIconList(msg.headIconList)
	GlobalDispatcher:dispatch(GlobalNotify.ON_HEAD_ITEM_CHANGE)
end

function HeadItemController:onHeadFrameChange(msg, status)
	HeadItemModel.instance:addFrameList(msg.headIconFrameList)
	GlobalDispatcher:dispatch(GlobalNotify.ON_HEAD_ITEM_CHANGE)
end

function HeadItemController:sendGetInfo(callBack)
	local hasInited = HeadItemModel.instance:getHasInited()

	if not hasInited then
		HeadItemAgent.instance:sendPM_LoadAllHeadItemReq(function(msg)
			forcePrint("=====HeadItemController:sendGetInfo success=====")
			HeadItemModel.instance:init(msg)
			GameUtil.callBack(callBack)
		end)
	else
		GameUtil.callBack(callBack)
	end
end

function HeadItemController:sendWearItem(type, cfg)
	if type == MatType.HeadIcon then
		if RoleModel.instance:getHeadIconId() ~= cfg.id then
			HeadItemAgent.instance:sendPM_ChangeHeadIconReq(cfg.id, function(msg)
				HeadItemModel.instance:updateWearIcon(msg.curHeadIconId)
			end)
		end
	elseif RoleModel.instance:getHeadFrameId() ~= cfg.id then
		HeadItemAgent.instance:sendPM_ChangeHeadFrameReq(cfg.id, function(msg)
			HeadItemModel.instance:updateWearFrame(msg.curHeadFrameId)
		end)
	end
end

function HeadItemController:setMyHeadCell(go, showCallBack)
	local headId = RoleModel.instance:getHeadIconId()
	local frameId = RoleModel.instance:getHeadFrameId()
	local vipLv = RoleModel.instance:getVipLvl()
	local proxy = self:setHeadCell(go, headId, frameId, (RoleModel.instance:getSettingSwitchIsOpen(GameEnum.PlayerSettingSwitchBitPos.NO_SHOW_VIP_LV) or nil) and 0, showCallBack)

	if proxy then
		proxy.binder:addMyVipLvlupEvent()
	end

	return proxy
end

function HeadItemController:setMyHeadCellWithoutVip(go, callBack)
	local headId = RoleModel.instance:getHeadIconId()
	local frameId = RoleModel.instance:getHeadFrameId()
	local vipLv = 0

	return self:setHeadCell(go, headId, frameId, vipLv, callBack)
end

function HeadItemController:setHeadCell(go, headId, frameId, vipLv, showCallBack)
	if not goutil.isNil(go) then
		local img = go.gameObject:GetComponent(goutil.Type_UIImage)

		if not goutil.isNil(img) then
			img.enabled = false
		end

		if checknumber(headId) > 0 then
			local proxy = MaterialMgr.setCell(MatType.HeadIcon, headId, go)

			if proxy then
				proxy.binder:setVipLvl(vipLv)
				proxy.binder:setBgActive(false)
				proxy.binder:setHeadFrameById(frameId, showCallBack)
			end

			return proxy
		else
			self:resetHeadCell(go)

			return nil
		end
	end
end

function HeadItemController:resetHeadCell(go)
	MaterialMgr.resetAll(go)
end

function HeadItemController:setHeadCellByInfo(go, info, isAutoShowInfoView, showCallBack)
	if info then
		local userId = checknumber(info.userId)
		local myUserId = checknumber(RoleModel.instance:getUserId())
		local proxy = self:setHeadCell(go, info.headIconId, info.headFrameId, (userId == myUserId and RoleModel.instance:getSettingSwitchIsOpen(GameEnum.PlayerSettingSwitchBitPos.NO_SHOW_VIP_LV) or nil) and 0, showCallBack)

		if proxy and isAutoShowInfoView then
			proxy:setCallBack(function()
				FriendController.instance:showInfoView(info.userId, go)
			end)
		end

		return proxy
	else
		printError(">>>>>>>>>> 头像信息设置不正确 看到这报错麻烦上报")
	end
end

HeadItemController.instance = HeadItemController.New()

return HeadItemController
