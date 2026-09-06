-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/raiders/RaidersBigView.lua

module("logic.extensions.legend.view.raiders.RaidersBigView", package.seeall)

local RaidersBigView = class("RaidersBigView", FlyTweenBase)

function RaidersBigView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._txtRaidersRule1 = self:getTxt("part3/raiders1/txtRule1")
	self._txtRaidersRule2 = self:getTxt("part3/raiders2/txtRule2")
	self._imgRule1 = self:getGo("part3/raiders1/imgRule")
	self._imgRule2 = self:getGo("part3/raiders2/imgRule")
	self._petRule1 = self:getGo("part3/raiders1/petRule")
	self._petRule2 = self:getGo("part3/raiders2/petRule")
	self._raidersPetShow1 = RaidersPetShow.New()
	self._raidersPetShow2 = RaidersPetShow.New()

	self._raidersPetShow1:buildUI(self:getGo("part3/raiders1/petRule/petList"))
	self._raidersPetShow2:buildUI(self:getGo("part3/raiders2/petRule/petList"))
end

function RaidersBigView:destroyUI()
	self._raidersPetShow1:destroyUI()
	self._raidersPetShow2:destroyUI()

	self._raidersPetShow1 = nil
	self._raidersPetShow2 = nil
end

function RaidersBigView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function RaidersBigView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function RaidersBigView:_onClickClose()
	local function closeCallback()
		self:close()
	end

	self:_doCloseCallback(closeCallback)
end

function RaidersBigView:onEnter()
	local param = self:getOpenParam()

	self:_setUIFlyTweenParam(param[2])

	self._challengeId = param[1].challengeId
	self._stageId = param[1].stageId
	self._txtCfg = param[1].txtCfg

	if string.nilorempty(self._txtCfg.raidersText1) then
		self:_setRaiders1(self._txtCfg.raidersText2, self._txtCfg.raidersCondition2)
		self:_setRaiders2("", "")
	else
		self:_setRaiders1(self._txtCfg.raidersText1, self._txtCfg.raidersCondition1)
		self:_setRaiders2(self._txtCfg.raidersText2, self._txtCfg.raidersCondition2)
	end
end

function RaidersBigView:onExit()
	RaidersBigView.super.onExit(self)
	self._raidersPetShow1:onExit()
	self._raidersPetShow2:onExit()
	self:_removeImage()
end

function RaidersBigView:_getTypeAndParam(raidersCondition)
	local strList = string.split(raidersCondition, ",")
	local conditionType = checknumber(strList[1])
	local param

	if conditionType == 2 then
		local raceIdList = string.split(strList[2], "#")

		for i = 1, #raceIdList do
			raceIdList[i] = checknumber(raceIdList[i])
		end

		param = raceIdList
	else
		param = strList[2]
	end

	return conditionType, param
end

function RaidersBigView:_setRaiders1(raidersText, raidersCondition)
	self._txtRaidersRule1.text = raidersText

	if string.nilorempty(raidersCondition) then
		goutil.setActive(self._imgRule1, false)
		goutil.setActive(self._petRule1, false)

		return
	end

	local conditionType, param = self:_getTypeAndParam(raidersCondition)

	if conditionType == 2 then
		goutil.setActive(self._imgRule1, false)
		goutil.setActive(self._petRule1, true)
		self._raidersPetShow1:onEnter(param)
	else
		goutil.setActive(self._imgRule1, true)
		goutil.setActive(self._petRule1, false)
		self:_loadImage(self._imgRule1, param)
	end
end

function RaidersBigView:_setRaiders2(raidersText, raidersCondition)
	if string.nilorempty(raidersText) or string.nilorempty(raidersCondition) then
		return
	end

	local conditionType, param = self:_getTypeAndParam(raidersCondition)

	if conditionType == 2 then
		goutil.setActive(self._imgRule2, false)
		goutil.setActive(self._petRule2, true)
		self._raidersPetShow2:onEnter(param)
	else
		goutil.setActive(self._imgRule2, true)
		goutil.setActive(self._petRule2, false)
		self:_loadImage(self._imgRule2, param)
	end

	self._txtRaidersRule2.text = raidersText
end

function RaidersBigView:_loadImage(go, name)
	uGuiUtil.setSpriteToImage(go, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/legend/raiders/%s.png", name))
end

function RaidersBigView:_removeImage()
	local img1 = Framework.ImageBigBG.Get(self._imgRule1)

	if img1 then
		img1:ClearImage()
	end

	local img2 = Framework.ImageBigBG.Get(self._imgRule2)

	if img2 then
		img2:ClearImage()
	end
end

return RaidersBigView
