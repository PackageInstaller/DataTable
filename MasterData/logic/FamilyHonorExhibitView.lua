-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyHonorExhibitView.lua

module("logic.extensions.newfamily.view.FamilyHonorExhibitView", package.seeall)

local FamilyHonorExhibitView = class("FamilyHonorExhibitView", ViewComponent)

function FamilyHonorExhibitView:ctor()
	FamilyHonorExhibitView.super.ctor(self)

	self._posItemList = nil
end

function FamilyHonorExhibitView:bindEvents()
	FamilyHonorExhibitView.super.bindEvents(self)
	GameUtil.asBtn(self._clickBtnGo):AddClickListener(self.close, self)
end

function FamilyHonorExhibitView:unbindEvents()
	FamilyHonorExhibitView.super.unbindEvents(self)
	GameUtil.asBtn(self._clickBtnGo):RemoveClickListener()
end

function FamilyHonorExhibitView:onExit()
	FamilyHonorExhibitView.super.onExit(self)
end

function FamilyHonorExhibitView:destroyUI()
	FamilyHonorExhibitView.super.destroyUI(self)

	for _, item in pairs(self._posItemList or {}) do
		if item then
			if item.iconImaGo then
				uGuiUtil.clearImage(item.iconImaGo)
			end

			if item.itemGo then
				UnityEngine.GameObject.Destroy(item.itemGo)
			end
		end
	end

	self._posItemList = nil
end

function FamilyHonorExhibitView:buildUI()
	FamilyHonorExhibitView.super.buildUI(self)

	self._clickBtnGo = self:getGo("clickBtnGo")

	local viewBgGo = self:getGo("viewBgGo")

	self._userTxt = goutil.findChildTextComponent(viewBgGo, "userGo/userTxt")
	self._numberTxt = goutil.findChildTextComponent(viewBgGo, "numberGo/numberTxt")
	self._chiefTxt = goutil.findChildTextComponent(viewBgGo, "chiefGo/chiefTxt")
	self._itemGridTran = goutil.findChild(viewBgGo, "itemGridTran").transform
	self._honorItem = goutil.findChild(viewBgGo, "honorItem")
	self._userTxt.text = ""
	self._numberTxt.text = ""
	self._chiefTxt.text = ""

	GameUtil.SetActive(self._honorItem, false)
end

function FamilyHonorExhibitView:onEnter()
	FamilyHonorExhibitView.super.onEnter(self)

	self._params = self:getFirstParam()

	if self._params == nil or self._params.familyId == nil then
		printError("sr---家族荣誉墙    FamilyHonorExhibitView:onEnter()   没有传入参数哦！")

		return
	end

	self._userTxt.text = self._params.familyName
	self._numberTxt.text = tostring(self._params.familyId)
	self._chiefTxt.text = self._params.chiefName
	self._posItemList = self._posItemList or {}

	for _, item in pairs(self._posItemList) do
		if item then
			if item.iconImaGo then
				uGuiUtil.clearImage(item.iconImaGo)
			end

			if item.itemGo then
				GameUtil.SetActive(item.itemGo, false)
			end
		end
	end

	if self._params.honorList == nil or #self._params.honorList == 0 then
		return
	end

	local info

	self._onceGridSize = goutil.getWidth(self._itemGridTran) / FamilyHonorModel.instance.wallWide

	for _, info in pairs(self._params.honorList) do
		if info and info.defineId and checknumber(info.wallId) > 0 then
			self:_showWallHonorItem(info)
		end
	end
end

function FamilyHonorExhibitView:_showWallHonorItem(info)
	if info == nil or checknumber(info.defineId) <= 0 then
		return
	end

	local count = #self._posItemList + 1

	if self._posItemList[count] == nil or self._posItemList[count].itemGo == nil then
		self._posItemList[count] = {}

		local go = UnityEngine.GameObject.Instantiate(self._honorItem, self._itemGridTran)

		GameUtil.SetActive(go, true)

		self._posItemList[count] = {}
		self._posItemList[count].itemGo = go
		self._posItemList[count].kuangIma = goutil.findChild(go, "kuangIma"):GetComponent("UIImageSpriteChange")
		self._posItemList[count].iconImaGo = goutil.findChild(go, "iconImaGo")
	else
		GameUtil.SetActive(self._posItemList[count].itemGo, true)
		GameUtil.asBtn(self._posItemList[count].itemGo):RemoveClickListener()
	end

	local cfg = FamilyHonorConfig.instance:getFamilyMedalCfg(info.defineId)
	local item = self._posItemList[count]

	GameUtil.setWidth(item.itemGo, self._onceGridSize * cfg.width)
	GameUtil.setHeight(item.itemGo, self._onceGridSize * cfg.height)

	local iconPath = "ui/bigbg/familycallorder/" .. cfg.icon .. ".png"

	uGuiUtil.setSpriteToImage(item.iconImaGo, uGuiUtil.SpriteType.BigBg, iconPath)
	GameUtil.setAnchoredPos(item.itemGo, info.positionX * self._onceGridSize, -info.positionY * self._onceGridSize)
	item.kuangIma:SetState(cfg.level - 1)
	GameUtil.asBtn(self._posItemList[count].itemGo):AddClickListener(function()
		local params = {
			isSeeInfo = true,
			defineId = info.defineId,
			gainedTime = info.gainedTime,
			familyName = self._params.familyName,
			progress = info.progress
		}

		UIStateManager.instance:push(ViewName.FamilyHonorTips, params)
	end, self)
end

return FamilyHonorExhibitView
