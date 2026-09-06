-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyHonorWallView.lua

module("logic.extensions.newfamily.view.FamilyHonorWallView", package.seeall)

local FamilyHonorWallView = class("FamilyHonorWallView", ViewComponent)

function FamilyHonorWallView:ctor()
	FamilyHonorWallView.super.ctor(self)

	self._honorItemList = nil
end

function FamilyHonorWallView:bindEvents()
	FamilyHonorWallView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._lookBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.FamilyHonorList)
	end, self)
	self._editBtn:AddClickListener(function()
		if not self._isChief then
			FloatWordMgr.instance:show("只有族长或者副组长才可以编辑！")

			return
		end

		UIStateManager.instance:push(ViewName.FamilyHonorEdit)
	end, self)
	self._shareBtn:AddClickListener(function()
		local honorList = FamilyHonorModel.instance:getOtherHonorWallInfo()

		if honorList == nil or #honorList == 0 then
			FloatWordMgr.instance:show("荣誉墙空的没有勋章可以分享！")

			return
		end

		local info = FamilyModel.instance:getMyFamilyInfo()

		if info == nil or info.familyId == nil then
			return
		end

		UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.ShareHonor, info.familyId, 1)
	end, self)
end

function FamilyHonorWallView:unbindEvents()
	FamilyHonorWallView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._lookBtn:RemoveClickListener()
	self._editBtn:RemoveClickListener()
	self._shareBtn:RemoveClickListener()

	for _, item in pairs(self._honorItemList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end
end

function FamilyHonorWallView:onExit()
	FamilyHonorWallView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataNewFamilyHonorInfo, self._updateShowHonorWall, self)
end

function FamilyHonorWallView:destroyUI()
	FamilyHonorWallView.super.destroyUI(self)

	for _, item in pairs(self._honorItemList or {}) do
		if item and item.iconImaGo then
			uGuiUtil.clearImage(item.iconImaGo)
		end
	end

	self._honorItemList = nil
end

function FamilyHonorWallView:buildUI()
	FamilyHonorWallView.super.buildUI(self)

	self._closeBtn = self:getBtn("topInfoGo/closeBtn")
	self._itemGridTran = self:getGo("itemGridTran").transform
	self._honorItem = self:getGo("honorItem")
	self._lookBtn = self:getBtn("btnsTranGo/lookBtn")
	self._editBtn = self:getBtn("btnsTranGo/editBtn")
	self._shareBtn = self:getBtn("shareBtn")

	GameUtil.SetActive(self._honorItem, false)
end

function FamilyHonorWallView:onEnter()
	FamilyHonorWallView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataNewFamilyHonorInfo, self._updateShowHonorWall, self)

	self._isChief = FamilyModel.instance:isFamilyChief()

	GameUtil.SetActive(self._editBtn, self._isChief)
	self:_updateShowHonorWall()
	FamilyHonorController.instance:csRequestFamilyMedalGetMedalListReq()
end

function FamilyHonorWallView:_updateShowHonorWall()
	self._honorItemList = self._honorItemList or {}

	if #self._honorItemList > 0 then
		for i = 1, #self._honorItemList do
			if self._honorItemList[i] and self._honorItemList[i].itemGo then
				GameUtil.asBtn(self._honorItemList[i].itemGo):RemoveClickListener()
				uGuiUtil.clearImage(self._honorItemList[i].iconImaGo)
				GameUtil.SetActive(self._honorItemList[i].itemGo, false)
			end
		end
	end

	local honorList = FamilyHonorModel.instance:getOtherHonorWallInfo()

	if honorList == nil or #honorList == 0 then
		return
	end

	local settingInfo = FamilyModel.instance:getMyFamilySettingInfo()

	if settingInfo then
		if not settingInfo.familyName then
			local familyName = "无"
			local onceGridSize = goutil.getWidth(self._itemGridTran) / FamilyHonorModel.instance.wallWide

			for i = 1, #honorList do
				if self._honorItemList[i] == nil or self._honorItemList[i].itemGo == nil then
					local go = UnityEngine.GameObject.Instantiate(self._honorItem, self._itemGridTran)

					GameUtil.SetActive(go, true)

					self._honorItemList[i] = {}
					self._honorItemList[i].itemGo = go
					self._honorItemList[i].kuangIma = goutil.findChild(go, "kuangIma"):GetComponent("UIImageSpriteChange")
					self._honorItemList[i].iconImaGo = goutil.findChild(go, "iconImaGo")
				else
					GameUtil.SetActive(self._honorItemList[i].itemGo, true)
				end

				local cfg = FamilyHonorConfig.instance:getFamilyMedalCfg(honorList[i].defineId)

				GameUtil.setWidth(self._honorItemList[i].itemGo, onceGridSize * cfg.width)
				GameUtil.setHeight(self._honorItemList[i].itemGo, onceGridSize * cfg.height)

				local iconPath = "ui/bigbg/familycallorder/" .. cfg.icon .. ".png"

				uGuiUtil.setSpriteToImage(self._honorItemList[i].iconImaGo, uGuiUtil.SpriteType.BigBg, iconPath)
				GameUtil.setAnchoredPos(self._honorItemList[i].itemGo, honorList[i].positionX * onceGridSize, -honorList[i].positionY * onceGridSize)
				self._honorItemList[i].kuangIma:SetState(cfg.level - 1)
				GameUtil.asBtn(self._honorItemList[i].itemGo):AddClickListener(function()
					local params = {
						isSeeInfo = false,
						defineId = honorList[i].defineId,
						gainedTime = honorList[i].gainedTime,
						familyName = familyName
					}

					UIStateManager.instance:push(ViewName.FamilyHonorTips, params)
				end, self)
			end
		end
	end
end

return FamilyHonorWallView
