-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/TimelinitedcheatsView.lua

module("logic.extensions.timelimitedchallenge.view.TimelinitedcheatsView", package.seeall)

local TimelinitedcheatsView = class("TimelinitedcheatsView", FlyTweenBase)

function TimelinitedcheatsView:ctor()
	TimelinitedcheatsView.super.ctor(self)
end

function TimelinitedcheatsView:buildUI()
	TimelinitedcheatsView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.upList = {}
	self.downList = {}

	for i = 1, 3 do
		local go1 = self:getGo("left/petlist1/pet" .. i)
		local go2 = self:getGo("left/petlist2/pet" .. i)

		table.insert(self.upList, go1)
		table.insert(self.downList, go2)
	end

	self._txtTopTips = self:getTxt("right/stack1/item1")
	self._txtBomTips = self:getTxt("right/stack1/item2")
	self._image = self:getGo("right/stack1/item2/Image")
	self._petIcon = self:getGo("right/stack1/item2/peticon")
	self._leftAttrIcon = goutil.findChildComponent(self.mainGO, "right/stack1/item1/attrL/icon", typeof(UIImageSpriteChange))
	self._rightAttrIcon = goutil.findChildComponent(self.mainGO, "right/stack1/item1/attrR/icon", typeof(UIImageSpriteChange))
end

function TimelinitedcheatsView:bindEvents()
	TimelinitedcheatsView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self._onClickClose, self)
end

function TimelinitedcheatsView:unbindEvents()
	TimelinitedcheatsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function TimelinitedcheatsView:destroyUI()
	TimelinitedcheatsView.super.destroyUI(self)
end

local RaceTypeToEnum = {
	草 = GameEnum.RaceType.Cao,
	神草 = GameEnum.RaceType.Cao,
	水 = GameEnum.RaceType.Shui,
	神水 = GameEnum.RaceType.Shui,
	火 = GameEnum.RaceType.Huo,
	神火 = GameEnum.RaceType.Huo,
	光 = GameEnum.RaceType.Guang,
	神光 = GameEnum.RaceType.Guang,
	暗 = GameEnum.RaceType.An,
	神暗 = GameEnum.RaceType.An
}

function TimelinitedcheatsView:onEnter()
	TimelinitedcheatsView.super.onEnter(self)

	local challengeId = 1
	local params = self:getOpenParam()

	if params[1] ~= nil then
		challengeId = params[1]

		local strategyCfg = TimeLimitedConfig.instance:getStrategyCfg(params[1])

		self._txtTopTips.text = strategyCfg.topTips
		self._txtBomTips.text = strategyCfg.bomTips

		goutil.setActive(self._image, challengeId == 3)
		goutil.setActive(self._petIcon, challengeId ~= 3)
		MaterialMgr.setIcon(goutil.findChild(self._petIcon, "icon"), MatType.Pet, (checknumber(strategyCfg.raceId) > 0 or nil) and strategyCfg.raceId)

		local arrows = self:getGo("right/stack1/item1/arrows")
		local arrow1 = goutil.findChild(arrows, "arrow1")
		local arrow2 = goutil.findChild(arrows, "arrow2")
		local txtArrow1 = goutil.findChild(arrow1, "txt2")
		local leftAttr, rightAttr

		if string.find(strategyCfg.relations, "<=>") then
			arrow2:SetActive(true)
			txtArrow1:SetActive(false)

			leftAttr, rightAttr = unpack(string.split(strategyCfg.relations, "<=>"))
		elseif string.find(strategyCfg.relations, "=>") then
			arrow2:SetActive(false)
			txtArrow1:SetActive(true)

			leftAttr, rightAttr = unpack(string.split(strategyCfg.relations, "=>"))
		end

		print("leftAttr, rightAttr = " .. leftAttr .. rightAttr)

		local leftEnum = RaceTypeToEnum[leftAttr]
		local rightEnum = RaceTypeToEnum[rightAttr]

		self._leftAttrIcon:SetState(leftEnum - 1)
		self._rightAttrIcon:SetState(rightEnum - 1)
	end

	self:_setUIFlyTweenParam(params[2])

	local cfg = TimeLimitedConfig.instance:getCfgById(challengeId)
	local upListStr = cfg.upList
	local downListStr = cfg.downList

	self:setPets(self.upList, string.splitToNumber(upListStr, "#"))
	self:setPets(self.downList, string.splitToNumber(downListStr, "#"))
end

function TimelinitedcheatsView:onEnterFinished()
	TimelinitedcheatsView.super.onEnterFinished(self)
end

function TimelinitedcheatsView:onExit()
	TimelinitedcheatsView.super.onExit(self)
	self:setPets(self.upList)
	self:setPets(self.downList)
end

function TimelinitedcheatsView:onExitFinished()
	TimelinitedcheatsView.super.onExitFinished(self)
end

function TimelinitedcheatsView:setPets(goList, petRaceIds)
	for i, go in ipairs(goList) do
		local con = goutil.findChild(go, "con")
		local txt = goutil.findChildTextComponent(go, "txtName")

		MaterialMgr.resetAll(con)

		if petRaceIds and petRaceIds[i] ~= nil then
			MaterialMgr.setCell(MatType.Pet, petRaceIds[i], con)

			txt.text = MaterialMgr.getMaterialsName(MatType.Pet, petRaceIds[i])
		end
	end
end

function TimelinitedcheatsView:_onClickClose()
	local function closeCallback()
		self:close()
	end

	self:_doCloseCallback(closeCallback)
end

return TimelinitedcheatsView
