-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyHonorTipsView.lua

module("logic.extensions.newfamily.view.FamilyHonorTipsView", package.seeall)

local FamilyHonorTipsView = class("FamilyHonorTipsView", ViewComponent)

function FamilyHonorTipsView:ctor()
	FamilyHonorTipsView.super.ctor(self)
end

function FamilyHonorTipsView:bindEvents()
	FamilyHonorTipsView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function FamilyHonorTipsView:unbindEvents()
	FamilyHonorTipsView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function FamilyHonorTipsView:onExit()
	FamilyHonorTipsView.super.onExit(self)
end

function FamilyHonorTipsView:destroyUI()
	FamilyHonorTipsView.super.destroyUI(self)
	uGuiUtil.clearImage(self._iconImaGo)
end

function FamilyHonorTipsView:buildUI()
	FamilyHonorTipsView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._descTxt = self:getGo("viewDescSR/Viewport/descTxt"):GetComponent("Text")
	self._iconImaGo = self:getGo("iconImaGo")
	self._familyTxt = self:getGo("familyTxt"):GetComponent("Text")
	self._honorTxt = self:getGo("honorTxt"):GetComponent("Text")
	self._getTimeTxt = self:getGo("getTimeTxt"):GetComponent("Text")
	self._getPathTxt = self:getGo("getPathTxt"):GetComponent("Text")
	self._posShowTran = self:getGo("posShowTran"):GetComponent(goutil.Type_RectTransform)
	self._familyTxt.text = ""
end

function FamilyHonorTipsView:onEnter()
	FamilyHonorTipsView.super.onEnter(self)

	self._params = self:getFirstParam()

	if self._params == nil or checknumber(self._params.defineId) <= 0 then
		printError("sr---家族荣誉墙，未传入参数！     FamilyHonorTipsView:onEnter()")
		self:close()

		return
	end

	local cfg = FamilyHonorConfig.instance:getFamilyMedalCfg(self._params.defineId)

	if cfg == nil then
		printError("sr---家族荣誉墙  FamilyHonorTipsView:onEnter()   未读取到参数 = " .. self._params.defineId)

		return
	end

	self._honorTxt.text = cfg.name

	local getCfg = FamilyHonorConfig.instance:getFamilyMedalSourceCfg(cfg.sourceId)

	if checknumber(self._params.gainedTime) > 0 then
		local time = GameUtil.time2date(math.ceil(self._params.gainedTime / 1000))

		self._getTimeTxt.text = langPara("text_wltower_desc_1", time.year, time.month, time.day)
		self._getPathTxt.text = getCfg.desc
	else
		self._getTimeTxt.text = "获得时间：未获得"
		self._getPathTxt.text = string.format("%s(%s/%s)", getCfg.desc, self._params.progress, getCfg.progress)
	end

	self._descTxt.text = cfg.desc

	local iconPath = "ui/bigbg/familycallorder/" .. cfg.icon .. ".png"

	uGuiUtil.setSpriteToImage(self._iconImaGo, uGuiUtil.SpriteType.BigBg, iconPath)
	goutil.setWidth(self._posShowTran, cfg.width * 6)
	goutil.setHeight(self._posShowTran, cfg.height * 6)
end

return FamilyHonorTipsView
